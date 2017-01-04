/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.io;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author riccardo
 */
public class WriteFiles {

    final private String sep = "\t";
    private BufferedWriter bwkeys;
    private BufferedWriter bwauth;
    private BufferedWriter bwnorm;
    FileWriter fwkeys;
    FileWriter fwauth;
    FileWriter fwnorm;
    private static final String __NA__ = "__NOT_PROVIDED__";
    private List<List<String>> table;
    private String inFile;
    private String __CONF__;
    private String __YEAR__;
    private String __PASSCODE__;
    private String __RESID__;
    private String __RESOURCETYPE__;
    private String __RESOURCETYPE_CLEAN__;
    private String __RESOURCENAME__;
    private String __RESOURCENAME_CLEAN__;
    private String __RESOURCEPRODSTATUS__;
    private String __RESOURCEPRODSTATUS_CLEAN__;
    private String __RESOURCELANG_1__;
    private String __RESOURCELANG_1_CLEAN__;
    private String __RESOURCELANG_2__;
    private String __RESOURCELANG_2_CLEAN__;
    private String __RESOURCELANG_3__;
    private String __RESOURCELANG_3_CLEAN__;
    private String __RESOURCELANG_4__;
    private String __RESOURCELANG_4_CLEAN__;
    private String __RESOURCELANG_5__;
    private String __RESOURCELANG_5_CLEAN__;
    private String __RESOURCELANG_O__;
    private String __RESOURCELANG_O_CLEAN__;
    private String __RESOURCELANGDIM__;
    private String __RESOURCEMODALITY__;
    private String __RESOURCEMODALITY_CLEAN__;
    private String __RESOURCEUSE__;
    private String __RESOURCEUSE_CLEAN__;
    private String __RESOURCEAVAIL__;
    private String __RESOURCEAVAIL_CLEAN__;
    private String __RESOURCEURL__;
    private String __RESOURCESIZE__;
    private String __RESOURCESIZE_1__;
    private String __RESOURCELIC__;
    private String __RESOURCEDOC__;
    private String __TOT__;
    private String __ORIG__;
    private String __LP_AP__;
    private String __CLEAN__;
    private String __AUTHUPD__;

    public WriteFiles(List<List<String>> table) {
        this.table = table;
    }

    public WriteFiles(List<List<String>> table, String inFile) {
        this.table = table;
        this.inFile = inFile;
    }

