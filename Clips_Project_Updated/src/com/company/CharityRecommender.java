package com.company;

import javax.swing.*;
import java.awt.*;
import java.util.*;

import net.sf.clipsrules.jni.*;

import java.util.List;



/* Implement FindFact which returns just a FactAddressValue or null */
/* TBD Add size method to PrimitiveValue */

/*

Notes:

This example creates just a single environment. If you create multiple environments,
call the destroy method when you no longer need the environment. This will free the
C data structures associated with the environment.

   clips = new Environment();
      .
      .
      .
   clips.destroy();

Calling the clear, reset, load, loadFacts, run, eval, build, assertString,
and makeInstance methods can trigger CLIPS garbage collection. If you need
to retain access to a PrimitiveValue returned by a prior eval, assertString,
or makeInstance call, retain it and then release it after the call is made.

   PrimitiveValue pv1 = clips.eval("(myFunction foo)");
   pv1.retain();
   PrimitiveValue pv2 = clips.eval("(myFunction bar)");
      .
      .
      .
   pv1.release();

*/

public class CharityRecommender {

    private enum State {
        GREETING,
        INTERVIEW,
        CONCLUSION
    }

    private Boolean isMultiChoiceQn = false;
    private JFrame mainFrame;
    private GreetingForm greetingForm = new GreetingForm(this);
    private InterviewForm interviewForm = new InterviewForm(this);
    private ConclusionForm conclusionForm = new ConclusionForm(this);

    private ButtonGroup radioButtonsGroup;
    private List<JCheckBox> checkboxGroup;
    private ResourceBundle charityResources;

    private Environment clips;
    private State state;
    private boolean isExecuting = false;
    private Thread executionThread;

    private String lastAnswer;
    private String relationAsserted;
    private ArrayList<String> variableAsserts;
    private ArrayList<String> priorAnswers;
    private List<FactInstance> latest_facts;

    private ClipsAssertsHandler clipsAssertsHandler;

    // For result retrieval
    private Vector<String> goal_names = new Vector<>();
    private Vector<Float> goal_values = new Vector<>();

    // For final list of recommended charities
    private List<RecommendedCharityModel> recommendedCharities;

    private void initializeInterface() {
        /*================================*/
        /* Create a new JFrame container. */
        /*================================*/
        mainFrame = new JFrame(charityResources.getString("CharityRecommender"));

        /*=================================*/
        /* Give the frame an initial size. */
        /*=================================*/
        mainFrame.setSize(600, 500);

        /*=============================================================*/
        /* Terminate the program when the user closes the application. */
        /*=============================================================*/
        mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        /*==============================*/
        /* Prevent frame to be resized. */
        /*==============================*/
        mainFrame.setResizable(false);

        /*===========================================*/
        /* Add multiple type of form into the frame. */
        /*===========================================*/
        mainFrame.getContentPane().setLayout(new CardLayout());
        mainFrame.getContentPane().add(greetingForm.getMainPanel(), "greetingPanel");
        mainFrame.getContentPane().add(interviewForm.getMainPanel(), "interviewPanel");
        mainFrame.getContentPane().add(conclusionForm.getMainPanel(), "conclusionPanel");

        /*=================================*/
        /* Set Default Form to be visible. */
        /*=================================*/
        mainFrame.setLocationRelativeTo(null);
        mainFrame.setVisible(true);
    }

    private boolean initializeStates() {
        try {
            charityResources = ResourceBundle.getBundle("CharityResources", Locale.getDefault());
            clipsAssertsHandler = new ClipsAssertsHandler();
            clipsAssertsHandler.initializeHashes();

        } catch (MissingResourceException mre) {
            mre.printStackTrace();
            return false;
        }

        variableAsserts = new ArrayList<String>();
        priorAnswers = new ArrayList<String>();

        return true;
    }


    CharityRecommender() {
        /*===================================*/
        /* Initialize the state information. */
        /*===================================*/
        Boolean initStatus = initializeStates();

        if (initStatus) {
            clips = new Environment();

            try {
                String clipsCode = new Helpers().getFileData("/clips/CharitySelector.clp");
                clips.loadFromString(clipsCode);

                processRules();

            } catch (Exception e) {
                e.printStackTrace();
                System.exit(1);
            }

            /*===================================*/
            /* Initialize user interface. */
            /*===================================*/
            initializeInterface();
        }
    }

