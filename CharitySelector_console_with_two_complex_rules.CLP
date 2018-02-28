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

; Create defglobal
(defglobal
	?*research_variable* = 0.0
	?*emotional_variable* = 0.0)

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
							(slot kidney_dialysis_foundation_limited)
							(slot public_free_clinic_society)
							(slot alexandra_health_fund_limited)
							(slot society_for_the_prevention_of_cruelty_to_animals_singapore)
							(slot blossom_world_society)
							(slot waterways_watch_society)
							(slot asia_pacific_breweries_foundation)
							(slot the_law_society_of_singapore_pro_bono_learning_and_support_services)
							(slot singapore_indian_development_association_sinda)
							(slot singapore_institute_of_international_affairs_endowment_fund)
							(slot singapore_buddhist_federation_the)
							(slot new_creation_church)
							(slot holy_tree_sri_bala_subramaniar_temple)
							(slot muslim_converts_association_of_singapore)
							(slot xian_gu_tian)
							(slot fei_yue_community_services)
							(slot caritas_singapore_agape_fund)
							(slot association_for_persons_with_special_needs)
							(slot apex_day_rehabilitation_centre_for_elderly)
							(slot family_life_society)
							(slot heb___ashram_halfway_house)
							(slot footballplus_ltd)
							(slot singapore_national_paralympic_council_ltd)
							(slot special_olympics_asia_pacific_ltd)
							(slot singapore_athletic_association)
							(slot salvation_army_the)
						)
(deftemplate nameofvariable (slot name) (slot cf)(slot true_or_false))
;(defglobal ?*age*=0)

