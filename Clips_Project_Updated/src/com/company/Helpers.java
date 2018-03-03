package com.company;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.text.BreakIterator;
import java.util.*;
import java.util.stream.*;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

public class Helpers {

    public String getFileData(String filePath) throws IOException {
        String contents = "";
        BufferedReader br = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream(filePath)));
        StringBuilder sb = new StringBuilder();
        String line = br.readLine();

        while (line != null) {
            sb.append(line);
            sb.append(System.lineSeparator());
            line = br.readLine();
        }
        contents = sb.toString();

        return contents;
    }

    public Image loadImage(String filePath, Integer width, Integer height) {
        ImageIcon icon = new ImageIcon(getClass().getResource(filePath));
        Image image = icon.getImage();
        return image.getScaledInstance(width, height, Image.SCALE_SMOOTH);
    }

    /*****************/
    /* wrapLabelText */

    /*****************/
    public void wrapLabelText(
            JLabel label,
            String text) {
        FontMetrics fm = label.getFontMetrics(label.getFont());
        Container container = label.getParent();
        int containerWidth = container.getWidth();
        int textWidth = SwingUtilities.computeStringWidth(fm, text);
        int desiredWidth;

        if (textWidth <= containerWidth) {
            desiredWidth = containerWidth;
        } else {
            int lines = (int) ((textWidth + containerWidth) / containerWidth);

            desiredWidth = (int) (textWidth / lines);
        }

        BreakIterator boundary = BreakIterator.getWordInstance();
        boundary.setText(text);

        StringBuffer trial = new StringBuffer();
        StringBuffer real = new StringBuffer("<html>");

        int start = boundary.first();
        for (int end = boundary.next(); end != BreakIterator.DONE;
             start = end, end = boundary.next()) {
            String word = text.substring(start, end);

            // Add a line break if the current word contains a line separator
            if (word.contains(System.lineSeparator())) {
                trial = new StringBuffer("");
                real.append("<br>");
            } else {
                trial.append(word);
                int trialWidth = SwingUtilities.computeStringWidth(fm, trial.toString());
                if (trialWidth > containerWidth) {
                    trial = new StringBuffer(word);
                    real.append("<br>");
                    real.append(word);
                } else if (trialWidth > desiredWidth) {
                    trial = new StringBuffer("");
                    real.append(word);
                    real.append("<br>");
                } else {
                    real.append(word);
                }
            }
        }

        real.append("</html>");

        label.setText(real.toString());
    }

    public Component createDetailLink(Map<String, String> record, ActionListener actionListener) {
        JPanel panel = new JPanel();
        FlowLayout layout = new FlowLayout();
        layout.setAlignment(FlowLayout.RIGHT);
        layout.setHgap(0);
        layout.setVgap(0);
        panel.setLayout(layout);

        JButton button = new JButton("<html><u>View Details</u></html>");
        button.setBorder(BorderFactory.createLineBorder(Color.BLACK));
        button.setCursor(new Cursor(Cursor.HAND_CURSOR));
        button.setForeground(Color.BLUE);
        button.setBorderPainted(false);
        button.setOpaque(false);
        button.setBackground(Color.WHITE);
        button.setToolTipText("Look into " + record.get("Name of Organisation"));
        button.addActionListener(actionListener);

        panel.add(button);
        return panel;
    }

    public Component createHyperLink(String link) {
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
            JButton button = new JButton(String.format("<html><u>%s</u></html>", uri.toString()));
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
            JLabel noLinkLabel = new JLabel("N/A");
            noLinkLabel.setForeground(Color.GRAY);
            panel.add(noLinkLabel);
        }
        return panel;
    }

    public LinkedHashMap<String, Map<String, String>> readCSV(String filePath, String keyColumn) throws IOException {
        try (
                BufferedReader reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream(filePath)));
                CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT
                        .withFirstRecordAsHeader()
                        .withIgnoreHeaderCase()
                        .withTrim());
        ) {
            LinkedHashMap<String, Map<String, String>> hashMap = new LinkedHashMap<>();
            Iterable<CSVRecord> csvRecords = csvParser.getRecords();
            for (CSVRecord csvRecord : csvRecords) {
                hashMap.put(csvRecord.get(keyColumn), csvRecord.toMap());
            }
            return hashMap;
        }
    }

    public TreeMap<String, Double> sortByKey(Map<String, Double> map) {
        return new TreeMap<String, Double>(map);
    }

    public <K, V extends Comparable<? super V>> Map<K, V> sortByValue(Map<K, V> map, Boolean asc) {
        if (asc) {
            return map.entrySet()
                    .stream()
                    .sorted(Map.Entry.comparingByValue())
                    .collect(Collectors.toMap(
                            Map.Entry::getKey,
                            Map.Entry::getValue,
                            (e1, e2) -> e1,
                            LinkedHashMap::new
                    ));
        } else {
            return map.entrySet()
                    .stream()
                    .sorted(Map.Entry.comparingByValue(Collections.reverseOrder()))
                    .collect(Collectors.toMap(
                            Map.Entry::getKey,
                            Map.Entry::getValue,
                            (e1, e2) -> e1,
                            LinkedHashMap::new
                    ));

        }
    }

    public <K, V> Map<K, V> getFirstN(Map<K, V> map, Integer count) {
        return map.entrySet().stream().limit(count)
                .collect(LinkedHashMap::new, (m, e) -> m.put(e.getKey(), e.getValue()), LinkedHashMap::putAll);
    }
}
