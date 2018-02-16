;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This program is written by Charles Pang, 2018, ISS NUS (Copyright) 
;; This is a rule-based system for recommending a pet (red_cross, blue_cross, yellow_cross, purple_cross, black_cross) to
;; the user. It is an interactive system that makes use of certainty factors.  
;; 
;; Progamming is an art more than a science. The solution here is not the most elegant and even
;; not the most efficient ... but I have traded those for readability and simplicity in design
;; so that you can follow the english rules closely and kickstart your passion in AI and CLIPS!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(deftemplate current_fact (slot fact) (slot cf)                
                (slot notax(type NUMBER))
                (slot large(type NUMBER))
                (slot medium(type NUMBER))
                (slot small(type NUMBER))
                (slot health_sector(type NUMBER))
                (slot poverty_sector(type NUMBER))
                (slot rational(type NUMBER))
                (slot certainty_factor (type NUMBER))
)
(deftemplate current_goal (slot goal) (slot cf)) ;; the top-level
(deftemplate working_goal (slot goal) (slot cf)) ;; 
(deftemplate branch_indicator (slot name) (slot cf) (slot true_or_false))
(deftemplate recommendation (slot red_cross) (slot blue_cross) (slot yellow_cross) (slot purple_cross) (slot black_cross))
(deftemplate nameofvariable (slot name) (slot cf)(slot true_or_false))

;;; this will come from csv
(deffacts load-facts
	(current_fact (fact red_cross) (cf 0.5)
                (notax 1)
                (large 1)
                (medium 0)
                (small 0)
                (health_sector 1)
                (poverty_sector 0)
                (rational 1)
                (certainty_factor 0.5)
                 )
	(current_fact (fact blue_cross) (cf 0.5)
                (notax 1)
                (large 1)
                (medium 0)
                (small 0)
                (health_sector 1)
                (poverty_sector 0)
                (rational 1)
                (certainty_factor 0.5)
                 )
	(current_fact (fact yellow_cross) (cf 0.5)
                (notax 1)
                (large 1)
                (medium 0)
                (small 0)
                (health_sector 1)
                (poverty_sector 0)
                (rational 1)
                (certainty_factor 0.5))
	(current_fact (fact purple_cross) (cf 0.5)
                (notax 1)
                (large 1)
                (medium 0)
                (small 0)
                (health_sector 1)
                (poverty_sector 0)
                (rational 1)
                (certainty_factor 0.5))
	(current_fact (fact black_cross) (cf 0.5))

	(current_goal (goal red_cross) (cf 0.5))
	(current_goal (goal blue_cross) (cf 0.5))
	(current_goal (goal yellow_cross) (cf 0.5))
	(current_goal (goal purple_cross) (cf 0.5))
	(current_goal (goal black_cross) (cf 0.5))

  ;  (branch_indicator (name firstquestion) (true_or_false FALSE))
    (branch_indicator (name only_kind_or_time) (true_or_false UNKNOWN))
)