;Loading the facts now
(deffacts load-facts
	(current_fact (fact ngee_ann_cultural_centre_limited) (cf 0.2) (all_vars arts_and_heritage no_tax_deduct medium money historical_and_cultural_conservation exist_long   sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website   ))
	(current_fact (fact singapore_indian_fine_arts_society_the) (cf 0.2) (all_vars arts_and_heritage no_tax_deduct medium money   music_and_orchestras exist_long  gov_grants sub_fin_yes ratio_eff_high  sub_gov_not_req gov_rating_low has_website media_exposure  ))
	(current_fact (fact national_book_development_council_of_singapore_the) (cf 0.2) (all_vars arts_and_heritage  medium money   literary_arts exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact singapore_clan_foundation) (cf 0.2) (all_vars arts_and_heritage  medium money   historical_and_cultural_conservation exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact the_esplanade_co_ltd) (cf 0.2) (all_vars arts_and_heritage  large money inkind  music_and_orchestras exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact the_dance_company_ltd) (cf 0.2) (all_vars arts_and_heritage  medium money   professional_contemporary_and_ethnic_dance exit_medium  gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website   ))
	(current_fact (fact cake_theatrical_productions_ltd) (cf 0.2) (all_vars arts_and_heritage no_tax_deduct medium money   theatre_and_dramatic_arts exist_long  gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact tampines_arts_troupe) (cf 0.2) (all_vars arts_and_heritage  small money   traditional_ethnic_performing_arts exist_long  gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_mid has_website media_exposure  ))
	(current_fact (fact spot_art_limited) (cf 0.2) (all_vars arts_and_heritage no_tax_deduct small money inkind  visual_arts exist_short  gov_grants sub_fin_no ratio_eff_low  sub_gov_not_req gov_rating_low has_website   ))
	(current_fact (fact radin_mas_ccc_community_development_and_welfare_fund) (cf 0.2) (all_vars community  medium money   central exist_long   sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact kaki_bukit_ccc_community_development_and_welfare_fund) (cf 0.2) (all_vars community  medium money   north_east exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high  media_exposure  ))
	(current_fact (fact kebun_baru_ccc_community_development_and_welfare_fund) (cf 0.2) (all_vars community  small money   north_west exist_long   sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high  media_exposure  ))
	(current_fact (fact fengshan_ccc_community_development_and_welfare_fund) (cf 0.2) (all_vars community  small money   south_east exist_long   sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high  media_exposure  ))
	(current_fact (fact bukit_batok_ccc_community_development_and_welfare_fund) (cf 0.2) (all_vars community  medium money   south_west exist_long invest_reserves  sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact the_friends_of_the_university_of_warwick_in_singapore) (cf 0.2) (all_vars education  small money   foreign_educational_institutions_and_funds exist_short   sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_mid  media_exposure  ))
	(current_fact (fact methodist_schools_foundation) (cf 0.2) (all_vars education  medium money   foundations_and_trusts exist_long invest_reserves  sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website   ))
	(current_fact (fact hwa_chong_international_school_education_fund) (cf 0.2) (all_vars education  small money   local_educational_institutions_and_funds exist_long invest_reserves  sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website   ))
	(current_fact (fact girl_guides_singapore) (cf 0.2) (all_vars education  medium money  volunteer uniformed_groups exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_not_req gov_rating_low has_website media_exposure  ))
	(current_fact (fact national_skin_centre_health_endowment_fund) (cf 0.2) (all_vars health  small money   cluster_and_hospital_funds exist_long invest_reserves  sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high    ))
	(current_fact (fact ren_ci_hospital) (cf 0.2) (all_vars health  large money inkind volunteer community_and_chronic_sick_hospital exit_medium invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure has_chequered past  ))
	(current_fact (fact sata_commhealth) (cf 0.2) (all_vars health no_tax_deduct large money  volunteer day_rehabilitation_centre exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact ronald_mcdonald_house_charities_singapore) (cf 0.2) (all_vars health no_tax_deduct medium money   diseases_and_illnessess_support_group exist_long invest_reserves  sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact academy_of_medicine_singapore) (cf 0.2) (all_vars health  large money   health_professional_group exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact home_nursing_foundation) (cf 0.2) (all_vars health  large money  volunteer home_care exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact assisi_hospice) (cf 0.2) (all_vars health  large money  volunteer hospice exit_medium invest_reserves gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact hca_hospice_care) (cf 0.2) (all_vars health  large money  volunteer palliative_home_care exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact grace_lodge) (cf 0.2) (all_vars health  large money  volunteer nursing_home exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact alzheimers_disease_association) (cf 0.2) (all_vars health  large money  volunteer community_based_services exist_long  gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact kidney_dialysis_foundation_limited) (cf 0.2) (all_vars health  large money  volunteer renal_dialysis exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact public_free_clinic_society) (cf 0.2) (all_vars health  large money  volunteer tcm_clinic exist_long invest_reserves  sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact alexandra_health_fund_limited) (cf 0.2) (all_vars health  medium money  volunteer trust_and_research_funds exist_short invest_reserves  sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high  media_exposure  ))
	(current_fact (fact society_for_the_prevention_of_cruelty_to_animals_singapore) (cf 0.2) (all_vars others  medium money inkind volunteer animal_welfare exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact blossom_world_society) (cf 0.2) (all_vars others  medium money   children_and_youth exist_short  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact waterways_watch_society) (cf 0.2) (all_vars others  medium money   environment exist_long  gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_mid has_website media_exposure  ))
	(current_fact (fact asia_pacific_breweries_foundation) (cf 0.2) (all_vars others  medium money  volunteer general_charitable_purposes exist_long invest_reserves  sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_mid has_website media_exposure  ))
	(current_fact (fact the_law_society_of_singapore_pro_bono_learning_and_support_services) (cf 0.2) (all_vars others  medium money   humanitarian_aid exist_long  gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact singapore_indian_development_association_sinda) (cf 0.2) (all_vars others  large money  volunteer self_help_groups exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact singapore_institute_of_international_affairs_endowment_fund) (cf 0.2) (all_vars others  medium money   think_tanks exist_long   sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact singapore_buddhist_federation_the) (cf 0.2) (all_vars religious no_tax_deduct medium money  volunteer buddhism exist_long  gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact new_creation_church) (cf 0.2) (all_vars religious no_tax_deduct large money  volunteer christianity exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_mid has_website media_exposure  ))
	(current_fact (fact holy_tree_sri_bala_subramaniar_temple) (cf 0.2) (all_vars religious no_tax_deduct medium money  volunteer hinduism exist_long   sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact muslim_converts_association_of_singapore) (cf 0.2) (all_vars religious no_tax_deduct medium money  volunteer islam exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact xian_gu_tian) (cf 0.2) (all_vars religious no_tax_deduct medium money   taoism exist_long   sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high    ))
	(current_fact (fact fei_yue_community_services) (cf 0.2) (all_vars social_and_welfare  large money  volunteer children_and_youth exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact caritas_singapore_agape_fund) (cf 0.2) (all_vars social_and_welfare no_tax_deduct large money   community exist_long invest_reserves  sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact association_for_persons_with_special_needs) (cf 0.2) (all_vars social_and_welfare  large money inkind volunteer disability_adult exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_mid has_website media_exposure  ))
	(current_fact (fact apex_day_rehabilitation_centre_for_elderly) (cf 0.2) (all_vars social_and_welfare  medium money  volunteer eldercare exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website   ))
	(current_fact (fact family_life_society) (cf 0.2) (all_vars social_and_welfare  medium money  volunteer family exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact heb___ashram_halfway_house) (cf 0.2) (all_vars social_and_welfare  medium money   support_groups exit_medium  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact footballplus_ltd) (cf 0.2) (all_vars sports  small money   competitive_sports exist_short  gov_grants sub_fin_yes ratio_eff_high fin_health_poor sub_gov_yes gov_rating_mid has_website   ))
	(current_fact (fact singapore_national_paralympic_council_ltd) (cf 0.2) (all_vars sports  medium money   disability_sports exit_medium  gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact special_olympics_asia_pacific_ltd) (cf 0.2) (all_vars sports no_tax_deduct large money inkind volunteer non_nsas exit_medium   sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high  media_exposure  ))
	(current_fact (fact singapore_athletic_association) (cf 0.2) (all_vars sports no_tax_deduct medium money inkind volunteer nsas exit_medium  gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  ))
	(current_fact (fact salvation_army_the) (cf 0.2) (all_vars social_and_welfare  large money inkind volunteer community exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_mid has_website media_exposure  ))

;Current Goals are listed here.
	(current_goal (goal ngee_ann_cultural_centre_limited) (cf 0.5))
	(current_goal (goal singapore_indian_fine_arts_society_the) (cf 0.5))
	(current_goal (goal national_book_development_council_of_singapore_the) (cf 0.5))
	(current_goal (goal singapore_clan_foundation) (cf 0.5))
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
	(current_goal (goal kidney_dialysis_foundation_limited) (cf 0.5))
	(current_goal (goal public_free_clinic_society) (cf 0.5))
	(current_goal (goal alexandra_health_fund_limited) (cf 0.5))
	(current_goal (goal society_for_the_prevention_of_cruelty_to_animals_singapore) (cf 0.5))
	(current_goal (goal blossom_world_society) (cf 0.5))
	(current_goal (goal waterways_watch_society) (cf 0.5))
	(current_goal (goal asia_pacific_breweries_foundation) (cf 0.5))
	(current_goal (goal the_law_society_of_singapore_pro_bono_learning_and_support_services) (cf 0.5))
	(current_goal (goal singapore_indian_development_association_sinda) (cf 0.5))
	(current_goal (goal singapore_institute_of_international_affairs_endowment_fund) (cf 0.5))
	(current_goal (goal singapore_buddhist_federation_the) (cf 0.5))
	(current_goal (goal new_creation_church) (cf 0.5))
	(current_goal (goal holy_tree_sri_bala_subramaniar_temple) (cf 0.5))
	(current_goal (goal muslim_converts_association_of_singapore) (cf 0.5))
	(current_goal (goal xian_gu_tian) (cf 0.5))
	(current_goal (goal fei_yue_community_services) (cf 0.5))
	(current_goal (goal caritas_singapore_agape_fund) (cf 0.5))
	(current_goal (goal association_for_persons_with_special_needs) (cf 0.5))
	(current_goal (goal apex_day_rehabilitation_centre_for_elderly) (cf 0.5))
	(current_goal (goal family_life_society) (cf 0.5))
	(current_goal (goal heb___ashram_halfway_house) (cf 0.5))
	(current_goal (goal footballplus_ltd) (cf 0.5))
	(current_goal (goal singapore_national_paralympic_council_ltd) (cf 0.5))
	(current_goal (goal special_olympics_asia_pacific_ltd) (cf 0.5))
	(current_goal (goal singapore_athletic_association) (cf 0.5))
	(current_goal (goal salvation_army_the) (cf 0.5))

    (branch_indicator (name only_kind_or_time) (true_or_false UNKNOWN))
	;(branch_indicator (name char_size) (true_or_false TRUE))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BUSINESS RULES
; The idea is: you want to ask for input, and then use that input to get the relevant cf for all relevant charities (see engine rule)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;**** Rule 0: Ask user whether he is an individual or corporate.
(defrule indiv_corpo
    ; 1. You need an indicator for starting + CLIPS does not let you change this if you don't put it into a variable:
    ?branch_indicator <- (branch_indicator (name only_kind_or_time)(true_or_false UNKNOWN))
    =>	
    (printout t crlf " Are you Corporate or Individual user?(c/i) ") 
	(bind ?response (read))
	(if (eq ?response c) then 
        (assert (corporate))
    else
        (assert (individual))
	)
)
        

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
	(case k then (assert (nameofvariable (name inkind)(cf 1)(true_or_false TRUE)))
		             (assert(donation_type_kind)))	  
        ;2b here we make sure that the second rule, tax, doesn't fire.
        (case m then (assert (nameofvariable (name money)(cf 1)(true_or_false TRUE)))        
				(assert(donation_type_money)))
        (case v then (assert (nameofvariable (name volunteer)(cf 1)(true_or_false TRUE)))  
				(assert(donation_type_volunteering)))
        ;2c. the default is rest category (the wrong answer): ask again.        
        (default (printout t crlf "Not a valid answer, please try again.")
                (retract ?branch_indicator)
                (assert (branch_indicator (name only_kind_or_time)(true_or_false UNKNOWN))))
        )
    )
	
