package com.company;


import java.io.*;
import java.net.URL;
import java.util.Scanner;
import java.lang.Object;

public class Helpers {
    public String getFileData(String filePath) throws FileNotFoundException, IOException{
/*
        StringBuilder result = new StringBuilder("");

        //Get file from resources folder
        ClassLoader classLoader = getClass().getClassLoader();

        // r  = this.getClass().getClassLoader().
        File file = new File(this.getClass().getClassLoader().getResource(fileName).getFile());

        try (Scanner scanner = new Scanner(file)) {

            while (scanner.hasNextLine()) {
                String line = scanner.nextLine();
                result.append(line).append("\n");
            }

            scanner.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return result.toString();
*/
        String contents = "";
        try(BufferedReader br = new BufferedReader(new FileReader(filePath))) {
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
