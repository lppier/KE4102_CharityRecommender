;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For easier understanding use:
;; the (watch all) command 
;; the agenda function in IDE. 
;; I commented the final salience so you can see easily what happens for every question
;; use the printout from the cf rules to see the output
;; comments with stars (*) are only for improvement, not for understanding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Ideas:
;; Rationality will influence the type of questions rather than the charities
;; Age will be a combined rule --> see rule 4 of the pet recommender
;; Make use of global variables for more complexity
;; Try to get likert scales in global variables and use them to multiply with the 
;;   cf of a certain variable to get likert scales
;; I think we should not mess with current_fact cf, as this will increase both 
;;   negative as well as positive indicators (makes no sense to make this larger
;;   for one charity)
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
(deftemplate numbersector (slot health) (slot education) (slot educationsecond) (slot community) (slot arts) (slot artssecond) (slot other))
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
;(defglobal ?*age*=0)

;Loading the facts now
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
	;(branch_indicator (name char_size) (true_or_false TRUE))
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

;**** Rule8: Ask if want tax
(defrule tax
    (branch_indicator (name only_kind_or_time) (true_or_false FALSE))	
=>	(printout t crlf "Do you like your tax returned? (y/n)") 
    (bind ?response (read))
; *Create a name variable as input for the next function --> can become a modify!
    (if (eq ?response y) then 
        (assert (nameofvariable (name notax)(cf -1)(true_or_false TRUE)))
; *change this in a version that acknowledges a bad answer like above (switch)
    else
        (assert (nameofvariable (name notax)(cf 0.1)(true_or_false TRUE)))
	)
)


;**** Rule15: Ask for charity size 
(defrule charity_size
=>	(printout t crlf "Do you prefer small, midsize or large charities? (s/m/l)") 
	(bind ?response (read))
	(switch ?response
; *edit true_or_false to something more intelligable --> run_engine_rule
		(case s then (assert (nameofvariable (name small)(cf 0.3)(true_or_false TRUE))))
		(case m then 	(assert (nameofvariable (name medium)(cf 0.3)(true_or_false TRUE))))
		(case l then 	(assert (nameofvariable (name large)(cf 0.3)(true_or_false TRUE))))
	)
)

;**** Rule9:  prefer to donate to charities which invest 
(defrule charity_investment
=>	(printout t crlf "Do you prefer to donate to charities which invest for profit? (y/n)") 
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name invest_yes)(cf 0.7)(true_or_false TRUE)))
    else
        (assert (nameofvariable (name invest_yes)(cf -0.7)(true_or_false TRUE)))
		(assert (nameofvariable (name invest_no)(cf 0.7)(true_or_false TRUE)))
	)
)

;**** Rule10:  preference for Government funded charities CF value as per doc 1 
(defrule charity_gov_funded
=>	(printout t crlf "Do you prefer to donate to charities which are Government funded? (y/n)") 
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name govfunded_yes)(cf 1)(true_or_false TRUE)))
		(assert (nameofvariable (name govfunded_no)(cf -0.3)(true_or_false TRUE)))
    else
        (assert (nameofvariable (name govfunded_yes)(cf -0.4)(true_or_false TRUE)))
		
	)
)

;**** Rule11:  preference for financially efficient charities 
(defrule charity_fin_eff
=>	(printout t crlf "How financially efficient the charity should be? (l/m/h)") 
	(bind ?response (read))
	(switch ?response
		(case l then (assert (nameofvariable (name ratio_eff_low)(cf 0.4)(true_or_false TRUE))))
		(case m then 	(assert (nameofvariable (name ratio_eff_med)(cf 0.5)(true_or_false TRUE))))
		(case h then 	(assert (nameofvariable (name ratio_eff_high)(cf 0.8)(true_or_false TRUE))))
	)
)

