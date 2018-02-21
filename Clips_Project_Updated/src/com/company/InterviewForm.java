package com.company;

import net.sf.clipsrules.jni.CLIPSException;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class InterviewForm {
    private CharityRecommender charityRecommender;
    private JPanel mainPanel;
    private JPanel textPanel;
    private JPanel choicePanel;
    private JPanel buttonsPanel;
    private JButton nextButton;
    private JButton prevButton;
    private JLabel textLabel;

    InterviewForm(CharityRecommender recommender) {

        charityRecommender = recommender;

        // We need to setup choicePanel layout because of the bug of IntelliJ GUI Creator
        // https://stackoverflow.com/questions/9639017/intellij-gui-creator-jpanel-gives-runtime-null-pointer-exception-upon-adding-an
        choicePanel.setLayout(new BoxLayout(choicePanel, BoxLayout.PAGE_AXIS));

        prevButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    charityRecommender.prevButtonAction();
                } catch (CLIPSException e1) {
                    e1.printStackTrace();
                }
            }
        });

        nextButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    charityRecommender.continueInterview();
                } catch (CLIPSException e1) {
                    e1.printStackTrace();
                }
            }
        });
    }

    public JPanel getMainPanel() {
        return mainPanel;
    }

    public JPanel getChoicePanel() {
        return choicePanel;
    }

    public void setTextLabel(String text) {
        Helpers helpers = new Helpers();
        helpers.wrapLabelText(textLabel, text);
    }
}
