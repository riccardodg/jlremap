-- ODS auth --
REPLACE INTO ods_lremap_resource_keys SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',type,'#',name,'#',prodstatus)) as resourceid,
CONF,YEAR,PASSCODE,resourceid,type,name,prodstatus
FROM stage_lremap_resource_keys A;

-- ODS norm ---
REPLACE INTO ods_lremap_resource_norm_keys SELECT 
MD5(concat(CONF,'#',YEAR,'#',PASSCODE,'#',resourceid,'#',norm_type,'#',norm_name,'#',norm_prodstatus)) as resourceid,
CONF,YEAR,PASSCODE,resourceid,norm_type,norm_name,norm_prodstatus
FROM stage_lremap_resource_keys A;

