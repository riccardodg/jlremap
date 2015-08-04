-- langs --
SELECT
    T.ID,
    C.NAME,
    C.YEAR,
    TL.passcode,
    '',
    TL.ResourceType,
    '' asResourceType_clean,
    TL.resourceName,
    '' AS resourceName_clean,
    T.ResourceProdStatus,
    '' AS ResourceProdStatus_clean,
    TL.resourceLang,
    LT.lang_type
FROM
    RESOURCEMAP_TL TL,
    RESOURCEMAP_T T,
    RESOURCEMAP_LANGTYPE LT,
    CONFERENCES C
WHERE
    C.ID = TL.C_ID AND T.ID=TL.ID and TL.ID=LT.ID
ORDER BY 1 , 2 , 3,4,5 ASC;

DROP TABLE IF EXISTS `stage_lremap_resource_temp`;
CREATE TABLE `stage_lremap_resource_temp` (
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resourceid` varchar(11) NOT NULL DEFAULT '',
  `type` text COLLATE utf8_bin,
  `type_clean` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `name_clean` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  `prodstatus_clean` text COLLATE utf8_bin,
  `lang1` text COLLATE utf8_bin,
  `lang1_clean` text COLLATE utf8_bin,
  `lang2` text COLLATE utf8_bin,
  `lang2_clean` text COLLATE utf8_bin,
  `lang3` text COLLATE utf8_bin,
  `lang3_clean` text COLLATE utf8_bin,
  `lang4` text COLLATE utf8_bin,
  `lang4_clean` text COLLATE utf8_bin,
  `lang5` text COLLATE utf8_bin,
  `lang5_clean` text COLLATE utf8_bin,
  `langother` text COLLATE utf8_bin,
`langother_clean` text COLLATE utf8_bin,
  `langdim` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

LOAD DATA LOCAL INFILE  '/home/riccardo/Dropbox/LREMap/310715/MAPDBJPA_LANG.csv' INTO TABLE stage_lremap_resource_temp CHARACTER SET utf8 FIELDS  terminated by '\t' OPTIONALLY ENCLOSED BY '"';
SELECT * FROM lremap_datathon.stage_lremap_resource_temp order by 1 asc, 2 asc, 3 asc;

