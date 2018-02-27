package com.company;

import net.sf.clipsrules.jni.CLIPSException;
import org.apache.commons.lang3.text.WordUtils;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Map;
import java.net.URI;

public class ConclusionForm {
    private CharityRecommender charityRecommender;
    private JPanel mainPanel;
    private JPanel buttonsPanel;
    private JPanel titlePanel;
    private JButton nextButton;
    private JPanel rightBorder;
    private JPanel textPanel;
    private JPanel leftBorder;
    private JPanel listPanel;
    private JLabel textLabel;
    private GridBagLayout layout = new GridBagLayout();
    private GridBagConstraints constraints = new GridBagConstraints();
    private Integer itemCount = 0;

    ConclusionForm(CharityRecommender recommender) {

        charityRecommender = recommender;

        constraints.fill = GridBagConstraints.HORIZONTAL;
        constraints.anchor = GridBagConstraints.NORTH;
        listPanel.setLayout(layout);

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

    public void addItem(Map<String, String> record, Double cfValue) {

        System.out.println("ConclusionForm->addItem");
        System.out.println("-------------");

        System.out.println(record.get("Name of Organisation"));
        System.out.println(record.get("website"));

        constraints.gridx = 0;
        constraints.gridy = (itemCount * 2);
        constraints.weightx = 0.9;
        constraints.weighty = 0.5;
        constraints.insets = new Insets(0,0,0,0);
        Component charityName = new JLabel(WordUtils.capitalizeFully(record.get("Name of Organisation")));
        listPanel.add(charityName, constraints);

        constraints.gridx = 1;
        constraints.gridy = (itemCount * 2);
        constraints.weightx = 0.1;
        constraints.weighty = 0.5;
        constraints.insets = new Insets(0,0,0,0);
        JProgressBar cfProgessBar = new JProgressBar();
        cfProgessBar.setValue((int)(cfValue * 100));
        cfProgessBar.setString(String.format("%.4f", cfValue));
        cfProgessBar.setStringPainted(true);
        listPanel.add(cfProgessBar, constraints);

        constraints.gridx = 0;
        constraints.gridy = (itemCount * 2) + 1;
        constraints.weightx = 0.9;
        constraints.weighty = 0.5;
        constraints.insets = new Insets(0,0,7,0);
        Component linkButton = createHyperLink(record.get("website"));
        listPanel.add(linkButton, constraints);

        constraints.gridx = 1;
        constraints.gridy = (itemCount * 2) + 1;
        constraints.weightx = 0.1;
        constraints.weighty = 0.5;
        constraints.insets = new Insets(0,0,7,0);
        listPanel.add(createDetailLink(record), constraints);

        itemCount += 1;
        System.out.println("#############");
    }

    private Component createDetailLink(Map<String, String> record) {
        JPanel panel = new JPanel();
        FlowLayout layout = new FlowLayout();
        layout.setAlignment(FlowLayout.RIGHT);
        layout.setHgap(0);
        layout.setVgap(0);
        panel.setLayout(layout);

        JButton button = new JButton("<HTML><U>View Details</U></HTML>");
        button.setBorder(BorderFactory.createLineBorder(Color.BLACK));
        button.setCursor(new Cursor(Cursor.HAND_CURSOR));
        button.setForeground(Color.BLUE);
        button.setBorderPainted(false);
        button.setOpaque(false);
        button.setBackground(Color.WHITE);
        button.setToolTipText("Look into " + record.get("Name of Organisation"));

        ActionListener actionListener = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                charityRecommender.openDetail(record);
            }
        };
        button.addActionListener(actionListener);

        panel.add(button);
        return panel;
    }

    private Component createHyperLink(String link) {
        JPanel panel = new JPanel();
        FlowLayout layout = new FlowLayout();
        layout.setAlignment(FlowLayout.LEFT);
        layout.setHgap(0);
        layout.setVgap(0);
        panel.setLayout(layout);

        try {
            if (!link.contains("http")) {
                link = "http://" + link;
            }
            final URI uri = new URI(link);
            JButton button = new JButton("<HTML><U>" + uri.toString() + "</U></HTML>");
            button.setHorizontalAlignment(SwingConstants.LEFT);
            button.setForeground(Color.BLUE);
            button.setCursor(new Cursor(Cursor.HAND_CURSOR));
            button.setBorder(BorderFactory.createLineBorder(Color.BLACK));
            button.setBorderPainted(false);
            button.setOpaque(false);
            button.setBackground(Color.WHITE);
            button.setToolTipText(uri.toString());
            ActionListener actionListener = new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    if (Desktop.isDesktopSupported()) {
                        try {
                            Desktop.getDesktop().browse(uri);
                        } catch (IOException ex) {
                            /* TODO: error handling */
                            ex.printStackTrace();
                        }
                    } else { /* TODO: error handling */ }
                }
            };
            button.addActionListener(actionListener);
            panel.add(button);
        } catch (URISyntaxException e) {
            JLabel noLinkLabel = new JLabel("No Website");
            noLinkLabel.setForeground(Color.GRAY);
            panel.add(noLinkLabel);
        }
        return panel;
    }
}
