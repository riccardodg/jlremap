/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap;

/**
 *
 * @author riccardo
 */
public class Utils {

    /**
     *
     * @param a
     * @return
     */
    public static String normalizeSpace(String a) {
        String b = "";
        b = a.replaceAll(" +", " ");
        return b;
    }

    /**
     *
     * @param orig
     * @param ch
     * @return
     */
    public static String changeAlistOfCharsWithCharacter(String orig, String ch) {
        String b = "";
        String tmp = "";
        orig = orig.trim();
        orig = normalizeSpace(orig);
        //System.err.println("orig "+orig);
        tmp = orig.replaceAll("[%^()?:!.,;{} ]+", " ");
        //System.err.println("tmp "+tmp);
        b = tmp.replaceAll(" ", ch);
        //s = re.sub(r'[//\^,:;%" "]+', ch2,string)
        return b;

    }

    /**
     * used to change / in -
     *
     * @param string
     * @param orig
     * @param niu
     * @return
     */
    public static String changeCharWithChar(String string, String orig, String niu) {
        String b = "";

        b = string.replaceAll(orig, niu);
        return b;
    }

    /**
     * This method normalizes the spaces and change a list of specific chars in space. Then substitute
     * the space with @param sp. After it changes @param orig with @param niu.
     * Usually these last are / and -
     * @param string the string to clean
     * @param sp the char which replaces the space
     * @param orig the original, ie / 
     * @param niu the new char ie -
     * @return 
     */
    public static String cleanAgivenStringInInput(String string, String sp,String orig, String niu) {
        String b = "";
        String one ="",two="",three="", four="";
        
        string=string.trim();
        /*normalize spaces*/
        one = normalizeSpace(string);
        
        //System.err.println("one "+one);
        /* change the list with space */
        two = one.replaceAll("[%^()[0-9]?:!.,;#{}\\]\\[ ]+", " ");
        
        /*change space with sp*/
        three = two.replaceAll(" ", sp);
        
        
        b = three.replaceAll(orig, niu);
        
        return b;
    }

}
