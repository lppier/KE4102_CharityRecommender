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
    private Integer itemCount = 0;
    private Helpers helpers = new Helpers();

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
    }

    public void loadSimilarCharities(ArrayList<Map<String, String>> list) {
        listPanel.removeAll();
        itemCount = 0;
        for (Map<String, String> record : list) {
            if (itemCount < 5) {
                JPanel itemPanel = new JPanel();
                itemPanel.setLayout(new BoxLayout(itemPanel, BoxLayout.PAGE_AXIS));

                String name = record.get("Name of Organisation");
                System.out.println(name);

                JLabel nameLabel = new JLabel(WordUtils.capitalizeFully(name));
                nameLabel.setFont(new Font("Default", Font.ITALIC, 12));
                itemPanel.add(nameLabel);
                itemPanel.add(new JLabel("UEN: " + record.get("UEN")));
                itemPanel.add(new JLabel(record.get("Sector") + " - " + record.get("Classification")));

                listPanel.add(itemPanel);
            }
            itemCount += 1;
        }
    }
}
