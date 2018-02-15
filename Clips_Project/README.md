# Clips_Project

**For Development :** 

You can open the folder in IntelliJ. 
You should be able to run and debug. Remember to modify the run config to suit your system. 
You can run from within IntelliJ.


**To Run From Command Line :** 

Generate the jar file -> Build -> Build Artifacts

A jar file Clips_Project.jar should be generated in 

    /Clips_Project/out/artifacts/Clips_Project_jar/
    
How to use from command line: 

Go to the directory where the Clips_Project.jar file is located

    java -Djava.library.path="../../../src/CLIPSJNI" -jar Clips_Project.jar 

Where "../../../src/CLIPSJNI" is the location of the CLIPSJNI library files. 

Notes : 

Currently, it is still based on the AnimalDemo codes. *work in progress!*

# Code Workings

Find the fact UI-state (triggered for every question)  
FactAddressValue fv = clips.findFact("UI-state");

(deftemplate MAIN::UI-state  
(slot id (default-dynamic (gensym*))) # auto-generated id  
(slot display)						# actual question text eg. “Does your animal have wings?”  
(slot relation-asserted (default none))	# used to build facts eg. animal.has.wings  
(slot response (default none))			# seems to be default response  
(multislot valid-answers) 				# actual answer values for each choice used to build facts   
(multislot display-answers) 			# display for the various possible choices  
(slot state (default interview))) 			# interview, conclusion, greeting


**Important functions to look at in Main.java (in order)**

1. **onActionPerformed()** // looks at the button pressed, and decides what to do “Next, Prev or Restart?”

2. **nextButtonAction()**	// Triggered when the next button is clicked, asserts the facts answered by the qn

3. **processRules()** // goes through the fact list and asserts all the facts eg. (assert (variable (name backbone) (value yes)))
                      // these facts are built from various selections in the gui
                      
4. **handleResponse()** // reads the new UI-state value after asserting the facts in processRules, and loads the menu accordingly, setting up the answers, buttons and all