package com.company;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.text.BreakIterator;
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

public class CharityRecommender implements ActionListener {

    private enum InterviewState {
        GREETING,
        INTERVIEW,
        CONCLUSION
    }

    JLabel displayLabel;
    JButton nextButton;
    JButton prevButton;
    JPanel choicesPanel;
    ButtonGroup choicesButtons;
    ResourceBundle charityResources;

    Environment clips;
    boolean isExecuting = false;
    Thread executionThread;

    String lastAnswer;
    String relationAsserted;
    ArrayList<String> variableAsserts;
    ArrayList<String> priorAnswers;

    InterviewState interviewState;

    List<FactInstance> latest_facts;

    // Hashtable storing the answers for each question. Pass in answer to get the vector of assert statements
    Hashtable donation_hash = new Hashtable();
    Hashtable charity_size_hash = new Hashtable();
    Hashtable tax_return_hash = new Hashtable();

    // For result retrieval
    Vector<String> goal_names = new Vector<>();
    Vector<Float> goal_values = new Vector<>();

    CharityRecommender() {
        try {
            charityResources = ResourceBundle.getBundle("AnimalResources", Locale.getDefault());

            {   // donation_type
                Vector<String> k_ans = new Vector<>();
                k_ans.add("(assert (nameofvariable (name kind)(cf 1)(true_or_false TRUE)))"); // TODO, get current facts value and put in place of 0.5 here, and also for all rules
                k_ans.add("(assert (current_question tax_exemption))");

                Vector<String> m_ans = new Vector<>();
                m_ans.add("(assert (nameofvariable (name money)(cf 1)(true_or_false TRUE)))");
                m_ans.add("(assert (current_question tax_exemption))");

                //m_ans.add("(assert (current_question charity_size))");

                Vector<String> v_ans = new Vector<>();
                v_ans.add("(assert (nameofvariable (name volunteer)(cf 1)(true_or_false TRUE)))");
                v_ans.add("(assert (current_question conclusion))");


                donation_hash.put("k", k_ans);
                donation_hash.put("m", m_ans);
                donation_hash.put("v", v_ans);
            }

            {   // charity_size qn - NEED TO GET ACTUAL CF VALUE FROM list of facts: Idea get from latest_Facts and replace symbol with number
                Vector<String> s_ans = new Vector<>();
                s_ans.add("(assert (nameofvariable (name small)(cf 0.3)(true_or_false TRUE)))"); // TODO, get yellow_cross cf from fact list
                s_ans.add("(assert (current_question conclusion))");
                Vector<String> m_ans = new Vector<>();
                m_ans.add("(assert (nameofvariable (name medium)(cf 0.3)(true_or_false TRUE)))");
                m_ans.add("(assert (current_question conclusion))");
                Vector<String> l_ans = new Vector<>();
                l_ans.add("(assert (nameofvariable (name large)(cf 0.3)(true_or_false TRUE)))");
                l_ans.add("(assert (current_question conclusion))");
                charity_size_hash.put("s", s_ans);
                charity_size_hash.put("m", m_ans);
                charity_size_hash.put("l", l_ans);
            }

            {   // tax_return hash TODO update with correct values
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name notax)(cf -1)(true_or_false TRUE)))"); // TODO, get yellow_cross cf from fact list
                y_ans.add("(assert (current_question charity_size))");
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (nameofvariable (name notax)(cf 0.1)(true_or_false TRUE)))");
                n_ans.add("(assert (current_question charity_size))");
                tax_return_hash.put("y", y_ans);
                tax_return_hash.put("n", n_ans);
            }

        } catch (MissingResourceException mre) {
            mre.printStackTrace();
            return;
        }

        /*================================*/
        /* Create a new JFrame container. */
        /*================================*/

        JFrame jfrm = new JFrame(charityResources.getString("CharityRecommender"));

        /*=============================*/
        /* Specify FlowLayout manager. */
        /*=============================*/

        jfrm.getContentPane().setLayout(new GridLayout(3, 1));

        /*=================================*/
        /* Give the frame an initial size. */
        /*=================================*/

        jfrm.setSize(500, 400);

        /*=============================================================*/
        /* Terminate the program when the user closes the application. */
        /*=============================================================*/

        jfrm.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        /*===========================*/
        /* Create the display panel. */
        /*===========================*/

        JPanel displayPanel = new JPanel();
        displayLabel = new JLabel();
        displayPanel.add(displayLabel);

        /*===========================*/
        /* Create the choices panel. */
        /*===========================*/

        choicesPanel = new JPanel();
        choicesButtons = new ButtonGroup();

        /*===========================*/
        /* Create the buttons panel. */
        /*===========================*/

        JPanel buttonPanel = new JPanel();

        prevButton = new JButton(charityResources.getString("Prev"));
        prevButton.setActionCommand("Prev");
        buttonPanel.add(prevButton);
        prevButton.addActionListener(this);

        nextButton = new JButton(charityResources.getString("Next"));
        nextButton.setActionCommand("Next");
        buttonPanel.add(nextButton);
        nextButton.addActionListener(this);

        /*=====================================*/
        /* Add the panels to the content pane. */
        /*=====================================*/

        jfrm.getContentPane().add(displayPanel);
        jfrm.getContentPane().add(choicesPanel);
        jfrm.getContentPane().add(buttonPanel);

        /*===================================*/
        /* Initialize the state information. */
        /*===================================*/

        variableAsserts = new ArrayList<String>();
        priorAnswers = new ArrayList<String>();

        /*==================================*/
        /* Load and run the animal program. */
        /*==================================*/

        clips = new Environment();

        try {
//            clips.loadFromResource("/resources/bcengine.clp");
//            clips.loadFromResource("/resources/animal.clp");

            // Added by Pier to test csv
//            clips.loadFromResource("/resources/csv.clp");
//            clips.loadFromResource("/resources/charities_reco.clp");

            // Added by Pier to test assertion of charity
            // String clipsCode = new Helpers().getFileData(CLIPS_FILE_LOCATION);
            String clipsCode = new Helpers().getFileData("/clips/CharitySelector_Pier_Mod.clp");
            clips.loadFromString(clipsCode);


//            try
//            {
//                clips.loadFromResource("/resources/animal_" +
//                        Locale.getDefault().getLanguage() + ".clp");
//            }
//            catch (FileNotFoundException fnfe)
//            {
//                if (Locale.getDefault().getLanguage().equals("en"))
//                { throw fnfe; }
//                else
//                { clips.loadFromResource("/resources/animal_en.clp"); }
//            }

            processRules();

        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }

        /*====================*/
        /* Display the frame. */
        /*====================*/

        jfrm.setVisible(true);
    }

    /*******************/
    /* handleResponse: */

    /*******************/
    private void handleResponse() throws Exception {
        /*===========================*/
        /* Get the current UI state and list of facts. */
        /*===========================*/
        latest_facts = clips.getFactList(); // don't call getFactList() too often, just once here
        printFacts();
        FactAddressValue fv = clips.findFact("UI-state");
        //FactAddressValue f_red_cross = clips.findFact("")
        FactAddressValue freco;
        /*========================================*/
        /* Determine the Next/Prev button states. */
        /*========================================*/

        if (fv.getSlotValue("state").toString().equals("conclusion")) {
            interviewState = InterviewState.CONCLUSION;
            nextButton.setActionCommand("Restart");
            nextButton.setText(charityResources.getString("Restart"));
            prevButton.setVisible(true);
            choicesPanel.setVisible(false);





        } else if (fv.getSlotValue("state").toString().equals("greeting")) {
            interviewState = InterviewState.GREETING;
            nextButton.setActionCommand("Next");
            nextButton.setText(charityResources.getString("Next"));
            prevButton.setVisible(false);
            choicesPanel.setVisible(false);
        } else {
            interviewState = InterviewState.INTERVIEW;
            nextButton.setActionCommand("Next");
            nextButton.setText(charityResources.getString("Next"));
            prevButton.setVisible(true);
            choicesPanel.setVisible(true);
        }

        /*=====================*/
        /* Set up the choices. */
        /*=====================*/

        choicesPanel.removeAll();
        choicesButtons = new ButtonGroup();

        MultifieldValue damf = (MultifieldValue) fv.getSlotValue("display-answers");
        MultifieldValue vamf = (MultifieldValue) fv.getSlotValue("valid-answers");

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

            if (((lastAnswer != null) && buttonAnswer.equals(lastAnswer)))
            //||
            //    ((lastAnswer == null) && buttonAnswer.equals(selected)))
            {
                rButton = new JRadioButton(buttonText, true);
            } else {
                rButton = new JRadioButton(buttonText, false);
            }

            rButton.setActionCommand(buttonAnswer);
            choicesPanel.add(rButton);
            choicesButtons.add(rButton);

            if (firstButton == null) {
                firstButton = rButton;
            }
        }

        if ((choicesButtons.getSelection() == null) && (firstButton != null)) {
            choicesButtons.setSelected(firstButton.getModel(), true);
        }

        choicesPanel.repaint();

        /*====================================*/
        /* Set the label to the display text. */
        /*====================================*/

        relationAsserted = ((LexemeValue) fv.getSlotValue("relation-asserted")).getValue();

        /*====================================*/
        /* Set the label to the display text. */
        /*====================================*/



        String theText;
        if (fv.getSlotValue("state").toString().equals("conclusion")) {
            List<RecommendedCharityModel> recommendedCharities = new ArrayList<RecommendedCharityModel>();
            getGoals();
            theText="";
            for (int i=0; i < goal_names.size(); i++) {
                RecommendedCharityModel recommendedCharity = new RecommendedCharityModel(goal_names.elementAt(i).toString(), goal_values.elementAt(i).toString());
                recommendedCharities.add(recommendedCharity);
            }

            // Sort the recommended charities by their recommendation level in descending order
            Collections.sort(recommendedCharities, new Comparator<RecommendedCharityModel>()
            {
               public int compare(RecommendedCharityModel c1, RecommendedCharityModel c2){
                   return - Double.compare(c1.RecommendedValue, c2.RecommendedValue);
               }
            });

            // get the value of the text to show
            for(RecommendedCharityModel charityModel: recommendedCharities){
                theText += charityModel.GetCharityNameAndRecommendedValueAppended();
            }
        }
        else {
            theText = ((StringValue) fv.getSlotValue("question")).getValue();
        }
        wrapLabelText(displayLabel, theText);

        executionThread = null;

        isExecuting = false;
    }

    /*########################*/
    /* ActionListener Methods */
    /*########################*/

    /*******************/
    /* actionPerformed */

    /*******************/
    public void actionPerformed(
            ActionEvent ae) {
        try {
            onActionPerformed(ae);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /*************/
    /* runCharity */

    /*************/
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

        //List<FactInstance> test = clips.getFactList();

        runCharity(); // need this to run before the clips can continue engine

    }

    // Print to console for debugging
    private void printFacts() {
        System.out.println("####");
        for (FactInstance factInstance : latest_facts) {
            FactInstance fi = factInstance;
            System.out.print(fi.getRelationName() + " : ");
            for (SlotValue sv : fi.getSlotValues()) {
                System.out.print("  " + sv.getSlotName());
                System.out.print("  " + sv.getSlotValue());
            }
            System.out.println("");
        }
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

    /********************/
    /* nextButtonAction */

    /********************/
    private void nextButtonAction() throws CLIPSException {
        String theString;
        String theAnswer;

        lastAnswer = null;
        switch (interviewState) {
            /* Handle Next button. */
            case GREETING:
                variableAsserts.add("(assert (current_question donation_type))");
                break;
            case INTERVIEW:
                clips.eval("(assert (continue_interview))");
                theAnswer = choicesButtons.getSelection().getActionCommand();

                //variableAsserts.clear();
                if (relationAsserted.equals("donation_type")) {
                    Vector<String> answers = (Vector<String>) donation_hash.get(theAnswer);
                    variableAsserts.addAll(answers);
                } else if (relationAsserted.equals("charity_size")) {
                    Vector<String> answers = (Vector<String>) charity_size_hash.get(theAnswer);
                    variableAsserts.addAll(answers);
                } else if (relationAsserted.equals("tax_exemption")) {
                    Vector<String> answers = (Vector<String>) tax_return_hash.get(theAnswer);
                    variableAsserts.addAll(answers);
                }

//                theString = "(variable (name " + relationAsserted + ") (value " +  theAnswer + "))";
//                variableAsserts.add(theString);
//                priorAnswers.add(theAnswer);
                break;

            /* Handle Restart button. */
            case CONCLUSION:
                variableAsserts.clear();
                priorAnswers.clear();
                break;
        }

        processRules();
    }

    /********************/
    /* prevButtonAction */

    /********************/
    private void prevButtonAction() throws CLIPSException {
        lastAnswer = priorAnswers.get(priorAnswers.size() - 1);

        variableAsserts.remove(variableAsserts.size() - 1);
        priorAnswers.remove(priorAnswers.size() - 1);

        processRules();
    }

    /*********************/
    /* onActionPerformed */

    /*********************/
    private void onActionPerformed(
            ActionEvent ae) throws Exception {
        if (isExecuting) return;

        if (ae.getActionCommand().equals("Next")) {
            nextButtonAction();
        } else if (ae.getActionCommand().equals("Restart")) {
            nextButtonAction();
        } else if (ae.getActionCommand().equals("Prev")) {
            prevButtonAction();
        }
    }

    /*****************/
    /* wrapLabelText */

    /*****************/
    private void wrapLabelText(
            JLabel label,
            String text) {
        FontMetrics fm = label.getFontMetrics(label.getFont());
        Container container = label.getParent();
        int containerWidth = container.getWidth();
        int textWidth = SwingUtilities.computeStringWidth(fm, text);
        int desiredWidth;

        if (textWidth <= containerWidth) {
            desiredWidth = containerWidth;
        } else {
            int lines = (int) ((textWidth + containerWidth) / containerWidth);

            desiredWidth = (int) (textWidth / lines);
        }

        BreakIterator boundary = BreakIterator.getWordInstance();
        boundary.setText(text);

        StringBuffer trial = new StringBuffer();
        StringBuffer real = new StringBuffer("<html><center>");

        int start = boundary.first();
        for (int end = boundary.next(); end != BreakIterator.DONE;
             start = end, end = boundary.next()) {
            String word = text.substring(start, end);

            // Add a line break if the current word contains a line separator
            if(word.contains(System.lineSeparator())){
                trial = new StringBuffer("");
                real.append("<br>");
            }
            else {
                trial.append(word);
                int trialWidth = SwingUtilities.computeStringWidth(fm, trial.toString());
                if (trialWidth > containerWidth) {
                    trial = new StringBuffer(word);
                    real.append("<br>");
                    real.append(word);
                } else if (trialWidth > desiredWidth) {
                    trial = new StringBuffer("");
                    real.append(word);
                    real.append("<br>");
                } else {
                    real.append(word);
                }
            }
        }

        real.append("</html>");

        label.setText(real.toString());
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
