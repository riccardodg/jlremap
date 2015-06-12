--- lremap_datathon scripts ---
DROP table `stage_lremap_resource_keys`;
CREATE TABLE `stage_lremap_resource_keys` (
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resourceid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  `norm_type` text COLLATE utf8_bin,
  `norm_name` text COLLATE utf8_bin,
  `norm_prodstatus` text COLLATE utf8_bin,
  PRIMARY KEY (`passcode`,`resourceid`,`CONF`,`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE `stage_lremap_resource`;
CREATE TABLE `stage_lremap_resource` (
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resourceid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  `modality` text COLLATE utf8_bin,
  `resourceusage` text COLLATE utf8_bin,
  `avail` text COLLATE utf8_bin,
  `url` text COLLATE utf8_bin,
   `size` text COLLATE utf8_bin,
  `unit` text COLLATE utf8_bin,  
`license` text COLLATE utf8_bin,
  `doc` text COLLATE utf8_bin,
  PRIMARY KEY (`passcode`,`resourceid`,`CONF`,`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE `stage_lremap_resource_norm`;
CREATE TABLE `stage_lremap_resource_norm` (
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resourceid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  `modality` text COLLATE utf8_bin,
  `resourceusage` text COLLATE utf8_bin,
  `avail` text COLLATE utf8_bin,
  `url` text COLLATE utf8_bin,
  `size` text COLLATE utf8_bin,
  `unit` text COLLATE utf8_bin,
  `license` text COLLATE utf8_bin,
  `doc` text COLLATE utf8_bin,
  PRIMARY KEY (`passcode`,`resourceid`,`CONF`,`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--- LANGS ---
DROP TABLE `stage_lremap_resource_lang`;
CREATE TABLE `stage_lremap_resource_lang` (
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resourceid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  `lang1` text COLLATE utf8_bin,
  `lang2` text COLLATE utf8_bin,
  `lang3` text COLLATE utf8_bin,
  `lang4` text COLLATE utf8_bin,
  `lang5` text COLLATE utf8_bin,
  `langother` text COLLATE utf8_bin,
  `langdim` text COLLATE utf8_bin,
  PRIMARY KEY (`passcode`,`resourceid`,`CONF`,`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE `stage_lremap_resource_lang_norm`;
CREATE TABLE `stage_lremap_resource_lang_norm` (
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resourceid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  `lang1` text COLLATE utf8_bin,
  `lang2` text COLLATE utf8_bin,
  `lang3` text COLLATE utf8_bin,
  `lang4` text COLLATE utf8_bin,
  `lang5` text COLLATE utf8_bin,
  `langother` text COLLATE utf8_bin,
  `langdim` text COLLATE utf8_bin,
  PRIMARY KEY (`passcode`,`resourceid`,`CONF`,`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

---ODS KEYS ---
DROP table `ods_lremap_resource_keys`;
CREATE TABLE `ods_lremap_resource_keys` (
`resourceid` VARCHAR(32) NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`,`passcode`,`resid`,`CONF`,`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



---norm---
DROP table `ods_lremap_resource_norm_keys`;
CREATE TABLE `ods_lremap_resource_norm_keys` (
`resourceid` VARCHAR(32) NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`,`passcode`,`resid`,`CONF`,`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;




---KEYS---

DROP table `lremap_resource_keys`;
CREATE TABLE `lremap_resource_keys` (
  `resourceid` VARCHAR(32) NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `resource_normid` VARCHAR(32) NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
 
  PRIMARY KEY (`resourceid`,`resource_normid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--- resource auth ---
DROP TABLE `lremap_resource`;
CREATE TABLE `lremap_resource` (
  `resourceid` VARCHAR(32) NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
 `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  `modality` text COLLATE utf8_bin,
  `resourceusage` text COLLATE utf8_bin,
  `avail` text COLLATE utf8_bin,
  `url` text COLLATE utf8_bin,
   `size` text COLLATE utf8_bin,
  `unit` text COLLATE utf8_bin,  
`license` text COLLATE utf8_bin,
  `doc` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--- resource norm ---
DROP TABLE `lremap_resource_norm`;
CREATE TABLE `lremap_resource_norm` (
  `resourceid` VARCHAR(32) NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
 `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  `modality` text COLLATE utf8_bin,
  `resourceusage` text COLLATE utf8_bin,
  `avail` text COLLATE utf8_bin,
  `url` text COLLATE utf8_bin,
   `size` text COLLATE utf8_bin,
  `unit` text COLLATE utf8_bin,  
`license` text COLLATE utf8_bin,
  `doc` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- LANGS--
--- norm ---
DROP TABLE `lremap_resource_lang_norm`;
CREATE TABLE `lremap_resource_lang_norm` (
  `resourceid` VARCHAR(32) NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `lang1` text COLLATE utf8_bin,
  `lang2` text COLLATE utf8_bin,
  `lang3` text COLLATE utf8_bin,
  `lang4` text COLLATE utf8_bin,
  `lang5` text COLLATE utf8_bin,
  `langother` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--- auth ---
DROP TABLE `lremap_resource_lang`;
CREATE TABLE `lremap_resource_lang` (
  `resourceid` VARCHAR(32) NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `lang1` text COLLATE utf8_bin,
  `lang2` text COLLATE utf8_bin,
  `lang3` text COLLATE utf8_bin,
  `lang4` text COLLATE utf8_bin,
  `lang5` text COLLATE utf8_bin,
  `langother` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;