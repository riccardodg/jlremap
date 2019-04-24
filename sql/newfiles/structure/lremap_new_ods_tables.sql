--
-- Table structure for table `ods_lremap_resource_keys`
--

DROP TABLE IF EXISTS `ods_lremap_resource_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ods_lremap_resource_keys` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'fa53b91ccc1b78668d5af58e1ed3a485',
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`,`passcode`,`resid`,`CONF`,`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ods_lremap_resource_norm_keys`
--

DROP TABLE IF EXISTS `ods_lremap_resource_norm_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ods_lremap_resource_norm_keys` (
  `resourceid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '589275fdd4e5908f18310b56beaf439b',
  `CONF` varchar(50) COLLATE utf8_bin NOT NULL,
  `YEAR` char(4) COLLATE utf8_bin NOT NULL,
  `passcode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resid` int(11) NOT NULL DEFAULT '0',
  `type` text COLLATE utf8_bin,
  `name` text COLLATE utf8_bin,
  `prodstatus` text COLLATE utf8_bin,
  PRIMARY KEY (`resourceid`,`passcode`,`resid`,`CONF`,`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
