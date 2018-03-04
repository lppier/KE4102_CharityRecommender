package com.company;

import javax.swing.*;
import java.awt.*;
import java.io.IOException;
import java.util.*;
import java.util.List;

import net.sf.clipsrules.jni.*;


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
    private DetailForm detailForm = new DetailForm(this);

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
    private Stack<Integer> numberOfAssertStatements;
    private List<FactInstance> latest_facts;

    private ClipsAssertsHandler clipsAssertsHandler;
    private FactAddressValue currentUIFactValue; // for tracking UI state

    // For result retrieval
    private Vector<String> goalNames = new Vector<>();
    private Vector<Double> goalValues = new Vector<>();
    private Map<String, Double> goals = new HashMap<>();
    private HashMap<String, Map<String, String>> csvRecords;

    private void initializeInterface() {
        /*================================*/
        /* Create a new JFrame container. */
        /*================================*/
        mainFrame = new JFrame(charityResources.getString("CharityRecommender"));

        Image icon = new Helpers().loadImage("/img/charity_icon.png", 80, 80);
        mainFrame.setIconImage(icon);
        /*===============================*/
        /* Load charities data from CSV. */
        /*===============================*/
        try {
            csvRecords = new Helpers().readCSV("/data/charity_details.csv", "clips_name");
        } catch (IOException e) {
            e.printStackTrace();
        }

        /*=================================*/
        /* Give the frame an initial size. */
        /*=================================*/
        mainFrame.setSize(800, 600);

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
        mainFrame.getContentPane().add(detailForm.getMainPanel(), "detailPanel");

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
        numberOfAssertStatements = new Stack<>();

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
        System.out.println("------------------");
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
        System.out.println("-------------------");
        CardLayout cardLayout = (CardLayout) (mainFrame.getContentPane().getLayout());
        cardLayout.show(mainFrame.getContentPane(), "interviewPanel");

        /*=====================*/
        /* Set up the choices. */
        /*=====================*/
        interviewForm.getChoicePanel().removeAll();

        String isMultiChoiceStr = ((LexemeValue) factAddressValue.getSlotValue("is-multi-choice")).getValue();
        isMultiChoiceQn = isMultiChoiceStr.equals("yes");

        String hasGraphicStr = (currentUIFactValue.getSlotValue("hasGraphic")).toString();
        Helpers helpers = new Helpers();

        if (hasGraphicStr.equals("A")) {
            interviewForm.getImageLabel().setIcon(new ImageIcon(helpers.loadImage("/img/charity-A.jpg", 765, 485)));
            interviewForm.getImageLabel().setVisible(true);
        } else if (hasGraphicStr.equals("B")) {
            interviewForm.getImageLabel().setIcon(new ImageIcon(helpers.loadImage("/img/charity-B.jpg", 765, 485)));
            interviewForm.getImageLabel().setVisible(true);
        } else if (hasGraphicStr.equals("C")) {
            interviewForm.getImageLabel().setIcon(new ImageIcon(helpers.loadImage("/img/charity-C.jpg", 765, 485)));
            interviewForm.getImageLabel().setVisible(true);
        }
        else if (hasGraphicStr.equals("no")) {
            interviewForm.getImageLabel().setVisible(false);
        }

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
        this.isExecuting = false;
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

    private ArrayList<Map<String, String>> getNeighbours(Map<String, String> item) {
        ArrayList<Map<String, String>> neighbours = new ArrayList<>();
        for (int i = 1; i <= 15; i++) {
            String uen = item.get("Neighbour " + i + " UEN");
            if (!uen.equals("")) {
                Map<String, String> neighbour = new HashMap<>();
                neighbour.put("UEN", uen);
                neighbour.put("Name of Organisation", item.get("Neighbour " + i + " Name of Organisation"));
                neighbour.put("Sector", item.get("Neighbour " + i + " Sector"));
                neighbour.put("Classification", item.get("Neighbour " + i + " Classification"));
                neighbour.put("Website", item.get("Neighbour " + i + " Website"));
                neighbours.add(neighbour);
            }
        }
        return neighbours;
    }

    private void handleConclusionResponse() throws Exception {
        System.out.println("Show Conclusion Page");
        System.out.println("--------------------");

        /*=========================*/
        /* Display charities list. */
        /*=========================*/
        loadGoals();

        conclusionForm.clearListPanel();
        goals = new Helpers().getFirstN(goals, 10);
        goals.forEach((charityNameId, charityCfValue) -> {
            //System.out.println(String.format("CharityRecommender->handleConclusionResponse: addItem %s", charityNameId));
            conclusionForm.addItem(csvRecords.get(charityNameId), charityCfValue);
        });

        conclusionForm.setState(ConclusionForm.State.FINAL);

        CardLayout cardLayout = (CardLayout) (mainFrame.getContentPane().getLayout());
        cardLayout.show(mainFrame.getContentPane(), "conclusionPanel");
    }

    private void handleDetailResponse(Map<String, String> item) {
        System.out.println("Show Detail Page");
        System.out.println("--------------------");

        ArrayList<Map<String, String>> neighbours = getNeighbours(item);
        detailForm.loadDetail(item);
        detailForm.loadSimilarCharities(neighbours);

        CardLayout cardLayout = (CardLayout) (mainFrame.getContentPane().getLayout());
        cardLayout.show(mainFrame.getContentPane(), "detailPanel");
    }

    private void handleResponse() throws Exception {
        latest_facts = clips.getFactList(); // don't call getFactList() too often, just once here
        // printFacts();
        currentUIFactValue = clips.findFact("UI-state");
        String currentState = currentUIFactValue.getSlotValue("state").toString();
        switch (currentState) {
            case "greeting":
                this.state = State.GREETING;
                handleGreetingRespose(currentUIFactValue);
                break;
            case "interview":
                this.state = State.INTERVIEW;
                handleInterviewResponse(currentUIFactValue);
                break;
            case "conclusion":
                this.state = State.CONCLUSION;
                handleConclusionResponse();
                break;
        }
    }

    public void handleBackFromJumpConclusion() {
        try {
            handleInterviewResponse(currentUIFactValue);
        } catch (Exception e) {
            e.printStackTrace();
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

    private void loadGoals() {
        System.out.println("### Load Goals ###");
        goals.clear();
        for (FactInstance factInstance : latest_facts) {
            FactInstance fi = factInstance;
            if (fi.getRelationName().equals("current_goal")) {
                for (SlotValue sv : fi.getSlotValues()) {
                    if (sv.getSlotName().equals("goal"))
                        goalNames.add(sv.getSlotValue());
                    else if (sv.getSlotName().equals("cf"))
                        goalValues.add(Double.parseDouble(sv.getSlotValue()));
                }
            }
        }
        System.out.println("------------------");
        System.out.println("##### Sort it ####");
        for (int i = 0; i < goalNames.size(); i++) {
            goals.put(goalNames.elementAt(i), goalValues.elementAt(i));
        }

        Helpers helpers = new Helpers();
        goals = helpers.sortByKey(goals);
        goals = helpers.sortByValue(goals, false);
        System.out.println("##################");
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
        numberOfAssertStatements.push(priorAnswers.size()); // keep track for "prev" functionality

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

            // Check current UIState if hasGraphic is yes
            String hasGraphicStr = (currentUIFactValue.getSlotValue("hasGraphic")).toString();
            if (hasGraphicStr.equals("A") || hasGraphicStr.equals("B") || hasGraphicStr.equals("C") ) {
                theAnswer = "section";
            } else {
                theAnswer = radioButtonsGroup.getSelection().getActionCommand();
            }

            Vector<String> answers = clipsAssertsHandler.getSingleAnswers(relationAsserted, theAnswer);
            if (answers != null) {
                variableAsserts.addAll(answers);
            }
        }

        processRules();
    }

    public void jumpToConclusion() throws CLIPSException {
        System.out.println("Jumping to conclusions!");
        System.out.println("-----------------------");

        CardLayout cardLayout = (CardLayout) (mainFrame.getContentPane().getLayout());
        cardLayout.show(mainFrame.getContentPane(), "conclusionPanel");

        /*=========================*/
        /* Display charities list. */
        /*=========================*/
        loadGoals();
        conclusionForm.setState(ConclusionForm.State.INTERMEDIATE);

        conclusionForm.clearListPanel();
        goals = new Helpers().getFirstN(goals, 10);

        goals.forEach((charityNameId, charityCfValue) -> {
            conclusionForm.addItem(csvRecords.get(charityNameId), charityCfValue);
        });

        System.out.println("#######################");
    }

    public void openDetail(Map<String, String> data) {
        handleDetailResponse(data);
    }

    public void showConclusion() throws Exception {

        if (conclusionForm.getState() == ConclusionForm.State.INTERMEDIATE)
            jumpToConclusion();
        else
            handleConclusionResponse();
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

    public void restartInterview() {
        variableAsserts.clear();
        priorAnswers.clear();
        numberOfAssertStatements.clear();
        latest_facts.clear();

        mainFrame.dispose();

        greetingForm = new GreetingForm(this);
        interviewForm = new InterviewForm(this);
        conclusionForm = new ConclusionForm(this);
        detailForm = new DetailForm(this);

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

    public void prevButtonAction() throws CLIPSException {
        System.out.println(priorAnswers.size());
        Integer last_number_of_statements = numberOfAssertStatements.pop();
        while (priorAnswers.size() != last_number_of_statements)
            priorAnswers.remove(priorAnswers.size() - 1);
        variableAsserts = priorAnswers;
        processRules();
    }

    public static void main(String args[]) {
        // Create the frame on the event dispatching thread.
        SwingUtilities.invokeLater(
                new Runnable() {
                    public void run() {
                        new CharityRecommender();
                    }
                });


    }
}
