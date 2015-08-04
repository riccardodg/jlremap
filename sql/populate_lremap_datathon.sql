SET FOREIGN_KEY_CHECKS=0;

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
from ods_lremap_resource_keys K , NEWSTARTDB.START_authors A where A.passcode=K.passcode
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
from ods_lremap_resource_norm_keys K , NEWSTARTDB.START_authors A where A.passcode=K.passcode
and  A.conf=K.conf  and A.YEAR=K.YEAR and K.resid=1;


--- papers---


REPLACE INTO lremap_papers 
select K.resourceid, A.paperid, A.status, A.title, A.category1
from ods_lremap_resource_keys K , NEWSTARTDB.START_papers A where A.passcode=K.passcode
and  A.conf=K.conf  and A.YEAR=K.YEAR and K.resid=1;

REPLACE INTO lremap_papers_norm 
select K.resourceid, A.paperid, A.status, A.title, A.category1
from ods_lremap_resource_norm_keys K , NEWSTARTDB.START_papers A where A.passcode=K.passcode
and  A.conf=K.conf  and A.YEAR=K.YEAR and K.resid=1;

---subs---
REPLACE INTO lremap_subs
SELECT resourceid, conf, year, passcode FROM lremap_datathon.ods_lremap_resource_keys;

REPLACE INTO lremap_subs_norm
SELECT  resourceid, conf, year, passcode FROM lremap_datathon.ods_lremap_resource_norm_keys;

-- pivot languages --
INSERT INTO lremap_datathon.lremap_resource_pivoted_lang
SELECT resourceid, lang1 FROM lremap_datathon.lremap_resource_lang where lang1 <> ''
UNION
SELECT resourceid, lang2 FROM lremap_datathon.lremap_resource_lang where lang2 <> ''
UNION
SELECT resourceid, lang3 FROM lremap_datathon.lremap_resource_lang where lang3 <> ''
UNION
SELECT resourceid, lang4 FROM lremap_datathon.lremap_resource_lang where lang4 <> ''
UNION
SELECT resourceid, lang5 FROM lremap_datathon.lremap_resource_lang where lang5 <> '';

INSERT INTO lremap_datathon.lremap_resource_pivoted_lang_norm
SELECT resourceid, lang1 FROM lremap_datathon.lremap_resource_lang_norm where lang1 <> ''
UNION
SELECT resourceid, lang2 FROM lremap_datathon.lremap_resource_lang_norm where lang2 <> ''
UNION
SELECT resourceid, lang3 FROM lremap_datathon.lremap_resource_lang_norm where lang3 <> ''
UNION
SELECT resourceid, lang4 FROM lremap_datathon.lremap_resource_lang_norm where lang4 <> ''
UNION
SELECT resourceid, lang5 FROM lremap_datathon.lremap_resource_lang_norm where lang5 <> '';

INSERT INTO lremap_resource_other_lang_norm
SELECT resourceid, langother FROM lremap_datathon.lremap_resource_lang_norm where langother <> '';

INSERT INTO lremap_resource_other_lang
SELECT resourceid, langother FROM lremap_datathon.lremap_resource_lang where langother <> '';

REPLACE INTO lremap_resource_lang_dim
SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
langdim
FROM lremap_datathon.stage_lremap_resource_lang A;

REPLACE INTO lremap_resource_norm_lang_dim
SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
langdim
FROM lremap_datathon.stage_lremap_resource_lang_norm A;


-- additional tables --
REPLACE INTO lremap_conferences SELECT distinct conf, year,type, subeventof, location FROM NEWSTARTDB.START_conferences;

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


-- add default values up to 2014--
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Annotation_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Corpus");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Corpus_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Data");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Methodology-Formalism-Guidelines");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Package");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Standard-Best_Practice");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Grammar-Language_Model");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Image_Analyser");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Language_Identifier");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Language_Modeling_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Language_Resources-Technologies_Infrastructure");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Lexicon");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Machine_Translation_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Metadata");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","NoType");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Ontology");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Prosodic_Analyser");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Representation-Annotation_Formalism-Guidelines");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Representation-Annotation_Standard-Best_Practice");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Named_Entity_Recognizer");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Signal_Processing-Feature_Extraction");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Speaker_recogniser");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Speech_Recognizer-Transcriber");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Spoken_Dialogue_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Text-to-Speech_Synthesizer");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Tagger-Parser");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Terminology");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Tokenizer");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Transcriber");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Word_Sense_Disambiguator");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Not_Applicable");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Not_Relevant");

REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("avail","Freely_Available");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("avail","From_Data_Center(s)");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("avail","From_Owner");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("avail","Not_Available");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("avail","Not_Applicable");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("avail","Not_Relevant");

REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("status","Existing-updated");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("status","Existing-used");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("status","Newly_created-finished");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("status","Newly_created-in_progress");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("status","Not_Applicable");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("status","Not_Relevant");


REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("mod","Modality_Independent");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("mod","Multimodal_Multimedia");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("mod","Sign_Language");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("mod","Speech");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("mod","Speech-Written");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("mod","Written");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("mod","Not_Applicable");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("mod","Not_Relevant");


REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("lan_type","Bi");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("lan_type","Zero");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("lan_type","Mono");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("lan_type","Multi");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("lan_type","Tri");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("lan_type","Not_Applicable");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("lan_type","Not_Relevant");

REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Acquisition");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Dialogue");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Discourse");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Document_Classification-Text_categorisation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Emotion_Recognition-Generation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Information_Extraction-Information_Retrieval");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Knowledge_Discovery-Representation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Language_Identification");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Language_Modelling");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Machine_Translation-SpeechToSpeech_Translation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Multimedia_Document_Processing");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Named_Entity_Recognition");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Natural_Language_Generation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Person_Identification");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Question_Answering");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Semantic_Web");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Sign_Language_Recognition-Generation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Speech_Recognition-Understanding");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Speech_Synthesis");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Summarisation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Text_Mining");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Textual_Entailment");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Topic_Detection_and_Tracking");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Voice_Control");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Web_Services");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Word_Sense_Disambiguation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Not_Applicable");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Not_Relevant");

