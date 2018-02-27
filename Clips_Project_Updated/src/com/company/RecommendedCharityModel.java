package com.company;

public class RecommendedCharityModel {

    private static double DEFAULT_RECOMMENDATION_VALUE = 0.5;

    public String CharityName;

    public Double RecommendedValue;

    public RecommendedCharityModel(String charityName, String recommendedValue){
        if (charityName != null && !charityName.isEmpty())
        {
            this.CharityName = charityName;
            try {
                this.RecommendedValue = Double.parseDouble(recommendedValue);
            } catch (NumberFormatException e) {
                System.out.println("Invalid recommendation for charity: " + charityName);
                this.RecommendedValue = DEFAULT_RECOMMENDATION_VALUE;
            }
        }
    }
}
