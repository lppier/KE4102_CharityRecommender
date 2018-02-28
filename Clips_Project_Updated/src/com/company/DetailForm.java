package com.company;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.Map;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.WeakHashMap;

import org.apache.commons.lang3.text.WordUtils;

public class DetailForm {
    private CharityRecommender charityRecommender;
    private JPanel mainPanel;
    private JButton backButton;
    private JPanel buttonsPanel;
    private JPanel titlePanel;
    private JPanel textPanel;
    private JLabel titleLabel;
    private JPanel detailPanel;
    private JLabel uenLabel;
    private JLabel statusLabel;
    private JLabel typeLabel;
    private JLabel dateOfRegLabel;
    private JLabel ipcStatusLabel;
    private JLabel ipcPeriodLabel;
    private JLabel primarySectorLabel;
    private JLabel subSectorLabel;
    private JLabel addressLabel;
    private JPanel otherPanel;
    private JPanel listPanel;
    private JPanel websitePanel;
    private Integer itemCount = 0;
    private Helpers helpers = new Helpers();
    private GridBagConstraints gridBagConstraints = new GridBagConstraints();

    DetailForm(CharityRecommender recommender) {

        charityRecommender = recommender;
        listPanel.setLayout(new GridLayout(5, 1));

        backButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    charityRecommender.showConclusion();
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
            }
        });
    }

    public JPanel getMainPanel() {
        return mainPanel;
    }

    public void loadDetail(Map<String, String> item) {
        titleLabel.setText(WordUtils.capitalizeFully(item.get("Name of Organisation")));
        uenLabel.setText(item.get("UEN"));
        statusLabel.setText(item.get("status"));
        dateOfRegLabel.setText(item.get("date_of_reg"));
        ipcPeriodLabel.setText(item.get("IPC Period"));
        ipcStatusLabel.setText(item.get("ipc_status"));
        primarySectorLabel.setText(item.get("Sector"));
        subSectorLabel.setText(item.get("Classification"));
        typeLabel.setText(item.get("Type"));
        addressLabel.setText(item.get("Address"));
        websitePanel.removeAll();
        websitePanel.add(helpers.createHyperLink(item.get("website")));
    }

    public void loadSimilarCharities(ArrayList<Map<String, String>> list) {
        listPanel.removeAll();
        itemCount = 0;
        gridBagConstraints.anchor = GridBagConstraints.NORTHWEST;
        for (Map<String, String> record : list) {
            if (itemCount < 5) {
                JPanel itemPanel = new JPanel();
                itemPanel.setLayout(new GridBagLayout());

                String name = record.get("Name of Organisation");
                System.out.println(name);

                JLabel nameLabel = new JLabel(String.format("%s (UEN: %s)", WordUtils.capitalizeFully(name), record.get("UEN")));
                nameLabel.setFont(new Font("Default", Font.ITALIC, 12));
                gridBagConstraints.weightx = 1;
                gridBagConstraints.weighty = 1;
                gridBagConstraints.gridx = 0;
                gridBagConstraints.gridy = 0;
                itemPanel.add(nameLabel, gridBagConstraints);

                gridBagConstraints.weightx = 1;
                gridBagConstraints.weighty = 1;
                gridBagConstraints.gridx = 0;
                gridBagConstraints.gridy = 1;
                itemPanel.add(helpers.createHyperLink(record.get("Website")), gridBagConstraints);

                gridBagConstraints.weightx = 1;
                gridBagConstraints.weighty = 3;
                gridBagConstraints.gridx = 0;
                gridBagConstraints.gridy = 2;
                itemPanel.add(new JLabel(String.format("<html>%s - %s</html>", record.get("Sector"), record.get("Classification"))), gridBagConstraints);

                listPanel.add(itemPanel);
            }
            itemCount += 1;
        }
    }
}
