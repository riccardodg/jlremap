--- ODS auth --
REPLACE INTO ods_lremap_resource_keys SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
CONF,YEAR,PASSCODE,resourceid,type,name,prodstatus
FROM lremap_datathon.stage_lremap_resource_keys A;

--- ODS norm ---
REPLACE INTO ods_lremap_resource_norm_keys SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',norm_type,'#',norm_name,'#',norm_prodstatus)) as resourceid,
CONF,YEAR,PASSCODE,resourceid,norm_type,norm_name,norm_prodstatus
FROM lremap_datathon.stage_lremap_resource_keys A;

--- keys ---
REPLACE INTO lremap_resource_keys SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',norm_type,'#',norm_name,'#',norm_prodstatus)) as resource_normid
 FROM lremap_datathon.stage_lremap_resource_keys A;

--- resource auth ---
REPLACE INTO lremap_resource  
SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
A.* from stage_lremap_resource A; 

--- resource norm ---
REPLACE INTO lremap_resource_norm 
SELECT  
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
A.* from stage_lremap_resource_norm A;

--- resource langs ---
REPLACE INTO lremap_resource_lang SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
A.lang1,A.lang2,A.lang3,A.lang4,A.lang5,A.langother from stage_lremap_resource_lang A; 

REPLACE INTO lremap_resource_lang_norm SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
A.lang1,A.lang2,A.lang3,A.lang4,A.lang5,A.langother from stage_lremap_resource_lang_norm A;

--- authors ---
REPLACE INTO lremap_authors SELECT
K.resourceid,
authornumber,
username,
firstname,
lastname,
email,
affiliation,
country
from ods_lremap_resource_keys K , START_DB.START_authors A where A.passcode=K.passcode
and  A.conf=K.conf  and A.YEAR=K.YEAR and K.resid=1;

REPLACE INTO lremap_authors_norm SELECT
K.resourceid,
authornumber,
username,
firstname,
lastname,
email,
affiliation,
country
from ods_lremap_resource_norm_keys K , START_DB.START_authors A where A.passcode=K.passcode
and  A.conf=K.conf  and A.YEAR=K.YEAR and K.resid=1;


--- papers---


REPLACE INTO lremap_papers 
select K.resourceid, A.paperid, A.status, A.title, A.category1
from ods_lremap_resource_keys K , START_DB.START_papers A where A.passcode=K.passcode
and  A.conf=K.conf  and A.YEAR=K.YEAR and K.resid=1;

REPLACE INTO lremap_papers_norm 
select K.resourceid, A.paperid, A.status, A.title, A.category1
from ods_lremap_resource_norm_keys K , START_DB.START_papers A where A.passcode=K.passcode
and  A.conf=K.conf  and A.YEAR=K.YEAR and K.resid=1;

---subs---
REPLACE INTO lremap_subs
SELECT resourceid, conf, year, passcode FROM lremap_datathon.ods_lremap_resource_keys;

REPLACE INTO lremap_subs_norm
SELECT  resourceid, conf, year, passcode FROM lremap_datathon.ods_lremap_resource_norm_keys;

-- additional tables --
REPLACE INTO lremap_conferences SELECT distinct conf, year,type, subeventof, location FROM START_DB.START_conferences;

REPLACE INTO lremap_years select distinct year from lremap_resource order by 1;

REPLACE INTO lremap_conference_years select distinct conf,year from lremap_resource order by 1;

--add old conferences to the list --
-- 2010 --
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('LREC2010', '2010','MAIN', '', 'La_Valletta');
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('COLING2010', '2010','MAIN', '', 'Beijing');

-- 2011 --
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('O-COCOSDA2011', '2011','MAIN', '', 'Hsinchu');
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('ACLHT2011', '2011','MAIN', '', 'Portland');
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('IJCNLP2011', '2011','MAIN', '', 'Chiang_Mai');
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('IS2011', '2011','MAIN', '', 'Florence');
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('LTC2011', '2011','MAIN', '', 'Poznan');
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('RANLP2011', '2011','MAIN', '', 'Hissar');

-- 2012 --
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('LREC2012', '2012','MAIN', '', 'Istambul');

-- 2013 --
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('IS', '2013','MAIN', '', 'Lyon');
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('NAACL', '2013','MAIN', '', 'Atlanta');

