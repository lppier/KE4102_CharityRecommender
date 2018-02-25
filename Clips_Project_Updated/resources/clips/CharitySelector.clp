;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Templates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Added by pier - UI-related
(deftemplate combined_value (slot fact) (slot cf))      ; test value to see whether combination fn was called
(deftemplate UI-state 
   ;(slot id (default-dynamic (gensym*)))               ; autogen id everytime UI-state is asserted
   (slot question (type STRING))                        ; question text
   (slot relation-asserted (default none))              ; eg. donation-type (used in UI code for finding facts to assert)
   (multislot valid-answers)                            ; symbols to denote each ans selection (eg. k m v)
   (multislot display-answers)                          ; text for each answer's display in UI
   (slot state (default interview))                     ; 3 states: greeting, interview (mostly here) and conclusion
   (slot is-multi-choice (default no))                    ; Whether question allows for multiple-choice 
)

(deftemplate current_fact (slot fact)
                (slot cf)
                (multislot all_vars) ;contains all applicable parameters.
)



(deftemplate current_goal (slot goal) (slot cf)) ;; the top-level
(deftemplate working_goal (slot goal) (slot cf)) ;; 
(deftemplate branch_indicator (slot name) (slot cf) (slot true_or_false))
(deftemplate recommendation (slot ngee_ann_cultural_centre_limited) 
							(slot singapore_indian_fine_arts_society_the) 
							(slot national_book_development_council_of_singapore_the) 
							(slot singapore_clan_foundation)
							(slot design_society_the)							
							(slot the_esplanade_co_ltd)
							(slot the_dance_company_ltd)
							(slot cake_theatrical_productions_ltd)
							(slot tampines_arts_troupe)
							(slot spot_art_limited)
							(slot radin_mas_ccc_community_development_and_welfare_fund)
							(slot kaki_bukit_ccc_community_development_and_welfare_fund)
							(slot kebun_baru_ccc_community_development_and_welfare_fund)
							(slot fengshan_ccc_community_development_and_welfare_fund)
							(slot bukit_batok_ccc_community_development_and_welfare_fund)
							(slot the_friends_of_the_university_of_warwick_in_singapore)
							(slot methodist_schools_foundation)
							(slot hwa_chong_international_school_education_fund)
							(slot girl_guides_singapore)
							(slot national_skin_centre_health_endowment_fund)
							(slot ren_ci_hospital)
							(slot sata_commhealth)
							(slot ronald_mcdonald_house_charities_singapore)
							(slot academy_of_medicine_singapore)
							(slot home_nursing_foundation)
							(slot assisi_hospice)
							(slot hca_hospice_care)
							(slot grace_lodge)
							(slot alzheimers_disease_association)
							(slot sma_charity_fund)
							(slot kidney_dialysis_foundation_limited)
							)
