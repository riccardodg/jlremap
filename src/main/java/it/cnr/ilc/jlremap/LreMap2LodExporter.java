/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap;

import it.cnr.ilc.jlremap.controllers.ConfController;
import it.cnr.ilc.jlremap.controllers.YearController;
import it.cnr.ilc.jlremap.entities.LremapConferences;
import it.cnr.ilc.jlremap.entities.LremapYears;
import it.cnr.ilc.jlremap.jena.serializer.ConfSerializer;
import it.cnr.ilc.jlremap.jena.serializer.YearSerializer;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.*;

/**
 * This class is responsible for exporting the whole map or part of it in LOD
 *
 * @author riccardo
 */
public class LreMap2LodExporter {

    /*entities*/
    private static List<LremapYears> years = new ArrayList<LremapYears>();
    private static List<LremapConferences> confs = new ArrayList<LremapConferences>();

    /**
     * for log
     */
    static final String className = LreMap2LodExporter.class.getName();

    /**
     * the Logger
     */
    static Logger log = Logger.getLogger(className);

    /*
     * default values of some debugs
     */
    /**
     * no verbose output to console
     */
    private static boolean __VERBOSE__ = false;

    /**
     * no details on the database records
     */
    private static boolean __PARSERDEBUG__ = false;

    /**
     * no details on the process in its complete form
     */
    private static boolean __STATDEBUG__ = false;

    /**
     * if not specified with the -t switch, all data are saved in the same file
     */
    private static int __SINGLEFILE__ = 0;

    /**
     * default format is RDF. Use -o switch to specify a valid Jena format
     */
    private static String __FORMAT__ = "";
    
    /**
     * current directory
     */
    private static String __DIR__ = System.getProperty("user.dir");

    /**
     * For years, data are serialized in a single file
     */
    private static String __YEAR_FILE__ = "lremap_year";
    
    /**
     * For years, data are serialized in a single file
     */
    private static String __CONF_FILE__ = "lremap_conf";

    /**
     * Base folder for single file
     */
    private static String __SINGLE_FOLDER__ = "/lremap/owl/";

    /**
     * base folder for multiple files
     */
    private static String __MULTI_FOLDER__ = "/lremap/owl/instances/";

    /**
     * main
     *
     * @param args the list of arguments
     * <p>
     * Mandatory
     * <ul>
     * <li>-a whattodo</li>
     * </ul>
     * Other
     * <ul>
     * <li>-l loglevel (default 0 max 7)</li>
     * <li>-t output type (default 0 for single file)</li>
     * <li>-o format (default RDF). Insert any valid Jena output styles</li>
     * </ul>
     *
     */
    public static void main(String[] args) {
        String routine = className + "/main";
        String logmess = "";
        boolean callPrintHelp = true;
        String whatToDo = "";
        int logLevel = 0, singleFile = 0;

        int i = 0;
        for (String a : args) {

            switch (a) {
                case "-a":
                    whatToDo = args[i + 1];
                    callPrintHelp = false;

                    break;
                case "-l":

                    logLevel = Integer.parseInt(args[i + 1]);

                    switch (logLevel) {
                        case 0:
                            break;
                        case 1:
                            __VERBOSE__ = true;
                            break;
                        case 2:
                            __PARSERDEBUG__ = true;
                            break;
                        case 3:
                            __VERBOSE__ = true;
                            __PARSERDEBUG__ = true;
                            break;
                        case 4:
                            __STATDEBUG__ = true;
                            break;
                        case 5:
                            __VERBOSE__ = true;
                            __STATDEBUG__ = true;
                            break;
                        case 6:
                            __PARSERDEBUG__ = true;
                            __STATDEBUG__ = true;
                            break;
                        case 7:
                            __VERBOSE__ = true;
                            __PARSERDEBUG__ = true;
                            __STATDEBUG__ = true;
                            break;
                        default:
                            break;

                    }
                    break;
                case "-t":
                    singleFile = Integer.parseInt(args[i + 1]);
                    break;
                case "-o":
                    __FORMAT__ = args[i + 1];
                    break;

            }
            i++;

        }

        if (callPrintHelp) {
            printHelp();

        }

        logmess = String.format("VERBOSE START Executing %s in LreMap2LodExporter.java", routine);
        log.debug(logmess);

        logmess = String.format("VERBOSE Parameters: whatToDo -%s- logLevel -%d- singleFile -%d-", whatToDo, logLevel, singleFile);
        log.debug(logmess);

        if (whatToDo.equalsIgnoreCase("y")) {
            serializeYears();
        }
        
        if (whatToDo.equalsIgnoreCase("c")) {
            serializeYears();
            serializeConferences();
        }

    }