;;; some global variables used in rules 4&5
(defglobal
	?*time-cf* = 0.0
	?*money-cf* = 0.0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; initialise current goal when a new_goal is asserted
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (defrule initialise-current-goal
;	(working_goal (goal ?ng) (cf ?cfng))
;	(not (current_goal (goal ?cg) (cf ?cfg)))
;	?newg <- (working_goal (goal ?ng) (cf ?cfng))
;=> 	(assert (current_goal (goal ?ng) (cf ?cfng)))
;	(retract ?newg)
;)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CF combination for multiple conclusions RULES
;;; treat this as a black-box 

; you get the input and this will in the pet case always add if it is positive!
; in the end we have some negatives.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;combine POSITIVE certainty factors for multiple conclusions
;cf(cf1,cf2) = cf1 + cf2 * (1- cf1)

(defrule combine-positive-cf
;;;;;;;;;;;;;;;;;;problem: if you use branch indicators the next question will fire before the combination black box
  (declare (salience 101))
  ?f1 <- (current_goal (goal ?g)(cf ?cf1&:(>= ?cf1 0)))
  ?f2 <- (working_goal (goal ?g)(cf ?cf2&:(>= ?cf2 0)))
  (test (neq ?f1 ?f2)) ; test pointers and not value
  =>
  (retract ?f2)
  (modify ?f1 (cf =(+ ?cf1 (* ?cf2 (- 1 ?cf1)))))
  (printout t crlf "+++++++++++++++++++++++++++++++++++++new value " (fact-slot-value ?f1 cf))
)

;combine NEGATIVE cf
;cf(cf1,cf2) = cf1 + cf2 * (1 + cf1)

(defrule combine-neg-cf
 (declare (salience 100))
  ?f1 <- (current_goal   (goal ?g)(cf ?cf1&:(< ?cf1 0)))
  ?f2 <- (working_goal (goal ?g)(cf ?cf2&:(< ?cf2 0)))
  (test (neq ?f1 ?f2))
  =>
  (retract ?f2)
  (modify ?f1 (cf =(+ ?cf1 (* ?cf2 (+ 1 ?cf1)))))
  (printout t crlf "--------------------------------new value "(fact-slot-value ?f1 cf))

)

;combine one POSITIVE and one NEGATIVE
;cf(cf1,cf2) = (cf1 + cf2) / 1 - MIN[abs(cf1),abs(cf2)]

(defrule neg-pos-cf
 (declare (salience 100))
  ?f1 <- (current_goal (goal ?g) (cf ?cf1))
  ?f2 <- (working_goal (goal ?g) (cf ?cf2))
  (test (neq ?f1 ?f2))
  (test (< (* ?cf1 ?cf2) 0))
  =>
  (retract ?f2)
  (modify ?f1 (cf =(/ (+ ?cf1 ?cf2) (- 1 (min (abs ?cf1) (abs ?cf2))))))
  (printout t crlf "---------------+++++++++++++++++++new value "(fact-slot-value ?f1 cf))

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BUSINESS RULES
;;; note that stage1 and stage2 are combined into one assert statement within the defrule
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;**** Rule 1: Ask user preference for size.
(defrule donation_type
	(declare (salience 10))

; in order to retract facts you must have a fact adress in a variable (you can also lose true_or_fase but in this case,
; I want to create a variable AND test if true_or_fales = UNKNOWN
    ?branch_indicator <- (branch_indicator (name only_kind_or_time)(true_or_false UNKNOWN))
	(current_fact (fact red_cross) (cf ?cf-red_cross))
	(current_fact (fact blue_cross) (cf ?cf-blue_cross))
	(current_fact (fact yellow_cross) (cf ?cf-yellow_cross))
	(current_fact (fact purple_cross) (cf ?cf-purple_cross))
	(current_fact (fact black_cross) (cf ?cf-black_cross))
=>	(printout t crlf "

    What is your preferred donation type?

") 
	(printout t crlf "k=donation in kind,  m=donation in money, v=donation in volunteering (type in k/m/v)? ") 
	(bind ?response (read))
	(switch ?response
		(case k then 	(assert (working_goal (goal yellow_cross) (cf (* ?cf-yellow_cross 0.7))))
				(assert (working_goal (goal blue_cross) (cf (* ?cf-blue_cross 0.7))))
           ;     (retract ?branch_indicator)
                (modify ?branch_indicator (true_or_false TRUE)))
;(modify (only_kind_or_time) (true_or_false TRUE)))
		(case m then 	(assert (working_goal (goal yellow_cross) (cf (* ?cf-yellow_cross 0.8))))
				(assert (working_goal (goal red_cross) (cf (* ?cf-red_cross 0.8))))
                (modify ?branch_indicator (true_or_false FALSE)))
		(case v then 	(assert (working_goal (goal purple_cross) (cf (* ?cf-purple_cross 0.9))))
				(assert (working_goal (goal black_cross) (cf (* ?cf-black_cross 0.9))))

;;;;;;;;;;;;;;;;;;problem: if you use branch indicators the next question will fire before the combination black box

                (modify ?branch_indicator (true_or_false TRUE)))
        (default (printout t crlf "Not a valid answer, please try again.")
                (retract ?branch_indicator)
                (assert (branch_indicator (name only_kind_or_time)(true_or_false UNKNOWN)))
                )
	)
)
; you want to ask once, and then use the relevant cf for all relevant charities

;**** Rule2: Ask if want tax
(defrule tax
    (branch_indicator (name only_kind_or_time) (true_or_false FALSE))
;    ?branch_indicator <- (branch_indicator (name notax)(true_or_false UNKNOWN))	
=>	(printout t crlf "Do you like your tax returned? (y/n)") 
    (bind ?response (read))
; Create a name variable as input for the next function --> has to become a modify! (maybe a global variable is better?)
    (if (eq ?response y) then 
;        (assert (branch_indicator (name notax)(true_or_false TRUE)))  
        (assert (nameofvariable (name notax)(cf -1)(true_or_false TRUE)))
;      (assert ?branch_indicator (true_or_false TRUE))
;change this in a version that acknowledges a bad answer
    else
;        (assert (branch_indicator (name notax)(true_or_false TRUE)))
        (assert (nameofvariable (name notax)(cf 0.1)(true_or_false TRUE)))
    ;    (modify ?branch_indicator (true_or_false FALSE)))
	)
)
	;	(assert (working_goal (goal purple_cross) (cf (* ?cf-purple_cross 0.7))))
;		(assert (working_goal (goal black_cross) (cf (* ?cf-black_cross 1.0))))
;		(assert (working_goal (goal red_cross) (cf (* ?cf-red_cross 0.3))))
;	else 	(assert (working_goal (goal blue_cross) (cf (* ?cf-blue_cross 0.9))))
;		(assert (working_goal (goal yellow_cross) (cf (* ?cf-yellow_cross 0.9))))




(defrule selecting_the_right_charities
; for the time being --> to prevent from going to the next question after this
    (declare (salience 10))
    ?branch_ind <- (nameofvariable (name ?any_variable) (cf ?cf_variable) (true_or_false TRUE))
; I was stuck here for an hour: apparantly the order of these variables matters, any_variable and (fact-slot-value ?branch_ind name) work only after the =>...
;	?charity_adress <- (current_fact (fact ?any_charity) (certainty_factor ?cf_any_charity) (?any_variable ?test))
	?charity_adress <- (current_fact (fact ?any_charity) (cf ?cf_any_charity) (notax ?test))
    =>
  (assert (working_goal (goal ?any_charity) (cf (* ?cf_any_charity ?cf_variable))))
        (modify ?branch_ind (true_or_false FALSE))
)


;**** Rule3: Ask for donation type
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

;**** Print out the final results
; this is not an elegant way to program - imagine if you have 30 current_goals!
; also note the output is not sorted by CF


;I've deleted the salience to create some information
(defrule compile_recommendations
	(declare (salience -10))
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