    /*******************/
    /* handleResponse: */

    /*******************/
    private void handleGreetingRespose(FactAddressValue factAddressValue) throws Exception {
        System.out.println("Show Greeting Page");
        System.out.println("#############");
        CardLayout cardLayout = (CardLayout) (mainFrame.getContentPane().getLayout());
        cardLayout.show(mainFrame.getContentPane(), "greetingPanel");

        /*====================================*/
        /* Set the label to the display text. */
        /*====================================*/
        String theText = ((StringValue) factAddressValue.getSlotValue("question")).getValue();
        greetingForm.setTextLabel(theText);
    }

    private void handleInterviewResponse(FactAddressValue factAddressValue) throws Exception {
        System.out.println("Show Interview Page");
        System.out.println("#############");
        CardLayout cardLayout = (CardLayout) (mainFrame.getContentPane().getLayout());
        cardLayout.show(mainFrame.getContentPane(), "interviewPanel");

        /*=====================*/
        /* Set up the choices. */
        /*=====================*/
        interviewForm.getChoicePanel().removeAll();

        String isMultiChoiceStr = ((LexemeValue) factAddressValue.getSlotValue("is-multi-choice")).getValue();
        isMultiChoiceQn = isMultiChoiceStr.equals("yes");

        if (isMultiChoiceQn)
            setupCheckBoxButtons(factAddressValue);
        else
            setupRadioButtons(factAddressValue);

        interviewForm.getChoicePanel().repaint();

        relationAsserted = ((LexemeValue) factAddressValue.getSlotValue("relation-asserted")).getValue();

        /*====================================*/
        /* Set the label to the display text. */
        /*====================================*/
        String theText = ((StringValue) factAddressValue.getSlotValue("question")).getValue();
        interviewForm.setTextLabel(theText);

        executionThread = null;
        isExecuting = false;
    }

    private void setupCheckBoxButtons(FactAddressValue factAddressValue) {

        checkboxGroup = new ArrayList<>();

        MultifieldValue damf = (MultifieldValue) factAddressValue.getSlotValue("display-answers");
        MultifieldValue vamf = (MultifieldValue) factAddressValue.getSlotValue("valid-answers");

        // Do not use ButtonGroup as we need to select more than one, simply use JCheckBox
        JCheckBox firstCheckBox = null;

        for (int i = 0; i < damf.size(); i++) {
            LexemeValue da = (LexemeValue) damf.get(i);
            LexemeValue va = (LexemeValue) vamf.get(i);

            String buttonName, buttonText, buttonAnswer;

            buttonName = da.getValue();
            buttonText = buttonName.substring(0, 1).toUpperCase() + buttonName.substring(1);
            buttonAnswer = va.getValue();
            JCheckBox rButton = new JCheckBox(buttonText, false);
            rButton.setActionCommand(buttonAnswer);
            checkboxGroup.add(rButton);

            interviewForm.getChoicePanel().add(rButton);
            if (firstCheckBox == null) {
                firstCheckBox = rButton;
            }
        }
    }

    private void setupRadioButtons(FactAddressValue factAddressValue) {
        radioButtonsGroup = new ButtonGroup();

        MultifieldValue damf = (MultifieldValue) factAddressValue.getSlotValue("display-answers");
        MultifieldValue vamf = (MultifieldValue) factAddressValue.getSlotValue("valid-answers");

        //String selected = fv.getSlotValue("response").toString();
        JRadioButton firstButton = null;

        for (int i = 0; i < damf.size(); i++) {
            LexemeValue da = (LexemeValue) damf.get(i);
            LexemeValue va = (LexemeValue) vamf.get(i);
            JRadioButton rButton;
            String buttonName, buttonText, buttonAnswer;

            buttonName = da.getValue();
            buttonText = buttonName.substring(0, 1).toUpperCase() + buttonName.substring(1);
            buttonAnswer = va.getValue();

            if (((lastAnswer != null) && buttonAnswer.equals(lastAnswer))) {
                rButton = new JRadioButton(buttonText, true);
            } else {
                rButton = new JRadioButton(buttonText, false);
            }

            rButton.setActionCommand(buttonAnswer);
            System.out.println(interviewForm.getChoicePanel());
            System.out.println(rButton);
            radioButtonsGroup.add(rButton);
            interviewForm.getChoicePanel().add(rButton);

            if (firstButton == null) {
                firstButton = rButton;
            }
        }

        if ((radioButtonsGroup.getSelection() == null) && (firstButton != null)) {
            radioButtonsGroup.setSelected(firstButton.getModel(), true);
        }
    }

