package com.company;

import net.sf.clipsrules.jni.CLIPSException;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;

public class GreetingForm {
    private CharityRecommender charityRecommender;
    private JPanel mainPanel;
    private JPanel imagePanel;
    private JPanel textPanel;
    private JLabel imageLabel;
    private JLabel textLabel;
    private JPanel buttonsPanel;
    private JButton nextButton;

    GreetingForm(CharityRecommender recommender) {

        charityRecommender = recommender;

        Helpers helpers = new Helpers();

        imageLabel.setIcon(new ImageIcon(helpers.loadImage("/img/charity-01.jpg", 800, 500)));

        nextButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    charityRecommender.startInterview();
                } catch (CLIPSException e1) {
                    e1.printStackTrace();
                }
            }
        });
    }

    public JPanel getMainPanel() {
        return mainPanel;
    }

    public void setTextLabel(String text) {
        Helpers helpers = new Helpers();
        helpers.wrapLabelText(textLabel, text);
    }
}
