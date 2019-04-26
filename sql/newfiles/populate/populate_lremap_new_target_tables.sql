/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Riccardo Del Gratta &lt;riccardo.delgratta@ilc.cnr.it&gt;
 * Created: Apr 26, 2019
 */

-- subs---
REPLACE INTO lremap_subs
SELECT resourceid, conf, year, passcode FROM ods_lremap_resource_keys;

REPLACE INTO lremap_subs_norm
SELECT  resourceid, conf, year, passcode FROM ods_lremap_resource_norm_keys;

-- keys ---
REPLACE INTO lremap_resource_keys SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',norm_type,'#',norm_name,'#',norm_prodstatus)) as resource_normid
 FROM stage_lremap_resource_keys A;



-- resource auth ---
REPLACE INTO lremap_resources  
SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
A.* from stage_lremap_resource A; 

-- resource norm ---
REPLACE INTO lremap_resources_norm 
SELECT  
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
A.* from stage_lremap_resource_norm A;

-- resource langs ---
REPLACE INTO lremap_resource_langs SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
A.lang1,A.lang2,A.lang3,A.lang4,A.lang5,A.langother from stage_lremap_resource_lang A; 

REPLACE INTO lremap_resource_langs_norm SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
A.lang1,A.lang2,A.lang3,A.lang4,A.lang5,A.langother from stage_lremap_resource_lang_norm A;

-- pivot languages --
INSERT INTO lremap_resource_pivoted_langs (resourceid, language)
SELECT resourceid, lang1 FROM lremap_resource_langs where lang1 is not  null
UNION ALL
SELECT resourceid, lang2 FROM lremap_resource_langs where lang2 is not  null
UNION ALL
SELECT resourceid, lang3 FROM lremap_resource_langs where lang3 is not  null
UNION ALL
SELECT resourceid, lang4 FROM lremap_resource_langs where lang4 is not  null
UNION ALL
SELECT resourceid, lang5 FROM lremap_resource_langs where lang5 is not  null
order by 1, 2 asc;

INSERT INTO lremap_resource_pivoted_langs_norm (resourceid, language)
SELECT resourceid, lang1 FROM lremap_resource_langs_norm where lang1 is not  null
UNION ALL
SELECT resourceid, lang2 FROM lremap_resource_langs_norm where lang2 is not  null
UNION ALL
SELECT resourceid, lang3 FROM lremap_resource_langs_norm where lang3 is not  null
UNION ALL
SELECT resourceid, lang4 FROM lremap_resource_langs_norm where lang4 is not  null
UNION ALL
SELECT resourceid, lang5 FROM lremap_resource_langs_norm where lang5 is not  null
order by 1, 2 asc;

-- other langs 
REPLACE INTO lremap_resource_other_langs
SELECT resourceid, langother FROM lremap_resource_langs where langother is not null;

REPLACE INTO lremap_resource_other_langs_norm
SELECT resourceid, langother FROM lremap_resource_langs_norm where langother is not null;

-- lang dim
REPLACE INTO lremap_resource_langs_dim
SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
langdim
FROM stage_lremap_resource_lang A;

REPLACE INTO lremap_resource_langs_dim_norm
SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
langdim
FROM stage_lremap_resource_lang_norm A;
