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

(deftemplate current_fact (slot fact) (slot cf))
(deftemplate current_goal (slot goal) (slot cf)) ;; the top-level
(deftemplate working_goal (slot goal) (slot cf)) ;; 
(deftemplate branch_indicator (slot name) (slot true_or_false))
(deftemplate recomendation (slot red_cross) (slot blue_cross) (slot yellow_cross) (slot purple_cross) (slot black_cross))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Initial facts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; by default (initially) all pets have equal chance of being recommended 
;;; however, if you have knowledge that some pets are less popular
;;; you can give it a lower CF to begin with
(deffacts load-facts
	(current_fact (fact red_cross) (cf 0.5))
	(current_fact (fact blue_cross) (cf 0.5))
	(current_fact (fact yellow_cross) (cf 0.5))
	(current_fact (fact purple_cross) (cf 0.5))
	(current_fact (fact black_cross) (cf 0.5))

	(current_goal (goal red_cross) (cf 0.5))
	(current_goal (goal blue_cross) (cf 0.5))
	(current_goal (goal yellow_cross) (cf 0.5))
	(current_goal (goal purple_cross) (cf 0.5))
	(current_goal (goal black_cross) (cf 0.5))

        (UI-state 
            (question "Welcome to Charity Recommender! Do you want to start the recommendation?")
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
   ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s)) ; not req if no fact definition in front
   ?fci <- (continue_interview)
   ?fcq <- (current_question ?f)
   =>
    (retract ?f1)
    (assert (UI-state 
                (question "Welcome to Charity Recommender! Do you want to start the recommendation?")
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
	;(declare (salience 10))
        (continue_interview)
        (current_question donation_type)
	(current_fact (fact red_cross) (cf ?cf-red_cross))
	(current_fact (fact blue_cross) (cf ?cf-blue_cross))
	(current_fact (fact yellow_cross) (cf ?cf-yellow_cross))
	(current_fact (fact purple_cross) (cf ?cf-purple_cross))
	(current_fact (fact black_cross) (cf ?cf-black_cross))
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
    ;(modify ?fcq (current_question greeting))
    ;(assert (current_question charity_size))
    
)

; 	(printout t crlf "k=donation in kind,  m=donation in money, v=donation in volunteering (s/m/l)? ") 
; 	(bind ?response (read))
; 	(switch ?response
; 		(case k then 	(assert (working_goal (goal yellow_cross) (cf (* ?cf-yellow_cross 0.7))))
; 				(assert (working_goal (goal blue_cross) (cf (* ?cf-blue_cross 0.7))))
;                 (assert (branch_indicator (name only_kind_or_time) (true_or_false TRUE))))
; 		(case m then 	(assert (working_goal (goal yellow_cross) (cf (* ?cf-yellow_cross 0.4))))
; 				(assert (working_goal (goal red_cross) (cf (* ?cf-red_cross 0.8))))
;                 (assert (branch_indicator (name only_kind_or_time) (true_or_false FALSE))))
; 		(case v then 	(assert (working_goal (goal purple_cross) (cf (* ?cf-purple_cross 0.9))))
; 				(assert (working_goal (goal black_cross) (cf (* ?cf-black_cross 0.9))))
;                 (assert (branch_indicator (name only_kind_or_time) (true_or_false TRUE))))
; 	)




;**** Rule2: Ask if want tax
(defrule tax
    ;(branch_indicator (name only_kind_or_time) (true_or_false FALSE))
        (continue_interview)
        (current_question tax_exemption)
	(current_fact (fact purple_cross) (cf ?cf-purple_cross))
	(current_fact (fact black_cross) (cf ?cf-black_cross))
	(current_fact (fact red_cross) (cf ?cf-red_cross))
	(current_fact (fact yellow_cross) (cf ?cf-yellow_cross))
	(current_fact (fact blue_cross) (cf ?cf-blue_cross))
        ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
        ?fci <- (continue_interview)
        ?fcq <- (current_question ?f)
=>	
    (retract ?f1)
    (assert (UI-state 
                (question "Do you like tax returned?")
                (relation-asserted tax_exemption)
                (valid-answers y n)
                (display-answers "Yes" "No")
                (state interview)))
    (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked) 
    (retract ?fcq)
    ;(modify ?fcq (current_question charity_size))
        ;(printout t crlf "Do you like tax returned? (y/n)") 
	; (bind ?response (read))
	; (if (eq ?response y) then 
	; 	(assert (working_goal (goal purple_cross) (cf (* ?cf-purple_cross 0.7))))
	; 	(assert (working_goal (goal black_cross) (cf (* ?cf-black_cross 1.0))))
	; 	(assert (working_goal (goal red_cross) (cf (* ?cf-red_cross 0.3))))
	; else 	(assert (working_goal (goal blue_cross) (cf (* ?cf-blue_cross 0.9))))
	; 	(assert (working_goal (goal yellow_cross) (cf (* ?cf-yellow_cross 0.9))))
	; )
)

; ;**** Rule3: Ask for donation type
(defrule charity_size
        (continue_interview)
        (current_question charity_size)
	(current_fact (fact red_cross) (cf ?cf-red_cross))
	(current_fact (fact blue_cross) (cf ?cf-blue_cross))
	(current_fact (fact yellow_cross) (cf ?cf-yellow_cross))
	(current_fact (fact purple_cross) (cf ?cf-purple_cross))
	(current_fact (fact black_cross) (cf ?cf-black_cross))
        ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
        ?fci <- (continue_interview)
        ?fcq <- (current_question ?f)
=>	;(printout t crlf "Do you like small, midsize or large charity? (s/m/l)") 
	; (bind ?response (read))
	; (switch ?response
	; 	(case s then 	(assert (working_goal (goal red_cross) (cf (* ?cf-red_cross 0.5))))  ; dus nieuwe working goal krijgt 0.5*0.5 --> als waarde. En dan wordt dat opgeteld bij de oude.
	; 			        (assert (working_goal (goal blue_cross) (cf (* ?cf-blue_cross 0.8)))) 
	; 			        (assert (working_goal (goal yellow_cross) (cf (* ?cf-yellow_cross 1.0)))))
	; 	(case m then 	(assert (working_goal (goal red_cross) (cf (* ?cf-red_cross 0.8))))						
 ;                       (assert (working_goal (goal purple_cross) (cf (* ?cf-purple_cross 0.6))))
 ;        				(assert (working_goal (goal black_cross) (cf (* ?cf-black_cross 0.2)))))
	; 	(case l then 	(assert (working_goal (goal purple_cross) (cf (* ?cf-purple_cross 0.5))))
	; 			        (assert (working_goal (goal black_cross) (cf (* ?cf-black_cross 0.9)))))
	; )
        (retract ?f1)
        (assert (UI-state 
                (question "Do you like small, midsize or large charity?")
                (relation-asserted charity_size)
                (valid-answers s m l)
                (display-answers "Small" "Medium" "Large")
                (state interview)))
        (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked) 
        (retract ?fcq)
        ;(modify ?fcq (current_question greeting))
)


; ;**** Print out the final results
; ; this is not an elegant way to program - imagine if you have 30 current_goals!
; ; also note the output is not sorted by CF

(defrule compile_recommendations
	;(declare (salience -10))
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
=>	;(assert (recomendation (red_cross ?cf-r) (blue_cross ?cf-m) (yellow_cross ?cf-f) (purple_cross ?cf-c) (black_cross ?cf-d)))
        (retract ?f1)
        (assert (UI-state 
                (question "Here are your results: ")
                (relation-asserted conclusion)
                (valid-answers)
                (display-answers)
                (state conclusion)))
        (retract ?fci)
        (retract ?fcq)
        (assert (recomendation (red_cross ?cf-r) (blue_cross ?cf-m) (yellow_cross ?cf-f) (purple_cross ?cf-c) (black_cross ?cf-d)))
	; (printout t crlf "Our recommendation is as currently as follows :")
	; (printout t crlf "red_cross: " (integer (* ?cf-r 100)) "%")
	; (printout t crlf "blue_cross   : " (integer (* ?cf-m 100)) "%")
	; (printout t crlf "yellow_cross   : " (integer (* ?cf-f 100)) "%")
	; (printout t crlf "purple_cross    : " (integer (* ?cf-c 100)) "%")
	; (printout t crlf "black_cross    : " (integer (* ?cf-d 100)) "%" crlf)
)