;**** Rule13:  preference for charities which submitted compliance 
(defrule charity_gov_compl
=>	(printout t crlf "Do you prefer to donate to charities which submitted code of compliance? (y/n)") 
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name sub_gov_yes)(cf 1)(true_or_false TRUE)))
		(assert (nameofvariable (name sub_gov_no)(cf -0.1)(true_or_false TRUE)))
		(assert (nameofvariable (name sub_gov_not_req)(cf -0.1)(true_or_false TRUE)))
		
    else
        (assert (nameofvariable (name sub_gov_yes)(cf -0.4)(true_or_false TRUE)))
		
	)
)

;**** Rule17:  Likely to do own research before making decision(likert scale)Please check the logic..I am not sure of the logic..
(defrule charity_research
=>	(printout t crlf "I like to do my own extensive research before making decision (-1/-0.5/0/0.5/1)") 
	(bind ?response (read))
	(switch ?response
		(case -1 then   (assert (nameofvariable (name ratio_eff_low)(cf 0.3)(true_or_false TRUE)))
					    (assert (nameofvariable (name sub_gov_no)(cf 0.3)(true_or_false TRUE)))
						(assert (nameofvariable (name gov_rating_low)(cf 0.3)(true_or_false TRUE))))
		(case -0.5 then (assert (nameofvariable (name ratio_eff_low)(cf 0.2)(true_or_false TRUE)))
		                (assert (nameofvariable (name sub_gov_not_req)(cf 0.2)(true_or_false TRUE)))
						(assert (nameofvariable (name gov_rating_low)(cf 0.2)(true_or_false TRUE)))
		)
		(case 0 then 	(assert (nameofvariable (name ratio_eff_med)(cf 0.1)(true_or_false TRUE)))
		                (assert (nameofvariable (name sub_gov_not_req)(cf 0.1)(true_or_false TRUE)))
						(assert (nameofvariable (name gov_rate_med)(cf 0.1)(true_or_false TRUE)))
		)
		(case 0.5 then 	(assert (nameofvariable (name ratio_eff_high)(cf 0.5)(true_or_false TRUE)))
		                (assert (nameofvariable (name sub_gov_not_req)(cf 0.5)(true_or_false TRUE)))
						(assert (nameofvariable (name gov_rate_med)(cf 0.5)(true_or_false TRUE)))
		)
		(case 1 then 	(assert (nameofvariable (name ratio_eff_high)(cf 0.8)(true_or_false TRUE)))
		                (assert (nameofvariable (name sub_gov_yes)(cf 0.8)(true_or_false TRUE)))
						(assert (nameofvariable (name gov_rate_high)(cf 0.8)(true_or_false TRUE)))
		)
	)
)

;**** Rule11:  preference for number of years charity is established
(defrule charity_established
=>	(printout t crlf "How likely do you consider the age of the charity when you donate to charity? (-1/0/1)") 
	(bind ?response (read))
	(switch ?response
		(case -1 then (assert (nameofvariable (name exist_short)(cf 0.5)(true_or_false TRUE))))
		(case 0 then 	(assert (nameofvariable (name exist_medium)(cf 0.6)(true_or_false TRUE))))
		(case 1 then 	(assert (nameofvariable (name exist_long)(cf 0.7)(true_or_false TRUE))))
	)
)

;**** Rule:  Do you mind donating to charities that have checkered past(variable not clear)
(defrule charity_past
=>	(printout t crlf "Do you mind donating to charities that have checkered past? (y/n)") 
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name ratio_eff_low)(cf 0.5)(true_or_false TRUE)))
		(assert (nameofvariable (name sub_gov_no)(cf  0.5)(true_or_false TRUE)))
		(assert (nameofvariable (name gov_rating_low)(cf 0.5)(true_or_false TRUE)))
		
    else
		(assert (nameofvariable (name ratio_eff_low)(cf -0.5)(true_or_false TRUE)))
		(assert (nameofvariable (name sub_gov_no)(cf  -0.5)(true_or_false TRUE)))
		(assert (nameofvariable (name gov_rating_low)(cf -0.5)(true_or_false TRUE)))
	)
)

