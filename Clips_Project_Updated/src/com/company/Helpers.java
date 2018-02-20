package com.company;


import java.io.*;

public class Helpers {
    private String getFullpath(String filePath) {
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
}
