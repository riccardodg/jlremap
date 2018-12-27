SET FOREIGN_KEY_CHECKS=0;

-- keys --

ALTER TABLE `lremap_datathon`.`lremap_resource_keys` 
ADD CONSTRAINT `fk_keys2subs`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_subs` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `lremap_datathon`.`lremap_resource_keys` 
ADD CONSTRAINT `fk_keys2subs_norm`
  FOREIGN KEY (`resource_normid`)
  REFERENCES `lremap_datathon`.`lremap_subs_norm` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
-- resource --



ALTER TABLE `lremap_datathon`.`lremap_resource` 
ADD CONSTRAINT `fk_lremap_resource_2rkey`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_keys` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- resource_norm --


ALTER TABLE `lremap_datathon`.`lremap_resource_norm` 
ADD CONSTRAINT `fk_lremap_resource_2rnkey`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_keys` (`resource_normid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- papers --


ALTER TABLE `lremap_datathon`.`lremap_papers` 
ADD CONSTRAINT `fk_lremap_papers2resource`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


-- papers_norm --


ALTER TABLE `lremap_datathon`.`lremap_papers_norm` 
ADD CONSTRAINT `fk_lremap_papers_norm_2resource_norm`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_norm` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- authors --
ALTER TABLE `lremap_datathon`.`lremap_authors` 
ADD CONSTRAINT `fk_lremap_papers2authors`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_papers` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- authors_norm --
ALTER TABLE `lremap_datathon`.`lremap_authors_norm` 
ADD CONSTRAINT `fk_lremap_papersnorm2authorsnorm`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_papers_norm` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- languages --


ALTER TABLE `lremap_datathon`.`lremap_resource_lang` 
ADD CONSTRAINT `fk_lremap_resource_lang_2_r`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `lremap_datathon`.`lremap_resource_lang_norm` 
ADD CONSTRAINT `fk_lremap_resource_lang_2_rn`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_norm` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `lremap_datathon`.`lremap_resource_pivoted_lang_norm` 
ADD CONSTRAINT `fk_lremap_resource_pvt_lang_norm_2_rln`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_lang_norm` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `lremap_datathon`.`lremap_resource_pivoted_lang` 
ADD CONSTRAINT `fk_lremap_resource_pvt_lang_2_rl`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_lang` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `lremap_datathon`.`lremap_resource_other_lang_norm` 
ADD CONSTRAINT `fk_lremap_resource_other_lang_norm_2_rln`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_lang_norm` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `lremap_datathon`.`lremap_resource_other_lang` 
ADD CONSTRAINT `fk_lremap_resource_other_lang_2_rl`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_lang` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `lremap_datathon`.`lremap_resource_norm_lang_dim` 
ADD CONSTRAINT `fk_lremap_resource_norm_lang_dim_2_rln`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_lang_norm` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `lremap_datathon`.`lremap_resource_lang_dim` 
ADD CONSTRAINT `fk_lremap_resource_norm_lang_dim_2_rl`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_lang` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;




SET FOREIGN_KEY_CHECKS=1;