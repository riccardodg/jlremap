 SET FOREIGN_KEY_CHECKS=0;

--
-- Table structure for table `lremap_subs`
--

DROP TABLE IF EXISTS `lremap_subs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lremap_subs` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`resourceid`),
  KEY `SIDX` (`CONF`,`YEAR`,`passcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `lremap_subs_norm`
--

DROP TABLE IF EXISTS `lremap_subs_norm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lremap_subs_norm` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`resourceid`),
  KEY `SIDXN` (`CONF`,`YEAR`,`passcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lremap_resource_keys`
--

DROP TABLE IF EXISTS `lremap_resource_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lremap_resource_keys` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `resource_normid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  PRIMARY KEY (`resourceid`),
  UNIQUE KEY `NID` (`resource_normid`),
  CONSTRAINT `fk_keys2subs` FOREIGN KEY (`resourceid`) REFERENCES `lremap_subs` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_keysnorm2subsnorm` FOREIGN KEY (`resource_normid`) REFERENCES `lremap_subs_norm` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- DATA PROVIDED DURING SUBMISSIONS BY AUTHORS: THAT'S TO SAY NO NORMALIZED DATA
--

-- resources
--
-- Table structure for table `lremap_resources`
--

DROP TABLE IF EXISTS `lremap_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lremap_resources` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
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
  PRIMARY KEY (`resourceid`),
  CONSTRAINT `fk_lremap_resource_1` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resource_keys` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

-- authors
--
-- Table structure for table `lremap_authors`
--

DROP TABLE IF EXISTS `lremap_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lremap_authors` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `authornumber` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `username` text COLLATE utf8_bin,
  `firstname` text COLLATE utf8_bin,
  `lastname` text COLLATE utf8_bin,
  `email` text COLLATE utf8_bin,
  `affiliation` text COLLATE utf8_bin,
  `country` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`,`authornumber`),
  KEY `AIDX` (`authornumber`),
  CONSTRAINT `fk_authors2papers` FOREIGN KEY (`resourceid`) REFERENCES `lremap_papers` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

-- papers
--
-- Table structure for table `lremap_papers`
--

DROP TABLE IF EXISTS `lremap_papers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lremap_papers` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `paperid` int(11) NOT NULL DEFAULT '0',
  `status` text COLLATE utf8_bin,
  `title` text COLLATE utf8_bin,
  `category1` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`),
  KEY `PIDX` (`paperid`),
  CONSTRAINT `fk_papers2resources` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resources` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

-- languages
--
-- Table structure for table `lremap_resource_langs`
--

DROP TABLE IF EXISTS `lremap_resource_langs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lremap_resource_langs` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `lang1` text COLLATE utf8_bin,
  `lang2` text COLLATE utf8_bin,
  `lang3` text COLLATE utf8_bin,
  `lang4` text COLLATE utf8_bin,
  `lang5` text COLLATE utf8_bin,
  `langother` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`),
  CONSTRAINT `fk_lremap_resource_lang_2_r` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resources` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `lremap_resource_langs_dim`
--

DROP TABLE IF EXISTS `lremap_resource_langs_dim`;
CREATE TABLE `lremap_resource_langs_dim` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `lang_type` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`resourceid`,`lang_type`),
  CONSTRAINT `fk_lremap_resource_norm_lang_dim_2_rl` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resource_langs` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


--
-- Table structure for table `lremap_resource_other_langs`
--

DROP TABLE IF EXISTS `lremap_resource_other_langs`;
CREATE TABLE `lremap_resource_other_langs` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `language` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`),
  CONSTRAINT `fk_lremap_resource_other_lang_2_rl` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resource_langs` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `lremap_resource_pivoted_langs`
--

