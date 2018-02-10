;;; to do:

;;; add cf certainties (in deftemplate as default --> SO WE CAN CHANGE THE DEFAULTS IF A PERSON IS IRRATIONAL)
;;; then we need a * indicator like pet --> easy
;;; then two options with the 'black box' mechanism:
;;; 1. with salience -10 get all inputs and calculate result;;; downside of this method is that we cannot have a in between
;;; 2. function for each value that ~default (no not valid)... =new or something do the calculation
;;; make a ranked grouping system.


;;; idea: in stead of changing all the elements of the different facts, we should rather
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
(slot ratio-or-emo
; type of field
(type STRING)
; allowed inputs from likert scale
(allowed-strings
"1" "2" "3" "4" "5")
; default value of field name --> 3 = neutral
(default "3"))
;make a cf for each field to prevent asserting every time
(slot ratio-cf)

;I think we need to make this one for each sector.
; name of field
(slot healthsector
; type of field
(type STRING)
; allowed inputs
(allowed-strings
"1" "2" "3" "4" "5" "0")
; default value of field name
(default "3"))
(slot health-cf)

(slot age
; type. NUMBER can be
; INTEGER or FLOAT
(type NUMBER)
; default value of field age
(default 40))
(slot age-cf)
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
"all characteristics of a charity"
(multislot name
(type SYMBOL)
(default ?DERIVE))

(slot tax_yes_no_unknown
; type of field
(type STRING)
; allowed inputs
(allowed-strings
"y" "n" "u")
; default value of field assets --> unknown
(default "u"))

(slot Budd_or_Islam
; type of field
(type STRING)
; allowed inputs
(allowed-strings "B" "I")
; default value of field assets --> unknown
(default "B"))

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

(deftemplate sector
 (slot name)
 (type STRING)
 (slot cf)
 (type NUMBER)
 (default 0.7)
)
;;; Just thought: if we use the abovementioned strat then we actually don't need deftemplate for 
;;; the user pref because we can also put them in deffacts... oh well...

(deffacts user_facts
    (background-info)
    (preferences-user)
)
    
;;; load facts from csv, but for now:

(deffacts load_facts
	(charity (name red cross)
                (tax_yes_no_unknown "u")
                (large_medium_small "l")
                (sector "1")
                 )
)

;	(current_goal (goal redcross) (cf 0.5))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CF combination rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;combine POSITIVE certainty factors for multiple conclusions
;cf(cf1,cf2) = cf1 + cf2 * (1- cf1)

;JUST COPY THESE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BUSINESS RULES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ratio-or-emo
   => (printout t crlf "Can you give an indication if you agree with the following statement:
The last time I donated to charity I spend some time checking if the charity was effective. 
Possible answers (enter the number): 1 (totally incorrect) 2 (not really correct) 3 (neutral) 4 (sort of correct) 5 (totally incorrect) 
0 (don't know/care)" crlf) 
      (bind ?ratio-or-emo (read))
; because it is the first input, I need a ratio-cf here that is not a product but a statement
      (switch ?ratio-or-emo
(case "1" then  (assert (background-info(ratio-or-emo ?ratio-or-emo)(ratio-cf 0.5))))
(case "2" then  (assert (background-info(ratio-or-emo ?ratio-or-emo)(ratio-cf 0.3))))
(case "3" then  (assert (background-info(ratio-or-emo ?ratio-or-emo)(ratio-cf 0.1))))
(case "4" then  (assert (background-info(ratio-or-emo ?ratio-or-emo)(ratio-cf 0.3))))
(case "5" then  (assert (background-info(ratio-or-emo ?ratio-or-emo)(ratio-cf 0.5))))
(case "0" then  (assert (background-info(ratio-or-emo ?ratio-or-emo)(ratio-cf 0.0))))

      )
)       

(defrule which_sector
   => (printout t crlf "Can you give an indication of importance to the following sector:
Healthcare 
Possible answers (enter the number): 1 (totally not important) 2 (not really important) 3 (neutral) 4 (sort of important) 5 (very important) 
0 (don't know/care)" crlf) 
      (bind ?healthsector (read))
; because it is the first input, I need a ratio-cf here that is not a product but a statement
      (switch ?healthsector
(case "1" then  (assert (background-info(healthsector ?healthsector)(health-cf 0.5))))
(case "2" then  (assert (background-info(healthsector ?healthsector)(health-cf 0.3))))
(case "3" then  (assert (background-info(healthsector ?healthsector)(health-cf 0.1))))
(case "4" then  (assert (background-info(healthsector ?healthsector)(health-cf 0.3))))
(case "5" then  (assert (background-info(healthsector ?healthsector)(health-cf 0.5))))
(case "0" then  (assert (background-info(healthsector ?healthsector)(health-cf 0.0))))
      )
)  

 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; OUTCOME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule recommend_charity
	(declare (salience -10))
    (background-info(ratio-or-emo 1))
    (background-info(health-cf 0.5))
    (background-info(healthsector 1))
    => 
	(printout t "Our recommendation is as follows: YOU SHOULD BE ASHAMED OF YOURSELF" crlf)
)