;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For easier understanding use:
;; the (watch all) command 
;; the agenda function in IDE. 
;; I commented the final salience so you can see easily what happens for every question
;; use the printout from the cf rules to see the output
;; comments with stars (*) are only for improvement, not for understanding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; DEFINING TEMPLATES AND FACTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal
	?*research_variable* = 0.0
	?*emotional_variable* = 0.0
	?*old_variable* = 0.0
	?*recent_variable* = 0.0)

(deftemplate current_fact (slot fact) (slot cf) (multislot all_vars) (slot name) ;contains all applicable parameters, was faster than creating new slots.               
)
(deftemplate current_goal (slot goal) (slot cf)) ;; the top-level
(deftemplate nameofvariable (slot name) (slot cf)(slot true_or_false))
(deftemplate working_goal (slot goal) (slot cf)) ;; 
(deftemplate branch_indicator (slot name) (slot cf) (slot true_or_false) (slot correct_answer))
(deftemplate recommendation (multislot charity))


;Loading the facts
(deffacts load-facts
	(current_fact (fact ngee_ann_cultural_centre_limited) (cf 0.5) (all_vars arts_and_heritage no_tax_deduct medium money   historical_and_cultural_conservation exist_long   sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website   )( name "NGEE ANN CULTURAL CENTRE LIMITED"))
	(current_fact (fact singapore_indian_fine_arts_society_the) (cf 0.5) (all_vars arts_and_heritage no_tax_deduct medium money   music_and_orchestras exist_long  gov_grants sub_fin_yes ratio_eff_high  sub_gov_not_req gov_rating_low has_website media_exposure  )( name "Singapore Indian Fine Arts Society, The"))
	(current_fact (fact national_book_development_council_of_singapore_the) (cf 0.5) (all_vars arts_and_heritage  medium money   literary_arts exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "National Book Development Council of Singapore, The"))
	(current_fact (fact singapore_clan_foundation) (cf 0.5) (all_vars arts_and_heritage  medium money   historical_and_cultural_conservation exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  )( name "SINGAPORE CLAN FOUNDATION"))
	(current_fact (fact the_esplanade_co_ltd) (cf 0.5) (all_vars arts_and_heritage  large money inkind  music_and_orchestras exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "THE ESPLANADE CO LTD"))
	(current_fact (fact the_dance_company_ltd) (cf 0.5) (all_vars arts_and_heritage  medium money   professional_contemporary_and_ethnic_dance exit_medium  gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website   )( name "T.H.E DANCE COMPANY LTD."))
	(current_fact (fact cake_theatrical_productions_ltd) (cf 0.5) (all_vars arts_and_heritage no_tax_deduct medium money   theatre_and_dramatic_arts exist_long  gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  )( name "CAKE THEATRICAL PRODUCTIONS LTD."))
	(current_fact (fact tampines_arts_troupe) (cf 0.5) (all_vars arts_and_heritage  small money   traditional_ethnic_performing_arts exist_long  gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_mid has_website media_exposure  )( name "Tampines Arts Troupe"))
	(current_fact (fact spot_art_limited) (cf 0.5) (all_vars arts_and_heritage no_tax_deduct small money inkind  visual_arts exist_short  gov_grants sub_fin_no ratio_eff_low  sub_gov_not_req gov_rating_low has_website   )( name "SPOT ART LIMITED"))
	(current_fact (fact radin_mas_ccc_community_development_and_welfare_fund) (cf 0.5) (all_vars community  medium money   central exist_long   sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  )( name "RADIN MAS CCC COMMUNITY DEVELOPMENT AND WELFARE FUND"))
	(current_fact (fact kaki_bukit_ccc_community_development_and_welfare_fund) (cf 0.5) (all_vars community  medium money   north_east exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high  media_exposure  )( name "KAKI BUKIT CCC COMMUNITY DEVELOPMENT AND WELFARE FUND"))
	(current_fact (fact kebun_baru_ccc_community_development_and_welfare_fund) (cf 0.5) (all_vars community  small money   north_west exist_long   sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high  media_exposure  )( name "KEBUN BARU CCC COMMUNITY DEVELOPMENT AND WELFARE FUND"))
	(current_fact (fact fengshan_ccc_community_development_and_welfare_fund) (cf 0.5) (all_vars community  large money   south_east exist_long   sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high  media_exposure  )( name "FENGSHAN CCC COMMUNITY DEVELOPMENT AND WELFARE FUND"))
	(current_fact (fact bukit_batok_ccc_community_development_and_welfare_fund) (cf 0.5) (all_vars community  medium money   south_west exist_long invest_reserves  sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  )( name "BUKIT BATOK CCC COMMUNITY DEVELOPMENT AND WELFARE FUND"))
	(current_fact (fact the_friends_of_the_university_of_warwick_in_singapore) (cf 0.5) (all_vars education  small money   foreign_educational_institutions_and_funds exist_short   sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_mid  media_exposure  )( name "The Friends of The University of Warwick in Singapore"))
	(current_fact (fact methodist_schools_foundation) (cf 0.5) (all_vars education  medium money   foundations_and_trusts exist_long invest_reserves  sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website   )( name "METHODIST SCHOOLS' FOUNDATION"))
	(current_fact (fact hwa_chong_international_school_education_fund) (cf 0.5) (all_vars education  small money   local_educational_institutions_and_funds exist_long invest_reserves  sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website   )( name "Hwa Chong International School Education Fund"))
	(current_fact (fact girl_guides_singapore) (cf 0.5) (all_vars education  medium money  volunteer uniformed_groups exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_not_req gov_rating_low has_website media_exposure  )( name "Girl Guides Singapore"))
	(current_fact (fact national_skin_centre_health_endowment_fund) (cf 0.5) (all_vars health  small money   cluster_and_hospital_funds exist_long invest_reserves  sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high    )( name "NATIONAL SKIN CENTRE HEALTH ENDOWMENT FUND"))
	(current_fact (fact ren_ci_hospital) (cf 0.5) (all_vars health  large money inkind volunteer community_and_chronic_sick_hospital exit_medium invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure has_chequered past  )( name "REN CI HOSPITAL"))
	(current_fact (fact sata_commhealth) (cf 0.5) (all_vars health no_tax_deduct large money  volunteer day_rehabilitation_centre exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "SATA COMMHEALTH"))
	(current_fact (fact ronald_mcdonald_house_charities_singapore) (cf 0.5) (all_vars health no_tax_deduct medium money   diseases_and_illnessess_support_group exist_long invest_reserves  sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "RONALD MCDONALD HOUSE CHARITIES SINGAPORE"))
	(current_fact (fact academy_of_medicine_singapore) (cf 0.5) (all_vars health  large money   health_professional_group exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "ACADEMY OF MEDICINE SINGAPORE"))
	(current_fact (fact home_nursing_foundation) (cf 0.5) (all_vars health  large money  volunteer home_care exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  )( name "HOME NURSING FOUNDATION"))
	(current_fact (fact assisi_hospice) (cf 0.5) (all_vars health  large money  volunteer hospice exit_medium invest_reserves gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "ASSISI HOSPICE"))
	(current_fact (fact hca_hospice_care) (cf 0.5) (all_vars health  large money  volunteer palliative_home_care exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  )( name "HCA Hospice Care"))
	(current_fact (fact grace_lodge) (cf 0.5) (all_vars health  large money  volunteer nursing_home exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "Grace Lodge"))
	(current_fact (fact alzheimers_disease_association) (cf 0.5) (all_vars health  large money  volunteer community_based_services exist_long  gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  )( name "Alzheimer's Disease Association"))
	(current_fact (fact kidney_dialysis_foundation_limited) (cf 0.5) (all_vars health  large money  volunteer renal_dialysis exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  )( name "KIDNEY DIALYSIS FOUNDATION LIMITED"))
	(current_fact (fact public_free_clinic_society) (cf 0.5) (all_vars health  large money  volunteer tcm_clinic exist_long invest_reserves  sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high media_exposure  )( name "Public Free Clinic Society"))
	(current_fact (fact alexandra_health_fund_limited) (cf 0.5) (all_vars health  medium money  volunteer trust_and_research_funds exist_short invest_reserves  sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high  media_exposure  )( name "ALEXANDRA HEALTH FUND LIMITED"))
	(current_fact (fact society_for_the_prevention_of_cruelty_to_animals_singapore) (cf 0.5) (all_vars others  medium money inkind volunteer animal_welfare exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "SOCIETY FOR THE PREVENTION OF CRUELTY TO ANIMALS, SINGAPORE"))
	(current_fact (fact blossom_world_society) (cf 0.5) (all_vars others  medium money   children_and_youth exist_short  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "Blossom World Society"))
	(current_fact (fact waterways_watch_society) (cf 0.5) (all_vars others  medium money   environment exist_long  gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_mid has_website media_exposure  )( name "Waterways Watch Society"))
	(current_fact (fact asia_pacific_breweries_foundation) (cf 0.5) (all_vars others  medium money  volunteer general_charitable_purposes exist_long invest_reserves  sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_mid has_website media_exposure  )( name "ASIA PACIFIC BREWERIES FOUNDATION"))
	(current_fact (fact the_law_society_of_singapore_pro_bono_learning_and_support_services) (cf 0.5) (all_vars others  medium money   humanitarian_aid exist_long  gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  )( name "THE LAW SOCIETY OF SINGAPORE PRO BONO, LEARNING AND SUPPORT SERVICES"))
	(current_fact (fact singapore_indian_development_association_sinda) (cf 0.5) (all_vars others  large money  volunteer self_help_groups exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  )( name "Singapore Indian Development Association (SINDA)"))
	(current_fact (fact singapore_institute_of_international_affairs_endowment_fund) (cf 0.5) (all_vars others  medium money   think_tanks exist_long   sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  )( name "SINGAPORE INSTITUTE OF INTERNATIONAL AFFAIRS ENDOWMENT FUND"))
	(current_fact (fact singapore_buddhist_federation_the) (cf 0.5) (all_vars religious no_tax_deduct medium money buddhism exist_long  gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website )( name "Singapore Buddhist Federation, The"))
	(current_fact (fact new_creation_church) (cf 0.5) (all_vars religious no_tax_deduct large money  volunteer christianity exist_long  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_mid has_website media_exposure  )( name "NEW CREATION CHURCH"))
	(current_fact (fact holy_tree_sri_bala_subramaniar_temple) (cf 0.5) (all_vars religious no_tax_deduct medium money hinduism exist_long   sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website)( name "Holy Tree Sri Bala Subramaniar Temple"))
	(current_fact (fact muslim_converts_association_of_singapore) (cf 0.5) (all_vars religious no_tax_deduct medium money  volunteer islam exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "Muslim Converts' Association of Singapore"))
	(current_fact (fact xian_gu_tian) (cf 0.5) (all_vars religious no_tax_deduct medium money   taoism exist_long   sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high    )( name "Xian Gu Tian"))
	(current_fact (fact fei_yue_community_services) (cf 0.5) (all_vars social_and_welfare  large money  volunteer children_and_youth exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website )( name "Fei Yue Community Services"))
	(current_fact (fact caritas_singapore_agape_fund) (cf 0.5) (all_vars social_and_welfare no_tax_deduct large money   community exist_long invest_reserves  sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_high has_website media_exposure  )( name "Caritas Singapore Agape Fund"))
	(current_fact (fact association_for_persons_with_special_needs) (cf 0.5) (all_vars social_and_welfare  large money inkind disability_adult exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_mid has_website )( name "Association for Persons with Special Needs"))
	(current_fact (fact apex_day_rehabilitation_centre_for_elderly) (cf 0.5) (all_vars social_and_welfare  medium money  volunteer eldercare gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website   )( name "Apex Day Rehabilitation Centre For Elderly"))
	(current_fact (fact family_life_society) (cf 0.5) (all_vars social_and_welfare  medium money  volunteer family exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  )( name "Family Life Society"))
	(current_fact (fact heb___ashram_halfway_house) (cf 0.5) (all_vars social_and_welfare  medium money   support_groups exit_medium  gov_grants sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high has_website media_exposure  )( name "HEB - ASHRAM HALFWAY HOUSE"))
	(current_fact (fact footballplus_ltd) (cf 0.5) (all_vars sports  small money   competitive_sports exist_short  gov_grants sub_fin_yes ratio_eff_high fin_health_poor sub_gov_yes gov_rating_mid has_website   )( name "FOOTBALLPLUS LTD."))
	(current_fact (fact singapore_national_paralympic_council_ltd) (cf 0.5) (all_vars sports  medium money   disability_sports exit_medium  gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  )( name "SINGAPORE NATIONAL PARALYMPIC COUNCIL LTD."))
	(current_fact (fact special_olympics_asia_pacific_ltd) (cf 0.5) (all_vars sports no_tax_deduct large money inkind  non_nsas exit_medium   sub_fin_yes ratio_eff_low  sub_gov_yes gov_rating_high  media_exposure  )( name "SPECIAL OLYMPICS ASIA PACIFIC, LTD."))
	(current_fact (fact singapore_athletic_association) (cf 0.5) (all_vars sports no_tax_deduct medium money inkind volunteer nsas exit_medium  gov_grants sub_fin_yes ratio_eff_med  sub_gov_yes gov_rating_high has_website media_exposure  )( name "SINGAPORE ATHLETIC ASSOCIATION"))
	(current_fact (fact salvation_army_the) (cf 0.5) (all_vars social_and_welfare  large money inkind volunteer community exist_long invest_reserves gov_grants sub_fin_yes ratio_eff_high  sub_gov_yes gov_rating_mid has_website media_exposure  )( name "The Salvation Army"))

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
    (branch_indicator (name first_question) (true_or_false UNKNOWN))
)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BUSINESS RULES
;;; The idea is: you want to ask for input, and then use that input to get the relevant cf for all relevant charities (see engine rule)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;**** Rule 0: Ask user whether he is an individual or corporate.
(defrule indiv_corpo
    ; 1. You need an indicator for starting + CLIPS does not let you change this if you don't put it into a variable:
    ?branch_indicator <- (branch_indicator (name first_question) (true_or_false UNKNOWN))
    =>	
    (printout t crlf "
    	______________________________________________________________________
    	
	Hi, welcome to our CLIPS engine. 
	We notice that instead of using our beautiful GUI program in JAVA, 
	you use the CLIPS program. Please note that this will lead to a lesser
	user experience.
	______________________________________________________________________

That said, the first question is: 

Are you a corporate or an individual user? 
c = corporate, i = individual (type in c/i and then press the ENTER button)? ") 
	(bind ?response (read))
(switch ?response
     (case c then
        (assert (corporate)))
    (case i then 
        (assert (individual)))
    (default 
	(printout t crlf "Not a valid answer, please try again.")
	(retract ?branch_indicator)
	(assert (branch_indicator (name first_question)(true_or_false UNKNOWN)))
	)
     )
  )
        

;**** Rule 1: Ask user preference for size.
(defrule donation_type
    ; 1. You need an indicator for starting + CLIPS does not let you change this if you don't put it into a variable:
    ?branch_indicator <- (branch_indicator (name only_kind_or_time)(true_or_false UNKNOWN))
    =>	
    (printout t crlf "What is your preferred donation type? ") 
	(printout t crlf "k = donation in kind, m = donation in money, v = donation in volunteering (type in k/m/v)?") 
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

	
;**** Rule8: Ask if want tax
(defrule tax
    (current_question tax_exemption)
   ; (branch_indicator (name only_kind_or_time) (true_or_false FALSE))	
=>	(printout t crlf "Would you prefer your charity to have a 'tax exemption' status?")
	(printout t crlf "y = yes, n = no (type in y/n)? ")  
    (bind ?response (read))
; *Create a name variable as input for the next function --> can become a modify!
    (if (eq ?response y) then 
        (assert (nameofvariable (name no_tax_deduct)(cf -1)(true_or_false TRUE)))
	)
)


;**** Rule17:  IF reseach AND emotional --> least value will influence the result
(defrule rational_user
=>	(printout t crlf "Please indicate to what extent you agree with the following statements:
	")
	(printout t crlf "I like to do my own extensive research before making a decision")
	(printout t crlf "1 = strongly disagree, 2 = disagree, 3 = neutral, 4 = agree, 5 = strongly agree (type in 1/2/3/4/5)")
	(bind ?response1 (read))
	;emotional does not dislike effective, so no negative values:
	(switch ?response1
		(case 1 then    (bind ?*research_variable* 0))
		(case 2 then 	(bind ?*research_variable* 0.1))
		(case 3 then 	(bind ?*research_variable* 0.2) (assert (is_not_emotional)))
		(case 4 then 	(bind ?*research_variable* 0.3) (assert (is_not_emotional)))
		(case 5 then 	(bind ?*research_variable* 0.4) (assert (is_not_emotional)))		

	)
	(printout t crlf)
	(printout t crlf "When I read depressing news I feel emotionally affected")
	(printout t crlf "1 = strongly disagree,  2 = disagree, 3 = neutral, 4 = agree, 5 = strongly agree (type in 1/2/3/4/5)")  
	(bind ?response2 (read))
	(switch ?response2
		(case 1 then    (bind ?*emotional_variable* 0.4) (assert (is_not_emotional)))
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



; Rule15: Ask for charity size 
(defrule charity_size
    ; (current_question charity_size)
=>	(printout t crlf "Do you prefer small, midsize or large charities?") 
	(printout t crlf "s = small, m = midsize, l = large (type in s/m/l)? ") 
	(bind ?response (read))
	(switch ?response
; *edit true_or_false to something more intelligable --> run_engine_rule
		(case s then    (assert (nameofvariable (name small)(cf 0.3)(true_or_false TRUE))))
		(case m then 	(assert (nameofvariable (name medium)(cf 0.3)(true_or_false TRUE))))
		(case l then 	(assert (nameofvariable (name large)(cf 0.3)(true_or_false TRUE))))
	)
)

;**** Rule9:  prefer to donate to charities which invest 
(defrule charity_investment
	(is_not_emotional)
=>	(printout t crlf "Do you mind donating to charities which do commercial investments?") 
	(printout t crlf "y = yes, n = no (type in y/n)? ")  
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name invest_reserves)(cf -0.3)(true_or_false TRUE)))
	)
)

;**** Rule10:  preference for Government funded charities CF value as per doc 1 
(defrule charity_gov_funded
	(is_not_emotional)
=>	(printout t crlf "Do you prefer government funded charities or non-government funded charities?")
	(printout t crlf "g = gov. funded, n = non gov. funded (type in g/n)? ")   
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
=>	(printout t crlf "Please indicate your preferred level of program efficiency of the charity (ratio money spend on charitable causes compared to money spend on other activities)")
	(printout t crlf "(l=low amount to charitable causes,  m=medium amount to charitable causes, h=high amount to charitable causes)") 
	(printout t crlf "(type in l/m/h)") 
	(bind ?response (read))
	(switch ?response
		(case l then (assert (nameofvariable (name ratio_eff_low)(cf 0.4)(true_or_false TRUE))))
		(case m then (assert (nameofvariable (name ratio_eff_med)(cf 0.4)(true_or_false TRUE))))
		(case h then (assert (nameofvariable (name ratio_eff_high)(cf 0.4)(true_or_false TRUE))))
	)
)

;**** Rule13:  preference for charities which submitted compliance 
(defrule charity_gov_compl
	(is_not_emotional)
=>	(printout t crlf "Do you prefer to donate to charities which submitted code of compliance? (y/n)") 
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name sub_gov_yes)(cf 0.5)(true_or_false TRUE)))
; to make sure that not all charities get a high score we use a minus instead of a high cf for this important factor
	(assert (nameofvariable (name sub_gov_no)(cf -0.3)(true_or_false TRUE)))
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; the sector-subsector rules ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;**** Rule16:  choice of Sector
(defrule charity_choice
=>	(printout t crlf "In which kind of charities, would you like to donate?  (Please enter the option number)") 
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
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE)))
						(assert(current_question health_subsector)))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE)))
						(assert(current_question community_neighbourhood)))
		(case 5 then    (assert (nameofvariable (name religious)(cf 0.6)(true_or_false TRUE)))
						(assert(current_question religion_subsector)))
		(case 6 then 	(assert (nameofvariable (name social_and_welfare)(cf 0.6)(true_or_false TRUE)))
						(assert(current_question social_subsector)))
		(case 7 then 	(assert (nameofvariable (name sports)(cf 0.6)(true_or_false TRUE)))
						(assert(current_question sports_subsector)))
		(case 8 then 	(assert (nameofvariable (name others)(cf 0.6)(true_or_false TRUE)))
						(assert(current_question others_commemorating))
		
		)		
	)
)

