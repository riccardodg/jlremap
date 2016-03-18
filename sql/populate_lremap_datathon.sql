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


-- authors ---
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
and  A.conf=K.conf  and A.YEAR=K.YEAR; -- and K.resid=1;

-- recover 2012 ---

REPLACE INTO lremap_authors  SELECT
K.resourceid,
authornumber,
username,
firstname,
lastname,
email,
affiliation,
country
from ods_lremap_resource_keys K , START_DB_2012.START_authors A where substr(A.passcode, 1,instr(A.passcode,"X")-1)=K.passcode
and  K.conf='LREC2012'  and K.YEAR='2012'; -- and K.resid=1;

-- recover 2010 ---
REPLACE INTO lremap_authors SELECT
K.resourceid,
authornumber,
username,
firstname,
lastname,
email,
affiliation,
country
from ods_lremap_resource_keys K , START_DB_2010.START_authors A where A.passcode=K.passcode
and  K.conf='LREC2010'  and K.YEAR='2010'; -- and K.resid=1;

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
and  A.conf=K.conf  and A.YEAR=K.YEAR; -- and K.resid=1;

-- recover 2012 ---

REPLACE INTO lremap_authors_norm  SELECT
K.resourceid,
authornumber,
username,
firstname,
lastname,
email,
affiliation,
country
from ods_lremap_resource_norm_keys K , START_DB_2012.START_authors A where substr(A.passcode, 1,instr(A.passcode,"X")-1)=K.passcode
and  K.conf='LREC2012'  and K.YEAR='2012' ;-- and K.resid=1;

-- recover 2010 ---
REPLACE INTO lremap_authors_norm SELECT
K.resourceid,
authornumber,
username,
firstname,
lastname,
email,
affiliation,
country
from ods_lremap_resource_norm_keys K , START_DB_2010.START_authors A where A.passcode=K.passcode
and  K.conf='LREC2010'  and K.YEAR='2010';-- and K.resid=1;

--- papers---
REPLACE INTO lremap_papers_norm 
select K.resourceid, A.paperid, A.status, A.title, A.category1
from ods_lremap_resource_norm_keys K , NEWSTARTDB.START_papers A where A.passcode=K.passcode
and  A.conf=K.conf  and A.YEAR=K.YEAR; -- and K.resid=1;

REPLACE INTO lremap_papers 
select K.resourceid, A.paperid, A.status, A.title, A.category1
from ods_lremap_resource_keys K , NEWSTARTDB.START_papers A where A.passcode=K.passcode
and  A.conf=K.conf  and A.YEAR=K.YEAR; -- and K.resid=1;

-- recover 2012 ---
REPLACE INTO lremap_papers  
select K.resourceid, A.paperid, A.status, A.title, A.category1
from ods_lremap_resource_keys K , START_DB_2012.START_papers A where substr(A.passcode, 1,instr(A.passcode,"X")-1)=K.passcode
and  K.conf='LREC2012'  and K.YEAR='2012'; -- and K.resid=1;

-- recover 2010 ---
REPLACE INTO lremap_papers  
select K.resourceid, A.paperid, A.status, A.title, A.category1
from ods_lremap_resource_keys K , START_DB_2010.START_papers A where A.passcode=K.passcode
and  K.conf='LREC2010'  and K.YEAR='2010'; -- and K.resid=1;



-- recover 2012 ---
REPLACE INTO lremap_papers_norm  
select K.resourceid, A.paperid, A.status, A.title, A.category1
from ods_lremap_resource_norm_keys K , START_DB_2012.START_papers A where substr(A.passcode, 1,instr(A.passcode,"X")-1)=K.passcode
and  K.conf='LREC2012'  and K.YEAR='2012'; -- and K.resid=1;

-- recover 2010 ---
REPLACE INTO lremap_papers_norm  
select K.resourceid, A.paperid, A.status, A.title, A.category1
from ods_lremap_resource_norm_keys K , START_DB_2010.START_papers A where A.passcode=K.passcode
and  K.conf='LREC2010'  and K.YEAR='2010'; -- and K.resid=1;

--- subs---
REPLACE INTO lremap_subs
SELECT resourceid, conf, year, passcode FROM lremap_datathon.ods_lremap_resource_keys;

REPLACE INTO lremap_subs_norm
SELECT  resourceid, conf, year, passcode FROM lremap_datathon.ods_lremap_resource_norm_keys;

-- pivot languages --
REPLACE INTO lremap_datathon.lremap_resource_pivoted_lang
SELECT resourceid, lang1 FROM lremap_datathon.lremap_resource_lang where lang1 <> ''
UNION
SELECT resourceid, lang2 FROM lremap_datathon.lremap_resource_lang where lang2 <> ''
UNION
SELECT resourceid, lang3 FROM lremap_datathon.lremap_resource_lang where lang3 <> ''
UNION
SELECT resourceid, lang4 FROM lremap_datathon.lremap_resource_lang where lang4 <> ''
UNION
SELECT resourceid, lang5 FROM lremap_datathon.lremap_resource_lang where lang5 <> '';

