SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for quest_bug_list
-- ----------------------------
DROP TABLE IF EXISTS `quest_bug_list`;
CREATE TABLE `quest_bug_list` (
 `quest_id` int(20) unsigned NOT NULL default '0',
 PRIMARY KEY (`quest_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

delete from `trinity_string` where `entry` IN ('13002','13003','13004','13005','13006','13007');
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES ('13002','Vous ne suivez pas cette quête !');
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES ('13003','Cette quête n\'est actuellement pas signalée bugée, Utilisez le bug tracker ou créer un ticket pour nous la signaler.');
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES ('13004','La quête %u est déja dans la liste des quêtes buguées');
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES ('13005','Quête %u ajoutée la liste des quêtes bugées');
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES ('13006','La quête %u n\'est pas signalée bugée');
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES ('13007','La quête %u est retirée de la liste des quêtes bugées');

INSERT INTO `command` (`name`,`help`) VALUES ('valide','Syntax .valide $queteID , vous pouvez aussi link votre quête depuis votre journal de quête.');
INSERT INTO `command` (`name`,`security`,`help`) VALUES ('questbug add','2','Syntax .questbug add $queteID , Ajoute la quete à la liste des quêtes bugées');
INSERT INTO `command` (`name`,`security`,`help`) VALUES ('questbug remove','2','Syntax .questbug remove $queteID , retire la quête de la liste des quêtes bugées');