    /**
     * the structure of the file is
     * <ul>
     * <li>0 conf
     * <li>1 year
     * <li>2 passcode
     * <li>3 resid
     * <li>4 ResourceType
     * <li>5 ResourceType-Clean
     * <li>6 resourceName
     * <li>7 ResourceName-Clean
     * <li>8 ResourceProdStatus
     * <li>9 ResourceProdStatus_clean
     * <li>10 ResourceModality
     * <li>11 ResourceModality_clean
     * <li>12 ResourceUse
     * <li>13 ResourceUse_clean
     * <li>14 ResourceAvail
     * <li>15 ResourceAvail_clean
     * <li>16 ResourceUrl
     * <li>17 ResourceSize
     * <li>18 ResourceSize_1
     * <li>19 ResourceLicense
     * <li>20 ResourceDoc
     * </ul>
     * <ul>
     * <li>fields 0,1,2,3,4,6,8 form the natural key
     * <li>added fields 5,7,9 form the normalized natural key
     *
     * <li>fields contained in file norm 0,1,2,3,5,7,9,11,13,15,16,17,18,19,20
     *
     * <li>fields contained in file auth 0,1,2,3,4,6,8,10,12,14,16,17,18,19,20
     *
     * <li>fields contained in file keys 0,1,2,3,4,6,8,5,7,9
     * </ul>
     *
     *
     * @throws Exception
     */
    public List<String> writefile() throws Exception {
        boolean goahead = true;
        String passChk = "";
        int resid = 1;
        List<String> files = new ArrayList<String>();
        File filekeys = new File(this.inFile + ".keys");
        File filenorm = new File(this.inFile + ".norm");
        File fileauthor = new File(this.inFile + ".auth");
        fwkeys = new FileWriter(filekeys.getAbsoluteFile());
        fwauth = new FileWriter(fileauthor.getAbsoluteFile());
        fwnorm = new FileWriter(filenorm.getAbsoluteFile());
        System.out.print(filekeys.getAbsoluteFile());
        bwkeys = new BufferedWriter(fwkeys);
        bwauth = new BufferedWriter(fwauth);
        bwnorm = new BufferedWriter(fwnorm);
        int i = 0;
        int num = 0;
        for (List<String> items : table) {
            /*init fields*/
            //System.err.println(items + " " + items);
            __CONF__ = items.get(0);
            __YEAR__ = items.get(1);
            __PASSCODE__ = items.get(2);
            __RESID__ = items.get(3);
            __RESOURCETYPE__ = items.get(4);
            __RESOURCETYPE_CLEAN__ = items.get(5);
            __RESOURCENAME__ = items.get(6);
            __RESOURCENAME_CLEAN__ = items.get(7);
            __RESOURCEPRODSTATUS__ = items.get(8);
            __RESOURCEPRODSTATUS_CLEAN__ = items.get(9);
            __RESOURCEMODALITY__ = items.get(10);
            __RESOURCEMODALITY_CLEAN__ = items.get(11);
            __RESOURCEUSE__ = items.get(12);
            __RESOURCEUSE_CLEAN__ = items.get(13);
            __RESOURCEAVAIL__ = items.get(14);
            __RESOURCEAVAIL_CLEAN__ = items.get(15);
            __RESOURCEURL__ = items.get(16);
            __RESOURCESIZE__ = items.get(17);
            __RESOURCESIZE_1__ = items.get(18);
            __RESOURCELIC__ = items.get(19);
            __RESOURCEDOC__ = items.get(20);
            /*write file keys
             fields contained in file keys 0,1,2,3,4,6,8,5,7,9
             */
 /*check auth nk values*/

            if (__PASSCODE__.equals("")) {
                goahead = false;
            }

            if (__CONF__.equals("")) {
                goahead = false;
            }

            if (__YEAR__.equals("")) {
                goahead = false;
            }

            if (__RESOURCETYPE__.equals("") || __RESOURCETYPE__.equalsIgnoreCase("NULL") || __RESOURCETYPE__==null) {
                __RESOURCETYPE__ = __NA__;
                
            }

            if (__RESOURCENAME__.equals("") || __RESOURCENAME__.equals("NULL") || __RESOURCENAME__==null) {
                __RESOURCENAME__ = __NA__;
                System.err.println("NULL "+__RESOURCENAME__);
            }

            if (__RESOURCEPRODSTATUS__.equals("")|| __RESOURCEPRODSTATUS__.equals("NULL") || __RESOURCEPRODSTATUS__==null) {
                __RESOURCEPRODSTATUS__ = __NA__;
                
            }

            /*check norm nk values*/
            if (__RESOURCETYPE_CLEAN__.equals("") ) {
                if (__RESOURCETYPE__.equals(__NA__)) {
                    __RESOURCETYPE_CLEAN__ = __NA__;
                } else {
                    __RESOURCETYPE_CLEAN__ = __RESOURCETYPE__;
                }
            }

            if (__RESOURCENAME_CLEAN__.equals("")) {
                if (__RESOURCENAME__.equals(__NA__)) {
                    __RESOURCENAME_CLEAN__ = __NA__;
                } else {
                    __RESOURCENAME_CLEAN__ = __RESOURCENAME__;
                }
            }

            if (__RESOURCEPRODSTATUS_CLEAN__.equals("")) {
                if (__RESOURCEPRODSTATUS__.equals(__NA__)) {
                    __RESOURCEPRODSTATUS_CLEAN__ = __NA__;
                } else {
                    __RESOURCEPRODSTATUS_CLEAN__ = __RESOURCEPRODSTATUS__;
                }
            }

            /*check resid*/
            // System.err.println("resid -"+__RESID__+"-");
            if (__RESID__.equals("")) {
                if (__PASSCODE__.equals(passChk)) {
                    resid = resid + 1;
                } else {
                    resid = 1;
                }
                __RESID__ = new Integer(resid).toString();
            }
            //System.err.println("resid1 -"+__RESID__+"-");

            /*check other fields */
            if (__RESOURCEAVAIL_CLEAN__.equals("")) {
                if (__RESOURCEAVAIL__.equals(__NA__) || __RESOURCEAVAIL__.equals("")) {
                    __RESOURCEAVAIL_CLEAN__ = __NA__;
                } else {
                    __RESOURCEAVAIL_CLEAN__ = __RESOURCEAVAIL__;
                }
            }

            if (__RESOURCEMODALITY_CLEAN__.equals("")) {
                if (__RESOURCEMODALITY__.equals(__NA__) || __RESOURCEMODALITY__.equals("")) {
                    __RESOURCEMODALITY_CLEAN__ = __NA__;
                } else {
                    __RESOURCEMODALITY_CLEAN__ = __RESOURCEMODALITY__;
                }
            }

            if (__RESOURCEUSE_CLEAN__.equals("")) {
                if (__RESOURCEUSE__.equals(__NA__) || __RESOURCEUSE__.equals("")) {
                    __RESOURCEUSE_CLEAN__ = __NA__;
                } else {
                    __RESOURCEUSE_CLEAN__ = __RESOURCEUSE__;
                }
            }
            if (goahead) {
                /*write keys 0,1,2,3,4,6,8,5,7,9 */
                bwkeys.write(__CONF__ + sep); //0
                bwkeys.write(__YEAR__ + sep);//1
                bwkeys.write(__PASSCODE__ + sep); //2
                bwkeys.write(__RESID__ + sep); //3
                bwkeys.write(__RESOURCETYPE__ + sep); //4
                bwkeys.write(__RESOURCENAME__ + sep); //6
                bwkeys.write(__RESOURCEPRODSTATUS__ + sep); //8

                bwkeys.write(__RESOURCETYPE_CLEAN__ + sep); //5
                bwkeys.write(__RESOURCENAME_CLEAN__ + sep); //7
                bwkeys.write(__RESOURCEPRODSTATUS_CLEAN__ + sep); //9
                bwkeys.write("\n");

                /*write auth 0,1,2,3,4,6,8,10,12,14,16,17,18,19,20*/
                bwauth.write(__CONF__ + sep); //0
                bwauth.write(__YEAR__ + sep);//1
                bwauth.write(__PASSCODE__ + sep); //2
                bwauth.write(__RESID__ + sep); //3
                bwauth.write(__RESOURCETYPE__ + sep); //4
                bwauth.write(__RESOURCENAME__ + sep); //6
                bwauth.write(__RESOURCEPRODSTATUS__ + sep); //8

                bwauth.write(__RESOURCEMODALITY__ + sep); //10
                bwauth.write(__RESOURCEUSE__ + sep); //12

                bwauth.write(__RESOURCEAVAIL__ + sep); //14

                bwauth.write(__RESOURCEURL__ + sep); //16
                bwauth.write(__RESOURCESIZE__ + sep); //17
                bwauth.write(__RESOURCESIZE_1__ + sep); //18
                bwauth.write(__RESOURCELIC__ + sep); //19
                bwauth.write(__RESOURCEDOC__ + sep); //20
                bwauth.write("\n");

                /*write norm 0,1,2,3,5,7,9,11,13,15,16,17,18,19,20*/
                bwnorm.write(__CONF__ + sep); //0
                bwnorm.write(__YEAR__ + sep);//1
                bwnorm.write(__PASSCODE__ + sep); //2
                bwnorm.write(__RESID__ + sep); //3
                bwnorm.write(__RESOURCETYPE_CLEAN__ + sep); //5
                bwnorm.write(__RESOURCENAME_CLEAN__ + sep); //7
                bwnorm.write(__RESOURCEPRODSTATUS_CLEAN__ + sep); //9

                bwnorm.write(__RESOURCEMODALITY_CLEAN__ + sep); //11
                bwnorm.write(__RESOURCEUSE_CLEAN__ + sep); //13

                bwnorm.write(__RESOURCEAVAIL_CLEAN__ + sep); //15

                bwnorm.write(__RESOURCEURL__ + sep); //16
                bwnorm.write(__RESOURCESIZE__ + sep); //17
                bwnorm.write(__RESOURCESIZE_1__ + sep); //18
                bwnorm.write(__RESOURCELIC__ + sep); //19
                bwnorm.write(__RESOURCEDOC__ + sep); //20
                bwnorm.write("\n");
                if (i == 0) {
                    files.add(filekeys.getAbsolutePath());
                    files.add(fileauthor.getAbsolutePath());
                    files.add(filenorm.getAbsolutePath());
                }
            }
            i++;
            passChk = __PASSCODE__;
            num++;
        } // end for

        bwkeys.close();
        bwauth.close();
        bwnorm.close();
        System.out.println("Write # " + num + " lines!");
        return files;
    }