    /**
     * serialize years
     */
    private static void serializeYears() {
        String routine = className + "/serializeYears";
        String logmess = "";
        YearController controller = new YearController();
        
        YearSerializer serializer;

        String outYearFile = __DIR__ + __SINGLE_FOLDER__ + __YEAR_FILE__;
        /**
         * ONLY SINFLE FILE *
         */
        if (__VERBOSE__) {
            logmess = String.format("VERBOSE Extracting YEAR in %s", routine);
            log.debug(logmess);
        }
        years = controller.getYears();

        if (__VERBOSE__) {
            logmess = String.format("VERBOSE CREATING OutputStream in %s using -%s-", routine, outYearFile);
            log.debug(logmess);
        }
        try {
            OutputStream out = new FileOutputStream(outYearFile);
            PrintStream ps = new PrintStream(out);
            if (__FORMAT__.equals("")) {
                serializer = new YearSerializer(years, ps);

            } else {
                serializer = new YearSerializer(years, ps, __FORMAT__);
            }
            serializer.write();
        } catch (Exception e) {
        }

    }
    
    /**
     * serialize years
     */
    private static void serializeConferences() {
        String routine = className + "/serializeConferences";
        String logmess = "";
        ConfController controller = new ConfController();
        
        ConfSerializer serializer;

        String outFile = __DIR__ + __SINGLE_FOLDER__ + __CONF_FILE__;
        /**
         * ONLY SINFLE FILE *
         */
        if (__VERBOSE__) {
            logmess = String.format("VERBOSE Extracting YEAR in %s", routine);
            log.debug(logmess);
        }
        confs = controller.geConferences();

        if (__VERBOSE__) {
            logmess = String.format("VERBOSE CREATING OutputStream in %s using -%s-", routine, outFile);
            log.debug(logmess);
        }
        try {
            OutputStream out = new FileOutputStream(outFile);
            PrintStream ps = new PrintStream(out);
            if (__FORMAT__.equals("")) {
                serializer = new ConfSerializer(confs, ps);

            } else {
                serializer = new ConfSerializer(confs, ps, __FORMAT__);
            }
            serializer.write();
        } catch (Exception e) {
        }

    }

    /**
     * printhelp
     */
    private static void printHelp() {
        System.err.println("usage: java -jar  LreMap2LodExporter.jar -a dowhat -l logleval -t outputfile");
        System.err.println("\tlogleval Values from 0 to 7. verbose (0), parser_debug (1) and stat_debug (2) can be set on/off Default 0 corresponding all debugs set to 0");
        System.err.println("\toutputfile 0 for single file, 1 for distinct files. Default 0");
        System.err.println("\tdowhat is a string with the following values:");
        System.err.println("\t\t y\t to extract the list of years");
        System.err.println("\t\t c\t to extract the list of conferences");
        System.err.println("\t\t s\t to extract the list of submissions");
        System.err.println("\t\t a\t to extract the list of authors");
        System.err.println("\t\t p\t to extract the list of papers");
        System.err.println("\t\t ap\t to extract the list of papers and connected authors");
        System.err.println("\t\t r\t to extract the list of resources");
        System.err.println("\t\t rn\t to extract the list of normalized resources");
        System.err.println("\t\t rt\t to extract the list of template resources");
        System.err.println("\t\t all\t to extract all the map");

    }

    /**
     * @return the years
     */
    public List<LremapYears> getYears() {
        return years;
    }

    /**
     * @param years the years to set
     */
    public void setYears(List<LremapYears> years) {
        this.years = years;
    }
}