    private void handleConclusionResponse(FactAddressValue factAddressValue) throws Exception {
        System.out.println("Show Conclusion Page");
        System.out.println("#############");
        CardLayout cardLayout = (CardLayout) (mainFrame.getContentPane().getLayout());
        cardLayout.show(mainFrame.getContentPane(), "conclusionPanel");

        /*====================================*/
        /* Display charities list. */
        /*====================================*/
        String theText = "";
        recommendedCharities = new ArrayList<RecommendedCharityModel>();
        getGoals();
        for (int i = 0; i < goal_names.size(); i++) {
            RecommendedCharityModel recommendedCharity = new RecommendedCharityModel(goal_names.elementAt(i).toString(), goal_values.elementAt(i).toString());
            recommendedCharities.add(recommendedCharity);
        }

        // Sort the recommended charities by their recommendation level in descending order
        Collections.sort(recommendedCharities, new Comparator<RecommendedCharityModel>() {
            public int compare(RecommendedCharityModel c1, RecommendedCharityModel c2) {
                return -Double.compare(c1.RecommendedValue, c2.RecommendedValue);
            }
        });

        // get the value of the text to show
        for (RecommendedCharityModel charityModel : recommendedCharities) {
            theText += charityModel.GetCharityNameAndRecommendedValueAppended();
        }
        conclusionForm.setTextLabel(theText);
    }

    private void handleResponse() throws Exception {
        latest_facts = clips.getFactList(); // don't call getFactList() too often, just once here
        printFacts();
        FactAddressValue factValue = clips.findFact("UI-state");

        String state = factValue.getSlotValue("state").toString();
        switch (state) {
            case "interview":
                this.state = State.INTERVIEW;
                handleInterviewResponse(factValue);
                break;
            case "conclusion":
                this.state = State.CONCLUSION;
                handleConclusionResponse(factValue);
                break;
            case "greeting":
                this.state = State.GREETING;
                handleGreetingRespose(factValue);
                break;
        }

    }

    /**************/
    /* runCharity */