;**** Rule2:  Sectors parents donate to 
(defrule charity_parents_sector
=>	(printout t crlf "Please choose the type of the charity to which your parents donate to.(Please enter the option number)")
    (printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.7)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.7)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.7)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.7)(true_or_false TRUE))))
		(case 5 then 	(assert (nameofvariable (name arts_and_heritage)(cf 0.5)(true_or_false TRUE)))
	                    (assert (nameofvariable (name education)(cf 0.5)(true_or_false TRUE)))
                        (assert (nameofvariable (name health)(cf 0.5)(true_or_false TRUE)))
                        (assert (nameofvariable (name community)(cf 0.5)(true_or_false TRUE))))
	)
)

;(defrule input_age
;=>	(printout t crlf "Please enter your age.")
;    (bind ?*age* (read))
;	 
;)

;**** Rule3:  sectors friends donate to and user age(considering their age >12 need to add code to check  age
(defrule charity_friends_Sector
=>	(printout t crlf "Please choose the type of the charity to which your friends donate to.(Please enter the option number)")
    (printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.6)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE))))
	)
)

;**** Rule21:  Influence of spouse Sectors spouse donate to 
(defrule charity_spouse
=>	(printout t crlf "Please choose the type of the charity to which your spouse donate to.(Please enter the option number)")
    (printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.None of the above " crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.8)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.8)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.8)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.8)(true_or_false TRUE))))
		(case 5 then 	(assert (nameofvariable (name arts_and_heritage)(cf 0)(true_or_false TRUE)))
	                    (assert (nameofvariable (name education)(cf 0)(true_or_false TRUE)))
                        (assert (nameofvariable (name health)(cf 0)(true_or_false TRUE)))
                        (assert (nameofvariable (name community)(cf 0)(true_or_false TRUE))))
	)
)

;**** Rule22:  Received Help earlier
(defrule charity_received_help
=>	(printout t crlf "Which of the following type of charities helped you in past? (Please enter the option number)") 
	(printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.None of the above " crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.5)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.5)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.5)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.5)(true_or_false TRUE))))
		(case 5 then 	(assert (nameofvariable (name arts_and_heritage)(cf -0.1)(true_or_false TRUE)))
	                    (assert (nameofvariable (name education)(cf -0.1)(true_or_false TRUE)))
                        (assert (nameofvariable (name health)(cf -0.1)(true_or_false TRUE)))
                        (assert (nameofvariable (name community)(cf -0.1)(true_or_false TRUE))))
	)
)

;**** Rule35:  Influence of positive public figure
(defrule charity_influence
=>	(printout t crlf "In which sectors do the your idol(influential) donate to?  (Please enter the option number)") 
	(printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.None of the above " crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.4)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.4)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.4)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.4)(true_or_false TRUE))))
		(case 5 then 	(assert (nameofvariable (name arts_and_heritage)(cf -0.1)(true_or_false TRUE)))
	                    (assert (nameofvariable (name education)(cf -0.1)(true_or_false TRUE)))
                        (assert (nameofvariable (name health)(cf -0.1)(true_or_false TRUE)))
                        (assert (nameofvariable (name community)(cf -0.1)(true_or_false TRUE))))
	)
)

;**** Rule16:  choice of Sector
(defrule charity_choice
; for debugging purposes, I put salience in so this one will fire first.
    (declare (salience 99))
=>(printout t crlf "Would you like to donate to arts (type in 'Y' OR 'N')")
  (bind ?response1 (read))
  (printout t crlf "Would you like to donate to education (type in 'Y' OR 'N')")
  (bind ?response2 (read))
  (printout t crlf "Would you like to donate to community (type in 'Y' OR 'N')")
  (bind ?response3 (read))
  (printout t crlf "Would you like to donate to health (type in 'Y' OR 'N')")
  (bind ?response4 (read))
  ; (bind ?response5 (read))
  (if (eq ?response1 Y) then 
    (assert (nameofvariable (name arts_and_heritage)(cf 0.5)(true_or_false TRUE)))
    (assert (numbersector (arts TRUE)))
  else (printout t crlf "arts won't be adjusted"))
  (if (eq ?response2 Y) then 
    (assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE)))
    (assert (numbersector (education TRUE)))
    else (printout t crlf "arts won't be adjusted"))
 (if (eq ?response3 Y) then 
    (assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE)))
    (assert (numbersector (community TRUE)))
    else (printout t crlf "arts won't be adjusted"))
  (if (eq ?response4 Y) then 
    (assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE)))
    (assert (numbersector (health TRUE)))
    else (printout t crlf "arts won't be adjusted"))
)

