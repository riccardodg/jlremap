/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.io;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author riccardo
 */
public class ParseInFile {

    final private String sep = "\t";
    private BufferedReader br;
    private List<List<String>> table;
    private boolean hasTitle;
    private int chk = 0;

    public ParseInFile(boolean hasTitle) {
        this.hasTitle = hasTitle;
        if (hasTitle) {
            this.chk = 1;
        }

    }

    public List<List<String>> parse(String inFileName) throws Exception {
        br = new BufferedReader(new FileReader(inFileName));
        table = new ArrayList<>();
        String line;
        int k = 0;
       
        while ((line = br.readLine()) != null) {
            if (k >= this.chk) {
                if (!line.equals("")) {
                    //System.out.println(line + " " + line.split(sep, -1).length);
                    table.add(Arrays.asList(line.split(sep, -1)));
                }
            }
            k++;
            
        }
        System.out.println("Read # "+k+ " lines!");
        return table;
    }

}