REPLACE INTO lremap_datathon.lremap_resource_pivoted_lang_norm
SELECT resourceid, lang1 FROM lremap_datathon.lremap_resource_lang_norm where lang1 <> ''
UNION
SELECT resourceid, lang2 FROM lremap_datathon.lremap_resource_lang_norm where lang2 <> ''
UNION
SELECT resourceid, lang3 FROM lremap_datathon.lremap_resource_lang_norm where lang3 <> ''
UNION
SELECT resourceid, lang4 FROM lremap_datathon.lremap_resource_lang_norm where lang4 <> ''
UNION
SELECT resourceid, lang5 FROM lremap_datathon.lremap_resource_lang_norm where lang5 <> '';

REPLACE INTO lremap_resource_other_lang_norm
SELECT resourceid, langother FROM lremap_datathon.lremap_resource_lang_norm where langother <> '';

REPLACE INTO lremap_resource_other_lang
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

REPLACE INTO lremap_conference_years (conf,year) select distinct conf,year from lremap_resource order by 2 desc, 1 asc;

--- add old conferences to the list --
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
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('COLING', '2012','MAIN', '', 'Bombay');

-- 2013 --
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('IS', '2013','MAIN', '', 'Lyon');
REPLACE INTO lremap_conferences (conf, year,type, subeventof, location) VALUES ('NAACL', '2013','MAIN', '', 'Atlanta');


-- add default values up to 2014--
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Annotation_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Corpus");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Corpus_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Data");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Methodology-Formalism-Guidelines");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Methodology-Standards-Guidelines");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Package");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Standard-Best_Practice");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Evaluation_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Grammar-Language_Model");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Image_Analyzer");
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
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Representation-Annotation_Standards-Best_Practices");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Named_Entity_Recognizer");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Signal_Processing-Features_Extraction");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Speaker_Recognizer");
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

-- for 2016 --
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Treebank");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Aligner");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Machine_Learning_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Sentiment_Analysis_Tool");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Software_Toolkit");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Web_Service");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("type","Prosodic_Analyzer");


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
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("mod","Multimodal-Multimedia");
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
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Document_Classification,_Text_categorisation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Emotion_Recognition-Generation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Information_Extraction,_Information_Retrieval");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Knowledge_Discovery-Representation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Language_Identification");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Language_Modelling");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Machine_Translation,_SpeechToSpeech_Translation");
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
-- REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Textual_Entailment");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Topic_Detection_and_Tracking");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Voice_Control");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Web_Services");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Word_Sense_Disambiguation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Not_Applicable");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Not_Relevant");

-- for lrec 2016 --
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Anaphora,_Coreference");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Corpus_Creation-Annotation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Evaluation-Validation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Lexicon_Creation-Annotation");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Machine_Learning");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Morphological_Analysis");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Opinion_Mining-Sentiment_Analysis");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Parsing_and_Tagging");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Semantic_Role_Labeling");
REPLACE INTO  lremap_side_table_resmetadata(attribute, value) VALUES ("use","Textual_Entailment_and_Paraphrasing");

-- load iso 639-3

-- for GUI --
CREATE TABLE `lremap_side_table_groupedtype` (
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `grouping` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`value`,`grouping`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Corpus","Resource-Dataset");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Lexicon","Resource-Dataset");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Grammar/Language Model","Resource-Dataset");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Ontology","Resource-Dataset");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Terminology","Resource-Dataset");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Treebank","Resource-Dataset");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Corpus Tool","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Aligner","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Annotation Tool","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Language Identifier","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Language Modeling Tool","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Machine Learning Tool","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Machine Translation Tool","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Named Entity Recognizer","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Sentiment Analysis Tool","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Software Toolkit","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Tagger/Parser","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Tokenizer","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Web Service","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Word Sense Disambiguator","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Prosodic Analyzer","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Signal Processing/Features Extraction","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Speaker Recognizer","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Speech Recognizer/Transcriber","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Spoken Dialogue Tool","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Text-to-Speech Synthesizer","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Image Analyzer","Resource-Tool");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Metadata","Resource-Guidelines");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Representation-Annotation Formalism/Guidelines","Resource-Guidelines");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Representation-Annotation Standards/Best Practices","Resource-Guidelines");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Language Resources/Technologies Infrastructure","Resource-Guidelines");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Evaluation Data","Evaluation");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Evaluation Tool","Evaluation");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Evaluation Package","Evaluation");
REPLACE INTO lremap_side_table_groupedtype (value,grouping) VALUES ("Evaluation Methodology/Standards/Guidelines","Evaluation");

REPLACE  INTO lremap_side_table_groupedtype SELECT DISTINCT B.type, 'Other' FROM lremap_side_table_groupedtype A RIGHT OUTER JOIN  lremap_resource_norm B ON ( A.value=B.type) where A.value is null;


