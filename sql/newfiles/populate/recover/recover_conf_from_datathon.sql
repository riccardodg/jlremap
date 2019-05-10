-- conf	year	passcode	resid	ResourceType	ResourceType_clean	resourceName	resourceName_clean	ResourceProdStatus	ResourceProdStatus_clean	ResourceModality	ResourceModality_clean	ResourceUse	ResourceUse_clean	ResourceAvail	ResourceAvail_clean	ResourceUrl	ResourceSize	ResourceSize_1	ResourceLicense	ResourceDoc
-- # resourceid, CONF, YEAR, passcode, resid, type, name, prodstatus, modality, resourceusage, avail, url, size, unit, license, doc

SELECT 
    r.conf,
    r.year,
    r.passcode,
    r.resid,
    r.type,
    rn.type,
    r.name,
    rn.name,
    r.prodstatus,
    rn.prodstatus,
    r.modality,
    rn.modality,
    r.resourceusage,
    rn.resourceusage,
    r.avail,
    rn.avail,
    r.url,
    r.size,
    '',
    r.unit,
    r.license,
    r.doc
FROM
    lremap_datathon.lremap_resource r,
    lremap_datathon.lremap_resource_norm rn,
    lremap_datathon.lremap_resource_keys k
WHERE
    r.resourceid = k.resourceid
        AND k.resource_normid = rn.resourceid
        AND r.conf = 'ACLHT2011';
        
SELECT 
    r.conf,
    r.year,
    r.passcode,
    r.resid,
    r.type,
    rn.type,
    r.name,
    rn.name,
    r.prodstatus,
    rn.prodstatus,
    l.lang1,
    ln.lang1,
    l.lang2,
    ln.lang2,
    l.lang3,
    ln.lang3,
    l.lang4,
    ln.lang4,
    l.lang5,
    ln.lang5,
    l.langother,
    ln.langother,
    ''
FROM
    lremap_datathon.lremap_resource r left outer join
    lremap_datathon.lremap_resource_lang l on (r.resourceid=l.resourceid), 
    lremap_datathon.lremap_resource_norm rn left outer join 
    lremap_datathon.lremap_resource_lang_norm ln on (rn.resourceid=ln.resourceid),
    lremap_datathon.lremap_resource_keys k
WHERE
    r.resourceid = k.resourceid
        AND k.resource_normid = rn.resourceid
       
        AND r.conf = 'ACLHT2011'