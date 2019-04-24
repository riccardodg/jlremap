--
-- set path where tour file are
-- set name the name of your file (depend on conference)
--

-- metadata
LOAD DATA LOCAL INFILE  'PATH/NAME_MD.csv.keys' INTO TABLE stage_lremap_resource_keys CHARACTER SET utf8 FIELDS  terminated by '\t' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE  'PATH/NAME_MD.csv.auth' INTO TABLE stage_lremap_resource CHARACTER SET utf8 FIELDS  terminated by '\t' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE  'PATH/NAME_MD.csv.norm' INTO TABLE stage_lremap_resource_norm CHARACTER SET utf8 FIELDS  terminated by '\t' OPTIONALLY ENCLOSED BY '"';


-- languages

