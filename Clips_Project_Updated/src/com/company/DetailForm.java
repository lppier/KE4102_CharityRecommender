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
//        System.out.println("Load Similar Charities");
//        System.out.println("----------------------");

        listPanel.removeAll();
        itemCount = 0;
        gridBagConstraints.anchor = GridBagConstraints.NORTHWEST;
        for (Map<String, String> record : list) {
            if (itemCount < 5) {
                JPanel itemPanel = new JPanel();
                itemPanel.setLayout(new GridBagLayout());

                String name = record.get("Name of Organisation");
                String uen = record.get("UEN");
                String website = record.get("Website");
                String primary_sector = record.get("Sector");
                String sub_sector = record.get("Classification");

//                System.out.println(String.format("Name: %s", name));
//                System.out.println(String.format("UEN: %s", uen));
//                System.out.println(String.format("Website: %s", website));
//                System.out.println(String.format("Sector: %s", primary_sector));
//                System.out.println(String.format("Sub Sector: %s", sub_sector));
//                System.out.println("----------------------");

                JLabel nameLabel = new JLabel(String.format("%s (UEN: %s)", WordUtils.capitalizeFully(name), uen));
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
                itemPanel.add(helpers.createHyperLink(website), gridBagConstraints);

                gridBagConstraints.weightx = 1;
                gridBagConstraints.weighty = 1;
                gridBagConstraints.gridx = 0;
                gridBagConstraints.gridy = 2;
                itemPanel.add(new JLabel(String.format("%s - %s", primary_sector, sub_sector)), gridBagConstraints);

                gridBagConstraints.weightx = 1;
                gridBagConstraints.weighty = 1;
                gridBagConstraints.gridx = 0;
                gridBagConstraints.gridy = 3;
                itemPanel.add(new JLabel(" "), gridBagConstraints);

                listPanel.add(itemPanel);
            }
            itemCount += 1;
        }
    }
}