    /**
     * the structure of the file is
     * <ul>
     * <li>0 conf
     * <li>1 year
     * <li>2 passcode
     * <li>3 resid
     * <li>4 ResourceType
     * <li>5 ResourceType-Clean
     * <li>6 resourceName
     * <li>7 ResourceName-Clean
     * <li>8 ResourceProdStatus
     * <li>9 ResourceProdStatus_clean
     * <li>10 lang1
     * <li>11 lang1_clean
     * <li>12 lang2
     * <li>13 lang2_clean
     * <li>14 lang3
     * <li>15 lang3_clean
     * <li>16 lang4
     * <li>17 lang4_clean
     * <li>18 lang5
     * <li>19 lang5_clean
     * <li>20 langother
     * <li>21 langother_clean
     * <li>22 langdim
     * </ul>
     * <ul>
     * <li>fields 0,1,2,3,4,6,8 form the natural key
     * <li>added fields 5,7,9 form the normalized natural key
     *
     * <li>fields contained in file norm 0,1,2,3,5,7,9,11,13,15,16,17,18,19,20
     *
     * <li>fields contained in file auth 0,1,2,3,4,6,8,10,12,14,16,17,18,19,20
     *
     * <li>fields contained in file keys 0,1,2,3,4,6,8,5,7,9
     * </ul>
     *
     *
     * @throws Exception
     */
    public List<String> writeLangfile() throws Exception {
        boolean goahead = true;
        String passChk = "";
        int resid = 1;
        List<String> files = new ArrayList<String>();
        File filenorm = new File(this.inFile + ".norm");
        File fileauthor = new File(this.inFile + ".auth");

        fwauth = new FileWriter(fileauthor.getAbsoluteFile());
        fwnorm = new FileWriter(filenorm.getAbsoluteFile());

        bwauth = new BufferedWriter(fwauth);
        bwnorm = new BufferedWriter(fwnorm);
        int i = 0;
        for (List<String> items : table) {
            /*init fields*/
            //System.err.println("items  at " + i + ":  " + items);
            try {
                __CONF__ = items.get(0);
                __YEAR__ = items.get(1);
                __PASSCODE__ = items.get(2);
                __RESID__ = items.get(3);
                __RESOURCETYPE__ = items.get(4);
                __RESOURCETYPE_CLEAN__ = items.get(5);
                __RESOURCENAME__ = items.get(6);
                __RESOURCENAME_CLEAN__ = items.get(7);
                __RESOURCEPRODSTATUS__ = items.get(8);
                __RESOURCEPRODSTATUS_CLEAN__ = items.get(9);
                __RESOURCELANG_1__ = items.get(10);
                __RESOURCELANG_1_CLEAN__ = items.get(11);

                __RESOURCELANG_2__ = items.get(12);
                __RESOURCELANG_2_CLEAN__ = items.get(13);

                __RESOURCELANG_3__ = items.get(14);
                __RESOURCELANG_3_CLEAN__ = items.get(15);

                __RESOURCELANG_4__ = items.get(16);
                __RESOURCELANG_4_CLEAN__ = items.get(17);

                __RESOURCELANG_5__ = items.get(18);
                __RESOURCELANG_5_CLEAN__ = items.get(19);

                __RESOURCELANG_O__ = items.get(20);
                __RESOURCELANG_O_CLEAN__ = items.get(21);
                __RESOURCELANGDIM__ = items.get(22);
            } catch (Exception e) {
                System.err.println("WRONG item  at " + i + ":  " + items);
            } 

            /*write file keys
             fields contained in file keys 0,1,2,3,4,6,8,5,7,9
             */
 /*check auth nk values*/
            if (__PASSCODE__.equals("")) {
                goahead = false;
            }

            if (__CONF__.equals("")) {
                goahead = false;
            }

            if (__YEAR__.equals("")) {
                goahead = false;
            }

            if (__RESOURCETYPE__.equals("") || __RESOURCETYPE__.equalsIgnoreCase("NULL") || __RESOURCETYPE__==null) {
                __RESOURCETYPE__ = __NA__;
                
            }

            if (__RESOURCENAME__.equals("") || __RESOURCENAME__.equals("NULL") || __RESOURCENAME__==null) {
                __RESOURCENAME__ = __NA__;
                
            }

            if (__RESOURCEPRODSTATUS__.equals("")|| __RESOURCEPRODSTATUS__.equals("NULL") || __RESOURCEPRODSTATUS__==null) {
                __RESOURCEPRODSTATUS__ = __NA__;
                System.err.println("NULL "+__RESOURCEPRODSTATUS__);
                
            }


            /*check norm nk values*/
            if (__RESOURCETYPE_CLEAN__.equals("")) {
                if (__RESOURCETYPE__.equals(__NA__)) {
                    __RESOURCETYPE_CLEAN__ = __NA__;
                } else {
                    __RESOURCETYPE_CLEAN__ = __RESOURCETYPE__;
                }
            }

            if (__RESOURCENAME_CLEAN__.equals("")) {
                if (__RESOURCENAME__.equals(__NA__)) {
                    __RESOURCENAME_CLEAN__ = __NA__;
                } else {
                    __RESOURCENAME_CLEAN__ = __RESOURCENAME__;
                }
            }

            if (__RESOURCEPRODSTATUS_CLEAN__.equals("")) {
                if (__RESOURCEPRODSTATUS__.equals(__NA__)) {
                    __RESOURCEPRODSTATUS_CLEAN__ = __NA__;
                } else {
                    __RESOURCEPRODSTATUS_CLEAN__ = __RESOURCEPRODSTATUS__;
                }
            }

            /*check resid*/
            if (__RESID__.equals("")) {
                if (__PASSCODE__.equals(passChk)) {
                    resid = resid + 1;
                    //System.err.println("resid1 chk pc -" + __RESID__ + "-");
                } else {
                    resid = 1;
                }
                __RESID__ = new Integer(resid).toString();
                //System.err.println("resid1 -" + __RESID__ + "-");
            } else {
                //System.err.println("resid1 ELSE -" + __RESID__ + "-");
            }

            /*check langs fields */
            if (__RESOURCELANG_1_CLEAN__.equals("")) {
                if (__RESOURCELANG_1__.equals(__NA__)) {
                    __RESOURCELANG_1_CLEAN__ = __NA__;
                } else {
                    __RESOURCELANG_1_CLEAN__ = __RESOURCELANG_1__;
                }
            }

            if (__RESOURCELANG_2_CLEAN__.equals("")) {
                if (__RESOURCELANG_2__.equals(__NA__)) {
                    __RESOURCELANG_2_CLEAN__ = __NA__;
                } else {
                    __RESOURCELANG_2_CLEAN__ = __RESOURCELANG_2__;
                }
            }

            if (__RESOURCELANG_3_CLEAN__.equals("")) {
                if (__RESOURCELANG_3__.equals(__NA__)) {
                    __RESOURCELANG_3_CLEAN__ = __NA__;
                } else {
                    __RESOURCELANG_3_CLEAN__ = __RESOURCELANG_3__;
                }
            }

            if (__RESOURCELANG_4_CLEAN__.equals("")) {
                if (__RESOURCELANG_4__.equals(__NA__)) {
                    __RESOURCELANG_4_CLEAN__ = __NA__;
                } else {
                    __RESOURCELANG_4_CLEAN__ = __RESOURCELANG_4__;
                }
            }

            if (__RESOURCELANG_5_CLEAN__.equals("")) {
                if (__RESOURCELANG_5__.equals(__NA__)) {
                    __RESOURCELANG_5_CLEAN__ = __NA__;
                } else {
                    __RESOURCELANG_5_CLEAN__ = __RESOURCELANG_5__;
                }
            }

            if (__RESOURCELANG_O_CLEAN__.equals("")) {
                if (__RESOURCELANG_O__.equals(__NA__)) {
                    __RESOURCELANG_O_CLEAN__ = __NA__;
                } else {
                    __RESOURCELANG_O_CLEAN__ = __RESOURCELANG_O__;
                }
            }

            if (__RESOURCELANGDIM__.equals("")) {
                __RESOURCELANGDIM__ = __NA__;
            }

            if (goahead) {


                /*write auth 0,1,2,3,4,6,8,10,12,14,16,18,20*/
                bwauth.write(__CONF__ + sep); //0
                bwauth.write(__YEAR__ + sep);//1
                bwauth.write(__PASSCODE__ + sep); //2
                bwauth.write(__RESID__ + sep); //3
                bwauth.write(__RESOURCETYPE__ + sep); //4
                bwauth.write(__RESOURCENAME__ + sep); //6
                bwauth.write(__RESOURCEPRODSTATUS__ + sep); //8

                bwauth.write(__RESOURCELANG_1__ + sep); //10
                bwauth.write(__RESOURCELANG_2__ + sep); //12

                bwauth.write(__RESOURCELANG_3__ + sep); //14

                bwauth.write(__RESOURCELANG_4__ + sep); //16

                bwauth.write(__RESOURCELANG_5__ + sep); //18

                bwauth.write(__RESOURCELANG_O__ + sep); //19
                bwauth.write(__RESOURCELANGDIM__ + sep); //22
                bwauth.write("\n");

                /*write norm 0,1,2,3,5,7,9,11,13,15,17,19,21*/
                bwnorm.write(__CONF__ + sep); //0
                bwnorm.write(__YEAR__ + sep);//1
                bwnorm.write(__PASSCODE__ + sep); //2
                bwnorm.write(__RESID__ + sep); //3
                bwnorm.write(__RESOURCETYPE_CLEAN__ + sep); //5
                bwnorm.write(__RESOURCENAME_CLEAN__ + sep); //7
                bwnorm.write(__RESOURCEPRODSTATUS_CLEAN__ + sep); //9

                bwnorm.write(__RESOURCELANG_1_CLEAN__ + sep); //10
                bwnorm.write(__RESOURCELANG_2_CLEAN__ + sep); //12

                bwnorm.write(__RESOURCELANG_3_CLEAN__ + sep); //14

                bwnorm.write(__RESOURCELANG_4_CLEAN__ + sep); //16

                bwnorm.write(__RESOURCELANG_5_CLEAN__ + sep); //18

                bwnorm.write(__RESOURCELANG_O_CLEAN__ + sep); //20
                bwnorm.write(__RESOURCELANGDIM__ + sep); //21
                bwnorm.write("\n");
                if (i == 0) {

                    files.add(fileauthor.getAbsolutePath());
                    files.add(filenorm.getAbsolutePath());
                }
            }
            i++;
            passChk = __PASSCODE__;
        } // end for

        bwauth.close();
        bwnorm.close();
        return files;
    }

