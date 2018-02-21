;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Templates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Added by pier - UI-related
(deftemplate combined_value (slot fact) (slot cf))      ; test value to see whether combination fn was called
(deftemplate UI-state 
   ;(slot id (default-dynamic (gensym*)))                ; autogen id everytime UI-state is asserted
   (slot question (type STRING))                        ; question text
   (slot relation-asserted (default none))              ; eg. donation-type (used in UI code for finding facts to assert)
   (multislot valid-answers)                            ; symbols to denote each ans selection (eg. k m v)
   (multislot display-answers)                          ; text for each answer's display in UI
   (slot state (default interview)))                    ; 3 states: greeting, interview (mostly here) and conclusion

;;; Added by Charles
(deftemplate current_fact
    (slot fact)
    (slot cf)
    (multislot all_vars) ;contains all applicable parameters.
)
;;; End of addition


(deftemplate current_goal (slot goal) (slot cf)) ;; the top-level
(deftemplate working_goal (slot goal) (slot cf)) ;; 

(deftemplate recomendation (slot red_cross) (slot blue_cross) (slot yellow_cross) (slot purple_cross) (slot black_cross))

;;; Changed Charles
(deftemplate branch_indicator (slot name) (slot cf) (slot true_or_false))
(deftemplate nameofvariable (slot name) (slot cf)(slot true_or_false))
;;; End of change

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Initial facts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; by default (initially) all pets have equal chance of being recommended 
;;; however, if you have knowledge that some pets are less popular
;;; you can give it a lower CF to begin with
(deffacts load-facts
    ;;; Changed Charles
	(current_fact (fact red_cross) (cf 0.5) (all_vars notax health large money))
    (current_fact (fact blue_cross) (cf 0.5) (all_vars tax health medium kind))
    (current_fact (fact yellow_cross) (cf 0.5) (all_vars notax health medium volunteer))
    (current_fact (fact purple_cross) (cf 0.5) (all_vars tax health medium money))
    (current_fact (fact black_cross) (cf 0.5) (all_vars tax health medium money))
     ;;; End of change

	(current_goal (goal red_cross) (cf 0.5))
	(current_goal (goal blue_cross) (cf 0.5))
	(current_goal (goal yellow_cross) (cf 0.5))
	(current_goal (goal purple_cross) (cf 0.5))
	(current_goal (goal black_cross) (cf 0.5))

	 ;;; Changed Charles
     (branch_indicator (name only_kind_or_time) (true_or_false UNKNOWN))
     ;;; End of change

      (UI-state
            (question "Welcome to Give@SG, we will recommend a list of charities based on your preference.")
            (relation-asserted greeting)
            (valid-answers y)
            (display-answers "Yes")
            (state greeting))

        (current_question greeting)
        (continue_interview)
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
  ?f1 <- (current_goal (goal ?g)(cf ?cf1&:(>= ?cf1 0)))
  ?f2 <- (working_goal (goal ?g)(cf ?cf2&:(>= ?cf2 0)))
  (test (neq ?f1 ?f2)) ; test pointers and not value
  =>
  (retract ?f2)
  (modify ?f1 (cf =(+ ?cf1 (* ?cf2 (- 1 ?cf1)))))
  ;(assert (combined_value (fact combined) (cf ?cf1)))
)

;combine NEGATIVE cf
;cf(cf1,cf2) = cf1 + cf2 * (1 + cf1)

(defrule combine-neg-cf
 (declare (salience -1))
  ?f1 <- (current_goal   (goal ?g)(cf ?cf1&:(< ?cf1 0)))
  ?f2 <- (working_goal (goal ?g)(cf ?cf2&:(< ?cf2 0)))
  (test (neq ?f1 ?f2))
  =>
  (retract ?f2)
  (modify ?f1 (cf =(+ ?cf1 (* ?cf2 (+ 1 ?cf1)))))
)

;combine one POSITIVE and one NEGATIVE
;cf(cf1,cf2) = (cf1 + cf2) / 1 - MIN[abs(cf1),abs(cf2)]

