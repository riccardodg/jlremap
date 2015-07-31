SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE `lremap_datathon`.`lremap_resource` 
ADD CONSTRAINT `fk_lremap_resource2subs`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_subs` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `lremap_datathon`.`lremap_resource_norm` 
ADD CONSTRAINT `fk_lremap_resourcenorm2subsnorm`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_subs_norm` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
----
ALTER TABLE `lremap_datathon`.`lremap_authors` 
ADD CONSTRAINT `fk_lremap_authors2resource`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `lremap_datathon`.`lremap_authors_norm` 
ADD CONSTRAINT `fk_lremap_authorsnorm2resourcenorm`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource_norm` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

----
ALTER TABLE `lremap_datathon`.`lremap_papers` 
ADD CONSTRAINT `fk_lremap_papers2resource`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_resource` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `lremap_datathon`.`stage_lremap_resource_keys` 
ADD CONSTRAINT `fk_stage_lremap_resource_keys_1`
  FOREIGN KEY ()
  REFERENCES `lremap_datathon`.`lremap_resource_norm` ()
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;




ALTER TABLE `lremap_datathon`.`lremap_authors` 
ADD CONSTRAINT `fk_lremap_papers2authors`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_papers` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `lremap_datathon`.`lremap_authors_norm` 
ADD CONSTRAINT `fk_lremap_papersnorm2authorsnorm`
  FOREIGN KEY (`resourceid`)
  REFERENCES `lremap_datathon`.`lremap_papers_norm` (`resourceid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

SET FOREIGN_KEY_CHECKS=1;