;Rule: Arts and Heritage
(defrule arts_and_heritage_support
	(current_question arts_and_heritage_support)
=>	
	(printout t crlf "Do you agree with the following statement:")
	(printout t crlf "I support conserving history and traditional cultures")
	(printout t crlf "1 = strongly disagree, 2 = disagree, 3 = neutral, 4 = agree, 5 = strongly agree (type in 1/2/3/4/5)")
	(bind ?response (read))
	(switch ?response
		(case 1 then   (assert (nameofvariable (name historical_and_cultural_conservation)(cf -0.5)(true_or_false TRUE))))
		(case 2 then (assert (nameofvariable (name historical_and_cultural_conservation)(cf -0.3)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name historical_and_cultural_conservation)(cf  0.3)(true_or_false TRUE))))
		(case 5 then 	(assert (nameofvariable (name historical_and_cultural_conservation)(cf  0.5)(true_or_false TRUE))))
	)
	(assert(current_question arts_and_heritage_subsector))
)
;Rule: Choice of SubSector
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

;Rule: Education Branch scholarship
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

;Rule: choice of SubSector education
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
		(case 11 then   (assert (nameofvariable(name renal_dialysis)(cf 0.7)(true_or_false TRUE))))
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
;The choice for religion has a very high impact and our experts said that they are mutually exclusive, so that is why we excluded the other ones
		(case 1 then    (assert (nameofvariable (name buddhism)(cf 0.9)(true_or_false TRUE)))
				(assert (nameofvariable (name christianity)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name hinduism)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name islam)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name taoism)(cf -0.8)(true_or_false TRUE)))
			)
		(case 2 then 	(assert (nameofvariable (name christianity)(cf 0.9)(true_or_false TRUE)))
				(assert (nameofvariable (name buddhism)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name hinduism)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name islam)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name taoism)(cf -0.8)(true_or_false TRUE)))
			)
		(case 3 then 	(assert (nameofvariable (name hinduism)(cf 0.9)(true_or_false TRUE)))
				(assert (nameofvariable (name buddhism)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name christianity)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name islam)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name taoism)(cf -0.8)(true_or_false TRUE)))
			)
		(case 4 then 	(assert (nameofvariable (name islam)(cf 0.9)(true_or_false TRUE)))
				(assert (nameofvariable (name buddhism)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name christianity)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name hinduism)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name taoism)(cf -0.8)(true_or_false TRUE)))
			)
		(case 5 then 	(assert (nameofvariable (name taoism)(cf 0.9)(true_or_false TRUE)))
				(assert (nameofvariable (name buddhism)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name christianity)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name hinduism)(cf -0.8)(true_or_false TRUE)))
				(assert (nameofvariable (name islam)(cf -0.8)(true_or_false TRUE)))
			)
	)
)