(defrule charity_arts_subsector1
  (numbersector (arts TRUE))
=>  (printout t crlf "In which kind of arts1 would you like to donate?  (Please enter the option number)") 
  (printout t crlf "1.")
  (printout t crlf "2.")
  (printout t crlf "3.")
  (printout t crlf "4.")
  (printout t crlf "5.Other " crlf)
  (printout t crlf "6.Don't care " crlf)
  (bind ?response (read))
  (switch ?response
    ; 1. change this (secondarts) into relevant all_vars variables---> note that you can only use each variable in 
    ; all_vars ONCE --> cannot use the same subset/name twice or it does not trigger the engine rule!
    ; (can be solved in clips using modify command, but will not work in JAVA, so I chose the ugly solution)
    (case 1 then  (assert (nameofvariable (name secondarts_and_heritage)(cf 0.6)(true_or_false TRUE)))
    (assert (numbersector (artssecond TRUE))))
    (case 2 then  (assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE))))
    (case 3 then  (assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE))))
    (case 4 then  (assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE))))
    (case 5 then  (assert (nameofvariable (name other)(cf -0.1)(true_or_false TRUE)))    
  )
)
)


(defrule charity_arts_subsector2
  (numbersector (artssecond TRUE))
=>  (printout t crlf "In which kind of arts2 would you like to donate?  (Please enter the option number)") 
  (printout t crlf "1.")
  (printout t crlf "2.")
  (printout t crlf "3.")
  (printout t crlf "4.")
  (printout t crlf "5.Other " crlf)
  (printout t crlf "6.Don't care " crlf)
  (bind ?response (read))
  (switch ?response
    ; change this into relevant all_vars variables
    (case 1 then  (assert (nameofvariable (name thirdarts_and_heritage)(cf 0.6)(true_or_false TRUE))))
    (case 2 then  (assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE))))
    (case 3 then  (assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE))))
    (case 4 then  (assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE))))
    (case 5 then  (assert (nameofvariable (name other)(cf -0.1)(true_or_false TRUE)))    
  )
)
)


(defrule charity_education_subsector1
  (numbersector (education TRUE))
=>  (printout t crlf "In which kind of education would you like to donate?  (Please enter the option number)") 
  (printout t crlf "1.")
  (printout t crlf "2.")
  (printout t crlf "3.")
  (printout t crlf "4.")
  (printout t crlf "5.Other " crlf)
  (printout t crlf "6.Don't care " crlf)
  (bind ?response (read))
  (switch ?response
    ; change this into relevant all_vars variables
    (case 1 then  (assert (nameofvariable (name secondarts_and_heritage)(cf 0.6)(true_or_false TRUE))))
    ; if you need a second question:
;    (assert (numbersector (educationsecond TRUE))))
    (case 2 then  (assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE))))
    (case 3 then  (assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE))))
    (case 4 then  (assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE))))
    (case 5 then  (assert (nameofvariable (name other)(cf -0.1)(true_or_false TRUE)))    
  )
)
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ENGINE RULE (RULE THAT SELECTS THE RIGHT CHARITIES AND ADJUSTS THEIR CF)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule selecting_the_right_charities
    ; *for the time being I kept salience in --> to make sure it doesn't go to the next question after this:
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
; *To keep in mind: if you remove this salience and use branch indicators and assert 
; them after you make a new working_goal, the next question will fire before the 
; combination black box (conflict resolution --> newest rule wins)
  (declare (salience 2))
  ?f1 <- (current_goal (goal ?g)(cf ?cf1&:(>= ?cf1 0)))
  ?f2 <- (working_goal (goal ?g)(cf ?cf2&:(>= ?cf2 0)))
  (test (neq ?f1 ?f2)) ; test pointers and not value
  =>
  (retract ?f2)
  (modify ?f1 (cf =(+ ?cf1 (* ?cf2 (- 1 ?cf1)))))