    /**************/
    public void runCharity() {
        Runnable runThread =
                new Runnable() {
                    public void run() {
                        try {
                            clips.run();
                        } catch (CLIPSException e) {
                            e.printStackTrace();
                        }

                        SwingUtilities.invokeLater(
                                new Runnable() {
                                    public void run() {
                                        try {
                                            handleResponse();
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    }
                                });
                    }
                };

        isExecuting = true;

        executionThread = new Thread(runThread);

        executionThread.start();
    }

    /****************/
    /* processRules */

    /****************/
    private void processRules() throws CLIPSException {
        clips.reset();

        for (String factString : variableAsserts) {
            clips.eval(factString);
        }

        runCharity(); // need this to run before the clips can continue engine

    }

    // Print to console for debugging
    private void printFacts() {
        System.out.println("### Facts ###");
        for (FactInstance factInstance : latest_facts) {
            FactInstance fi = factInstance;
            System.out.print(fi.getRelationName() + " : ");
            for (SlotValue sv : fi.getSlotValues()) {
                System.out.print("  " + sv.getSlotName());
                System.out.print("  " + sv.getSlotValue());
            }
            System.out.println("");
        }
        System.out.println("#############");
    }

    private void getGoals() {

        for (FactInstance factInstance : latest_facts) {
            FactInstance fi = factInstance;
            if (fi.getRelationName().equals("current_goal")) {
                for (SlotValue sv : fi.getSlotValues()) {
                    if (sv.getSlotName().equals("goal"))
                        goal_names.add(sv.getSlotValue());
                    else if (sv.getSlotName().equals("cf"))
                        goal_values.add(Float.parseFloat(sv.getSlotValue()));
                }
            }
        }
    }

    public void startInterview() throws CLIPSException {
        variableAsserts.add("(assert (current_question corporate_or_individual))");
        processRules();
    }

    public void continueInterview() throws CLIPSException {

        if (isMultiChoiceQn && nothingSelected()) return; // single qn don't need this, at least one is pre-selected

        clips.eval("(assert (continue_interview))");
        String theAnswer;
        ArrayList<String> multiChoiceAsserts = new ArrayList<>();
        priorAnswers = (ArrayList<String>) variableAsserts.clone();

        if (isMultiChoiceQn) {
            for (JCheckBox btn : checkboxGroup) {
                if (btn.isSelected()) {
                    theAnswer = btn.getActionCommand();
                    Vector<String> answers = clipsAssertsHandler.getSingleAnswers(relationAsserted, theAnswer);
                    if (answers != null) multiChoiceAsserts.addAll(answers);
                }
            }

            removeExtraCurrentQnAsserts(multiChoiceAsserts);
            variableAsserts.addAll(multiChoiceAsserts);

        } else {
            theAnswer = radioButtonsGroup.getSelection().getActionCommand();
            Vector<String> answers = clipsAssertsHandler.getSingleAnswers(relationAsserted, theAnswer);
            if (answers != null)
            {
                variableAsserts.addAll(answers);
            }
        }

        processRules();
    }

    private boolean nothingSelected() {
        Boolean isSomethingSelected = false;
        for (JCheckBox cb : checkboxGroup) {
            if (cb.isSelected()) {
                isSomethingSelected = true;
                break;
            }
        }

        if (!isSomethingSelected) {
            JOptionPane.showMessageDialog(checkboxGroup.get(0), "Please select at least one option.", "Reminder", JOptionPane.ERROR_MESSAGE);
            return true;
        }
        return false;
    }

    // may not be req, but clean up extra ((assert(current_question anyway
    private void removeExtraCurrentQnAsserts(ArrayList<String> tempAsserts) {

        String branchStr = "";
        int count = 0; // number of times "current_question" occurs in the list

        for (String string : tempAsserts) {
            if (string.contains("current_question")) {
                branchStr = string;
                count++;
            }
        }

        // Remove all (assert (current_question except the last one
        // Assumption here is that each answer ticked gives one (assert (current_question
        if (!branchStr.equals(""))
            for (int i = 0; i < count - 1; i++)
                tempAsserts.remove(branchStr);
    }

    public void restartInterview() throws CLIPSException {
        variableAsserts.clear();
        priorAnswers.clear();
        goal_names.clear();
        goal_values.clear();
        recommendedCharities.clear();
        processRules();
    }

    public void prevButtonAction() throws CLIPSException {
//        lastAnswer = priorAnswers.get(priorAnswers.size() - 1);
//
//        variableAsserts.remove(variableAsserts.size() - 1);
//        priorAnswers.remove(priorAnswers.size() - 1);
        variableAsserts = priorAnswers;
        processRules();
    }


    public static void createNewDatabase(String fileName) {

        /*
        String url = "jdbc:sqlite:/Users/pierlim/IdeaProjects/Test/" + fileName;

        try (Connection conn = DriverManager.getConnection(url)) {
            if (conn != null) {
                DatabaseMetaData meta = conn.getMetaData();
                System.out.println("The driver name is " + meta.getDriverName());
                System.out.println("A new database has been created.");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        */
    }

    public static void main(String args[]) {
        createNewDatabase("test.db"); // For the case that we need to use external database to lookup more details

        // Create the frame on the event dispatching thread.
        SwingUtilities.invokeLater(
                new Runnable() {
                    public void run() {
                        new CharityRecommender();
                    }
                });


    }
}