;;;;Following rules are for branching purpose
(defrule donation_from_corporate
  ;?branch_indicator <- (branch_indicator (name only_kind_or_time)(true_or_false UNKNOWN))
  (corporate)
  (or (donation_type_money)
      (donation_type_volunteering)
      (donation_type_kind)
  )
  =>
  (assert (current_question tax_exemption))
  ;(modify ?branch_indicator (true_or_false FALSE))
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

	
;**** Rule8: Ask if want tax
(defrule tax
    (current_question tax_exemption)
   ; (branch_indicator (name only_kind_or_time) (true_or_false FALSE))	
=>	(printout t crlf "Do you like your tax exemption? (y/n)") 
    (bind ?response (read))
; *Create a name variable as input for the next function --> can become a modify!
    (if (eq ?response y) then 
        (assert (nameofvariable (name no_tax_deduct)(cf -1)(true_or_false TRUE)))
	)
)


;**** Rule17:  IF reseach AND emotional --> least value will influence the result
(defrule rational_user
=>	(printout t crlf "Please indicate to what extent you agree with the following statements:

	I like to do my own extensive research before making decision (1/2/3/4/5)") 
	(bind ?response1 (read))
	;emotional does not dislike effective, so no negative values:
	(switch ?response1
		(case 1 then   (bind ?*research_variable* 0))
		(case 2 then 	(bind ?*research_variable* 0.1))
		(case 3 then 	(bind ?*research_variable* 0.2) (assert (is_not_emotional)))
		(case 4 then 	(bind ?*research_variable* 0.3) (assert (is_not_emotional)))
		(case 5 then 	(bind ?*research_variable* 0.4) (assert (is_not_emotional)))		

	)
	(printout t crlf)
	(printout t crlf "When I read depressing news I feel emotionally affected") 
	(bind ?response2 (read))
	(switch ?response2
		(case 1 then   (bind ?*emotional_variable* 0.4) (assert (is_not_emotional)))
		(case 2 then 	(bind ?*emotional_variable* 0.3) (assert (is_not_emotional)))
		(case 3 then 	(bind ?*emotional_variable* 0.2) (assert (is_not_emotional)))
		(case 4 then 	(bind ?*emotional_variable* 0.1))
		(case 5 then 	(bind ?*emotional_variable* 0))
	)
	; Will likely have a positive effect on the ones with ratio eff high:
	;(printout t crlf "+++++++++++++++++++++++++++++++++++++++++++------"(* (min ?*research_variable* ?*emotional_variable*) 0.3))
	(assert (nameofvariable (name ratio_eff_high) (cf (* (min ?*research_variable* ?*emotional_variable*) 0.5))(true_or_false TRUE)))
	(assert (nameofvariable (name sub_gov_no) (cf (* (min ?*research_variable* ?*emotional_variable*) 0.4))(true_or_false TRUE)))
)



;**** Rule15: Ask for charity size 
(defrule charity_size
    ; (current_question charity_size)
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
	(is_not_emotional)
=>	(printout t crlf "Do you prefer to donate to charities which invest for profit? (y/n)") 
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name invest_reserves)(cf 0.3)(true_or_false TRUE)))
	)
)

;**** Rule10:  preference for Government funded charities CF value as per doc 1 
(defrule charity_gov_funded
	(is_not_emotional)
=>	(printout t crlf "Do you prefer government funded charities or non-government funded charities? (g/n)") 
	(bind ?response (read))
    (if (eq ?response g) then 
        (assert (nameofvariable (name gov_grants)(cf 0.4)(true_or_false TRUE)))
    else
        (assert (nameofvariable (name gov_grants)(cf -0.4)(true_or_false TRUE)))
		
	)
)

;**** Rule11:  preference for financially efficient charities 
(defrule charity_fin_eff
	(is_not_emotional)
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
	(is_not_emotional)
=>	(printout t crlf "Do you prefer to donate to charities which submitted code of compliance? (y/n)") 
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name sub_gov_yes)(cf 1)(true_or_false TRUE)))
		(assert (nameofvariable (name sub_gov_no)(cf -0.1)(true_or_false TRUE)))
		
		
    else
        (assert (nameofvariable (name sub_gov_yes)(cf -0.4)(true_or_false TRUE)))
		
	)
)

;;;;;;;;;;;;;;;;;;; the sector-subsector rules ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;**** Rule16:  choice of Sector
(defrule charity_choice
=>	(printout t crlf "In which kind of charities,would you like to donate?  (Please enter the option number)") 
	(printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    	(printout t crlf "4.Community")
	(printout t crlf "5.Religious")
	(printout t crlf "6.Social and Welfare")
	(printout t crlf "7.Sports")
	(printout t crlf "8.Others")
	(printout t crlf "9.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.6)(true_or_false TRUE)))
						(assert(current_question arts_and_heritage_support)))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE)))
						(assert(current_question education_scholarship)))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.4)(true_or_false TRUE)))
						(assert(current_question health_subsector)))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.4)(true_or_false TRUE)))
						(assert(current_question community_neighbourhood)))
		(case 5 then    (assert (nameofvariable (name religious)(cf 0.4)(true_or_false TRUE)))
						(assert(current_question religion_subsector)))
		(case 6 then 	(assert (nameofvariable (name social_and_welfare)(cf 0.4)(true_or_false TRUE)))
						(assert(current_question social_subsector)))
		(case 7 then 	(assert (nameofvariable (name sports)(cf 0.4)(true_or_false TRUE)))
						(assert(current_question sports_subsector)))
		(case 8 then 	(assert (nameofvariable (name others)(cf 0.4)(true_or_false TRUE)))
						(assert(current_question others_commemorating))
		
		)		
	)
)

;#Rule:Arts  and Heritage
(defrule arts_and_heritage_support
	(current_question arts_and_heritage_support)
=>	(printout t crlf "I support conserving history and traditional cultures?(-1/-0.5/0/0.5/1)")
	(bind ?response (read))
	(switch ?response
		(case -1 then   (assert (nameofvariable (name historical_and_cultural_conservation)(cf -0.5)(true_or_false TRUE))))
		(case -0.5 then (assert (nameofvariable (name historical_and_cultural_conservation)(cf -0.3)(true_or_false TRUE))))
		(case 0.5 then 	(assert (nameofvariable (name historical_and_cultural_conservation)(cf  0.3)(true_or_false TRUE))))
		(case 1 then 	(assert (nameofvariable (name historical_and_cultural_conservation)(cf  0.5)(true_or_false TRUE))))
	)
	(assert(current_question arts_and_heritage_subsector))
)
;**** Rule:  choice of SubSector
(defrule arts_and_heritage_subsector
	(current_question arts_and_heritage_subsector)
=>	(printout t crlf "What interests you more in Arts and Heritage in Singapore?  (Please enter the option number)") 
	(printout t crlf "1.historical_and_cultural_conservation")
	(printout t crlf "2.music_and_orchestras")
	(printout t crlf "3.literary_arts")
	(printout t crlf "4.visual_arts")
	(printout t crlf "5.professional_contemporary_and_ethnic_dance")
	(printout t crlf "6.theatre_and_dramatic_arts")
	(printout t crlf "7.traditional_ethnic_performing_arts")
	(printout t crlf "8.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name historical_and_cultural_conservation)(cf 0.7)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name music_and_orchestras)(cf 0.7)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name literary_arts)(cf 0.7)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name visual_arts)(cf 0.7)(true_or_false TRUE))))
		(case 5 then    (assert (nameofvariable (name professional_contemporary_and_ethnic_dance)(cf 0.7)(true_or_false TRUE))))
		(case 6 then 	(assert (nameofvariable (name theatre_and_dramatic_arts)(cf 0.7)(true_or_false TRUE))))
		(case 7 then 	(assert (nameofvariable (name traditional_ethnic_performing_arts)(cf 0.7)(true_or_false TRUE))))
	)
)

