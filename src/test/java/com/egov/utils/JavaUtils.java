package com.egov.utils;

import java.io.*;
import java.nio.file.*;

public class JavaUtils {

    public static void deleteFile(String fileName) throws Exception{
        File f = new File(fileName);
        Files.deleteIfExists(Paths.get(f.getAbsolutePath()));
        System.out.println("File Deleted Successfully");
    }

    public static void writeToFile(String fileName, String text) throws Exception{

        File f = new File(fileName);
        FileWriter myWriter = new FileWriter(f.getAbsolutePath());
        myWriter.write(text);
        myWriter.close();
        System.out.println("Successfully wrote to the file.");
    }

    public static String readFromFile(String fileName) throws Exception{
        File f = new File(fileName);
        String content = "";
        if(f.exists()){
            content = new String(Files.readAllBytes(Paths.get(fileName)));
            System.out.println("Successfully read from the file");
        }else{
            System.out.println("File does not exists");
        }
        return content;
    }
}