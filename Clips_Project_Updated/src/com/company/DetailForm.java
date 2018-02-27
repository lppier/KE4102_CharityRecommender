package com.company;

import javax.swing.*;
import java.util.Map;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
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
    private JPanel listPanel;
    private JLabel uenLabel;
    private JLabel statusLabel;
    private JLabel typeLabel;
    private JLabel dateOfRegLabel;
    private JLabel ipcStatusLabel;
    private JLabel ipcPeriodLabel;
    private JLabel primarySectorLabel;
    private JLabel subSectorLabel;
    private JLabel addressLabel;

    DetailForm(CharityRecommender recommender) {

        charityRecommender = recommender;

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

    public void loadDetail(Map<String, String> data) {
        titleLabel.setText(WordUtils.capitalizeFully(data.get("Name of Organisation")));
        uenLabel.setText(data.get("UEN"));
        statusLabel.setText(data.get("status"));
        dateOfRegLabel.setText(data.get("date_of_reg"));
        ipcPeriodLabel.setText(data.get("IPC Period"));
        ipcStatusLabel.setText(data.get("ipc_status"));
        primarySectorLabel.setText(data.get("Sector"));
        subSectorLabel.setText(data.get("Classification"));
        typeLabel.setText(data.get("Type"));
        addressLabel.setText(data.get("Address"));
    }
}