CREATE TABLE `lremap_side_table_avail` (
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `grouping` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`value`,`grouping`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

REPLACE INTO lremap_side_table_avail (value,grouping) VALUES ("Freely Available","Lrec");
REPLACE INTO lremap_side_table_avail (value,grouping) VALUES ("From Data Center(s)","Lrec");
REPLACE INTO lremap_side_table_avail (value,grouping) VALUES ("From Owner","Lrec");
REPLACE INTO lremap_side_table_avail (value,grouping) VALUES ("Not Applicable","Lrec");
REPLACE INTO lremap_side_table_avail (value,grouping) VALUES ("Not Available","Lrec");
REPLACE INTO lremap_side_table_avail (value,grouping) VALUES ("Not Relevant","Lrec");

REPLACE INTO lremap_side_table_avail SELECT DISTINCT B.avail, 'Other' FROM lremap_datathon.lremap_side_table_avail A RIGHT OUTER JOIN  lremap_resource_norm B ON ( A.value=B.avail) where A.value is null order by 1

DROP TABLE IF EXISTS `lremap_side_table_status`;
CREATE TABLE `lremap_side_table_status` (
  `value` varchar(370) COLLATE utf8_bin NOT NULL DEFAULT '',
  `grouping` char(15) COLLATE utf8_bin NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

REPLACE INTO lremap_side_table_status (value,grouping) VALUES ("Newly created-finished","Lrec");
REPLACE INTO lremap_side_table_status (value,grouping) VALUES ("Newly created-in progress","Lrec");
REPLACE INTO lremap_side_table_status (value,grouping) VALUES ("Existing-used","Lrec");
REPLACE INTO lremap_side_table_status (value,grouping) VALUES ("Existing-updated","Lrec");
REPLACE INTO lremap_side_table_status (value,grouping) VALUES ("Not Applicable","Lrec");


REPLACE INTO lremap_side_table_status SELECT DISTINCT B.prodstatus, 'Other' FROM lremap_datathon.lremap_side_table_status A RIGHT OUTER JOIN  lremap_resource_norm B ON ( A.value=B.prodstatus) where A.value is null order by 1

DROP TABLE IF EXISTS `lremap_side_table_modality`;
CREATE TABLE `lremap_side_table_modality` (
  `value` varchar(300) COLLATE utf8_bin NOT NULL DEFAULT '',
  `grouping` char(15) COLLATE utf8_bin NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

REPLACE INTO lremap_side_table_modality (value,grouping) VALUES ("Speech","Lrec");
REPLACE INTO lremap_side_table_modality (value,grouping) VALUES ("Written","Lrec");
REPLACE INTO lremap_side_table_modality (value,grouping) VALUES ("Speech/Written","Lrec");
REPLACE INTO lremap_side_table_modality (value,grouping) VALUES ("Multimodal/Multimedia","Lrec");
REPLACE INTO lremap_side_table_modality (value,grouping) VALUES ("Sign Language","Lrec");
REPLACE INTO lremap_side_table_modality (value,grouping) VALUES ("Modality Independent","Lrec");
REPLACE INTO lremap_side_table_modality (value,grouping) VALUES ("Not Applicable","Lrec");


REPLACE INTO lremap_side_table_modality SELECT DISTINCT B.modality, 'Other' FROM lremap_datathon.lremap_side_table_modality A RIGHT OUTER JOIN  lremap_resource_norm B ON ( A.value=B.modality) where A.value is null order by 1

DROP TABLE IF EXISTS `lremap_side_table_use`;
CREATE TABLE `lremap_side_table_use` (
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `grouping` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`value`,`grouping`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Acquisition","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Anaphora, Coreference","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Corpus Creation/Annotation","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Dialogue","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Discourse","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Document Classification, Text categorisation","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Emotion Recognition/Generation","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Evaluation/Validation","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Information Extraction, Information Retrieval","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Knowledge Discovery/Representation","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Language Identification","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Language Modelling","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Lexicon Creation/Annotation","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Machine Learning","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Machine Translation, SpeechToSpeech Translation","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Morphological Analysis","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Multimedia Document Processing","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Named Entity Recognition","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Natural Language Generation","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Opinion Mining/Sentiment Analysis","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Parsing and Tagging","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Person Identification","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Question Answering","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Semantic Role Labeling","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Semantic Web","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Sign Language Recognition/Generation","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Speech Recognition/Understanding","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Speech Synthesis","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Summarisation","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Text Mining","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Textual Entailment and Paraphrasing","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Topic Detection and Tracking","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Voice Control","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Web Services","Lrec");
REPLACE INTO lremap_side_table_use (value,grouping) VALUES ("Word Sense Disambiguation","Lrec");




REPLACE INTO lremap_side_table_use SELECT DISTINCT B.resourceusage, 'Other' FROM lremap_datathon.lremap_side_table_use A RIGHT OUTER JOIN  lremap_resource_norm B ON ( A.value=B.resourceusage) where A.value is null order by 1


-- END GUI --