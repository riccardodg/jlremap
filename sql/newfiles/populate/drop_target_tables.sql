/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Riccardo Del Gratta &lt;riccardo.delgratta@ilc.cnr.it&gt;
 * Created: Apr 24, 2019
 */
SET FOREIGN_KEY_CHECKS=0;

--
-- Table structure for table `lremap_subs`
--

DROP TABLE IF EXISTS `lremap_subs`;

DROP TABLE IF EXISTS `lremap_subs_norm`;

DROP TABLE IF EXISTS `lremap_resource_keys`;

--
-- DATA PROVIDED DURING SUBMISSIONS BY AUTHORS: THAT'S TO SAY NO NORMALIZED DATA
--

-- resources
DROP TABLE IF EXISTS `lremap_resources`;

-- authors
DROP TABLE IF EXISTS `lremap_authors`;

-- papers
DROP TABLE IF EXISTS `lremap_papers`;

-- languages
DROP TABLE IF EXISTS `lremap_resource_langs`;
DROP TABLE IF EXISTS `lremap_resource_langs_dim`;
DROP TABLE IF EXISTS `lremap_resource_other_langs`;
DROP TABLE IF EXISTS `lremap_resource_pivoted_langs`;

-- ISLRN
DROP TABLE IF EXISTS `lremap_resources_ISLRN`;
-- -- -- -- --
--
-- NORMALIZED DATA
--

-- resources_norm
DROP TABLE IF EXISTS `lremap_resources_norm`;

-- authors_norm
DROP TABLE IF EXISTS `lremap_authors_norm`;

-- papers_norm

DROP TABLE IF EXISTS `lremap_papers_norm`;

-- languages
DROP TABLE IF EXISTS `lremap_resource_langs_norm`;
DROP TABLE IF EXISTS `lremap_resource_langs_dim_norm`;
DROP TABLE IF EXISTS `lremap_resource_other_langs_norm`;
DROP TABLE IF EXISTS `lremap_resource_pivoted_langs_norm`;

-- ISLRN
DROP TABLE IF EXISTS `lremap_resources_ISLRN_norm`;


SET FOREIGN_KEY_CHECKS=1;

