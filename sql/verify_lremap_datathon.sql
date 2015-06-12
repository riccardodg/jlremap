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