    /**
     * the structure of the file is
     * <ul>
     * <li>0 tot
     * <li>1 original value
     * <li>2 value for clean field (<>_norm)
     * <li>3 lp_ap
     * <li>4 value to update orig value <>)
     * </ul>
     *
     *
     * @throws Exception
     */
    public List writeUpdateSqlfiles(String md) throws Exception {
        boolean goahead = true;
        String passChk = "";
        int resid = 1;
        List updates = new ArrayList<>();
        List<String> authupd = new ArrayList<String>();
        List<String> clean = new ArrayList<String>();
        File filenorm = new File(this.inFile + ".norm");
        File fileauthor = new File(this.inFile + ".auth");
        String updateOrig = " ", updateClean = "";

//        fwauth = new FileWriter(fileauthor.getAbsoluteFile());
//        fwnorm = new FileWriter(filenorm.getAbsoluteFile());
//
//        bwauth = new BufferedWriter(fwauth);
//        bwnorm = new BufferedWriter(fwnorm);
        int i = 0, a = 0, c = 0;
        for (List<String> items : table) {
            /*init fields*/
            //System.err.println(items + " " + items);
            __TOT__ = items.get(0);
            __ORIG__ = items.get(1);
            __LP_AP__ = items.get(2);
            __CLEAN__ = items.get(3);
            __AUTHUPD__ = items.get(4);

            /*write file keys
             fields contained in file keys 0,1,2,3,4,6,8,5,7,9
             */
 /*check auth nk values*/
            if (!__CLEAN__.equals("")) {
                //System.err.println("__CLEAN__ " + __CLEAN__);
                updateClean = String.format("SET   %s = '%s' WHERE LOWER(%s)='%s';", md, __CLEAN__.trim(), md, __ORIG__.toLowerCase());
                clean.add(updateClean);
                c++;

            }

            if (!__AUTHUPD__.equals("")) {
                //System.err.println("__AUTHUPD__ " + __AUTHUPD__);
                updateOrig = String.format("SET   %s = '%s' WHERE LOWER(%s)='%s';", md, __AUTHUPD__.trim(), md, __ORIG__.toLowerCase());
                authupd.add(updateOrig);
                a++;
                if (__CLEAN__.equals("")) {
                    System.err.println("__CLEAN__FROM_ORIG " + __ORIG__);
                    updateClean = String.format("SET   %s = '%s' WHERE LOWER(%s)='%s';", md, __AUTHUPD__.trim(), md, __ORIG__.toLowerCase());
                    clean.add(updateClean);
                    c++;

                }

            }

        }
        System.err.println("__CLEAN__ " + c);
        try {
            System.err.println("__AUTHOR__ " + a);
        } catch (Exception e) {
        }
        updates.add(clean);
        updates.add(authupd);
        return updates;

    }

}