;Rule:Education Branch scholarship
(defrule education_scholarship
	(current_question education_scholarship)
=>	(printout t crlf "Have you benefited from scholarships and bursaries before?(y/n)")
	(bind ?response (read))
	(if (eq ?response y) then 
        (assert (nameofvariable (name foundations_and_trusts)(cf 0.5)(true_or_false TRUE))) 
		(assert (nameofvariable (name local_educational_institutions_and_funds)(cf 0.5)(true_or_false TRUE)))
	)
	(assert(current_question education_subsector))
)

;**** Rule:  choice of SubSector education
(defrule education_subsector
	(current_question education_subsector)
=>	(printout t crlf "Which sub sector of the following, do you think is more worthy to donate to?  (Please enter the option number)") 
	(printout t crlf "1.foreign_educational_institutions_and_funds")
	(printout t crlf "2.foundations_and_trusts")
	(printout t crlf "3.local_educational_institutions_and_funds")
	(printout t crlf "4.uniformed_groups")
	(printout t crlf "5.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name foreign_educational_institutions_and_funds)(cf 0.7)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name foundations_and_trusts)(cf 0.7)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name local_educational_institutions_and_funds)(cf 0.7)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name uniformed_groups)(cf 0.7)(true_or_false TRUE))))
	)
)
;Rule:Commmunity Branch neighborhood
(defrule community_neighbourhood
;(declare (salience 10))
	(current_question community_neighbourhood)

=>	(printout t crlf "Do you think donating to neighborhood is more worthy than donating to rest of Singapore?(y/n)")
	(bind ?response (read))
	
	(if (eq ?response y) then 
       (assert(current_question community_location))	
	)
)	
	
;**** Rule:  choice of SubSector community
(defrule community_location
	(current_question community_location)
=>	(printout t crlf "In which part of Singapore do you live?  (Please enter the option number)") 
	(printout t crlf "1.central")
	(printout t crlf "2.north_east")
	(printout t crlf "3.north_west")
	(printout t crlf "4.south_east")
	(printout t crlf "5.south_west")
	(printout t crlf "6.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name central)(cf 0.7)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name north_east)(cf 0.7)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name north_west)(cf 0.7)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name south_east)(cf 0.7)(true_or_false TRUE))))
		(case 5 then 	(assert (nameofvariable (name south_west)(cf 0.7)(true_or_false TRUE))))
	)
)

;**** Rule:  choice of SubSector health
(defrule health_subsector
	(current_question health_subsector)
=>	(printout t crlf "Which of the following subsector do you think is more worthy to donate to?  (Please enter the option number)") 
	(printout t crlf "1.cluster_and_hospital_funds")
	(printout t crlf "2.community_and_chronic_sick_hospital")
	(printout t crlf "3.day_rehabilitation_centre")
	(printout t crlf "4.diseases_and_illnessess_support_group")
	(printout t crlf "5.health_professional_group")
	(printout t crlf "6.home_care")
	(printout t crlf "7.hospice")
	(printout t crlf "8.palliative_home_care")
	(printout t crlf "9.nursing_home")
	(printout t crlf "10.community_based_services")
	(printout t crlf "11.renal_dialysis")
	(printout t crlf "12.tcm_clinic")
	(printout t crlf "13.trust_and_research_funds")
	(printout t crlf "14.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name cluster_and_hospital_funds)(cf 0.7)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name community_and_chronic_sick_hospital)(cf 0.7)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name day_rehabilitation_centre)(cf 0.7)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name diseases_and_illnessess_support_group)(cf 0.7)(true_or_false TRUE))))
		(case 5 then 	(assert (nameofvariable (name health_professional_group)(cf 0.7)(true_or_false TRUE))))
		(case 6 then    (assert (nameofvariable (name home_care)(cf 0.7)(true_or_false TRUE))))
		(case 7 then 	(assert (nameofvariable (name hospice)(cf 0.7)(true_or_false TRUE))))
		(case 8 then 	(assert (nameofvariable (name palliative_home_care)(cf 0.7)(true_or_false TRUE))))
		(case 9 then 	(assert (nameofvariable (name nursing_home)(cf 0.7)(true_or_false TRUE))))
		(case 10 then 	(assert (nameofvariable (name community_based_services)(cf 0.7)(true_or_false TRUE))))
		(case 11 then    (assert (nameofvariable(name renal_dialysis)(cf 0.7)(true_or_false TRUE))))
		(case 12 then 	(assert (nameofvariable (name tcm_clinic)(cf 0.7)(true_or_false TRUE))))
		(case 13 then 	(assert (nameofvariable (name trust_and_research_funds)(cf 0.7)(true_or_false TRUE))))

	)
)


;**** Rule:  choice of SubSector religion
(defrule religion_subsector
	(current_question religion_subsector)
=>	(printout t crlf "Which religion you are interested to donate to?  (Please enter the option number)") 
	(printout t crlf "1.buddhism")
	(printout t crlf "2.christianity")
	(printout t crlf "3.hinduism")
	(printout t crlf "4.islam")
	(printout t crlf "5.taoism")
	(printout t crlf "6.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name buddhism)(cf 0.7)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name christianity)(cf 0.7)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name hinduism)(cf 0.7)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name islam)(cf 0.7)(true_or_false TRUE))))
		(case 5 then 	(assert (nameofvariable (name taoism)(cf 0.7)(true_or_false TRUE))))
	)
)

;**** Rule:  choice of SubSector others
(defrule others_commemorating
	(current_question others_commemorating)
=>	(printout t crlf "Do you celebrate the days commemorating the environment day like June 5th,Earth day?  (y/n)") 
	(bind ?response (read))
	(if (eq ?response y) then 
       (assert (nameofvariable (name environment)(cf 0.8)(true_or_false TRUE)))
	 else 
	 (assert(current_question others_pet)  )
	)
)

;**** Rule:  choice of SubSector others
(defrule others_pet
	(current_question others_pet)
=>	(printout t crlf "Do you have the pet that you love/loved?  (y/n)") 
	(bind ?response (read))
	(if (eq ?response y) then 
       (assert (nameofvariable (name animal_welfare)(cf 0.8)(true_or_false TRUE)))
	   
	 else
	 (assert(current_question others_humanitarian))  
	)
	
)

;**** Rule:  choice of SubSector others
(defrule others_humanitarian
	(current_question others_humanitarian)
=>	(printout t crlf "Do you want to support relief funds that bring relief during times of emergencies like Tsunami,earthquakes?  (y/n)") 
	(bind ?response (read))
	(if (eq ?response y) then 
       (assert (nameofvariable (name humanitarian_aid)(cf 0.8)(true_or_false TRUE)))
	 else
     (assert(current_question others_children))	 
	)
	
)

;**** Rule:  choice of SubSector others
(defrule others_children
	(current_question others_children)
=>	(printout t crlf "Do you think charities which focus on children/youth deserve more attention? (y/n)") 
	(bind ?response (read))
	(if (eq ?response y) then 
       (assert (nameofvariable (name children_and_youth)(cf 0.8)(true_or_false TRUE)))
	)
)

