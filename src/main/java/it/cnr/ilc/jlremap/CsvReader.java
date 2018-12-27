/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap;

import it.cnr.ilc.jlremap.db.DbConnect;
import it.cnr.ilc.jlremap.io.ParseInFile;
import it.cnr.ilc.jlremap.io.WriteFiles;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author riccardo
 */
public class CsvReader {

    public static void main(String[] args) throws Exception {
        List<List<String>> records;
        List<List<String>> updates=new ArrayList();
        List<String> files;
        List<String> tables = new ArrayList<String>();
        List<String> updtables = new ArrayList<String>();
        
        List<String> langs = new ArrayList<String>();
        
        BufferedWriter bwupd;
        File fileupd;
        FileWriter fwupd;
        

        tables.add("stage_lremap_resource_keys");
        tables.add("stage_lremap_resource");
        tables.add("stage_lremap_resource_norm");
        
        updtables.add("stage_lremap_resource_norm");
        updtables.add("stage_lremap_resource");

        langs.add("stage_lremap_resource_lang");
        langs.add("stage_lremap_resource_lang_norm");
        String stm = "";
        System.err.println("File to parse " + args[1]);
        System.err.println("Switch " + args[1]);
        ParseInFile parseinfile = new ParseInFile(true);
        records = parseinfile.parse(args[1]);
        WriteFiles writefiles = new WriteFiles(records, args[1]);
        DbConnect connect = new DbConnect();
        Connection conn = connect.db_connect();
        
        if (args[0].equals("-d")) {
            files = writefiles.writefile();
            System.out.println(files);

            int i = 0, l = 0;
            for (String file : files) {
                stm = String.format("LOAD DATA LOCAL INFILE  '%s' INTO TABLE %s CHARACTER SET utf8 FIELDS  terminated by '\\t' OPTIONALLY ENCLOSED BY '\"';", file, tables.get(i));
                System.out.println(stm);
                connect.execStm(conn, stm);
                i++;
            }
        }
        // langs

        if (args[0].equals("-l")) {
            files = writefiles.writeLangfile();
            System.out.println(files);

            int i = 0, l = 0;
            for (String file : files) {
                stm = String.format("LOAD DATA LOCAL INFILE  '%s' INTO TABLE %s CHARACTER SET utf8 FIELDS  terminated by '\\t' OPTIONALLY ENCLOSED BY '\"';", file, langs.get(i));
                System.out.println(stm);
                connect.execStm(conn, stm);
                i++;
            }
        }
        
        // update

        if (args[0].equals("-u")) {
            if (args[2] !="")
                
            updates = writefiles.writeUpdateSqlfiles(args[3]);
            System.out.println(updates.get(0));
            fileupd = new File(args[1]+ ".sql");
            fwupd = new FileWriter(fileupd);
            bwupd = new BufferedWriter(fwupd);
            
            //System.out.println(args[1]);

            int i = 0, l = 0;
            for (List<String> items : updates) {
                for (String item:items){
                    stm = String.format("UPDATE  %s %s ",  updtables.get(i), item);
                    System.out.println(stm);
                    bwupd.write(stm);
                    bwupd.write("\n");
                }
                
                //connect.execStm(conn, stm);
                i++;
            }
            bwupd.close();
        }

    }

}