;**** Rule:  choice of SubSector others
(defrule others_commemorating
	(current_question others_commemorating)
=>	(printout t crlf "Do you celebrate the days commemorating the environment day like June 5th, Earth day?  (y/n)") 
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

;**** Rule11: If a user prefers charities have a lot of experience OR prefers charities that focus on short term, update cf:
(defrule years_established
=>	(printout t crlf " Please indicate to what extent you agree with the following statements:
When I support charities, I care about the experience of the employees.
	") 
	(printout t crlf "1 = strongly disagree, 2 = disagree, 3 = neutral, 4 = agree, 5 = strongly agree (type in 1/2/3/4/5)
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
	(printout t crlf "I prefer charities that have been examined multiple times by accountants.
	") 
	(printout t crlf "1 = strongly disagree, 2 = disagree, 3 = neutral, 4 = agree, 5 = strongly agree (type in 1/2/3/4/5)
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
	(assert (nameofvariable (name exist_long) (cf (* (max ?*old_variable* ?*recent_variable*) 0.3))(true_or_false TRUE)))
	(assert (nameofvariable (name exist_medium) (cf (* (max ?*old_variable* ?*recent_variable*) 0.1))(true_or_false TRUE)))
)


;**** Rule:  Do you mind donating to charities that have checkered past(variable not clear)
(defrule charity_past
=>	(printout t crlf "Are you willing to donate to charities that have a checkered past (but have since been rehabilitated)? (y/n)") 
	(bind ?response (read))
    (if (eq ?response n) then 
        (assert (nameofvariable (name has_chequered_past)(cf -0.8)(true_or_false TRUE)))
		
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
=>	(printout t crlf "Please choose the type of the charity to which your friends donate to (please enter the option number)")
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
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.3)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.3)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.3)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.3)(true_or_false TRUE))))
		(case 5 then    (assert (nameofvariable (name religious)(cf 0.3)(true_or_false TRUE))))
		(case 6 then 	(assert (nameofvariable (name social_and_welfare)(cf 0.3)(true_or_false TRUE))))
		(case 7 then 	(assert (nameofvariable (name sports)(cf 0.3)(true_or_false TRUE))))
		(case 8 then 	(assert (nameofvariable (name others)(cf 0.3)(true_or_false TRUE))))	
	)
	(assert (current_question charity_spouse))
)