;**** Rule:  choice of SubSector sports
(defrule sports_subsector
	(current_question sports_subsector)
=>	(printout t crlf "Which  areas of sports you are interested to donate to?  (Please enter the option number)") 
	(printout t crlf "1.competitive_sports")
	(printout t crlf "2.disability_sports")
	(printout t crlf "3.non_nsas")
	(printout t crlf "4.nsas")	
	(printout t crlf "5.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name competitive_sports)(cf 0.7)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name disability_sports)(cf 0.7)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name non_nsas)(cf 0.7)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name nsas)(cf 0.7)(true_or_false TRUE))))
		
	)
)

;**** Rule:  choice of SubSector social
(defrule social_subsector
	(current_question social_subsector)
=>	(printout t crlf "Which sector you are interested to donate to?  (Please enter the option number)") 
	(printout t crlf "1.children_and_youth")
	(printout t crlf "2.community")
	(printout t crlf "3.disability_adult")
	(printout t crlf "4.eldercare")	
	(printout t crlf "5.family")	
	(printout t crlf "6.support_groups")	
	(printout t crlf "7.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name children_and_youth)(cf 0.7)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name community)(cf 0.7)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name disability_adult)(cf 0.7)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name eldercare)(cf 0.7)(true_or_false TRUE))))
		(case 5 then 	(assert (nameofvariable (name family)(cf 0.7)(true_or_false TRUE))))
		(case 6 then 	(assert (nameofvariable (name support_groups)(cf 0.7)(true_or_false TRUE))))		
	)
)
;;;;;;;;;;;;;;;;;;;;;;;;;


; (deftemplate numbersector (slot health) (slot education) (slot educationsecond) (slot community) (slot arts) (slot artssecond) (slot other))
; ;**** Rule16:  choice of Sector

; (defrule charity_choice
; ; for debugging purposes, I put salience in so this one will fire first.
;     (declare (salience 999))
;     ?branch_indicator <- (branch_indicator (name only_kind_or_time)(true_or_false UNKNOWN))
; =>(printout t crlf "Would you like to donate to arts (type in 'Y' OR 'N')")
;   (bind ?response1 (read))
;   (printout t crlf "Would you like to donate to education (type in 'Y' OR 'N')")
;   (bind ?response2 (read))
;   (printout t crlf "Would you like to donate to community (type in 'Y' OR 'N')")
;   (bind ?response3 (read))
;   (printout t crlf "Would you like to donate to health (type in 'Y' OR 'N')")
;   (bind ?response4 (read))
;   ; (bind ?response5 (read))4
;   (if (eq ?response1 Y) then 
;     (assert (nameofvariable (name arts_and_heritage)(cf 0.5)(true_or_false TRUE)))
;     (assert (numbersector (arts TRUE)))
; ; you need else statments or else the system will crash
;   else (printout t crlf "arts won't be adjusted"))
;   (if (eq ?response2 Y) then 
;     (assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE)))
;     (assert (numbersector (education TRUE)))
;     else (printout t crlf "education won't be adjusted"))
;  (if (eq ?response3 Y) then 
;     (assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE)))
;     (assert (numbersector (community TRUE)))
;     else (printout t crlf "community won't be adjusted"))
;  (if (eq ?response4 Y) then 
;     (assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE)))
;     (assert (numbersector (health TRUE)))
;     else (printout t crlf "health won't be adjusted"))
; )

; (defrule charity_arts_subsector1
;   (numbersector (arts TRUE))
; =>  (printout t crlf "In which kind of arts1 would you like to donate?  (Please enter the option number)") 
;   (printout t crlf "1.")
;   (printout t crlf "2.")
;   (printout t crlf "3.")
;   (printout t crlf "4.")
;   (printout t crlf "5.Other " crlf)
;   (printout t crlf "6.Don't care " crlf)
;   (bind ?response (read))
;   (switch ?response
;     ; 1. change this (secondarts) into relevant all_vars variables---> note that you can only use each variable in 
;     ; all_vars ONCE --> cannot use the same subset/name twice or it does not trigger the engine rule!
;     ; (can be solved in clips using modify command, but will not work in JAVA, so I chose the ugly solution)
;     (case 1 then  (assert (nameofvariable (name secondarts_and_heritage)(cf 0.6)(true_or_false TRUE)))
;     (assert (numbersector (artssecond TRUE))))
;     (case 2 then  (assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE))))
;     (case 3 then  (assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE))))
;     (case 4 then  (assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE))))
;     (case 5 then  (assert (nameofvariable (name other)(cf -0.1)(true_or_false TRUE)))    
;   )
; )
; )


; (defrule charity_arts_subsector2
;   (numbersector (artssecond TRUE))
; =>  (printout t crlf "In which kind of arts2 would you like to donate?  (Please enter the option number)") 
;   (printout t crlf "1.")
;   (printout t crlf "2.")
;   (printout t crlf "3.")
;   (printout t crlf "4.")
;   (printout t crlf "5.Other " crlf)
;   (printout t crlf "6.Don't care " crlf)
;   (bind ?response (read))
;   (switch ?response
;     ; change this into relevant all_vars variables
;     (case 1 then  (assert (nameofvariable (name thirdarts_and_heritage)(cf 0.6)(true_or_false TRUE))))
;     (case 2 then  (assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE))))
;     (case 3 then  (assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE))))
;     (case 4 then  (assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE))))
;     (case 5 then  (assert (nameofvariable (name other)(cf -0.1)(true_or_false TRUE)))    
;   )
; )
; )


; (defrule charity_education_subsector1
;   (numbersector (education TRUE))
; =>  (printout t crlf "In which kind of education would you like to donate?  (Please enter the option number)") 
;   (printout t crlf "1.")
;   (printout t crlf "2.")
;   (printout t crlf "3.")
;   (printout t crlf "4.")
;   (printout t crlf "5.Other " crlf)
;   (printout t crlf "6.Don't care " crlf)
;   (bind ?response (read))
;   (switch ?response
;     ; change this into relevant all_vars variables
;     (case 1 then  (assert (nameofvariable (name secondarts_and_heritage)(cf 0.6)(true_or_false TRUE))))
;     ; if you need a second question:
; ;    (assert (numbersector (educationsecond TRUE))))
;     (case 2 then  (assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE))))
;     (case 3 then  (assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE))))
;     (case 4 then  (assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE))))
;     (case 5 then  (assert (nameofvariable (name other)(cf -0.1)(true_or_false TRUE)))    
;   )
; )
; )

; Create defglobal
(defglobal
	?*old_variable* = 0.0
	?*recent_variable* = 0.0)

