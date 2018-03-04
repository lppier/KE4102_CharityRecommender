/**
 * ClipsAssertsHandler
 * <p>
 * Note: All clips assert statements for questions belong here.
 */

package com.company;

import java.util.*;

public class ClipsAssertsHandler {

    // Hashtable storing the answers for each question. Pass in answer to get the vector of assert statements
    private Hashtable<String, Vector<String>> corporate_individual_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> donation_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_size_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_invest_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_gov_funded_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_fin_eff_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_gov_compl_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_research_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_sad_stories_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> section_charity_attributes_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> section_sector_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_established_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_past_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_parents_sector_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_spouse_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_received_help_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> twelve_years_old_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_friends_above_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_friends_below_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_media_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_website_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_influence_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> tax_return_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> religious_subsector_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> sector_preference_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> arts_and_heritage_support_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> arts_and_heritage_subsector_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> education_scholarship_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> education_subsector_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> community_neighbourhood_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> community_location_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> health_subsector_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> others_commemorating_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> others_pet_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> others_humanitarian_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> others_children_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> sports_subsector_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> social_subsector_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> experience_employees_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> multiple_accounting_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> section_external_influence_hash = new Hashtable<>();

    public boolean initializeHashes() {
        try {

            {  // corporate_or_individual
                Vector<String> i_ans = new Vector<>();
                i_ans.add("(assert (individual))");
                i_ans.add("(assert (current_question donation_type))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (corporate))");
                c_ans.add("(assert (current_question donation_type))");

                corporate_individual_hash.put("c", c_ans);
                corporate_individual_hash.put("i", i_ans);
            }

            {   // donation_type
                Vector<String> k_ans = new Vector<>();
                k_ans.add("(assert (nameofvariable (name inkind)(cf 1)(true_or_false TRUE)))");
                k_ans.add("(assert (donation_type_kind))");

                Vector<String> m_ans = new Vector<>();
                m_ans.add("(assert (nameofvariable (name money)(cf 1)(true_or_false TRUE)))");
                m_ans.add("(assert (donation_type_money))");

                Vector<String> v_ans = new Vector<>();
                v_ans.add("(assert (nameofvariable (name volunteer)(cf 1)(true_or_false TRUE)))");
                v_ans.add("(assert (donation_type_volunteering))");

                donation_hash.put("k", k_ans);
                donation_hash.put("m", m_ans);
                donation_hash.put("v", v_ans);
            }

            {   // charity_size qn
                Vector<String> small_ans = new Vector<>();
                small_ans.add("(assert (nameofvariable (name small)(cf 0.3)(true_or_false TRUE)))");
                small_ans.add("(assert (charity_size_done))");
                Vector<String> medium_ans = new Vector<>();
                medium_ans.add("(assert (nameofvariable (name medium)(cf 0.3)(true_or_false TRUE)))");
                medium_ans.add("(assert (charity_size_done))");
                Vector<String> large_ans = new Vector<>();
                large_ans.add("(assert (nameofvariable (name large)(cf 0.3)(true_or_false TRUE)))");
                large_ans.add("(assert (charity_size_done))");
                charity_size_hash.put("small", small_ans);
                charity_size_hash.put("medium", medium_ans);
                charity_size_hash.put("large", large_ans);
            }

            {   // charity_invest qn
                Vector<String> yes_ans = new Vector<>();
                yes_ans.add("(assert (nameofvariable (name invest_reserves)(cf -0.3)(true_or_false TRUE)))");
                yes_ans.add("(assert (current_question charity_gov_funded))");

                Vector<String> no_ans = new Vector<>();
                no_ans.add("(assert (current_question charity_gov_funded))");

                charity_invest_hash.put("y", yes_ans);
                charity_invest_hash.put("n", no_ans);
            }

            {   // charity_gov_funded qn
                Vector<String> yes_ans = new Vector<>();
                yes_ans.add("(assert (nameofvariable (name gov_grants)(cf 0.4)(true_or_false TRUE)))");
                yes_ans.add("(assert (current_question charity_fin_eff))");

                Vector<String> no_ans = new Vector<>();
                no_ans.add("(assert (nameofvariable (name gov_grants)(cf -0.4)(true_or_false TRUE)))");
                no_ans.add("(assert (current_question charity_fin_eff))");

                charity_gov_funded_hash.put("y", yes_ans);
                charity_gov_funded_hash.put("n", no_ans);

            }

            {   // tax_return
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name no_tax_deduct)(cf -1)(true_or_false TRUE)))");
                    y_ans.add("(assert (current_question charity_research))");
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question charity_research))");
                tax_return_hash.put("y", y_ans);
                tax_return_hash.put("n", n_ans);
            }

            {   //  charity_fin_eff qn
                Vector<String> low_ans = new Vector<>();
                low_ans.add("(assert (nameofvariable (name ratio_eff_low)(cf 0.4)(true_or_false TRUE)))");
                low_ans.add("(assert (current_question charity_gov_compl))");
                Vector<String> medium_ans = new Vector<>();
                medium_ans.add("(assert (nameofvariable (name ratio_eff_med)(cf 0.4)(true_or_false TRUE)))");
                medium_ans.add("(assert (current_question charity_gov_compl))");
                Vector<String> high_ans = new Vector<>();
                high_ans.add("(assert (nameofvariable (name ratio_eff_high)(cf 0.4)(true_or_false TRUE)))");
                high_ans.add("(assert (current_question charity_gov_compl))");
                charity_fin_eff_hash.put("l", low_ans);
                charity_fin_eff_hash.put("m", medium_ans);
                charity_fin_eff_hash.put("h", high_ans);
            }

            {   // charity_gov_compl
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name sub_gov_yes)(cf 0.5)(true_or_false TRUE)))");
                y_ans.add("(assert (nameofvariable (name sub_gov_no)(cf -0.3)(true_or_false TRUE)))");
                y_ans.add("(assert (current_question section_sector))");
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question section_sector))");
                charity_gov_compl_hash.put("y", y_ans);
                charity_gov_compl_hash.put("n", n_ans);
            }

            {
                // charity_research_hash (likert scale)
                Vector<String> a_ans = new Vector<>();
                //a_ans.add("(bind ?*research_variable* 0)");
                a_ans.add("(assert (research 0))");
                a_ans.add("(assert (current_question charity_sad_stories))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (research 0.1))");
                b_ans.add("(assert (current_question charity_sad_stories))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (research 0.2))");
                c_ans.add("(assert (is_rational))");
                c_ans.add("(assert (current_question charity_sad_stories))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (research 0.3))");
                d_ans.add("(assert (is_rational))");
                d_ans.add("(assert (current_question charity_sad_stories))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (research 0.4))");
                e_ans.add("(assert (is_rational))");
                e_ans.add("(assert (current_question charity_sad_stories))");

                charity_research_hash.put("a", a_ans);
                charity_research_hash.put("b", b_ans);
                charity_research_hash.put("c", c_ans);
                charity_research_hash.put("d", d_ans);
                charity_research_hash.put("e", e_ans);
            }

            {
                // charity_sad_stories (likert scale)
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (emotional 0.4))");
                a_ans.add("(assert (is_rational))");
                a_ans.add("(assert (current_question section_charity_attributes))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (emotional 0.3))");
                b_ans.add("(assert (is_rational))");
                b_ans.add("(assert (current_question section_charity_attributes))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (emotional 0.2))");
                c_ans.add("(assert (is_rational))");
                c_ans.add("(assert (current_question section_charity_attributes))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (emotional 0.1))");
                d_ans.add("(assert (current_question section_charity_attributes))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (emotional 0))");
                e_ans.add("(assert (current_question section_charity_attributes))");

                charity_sad_stories_hash.put("a", a_ans);
                charity_sad_stories_hash.put("b", b_ans);
                charity_sad_stories_hash.put("c", c_ans);
                charity_sad_stories_hash.put("d", d_ans);
                charity_sad_stories_hash.put("e", e_ans);
            }

            {  // section_charity_attributes
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (current_question charity_size))");
                section_charity_attributes_hash.put("section", a_ans);
            }

            {   // section_external_influence
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (current_question charity_past))");
                section_external_influence_hash.put("section", a_ans);
            }

            {   //  charity_established qn
                Vector<String> short_ans = new Vector<>();
                short_ans.add("(assert (nameofvariable (name exist_short)(cf 0.5)(true_or_false TRUE)))");
                short_ans.add("(assert (current_question charity_past))");
                Vector<String> medium_ans = new Vector<>();
                medium_ans.add("(assert (nameofvariable (name exist_medium)(cf 0.6)(true_or_false TRUE)))");
                medium_ans.add("(assert (current_question charity_past))");
                Vector<String> long_ans = new Vector<>();
                long_ans.add("(assert (nameofvariable (name exist_long)(cf 0.7)(true_or_false TRUE)))");
                long_ans.add("(assert (current_question charity_past))");
                charity_established_hash.put("s", short_ans);
                charity_established_hash.put("m", medium_ans);
                charity_established_hash.put("l", long_ans);
            }

            {   // charity_past
                Vector<String> y_ans = new Vector<>();

                y_ans.add("(assert (current_question charity_parents_sector))");
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (nameofvariable (name has_chequered_past)(cf -0.8)(true_or_false TRUE)))");
                n_ans.add("(assert (current_question charity_parents_sector))");
                charity_past_hash.put("y", y_ans);
                charity_past_hash.put("n", n_ans);
            }

            {
                // charity_parents_sector
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name arts_and_heritage)(cf 0.4)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question twelve_years_old))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name education)(cf 0.4)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question twelve_years_old))");

                Vector<String> h_ans = new Vector<>();
                h_ans.add("(assert (nameofvariable (name health)(cf 0.4)(true_or_false TRUE)))");
                h_ans.add("(assert (current_question twelve_years_old))");

                Vector<String> r_ans = new Vector<>();
                r_ans.add("(assert (nameofvariable (name religious)(cf 0.4)(true_or_false TRUE)))");
                r_ans.add("(assert (current_question twelve_years_old))");

                Vector<String> sw_ans = new Vector<>();
                sw_ans.add("(assert (nameofvariable (name social_and_welfare)(cf 0.4)(true_or_false TRUE)))");
                sw_ans.add("(assert (current_question twelve_years_old))");

                Vector<String> sp_ans = new Vector<>();
                sp_ans.add("(assert (nameofvariable (name sports)(cf 0.4)(true_or_false TRUE)))");
                sp_ans.add("(assert (current_question twelve_years_old))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name community)(cf 0.4)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question twelve_years_old))");

                Vector<String> o_ans = new Vector<>();
                o_ans.add("(assert (nameofvariable (name others)(cf 0.4)(true_or_false TRUE)))");
                o_ans.add("(assert (current_question twelve_years_old))");

                Vector<String> t_ans = new Vector<>();
                t_ans.add("(assert (current_question twelve_years_old))");

                charity_parents_sector_hash.put("a", a_ans);
                charity_parents_sector_hash.put("e", e_ans);
                charity_parents_sector_hash.put("h", h_ans);
                charity_parents_sector_hash.put("c", c_ans);
                charity_parents_sector_hash.put("r", r_ans);
                charity_parents_sector_hash.put("sw", sw_ans);
                charity_parents_sector_hash.put("sp", sp_ans);
                charity_parents_sector_hash.put("o", o_ans);
                charity_parents_sector_hash.put("t", t_ans);
            }

            {   // twelve_years_old
                Vector<String> u_ans = new Vector<>();
                u_ans.add("(assert (current_question charity_friends_below))");
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (current_question charity_friends_above))");
                twelve_years_old_hash.put("u", u_ans);
                twelve_years_old_hash.put("a", a_ans);
            }

            {
                // charity_friends_above
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name arts_and_heritage)(cf 0.3)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question charity_spouse))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name education)(cf 0.3)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question charity_spouse))");

                Vector<String> h_ans = new Vector<>();
                h_ans.add("(assert (nameofvariable (name health)(cf 0.3)(true_or_false TRUE)))");
                h_ans.add("(assert (current_question charity_spouse))");

                Vector<String> r_ans = new Vector<>();
                r_ans.add("(assert (nameofvariable (name religious)(cf 0.3)(true_or_false TRUE)))");
                r_ans.add("(assert (current_question charity_spouse))");

                Vector<String> sw_ans = new Vector<>();
                sw_ans.add("(assert (nameofvariable (name social_and_welfare)(cf 0.3)(true_or_false TRUE)))");
                sw_ans.add("(assert (current_question charity_spouse))");

                Vector<String> sp_ans = new Vector<>();
                sp_ans.add("(assert (nameofvariable (name sports)(cf 0.3)(true_or_false TRUE)))");
                sp_ans.add("(assert (current_question charity_spouse))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name community)(cf 0.3)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question charity_spouse))");

                Vector<String> o_ans = new Vector<>();
                o_ans.add("(assert (nameofvariable (name others)(cf 0.3)(true_or_false TRUE)))");
                o_ans.add("(assert (current_question charity_spouse))");

                Vector<String> t_ans = new Vector<>();
                t_ans.add("(assert (current_question charity_spouse))");

                charity_friends_above_hash.put("a", a_ans);
                charity_friends_above_hash.put("e", e_ans);
                charity_friends_above_hash.put("h", h_ans);
                charity_friends_above_hash.put("c", c_ans);
                charity_friends_above_hash.put("r", r_ans);
                charity_friends_above_hash.put("sw", sw_ans);
                charity_friends_above_hash.put("sp", sp_ans);
                charity_friends_above_hash.put("o", o_ans);
                charity_friends_above_hash.put("t", t_ans);
            }

            {
                // charity_friends_below
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name arts_and_heritage)(cf 0.2)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question charity_received_help))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name education)(cf 0.2)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question charity_received_help))");

                Vector<String> h_ans = new Vector<>();
                h_ans.add("(assert (nameofvariable (name health)(cf 0.2)(true_or_false TRUE)))");
                h_ans.add("(assert (current_question charity_received_help))");

                Vector<String> r_ans = new Vector<>();
                r_ans.add("(assert (nameofvariable (name religious)(cf 0.2)(true_or_false TRUE)))");
                r_ans.add("(assert (current_question charity_received_help))");

                Vector<String> sw_ans = new Vector<>();
                sw_ans.add("(assert (nameofvariable (name social_and_welfare)(cf 0.2)(true_or_false TRUE)))");
                sw_ans.add("(assert (current_question charity_received_help))");

                Vector<String> sp_ans = new Vector<>();
                sp_ans.add("(assert (nameofvariable (name sports)(cf 0.2)(true_or_false TRUE)))");
                sp_ans.add("(assert (current_question charity_received_help))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name community)(cf 0.2)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question charity_received_help))");

                Vector<String> o_ans = new Vector<>();
                o_ans.add("(assert (nameofvariable (name others)(cf 0.2)(true_or_false TRUE)))");
                o_ans.add("(assert (current_question charity_received_help))");

                Vector<String> t_ans = new Vector<>();
                t_ans.add("(assert (current_question charity_received_help))");

                charity_friends_below_hash.put("a", a_ans);
                charity_friends_below_hash.put("e", e_ans);
                charity_friends_below_hash.put("h", h_ans);
                charity_friends_below_hash.put("c", c_ans);
                charity_friends_below_hash.put("r", r_ans);
                charity_friends_below_hash.put("sw", sw_ans);
                charity_friends_below_hash.put("sp", sp_ans);
                charity_friends_below_hash.put("o", o_ans);
                charity_friends_below_hash.put("t", t_ans);
            }

            {
                // charity_spouse
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name arts_and_heritage)(cf 0.5)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question charity_received_help))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name education)(cf 0.5)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question charity_received_help))");

                Vector<String> h_ans = new Vector<>();
                h_ans.add("(assert (nameofvariable (name health)(cf 0.5)(true_or_false TRUE)))");
                h_ans.add("(assert (current_question charity_received_help))");

                Vector<String> r_ans = new Vector<>();
                r_ans.add("(assert (nameofvariable (name religious)(cf 0.5)(true_or_false TRUE)))");
                r_ans.add("(assert (current_question charity_received_help))");

                Vector<String> sw_ans = new Vector<>();
                sw_ans.add("(assert (nameofvariable (name social_and_welfare)(cf 0.5)(true_or_false TRUE)))");
                sw_ans.add("(assert (current_question charity_received_help))");

                Vector<String> sp_ans = new Vector<>();
                sp_ans.add("(assert (nameofvariable (name sports)(cf 0.5)(true_or_false TRUE)))");
                sp_ans.add("(assert (current_question charity_received_help))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name community)(cf 0.5)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question charity_received_help))");

                Vector<String> o_ans = new Vector<>();
                o_ans.add("(assert (nameofvariable (name others)(cf 0.5)(true_or_false TRUE)))");
                o_ans.add("(assert (current_question charity_received_help))");

                Vector<String> t_ans = new Vector<>();
                t_ans.add("(assert (current_question charity_received_help))");

                charity_spouse_hash.put("a", a_ans);
                charity_spouse_hash.put("e", e_ans);
                charity_spouse_hash.put("h", h_ans);
                charity_spouse_hash.put("c", c_ans);
                charity_spouse_hash.put("r", r_ans);
                charity_spouse_hash.put("sw", sw_ans);
                charity_spouse_hash.put("sp", sp_ans);
                charity_spouse_hash.put("o", o_ans);
                charity_spouse_hash.put("t", t_ans);
            }

            {
                // charity_received_help
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name arts_and_heritage)(cf 0.5)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question charity_media))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name education)(cf 0.5)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question charity_media))");

                Vector<String> h_ans = new Vector<>();
                h_ans.add("(assert (nameofvariable (name health)(cf 0.5)(true_or_false TRUE)))");
                h_ans.add("(assert (current_question charity_media))");

                Vector<String> r_ans = new Vector<>();
                r_ans.add("(assert (nameofvariable (name religious)(cf 0.5)(true_or_false TRUE)))");
                r_ans.add("(assert (current_question charity_media))");

                Vector<String> sw_ans = new Vector<>();
                sw_ans.add("(assert (nameofvariable (name social_and_welfare)(cf 0.5)(true_or_false TRUE)))");
                sw_ans.add("(assert (current_question charity_media))");

                Vector<String> sp_ans = new Vector<>();
                sp_ans.add("(assert (nameofvariable (name sports)(cf 0.5)(true_or_false TRUE)))");
                sp_ans.add("(assert (current_question charity_media))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name community)(cf 0.5)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question charity_media))");

                Vector<String> o_ans = new Vector<>();
                o_ans.add("(assert (nameofvariable (name others)(cf 0.5)(true_or_false TRUE)))");
                o_ans.add("(assert (current_question charity_media))");

                Vector<String> t_ans = new Vector<>();
                t_ans.add("(assert (current_question charity_media))");

                charity_received_help_hash.put("a", a_ans);
                charity_received_help_hash.put("e", e_ans);
                charity_received_help_hash.put("h", h_ans);
                charity_received_help_hash.put("c", c_ans);
                charity_received_help_hash.put("r", r_ans);
                charity_received_help_hash.put("sw", sw_ans);
                charity_received_help_hash.put("sp", sp_ans);
                charity_received_help_hash.put("o", o_ans);
                charity_received_help_hash.put("t", t_ans);
            }

            {   // charity_media
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name media_exposure)(cf 0.2)(true_or_false TRUE)))");
                y_ans.add("(assert (current_question charity_website))");
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question charity_website))");
                charity_media_hash.put("y", y_ans);
                charity_media_hash.put("n", n_ans);
            }

            {   // charity_website
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name has_website)(cf 0.2)(true_or_false TRUE)))");
                y_ans.add("(assert (current_question charity_influence))");
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question charity_influence))");
                charity_website_hash.put("y", y_ans);
                charity_website_hash.put("n", n_ans);
            }

            {
                // charity_influence
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name arts_and_heritage)(cf 0.4)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question conclusion))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name education)(cf 0.4)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question conclusion))");

                Vector<String> h_ans = new Vector<>();
                h_ans.add("(assert (nameofvariable (name health)(cf 0.4)(true_or_false TRUE)))");
                h_ans.add("(assert (current_question conclusion))");

                Vector<String> r_ans = new Vector<>();
                r_ans.add("(assert (nameofvariable (name religious)(cf 0.4)(true_or_false TRUE)))");
                r_ans.add("(assert (current_question conclusion))");

                Vector<String> sw_ans = new Vector<>();
                sw_ans.add("(assert (nameofvariable (name social_and_welfare)(cf 0.4)(true_or_false TRUE)))");
                sw_ans.add("(assert (current_question conclusion))");

                Vector<String> sp_ans = new Vector<>();
                sp_ans.add("(assert (nameofvariable (name sports)(cf 0.4)(true_or_false TRUE)))");
                sp_ans.add("(assert (current_question conclusion))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name community)(cf 0.4)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question conclusion))");

                Vector<String> o_ans = new Vector<>();
                o_ans.add("(assert (nameofvariable (name others)(cf 0.4)(true_or_false TRUE)))");
                o_ans.add("(assert (current_question conclusion))");

                Vector<String> t_ans = new Vector<>();
                t_ans.add("(assert (current_question conclusion))");

                charity_influence_hash.put("a", a_ans);
                charity_influence_hash.put("e", e_ans);
                charity_influence_hash.put("h", h_ans);
                charity_influence_hash.put("c", c_ans);
                charity_influence_hash.put("r", r_ans);
                charity_influence_hash.put("sw", sw_ans);
                charity_influence_hash.put("sp", sp_ans);
                charity_influence_hash.put("o", o_ans);
                charity_influence_hash.put("t", t_ans);
            }

            {
                // experience_employees (likert scale)
                Vector<String> a_ans = new Vector<>();
                //a_ans.add("(bind ?*research_variable* 0)");
                a_ans.add("(assert (old 0))");
                a_ans.add("(assert (current_question multiple_accounting))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (old 0.1))");
                b_ans.add("(assert (current_question multiple_accounting))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (old 0.2))");
                c_ans.add("(assert (current_question multiple_accounting))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (old 0.3))");
                d_ans.add("(assert (current_question multiple_accounting))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (old 0.4))");
                e_ans.add("(assert (current_question multiple_accounting))");

                experience_employees_hash.put("a", a_ans);
                experience_employees_hash.put("b", b_ans);
                experience_employees_hash.put("c", c_ans);
                experience_employees_hash.put("d", d_ans);
                experience_employees_hash.put("e", e_ans);
            }

            {
                // multiple_accounting (likert scale)
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (recent 0.4))");
                a_ans.add("(assert (current_question section_external_influence))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (recent 0.3))");
                b_ans.add("(assert (current_question section_external_influence))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (recent 0.2))");
                c_ans.add("(assert (current_question section_external_influence))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (recent 0.1))");
                d_ans.add("(assert (current_question section_external_influence))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (recent 0))");
                e_ans.add("(assert (current_question section_external_influence))");

                multiple_accounting_hash.put("a", a_ans);
                multiple_accounting_hash.put("b", b_ans);
                multiple_accounting_hash.put("c", c_ans);
                multiple_accounting_hash.put("d", d_ans);
                multiple_accounting_hash.put("e", e_ans);
            }

            {   // religion
                Vector<String> buddhism_ans = new Vector<>();
                Vector<String> christianity_ans = new Vector<>();
                Vector<String> hinduism_ans = new Vector<>();
                Vector<String> islam_ans = new Vector<>();
                Vector<String> taoism_ans = new Vector<>();
                Vector<String> others_ans = new Vector<>();
                buddhism_ans.add("(assert (nameofvariable (name buddhism)(cf 0.9)(true_or_false TRUE)))");
                buddhism_ans.add("(assert (nameofvariable (name islam)(cf -0.8)(true_or_false TRUE)))");
                buddhism_ans.add("(assert (nameofvariable (name taoism)(cf -0.8)(true_or_false TRUE)))");
                buddhism_ans.add("(assert (nameofvariable (name hinduism)(cf -0.8)(true_or_false TRUE)))");
                buddhism_ans.add("(assert (nameofvariable (name christianity)(cf -0.8)(true_or_false TRUE)))");
                buddhism_ans.add("(assert (current_question experience_employees))");

                christianity_ans.add("(assert (nameofvariable (name christianity)(cf 0.9)(true_or_false TRUE)))");
                christianity_ans.add("(assert (nameofvariable (name buddhism)(cf -0.8)(true_or_false TRUE)))");
                christianity_ans.add("(assert (nameofvariable (name islam)(cf -0.8)(true_or_false TRUE)))");
                christianity_ans.add("(assert (nameofvariable (name taoism)(cf -0.8)(true_or_false TRUE)))");
                christianity_ans.add("(assert (nameofvariable (name hinduism)(cf -0.8)(true_or_false TRUE)))");
                christianity_ans.add("(assert (current_question experience_employees))");

                hinduism_ans.add("(assert (nameofvariable (name hinduism)(cf 0.9)(true_or_false TRUE)))");
                hinduism_ans.add("(assert (nameofvariable (name christianity)(cf -0.8)(true_or_false TRUE)))");
                hinduism_ans.add("(assert (nameofvariable (name buddhism)(cf -0.8)(true_or_false TRUE)))");
                hinduism_ans.add("(assert (nameofvariable (name islam)(cf -0.8)(true_or_false TRUE)))");
                hinduism_ans.add("(assert (nameofvariable (name taoism)(cf -0.8)(true_or_false TRUE)))");
                hinduism_ans.add("(assert (current_question experience_employees))");

                islam_ans.add("(assert (nameofvariable (name islam)(cf 0.9)(true_or_false TRUE)))");
                islam_ans.add("(assert (nameofvariable (name taoism)(cf -0.8)(true_or_false TRUE)))");
                islam_ans.add("(assert (nameofvariable (name hinduism)(cf -0.8)(true_or_false TRUE)))");
                islam_ans.add("(assert (nameofvariable (name buddhism)(cf -0.8)(true_or_false TRUE)))");
                islam_ans.add("(assert (nameofvariable (name christianity)(cf -0.8)(true_or_false TRUE)))");
                islam_ans.add("(assert (current_question experience_employees))");

                taoism_ans.add("(assert (nameofvariable (name taoism)(cf 0.9)(true_or_false TRUE)))");
                taoism_ans.add("(assert (nameofvariable (name hinduism)(cf -0.8)(true_or_false TRUE)))");
                taoism_ans.add("(assert (nameofvariable (name buddhism)(cf -0.8)(true_or_false TRUE)))");
                taoism_ans.add("(assert (nameofvariable (name christianity)(cf -0.8)(true_or_false TRUE)))");
                taoism_ans.add("(assert (nameofvariable (name islam)(cf -0.8)(true_or_false TRUE)))");
                taoism_ans.add("(assert (current_question experience_employees))");

                others_ans.add("(assert (current_question experience_employees))"); // others no effect
                religious_subsector_hash.put("b", buddhism_ans);
                religious_subsector_hash.put("c", christianity_ans);
                religious_subsector_hash.put("h", hinduism_ans);
                religious_subsector_hash.put("i", islam_ans);
                religious_subsector_hash.put("t", taoism_ans);
                religious_subsector_hash.put("o", others_ans);
            }

            {
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (current_question sector_preference))");
                section_sector_hash.put("section", a_ans);
            }

            {
                // sector_preferences
                Vector<String> arts_heritage_ans = new Vector<>();
                Vector<String> community_ans = new Vector<>();
                Vector<String> education_ans = new Vector<>();
                Vector<String> health_ans = new Vector<>();
                Vector<String> religious_ans = new Vector<>();
                Vector<String> social_welfare_ans = new Vector<>();
                Vector<String> sports_ans = new Vector<>();
                Vector<String> others_ans = new Vector<>();

                arts_heritage_ans.add("(assert (nameofvariable (name arts_heritage)(cf 0.6)(true_or_false TRUE)))");
                arts_heritage_ans.add("(assert (current_question arts_and_heritage_support))");
                community_ans.add("(assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE)))");
                community_ans.add("(assert (current_question community_neighbourhood))");
                education_ans.add("(assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE)))");
                education_ans.add("(assert (current_question education_scholarship))");
                health_ans.add("(assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE)))");
                health_ans.add("(assert (current_question health_subsector))");
                religious_ans.add("(assert (nameofvariable (name religious)(cf 0.6)(true_or_false TRUE)))");
                religious_ans.add("(assert (current_question religion_subsector))");
                social_welfare_ans.add("(assert (nameofvariable (name social_welfare)(cf 0.6)(true_or_false TRUE)))");
                social_welfare_ans.add("(assert (current_question social_subsector))");
                sports_ans.add("(assert (nameofvariable (name sports)(cf 0.6)(true_or_false TRUE)))");
                sports_ans.add("(assert (current_question sports_subsector))");
                others_ans.add("(assert (nameofvariable (name others_sector)(cf 0.6)(true_or_false TRUE)))");
                others_ans.add("(assert (current_question others_commemorating))");

                sector_preference_hash.put("a", arts_heritage_ans);
                sector_preference_hash.put("c", community_ans);
                sector_preference_hash.put("e", education_ans);
                sector_preference_hash.put("h", health_ans);
                sector_preference_hash.put("r", religious_ans);
                sector_preference_hash.put("sw", social_welfare_ans);
                sector_preference_hash.put("sp", sports_ans);
                sector_preference_hash.put("o", others_ans);
            }

            // ---------------------- Health Sub-Sector Questions --------------------- //
            {
                // health_subsector
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name cluster_and_hospital_funds)(cf 0.7)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question experience_employees))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (nameofvariable (name community_and_chronic_sick_hospital)(cf 0.7)(true_or_false TRUE)))");
                b_ans.add("(assert (current_question experience_employees))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name day_rehabilitation_centre)(cf 0.7)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question experience_employees))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (nameofvariable (name diseases_and_illnessess_support_group)(cf 0.7)(true_or_false TRUE)))");
                d_ans.add("(assert (current_question experience_employees))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name health_professional_group)(cf 0.7)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question experience_employees))");

                Vector<String> f_ans = new Vector<>();
                f_ans.add("(assert (nameofvariable (name home_care)(cf 0.7)(true_or_false TRUE)))");
                f_ans.add("(assert (current_question experience_employees))");

                Vector<String> g_ans = new Vector<>();
                g_ans.add("(assert (nameofvariable (name hospice)(cf 0.7)(true_or_false TRUE)))");
                g_ans.add("(assert (current_question experience_employees))");

                Vector<String> h_ans = new Vector<>();
                h_ans.add("(assert (nameofvariable (name palliative_home_care)(cf 0.7)(true_or_false TRUE)))");
                h_ans.add("(assert (current_question experience_employees))");

                Vector<String> i_ans = new Vector<>();
                i_ans.add("(assert (nameofvariable (name nursing_home)(cf 0.7)(true_or_false TRUE)))");
                i_ans.add("(assert (current_question experience_employees))");

                Vector<String> j_ans = new Vector<>();
                j_ans.add("(assert (nameofvariable (name community_based_services)(cf 0.7)(true_or_false TRUE)))");
                j_ans.add("(assert (current_question experience_employees))");

                Vector<String> k_ans = new Vector<>();
                k_ans.add("(assert (nameofvariable (name renal_dialysis)(cf 0.7)(true_or_false TRUE)))");
                k_ans.add("(assert (current_question experience_employees))");

                Vector<String> l_ans = new Vector<>();
                l_ans.add("(assert (nameofvariable (name tcm_clinic)(cf 0.7)(true_or_false TRUE)))");
                l_ans.add("(assert (current_question experience_employees))");

                Vector<String> m_ans = new Vector<>();
                m_ans.add("(assert (nameofvariable (name trust_and_research_funds)(cf 0.7)(true_or_false TRUE)))");
                m_ans.add("(assert (current_question experience_employees))");

                health_subsector_hash.put("a", a_ans);
                health_subsector_hash.put("b", b_ans);
                health_subsector_hash.put("c", c_ans);
                health_subsector_hash.put("d", d_ans);
                health_subsector_hash.put("e", e_ans);
                health_subsector_hash.put("f", f_ans);
                health_subsector_hash.put("g", g_ans);
                health_subsector_hash.put("h", h_ans);
                health_subsector_hash.put("i", i_ans);
                health_subsector_hash.put("j", j_ans);
                health_subsector_hash.put("k", k_ans);
                health_subsector_hash.put("l", l_ans);
                health_subsector_hash.put("m", m_ans);
            }


            // ---------------------- Arts and Heritage Sub-Sector Questions --------------------- //

            {
                // arts_and_heritage_support (likert scale)
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name historical_and_cultural_conservation)(cf -0.5)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question arts_and_heritage_subsector))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (nameofvariable (name historical_and_cultural_conservation)(cf -0.3)(true_or_false TRUE)))");
                b_ans.add("(assert (current_question arts_and_heritage_subsector))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (current_question arts_and_heritage_subsector))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (nameofvariable (name historical_and_cultural_conservation)(cf 0.3)(true_or_false TRUE)))");
                d_ans.add("(assert (current_question arts_and_heritage_subsector))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name historical_and_cultural_conservation)(cf 0.5)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question arts_and_heritage_subsector))");

                arts_and_heritage_support_hash.put("a", a_ans);
                arts_and_heritage_support_hash.put("b", b_ans);
                arts_and_heritage_support_hash.put("c", c_ans);
                arts_and_heritage_support_hash.put("d", d_ans);
                arts_and_heritage_support_hash.put("e", e_ans);
            }

            {
                // arts_and_heritage_subsector
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name historical_and_cultural_conservation)(cf 0.7)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question experience_employees))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (nameofvariable (name music_and_orchestras)(cf 0.7)(true_or_false TRUE)))");
                b_ans.add("(assert (current_question experience_employees))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name literary_arts)(cf 0.7)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question experience_employees))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (nameofvariable (name professional_contemporay_ethnic)(cf 0.7)(true_or_false TRUE)))");
                d_ans.add("(assert (current_question experience_employees))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name theatre_and_dramatic_arts)(cf 0.7)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question experience_employees))");

                Vector<String> f_ans = new Vector<>();
                f_ans.add("(assert (nameofvariable (name traditional_ethnic_performing_arts)(cf 0.7)(true_or_false TRUE)))");
                f_ans.add("(assert (current_question experience_employees))");

                Vector<String> g_ans = new Vector<>();
                g_ans.add("(assert (nameofvariable (name visual_arts)(cf 0.7)(true_or_false TRUE)))");
                g_ans.add("(assert (current_question experience_employees))");

                arts_and_heritage_subsector_hash.put("a", a_ans);
                arts_and_heritage_subsector_hash.put("b", b_ans);
                arts_and_heritage_subsector_hash.put("c", c_ans);
                arts_and_heritage_subsector_hash.put("d", d_ans);
                arts_and_heritage_subsector_hash.put("e", e_ans);
                arts_and_heritage_subsector_hash.put("f", f_ans);
                arts_and_heritage_subsector_hash.put("g", g_ans);
            }
            // ---------------------- Community Sub-Sector Questions --------------------- //
            {   // community_neighbourhood
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (current_question community_location))");
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question conclusion))");
                community_neighbourhood_hash.put("y", y_ans);
                community_neighbourhood_hash.put("n", n_ans);
            }

            {
                // community_location
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name central)(cf 0.7)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question experience_employees))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (nameofvariable (name north_east)(cf 0.7)(true_or_false TRUE)))");
                b_ans.add("(assert (current_question experience_employees))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name north_west)(cf 0.7)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question experience_employees))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (nameofvariable (name south_east)(cf 0.7)(true_or_false TRUE)))");
                d_ans.add("(assert (current_question experience_employees))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name south_west)(cf 0.7)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question experience_employees))");

                community_location_hash.put("a", a_ans);
                community_location_hash.put("b", b_ans);
                community_location_hash.put("c", c_ans);
                community_location_hash.put("d", d_ans);
                community_location_hash.put("e", e_ans);
            }

            // ---------------------- Education Sub-Sector Questions --------------------- //

            {   // education_scholarship
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name foundations_and_trusts)(cf 0.5)(true_or_false TRUE)))");
                y_ans.add("(assert (nameofvariable (name local_educational_institutions_and_funds)(cf 0.5)(true_or_false TRUE)))");
                y_ans.add("(assert (current_question education_subsector))");
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question education_subsector))");
                education_scholarship_hash.put("y", y_ans);
                education_scholarship_hash.put("n", n_ans);
            }

            {
                // education_subsector
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name foreign_educational_institutions_and_funds)(cf 0.7)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question experience_employees))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (nameofvariable (name foundations_and_trusts)(cf 0.7)(true_or_false TRUE)))");
                b_ans.add("(assert (current_question experience_employees))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name local_educational_institutions_and_funds)(cf 0.7)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question experience_employees))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (nameofvariable (name uniformed_groups)(cf 0.7)(true_or_false TRUE)))");
                d_ans.add("(assert (current_question experience_employees))");

                education_subsector_hash.put("a", a_ans);
                education_subsector_hash.put("b", b_ans);
                education_subsector_hash.put("c", c_ans);
                education_subsector_hash.put("d", d_ans);
            }

            // ---------------------- Religious Sub-Sector Questions --------------------- //
            // ---------------------- Social and Welfare Sub-Sector Questions --------------------- //
            {
                // social_subsector
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name children_and_youth)(cf 0.7)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question experience_employees))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (nameofvariable (name community)(cf 0.7)(true_or_false TRUE)))");
                b_ans.add("(assert (current_question experience_employees))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name disability_adult)(cf 0.7)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question experience_employees))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (nameofvariable (name eldercare)(cf 0.7)(true_or_false TRUE)))");
                d_ans.add("(assert (current_question experience_employees))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name family)(cf 0.7)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question experience_employees))");

                Vector<String> f_ans = new Vector<>();
                f_ans.add("(assert (nameofvariable (name support_groups)(cf 0.7)(true_or_false TRUE)))");
                f_ans.add("(assert (current_question experience_employees))");


                social_subsector_hash.put("a", a_ans);
                social_subsector_hash.put("b", b_ans);
                social_subsector_hash.put("c", c_ans);
                social_subsector_hash.put("d", d_ans);
                social_subsector_hash.put("e", e_ans);
                social_subsector_hash.put("f", f_ans);
            }
            // ---------------------- Sports Sub-Sector Questions --------------------- //

            {
                // sports_subsector
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name competitive_sports)(cf 0.7)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question experience_employees))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (nameofvariable (name disability_sports)(cf 0.7)(true_or_false TRUE)))");
                b_ans.add("(assert (current_question experience_employees))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name non_nsas)(cf 0.7)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question experience_employees))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (nameofvariable (name nsas)(cf 0.7)(true_or_false TRUE)))");
                d_ans.add("(assert (current_question experience_employees))");

                sports_subsector_hash.put("a", a_ans);
                sports_subsector_hash.put("b", b_ans);
                sports_subsector_hash.put("c", c_ans);
                sports_subsector_hash.put("d", d_ans);
            }
            // ---------------------- Others Sub-Sector Questions --------------------- //

            {   // others_commemorating
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name environment)(cf 0.8)(true_or_false TRUE)))");
                y_ans.add("(assert (current_question experience_employees))");

                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question others_pet))");
                others_commemorating_hash.put("y", y_ans);
                others_commemorating_hash.put("n", n_ans);
            }

            {   // others_pet
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name animal_welfare)(cf 0.8)(true_or_false TRUE)))");
                y_ans.add("(assert (current_question experience_employees))");

                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question others_humanitarian))");
                others_pet_hash.put("y", y_ans);
                others_pet_hash.put("n", n_ans);
            }

            {   // others_humanitarian
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name humanitarian_aid)(cf 0.8)(true_or_false TRUE)))");
                y_ans.add("(assert (current_question experience_employees))");

                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question others_children))");
                others_humanitarian_hash.put("y", y_ans);
                others_humanitarian_hash.put("n", n_ans);
            }

            {   // others_children
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name children_and_youth)(cf 0.8)(true_or_false TRUE)))");
                y_ans.add("(assert (current_question experience_employees))");

                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question experience_employees))");
                others_children_hash.put("y", y_ans);
                others_children_hash.put("n", n_ans);
            }

            {   // others_children
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question charity_investment))");
                section_charity_attributes_hash.put("n", n_ans);
            }



        } catch (MissingResourceException mre) {
            mre.printStackTrace();
            return false;
        }


        return true;
    }

    public Vector<String> getSingleAnswers(String relationAsserted, String theAnswer) {

        switch (relationAsserted) {
            case "corporate_or_individual":
                return corporate_individual_hash.get(theAnswer);
            case "donation_type":
                return donation_hash.get(theAnswer);
            case "charity_size":
                return charity_size_hash.get(theAnswer);
            case "charity_investment":
                return charity_invest_hash.get(theAnswer);
            case "charity_gov_funded":
                return charity_gov_funded_hash.get(theAnswer);
            case "tax_exemption":
                return tax_return_hash.get(theAnswer);
            case "charity_fin_eff":
                return charity_fin_eff_hash.get(theAnswer);
            case "charity_gov_compl":
                return charity_gov_compl_hash.get(theAnswer);
            case "charity_research":
                return charity_research_hash.get(theAnswer);
            case "charity_sad_stories":
                return charity_sad_stories_hash.get(theAnswer);
            case "section_charity_attributes":
                return section_charity_attributes_hash.get(theAnswer);
            case "charity_established":
                return charity_established_hash.get(theAnswer);
            case "charity_past":
                return charity_past_hash.get(theAnswer);
            case "charity_parents_sector":
                return charity_parents_sector_hash.get(theAnswer);
            case "twelve_years_old":
                return twelve_years_old_hash.get(theAnswer);
            case "charity_friends_above":
                return charity_friends_above_hash.get(theAnswer);
            case "charity_friends_below":
                return charity_friends_below_hash.get(theAnswer);
            case "charity_spouse":
                return charity_spouse_hash.get(theAnswer);
            case "charity_received_help":
                return charity_received_help_hash.get(theAnswer);
            case "charity_media":
                return charity_media_hash.get(theAnswer);
            case "charity_website":
                return charity_website_hash.get(theAnswer);
            case "charity_influence":
                return charity_influence_hash.get(theAnswer);
            case "section_sector":
                return section_sector_hash.get(theAnswer);
            case "arts_and_heritage_support":
                return arts_and_heritage_support_hash.get(theAnswer);
            case "arts_and_heritage_subsector":
                return arts_and_heritage_subsector_hash.get(theAnswer);
            case "education_scholarship":
                return education_scholarship_hash.get(theAnswer);
            case "education_subsector":
                return education_subsector_hash.get(theAnswer);
            case "community_neighbourhood":
                return community_neighbourhood_hash.get(theAnswer);
            case "community_location":
                return community_location_hash.get(theAnswer);
            case "health_subsector":
                return health_subsector_hash.get(theAnswer);
            case "religion_subsector":
                return religious_subsector_hash.get(theAnswer);
            case "sector_preference":
                return sector_preference_hash.get(theAnswer);
            case "others_commemorating":
                return others_commemorating_hash.get(theAnswer);
            case "others_pet":
                return others_pet_hash.get(theAnswer);
            case "others_humanitarian":
                return others_humanitarian_hash.get(theAnswer);
            case "others_children":
                return others_children_hash.get(theAnswer);
            case "sports_subsector":
                return sports_subsector_hash.get(theAnswer);
            case "social_subsector":
                return social_subsector_hash.get(theAnswer);
            case "experience_employees":
                return experience_employees_hash.get(theAnswer);
            case "multiple_accounting":
                return multiple_accounting_hash.get(theAnswer);
            case "section_external_influence":
                return section_external_influence_hash.get(theAnswer);
            default:

        }
        System.out.println("ERROR: No answers found for this relation! ");
        return null;
    }
}
