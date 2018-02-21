package com.company;

import net.sf.clipsrules.jni.CLIPSException;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ConclusionForm {
    private CharityRecommender charityRecommender;
    private JPanel MainPanel;
    private JPanel ButtonsPanel;
    private JPanel ListPanel;
    private JPanel TitlePanel;
    private JButton nextButton;
    private JLabel textLabel;

    ConclusionForm(CharityRecommender recommender) {

        charityRecommender = recommender;

        nextButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    charityRecommender.restartInterview();
                } catch (CLIPSException e1) {
                    e1.printStackTrace();
                }
            }
        });
    }

    public JPanel getMainPanel() {
        return MainPanel;
    }

    public void setTextLabel(String text) {
        Helpers helpers = new Helpers();
        helpers.wrapLabelText(textLabel, text);
    }
}
