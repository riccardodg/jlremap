/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Riccardo Del Gratta &lt;riccardo.delgratta@ilc.cnr.it&gt;
 * Created: Apr 29, 2019
 */
-- check lang vs resource
SELECT 
    l.CONF,
    l.YEAR,
    l.PASSCODE,
    l.resourceid,
    l.type,
    l.name,
    MD5(CONCAT(l.CONF,
                    '#',
                    l.YEAR,
                    '#',
                    l.PASSCODE,
                    '#',
                    l.resourceid,
                    '#',
                    l.type,
                    '#',
                    l.name,
                    '#',
                    l.prodstatus)) AS l_resourceid,
    '-',
    r.CONF,
    r.YEAR,
    r.PASSCODE,
    r.resourceid,
    r.type,
    r.name,
    MD5(CONCAT(r.CONF,
                    '#',
                    r.YEAR,
                    '#',
                    r.PASSCODE,
                    '#',
                    r.resourceid,
                    '#',
                    r.type,
                    '#',
                    r.name,
                    '#',
                    r.prodstatus)) AS r_resourceid
FROM
    stage_lremap_resource_lang l,
    stage_lremap_resource r
WHERE
    r.passcode = l.passcode
        AND r.resourceid = l.resourceid
        AND MD5(CONCAT(l.CONF,
                    '#',
                    l.YEAR,
                    '#',
                    l.PASSCODE,
                    '#',
                    l.resourceid,
                    '#',
                    l.type,
                    '#',
                    l.name,
                    '#',
                    l.prodstatus)) <> MD5(CONCAT(r.CONF,
                    '#',
                    r.YEAR,
                    '#',
                    r.PASSCODE,
                    '#',
                    r.resourceid,
                    '#',
                    r.type,
                    '#',
                    r.name,
                    '#',
                    r.prodstatus));



-- check lang vs resource norm

SELECT 
    l.CONF,
    l.YEAR,
    l.PASSCODE,
    l.resourceid,
    l.type,
    l.name,
    MD5(CONCAT(l.CONF,
                    '#',
                    l.YEAR,
                    '#',
                    l.PASSCODE,
                    '#',
                    l.resourceid,
                    '#',
                    l.type,
                    '#',
                    l.name,
                    '#',
                    l.prodstatus)) AS l_resourceid,
    '-',
    r.CONF,
    r.YEAR,
    r.PASSCODE,
    r.resourceid,
    r.type,
    r.name,
    MD5(CONCAT(r.CONF,
                    '#',
                    r.YEAR,
                    '#',
                    r.PASSCODE,
                    '#',
                    r.resourceid,
                    '#',
                    r.type,
                    '#',
                    r.name,
                    '#',
                    r.prodstatus)) AS r_resourceid
FROM
    stage_lremap_resource_lang l,
    stage_lremap_resource r
WHERE
    r.passcode = l.passcode
        AND r.resourceid = l.resourceid
        AND MD5(CONCAT(l.CONF,
                    '#',
                    l.YEAR,
                    '#',
                    l.PASSCODE,
                    '#',
                    l.resourceid,
                    '#',
                    l.type,
                    '#',
                    l.name,
                    '#',
                    l.prodstatus)) <> MD5(CONCAT(r.CONF,
                    '#',
                    r.YEAR,
                    '#',
                    r.PASSCODE,
                    '#',
                    r.resourceid,
                    '#',
                    r.type,
                    '#',
                    r.name,
                    '#',
                    r.prodstatus));

SELECT A.CONF, A.PASSCODE, A.resourceid, R.conf,
    MD5(CONCAT(A.CONF,
                    '#',
                    A.YEAR,
                    '#',
                    A.PASSCODE,
                    '#',
                    A.resourceid,
                    '#',
                    A.type,
                    '#',
                    A.name,
                    '#',
                    A.prodstatus)) AS resourceid,
    A.lang1,
    A.lang2,
    A.lang3,
    A.lang4,
    A.lang5,
    A.langother
FROM
    stage_lremap_resource_lang_norm A LEFT OUTER JOIN 
    lremap_resources_norm R
ON
    R.resourceid = MD5(CONCAT(A.CONF,
                    '#',
                    A.YEAR,
                    '#',
                    A.PASSCODE,
                    '#',
                    A.resourceid,
                    '#',
                    A.type,
                    '#',
                    A.name,
                    '#',
                    A.prodstatus))
                    WHERE A.YEAR='2011' and R.conf is null
