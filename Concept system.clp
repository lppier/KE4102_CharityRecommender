;;; idea: in stead of changing all the elements of the different facts, we maybe should rather
;;; make a user profile, that in the very end leads to one algorithm that selects (groups of
;;; charities based on these answers. This way we don't have to assert all 2000 charities with each question :-)
;;; Note that Charles also confesses in his solution that this is not the most elegant 
;;; and efficient one.

(deftemplate current_goal (slot goal) (slot cf)) ;; the top-level
;;; some global variables

(defglobal
	?*time-cf* = 0.0
	?*money-cf* = 0.0
    ?*kind-cf* = 0.0)

(deftemplate background-info
"background info about the user"
; character info
; name of field
(slot emo-vs-ratio
; type of field
(type STRING)
; allowed inputs from likert scale
(allowed-strings
"1" "2" "3" "4" "5")
; default value of field name --> 3 = neutral
(default "0"))

; name of field
(slot sector
; type of field
(type STRING)
; allowed inputs (for now only 3 possibilities plus 0 = don't care)
(allowed-strings
"1" "2" "3" "0")
; default value of field name
(default "0"))

(slot age
; type. NUMBER can be
; INTEGER or FLOAT
(type NUMBER)
; default value of field age
(default 40))

)

(deftemplate preferences-user
; optional comment in quotes
"preferences from user"
; name of field
(slot tax_or_dontcare
; type of field
(type STRING)
; allowed inputs
(allowed-strings
"y" "n")
; default value of field assets --> both should not be an option
(default "n"))
; name of field
(slot large_medium_small_dontcare
; type of field
(type STRING)
; allowed inputs
(allowed-strings
"l" "m" "s" "d")
; default value of field assets --> both should not be an option
(default "d"))
)

(deftemplate charity
; optional comment in quotes
"all characteristics of a charity"
(slot name
; type of field
(type STRING)
; default value of field assets --> unknown
(default ""))
(slot tax_yes_no_unknown
; type of field
(type STRING)
; allowed inputs
(allowed-strings
"y" "n" "u")
; default value of field assets --> unknown
(default "u"))
; name of field
(slot large_medium_small
; type of field
(type STRING)
; allowed inputs, default unknown
(allowed-strings
"l" "m" "s" "u")
; default value of field assets 
(default "u"))
(slot sector
; type of field
(type STRING)
; allowed inputs (for now only 3 possibilities)
(allowed-strings
"1" "2" "3")
; default value of field name 3 = other
(default "3"))
)


;;; Just thought: if we use the abovementioned strat then we actually don't need deftemplate for 
;;; the user pref because we can also put them in deffacts... oh well...

(deffacts user_facts
    (background-info)
    (preferences-user)
)
    
;;; load facts from csv, but for now:

(deffacts load-facts
	(charity (name "redcross")
                (tax_yes_no_unknown "u")
                (large_medium_small "l")
                (sector "1")
                 (cf 0.5))
	(current_goal (goal redcross) (cf 0.5))

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CF combination rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;combine POSITIVE certainty factors for multiple conclusions
;cf(cf1,cf2) = cf1 + cf2 * (1- cf1)

(defrule combine-positive-cf
  ?f1 <- (current_goal (goal ?g)(cf ?cf1&:(>= ?cf1 0)))
  ?f2 <- (working_goal (goal ?g)(cf ?cf2&:(>= ?cf2 0)))
  (test (neq ?f1 ?f2)) ; test pointers and not value
  =>
  (retract ?f2)
  (modify ?f1 (cf =(+ ?cf1 (* ?cf2 (- 1 ?cf1)))))
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ratio-or-emo
   => (printout t crlf "Pleas enter if you think you are an emotional person or
       a rational person (check http://www.humanmetrics.com/cgi-win/jtypes2.asp for a free
       test):" crlf) 
      (bind ?ratio-or-emo (read))
      (assert (background-info(emo-vs-ratio ?ratio-or-emo)))
)       
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; OUTCOME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule recommend_charity
	(declare (salience -10))
    (background-info(emo-vs-ratio "emotional"))
    => 
	(printout t crlf "Our recommendation is as follows :")
    (printout t "We recommend charities of type ..." crlf)
)