DROP TABLE IF EXISTS `lremap_resource_pivoted_langs`;
CREATE TABLE `lremap_resource_pivoted_langs` (
   `id` INT NOT NULL AUTO_INCREMENT,
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `language` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
   KEY (`resourceid`,`language`),
  CONSTRAINT `fk_lremap_resource_pvt_lang_2_rl` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resource_langs` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


-- ISLRN
--
-- Table structure for table `lremap_resources_ISLRN`
--
DROP TABLE IF EXISTS `lremap_resources_ISLRN`;
CREATE TABLE `lremap_resources_ISLRN` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  `ISLRNstatus` text COLLATE utf8_bin,
  `ISLRNcode` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`),
  CONSTRAINT `fk_lremap_resource_islrn2rkey` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resources` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- -- -- -- --
--
-- NORMALIZED DATA
--

-- resources_norm
--
-- Table structure for table `lremap_resources_norm`
--

DROP TABLE IF EXISTS `lremap_resources_norm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lremap_resources_norm` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
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
  PRIMARY KEY (`resourceid`),
  CONSTRAINT `fk_lremap_resource_norm_2_keys` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resource_keys` (`resource_normid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

-- authors_norm
--
-- Table structure for table `lremap_authors_norm`
--

DROP TABLE IF EXISTS `lremap_authors_norm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lremap_authors_norm` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `authornumber` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `username` text COLLATE utf8_bin,
  `firstname` text COLLATE utf8_bin,
  `lastname` text COLLATE utf8_bin,
  `email` text COLLATE utf8_bin,
  `affiliation` text COLLATE utf8_bin,
  `country` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`,`authornumber`),
  KEY `AIDXN` (`authornumber`),
  CONSTRAINT `fk_authorsnorm2papersnorm` FOREIGN KEY (`resourceid`) REFERENCES `lremap_papers_norm` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

-- papers_norm
--
-- Table structure for table `lremap_papers_norm`
--

DROP TABLE IF EXISTS `lremap_papers_norm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lremap_papers_norm` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `paperid` int(11) NOT NULL DEFAULT '0',
  `status` text COLLATE utf8_bin,
  `title` text COLLATE utf8_bin,
  `category1` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`),
  KEY `index2` (`paperid`),
  CONSTRAINT `fk_papersnorm2resourcesnorm` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resources_norm` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

-- languages
--
-- Table structure for table `lremap_papers_norm`
--

DROP TABLE IF EXISTS `lremap_resource_langs_norm`;
CREATE TABLE `lremap_resource_langs_norm` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `lang1` text COLLATE utf8_bin,
  `lang2` text COLLATE utf8_bin,
  `lang3` text COLLATE utf8_bin,
  `lang4` text COLLATE utf8_bin,
  `lang5` text COLLATE utf8_bin,
  `langother` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`),
  CONSTRAINT `fk_lremap_resource_lang_2_rn` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resources_norm` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `lremap_resource_langs_dim_norm`
--

DROP TABLE IF EXISTS `lremap_resource_langs_dim_norm`;
CREATE TABLE `lremap_resource_langs_dim_norm` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `lang_type` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`resourceid`,`lang_type`),
  CONSTRAINT `fk_lremap_resource_norm_lang_dim_2_rln` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resource_langs_norm` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `lremap_resource_other_langs_norm`
--

DROP TABLE IF EXISTS `lremap_resource_other_langs_norm`;
CREATE TABLE `lremap_resource_other_langs_norm` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `language` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`),
  CONSTRAINT `fk_lremap_resource_other_lang_norm_2_rln` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resource_langs_norm` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


--
-- Table structure for table `lremap_resource_pivoted_langs_norm`
--

DROP TABLE IF EXISTS `lremap_resource_pivoted_langs_norm`;
CREATE TABLE `lremap_resource_pivoted_langs_norm` (
 `id` INT NOT NULL AUTO_INCREMENT,
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `language` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
   KEY (`resourceid`,`language`),
  CONSTRAINT `fk_lremap_resource_pvt_lang_norm_2_rln` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resource_langs_norm` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ISLRN
--
-- Table structure for table `lremap_resources_ISLRN`
--

DROP TABLE IF EXISTS `lremap_resources_ISLRN_norm`;
CREATE TABLE `lremap_resources_ISLRN_norm` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  `ISLRNstatus` text COLLATE utf8_bin,
  `ISLRNcode` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`),
  CONSTRAINT `fk_lremap_resource_islrn_n2rkey` FOREIGN KEY (`resourceid`) REFERENCES `lremap_resources_norm` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


 SET FOREIGN_KEY_CHECKS=1;
