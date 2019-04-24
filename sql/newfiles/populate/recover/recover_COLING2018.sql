/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Riccardo Del Gratta &lt;riccardo.delgratta@ilc.cnr.it&gt;
 * Created: Apr 24, 2019
 */

-- 
-- the original database where COLING 2018 date are is COLING_2018_FULL

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
    COLING_2018_FULL.START_authors A
WHERE
    A.passcode = K.passcode;
    
-- authors_norm
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
	COLING_2018_FULL.START_authors A 
WHERE A.passcode=K.passcode;



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
    COLING_2018_FULL.START_papers A
WHERE
    A.passcode = K.passcode;
    
-- papers_norm
REPLACE INTO lremap_papers_norm 
SELECT 
	K.resourceid,
    A.paperid, 
    A.status, 
    A.title, 
    A.category1
FROM 
	ods_lremap_resource_norm_keys K , 
	COLING_2018_FULL.START_papers A 
WHERE A.passcode=K.passcode;

-- ISLRN
REPLACE INTO lremap_resource_ISLRN SELECT
K.resourceid,
K.conf,K.year,K.passcode,K.resid,K.type,K.prodstatus, A.ISLRNStatus, A.ISLRNCode
from ods_lremap_resource_keys K ,  COLING_2018_FULL.START_ISLRN A WHERE  A.passcode = K.passcode AND
	A.resourceid = K.resid ;

-- ISLRN__norm
REPLACE INTO lremap_resource_ISLRN_norm SELECT
K.resourceid,
K.conf,K.year,K.passcode,K.resid,K.type,K.prodstatus,  A.ISLRNStatus, A.ISLRNCode
from ods_lremap_resource_norm_keys K ,  COLING_2018_FULL.START_ISLRN A WHERE  A.passcode = K.passcode AND
	A.resourceid = K.resid  ;