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
    private Hashtable<String, Vector<String>> charity_established_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> charity_past_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> tax_return_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> religion_hash = new Hashtable<>();
    private Hashtable<String, Vector<String>> sector_preference_hash = new Hashtable<>();

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
                k_ans.add("(assert (nameofvariable (name kind)(cf 1)(true_or_false TRUE)))");
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
                small_ans.add("(assert (current_question charity_investment))");
                Vector<String> medium_ans = new Vector<>();
                medium_ans.add("(assert (nameofvariable (name medium)(cf 0.3)(true_or_false TRUE)))");
                medium_ans.add("(assert (current_question charity_investment))");
                Vector<String> large_ans = new Vector<>();
                large_ans.add("(assert (nameofvariable (name large)(cf 0.3)(true_or_false TRUE)))");
                large_ans.add("(assert (current_question charity_investment))");
                charity_size_hash.put("small", small_ans);
                charity_size_hash.put("medium", medium_ans);
                charity_size_hash.put("large", large_ans);
            }

            {   // charity_invest qn
                Vector<String> yes_ans = new Vector<>();
                yes_ans.add("(assert (nameofvariable (name invest_yes)(cf 0.7)(true_or_false TRUE)))");
                yes_ans.add("(assert (current_question charity_gov_funded))");

                Vector<String> no_ans = new Vector<>();
                no_ans.add("(assert (nameofvariable (name invest_yes)(cf -0.7)(true_or_false TRUE)))");
                no_ans.add("(assert (nameofvariable (name invest_no)(cf 0.7)(true_or_false TRUE)))");
                no_ans.add("(assert (current_question charity_gov_funded))");

                charity_invest_hash.put("y", yes_ans);
                charity_invest_hash.put("n", no_ans);
            }

            {   // charity_gov_funded qn
                Vector<String> yes_ans = new Vector<>();
                yes_ans.add("(assert (nameofvariable (name govfunded_yes)(cf 1)(true_or_false TRUE)))");
                yes_ans.add("(assert (nameofvariable (name govfunded_no)(cf -0.3)(true_or_false TRUE)))");
                yes_ans.add("(assert (current_question charity_fin_eff))");

                Vector<String> no_ans = new Vector<>();
                no_ans.add("(assert (nameofvariable (name govfunded_yes)(cf -0.4)(true_or_false TRUE)))");
                no_ans.add("(assert (current_question charity_fin_eff))");

                charity_gov_funded_hash.put("y", yes_ans);
                charity_gov_funded_hash.put("n", no_ans);

            }

            {   // tax_return
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name notax)(cf -1)(true_or_false TRUE)))");
                y_ans.add("(assert (current_question charity_size))");
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (nameofvariable (name notax)(cf 0.1)(true_or_false TRUE)))");
                n_ans.add("(assert (current_question charity_size))");
                tax_return_hash.put("y", y_ans);
                tax_return_hash.put("n", n_ans);
            }

            {   //  charity_fin_eff qn
                Vector<String> low_ans = new Vector<>();
                low_ans.add("(assert (nameofvariable (name ratio_eff_low)(cf 0.4)(true_or_false TRUE)))");
                low_ans.add("(assert (current_question charity_gov_compl))");
                Vector<String> medium_ans = new Vector<>();
                medium_ans.add("(assert (nameofvariable (name ratio_eff_med)(cf 0.5)(true_or_false TRUE)))");
                medium_ans.add("(assert (current_question charity_gov_compl))");
                Vector<String> high_ans = new Vector<>();
                high_ans.add("(assert (nameofvariable (name ratio_eff_high)(cf 0.8)(true_or_false TRUE)))");
                high_ans.add("(assert (current_question charity_gov_compl))");
                charity_fin_eff_hash.put("l", low_ans);
                charity_fin_eff_hash.put("m", medium_ans);
                charity_fin_eff_hash.put("h", high_ans);
            }

            {   // charity_gov_compl
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (nameofvariable (name sub_gov_yes)(cf 1)(true_or_false TRUE)))");
                y_ans.add("(assert (nameofvariable (name sub_gov_no)(cf -0.1)(true_or_false TRUE)))");
                y_ans.add("(assert (nameofvariable (name sub_gov_not_req)(cf -0.1)(true_or_false TRUE)))");
                y_ans.add("(assert (current_question charity_research))");
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (nameofvariable (name sub_gov_yes)(cf -0.4)(true_or_false TRUE)))");
                n_ans.add("(assert (current_question charity_research))");
                charity_gov_compl_hash.put("y", y_ans);
                charity_gov_compl_hash.put("n", n_ans);
            }

            {
                // charity_research_hash (likert scale)
                Vector<String> a_ans = new Vector<>();
                a_ans.add("(assert (nameofvariable (name ratio_eff_low)(cf 0.3)(true_or_false TRUE)))");
                a_ans.add("(assert (nameofvariable (name sub_gov_no)(cf 0.3)(true_or_false TRUE)))");
                a_ans.add("(assert (nameofvariable (name gov_rating_low)(cf 0.3)(true_or_false TRUE)))");
                a_ans.add("(assert (current_question charity_established))");

                Vector<String> b_ans = new Vector<>();
                b_ans.add("(assert (nameofvariable (name ratio_eff_low)(cf 0.2)(true_or_false TRUE)))");
                b_ans.add("(assert (nameofvariable (name sub_gov_not_req)(cf 0.2)(true_or_false TRUE)))");
                b_ans.add("(assert (nameofvariable (name gov_rating_low)(cf 0.2)(true_or_false TRUE)))");
                b_ans.add("(assert (current_question charity_established))");

                Vector<String> c_ans = new Vector<>();
                c_ans.add("(assert (nameofvariable (name ratio_eff_med)(cf 0.1)(true_or_false TRUE)))");
                c_ans.add("(assert (nameofvariable (name sub_gov_not_req)(cf 0.1)(true_or_false TRUE)))");
                c_ans.add("(assert (nameofvariable (name gov_rate_med)(cf 0.1)(true_or_false TRUE)))");
                c_ans.add("(assert (current_question charity_established))");

                Vector<String> d_ans = new Vector<>();
                d_ans.add("(assert (nameofvariable (name ratio_eff_high)(cf 0.5)(true_or_false TRUE)))");
                d_ans.add("(assert (nameofvariable (name sub_gov_not_req)(cf 0.5)(true_or_false TRUE)))");
                d_ans.add("(assert (nameofvariable (name gov_rate_med)(cf 0.5)(true_or_false TRUE)))");
                d_ans.add("(assert (current_question charity_established))");

                Vector<String> e_ans = new Vector<>();
                e_ans.add("(assert (nameofvariable (name ratio_eff_high)(cf 0.8)(true_or_false TRUE)))");
                e_ans.add("(assert (nameofvariable (name sub_gov_yes)(cf 0.8)(true_or_false TRUE)))");
                e_ans.add("(assert (nameofvariable (name gov_rate_high)(cf 0.8)(true_or_false TRUE)))");
                e_ans.add("(assert (current_question charity_established))");

                charity_research_hash.put("a", a_ans);
                charity_research_hash.put("b", b_ans);
                charity_research_hash.put("c", c_ans);
                charity_research_hash.put("d", d_ans);
                charity_research_hash.put("e", e_ans);
            }

            {   //  charity_established qn
                Vector<String> short_ans = new Vector<>();
                short_ans.add("(assert (nameofvariable (name ratio_eff_low)(cf 0.4)(true_or_false TRUE)))");
                short_ans.add("(assert (current_question charity_past))");
                Vector<String> medium_ans = new Vector<>();
                medium_ans.add("(assert (nameofvariable (name ratio_eff_med)(cf 0.5)(true_or_false TRUE)))");
                medium_ans.add("(assert (current_question charity_past))");
                Vector<String> long_ans = new Vector<>();
                long_ans.add("(assert (nameofvariable (name ratio_eff_high)(cf 0.8)(true_or_false TRUE)))");
                long_ans.add("(assert (current_question charity_past))");
                charity_established_hash.put("s", short_ans);
                charity_established_hash.put("m", medium_ans);
                charity_established_hash.put("l", long_ans);
            }

            {   // charity_past
                Vector<String> y_ans = new Vector<>();
                y_ans.add("(assert (current_question religion))"); // TODO there is no data, find out CF values!
                Vector<String> n_ans = new Vector<>();
                n_ans.add("(assert (current_question religion))");
                charity_past_hash.put("y", y_ans);
                charity_past_hash.put("n", n_ans);
            }

            {   // religion
                Vector<String> buddhism_ans = new Vector<>();
                Vector<String> christianity_ans = new Vector<>();
                Vector<String> hinduism_ans = new Vector<>();
                Vector<String> islam_ans = new Vector<>();
                Vector<String> taoism_ans = new Vector<>();
                Vector<String> others_ans = new Vector<>();
                buddhism_ans.add("(assert (nameofvariable (name buddhism)(cf 0.7)(true_or_false TRUE)))");
                buddhism_ans.add("(assert (current_question sector_preference))");
                christianity_ans.add("(assert (nameofvariable (name christianity)(cf 0.8)(true_or_false TRUE)))");
                christianity_ans.add("(assert (current_question sector_preference))");
                hinduism_ans.add("(assert (nameofvariable (name hinduism)(cf 0.7)(true_or_false TRUE)))");
                hinduism_ans.add("(assert (current_question sector_preference))");
                islam_ans.add("(assert (nameofvariable (name islam)(cf 0.9)(true_or_false TRUE)))");
                islam_ans.add("(assert (current_question conclusion))");
                taoism_ans.add("(assert (nameofvariable (name taoism)(cf 0.7)(true_or_false TRUE)))");
                taoism_ans.add("(assert (current_question sector_preference))");
                others_ans.add("(assert (current_question sector_preference))"); // others no effect
                religion_hash.put("b", buddhism_ans);
                religion_hash.put("c", christianity_ans);
                religion_hash.put("h", hinduism_ans);
                religion_hash.put("i", islam_ans);
                religion_hash.put("t", taoism_ans);
                religion_hash.put("o", others_ans);
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
                arts_heritage_ans.add("(assert (current_question conclusion))");
                community_ans.add("(assert (nameofvariable (name community)(cf 0.6)(true_or_false TRUE)))");
                community_ans.add("(assert (current_question conclusion))");
                education_ans.add("(assert (nameofvariable (name education)(cf 0.6)(true_or_false TRUE)))");
                education_ans.add("(assert (current_question conclusion))");
                health_ans.add("(assert (nameofvariable (name health)(cf 0.6)(true_or_false TRUE)))");
                health_ans.add("(assert (current_question conclusion))");
                religious_ans.add("(assert (nameofvariable (name religious)(cf 0.6)(true_or_false TRUE)))");
                religious_ans.add("(assert (current_question conclusion))");
                social_welfare_ans.add("(assert (nameofvariable (name social_welfare)(cf 0.6)(true_or_false TRUE)))");
                social_welfare_ans.add("(assert (current_question conclusion))");
                sports_ans.add("(assert (nameofvariable (name sports)(cf 0.6)(true_or_false TRUE)))");
                sports_ans.add("(assert (current_question conclusion))");
                others_ans.add("(assert (nameofvariable (name others_sector)(cf 0.6)(true_or_false TRUE)))");
                others_ans.add("(assert (current_question conclusion))");

                sector_preference_hash.put("a", arts_heritage_ans);
                sector_preference_hash.put("c", community_ans);
                sector_preference_hash.put("e", education_ans);
                sector_preference_hash.put("h", health_ans);
                sector_preference_hash.put("r", religious_ans);
                sector_preference_hash.put("sw", social_welfare_ans);
                sector_preference_hash.put("sp", sports_ans);
                sector_preference_hash.put("o", others_ans);
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
            case "charity_established":
                return charity_established_hash.get(theAnswer);
            case "charity_past":
                return charity_past_hash.get(theAnswer);
            case "religion":
                return religion_hash.get(theAnswer);
            case "sector_preference":
                return sector_preference_hash.get(theAnswer);
            default:

        }
        System.out.println("ERROR: No answers found for this relation! ");
        return null;
    }
}
