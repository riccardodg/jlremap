--
-- stage tables are loaded from data created by a java program (jlremap)
-- Corresponding populating file is populate_lremap_new_stage_tables.sql under the 
-- populate folder

--
-- Table structure for table `stage_lremap_resource`
--

DROP TABLE IF EXISTS `stage_lremap_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stage_lremap_resource_keys`
--

DROP TABLE IF EXISTS `stage_lremap_resource_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stage_lremap_resource_keys_test`
--

-- DROP TABLE IF EXISTS `stage_lremap_resource_keys_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `stage_lremap_resource_keys_test` (
--   `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
--   `YEAR` char(4) COLLATE utf8_bin NOT NULL,
--   `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
--   `resourceid` int(11) NOT NULL DEFAULT '0',
--   `type` text COLLATE utf8_bin,
--   `name` text COLLATE utf8_bin,
--   `prodstatus` text COLLATE utf8_bin,
--   `norm_type` text COLLATE utf8_bin,
-- `norm_name` text COLLATE utf8_bin,
--   `norm_prodstatus` text COLLATE utf8_bin
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
--  /*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stage_lremap_resource_lang`
--

DROP TABLE IF EXISTS `stage_lremap_resource_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stage_lremap_resource_lang_norm`
--

DROP TABLE IF EXISTS `stage_lremap_resource_lang_norm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stage_lremap_resource_norm`
--

DROP TABLE IF EXISTS `stage_lremap_resource_norm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