(defrule neg-pos-cf
 (declare (salience -1))
  ?f1 <- (current_goal (goal ?g) (cf ?cf1))
  ?f2 <- (working_goal (goal ?g) (cf ?cf2))
  (test (neq ?f1 ?f2))
  (test (< (* ?cf1 ?cf2) 0))
  =>
  (retract ?f2)
  (modify ?f1 (cf =(/ (+ ?cf1 ?cf2) (- 1 (min (abs ?cf1) (abs ?cf2))))))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BUSINESS RULES
;;; note that stage1 and stage2 are combined into one assert statement within the defrule
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule startup
   (current_question greeting)
   ?f1 <- (UI-state (relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s)) ; not req if no fact definition in front
   ?fci <- (continue_interview)
   ?fcq <- (current_question ?f)
   =>
    (retract ?f1)
    (assert (UI-state
                (question "Welcome to Give@SG, we will recommend a list of charities based on your preference.")
                (relation-asserted greeting)
                (valid-answers y)
                (display-answers "Yes")
                (state greeting)))
    (retract ?fci)
    ;(retract ?fcq)
    (modify ?fcq (current_question donation_type))
    ;(assert (current_question donation_type))
    
)        

;**** Rule 1: Ask user preference for size.
(defrule donation_type
    (continue_interview)
    (current_question donation_type)

    ; 1. You need an indicator for starting + CLIPS does not let you change this if you don't put it into a variable:
    ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
            ?fci <- (continue_interview)
            ?fcq <- (current_question ?f)
    =>
      (retract ?f1)
      (assert (UI-state
                (question "What form of charity do you prefer doing?")
                (relation-asserted donation_type)
                (valid-answers k m v)
                (display-answers "Donation in kind" "Donation in money" "Donation by volunteering")
                (state interview)))
	(retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
    (retract ?fcq)
)

;**** Rule2: Ask if want tax
(defrule tax
    (continue_interview)
    (current_question tax_exemption)
    ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
            ?fci <- (continue_interview)
            ?fcq <- (current_question ?f)
=>
    (retract ?f1)
    (assert (UI-state
                (question "Do you like your tax returned?")
                (relation-asserted tax_exemption)
                (valid-answers y n)
                (display-answers "Yes" "No")
                (state interview)))
    (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
    (retract ?fcq)
)

;**** Rule3: Ask for charity size
(defrule charity_size
    (continue_interview)
    (current_question charity_size)
     ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
     ?fci <- (continue_interview)
     ?fcq <- (current_question ?f)
=>	 (retract ?f1)
     (assert (UI-state
                (question "Do you like small, midsize or large charity?")
                (relation-asserted charity_size)
                (valid-answers s m l)
                (display-answers "Small" "Medium" "Large")
                (state interview)))
     (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
     (retract ?fcq)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ENGINE RULE (RULE THAT SELECTS THE RIGHT CHARITIES AND ADJUSTS THEIR CF)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule selecting_the_right_charities
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
;;; RECOMMENDATIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule compile_recommendations
        (continue_interview)
        (current_question conclusion)
	(current_goal (goal red_cross) (cf ?cf-r))
	(current_goal (goal blue_cross) (cf ?cf-m))
	(current_goal (goal yellow_cross) (cf ?cf-f))
	(current_goal (goal purple_cross) (cf ?cf-c))
	(current_goal (goal black_cross) (cf ?cf-d))
        ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
        ?fci <- (continue_interview)
        ?fcq <- (current_question ?f)
=>      (retract ?f1)
        (assert (UI-state
                (question "Here are your results: ")
                (relation-asserted conclusion)
                (valid-answers)
                (display-answers)
                (state conclusion)))
        (retract ?fci)
        (retract ?fcq)
        (assert (recomendation (red_cross ?cf-r) (blue_cross ?cf-m) (yellow_cross ?cf-f) (purple_cross ?cf-c) (black_cross ?cf-d)))
)

