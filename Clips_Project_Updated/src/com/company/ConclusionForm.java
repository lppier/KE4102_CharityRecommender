package com.company;

import net.sf.clipsrules.jni.CLIPSException;
import org.apache.commons.lang3.text.WordUtils;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Map;

public class ConclusionForm {

    public enum State {
        INTERMEDIATE, FINAL
    }

    private CharityRecommender charityRecommender;
    private JPanel mainPanel;
    private JPanel buttonsPanel;
    private JPanel titlePanel;

    private JButton restartButton;
    private JPanel rightBorder;
    private JPanel textPanel;
    private JPanel leftBorder;
    private JPanel listPanel;
    private JLabel textLabel;
    private GridBagLayout layout = new GridBagLayout();
    private GridBagConstraints constraints = new GridBagConstraints();
    private Integer itemCount = 0;
    private Helpers helpers = new Helpers();

    private State state = State.INTERMEDIATE;

    private ActionListener restartActionListener = new ActionListener() {
        @Override
        public void actionPerformed(ActionEvent e) {
            charityRecommender.restartInterview();
        }
    };

    private ActionListener backActionListener = new ActionListener() {
        @Override
        public void actionPerformed(ActionEvent e) {
            charityRecommender.handleBackFromJumpConclusion();
        }
    };

    public JButton getRestartButton() {
        return restartButton;
    }

    public State getState() {
        return state;
    }

    public void setState(State newState) {
        state = newState;
        if (state == State.INTERMEDIATE) {
            restartButton.addActionListener(backActionListener);
            restartButton.setText("Back");
        } else {
            restartButton.addActionListener(restartActionListener);
            restartButton.setText("Restart");

        }
    }

    ConclusionForm(CharityRecommender recommender) {

        charityRecommender = recommender;

        constraints.fill = GridBagConstraints.HORIZONTAL;
        constraints.anchor = GridBagConstraints.NORTH;
        listPanel.setLayout(layout);
    }

    public JPanel getMainPanel() {
        return mainPanel;
    }

    public void setTextLabel(String text) {
        Helpers helpers = new Helpers();
        helpers.wrapLabelText(textLabel, text);
    }

    public void clearListPanel() {
        listPanel.removeAll();
        itemCount = 0;
    }

    public void addItem(Map<String, String> item, Double cfValue) {

//        System.out.println("ConclusionForm->addItem");
//        System.out.println("-------------");

        try {
            System.out.println(String.format("%s: CF %s", item.get("Name of Organisation"), cfValue.toString()));

            constraints.gridx = 0;
            constraints.gridy = (itemCount * 2);
            constraints.weightx = 0.9;
            constraints.weighty = 0.5;
            constraints.insets = new Insets(0, 0, 0, 0);
            Component charityNameLabel = new JLabel(String.format("%s (UEN: %s)", WordUtils.capitalizeFully(item.get("Name of Organisation")), item.get("UEN")));
            listPanel.add(charityNameLabel, constraints);

            constraints.gridx = 1;
            constraints.gridy = (itemCount * 2);
            constraints.weightx = 0.1;
            constraints.weighty = 0.5;
            constraints.insets = new Insets(0, 0, 0, 0);
            JProgressBar cfProgessBar = new JProgressBar();
            cfProgessBar.setValue((int) (cfValue * 100));
            cfProgessBar.setString(String.format("%.4f", cfValue));
            cfProgessBar.setStringPainted(false);
            listPanel.add(cfProgessBar, constraints);

            constraints.gridx = 0;
            constraints.gridy = (itemCount * 2) + 1;
            constraints.weightx = 0.9;
            constraints.weighty = 0.5;
            constraints.insets = new Insets(0, 0, 7, 0);
            Component linkButton = helpers.createHyperLink(item.get("website"));
            listPanel.add(linkButton, constraints);

            constraints.gridx = 1;
            constraints.gridy = (itemCount * 2) + 1;
            constraints.weightx = 0.1;
            constraints.weighty = 0.5;
            constraints.insets = new Insets(0, 0, 7, 0);
            ActionListener actionListener = new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    charityRecommender.openDetail(item);
                }
            };
            listPanel.add(helpers.createDetailLink(item, actionListener), constraints);
        } catch (NullPointerException e) {
            e.printStackTrace();
        }

        itemCount += 1;
        //System.out.println("#############");
    }
}
