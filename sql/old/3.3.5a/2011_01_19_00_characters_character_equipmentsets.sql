ALTER TABLE `character_equipmentsets`
CHANGE `guid` `guid` INT(10) DEFAULT '0' NOT NULL,
CHANGE `setindex` `setindex` TINYINT(3) UNSIGNED DEFAULT '0' NOT NULL,
CHANGE `name` `name` VARCHAR(31) NOT NULL,
CHANGE `item0` `item0` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item1` `item1` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item2` `item2` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item3` `item3` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item4` `item4` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item5` `item5` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item6` `item6` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item7` `item7` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item8` `item8` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item9` `item9` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item10` `item10` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item11` `item11` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item12` `item12` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item13` `item13` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item14` `item14` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item15` `item15` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item16` `item16` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item17` `item17` INT(10) UNSIGNED NOT NULL DEFAULT '0', 
CHANGE `item18` `item18` INT(10) UNSIGNED NOT NULL DEFAULT '0';