;**** Rule11: If a user prefers charities have a lot of experience OR prefers charities that focus on short term, update cf:
(defrule years_established
=>	(printout t crlf " Please indicate to what extent you agree with the following statements:
	When I support charities, I care about the experience of the employees (rate 1/2/3/4/5).
	") 
	(bind ?response1 (read))
	(switch ?response1
		(case 1 then    (bind ?*old_variable* 0))
		(case 2 then 	(bind ?*old_variable* 0.1))
		(case 3 then 	(bind ?*old_variable* 0.2))
		(case 4 then 	(bind ?*old_variable* 0.3))
		(case 5 then 	(bind ?*old_variable* 0.4))		
	)
	(printout t crlf)
	(printout t crlf "I prefer charities that have been examined multiple times by accountants (rate 1/2/3/4/5).
		") 
	; new charities have had less checks by the accountant:
	(bind ?response2 (read))
	(switch ?response2
		(case 1 then (bind ?*recent_variable* 0.4))
		(case 2 then (bind ?*recent_variable* 0.3))
		(case 3 then (bind ?*recent_variable* 0.2))
		(case 4 then (bind ?*recent_variable* 0.1))
		(case 5 then (bind ?*recent_variable* 0))
	)
	; very likely to give a positive indication for long existing: only if you really feel there is no need for establishment 
	; AND you really want to focus on recent issues, it will become negative
	; (printout t crlf "long  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"(* (max ?*old_variable* ?*recent_variable*) 0.3))
	; (printout t crlf "medium  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"(* (max ?*old_variable* ?*recent_variable*) 0.1))
	; (printout t crlf "short  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"(* (max ?*old_variable* ?*recent_variable*) -0.2))		
	(assert (nameofvariable (name exist_long) (cf (* (max ?*old_variable* ?*recent_variable*) 0.3))(true_or_false TRUE)))
	(assert (nameofvariable (name exist_medium) (cf (* (max ?*old_variable* ?*recent_variable*) 0.1))(true_or_false TRUE)))
)


;**** Rule:  Do you mind donating to charities that have checkered past(variable not clear)
(defrule charity_past
=>	(printout t crlf "Are you willing to donate to charities that have a checkered past (but have since been rehabilitated)? (y/n)") 
	(bind ?response (read))
    (if (eq ?response n) then 
        (assert (nameofvariable (name has_chequered_past)(cf -0.6)(true_or_false TRUE)))
		
	)
)

;**** Rule2:  Sectors parents donate to 
(defrule charity_parents_sector
=>	(printout t crlf "Please choose the type of the charity to which your parents donate to.(Please enter the option number)")
    (printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.Religious")
	(printout t crlf "6.Social and Welfare")
	(printout t crlf "7.Sports")
	(printout t crlf "8.Others")
	(printout t crlf "9.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.7)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.7)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.7)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.7)(true_or_false TRUE))))
		(case 5 then    (assert (nameofvariable (name religious)(cf 0.7)(true_or_false TRUE))))
		(case 6 then 	(assert (nameofvariable (name social_and_welfare)(cf 0.7)(true_or_false TRUE))))
		(case 7 then 	(assert (nameofvariable (name sports)(cf 0.7)(true_or_false TRUE))))
		(case 8 then 	(assert (nameofvariable (name others)(cf 0.7)(true_or_false TRUE))))
	)
)



(defrule input_age
=>	(printout t crlf "Are you above 12 years old?(y/n)")
	(bind ?response (read))
	(if (eq ?response y) then 
        (assert (current_question charity_friends_above)) 		
	else	
	    (assert (current_question charity_friends_below))
	)
	 
)

;**** Rule3:  sectors friends donate to and user age(considering their age >12 need to add code to check  age
(defrule charity_friends_Sector
	(current_question charity_friends_above)
=>	(printout t crlf "Please choose the type of the charity to which your friends donate to.(Please enter the option number)")
    (printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.Religious")
	(printout t crlf "6.Social and Welfare")
	(printout t crlf "7.Sports")
	(printout t crlf "8.Others")
	(printout t crlf "9.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.6)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE))))
		(case 5 then    (assert (nameofvariable (name religious)(cf 0.6)(true_or_false TRUE))))
		(case 6 then 	(assert (nameofvariable (name social_and_welfare)(cf 0.6)(true_or_false TRUE))))
		(case 7 then 	(assert (nameofvariable (name sports)(cf 0.6)(true_or_false TRUE))))
		(case 8 then 	(assert (nameofvariable (name others)(cf 0.6)(true_or_false TRUE))))	
	)
	(assert (current_question charity_spouse))
)

;**** Rule3:  sectors friends donate to and user age(considering their age <12 need to add code to check  age
(defrule charity_friends_Sector2
	(current_question charity_friends_below)
=>	(printout t crlf "Please choose the type of the charity to which your friends donate to.(Please enter the option number)")
    (printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.Religious")
	(printout t crlf "6.Social and Welfare")
	(printout t crlf "7.Sports")
	(printout t crlf "8.Others")
	(printout t crlf "9.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.5)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.5)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.5)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.5)(true_or_false TRUE))))
		(case 5 then    (assert (nameofvariable (name religious)(cf 0.5)(true_or_false TRUE))))
		(case 6 then 	(assert (nameofvariable (name social_and_welfare)(cf 0.5)(true_or_false TRUE))))
		(case 7 then 	(assert (nameofvariable (name sports)(cf 0.5)(true_or_false TRUE))))
		(case 8 then 	(assert (nameofvariable (name others)(cf 0.5)(true_or_false TRUE))))	
	)
	(assert (current_question charity_received_help))
)

;**** Rule21:  Influence of spouse Sectors spouse donate to 
(defrule charity_spouse
	(current_question charity_spouse)
=>	(printout t crlf "Please choose the type of the charity to which your spouse donate to.(Please enter the option number)")
    (printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.Religious")
	(printout t crlf "6.Social and Welfare")
	(printout t crlf "7.Sports")
	(printout t crlf "8.Others")
	(printout t crlf "9.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.8)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.8)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.8)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.8)(true_or_false TRUE))))
		(case 5 then    (assert (nameofvariable (name religious)(cf 0.8)(true_or_false TRUE))))
		(case 6 then 	(assert (nameofvariable (name social_and_welfare)(cf 0.8)(true_or_false TRUE))))
		(case 7 then 	(assert (nameofvariable (name sports)(cf 0.8)(true_or_false TRUE))))
		(case 8 then 	(assert (nameofvariable (name others)(cf 0.8)(true_or_false TRUE))))
	
		
	)
	(assert (current_question charity_received_help))
	
)

;**** Rule22:  Received Help earlier
(defrule charity_received_help
	(current_question charity_received_help)
=>	(printout t crlf "Which of the following type of charities helped you in past? (Please enter the option number)") 
	(printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.Religious")
	(printout t crlf "6.Social and Welfare")
	(printout t crlf "7.Sports")
	(printout t crlf "8.Others")
	(printout t crlf "9.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.5)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.5)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.5)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.5)(true_or_false TRUE))))
		(case 5 then    (assert (nameofvariable (name religious)(cf 0.5)(true_or_false TRUE))))
		(case 6 then 	(assert (nameofvariable (name social_and_welfare)(cf 0.5)(true_or_false TRUE))))
		(case 7 then 	(assert (nameofvariable (name sports)(cf 0.5)(true_or_false TRUE))))
		(case 8 then 	(assert (nameofvariable (name others)(cf 0.5)(true_or_false TRUE))))
		
	)
)

;**** New Rule:  Do you want to donate to charities which are constantly in media
(defrule charity_media
=>	(printout t crlf "Do you want to donate to charities which are constantly in media? (y/n)") 
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name media_exposure)(cf 0.4)(true_or_false TRUE)))
		
	)
)

;**** Rule13:  preference for charities which submitted compliance 
(defrule charity_website
=>	(printout t crlf "Do you prefer your charity to have a website? (y/n)") 
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name has_website)(cf 0.2)(true_or_false TRUE)))
	)
)



;**** Rule35:  Influence of positive public figure
(defrule charity_influence
=>	(printout t crlf "In which sectors do the your idol(influential) donate to?  (Please enter the option number)") 
	(printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.Religious")
	(printout t crlf "6.Social and Welfare")
	(printout t crlf "7.Sports")
	(printout t crlf "8.Others")
	(printout t crlf "9.None of the above" crlf)
	(bind ?response (read))
	(switch ?response
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.4)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.4)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.4)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.4)(true_or_false TRUE))))
		(case 5 then    (assert (nameofvariable (name religious)(cf 0.4)(true_or_false TRUE))))
		(case 6 then 	(assert (nameofvariable (name social_and_welfare)(cf 0.4)(true_or_false TRUE))))
		(case 7 then 	(assert (nameofvariable (name sports)(cf 0.4)(true_or_false TRUE))))
		(case 8 then 	(assert (nameofvariable (name others)(cf 0.4)(true_or_false TRUE))))
		
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
		(current_goal (goal kidney_dialysis_foundation_limited) (cf ?cf-kidney_dialysis_foundation_limited))
		(current_goal (goal public_free_clinic_society) (cf ?cf-public_free_clinic_society))
		(current_goal (goal alexandra_health_fund_limited) (cf ?cf-alexandra_health_fund_limited))
		(current_goal (goal society_for_the_prevention_of_cruelty_to_animals_singapore) (cf ?cf-society_for_the_prevention_of_cruelty_to_animals_singapore))
		(current_goal (goal blossom_world_society) (cf ?cf-blossom_world_society))
		(current_goal (goal waterways_watch_society) (cf ?cf-waterways_watch_society))
		(current_goal (goal asia_pacific_breweries_foundation) (cf ?cf-asia_pacific_breweries_foundation))
		(current_goal (goal the_law_society_of_singapore_pro_bono_learning_and_support_services) (cf ?cf-the_law_society_of_singapore_pro_bono_learning_and_support_services))
		(current_goal (goal singapore_indian_development_association_sinda) (cf ?cf-singapore_indian_development_association_sinda))
		(current_goal (goal singapore_institute_of_international_affairs_endowment_fund) (cf ?cf-singapore_institute_of_international_affairs_endowment_fund))
		(current_goal (goal singapore_buddhist_federation_the) (cf ?cf-singapore_buddhist_federation_the))
		(current_goal (goal new_creation_church) (cf ?cf-new_creation_church))
		(current_goal (goal holy_tree_sri_bala_subramaniar_temple) (cf ?cf-holy_tree_sri_bala_subramaniar_temple))
		(current_goal (goal muslim_converts_association_of_singapore) (cf ?cf-muslim_converts_association_of_singapore))
		(current_goal (goal xian_gu_tian) (cf ?cf-xian_gu_tian))
		(current_goal (goal fei_yue_community_services) (cf ?cf-fei_yue_community_services))
		(current_goal (goal caritas_singapore_agape_fund) (cf ?cf-caritas_singapore_agape_fund))
		(current_goal (goal association_for_persons_with_special_needs) (cf ?cf-association_for_persons_with_special_needs))
		(current_goal (goal apex_day_rehabilitation_centre_for_elderly) (cf ?cf-apex_day_rehabilitation_centre_for_elderly))
		(current_goal (goal family_life_society) (cf ?cf-family_life_society))
		(current_goal (goal heb___ashram_halfway_house) (cf ?cf-heb___ashram_halfway_house))
		(current_goal (goal footballplus_ltd) (cf ?cf-footballplus_ltd))
		(current_goal (goal singapore_national_paralympic_council_ltd) (cf ?cf-singapore_national_paralympic_council_ltd))
		(current_goal (goal special_olympics_asia_pacific_ltd) (cf ?cf-special_olympics_asia_pacific_ltd))
		(current_goal (goal singapore_athletic_association) (cf ?cf-singapore_athletic_association))
		(current_goal (goal salvation_army_the) (cf ?cf-salvation_army_the))
		
	