; *I use these print outs to get a better understanding, but feel free to remove them
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; final print out function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;**** Print out the final results
;** this is not an elegant way to program - imagine if you have 30 current_goals!
;* also note the output is not sorted by CF

;I've deleted the salience to create some information in between
(defrule compile_recommendations
; you can comment the salience to get an easy insight in what it does
	;(declare (salience -10))
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
=>	(assert (recommendation (ngee_ann_cultural_centre_limited ?cf-ngee_ann_cultural_centre_limited) 
							(singapore_indian_fine_arts_society_the ?cf-singapore_indian_fine_arts_society_the) 
							(national_book_development_council_of_singapore_the ?cf-national_book_development_council_of_singapore_the) 
							(singapore_clan_foundation ?cf-singapore_clan_foundation) 
							(design_society_the ?cf-design_society_the)
							(the_esplanade_co_ltd ?cf-the_esplanade_co_ltd)
							(the_dance_company_ltd ?cf-the_dance_company_ltd)
							(cake_theatrical_productions_ltd ?cf-cake_theatrical_productions_ltd)
							(tampines_arts_troupe ?cf-tampines_arts_troupe)
							(spot_art_limited ?cf-spot_art_limited)
							(radin_mas_ccc_community_development_and_welfare_fund ?cf-radin_mas_ccc_community_development_and_welfare_fund)
							(kaki_bukit_ccc_community_development_and_welfare_fund ?cf-kaki_bukit_ccc_community_development_and_welfare_fund)
							(kebun_baru_ccc_community_development_and_welfare_fund ?cf-kebun_baru_ccc_community_development_and_welfare_fund)
							(fengshan_ccc_community_development_and_welfare_fund ?cf-fengshan_ccc_community_development_and_welfare_fund)
							(bukit_batok_ccc_community_development_and_welfare_fund ?cf-bukit_batok_ccc_community_development_and_welfare_fund)
							(the_friends_of_the_university_of_warwick_in_singapore ?cf-the_friends_of_the_university_of_warwick_in_singapore)
							(methodist_schools_foundation ?cf-methodist_schools_foundation)
							(hwa_chong_international_school_education_fund ?cf-hwa_chong_international_school_education_fund)
							(girl_guides_singapore ?cf-girl_guides_singapore)
							(national_skin_centre_health_endowment_fund ?cf-national_skin_centre_health_endowment_fund)
							(ren_ci_hospital ?cf-ren_ci_hospital)
							(sata_commhealth ?cf-sata_commhealth)
							(ronald_mcdonald_house_charities_singapore ?cf-ronald_mcdonald_house_charities_singapore)
							(academy_of_medicine_singapore ?cf-academy_of_medicine_singapore)
							(home_nursing_foundation ?cf-home_nursing_foundation)
							(assisi_hospice ?cf-assisi_hospice)
							(hca_hospice_care ?cf-hca_hospice_care)
							(grace_lodge ?cf-grace_lodge)
							(alzheimers_disease_association ?cf-alzheimers_disease_association)
							(sma_charity_fund ?cf-sma_charity_fund)
							(kidney_dialysis_foundation_limited ?cf-kidney_dialysis_foundation_limited)
							))
	(printout t crlf "Our recommendation is (currently) as follows :")
	(printout t crlf "ngee ann cultural centre limited: " (integer (* ?cf-ngee_ann_cultural_centre_limited 100)) "%")
	(printout t crlf "singapore indian fine arts society the   : " (integer (* ?cf-singapore_indian_fine_arts_society_the 100)) "%")
	(printout t crlf "national book development council of singapore the   : " (integer (* ?cf-national_book_development_council_of_singapore_the 100)) "%")
	(printout t crlf "singapore clan foundation    : " (integer (* ?cf-singapore_clan_foundation 100)) "%")
	(printout t crlf "design society the    : " (integer (* ?cf-design_society_the 100)) "%" )
	(printout t crlf "the esplanade co ltd    : " (integer (* ?cf-the_esplanade_co_ltd 100)) "%" )
	(printout t crlf "the dance company ltd    : " (integer (* ?cf-the_dance_company_ltd 100)) "%" )
	(printout t crlf "cake theatrical productions ltd    : " (integer (* ?cf-cake_theatrical_productions_ltd 100)) "%" )
	(printout t crlf "tampines arts troupe    : " (integer (* ?cf-tampines_arts_troupe 100)) "%" )
	(printout t crlf "spot art limited    : " (integer (* ?cf-spot_art_limited 100)) "%" )
	(printout t crlf "radin mas ccc community development and welfare fund    : " (integer (* ?cf-radin_mas_ccc_community_development_and_welfare_fund 100)) "%" )
	(printout t crlf "kaki bukit ccc community development and welfare_fund    : " (integer (* ?cf-kaki_bukit_ccc_community_development_and_welfare_fund 100)) "%" )
	(printout t crlf "kebun baru ccc community development and welfare_fund    : " (integer (* ?cf-kebun_baru_ccc_community_development_and_welfare_fund 100)) "%" )
	(printout t crlf "fengshan_ccc_community_development_and_welfare_fund    : " (integer (* ?cf-fengshan_ccc_community_development_and_welfare_fund 100)) "%" )
	(printout t crlf "bukit batok_ccc community development and welfare fund    : " (integer (* ?cf-bukit_batok_ccc_community_development_and_welfare_fund 100)) "%" )
	(printout t crlf "the friends of the university of warwick in singapore    : " (integer (* ?cf-the_friends_of_the_university_of_warwick_in_singapore 100)) "%" )
	(printout t crlf "methodist schools foundation    : " (integer (* ?cf-methodist_schools_foundation 100)) "%" )
	(printout t crlf "hwa chong international school education fund    : " (integer (* ?cf-hwa_chong_international_school_education_fund 100)) "%" )
	(printout t crlf "girl guides singapore    : " (integer (* ?cf-girl_guides_singapore 100)) "%" )
	(printout t crlf "national skin centre health endowment fund    : " (integer (* ?cf-national_skin_centre_health_endowment_fund 100)) "%" )
	(printout t crlf "ren ci hospital    : " (integer (* ?cf-ren_ci_hospital 100)) "%" )
	(printout t crlf "sata commhealth    : " (integer (* ?cf-sata_commhealth 100)) "%" )
	(printout t crlf "ronald mcdonald house charities singapore    : " (integer (* ?cf-ronald_mcdonald_house_charities_singapore 100)) "%" )
	(printout t crlf "academy of medicine singapore    : " (integer (* ?cf-academy_of_medicine_singapore 100)) "%" )
	(printout t crlf "home nursing foundation    : " (integer (* ?cf-home_nursing_foundation 100)) "%" )
	(printout t crlf "assisi hospice    : " (integer (* ?cf-assisi_hospice 100)) "%" )
	(printout t crlf "hca hospice care    : " (integer (* ?cf-hca_hospice_care 100)) "%" )
	(printout t crlf "grace lodge    : " (integer (* ?cf-grace_lodge 100)) "%" )
	(printout t crlf "alzheimers disease association    : " (integer (* ?cf-alzheimers_disease_association 100)) "%" )
	(printout t crlf "sma charity fund    : " (integer (* ?cf-sma_charity_fund 100)) "%" )
	(printout t crlf "kidney dialysis foundation limited    : " (integer (* ?cf-kidney_dialysis_foundation_limited 100)) "%" crlf)

)
