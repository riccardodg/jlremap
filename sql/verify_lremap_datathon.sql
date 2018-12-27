-- recreate original files--
SELECT 
    A.conf, A.year, A.passcode, A.resourceId,
    A.type, N.type as type_clean,
    A.name, N.name as name_clean,
    A.prodstatus, N.prodstatus as prodstatus_clean,
    A.modality, N.modality as modality_clean,
    A.resourceusage, N.resourceusage as resourceusage_clean,
    A.avail, N.avail as avail_clean,
    A.url,
    A.size, A.unit, A.license, A.doc
    
FROM
    lremap_datathon.stage_lremap_resource A,
    lremap_datathon.stage_lremap_resource_norm N
WHERE
    A.conf = N.conf AND A.year = N.year
        AND A.passcode = N.passcode
        AND A.resourceId = N.resourceId
order by 1,2,3,4        ;

-- langs --
SELECT 
    A.conf, A.year, A.passcode, A.resourceId,
    A.type, N.type as type_clean,
    A.name, N.name as name_clean,
    A.prodstatus, N.prodstatus as prodstatus_clean,
    A.lang1, N.lang1 as lang1_clean,
    A.lang2, N.lang2 as lang2_clean,
    A.lang3, N.lang3 as lang3_clean,
    A.lang4, N.lang4 as lang4_clean,
    A.lang5, N.lang5 as lang5_clean,
    A.langother, N.langother as langother_clean,
    A.langdim
    
FROM
    lremap_datathon.stage_lremap_resource_lang A,
    lremap_datathon.stage_lremap_resource_lang_norm N
WHERE
    A.conf = N.conf AND A.year = N.year
        AND A.passcode = N.passcode
        AND A.resourceId = N.resourceId
order by 1,2,3,4;
--- verify stage keys ---
SELECT count(*), conf,year FROM lremap_datathon.ods_lremap_resource_keys group by conf,year order by 1 desc;

SELECT 
 CONF,
YEAR,
passcode,
resourceid,
type,
'' as type_clean,
name,
'' as name_clean,
prodstatus,
'' as prodstatus_clean,
modality,
'' as modality_clean,
resourceusage,
'' as resourceuse_clean,
avail,
'' as avail_clean,
url,
size,
unit,  
license,
doc
FROM START_DB.START_resource;

SELECT 
 CONF,
YEAR,
passcode,
resourceid,
type,
'' as type_clean,
name,
'' as name_clean,
prodstatus,
'' as prodstatus_clean,
lang1,
'' as lang1_clean,
lang2,
'' as lang2_clean,
lang3,
'' as lang3_clean,
lang4,
'' as lang4_clean,
lang5,
'' as lang5_clean,
langother,
'' as langother_clean,
langdimension



FROM START_DB.START_resource

--- MAPDBJPA ---

SELECT  distinct
C.NAME AS CONF,
C.YEAR AS YEAR,
passcode,
'' as resid,
ResourceType,
'' as type_clean,
resourceName,
'' as name_clean,
ResourceProdStatus,
'' as status_clean,
ResourceModality,
'' as modality_clean,
ResourceUse,
'' as resuse_clean,
ResourceAvail,
''as avail_clean,
ResourceUrl,
ResourceSize,
ResourceSize_1,
ResourceLicense,
ResourceDoc
FROM RESOURCEMAP_T R, CONFERENCES C where R.C_ID=C.ID order by CONF, YEAR,passcode, resid;