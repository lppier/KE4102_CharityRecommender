## KE4102 INTELLIGENT SYSTEMS AND TECHNIQUES FOR BUSINESS ANALYTICS Group Project 
This was a group project demonstrating the use of CLIPS in the inference of rules in a rule-based system. The end result was a Java application that demonstrated how the user could get a set of charity recommendation results. 
Machine learning techniques such as K-nearest neighbours clustering was used to derive more results from the original set of results. 

## Team Members
Anurag Chatterjee                     
Bhujbal Vaibhav Shivaji              
Charles Thomas De Leau            
Lim Pier                                       
Liu Theodorus David Leonardi  
Tsan Yee Soon                             

## A Knowledge based system to recommend charities in Singapore

[1. Data Set](#data-set)

[2. How to Import facts from CSV file](#how-to-import-facts-from-csv-file)

### Data Set

https://drive.google.com/open?id=1zZZCicFEp8QhmHZtcvcodB4AA6bZJoGp

**Description**
* **Charities_all_remove_duplicates.csv** contains all of the charities that we scraped from Charities.gov.sg.
* **Charities_registered.csv** contains all of the registered charities in Singapore.
* **Charities_with_ipc.csv** contains all of the charities in Singapore with IPC status.
* **Charities_with_tax_exempt.csv** contains all of the charities that benefit from tax exemption.
* **Charities_code_compliances.csv** contains the latest charities’ code of compliance information. Each entry stores one item of code of compliance. So one charity can consist of multiple code of compliance entries in this file.
* **Charities_financial_information.csv** contains the last three years of charities’ financial information.

### How to Import facts from CSV file

1. Define a template 

**Example**
```
(deftemplate link
  (slot title (type STRING))
  (slot url (type STRING))
  (slot category (type STRING))
)
```

2. Insert all the facts to a CSV file

**Example**
```
title,url,category
"CLIPSESG","http://groups.google.com/group/CLIPSESG","code"
"CLIPS","http://clipsrules.sourceforge.net/","book"
```

3. Load CSV library
```
CLIPS> (load "csv.clp")
```

4. Run CSV-Import command

**Format**
```
CLIPS> (CSV-import "filename" template-name)
```
**Example**
```
CLIPS> (CSV-import "link.csv" link)
```

5. Verify the facts
```
CLIPS> (facts)
f-1     (link (title "CLIPSESG") (url "http://groups.google.com/group/CLIPSESG") (category "code"))
f-2     (link (title "CLIPS") (url "http://clipsrules.sourceforge.net/") (category "book"))
For a total of 2 facts.

```

# Clips_Project (Java GUI)

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

### Code Workings

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
