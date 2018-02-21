package com.company;


import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.text.BreakIterator;

public class Helpers {
    public String getFullpath(String filePath) {
        return getClass().getResource(filePath).getFile();
    }

    public String getFileData(String filePath) throws IOException {
        String contents = "";
        try (BufferedReader br = new BufferedReader(new FileReader(getFullpath(filePath)))) {
            StringBuilder sb = new StringBuilder();
            String line = br.readLine();

            while (line != null) {
                sb.append(line);
                sb.append(System.lineSeparator());
                line = br.readLine();
            }
            contents = sb.toString();
        }

        return contents;
    }

    public Image loadImage(String filePath, Integer width, Integer height) throws IOException {
        BufferedImage img = ImageIO.read(new File(getFullpath(filePath)));
        ImageIcon icon = new ImageIcon(img);
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
        StringBuffer real = new StringBuffer("<html><center>");

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
}