;**** Rule3:  sectors friends donate to and user age(considering their age <12 need to add code to check  age
(defrule charity_friends_Sector2
	(current_question charity_friends_below)
=>	(printout t crlf "Please choose the type of the charity to which your friends donate to (please enter the option number)")
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
		(case 1 then    (assert (nameofvariable (name arts_and_heritage)(cf 0.2)(true_or_false TRUE))))
		(case 2 then 	(assert (nameofvariable (name education)(cf 0.2)(true_or_false TRUE))))
		(case 3 then 	(assert (nameofvariable (name health)(cf 0.2)(true_or_false TRUE))))
		(case 4 then 	(assert (nameofvariable (name community)(cf 0.2)(true_or_false TRUE))))
		(case 5 then    (assert (nameofvariable (name religious)(cf 0.2)(true_or_false TRUE))))
		(case 6 then 	(assert (nameofvariable (name social_and_welfare)(cf 0.2)(true_or_false TRUE))))
		(case 7 then 	(assert (nameofvariable (name sports)(cf 0.2)(true_or_false TRUE))))
		(case 8 then 	(assert (nameofvariable (name others)(cf 0.2)(true_or_false TRUE))))	
	)
	(assert (current_question charity_received_help))
)

;**** Rule21:  Influence of spouse Sectors spouse donate to 
(defrule charity_spouse
	(current_question charity_spouse)
=>	(printout t crlf "Please choose the type of the charity to which your spouse donate to please enter the option number)")
    (printout t crlf "1.Arts_and_heritage")
	(printout t crlf "2.Education")
	(printout t crlf "3.Health")
    (printout t crlf "4.Community")
	(printout t crlf "5.Religious")
	(printout t crlf "6.Social and Welfare")
	(printout t crlf "7.Sports")
	(printout t crlf "8.Others")
	(printout t crlf "9.None of the above/not married" crlf)
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
=>	(printout t crlf "Do you prefer charities to have a large or small media coverage? (s/l)") 
	(bind ?response (read))
    (if (eq ?response y) then 
        (assert (nameofvariable (name media_exposure)(cf 0.2)(true_or_false TRUE)))	
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
=>	(printout t crlf "If you have a role model that donates to charity, to which sector does he or she donates (please enter the option number)?
	") 
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
	(printout t crlf "Our charity recommender has finished the calculations!
		")
	(printout t crlf "Please note that our user-friendly JAVA multi-platform version provides for a much nicer list with a website and a nice suggestion of other charities")

	(printout t crlf "Our charity recommender recommends:")
	(assert (get_recommendations))	

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ENGINE RULE (RULE THAT SELECTS THE RIGHT CHARITIES AND ADJUSTS THEIR CF)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule selecting_the_right_charities
    ; *for the time being I kept salience in --> to make sure it doesn't go to the next question after this:
    (declare (salience 3))
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
  (declare (salience 2))
  ?f1 <- (current_goal (goal ?g)(cf ?cf1&:(>= ?cf1 0)))
  ?f2 <- (working_goal (goal ?g)(cf ?cf2&:(>= ?cf2 0)))
  (test (neq ?f1 ?f2))
  =>
  (retract ?f2)
  (modify ?f1 (cf =(+ ?cf1 (* ?cf2 (- 1 ?cf1)))))
)

(defrule combine-neg-cf
 (declare (salience 1))
  ?f1 <- (current_goal   (goal ?g)(cf ?cf1&:(< ?cf1 0)))
  ?f2 <- (working_goal (goal ?g)(cf ?cf2&:(< ?cf2 0)))
  (test (neq ?f1 ?f2))
  =>
  (retract ?f2)
  (modify ?f1 (cf =(+ ?cf1 (* ?cf2 (+ 1 ?cf1)))))
)

(defrule neg-pos-cf
 (declare (salience 1))
  ?f1 <- (current_goal (goal ?g) (cf ?cf1))
  ?f2 <- (working_goal (goal ?g) (cf ?cf2))
  (test (neq ?f1 ?f2))
  (test (< (* ?cf1 ?cf2) 0))
  =>
  (retract ?f2)
  (modify ?f1 (cf =(/ (+ ?cf1 ?cf2) (- 1 (min (abs ?cf1) (abs ?cf2))))))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; final print out functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule getting_the_recommendations
	(get_recommendations)
	(current_goal (goal ?charity_var) (cf ?cf_var2))
	=>
	(assert (recommendation (charity ?charity_var ?cf_var2)))
	)

(defrule printing_recommendations
	(recommendation (charity ?first ?second))
	(current_fact (fact ?first) (name ?stringname))
	=>
	(printout t crlf ?stringname " with a certainty of " (integer (* ?second 100)) "%")
	)