(deftemplate nameofvariable (slot name) (slot cf)(slot true_or_false))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Initial facts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffacts load-facts

	(current_fact (fact ngee_ann_cultural_centre_limited) (cf 0.5) (all_vars arts_and_heritage tax medium money historical_and_cultural_conservation exist_long invest_yes govfunded_yes sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
	(current_fact (fact singapore_indian_fine_arts_society_the) (cf 0.5) (all_vars arts_and_heritage tax medium money music_and_orchestras exist_medium invest_no govfunded_no sub_fin_no ratio_eff_med sub_gov_no gov_rate_med ))
	(current_fact (fact national_book_development_council_of_singapore_the) (cf 0.5) (all_vars arts_and_heritage notax medium money literary_arts exist_short invest_yes govfunded_yes sub_fin_not_req ratio_eff_high sub_gov_not_req gov_rate_high ))
	(current_fact (fact singapore_clan_foundation) (cf 0.5) (all_vars arts_and_heritage  medium money historical_and_cultural_conservation exist_long invest_no govfunded_no sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
	(current_fact (fact design_society_the) (cf 0.5) (all_vars arts_and_heritage notax small money others_arts_and_heritage exist_medium invest_yes govfunded_yes sub_fin_no ratio_eff_med sub_gov_no gov_rate_med ))
    (current_fact (fact the_esplanade_co_ltd) (cf 0.5) (all_vars arts_and_heritage notax large money music_and_orchestras exist_short invest_no govfunded_no sub_fin_not_req ratio_eff_high sub_gov_not_req gov_rate_high ))
    (current_fact (fact the_dance_company_ltd) (cf 0.5) (all_vars arts_and_heritage notax medium money professional_contemporay_ethnic exist_long invest_yes govfunded_yes sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
    (current_fact (fact cake_theatrical_productions_ltd) (cf 0.5) (all_vars arts_and_heritage tax medium money theatre_and_dramatic_arts exist_medium invest_no govfunded_no sub_fin_no ratio_eff_med sub_gov_no gov_rate_med ))
    (current_fact (fact tampines_arts_troupe) (cf 0.5) (all_vars arts_and_heritage notax small money traditional_ethnic_performing_arts exist_short invest_yes govfunded_yes sub_fin_not_req ratio_eff_high sub_gov_not_req gov_rate_high ))
    (current_fact (fact spot_art_limited) (cf 0.5) (all_vars arts_and_heritage tax small money visual_arts exist_long invest_no govfunded_no sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
    (current_fact (fact radin_mas_ccc_community_development_and_welfare_fund) (cf 0.5) (all_vars community notax medium money central exist_medium invest_yes govfunded_yes sub_fin_no ratio_eff_med sub_gov_no gov_rate_med ))
    (current_fact (fact kaki_bukit_ccc_community_development_and_welfare_fund) (cf 0.5) (all_vars community notax medium money north_east exist_short invest_no govfunded_no sub_fin_not_req ratio_eff_high sub_gov_not_req gov_rate_high ))
    (current_fact (fact kebun_baru_ccc_community_development_and_welfare_fund) (cf 0.5) (all_vars community notax small money north_west exist_long invest_yes govfunded_yes sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
    (current_fact (fact fengshan_ccc_community_development_and_welfare_fund) (cf 0.5) (all_vars community notax small money south_east exist_medium invest_no govfunded_no sub_fin_no ratio_eff_med sub_gov_no gov_rate_med ))
    (current_fact (fact bukit_batok_ccc_community_development_and_welfare_fund) (cf 0.5) (all_vars community notax medium money south_west exist_short invest_yes govfunded_yes sub_fin_not_req ratio_eff_high sub_gov_not_req gov_rate_high ))
    (current_fact (fact the_friends_of_the_university_of_warwick_in_singapore) (cf 0.5) (all_vars education notax small money foreign_educational_institutions_and_funds exist_long invest_no govfunded_no sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
    (current_fact (fact methodist_schools_foundation) (cf 0.5) (all_vars education notax medium money foundations_and_trusts exist_long invest_yes govfunded_yes sub_fin_no ratio_eff_med sub_gov_no gov_rate_med ))
    (current_fact (fact hwa_chong_international_school_education_fund) (cf 0.5) (all_vars education notax small money local_educational_institutions_and_funds exist_medium invest_no govfunded_no sub_fin_not_req ratio_eff_high sub_gov_not_req gov_rate_high ))
    (current_fact (fact girl_guides_singapore) (cf 0.5) (all_vars education notax medium money uniformed_groups exist_short invest_yes govfunded_yes sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
    (current_fact (fact national_skin_centre_health_endowment_fund) (cf 0.5) (all_vars health notax small money cluster_and_hospital_funds exist_long invest_no govfunded_no sub_fin_no ratio_eff_med sub_gov_no gov_rate_med ))
    (current_fact (fact ren_ci_hospital) (cf 0.5) (all_vars health notax large money community_and_chronic_sick_hospital exist_medium invest_yes govfunded_yes sub_fin_not_req ratio_eff_high sub_gov_not_req gov_rate_high ))
    (current_fact (fact sata_commhealth) (cf 0.5) (all_vars health tax large money day_rehabilitation_centre exist_short invest_no govfunded_no sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
    (current_fact (fact ronald_mcdonald_house_charities_singapore) (cf 0.5) (all_vars health tax medium money diseases_and_illnessess_support_group exist_long invest_yes govfunded_yes sub_fin_no ratio_eff_med sub_gov_no gov_rate_med ))
    (current_fact (fact academy_of_medicine_singapore) (cf 0.5) (all_vars health notax large money health_professional_group exist_medium invest_no govfunded_no sub_fin_not_req ratio_eff_high sub_gov_not_req gov_rate_high ))
    (current_fact (fact home_nursing_foundation) (cf 0.5) (all_vars health notax large money home_care exist_short invest_yes govfunded_yes sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
    (current_fact (fact assisi_hospice) (cf 0.5) (all_vars health notax large money hospice exist_long invest_no govfunded_no sub_fin_no ratio_eff_med sub_gov_no gov_rate_med ))
    (current_fact (fact hca_hospice_care) (cf 0.5) (all_vars health notax large money palliative_home_care exist_medium invest_yes govfunded_yes sub_fin_not_req ratio_eff_high sub_gov_not_req gov_rate_high ))
    (current_fact (fact grace_lodge) (cf 0.5) (all_vars health notax large money nursing_home exist_short invest_no govfunded_no sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
    (current_fact (fact alzheimers_disease_association) (cf 0.5) (all_vars health notax large money other_community_based_services exist_long invest_yes govfunded_yes sub_fin_no ratio_eff_med sub_gov_no gov_rate_med ))
    (current_fact (fact sma_charity_fund) (cf 0.5) (all_vars health notax small money others_health exist_medium invest_no govfunded_no sub_fin_not_req ratio_eff_high sub_gov_not_req gov_rate_high ))
    (current_fact (fact kidney_dialysis_foundation_limited) (cf 0.5) (all_vars health notax large money renal_dialysis exist_short invest_yes govfunded_yes sub_fin_yes ratio_eff_low sub_gov_yes gov_rating_low ))
;Current Goals are listed here.
	(current_goal (goal ngee_ann_cultural_centre_limited) (cf 0.5))
	(current_goal (goal singapore_indian_fine_arts_society_the) (cf 0.5))
	(current_goal (goal national_book_development_council_of_singapore_the) (cf 0.5))
	(current_goal (goal singapore_clan_foundation) (cf 0.5))
	(current_goal (goal design_society_the) (cf 0.5))
	(current_goal (goal the_esplanade_co_ltd) (cf 0.5))
	(current_goal (goal the_dance_company_ltd) (cf 0.5))
	(current_goal (goal cake_theatrical_productions_ltd) (cf 0.5))
	(current_goal (goal tampines_arts_troupe) (cf 0.5))
	(current_goal (goal spot_art_limited) (cf 0.5))
	(current_goal (goal radin_mas_ccc_community_development_and_welfare_fund) (cf 0.5))
	(current_goal (goal kaki_bukit_ccc_community_development_and_welfare_fund) (cf 0.5))
	(current_goal (goal kebun_baru_ccc_community_development_and_welfare_fund) (cf 0.5))
	(current_goal (goal fengshan_ccc_community_development_and_welfare_fund) (cf 0.5))
	(current_goal (goal bukit_batok_ccc_community_development_and_welfare_fund) (cf 0.5))
	(current_goal (goal the_friends_of_the_university_of_warwick_in_singapore) (cf 0.5))
	(current_goal (goal methodist_schools_foundation) (cf 0.5))
	(current_goal (goal hwa_chong_international_school_education_fund) (cf 0.5))
	(current_goal (goal girl_guides_singapore) (cf 0.5))
	(current_goal (goal national_skin_centre_health_endowment_fund) (cf 0.5))
	(current_goal (goal ren_ci_hospital) (cf 0.5))
	(current_goal (goal sata_commhealth) (cf 0.5))
	(current_goal (goal ronald_mcdonald_house_charities_singapore) (cf 0.5))
	(current_goal (goal academy_of_medicine_singapore) (cf 0.5))
	(current_goal (goal home_nursing_foundation) (cf 0.5))
	(current_goal (goal assisi_hospice) (cf 0.5))
	(current_goal (goal hca_hospice_care) (cf 0.5))
	(current_goal (goal grace_lodge) (cf 0.5))
	(current_goal (goal alzheimers_disease_association) (cf 0.5))
	(current_goal (goal sma_charity_fund) (cf 0.5))
	(current_goal (goal kidney_dialysis_foundation_limited) (cf 0.5))
    (branch_indicator (name only_kind_or_time) (true_or_false UNKNOWN))

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
; (working_goal (goal ?ng) (cf ?cfng))
; (not (current_goal (goal ?cg) (cf ?cfg)))
; ?newg <- (working_goal (goal ?ng) (cf ?cfng))
;=>   (assert (current_goal (goal ?ng) (cf ?cfng)))
; (retract ?newg)
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
                (question "Welcome to Give@SG! We will recommend a list of charities based on your preference.")
                (relation-asserted greeting)
                (valid-answers y)
                (display-answers "Yes")
                (state greeting)
                (is-multi-choice no)
            )
    )
    (retract ?fci)
    ;(retract ?fcq)
    (modify ?fcq (current_question donation_type))
    ;(assert (current_question donation_type))
    
)        


(defrule corporate_or_individual
    (continue_interview)
    (current_question corporate_or_individual)

    ; 1. You need an indicator for starting + CLIPS does not let you change this if you don't put it into a variable:
    ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
            ?fci <- (continue_interview)
            ?fcq <- (current_question ?f)
    =>
      (retract ?f1)
      (assert (UI-state
                  (question "Are you donating as an individual or corporation?")
                  (relation-asserted corporate_or_individual)
                  (valid-answers i c)
                  (display-answers "Individual" "Corporate")
                  (state interview)
                  (is-multi-choice no)
              )
      )
  (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
    (retract ?fcq)
)

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
                  (state interview)
                  (is-multi-choice no)
              )
      )
  (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
    (retract ?fcq)
)

;**** Rules for branching corporate/individual donations
(defrule donation_from_corporate
  (corporate)
  (or (donation_type_money)
      (donation_type_volunteering)
      (donation_type_kind)
  )
  =>
  (assert (current_question tax_exemption))
)

(defrule donation_from_individual_money
  (individual)
  (donation_type_money)
  =>
  (assert (current_question tax_exemption))
)

(defrule donation_from_individual_kind_volunteering
  (individual)
  (or (donation_type_volunteering)
      (donation_type_kind)
  )
  =>
  (assert (current_question charity_size))
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
                (question "Do you want tax exemption for your donation?")
                (relation-asserted tax_exemption)
                (valid-answers y n)
                (display-answers "Yes" "No")
                (state interview)
                (is-multi-choice no)
            )
    )
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
=>   (retract ?f1)
     (assert (UI-state
                (question "Do you like small, midsize or large charity?")
                (relation-asserted charity_size)
                (valid-answers small medium large)
                (display-answers "Small" "Medium" "Large")
                (state interview)
                (is-multi-choice no)
              )
     )
     (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
     (retract ?fcq)
)

(defrule charity_investment
    (continue_interview)
    (current_question charity_investment)
     ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
     ?fci <- (continue_interview)
     ?fcq <- (current_question ?f)
=>   (retract ?f1)
     (assert (UI-state
                (question "Do you prefer to donate to charities which invest for profit?")
                (relation-asserted charity_investment)
                (valid-answers y n)
                (display-answers "Yes" "No")
                (state interview)
                (is-multi-choice no)
              )
     )
     (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
     (retract ?fcq)
)

(defrule charity_gov_funded
    (continue_interview)
    (current_question charity_gov_funded)
     ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
     ?fci <- (continue_interview)
     ?fcq <- (current_question ?f)
=>   (retract ?f1)
     (assert (UI-state
                (question "Do you prefer to donate to charities which are Government funded?")
                (relation-asserted charity_gov_funded)
                (valid-answers y n)
                (display-answers "Yes" "No")
                (state interview)
                (is-multi-choice no)
              )
     )
     (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
     (retract ?fcq)
)

(defrule charity_fin_eff
    (continue_interview)
    (current_question charity_fin_eff)
     ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
     ?fci <- (continue_interview)
     ?fcq <- (current_question ?f)
=>   (retract ?f1)
     (assert (UI-state
                (question "How financially efficient the charity should be?")
                (relation-asserted charity_fin_eff)
                (valid-answers l m h)
                (display-answers "Low" "Medium" "High")
                (state interview)
                (is-multi-choice no)
              )
     )
     (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
     (retract ?fcq)
)

(defrule charity_gov_compl
    (continue_interview)
    (current_question charity_gov_compl)
     ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
     ?fci <- (continue_interview)
     ?fcq <- (current_question ?f)
=>   (retract ?f1)
     (assert (UI-state
                (question "Do you prefer to donate to charities which submitted the Charities' code of compliance?")
                (relation-asserted charity_gov_compl)
                (valid-answers y n)
                (display-answers "Yes" "No")
                (state interview)
                (is-multi-choice no)
              )
     )
     (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
     (retract ?fcq)
)

(defrule religion
    (continue_interview)
    (current_question religion)
     ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
     ?fci <- (continue_interview)
     ?fcq <- (current_question ?f)
=>   (retract ?f1)
     (assert  (UI-state
                (question "What religion do you practice?")
                (relation-asserted religion)
                (valid-answers b c h i t o)
                (display-answers "Buddhism" "Christianity" "Hinduism" "Islam" "Taoism" "Others")
                (state interview)
                (is-multi-choice no)
              )
     )
     (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
     (retract ?fcq)
)

(defrule sector_preference
    (continue_interview)
    (current_question sector_preference)
     ?f1 <- (UI-state (question ?q)(relation-asserted ?ra)(valid-answers ?va)(display-answers ?da) (state ?s))
     ?fci <- (continue_interview)
     ?fcq <- (current_question ?f)
=>   (retract ?f1)
     (assert (UI-state
                (question "Which of the following sectors are you interested in giving to?")
                (relation-asserted sector_preference)
                (valid-answers a c e h r sw sp o)
                (display-answers "Arts and Heritage" "Community" "Education" "Health" "Religious" "Social and Welfare" "Sports" "Others")
                (state interview)
                (is-multi-choice yes)
              )
     )
     (retract ?fci) ; don't continue interview unless UI says so (UI will assert continue-interview on next button clicked)
     (retract ?fcq)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ENGINE RULE (RULE THAT SELECTS THE RIGHT CHARITIES AND ADJUSTS THEIR CF)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule selecting_the_right_charities
    (declare (salience 10))
    ;1. branch ind is the name variable of the current variable which true_or_false is set to TRUE.
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
  (current_goal (goal ngee_ann_cultural_centre_limited) (cf ?cf-ngee_ann_cultural_centre_limited))
  (current_goal (goal singapore_indian_fine_arts_society_the) (cf ?cf-singapore_indian_fine_arts_society_the))
  (current_goal (goal national_book_development_council_of_singapore_the) (cf ?cf-national_book_development_council_of_singapore_the))
  (current_goal (goal singapore_clan_foundation) (cf ?cf-singapore_clan_foundation))
  (current_goal (goal design_society_the) (cf ?cf-design_society_the))
  (current_goal (goal the_esplanade_co_ltd) (cf ?cf-the_esplanade_co_ltd))
  (current_goal (goal the_dance_company_ltd) (cf ?cf-the_dance_company_ltd))
  (current_goal (goal cake_theatrical_productions_ltd) (cf ?cf-cake_theatrical_productions_ltd))
  (current_goal (goal tampines_arts_troupe) (cf ?cf-tampines_arts_troupe))
  (current_goal (goal spot_art_limited) (cf ?cf-spot_art_limited))
  (current_goal (goal radin_mas_ccc_community_development_and_welfare_fund) (cf ?cf-radin_mas_ccc_community_development_and_welfare_fund))
  (current_goal (goal kaki_bukit_ccc_community_development_and_welfare_fund) (cf ?cf-kaki_bukit_ccc_community_development_and_welfare_fund))
  (current_goal (goal kebun_baru_ccc_community_development_and_welfare_fund) (cf ?cf-kebun_baru_ccc_community_development_and_welfare_fund))
  (current_goal (goal fengshan_ccc_community_development_and_welfare_fund) (cf ?cf-fengshan_ccc_community_development_and_welfare_fund))
  (current_goal (goal bukit_batok_ccc_community_development_and_welfare_fund) (cf ?cf-bukit_batok_ccc_community_development_and_welfare_fund))
  (current_goal (goal the_friends_of_the_university_of_warwick_in_singapore) (cf ?cf-the_friends_of_the_university_of_warwick_in_singapore))
  (current_goal (goal methodist_schools_foundation) (cf ?cf-methodist_schools_foundation))
  (current_goal (goal hwa_chong_international_school_education_fund) (cf ?cf-hwa_chong_international_school_education_fund))
  (current_goal (goal girl_guides_singapore) (cf ?cf-girl_guides_singapore))
  (current_goal (goal national_skin_centre_health_endowment_fund) (cf ?cf-national_skin_centre_health_endowment_fund))
  (current_goal (goal ren_ci_hospital) (cf ?cf-ren_ci_hospital))
  (current_goal (goal sata_commhealth) (cf ?cf-sata_commhealth))
  (current_goal (goal ronald_mcdonald_house_charities_singapore) (cf ?cf-ronald_mcdonald_house_charities_singapore))
  (current_goal (goal academy_of_medicine_singapore) (cf ?cf-academy_of_medicine_singapore))
  (current_goal (goal home_nursing_foundation) (cf ?cf-home_nursing_foundation))
  (current_goal (goal assisi_hospice) (cf ?cf-assisi_hospice))
  (current_goal (goal hca_hospice_care) (cf ?cf-hca_hospice_care))
  (current_goal (goal grace_lodge) (cf ?cf-grace_lodge))
  (current_goal (goal alzheimers_disease_association) (cf ?cf-alzheimers_disease_association))
  (current_goal (goal sma_charity_fund) (cf ?cf-sma_charity_fund))
  (current_goal (goal kidney_dialysis_foundation_limited) (cf ?cf-kidney_dialysis_foundation_limited))
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
)