=>	(assert (recommendation (ngee_ann_cultural_centre_limited ?cf-ngee_ann_cultural_centre_limited)
							(singapore_indian_fine_arts_society_the ?cf-singapore_indian_fine_arts_society_the)
							(national_book_development_council_of_singapore_the ?cf-national_book_development_council_of_singapore_the)
							(singapore_clan_foundation ?cf-singapore_clan_foundation)
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
							(kidney_dialysis_foundation_limited ?cf-kidney_dialysis_foundation_limited)
							(public_free_clinic_society ?cf-public_free_clinic_society)
							(alexandra_health_fund_limited ?cf-alexandra_health_fund_limited)
							(society_for_the_prevention_of_cruelty_to_animals_singapore ?cf-society_for_the_prevention_of_cruelty_to_animals_singapore)
							(blossom_world_society ?cf-blossom_world_society)
							(waterways_watch_society ?cf-waterways_watch_society)
							(asia_pacific_breweries_foundation ?cf-asia_pacific_breweries_foundation)
							(the_law_society_of_singapore_pro_bono_learning_and_support_services ?cf-the_law_society_of_singapore_pro_bono_learning_and_support_services)
							(singapore_indian_development_association_sinda ?cf-singapore_indian_development_association_sinda)
							(singapore_institute_of_international_affairs_endowment_fund ?cf-singapore_institute_of_international_affairs_endowment_fund)
							(singapore_buddhist_federation_the ?cf-singapore_buddhist_federation_the)
							(new_creation_church ?cf-new_creation_church)
							(holy_tree_sri_bala_subramaniar_temple ?cf-holy_tree_sri_bala_subramaniar_temple)
							(muslim_converts_association_of_singapore ?cf-muslim_converts_association_of_singapore)
							(xian_gu_tian ?cf-xian_gu_tian)
							(fei_yue_community_services ?cf-fei_yue_community_services)
							(caritas_singapore_agape_fund ?cf-caritas_singapore_agape_fund)
							(association_for_persons_with_special_needs ?cf-association_for_persons_with_special_needs)
							(apex_day_rehabilitation_centre_for_elderly ?cf-apex_day_rehabilitation_centre_for_elderly)
							(family_life_society ?cf-family_life_society)
							(heb___ashram_halfway_house ?cf-heb___ashram_halfway_house)
							(footballplus_ltd ?cf-footballplus_ltd)
							(singapore_national_paralympic_council_ltd ?cf-singapore_national_paralympic_council_ltd)
							(special_olympics_asia_pacific_ltd ?cf-special_olympics_asia_pacific_ltd)
							(singapore_athletic_association ?cf-singapore_athletic_association)
							(salvation_army_the ?cf-salvation_army_the)
			)
	)
	(printout t crlf "Our recommendation is (currently) as follows :")
	(printout t crlf "NGEE ANN CULTURAL CENTRE LIMITED:" (integer (* ?cf-ngee_ann_cultural_centre_limited 100)) "%")
	(printout t crlf "Singapore Indian Fine Arts Society, The:" (integer (* ?cf-singapore_indian_fine_arts_society_the 100)) "%")
	(printout t crlf "National Book Development Council of Singapore, The:" (integer (* ?cf-national_book_development_council_of_singapore_the 100)) "%")
	(printout t crlf "SINGAPORE CLAN FOUNDATION:" (integer (* ?cf-singapore_clan_foundation 100)) "%")
	(printout t crlf "THE ESPLANADE CO LTD:" (integer (* ?cf-the_esplanade_co_ltd 100)) "%")
	(printout t crlf "T.H.E DANCE COMPANY LTD.:" (integer (* ?cf-the_dance_company_ltd 100)) "%")
	(printout t crlf "CAKE THEATRICAL PRODUCTIONS LTD.:" (integer (* ?cf-cake_theatrical_productions_ltd 100)) "%")
	(printout t crlf "Tampines Arts Troupe:" (integer (* ?cf-tampines_arts_troupe 100)) "%")
	(printout t crlf "SPOT ART LIMITED:" (integer (* ?cf-spot_art_limited 100)) "%")
	(printout t crlf "RADIN MAS CCC COMMUNITY DEVELOPMENT AND WELFARE FUND:" (integer (* ?cf-radin_mas_ccc_community_development_and_welfare_fund 100)) "%")
	(printout t crlf "KAKI BUKIT CCC COMMUNITY DEVELOPMENT AND WELFARE FUND:" (integer (* ?cf-kaki_bukit_ccc_community_development_and_welfare_fund 100)) "%")
	(printout t crlf "KEBUN BARU CCC COMMUNITY DEVELOPMENT AND WELFARE FUND:" (integer (* ?cf-kebun_baru_ccc_community_development_and_welfare_fund 100)) "%")
	(printout t crlf "FENGSHAN CCC COMMUNITY DEVELOPMENT AND WELFARE FUND:" (integer (* ?cf-fengshan_ccc_community_development_and_welfare_fund 100)) "%")
	(printout t crlf "BUKIT BATOK CCC COMMUNITY DEVELOPMENT AND WELFARE FUND:" (integer (* ?cf-bukit_batok_ccc_community_development_and_welfare_fund 100)) "%")
	(printout t crlf "The Friends of The University of Warwick in Singapore:" (integer (* ?cf-the_friends_of_the_university_of_warwick_in_singapore 100)) "%")
	(printout t crlf "METHODIST SCHOOLS' FOUNDATION:" (integer (* ?cf-methodist_schools_foundation 100)) "%")
	(printout t crlf "Hwa Chong International School Education Fund:" (integer (* ?cf-hwa_chong_international_school_education_fund 100)) "%")
	(printout t crlf "Girl Guides Singapore:" (integer (* ?cf-girl_guides_singapore 100)) "%")
	(printout t crlf "NATIONAL SKIN CENTRE HEALTH ENDOWMENT FUND:" (integer (* ?cf-national_skin_centre_health_endowment_fund 100)) "%")
	(printout t crlf "REN CI HOSPITAL:" (integer (* ?cf-ren_ci_hospital 100)) "%")
	(printout t crlf "SATA COMMHEALTH:" (integer (* ?cf-sata_commhealth 100)) "%")
	(printout t crlf "RONALD MCDONALD HOUSE CHARITIES SINGAPORE:" (integer (* ?cf-ronald_mcdonald_house_charities_singapore 100)) "%")
	(printout t crlf "ACADEMY OF MEDICINE SINGAPORE:" (integer (* ?cf-academy_of_medicine_singapore 100)) "%")
	(printout t crlf "HOME NURSING FOUNDATION:" (integer (* ?cf-home_nursing_foundation 100)) "%")
	(printout t crlf "ASSISI HOSPICE:" (integer (* ?cf-assisi_hospice 100)) "%")
	(printout t crlf "HCA Hospice Care:" (integer (* ?cf-hca_hospice_care 100)) "%")
	(printout t crlf "Grace Lodge:" (integer (* ?cf-grace_lodge 100)) "%")
	(printout t crlf "Alzheimer's Disease Association:" (integer (* ?cf-alzheimers_disease_association 100)) "%")
	(printout t crlf "KIDNEY DIALYSIS FOUNDATION LIMITED:" (integer (* ?cf-kidney_dialysis_foundation_limited 100)) "%")
	(printout t crlf "Public Free Clinic Society:" (integer (* ?cf-public_free_clinic_society 100)) "%")
	(printout t crlf "ALEXANDRA HEALTH FUND LIMITED:" (integer (* ?cf-alexandra_health_fund_limited 100)) "%")
	(printout t crlf "SOCIETY FOR THE PREVENTION OF CRUELTY TO ANIMALS, SINGAPORE:" (integer (* ?cf-society_for_the_prevention_of_cruelty_to_animals_singapore 100)) "%")
	(printout t crlf "Blossom World Society:" (integer (* ?cf-blossom_world_society 100)) "%")
	(printout t crlf "Waterways Watch Society:" (integer (* ?cf-waterways_watch_society 100)) "%")
	(printout t crlf "ASIA PACIFIC BREWERIES FOUNDATION:" (integer (* ?cf-asia_pacific_breweries_foundation 100)) "%")
	(printout t crlf "THE LAW SOCIETY OF SINGAPORE PRO BONO, LEARNING AND SUPPORT SERVICES:" (integer (* ?cf-the_law_society_of_singapore_pro_bono_learning_and_support_services 100)) "%")
	(printout t crlf "Singapore Indian Development Association (SINDA):" (integer (* ?cf-singapore_indian_development_association_sinda 100)) "%")
	(printout t crlf "SINGAPORE INSTITUTE OF INTERNATIONAL AFFAIRS ENDOWMENT FUND:" (integer (* ?cf-singapore_institute_of_international_affairs_endowment_fund 100)) "%")
	(printout t crlf "Singapore Buddhist Federation, The:" (integer (* ?cf-singapore_buddhist_federation_the 100)) "%")
	(printout t crlf "NEW CREATION CHURCH:" (integer (* ?cf-new_creation_church 100)) "%")
	(printout t crlf "Holy Tree Sri Bala Subramaniar Temple:" (integer (* ?cf-holy_tree_sri_bala_subramaniar_temple 100)) "%")
	(printout t crlf "Muslim Converts' Association of Singapore:" (integer (* ?cf-muslim_converts_association_of_singapore 100)) "%")
	(printout t crlf "Xian Gu Tian:" (integer (* ?cf-xian_gu_tian 100)) "%")
	(printout t crlf "Fei Yue Community Services:" (integer (* ?cf-fei_yue_community_services 100)) "%")
	(printout t crlf "Caritas Singapore Agape Fund:" (integer (* ?cf-caritas_singapore_agape_fund 100)) "%")
	(printout t crlf "Association for Persons with Special Needs:" (integer (* ?cf-association_for_persons_with_special_needs 100)) "%")
	(printout t crlf "Apex Day Rehabilitation Centre For Elderly:" (integer (* ?cf-apex_day_rehabilitation_centre_for_elderly 100)) "%")
	(printout t crlf "Family Life Society:" (integer (* ?cf-family_life_society 100)) "%")
	(printout t crlf "HEB - ASHRAM HALFWAY HOUSE:" (integer (* ?cf-heb___ashram_halfway_house 100)) "%")
	(printout t crlf "FOOTBALLPLUS LTD.:" (integer (* ?cf-footballplus_ltd 100)) "%")
	(printout t crlf "SINGAPORE NATIONAL PARALYMPIC COUNCIL LTD.:" (integer (* ?cf-singapore_national_paralympic_council_ltd 100)) "%")
	(printout t crlf "SPECIAL OLYMPICS ASIA PACIFIC, LTD.:" (integer (* ?cf-special_olympics_asia_pacific_ltd 100)) "%")
	(printout t crlf "SINGAPORE ATHLETIC ASSOCIATION:" (integer (* ?cf-singapore_athletic_association 100)) "%")
	(printout t crlf "The Salvation Army:" (integer (* ?cf-salvation_army_the 100)) "%")


)