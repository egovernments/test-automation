package com.egov.base;

import java.io.*;
import java.util.*;

public class testReadFile
{
    public String updateFile(Map<String, String> userNames) throws IOException {
        String oldUserName = userNames.get("old");
        String newUserName = userNames.get("new"); 
        String env = userNames.get("env");
        List<String> lines = new ArrayList<String>();
        // String line = null;
        
        String userDir = System.getProperty("user.dir");
        String path = userDir+"/envYaml/"+env+"/"+env+".yaml";
        File file = new File(path);
        StringBuilder sb = new StringBuilder();
        InputStream in = new FileInputStream(file);
        BufferedReader br = new BufferedReader(new InputStreamReader(in));
 
        String line;
        while ((line = br.readLine()) != null) {
            if(line.contains(oldUserName)){
                line = line.replace(oldUserName,newUserName);
            }
            lines.add(line);
            // sb.append(line + System.lineSeparator());
        }
        br.close();
        in.close();
        FileWriter  fw = new FileWriter (path);
        BufferedWriter out = new BufferedWriter(fw);
        for(String s : lines){
            out.write(s +  System.lineSeparator());
            sb.append(s  + System.lineSeparator());
        }
                
            out.flush();
            out.close();

        

        return sb.toString();
        // return System.getProperty("user.dir");
    }
    
}
