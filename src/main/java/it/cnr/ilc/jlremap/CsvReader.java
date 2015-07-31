/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap;

import it.cnr.ilc.jlremap.db.DbConnect;
import it.cnr.ilc.jlremap.io.ParseInFile;
import it.cnr.ilc.jlremap.io.WriteFiles;
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
        List<String> files;
        List<String> tables = new ArrayList<String>();
        List<String> langs = new ArrayList<String>();

        tables.add("stage_lremap_resource_keys");
        tables.add("stage_lremap_resource");
        tables.add("stage_lremap_resource_norm");

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

    }

}
