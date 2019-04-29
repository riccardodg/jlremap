-- papers
REPLACE INTO lremap_papers 
SELECT 
    K.resourceid,
    A.paperid, 
    A.status, 
    A.title, 
    A.category1
FROM
    ods_lremap_resource_keys K,
    LREC2018_FULL_DB.START_papers A
WHERE
     A.passcode = K.passcode ;

    
REPLACE INTO lremap_papers_norm 
SELECT 
	K.resourceid,
    A.paperid, 
    A.status, 
    A.title, 
    A.category1
FROM 
	ods_lremap_resource_norm_keys K , 
	LREC2018_FULL_DB.START_papers A 
WHERE A.passcode=K.passcode;

-- authors
REPLACE INTO lremap_authors 
SELECT 
    K.resourceid,
    authornumber,
    username,
    firstname,
    lastname,
    email,
    affiliation,
    country
FROM
    ods_lremap_resource_keys K,
    LREC2018_FULL_DB.START_authors A
WHERE
    A.passcode = K.passcode;
    
REPLACE INTO lremap_authors_norm 
SELECT 
	K.resourceid, 
	authornumber, 
    username, 
    firstname, 
    lastname, 
    email, 
    affiliation, 
    country 
FROM 
	ods_lremap_resource_norm_keys K , 
	LREC2018_FULL_DB.START_authors A 
WHERE A.passcode=K.passcode;

-- ISLRN

REPLACE INTO lremap_resources_ISLRN SELECT
K.resourceid,
-- K.conf,K.year,K.passcode,K.resid,K.type,K.prodstatus, 
A.ISLRNStatus, A.ISLRNCode
from ods_lremap_resource_keys K ,  LREC2018_FULL_DB.START_ISLRN A WHERE  A.passcode = K.passcode AND
	A.resourceid = K.resid ;

REPLACE INTO lremap_resources_ISLRN_norm SELECT
K.resourceid,
-- K.conf,K.year,K.passcode,K.resid,K.type,K.prodstatus,  
A.ISLRNStatus, A.ISLRNCode
from ods_lremap_resource_norm_keys K ,  LREC2018_FULL_DB.START_ISLRN A WHERE  A.passcode = K.passcode AND
	A.resourceid = K.resid  ;