;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; You can use the (watch all) command or the agenda function in IDE. 
;; I commented the final salience so you can see easily what happens 
;;; comments with stars (*) are only for improvement, not for understanding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; To do's 
;; make every rule such that wrong answer --> ask again
;; adjust rule 3 in line with previous two

;;Ideas:
;; Rationality will influence the type of questions rather than the charities
;; Age will be a combined rule --> see rule 4 of the pet recommender
;; Make use of global variables for more complexity
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; DEFINING TEMPLATES AND FACTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(deftemplate current_fact (slot fact) 
                (slot cf) 
                (multislot all_vars) ;contains all applicable parameters.               
)
(deftemplate current_goal (slot goal) (slot cf)) ;; the top-level
(deftemplate working_goal (slot goal) (slot cf)) ;; 
(deftemplate branch_indicator (slot name) (slot cf) (slot true_or_false))
(deftemplate recommendation (slot red_cross) (slot blue_cross) (slot yellow_cross) (slot purple_cross) (slot black_cross))
(deftemplate nameofvariable (slot name) (slot cf)(slot true_or_false))

;;; this will come from csv, only thing needed is some preprocessing
(deffacts load-facts
	(current_fact (fact red_cross) (cf 0.5)
                (all_vars notax health large money))
	(current_fact (fact blue_cross) (cf 0.5)
                (all_vars tax health medium kind))
	(current_fact (fact yellow_cross) (cf 0.5)
                (all_vars notax health medium volunteer))
	(current_fact (fact purple_cross) (cf 0.5)
                (all_vars tax health medium money))
	(current_fact (fact black_cross) (cf 0.5)
                (all_vars tax health medium money))

    ;see the pet recommender for how this works
	(current_goal (goal red_cross) (cf 0.5))
	(current_goal (goal blue_cross) (cf 0.5))
	(current_goal (goal yellow_cross) (cf 0.5))
	(current_goal (goal purple_cross) (cf 0.5))
	(current_goal (goal black_cross) (cf 0.5))

  ;  (branch_indicator (name firstquestion) (true_or_false FALSE))
    (branch_indicator (name only_kind_or_time) (true_or_false UNKNOWN))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BUSINESS RULES
; The idea is: you want to ask for input, and then use that input to get the relevant cf for all relevant charities (see engine rule)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;**** Rule 1: Ask user preference for size.
(defrule donation_type
    ; 1. You need an indicator for starting + CLIPS does not let you change this if you don't put it into a variable:
    ?branch_indicator <- (branch_indicator (name only_kind_or_time)(true_or_false UNKNOWN))
    =>	
    (printout t crlf " What is your preferred donation type? ") 
	(printout t crlf "k=donation in kind,  m=donation in money, v=donation in volunteering (type in k/m/v)? ") 
	(bind ?response (read))
	(switch ?response
        ;2a Create a name fact as input for the collector function (engine rule) --> in this case we want to edit the cf with 1 for all charities with the name 'kind'. Perhaps it is better to edit money and volunteer with -1, have to see.
		(case k then (assert (nameofvariable (name kind)(cf 1)(true_or_false TRUE)))
        ;2b here we make sure that the second rule, tax, doesn't fire.
                (modify ?branch_indicator (true_or_false TRUE)))
        (case m then (assert (nameofvariable (name money)(cf 1)(true_or_false TRUE)))        
                (modify ?branch_indicator (true_or_false FALSE)))
        (case v then (assert (nameofvariable (name volunteer)(cf 1)(true_or_false TRUE)))  
                (modify ?branch_indicator (true_or_false TRUE)))
        ;2c. the default is rest category (the wrong answer): ask again.        
        (default (printout t crlf "Not a valid answer, please try again.")
                (retract ?branch_indicator)
                (assert (branch_indicator (name only_kind_or_time)(true_or_false UNKNOWN))))
        )
    )

;**** Rule2: Ask if want tax
(defrule tax
    (branch_indicator (name only_kind_or_time) (true_or_false FALSE))	
=>	(printout t crlf "Do you like your tax returned? (y/n)") 
    (bind ?response (read))
; Create a name variable as input for the next function --> has to become a modify!
    (if (eq ?response y) then 
        (assert (nameofvariable (name notax)(cf -1)(true_or_false TRUE)))
;change this in a version that acknowledges a bad answer
    else
        (assert (nameofvariable (name notax)(cf 0.1)(true_or_false TRUE)))
	)
)


;**** Rule3: Ask for donation size --> old fashioned way, still have to convert.
(defrule charity_size
	(current_fact (fact red_cross) (cf ?cf-red_cross))
	(current_fact (fact blue_cross) (cf ?cf-blue_cross))
	(current_fact (fact yellow_cross) (cf ?cf-yellow_cross))
	(current_fact (fact purple_cross) (cf ?cf-purple_cross))
	(current_fact (fact black_cross) (cf ?cf-black_cross))
=>	(printout t crlf "Do you prefer small, midsize or large charities? (s/m/l)") 
	(bind ?response (read))
	(switch ?response
		(case s then 	(assert (working_goal (goal red_cross) (cf (* ?cf-red_cross 0.5))))  ; dus nieuwe working goal krijgt 0.5*0.5 --> als waarde. En dan wordt dat opgeteld bij de oude.
				        (assert (working_goal (goal blue_cross) (cf (* ?cf-blue_cross 0.8)))) 
				        (assert (working_goal (goal yellow_cross) (cf (* ?cf-yellow_cross 1.0)))))
		(case m then 	(assert (working_goal (goal red_cross) (cf (* ?cf-red_cross 0.8))))						
                        (assert (working_goal (goal purple_cross) (cf (* ?cf-purple_cross 0.6))))
        				(assert (working_goal (goal black_cross) (cf (* ?cf-black_cross 0.2)))))
		(case l then 	(assert (working_goal (goal purple_cross) (cf (* ?cf-purple_cross 0.5))))
				        (assert (working_goal (goal black_cross) (cf (* ?cf-black_cross 0.9)))))
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ENGINE RULE (RULE THAT SELECTS THE RIGHT CHARITIES AND ADJUSTS THEIR CF)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule selecting_the_right_charities
    ; *for the time being I kept salience in --> to prevent from going to the next question after this:
    (declare (salience 10))
    ;1. branch ind is the name variable of the current variable which true_or_false is set to TRUE.
    ; *previously I modified this fact but given that CLIPS only uses each fact + rule once (you can adjust this)
    ; I removed that (it also gave some issues):
    ?branch_ind <- (nameofvariable (name ?any_variable) (cf ?cf_variable) (true_or_false TRUE))
    ; 2. charity adress is the charity from the csv that has all_vars x in their multislot (eg. kind, health)
    ?charity_adress <- (current_fact (fact ?any_charity) (cf ?cf_any_charity) (all_vars $? ?any_variable $?))
    =>
    ; assert the working goal to fire the combination rules
    (assert (working_goal (goal ?any_charity) (cf (* ?cf_any_charity ?cf_variable))))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; COMBINATION RULES (Combining the cf's)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule combine-positive-cf
; *To keep in mind: if you remove this salience and use branch indicators and assert them after you make a 
; new working_goal, the next question will fire before the combination black box, so the order is important
; for now I keep it in
  (declare (salience 2))
  ?f1 <- (current_goal (goal ?g)(cf ?cf1&:(>= ?cf1 0)))
  ?f2 <- (working_goal (goal ?g)(cf ?cf2&:(>= ?cf2 0)))
  (test (neq ?f1 ?f2)) ; test pointers and not value
  =>
  (retract ?f2)
  (modify ?f1 (cf =(+ ?cf1 (* ?cf2 (- 1 ?cf1)))))
; I use these print outs to get a better understanding, but feel free to remove them
;  (printout t crlf "+++++++++++++++++++++++++++++++++++++new value " (fact-slot-value ?f1 cf))
)

;combine NEGATIVE cf
;cf(cf1,cf2) = cf1 + cf2 * (1 + cf1)

(defrule combine-neg-cf
 (declare (salience 1))
  ?f1 <- (current_goal   (goal ?g)(cf ?cf1&:(< ?cf1 0)))
  ?f2 <- (working_goal (goal ?g)(cf ?cf2&:(< ?cf2 0)))
  (test (neq ?f1 ?f2))
  =>
  (retract ?f2)
  (modify ?f1 (cf =(+ ?cf1 (* ?cf2 (+ 1 ?cf1)))))
;  (printout t crlf "--------------------------------new value "(fact-slot-value ?f1 cf))

)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; final print out function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;combine one POSITIVE and one NEGATIVE
;cf(cf1,cf2) = (cf1 + cf2) / 1 - MIN[abs(cf1),abs(cf2)]

(defrule neg-pos-cf
 (declare (salience 1))
  ?f1 <- (current_goal (goal ?g) (cf ?cf1))
  ?f2 <- (working_goal (goal ?g) (cf ?cf2))
  (test (neq ?f1 ?f2))
  (test (< (* ?cf1 ?cf2) 0))
  =>
  (retract ?f2)
  (modify ?f1 (cf =(/ (+ ?cf1 ?cf2) (- 1 (min (abs ?cf1) (abs ?cf2))))))
;  (printout t crlf "---------------+++++++++++++++++++new value "(fact-slot-value ?f1 cf))

)


;**** Print out the final results
; this is not an elegant way to program - imagine if you have 30 current_goals!
; also note the output is not sorted by CF

;I've deleted the salience to create some information
(defrule compile_recommendations
; you can comment the salience to get an easy insight in what it does
	;(declare (salience -10))
	(current_goal (goal red_cross) (cf ?cf-r))
	(current_goal (goal blue_cross) (cf ?cf-m))
	(current_goal (goal yellow_cross) (cf ?cf-f))
	(current_goal (goal purple_cross) (cf ?cf-c))
	(current_goal (goal black_cross) (cf ?cf-d))
=>	(assert (recommendation (red_cross ?cf-r) (blue_cross ?cf-m) (yellow_cross ?cf-f) (purple_cross ?cf-c) (black_cross ?cf-d)))
	(printout t crlf "Our recommendation is as currently as follows :")
	(printout t crlf "red_cross: " (integer (* ?cf-r 100)) "%")
	(printout t crlf "blue_cross   : " (integer (* ?cf-m 100)) "%")
	(printout t crlf "yellow_cross   : " (integer (* ?cf-f 100)) "%")
	(printout t crlf "purple_cross    : " (integer (* ?cf-c 100)) "%")
	(printout t crlf "black_cross    : " (integer (* ?cf-d 100)) "%" crlf)
)