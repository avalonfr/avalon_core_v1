/*NOTE! Included Cyrillic Fonts - open it in UTF8 coding*/

SET NAMES 'utf8';

DELETE FROM `trinity_string` WHERE entry IN (756,757,758,759,760,761,762,763,764,765,766,767,768,769,770,771,772,780,781,782,783);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('756', 'Que la Bataille Commence!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Битва началась'),
('757', '%s a defendu la forteresse avec succes!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '%s успешно защитил(а) крепость!'),
('758', '%s a capture la forteresse!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '%s захватил(а) крепость'),
('759', 'L atelier  %s a ete endommage par %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('760', 'L atelier %s a ete detruit par %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('761', 'La tour %s  a ete endommagee!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '%s башня повреждена'),
('762', 'La tour %s  a ete detruite!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '%s башня уничтожена!'),
('763', 'La forteresse est attaquee!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('764', 'Le joug est maintenant sous le controle de %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('765', 'Wintergrasp timer set to %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('766', 'Joug bataille en cours.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('767', 'Joug bataille terminee.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('768', 'Info joug : %s controle. temps: %s. guerre: %s. nombre de joueurs: (Horde: %u, Alliance: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('769', 'Wintergrasp outdoorPvP is disabled.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('770', 'Wintergrasp outdoorPvP is enabled.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('771', 'Vous avez atteint le rang  1: Corporal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Вы достигли Ранга 1: Капрал'),
('772', 'Vous avez atteint le rang 2: 1er Lieutenant', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Вы достигли Ранга 2: Лейтенант'),
('780', '30 minutes avant la bataille du joug!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'До битвы на  Озере Ледяных Оков осталось 30 минут!'),
('781', '10 minutes avant la bataille du joug !Portail a partir de  Dalaran activés dans 5 minutes.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'До битвы на  Озере Ледяных Оков осталось 10 минут! Портал с Даларана начнет роботу через 5 минут.'),
('782', 'The battle for Wintergrasp  has stopped! Not enough defenders. Wintergrasp Fortress remains  Attackers.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Битва за Озеро Ледяных Оков Остановлена. Не хватает защитников. Крепость переходит атакующей  стороне.'),
('783', 'The battle for Wintergrasp  has stopped! Not enough attackers. Wintergrasp Fortress remains  Defenders.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Битва за Озеро Ледяных Оков Остановлена. Не хватает нападающих. Крепость остается защитникам.');

DELETE FROM `command` WHERE name IN ('wg','wg enable','wg start','wg status','wg stop','wg switch','wg timer');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('wg', '3', 'Syntax: .wg $subcommand.'),
('wg enable', '3', 'Syntax: .wg enable [on/off] Enable/Disable Wintergrasp outdoorPvP.'),
('wg start', '3', 'Syntax: .wg start\r\nForce Wintergrasp battle start.'),
('wg status', '3', 'Syntax: .wg status\r\nWintergrasp info, defender, timer, wartime.'),
('wg stop', '3', 'Syntax: .wg stop\r\nForce Wintergrasp battle stop (No rewards).'),
('wg switch', '3', 'Syntax: .wg switch\r\nSwitchs Wintergrasp defender team.'),
('wg timer', '3', 'Syntax: .wg timer $minutes\r\nChange the current timer. Min value = 1, Max value 60 (Wartime), 1440 (Not Wartime)');

/* WG scriptname */
DELETE FROM `outdoorpvp_template` WHERE TypeId=7;
INSERT INTO `outdoorpvp_template` (`TypeId`, `ScriptName`, `comment`) VALUES 
('7', 'outdoorpvp_wg', 'Wintergrasp');

UPDATE `creature_template` SET `ScriptName` = 'npc_demolisher_engineerer' WHERE `entry` IN (30400,30499);

/* Teleport WG SPELLs*/
DELETE FROM `spell_target_position` WHERE id IN ('59096', '58632', '58633');
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
('59096', '571', '5325.06', '2843.36', '409.285', '3.20278'),
('58632', '571', '5097.79', '2180.29', '365.61', '2.41'),
('58633', '571', '5026.80', '3676.69', '362.58', '3.94');

/* Defender's Portal Activate Proper Spell */
DELETE FROM `spell_linked_spell` WHERE spell_trigger=54640;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES 
('54640','54643','0','Defender s Portal Activate Proper Spell');

/* Temp removed gameobject stopping you getting to the relic
* 194323 - [Wintergrasp Keep Collision Wall X:5396.209961 Y:2840.010010 Z:432.268005 MapId:571
* 194162 - [Doodad_WG_Keep_Door01_collision01 X:5397.109863 Y:2841.540039 Z:425.901001 MapId:571]*/
DELETE FROM gameobject WHERE id IN ('194323', '194162');

/* Titan Relic remove */
DELETE FROM `gameobject` WHERE `id`=192829;

/* Towers */
UPDATE `gameobject_template` SET `faction` = 0, `flags` = 6553632 WHERE `entry` IN (190356,190357,190358);

/*Spirit healer FIX */
UPDATE creature_template SET npcflag=npcflag|32768 WHERE entry IN (31841,31842);

/* Creature template */
UPDATE creature_template SET faction_A = '1802', faction_H = '1802' WHERE entry IN (30499,28312,28319);
UPDATE creature_template SET faction_A = '1801', faction_H = '1801' WHERE entry IN (30400,32629,32627);
UPDATE creature_template SET npcflag=npcflag|32768 WHERE entry   IN (31841,31842);

/* spell target for build vehicles */
DELETE FROM `conditions` WHERE ConditionValue2=27852;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 49899, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56575, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56661, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56663, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56665, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56667, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56669, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 61408, 0, 18, 1, 27852, 0, 0, '', NULL);

/* Workshop */
UPDATE `gameobject_template` SET `faction` = 35 WHERE `entry` IN (192028,192029,192030,192031,192032,192033);

/*WG Spell area Data */
/*For wg antifly */
DELETE FROM `spell_area` WHERE spell IN (58730, 57940, 58045);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_start_active`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`) VALUES
(58730, 4197, 0, 0, 0, 0, 0, 2, 1),
(58730, 4584, 0, 0, 0, 0, 0, 2, 1),
(58730, 4581, 0, 0, 0, 0, 0, 2, 1),
(58730, 4585, 0, 0, 0, 0, 0, 2, 1),
(58730, 4612, 0, 0, 0, 0, 0, 2, 1),
(58730, 4582, 0, 0, 0, 0, 0, 2, 1),
(58730, 4611, 0, 0, 0, 0, 0, 2, 1),
(58730, 4578, 0, 0, 0, 0, 0, 2, 1),
(58730, 4576, 0, 0, 0, 0, 0, 2, 1),
(58730, 4538, 0, 0, 0, 0, 0, 2, 1),
(57940, 65, 0, 0, 0, 0, 0, 2, 1),
(57940, 66, 0, 0, 0, 0, 0, 2, 1),
(57940, 67, 0, 0, 0, 0, 0, 2, 1),
(57940, 206, 0, 0, 0, 0, 0, 2, 1),
(57940, 210, 0, 0, 0, 0, 0, 2, 1),
(57940, 394, 0, 0, 0, 0, 0, 2, 1),
(57940, 395, 0, 0, 0, 0, 0, 2, 1),
(57940, 1196, 0, 0, 0, 0, 0, 2, 1),
(57940, 2817, 0, 0, 0, 0, 0, 2, 1),
(57940, 3456, 0, 0, 0, 0, 0, 2, 1),
(57940, 3477, 0, 0, 0, 0, 0, 2, 1),
(57940, 3537, 0, 0, 0, 0, 0, 2, 1),
(57940, 3711, 0, 0, 0, 0, 0, 2, 1),
(57940, 4100, 0, 0, 0, 0, 0, 2, 1),
(57940, 4196, 0, 0, 0, 0, 0, 2, 1),
(57940, 4228, 0, 0, 0, 0, 0, 2, 1),
(57940, 4264, 0, 0, 0, 0, 0, 2, 1),
(57940, 4265, 0, 0, 0, 0, 0, 2, 1),
(57940, 4272, 0, 0, 0, 0, 0, 2, 1),
(57940, 4273, 0, 0, 0, 0, 0, 2, 1),
(57940, 4395, 0, 0, 0, 0, 0, 2, 1),
(57940, 4415, 0, 0, 0, 0, 0, 2, 1),
(57940, 4416, 0, 0, 0, 0, 0, 2, 1),
(57940, 4493, 0, 0, 0, 0, 0, 2, 1),
(57940, 4494, 0, 0, 0, 0, 0, 2, 1),
(57940, 4603, 0, 0, 0, 0, 0, 2, 1),
(58045, 4197, 0, 0, 0, 0, 0, 2, 1);

/* Rajout des spells aux véhicules */
delete FROM npc_spellclick_spells WHERE npc_entry IN(32627,28094,27881,28312,28319,32629);

insert into `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) values('27881','60968','0','0','0','1','0','0','0');
insert into `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) values('28094','60968','0','0','0','1','0','0','0');
insert into `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) values('28312','60968','0','0','0','1','0','0','0');
insert into `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) values('28319','60968','0','0','0','1','0','0','0');
insert into `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) values('32627','60968','0','0','0','1','0','0','0');
insert into `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) values('32629','60968','0','0','0','1','0','0','0');

/* ajout des objectifs outdoor */
DELETE FROM gameobject_template WHERE entry IN (182173,182174,182175,182210,183104,183411,183412,183413,183414,182522,182523,182097,182098,182096,181899);

insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('181899','29','6834','Doodad_BattlefieldBanner_State_Base_Plaguelands01','','','','114','32','1','0','0','0','0','0','0','80','11515','2426','2427','10568','10556','10697','10696','10699','10698','11151','11150','20','2428','1','5','480','1200','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('182096','29','6834','Doodad_BattlefieldBanner_State_Base_Plaguelands02','','','','114','32','1','0','0','0','0','0','0','80','11515','2426','2427','10570','10566','10703','10702','10705','10704','11155','11154','20','2428','1','5','480','1200','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('182097','29','6834','Doodad_BattlefieldBanner_State_Base_Plaguelands03','','','','114','32','1','0','0','0','0','0','0','80','11515','2426','2427','10569','10565','10689','10690','10691','10692','11149','11148','20','2428','1','5','480','1200','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('182098','29','6834','Doodad_BattlefieldBanner_State_Base_Plaguelands04','','','','114','32','1','0','0','0','0','0','0','80','11515','2426','2427','10567','10564','10687','10688','10701','10700','11153','11152','20','2428','1','5','480','1200','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('182173','29','6834','Hellfire Banner, W','','','','0','32','1','0','0','0','0','0','0','80','32050','2473','2474','11390','11389','11384','11383','11388','11387','11386','11385','20','2475','1','5','240','600','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('182174','29','6834','Hellfire Banner, N','','','','0','32','1','0','0','0','0','0','0','80','32050','2473','2474','11398','11397','11392','11391','11396','11395','11394','11393','20','2475','1','5','240','600','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('182175','29','6834','Hellfire Banner, S','','','','0','32','1','0','0','0','0','0','0','80','32050','2473','2474','11406','11405','11400','11399','11404','11403','11402','11401','20','2475','1','5','240','600','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('182210','29','6834','Halaa Banner','','','','0','48','1','0','0','0','0','0','0','100','0','2495','2494','11504','11503','11559','11558','11821','11822','0','0','0','2497','1','10','300','600','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('182522','29','1287','Zangarmarsh Banner','','','','0','32','1','0','0','0','0','0','0','60','11515','2527','2528','0','0','11813','11812','11805','11804','11808','11809','80','2529','1','5','300','600','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('182523','29','1287','Zangarmarsh Banner','','','','0','32','1','0','0','0','0','0','0','60','11515','2533','2534','0','0','11816','11817','11807','11806','11814','11815','80','2535','1','5','300','600','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('183104','29','6834','Terokkar Banner','','','','0','32','1','0','0','0','0','0','0','75','0','2623','2625','0','0','0','0','12226','12225','12228','12227','80','2624','1','10','60','120','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('183411','29','6834','Terokkar Banner','','','','0','48','1','0','0','0','0','0','0','75','0','2623','2625','0','0','0','0','12497','12496','12490','12491','80','2624','1','10','60','120','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('183412','29','6834','Terokkar Banner','','','','0','48','1','0','0','0','0','0','0','75','0','2623','2625','0','0','0','0','12486','12487','12488','12489','80','2624','1','10','60','120','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('183413','29','6834','Terokkar Banner','','','','0','48','1','0','0','0','0','0','0','75','0','2623','2625','0','0','0','0','12499','12498','12492','12493','80','2624','1','10','60','120','1','0','50','0','0','0','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) values('183414','29','6834','Terokkar Banner','','','','0','48','1','0','0','0','0','0','0','75','0','2623','2625','0','0','0','0','12501','12500','12494','12495','80','2624','1','10','60','120','1','0','50','0','0','0','','12340');

/* main gate fortress */
delete FROM gameobject WHERE id IN (191810);
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('191810','571','1','1','5397.11','2841.54','425.901','3.14159','0','0','0','0','300','0','1');




/*----------------------------------------------------------------------- MALYGOSS ----------------------------------------------------------------------------------------------*/
-- Set instance script
UPDATE `instance_template` SET `script` = 'instance_eye_of_eternity' WHERE map = 616;
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 30334;

-- Update flags for NPCs/Vehicles
UPDATE `creature_template` SET `flags_extra` = flags_extra | 2 WHERE `entry`= 30090; -- Vortex  'Arcane Overload', 'Hover Disk');
UPDATE `creature_template` SET `flags_extra` = flags_extra | 2, `faction_A` = 35, `faction_H` = 35, `VehicleId` = 264 WHERE `entry` IN (30234, 30248); -- Hover Disk (`VehicleId` 264)
UPDATE `creature_template` SET `flags_extra` = flags_extra | 2, `faction_A` = 35, `faction_H` = 35 WHERE `entry` = 30118; -- Portal (Malygos)
UPDATE `creature_template` SET `flags_extra` = flags_extra | 2 WHERE `entry` = 30282; -- Arcane Overload
UPDATE `creature_template` SET `mindmg` = 1, `maxdmg` = 1, `dmg_multiplier` = 1 WHERE `entry` = 30592; -- Static Field
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 11686 WHERE `entry` = 22517; -- Some world trigger

-- Set scriptnames and some misc data to bosses and GOs
UPDATE `gameobject_template` SET `flags` = 0, `data0` = 43 WHERE `entry` IN (193967, 193905);
UPDATE `creature_template` SET `ScriptName` = 'boss_malygos', unit_flags = unit_flags & ~256 WHERE `entry` = 28859;
UPDATE `creature` SET `MovementType` = 0, `spawndist` = 0 WHERE `id` = 28859; -- Malygos, don't move
UPDATE `creature_template` SET `ScriptName` = 'mob_nexus_lord' WHERE `entry` = 30245; -- Nexus Lord
UPDATE `creature_template` SET `ScriptName` = 'mob_scion_of_eternity' WHERE `entry` = 30249; -- Scion of Eternity
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `ScriptName` = 'mob_power_spark' WHERE `entry` = 30084; -- Power Spark
UPDATE `creature_template` SET `ScriptName` = 'npc_arcane_overload' WHERE `entry` = 30282; -- Arcane Overload

-- Script GO Focusing Iris
UPDATE `gameobject_template` SET `ScriptName` = 'go_malygos_iris' WHERE `entry` IN (193960,193958); 

-- Fix Wyrmrest drakes creature info
UPDATE `creature_template` SET `spell1` = 56091, `spell2` = 56092, `spell3` = 57090, `spell4` = 57143, `spell5` = 57108, `spell6` = 57403, `VehicleId` = 165 WHERE entry IN (30161, 31752);

-- Fix Surge of Power targeting
DELETE FROM `conditions` WHERE SourceTypeOrReferenceId = 13 AND `SourceEntry` = 56505;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, COMMENT) VALUES
(13, 0, 56505, 0, 18, 1, 22517, 0, 0, "Surge of Power - cast only on World Trigger (Large AOI)");

UPDATE `creature_template` SET flags_extra = flags_extra | 1, mechanic_immune_mask = 1072902595 WHERE `entry` IN (30245, 31750);

-- Fix sound entries for Malygos encounter
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1616034 AND -1616000;
INSERT INTO `script_texts` (npc_entry, entry, content_default, sound, type, language, emote, comment) VALUES
(28859, -1616000, 'Lesser beings, intruding here! A shame that your excess courage does not compensate for your stupidity!', 14512, 1, 0, 0, 'Malygos INTRO 1'),
(28859, -1616001, 'None but the blue dragonflight are welcome here! Perhaps this is the work of Alexstrasza? Well then, she has sent you to your deaths.', 14513, 1, 0, 0, 'Malygos INTRO 2'),
(28859, -1616002, 'What could you hope to accomplish, to storm brazenly into my domain? To employ MAGIC? Against ME?', 14514, 1, 0, 0, 'Malygos INTRO 3'),
(28859, -1616003, 'I am without limits here... the rules of your cherished reality do not apply... In this realm, I am in control...', 14515, 1, 0, 0, 'Malygos INTRO 4'),
(28859, -1616004, 'I give you one chance. Pledge fealty to me, and perhaps I won\'t slaughter you for your insolence!', 14516, 1, 0, 0, 'Malygos INTRO 5'),
(28859, -1616005, 'My patience has reached its limit, I WILL BE RID OF YOU!', 14517, 1, 0, 0, 'Malygos AGGRO 1'),
(28859, -1616006, 'Watch helplessly as your hopes are swept away...', 14525, 1, 0, 0, 'Malygos VORTEX'),
(28859, -1616007, 'I AM UNSTOPPABLE!', 14533, 1, 0, 0, 'Malygos SPARK BUFF'),
(28859, -1616008, 'Your stupidity has finally caught up to you!', 14519, 1, 0, 0, 'Malygos SLAY 1-1'),
(28859, -1616009, 'More artifacts to confiscate...', 14520, 1, 0, 0, 'Malygos SLAY 1-2'),
(28859, -1616010, 'How very... naive...', 14521, 1, 0, 0, 'Malygos SLAY 1-3'),
(28859, -1616012, 'I had hoped to end your lives quickly, but you have proven more...resilient then I had anticipated. Nonetheless, your efforts are in vain, it is you reckless, careless mortals who are to blame for this war! I do what I must...And if it means your...extinction...THEN SO BE IT!', 14522, 1, 0, 0, 'Malygos PHASEEND 1'),
(28859, -1616013, 'Few have experienced the pain I will now inflict upon you!', 14523, 1, 0, 0, 'Malygos AGGRO 2'),
(28859, -1616014, 'YOU WILL NOT SUCCEED WHILE I DRAW BREATH!', 14518, 1, 0, 0, 'Malygos DEEP BREATH'),
(28859, -1616016, 'I will teach you IGNORANT children just how little you know of magic...', 14524, 1, 0, 0, 'Malygos ARCANE OVERLOAD'),
(28859, -1616020, 'Your energy will be put to good use!', 14526, 1, 0, 0, 'Malygos SLAY 2-1'),
(28859, -1616021, 'I AM THE SPELL-WEAVER! My power is INFINITE!', 14527, 1, 0, 0, 'Malygos SLAY 2-2'),
(28859, -1616022, 'Your spirit will linger here forever!', 14528, 1, 0, 0, 'Malygos SLAY 2-3'),
(28859, -1616017, 'ENOUGH! If you intend to reclaim Azeroth\'s magic, then you shall have it...', 14529, 1, 0, 0, 'Malygos PHASEEND 2'),
(28859, -1616018, 'Now your benefactors make their appearance...But they are too late. The powers contained here are sufficient to destroy the world ten times over! What do you think they will do to you?', 14530, 1, 0, 0, 'Malygos PHASE 3 INTRO'),
(28859, -1616019, 'SUBMIT!', 14531, 1, 0, 0, 'Malygos AGGRO 3'),
(28859, -1616026, 'The powers at work here exceed anything you could possibly imagine!', 14532, 1, 0, 0, 'Malygos STATIC FIELD'),
(28859, -1616023, 'Alexstrasza! Another of your brood falls!', 14534, 1, 0, 0, 'Malygos SLAY 3-1'),
(28859, -1616024, 'Little more then gnats!', 14535, 1, 0, 0, 'Malygos SLAY 3-2'),
(28859, -1616025, 'Your red allies will share your fate...', 14536, 1, 0, 0, 'Malygos SLAY 3-3'),
(28859, -1616027, 'Still standing? Not for long...', 14537, 1, 0, 0, 'Malygos SPELL 1'),
(28859, -1616028, 'Your cause is lost!', 14538, 1, 0, 0, 'Malygos SPELL 1'),
(28859, -1616029, 'Your fragile mind will be shattered!', 14539, 1, 0, 0, 'Malygos SPELL 1'),
(28859, -1616030, 'UNTHINKABLE! The mortals will destroy... e-everything... my sister... what have you-', 14540, 1, 0, 0, 'Malygos DEATH'),
(32295, -1616031, 'I did what I had to, brother. You gave me no alternative.', 14406, 1, 0, 0, 'Alexstrasza OUTRO 1'),
(32295, -1616032, 'And so ends the Nexus War.', 14407, 1, 0, 0, 'Alexstrasza OUTRO 2'),
(32295, -1616033, 'This resolution pains me deeply, but the destruction, the monumental loss of life had to end. Regardless of Malygos\' recent transgressions, I will mourn his loss. He was once a guardian, a protector. This day, one of the world\'s mightiest has fallen.', 14408, 1, 0, 0, 'Alexstrasza OUTRO 3'),
(32295, -1616034, 'The red dragonflight will take on the burden of mending the devastation wrought on Azeroth. Return home to your people and rest. Tomorrow will bring you new challenges, and you must be ready to face them. Life...goes on.', 14409, 1, 0, 0, 'Alexstrasza OUTRO 4');


/* ------------------------------------------------------------------------------------ Salle des reflets ------------------------------------------------------------------------------------------------*/

-- Halls of Reflection
-- Creature Templates 
UPDATE `creature_template` SET `speed_walk`='1.5', `speed_run`='2.0' WHERE `entry` in (36954, 37226);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_HRintro' WHERE `entry` in (37221, 37223);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_falric' WHERE `entry`=38112;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_marwyn' WHERE `entry`=38113;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_lich_king_hr' WHERE `entry`=36954;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_lich_king_hor' WHERE `entry`=37226;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_HRextro' WHERE `entry` in (36955, 37554);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_raging_gnoul' WHERE `entry`=36940;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_risen_witch_doctor' WHERE `entry`=36941;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_abon' WHERE `entry`=37069;
UPDATE `creature_template` SET `scale`='0.8', `equipment_id`='1221' WHERE `entry` in (37221, 36955);
UPDATE `creature_template` SET `equipment_id`='1290' WHERE `entry` in (37223, 37554);
UPDATE `creature_template` SET `equipment_id`='0' WHERE `entry`=36954;
UPDATE `creature_template` SET `scale`='1' WHERE `entry`=37223;
UPDATE `creature_template` SET `scale`='0.8' WHERE `entry` in (36658, 37225, 37223, 37226, 37554);
UPDATE `creature_template` SET `unit_flags`='768', `type_flags`='268435564' WHERE `entry` in (38177, 38176, 38173, 38172, 38567, 38175);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_frostworn_general' WHERE `entry`=36723;
UPDATE `creature_template` set `scale`='1' where `entry` in (37223);
UPDATE `instance_template` SET `script` = 'instance_hall_of_reflection' WHERE map=668;
UPDATE `gameobject_template` SET `faction`='1375' WHERE `entry` in (197341, 202302, 201385, 201596);
UPDATE `creature` SET `phaseMask` = 128 WHERE `id` = 36993; 
UPDATE `creature` SET `phaseMask` = 64 WHERE `id` = 36990; 
UPDATE `instance_template` SET `script` = 'instance_halls_of_reflection' WHERE map=668;
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1594540 AND -1594430;
INSERT INTO `script_texts` (`entry`,`content_default`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(-1594473, '<need translate>', 'Глупая девчонка! Тот кого ты ищещь давно убит! Теперь он лишь призрак, слабый отзвук в моем сознании!', 17229,1,0,0, '67234'),
(-1594474, '<need translate>', 'Я не повторю прежней ошибки, Сильвана. На этот раз тебе не спастись. Ты не оправдала моего доверия и теперь тебя ждет только забвение!', 17228,1,0,0, '67234'),
-- SCENE - Hall Of Reflection (Extro) - PreEscape
(-1594477, 'Your allies have arrived, Jaina, just as you promised. You will all become powerful agents of the Scourge.', 'Твои союзники прибыли, Джайна! Как ты и обещала... Ха-ха-ха-ха... Все вы станете могучими солдатами Плети...', 17212,1,0,0, '67234'),
(-1594478, 'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!', 'Я не повторю прежней ошибки, Сильвана! На этот раз тебе не спастись. Вы все будите служить мне после смерти...', 17213,1,0,0, '67234'),
(-1594479, 'He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!', 'Он слишком силен. Мы должны выбраться от сюда как можно скорее. Моя магия задержит его ненадолго, быстрее герои...', 16644,0,0,1, '67234'),
(-1594480, 'He\'s too powerful! Heroes, quickly, come to me! We must leave this place immediately! I will do what I can do hold him in place while we flee.', 'Он слишком силен. Герои скорее, за мной. Мы должны выбраться отсюда немедленно. Я постараюсь его задержать, пока мы будем убегать.', 17058,0,0,1, '67234'),
-- SCENE - Hall Of Reflection (Extro) - Escape
(-1594481, 'Death\'s cold embrace awaits.', 'Смерть распростерла ледяные обьятия!', 17221,1,0,0, '67234'),
(-1594482, 'Rise minions, do not left them us!', 'Восстаньте прислужники, не дайте им сбежать!', 17216,1,0,0, '67234'),
(-1594483, 'Minions sees them. Bring their corpses back to me!', 'Схватите их! Принесите мне их тела!', 17222,1,0,0, '67234'),
(-1594484, 'No...', 'Надежды нет!', 17214,1,0,0, '67234'),
(-1594485, 'All is lost!', 'Смирись с судьбой.', 17215,1,0,0, '67234'),
(-1594486, 'There is no escape!', 'Бежать некуда!', 17217,1,0,0, '67234'),
(-1594487, 'I will destroy this barrier. You must hold the undead back!', 'Я разрушу эту преграду, а вы удерживайте нежить на расстоянии!', 16607,1,0,0, '67234'),
(-1594488, 'No wall can hold the Banshee Queen! Keep the undead at bay, heroes! I will tear this barrier down!', 'Никакие стены не удержат Королеву Баньши. Держите нежить на расстоянии, я сокрушу эту преграду.', 17029,1,0,0, '67234'),
(-1594489, 'Another ice wall! Keep the undead from interrupting my incantation so that I may bring this wall down!', 'Опять ледяная стена... Я разобью ее, только не дайте нежити прервать мои заклинания...', 16608,1,0,0, '67234'),
(-1594490, 'Another barrier? Stand strong, champions! I will bring the wall down!', 'Еще одна преграда. Держитесь герои! Я разрушу эту стену!', 17030,1,0,0, '67234'),
(-1594491, 'Succumb to the chill of the grave.', 'Покоритесь Леденящей смерти!', 17218,1,0,0, '67234'),
(-1594492, 'Another dead end.', 'Вы в ловушке!', 17219,1,0,0, '67234'),
(-1594493, 'How long can you fight it?', 'Как долго вы сможете сопротивляться?', 17220,1,0,0, '67234'),
(-1594494, '<need translate>', 'Он с нами играет. Я  покажу ему что бывает когда лед встречается со огнем!', 16609,0,0,0, '67234'),
(-1594495, 'Your barriers can\'t hold us back much longer, monster. I will shatter them all!', 'Твои преграды больше не задержат нас, чудовище. Я смету их с пути!', 16610,1,0,0, '67234'),
(-1594496, 'I grow tired of these games, Arthas! Your walls can\'t stop me!', 'Я устала от этих игр Артас. Твои стены не остановят меня!', 17031,1,0,0, '67234'),
(-1594497, 'You won\'t impede our escape, fiend. Keep the undead off me while I bring this barrier down!', 'Ты не помешаешь нам уйти, монстр. Сдерживайте нежить, а я уничтожу эту преграду.', 17032,1,0,0, '67234'),
(-1594498, 'There\'s an opening up ahead. GO NOW!', 'Я вижу выход, скорее!', 16645,1,0,0, '67234'),
(-1594499, 'We\'re almost there... Don\'t give up!', 'Мы почти выбрались, не сдавайтесь!', 16646,1,0,0, '67234'),
(-1594500, 'There\'s an opening up ahead. GO NOW!', 'Я вижу выход, скорее!', 17059,1,0,0, '67234'),
(-1594501, 'We\'re almost there! Don\'t give up!', 'Мы почти выбрались, не сдавайтесь!', 17060,1,0,0, '67234'),
(-1594502, 'It... It\'s a dead end. We have no choice but to fight. Steel yourself heroes, for this is our last stand!', 'Больше некуда бежать. Теперь нам придется сражаться. Это наша последняя битва!', 16647,1,0,0, '67234'),
(-1594503, 'BLASTED DEAD END! So this is how it ends. Prepare yourselves, heroes, for today we make our final stand!', 'Проклятый тупик, значит все закончится здесь. Готовьтесь герои, это наша последняя битва.', 17061,1,0,0, '67234'),
(-1594504, 'Nowhere to run! You\'re mine now...', 'Ха-ха-ха... Бежать некуда. Теперь вы мои!', 17223,1,0,0, '67234'),
(-1594505, 'Soldiers of Lordaeron, rise to meet your master\'s call!', 'Солдаты Лордерона, восстаньте по зову Господина!', 16714,1,0,0, '67234'),
(-1594506, 'The master surveyed his kingdom and found it... lacking. His judgement was swift and without mercy. Death to all!', 'Господин осмотрел свое королевство и признал его негодным! Его суд был быстрым и суровым - предать всех смерти!', 16738,1,0,0, '67234'),
-- FrostWorn General
(-1594519, 'You are not worthy to face the Lich King!', 'Вы недостойны предстать перед Королем - Личом!', 16921,1,0,0, '67234'),
(-1594520, 'Master, I have failed...', 'Господин... Я подвел вас...', 16922,1,0,0, '67234');

-- Waipoints to escort event on Halls of reflection

DELETE FROM script_waypoint WHERE entry IN (36955,37226,37554);
INSERT INTO script_waypoint VALUES
-- Jaina

   (36955, 0, 5587.682,2228.586,733.011, 0, 'WP1'),
   (36955, 1, 5600.715,2209.058,731.618, 0, 'WP2'),
   (36955, 2, 5606.417,2193.029,731.129, 0, 'WP3'),
   (36955, 3, 5598.562,2167.806,730.918, 0, 'WP4 - Summon IceWall 01'), 
   (36955, 4, 5556.436,2099.827,731.827, 0, 'WP5 - Spell Channel'),
   (36955, 5, 5543.498,2071.234,731.702, 0, 'WP6'),
   (36955, 6, 5528.969,2036.121,731.407, 0, 'WP7'),
   (36955, 7, 5512.045,1996.702,735.122, 0, 'WP8'),
   (36955, 8, 5504.490,1988.789,735.886, 0, 'WP9 - Spell Channel'),
   (36955, 9, 5489.645,1966.389,737.653, 0, 'WP10'),
   (36955, 10, 5475.517,1943.176,741.146, 0, 'WP11'),
   (36955, 11, 5466.930,1926.049,743.536, 0, 'WP12'),
   (36955, 12, 5445.157,1894.955,748.757, 0, 'WP13 - Spell Channel'),
   (36955, 13, 5425.907,1869.708,753.237, 0, 'WP14'),
   (36955, 14, 5405.118,1833.937,757.486, 0, 'WP15'),
   (36955, 15, 5370.324,1799.375,761.007, 0, 'WP16'),
   (36955, 16, 5335.422,1766.951,767.635, 0, 'WP17 - Spell Channel'),
   (36955, 17, 5311.438,1739.390,774.165, 0, 'WP18'),
   (36955, 18, 5283.589,1703.755,784.176, 0, 'WP19'),
   (36955, 19, 5260.400,1677.775,784.301, 3000, 'WP20'),
   (36955, 20, 5262.439,1680.410,784.294, 0, 'WP21'),
   (36955, 21, 5260.400,1677.775,784.301, 0, 'WP22'),

-- Sylvana

   (37554, 0, 5587.682,2228.586,733.011, 0, 'WP1'),
   (37554, 1, 5600.715,2209.058,731.618, 0, 'WP2'),
   (37554, 2, 5606.417,2193.029,731.129, 0, 'WP3'),
   (37554, 3, 5598.562,2167.806,730.918, 0, 'WP4 - Summon IceWall 01'), 
   (37554, 4, 5556.436,2099.827,731.827, 0, 'WP5 - Spell Channel'),
   (37554, 5, 5543.498,2071.234,731.702, 0, 'WP6'),
   (37554, 6, 5528.969,2036.121,731.407, 0, 'WP7'),
   (37554, 7, 5512.045,1996.702,735.122, 0, 'WP8'),
   (37554, 8, 5504.490,1988.789,735.886, 0, 'WP9 - Spell Channel'),
   (37554, 9, 5489.645,1966.389,737.653, 0, 'WP10'),
   (37554, 10, 5475.517,1943.176,741.146, 0, 'WP11'),
   (37554, 11, 5466.930,1926.049,743.536, 0, 'WP12'),
   (37554, 12, 5445.157,1894.955,748.757, 0, 'WP13 - Spell Channel'),
   (37554, 13, 5425.907,1869.708,753.237, 0, 'WP14'),
   (37554, 14, 5405.118,1833.937,757.486, 0, 'WP15'),
   (37554, 15, 5370.324,1799.375,761.007, 0, 'WP16'),
   (37554, 16, 5335.422,1766.951,767.635, 0, 'WP17 - Spell Channel'),
   (37554, 17, 5311.438,1739.390,774.165, 0, 'WP18'),
   (37554, 18, 5283.589,1703.755,784.176, 0, 'WP19'),
   (37554, 19, 5260.400,1677.775,784.301, 3000, 'WP20'),
   (37554, 20, 5262.439,1680.410,784.294, 0, 'WP21'),
   (37554, 21, 5260.400,1677.775,784.301, 0, 'WP22'),

-- Lich King

   (37226, 0, 5577.187,2236.003,733.012, 0, 'WP1'),
   (37226, 1, 5587.682,2228.586,733.011, 0, 'WP2'),
   (37226, 2, 5600.715,2209.058,731.618, 0, 'WP3'),
   (37226, 3, 5606.417,2193.029,731.129, 0, 'WP4'),
   (37226, 4, 5598.562,2167.806,730.918, 0, 'WP5'), 
   (37226, 5, 5559.218,2106.802,731.229, 0, 'WP6'),
   (37226, 6, 5543.498,2071.234,731.702, 0, 'WP7'),
   (37226, 7, 5528.969,2036.121,731.407, 0, 'WP8'),
   (37226, 8, 5512.045,1996.702,735.122, 0, 'WP9'),
   (37226, 9, 5504.490,1988.789,735.886, 0, 'WP10'),
   (37226, 10, 5489.645,1966.389,737.653, 0, 'WP10'),
   (37226, 11, 5475.517,1943.176,741.146, 0, 'WP11'),
   (37226, 12, 5466.930,1926.049,743.536, 0, 'WP12'),
   (37226, 13, 5445.157,1894.955,748.757, 0, 'WP13'),
   (37226, 14, 5425.907,1869.708,753.237, 0, 'WP14'),
   (37226, 15, 5405.118,1833.937,757.486, 0, 'WP15'),
   (37226, 16, 5370.324,1799.375,761.007, 0, 'WP16'),
   (37226, 17, 5335.422,1766.951,767.635, 0, 'WP17'),
   (37226, 18, 5311.438,1739.390,774.165, 0, 'WP18'),
   (37226, 19, 5283.589,1703.755,784.176, 0, 'WP19'),
   (37226, 20, 5278.694,1697.912,785.692, 0, 'WP20'),
   (37226, 21, 5283.589,1703.755,784.176, 0, 'WP19');
   
   -- Fixed Halls of Reflection
DELETE FROM `gameobject_template` WHERE `entry` = 500001;
INSERT INTO `gameobject_template` VALUES ('500001', '0', '9214', 'Ice Wall', '', '', '', '1375', '0', '2.5', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '1'); 
DELETE FROM `creature` WHERE `id` IN (38112,37223,37221,36723,36955,37158,38113,37554,37226) AND `map` = 668;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`)
VALUES 
('38112', '668', '3', '1', '0', '0', '5276.81', '2037.45', '709.32', '5.58779', '604800', '0', '0', '377468', '0', '0', '0', '0', '0', '0'),
('37223', '668', '3', '64', '0', '0', '5266.78', '1953.42', '707.697', '0.740877', '7200', '0', '0', '6972500', '85160', '0', '0', '0', '0', '0'),
('37221', '668', '3', '128', '0', '0', '5266.78', '1953.42', '707.697', '0.740877', '7200', '0', '0', '5040000', '881400', '0', '0', '0', '0', '0'),
('36723', '668', '3', '1', '0', '0', '5413.84', '2116.44', '707.695', '3.88117', '7200', '0', '0', '315000', '0', '0', '0', '0', '0', '0'),
('36955', '668', '3', '128', '0', '0', '5547.27', '2256.95', '733.011', '0.835987', '7200', '0', '0', '252000', '881400', '0', '0', '0', '0', '0'),
('37158', '668', '3', '2', '0', '0', '5304.5', '2001.35', '709.341', '4.15073', '7200', '0', '0', '214200', '0', '0', '0', '0', '0', '0'),
('38113', '668', '3', '1', '0', '0', '5341.72', '1975.74', '709.32', '2.40694', '604800', '0', '0', '539240', '0', '0', '0', '0', '0', '0'),
('37554', '668', '3', '64', '0', '0', '5547.27', '2256.95', '733.011', '0.835987', '7200', '0', '0', '252000', '881400', '0', '0', '0', '0', '0'),
('37226', '668', '3', '1', '0', '0', '5551.29', '2261.33', '733.012', '4.0452', '604800', '0', '0', '27890000', '0', '0', '0', '0', '0', '0');
DELETE FROM `gameobject` WHERE `id` IN (202302,202236,201596,500001,196391,196392,202396,201885,197341,201976,197342,197343,201385,202212,201710,202337,202336,202079) AND `map`=668;
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`)
VALUES 
('202302', '668', '3', '1', '5309.51', '2006.64', '709.341', '5.50041', '0', '0', '0.381473', '-0.92438', '604800', '100', '1'),
('202236', '668', '3', '1', '5309.51', '2006.64', '709.341', '5.53575', '0', '0', '0.365077', '-0.930977', '604800', '100', '1'),
('201596', '668', '3', '1', '5275.28', '1694.23', '786.147', '0.981225', '0', '0', '0.471166', '0.882044', '25', '0', '1'),
('500001', '668', '3', '1', '5323.61', '1755.85', '770.305', '0.784186', '0', '0', '0.382124', '0.924111', '604800', '100', '1'),
('196391', '668', '3', '1', '5232.31', '1925.57', '707.695', '0.815481', '0', '0', '0.396536', '0.918019', '300', '0', '1'),
('196392', '668', '3', '1', '5232.31', '1925.57', '707.695', '0.815481', '0', '0', '0.396536', '0.918019', '300', '0', '1'),
('202396', '668', '3', '1', '5434.27', '1881.12', '751.303', '0.923328', '0', '0', '0.445439', '0.895312', '604800', '100', '1'),
('201885', '668', '3', '1', '5494.3', '1978.27', '736.689', '1.0885', '0', '0', '0.517777', '0.855516', '604800', '100', '1'),
('197341', '668', '3', '1', '5359.24', '2058.35', '707.695', '3.96022', '0', '0', '0.917394', '-0.397981', '300', '100', '1'),
('201976', '668', '3', '1', '5264.6', '1959.55', '707.695', '0.736951', '0', '0', '0.360194', '0.932877', '300', '100', '0'),
('197342', '668', '3', '1', '5520.72', '2228.89', '733.011', '0.778581', '0', '0', '0.379532', '0.925179', '300', '100', '1'),
('197343', '668', '3', '1', '5582.96', '2230.59', '733.011', '5.49098', '0', '0', '0.385827', '-0.922571', '300', '100', '1'),
('201385', '668', '3', '1', '5540.39', '2086.48', '731.066', '1.00057', '0', '0', '0.479677', '0.877445', '604800', '100', '1'),
('202212', '668', '1', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('201710', '668', '1', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('202337', '668', '2', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('202336', '668', '2', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('202079', '668', '3', '1', '5250.96', '1639.36', '784.302', '0', '0', '0', '0', '0', '-604800', '100', '1');
UPDATE `creature_template` SET `gossip_menu_id` = 11031 WHERE `entry` = 37223;

/* ------------------------------------------------------------------------------- Raid edc ---------------------------------------------------------------------------------------------------*/
DELETE FROM `gameobject` WHERE guid = 3488594;
REPLACE INTO `gameobject` VALUES
(500000,195527,649,15,1,563.678,177.284,398.621,1.57047,0,0,0,0,0,100,0), -- Argent Coliseum Floor 
(500001,195647,649,15,1,563.678,199.329,394.766,1.58619,0,0,0,0,0,100,1), -- Main Gate 
(500002,195650,649,15,1,624.656,139.342,395.261,0.00202179,0,0,0,0,0,100,1), -- South Portcullis 
(500003,195648,649,15,1,563.671,78.459,395.261,4.69083,0,0,0,0,0,100,0), -- East Portcullis 
(500004,195649,649,15,1,502.674,139.302,395.26,3.14933,0,0,0,0,0,100,1), -- North Portcullis 
(500046,195594,649,1,1,563.72,77.1442,396.336,1.559,0,0,0.715397,-0.698718,300,0,1), -- Portal 10 normal 
(500048,195595,649,2,1,563.72,77.1442,396.336,1.559,0,0,0.715397,-0.698718,300,0,1), -- Portal 25 normal 
(500050,195596,649,8,1,563.72,77.1442,396.336,1.559,0,0,0.715397,-0.698718,300,0,1), -- Portal 25 hc 
(500052,195593,649,4,1,563.72,77.1442,396.336,1.559,0,0,0.715397,-0.698718,300,0,1); -- Portal 10 hc 

-- Creatures 
REPLACE INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(604905,34990,649,15,1,0,0,624.633,139.386,418.209,3.15008,300,0,0,8367000,0,0,0), -- King Varian Wrynn 
(604903,34996,649,15,1,0,547,563.697,78.3457, 418.21,1.55937,300,0,0,13945000,4258,0,0), -- Hight Lord Tirion Fordring 
(604907,34995,649,15,1,0,0,502.825,139.407,418.211,0.0163429,300,0,0,1394500,0,0,0), -- Garrosh Hellscream 
(604911,34816,649,15,1,0,0,556.27,89.0785,395.241,1.05514,300,0,0,126000,0,0,0), -- Barrett Ramsey 
(504913,34564,649,15,1,0,0,783.237,133.477,142.576,3.06614,300,0,0,4183500,0,0,0); -- Anubarak 

-- Texts (yells) 
SET @id := -1760000;
DELETE FROM `script_texts` WHERE `entry` BETWEEN @id-76 AND @id;
INSERT INTO `script_texts` (npc_entry, entry, content_default, sound, type, language, emote, comment) VALUES
(34995, @id, "Welcome champions, you have heard the call of the Argent Crusade and you have boldly answered. It is here in the crusaders coliseum that you will face your greatest challenges. Those of you who survive the rigors of the coliseum will join the Argent Crusade on its marsh to ice crown citadel.", 16036, 1, 0, 0, "Trial of the Crusader - welcome"),
(36095, @id-1, "Hailing from the deepest, darkest carverns of the storm peaks, Gormok the Impaler! Battle on, heroes!", 16038, 1, 0, 0, "Gormok the Impaler - intro"),
(36095, @id-2, "Steel yourselves, heroes, for the twin terrors Acidmaw and Dreadscale. Enter the arena!", 16039, 1, 0, 0, "Acidmaw and Dreadscale - intro"),
(34799, @id-3, "At its companion perishes, %s becomes enraged!", 0, 3, 0, 0, "Acidmaws adn dreadscales enrage emote"),
(36095, @id-4, "The air freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!", 16040, 1, 0, 0, "Icehowl - intro"),
(34995, @id-5, "The monstrous menagerie has been vanquished!", 16041, 1, 0, 0, "Beasts of Northrend - victory"),
(36095, @id-6, "Tragic... They fought valiantly, but the beasts of Northrend triumphed. Let us observe a moment of silence for our fallen heroes.", 16042, 1, 0, 0, "Raid wipe"),
(36095, @id-7, "Grand Warlock Wilfred Fizzlebang will summon forth your next challenge. Stand by for his entry!", 16043, 1, 0, 0, "Lord Jaraxxus - intro"),
(35458, @id-8, "Thank you, Highlord! Now challengers, I will begin the ritual of summoning! When I am done, a fearsome Doomguard will appear!", 16268, 1, 0, 0, "Lord Jaraxxus - intro2"),
(35458, @id-9, "Prepare for oblivion!", 16269, 1, 0, 0, "Wilfred Fizzlebang - summoning"),
(35458, @id-10, "Ah ha! Behold the absolute power of Wilfred Fizzlebang, master summoner! You are bound to ME, demon!", 16270, 1, 0, 0, "Lord Jaraxxus - portal"),
(34780, @id-11, "Trifling gnome, your arrogance will be your undoing!", 16143, 1, 0, 0, "Lord Jaraxxus - intro3"),
(35458, @id-12, "But I'm in charge her-", 16271, 1, 0, 0, "Wilfred Fizzlebang - die"),
(36095, @id-13, "Quickly, heroes! Destroy the demon lord before it can open a portal to its twisted demonic realm!", 16044, 1, 0, 0, "Lord Jaraxxus - intro4"),
(34780, @id-14, "You face Jaraxxus, eredar lord of the Burning Legion!", 16144, 1, 0, 0, "Lord Jaraxxus - aggro"),
(34780, @id-15, "FLESH FROM BONE!", 16149, 1, 0, 0, "Lord Jaraxxus - Incinerate Flesh"),
(34780, @id-16, "$n has |cFF00FFFFIncinerate flesh!|R Heal $ghim:her;!", 0, 3, 0, 0, "Lord Jaraxxus - incinerate flesh's emote for players"),
(34780, @id-17, "Come forth, sister! Your master calls!", 16150, 1, 0, 0, "Lord Jaraxxus - Summoning Mistress of Pain"),
(34780, @id-18, "INFERNO!", 16151, 1, 0, 0, "Lord Jaraxxus - Summoning Infernals"),
(34780, @id-19, "Insignificant gnat!", 16145, 1, 0, 0, "Lord Jaraxxus - killing a player1"),
(34780, @id-20, "Banished to the Nether!", 16146, 1, 0, 0, "Lord Jaraxxus - killing a player2"),
(34780, @id-21, "Another will take my place. Your world is doomed.", 16147, 1, 0, 0, "Lord Jaraxxus - death"),
(36095, @id-22, "The loss of Wilfred Fizzlebang, while unfortunate, should be a lesson to those that dare dabble in dark magic. Alas, you are victorious and must now face the next challenge.", 16045, 1, 0, 0, "Lord Jaraxxus - outro"),
(34995, @id-23, "Treacherous Alliance dogs! You summon a demon lord against warriors of the Horde!? Your deaths will be swift!", 16021, 1, 0, 0, "Garrosh Hellscream - Jaraxxus outro"),
(34990, @id-24, "The Alliance doesn't need the help of a demon lord to deal with Horde filth. Come, pig!", 16064, 1, 0, 0, "Varian Wrynn - Jaraxxus outro"),
(36095, @id-25, "Everyone, calm down! Compose yourselves! There is no conspiracy at play here. The warlock acted on his own volition - outside of influences from the Alliance. The tournament must go on!", 16046, 1, 0, 0, "Lord Jaraxxus - intro"),
(36095, @id-26, "The next battle will be against the Argent Crusade's most powerful knights! Only by defeating them will you be deemed worthy...", 16047, 1, 0, 0, "Faction Champions - intro"),
(34995, @id-27, "The Horde demands justice! We challenge the Alliance. Allow us to battle in place of your knights, paladin. We will show these dogs what it means to insult the Horde!", 16023, 1, 0, 0, "Faction Champions - intro2, Ally"),
(34990, @id-28, "Our honor has been besmirched! They make wild claims and false accusations against us. I demand justice! Allow my champions to fight in place of your knights, Tirion. We challenge the Horde!", 16066, 1, 0, 0, "Faction Champions - intro2, Horda"),
(36095, @id-29, "Very well, I will allow it. Fight with honor!", 16048, 1, 0, 0, "Faction Champions - intro3"),
(34995, @id-30, "Show them no mercy, Horde champions! LOK'TAR OGAR!", 16022, 1, 0, 0, "Faction Champions - intro4, Ally"),
(34995, @id-31, "Fight for the glory of the Alliance, heroes! Honor your king and your people!", 16065, 1, 0, 0, "Faction Champions - intro4, Horda"),
(34995, @id-32, "Weakling!", 16017, 1, 0, 0, "Faction Champions - killing an alliance player1"),
(34995, @id-33, "Pathetic!", 16018, 1, 0, 0, "Faction Champions - killing an alliance player2"),
(34995, @id-34, "Overpowered.", 16019, 1, 0, 0, "Faction Champions - killing an alliance player3"),
(34995, @id-35, "Lok'tar!", 16020, 1, 0, 0, "Faction Champions - killing an alliance player4"),
(34990, @id-36, "HAH!", 16060, 1, 0, 0, "Faction Champions - killing an horde player1"),
(34990, @id-37, "Hardly a challenge!", 16061, 1, 0, 0, "Faction Champions - killing an horde player2"),
(34990, @id-38, "Worthless scrub.", 16062, 1, 0, 0, "Faction Champions - killing an horde player3"),
(34990, @id-39, "Is this the best the Horde has to offer?", 16063, 1, 0, 0, "Faction Champions - killing an horde player4"),
(34990, @id-40, "Glory to the Alliance!", 16067, 1, 0, 0, "Faction Champions - victory as ally"),
(34995, @id-41, "That was just a taste of what the future brings. FOR THE HORDE!", 16024, 1, 0, 0, "Faction Champions - victory as horde"),
(36095, @id-42, "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death.", 16049, 1, 0, 0, "Faction Champions - outro"),
(36095, @id-43, "Only by working together will you overcome the final challenge. From the depths of Icecrown come two of the Scourge's most powerful lieutenants: fearsome val'kyr, winged harbingers of the Lich King!", 16050, 1, 0, 0, "Twin Valkyrs - intro"),
(36095, @id-44, "Let the games begin!", 16037, 1, 0, 0, "Twin Valkyrs - intro2"),
(34497, @id-45, "In the name of our dark master. For the Lich King. You. Will. Die.", 16272, 1, 0, 0, "Fjola - aggro"),
(34496, @id-46, "In the name of our dark master. For the Lich King. You. Will. Die.", 16272, 1, 0, 0, "Eydis - aggro"),
(34497, @id-47, "CHAOS!", 16274, 1, 0, 0, "Fjola - casting twins pact"),
(34496, @id-48, "CHAOS!", 16274, 1, 0, 0, "Eydis - casting twins pact"),
(34497, @id-49, "Let the dark consume you!", 16278, 1, 0, 0, "Fjola - casting dark vortex"),
(34496, @id-50, "Let the dark consume you!", 16278, 1, 0, 0, "Eydis - casting dark vortex"),
(34497, @id-51, "Let the light consume you!", 16279, 1, 0, 0, "Fjola - casting light vortex"),
(34496, @id-52, "Let the light consume you!", 16279, 1, 0, 0, "Eydis - casting light vortex"),
(34497, @id-53, "UNWORTHY!", 16277, 1, 0, 0, "Fjola - killing a player1"),
(34496, @id-54, "UNWORTHY!", 16277, 1, 0, 0, "Eydis - kiling a player1"),
(34497, @id-56, "You have been measured, and found wanting!", 16276, 1, 0, 0, "Fjola - killing a player2"),
(34496, @id-57, "You have been measured, and found wanting!", 16276, 1, 0, 0, "Eydis - kiling a player2"),
(34497, @id-58, "You are finished!", 16273, 1, 0, 0, "Fjola - berserk"),
(34496, @id-59, "You are finished!", 16273, 1, 0, 0, "Eydis - berserk"),
(34497, @id-60, "The Scourge cannot be stopped...", 16275, 1, 0, 0, "Fjola - death"),
(34496, @id-61, "The Scourge cannot be stopped...", 16275, 1, 0, 0, "Eydis - death"),
(34995, @id-62, "Do you still question the might of the Horde, paladin? We will take on all comers!", 16025, 1, 0, 0, "Twin Valkyrs - victory as horde"),
(34990, @id-63, "Not even the Lich King most powerful minions can stand against the Alliance! All hail our victors!", 16068, 1, 0, 0, "Twin Valkyrs - victory as alliance"),
(36095, @id-64, "A mighty blow has been dealt to the Lich King! You have proven yourselves as able bodied champions of the Argent Crusade. Together we will strike at Icecrown Citadel and destroy what remains of the Scourge! There is no challenge that we cannot face united!", 16051, 1, 0, 0, "Anub'arak - intro1"),
(35877, @id-65, "You will have your challenge, Fordring.", 16321, 1, 0, 0, "Anub'arak - intro2"),
(36095, @id-66, "Arthas! You are hopelessly outnumbered! Lay down Frostmourne and I will grant you a just death.", 16052, 1, 0, 0, "Anub'arak - intro3"),
(35877, @id-67, "The Nerubians built an empire beneath the frozen wastes of Northrend. An empire that you so foolishly built your structures upon. MY EMPIRE.", 16322, 1, 0, 0, "Anub'arak - intro4"),
(35877, @id-68, "The souls of your fallen champions will be mine, Fordring.", 16323, 1, 0, 0, "Anub'arak - intro5"),
(34564, @id-69, "Ahhh... Our guests arrived, just as the master promised.", 16235, 1, 0, 0, "Anub'arak - intro6"),
(34564, @id-70, "This place will serve as your tomb!", 16234, 1, 0, 0, "Anub'arak - aggro"),
(34564, @id-71, "Auum na-l ak-k-k-k, isshhh. Rise, minions. Devour...", 16240, 1, 0, 0, "Anub'arak - submerge"),
(34564, @id-72, "The swarm shall overtake you!", 16241, 1, 0, 0, "Anub'arak - leeching swarm"),
(34564, @id-73, "F-lakkh shir!", 16236, 1, 0, 0, "Anub'arak - killing a player1"),
(34564, @id-74, "Another soul to sate the host.", 16237, 1, 0, 0, "Anub'arak - killing a player2"),
(34564, @id-75, "I have failed you, master....", 16238, 1, 0, 0, "Anub'arak - death"),
(36095, @id-76, "Champions, you're alive! Not only have you defeated every challenge of the Trial of the Crusader, but thwarted Arthas directly! Your skill and cunning will prove to be a powerful weapon against the Scourge. Well done! Allow one of my mages to transport you back to the surface!", 0, 1, 0, 0, "Anub'arak - outro");

-- Creature/Instance Templates 
UPDATE creature_template SET ScriptName="boss_gormok_the_impaler" WHERE entry=34796; -- gormok the impaler
UPDATE creature_template SET ScriptName="boss_acidmaw" WHERE entry=35144; -- acidmaw
UPDATE creature_template SET ScriptName="boss_dreadscale" WHERE entry=34799; -- dreascale
UPDATE creature_template SET scriptname="mob_slime_pool" WHERE entry = 35176; -- slime pool - acidmaw's and dreadscale's add
UPDATE creature_template SET ScriptName="boss_icehowl" WHERE entry=34797; -- icehowl
UPDATE creature_template SET ScriptName="mob_snobold" WHERE entry=34800; -- Snobold
UPDATE creature_template SET ScriptName="boss_lord_jaraxxus" WHERE entry=34780; -- Lord Jaraxxus 
UPDATE creature_template SET scriptname="mob_misstress_of_pain" WHERE entry=34826; -- Misstress of pain (Jaraxxus' add)
UPDATE creature_template SET scriptname="mob_felflame_infernal" WHERE entry=34815; -- Felflame Infernal (Jaraxxus' add)
UPDATE creature_template SET scriptname="mob_jaraxxus_vulcan" WHERE entry=34813; -- Vulcan, summoned by Lord Jaraxxus, summoning Felflame Infernals
UPDATE creature_template SET scriptname="mob_jaraxxus_portal" WHERE entry=34825; -- Nether Portal, summoned by Lord Jaraxxus, summonig Misstress of pain
UPDATE creature_template SET scriptname="mob_legion_flame" WHERE entry = 34784; -- Jaraxxus' spell's effect - summon legion fire, deal damage every sec

UPDATE creature_template SET scriptname="mob_toc_warrior" WHERE entry IN (34475,34453);
UPDATE creature_template SET scriptname="mob_toc_mage" WHERE entry IN (34468,34449);
UPDATE creature_template SET scriptname="mob_toc_shaman" WHERE entry IN (34470,34444);
UPDATE creature_template SET scriptname="mob_toc_enh_shaman" WHERE entry IN (34463,34455);
UPDATE creature_template SET scriptname="mob_toc_hunter" WHERE entry IN (34467,34448);
UPDATE creature_template SET scriptname="mob_toc_rogue" WHERE entry IN (34472,34454);
UPDATE creature_template SET scriptname="mob_toc_priest" WHERE entry IN (34466,34447);
UPDATE creature_template SET scriptname="mob_toc_shadow_priest" WHERE entry IN (34473,34441);
UPDATE creature_template SET scriptname="mob_toc_dk" WHERE entry IN (34461,34458);
UPDATE creature_template SET scriptname="mob_toc_paladin" WHERE entry IN (34465,34445);
UPDATE creature_template SET scriptname="mob_toc_retro_paladin" WHERE entry IN (34471,34456);
UPDATE creature_template SET scriptname="mob_toc_druid" WHERE entry IN (34469,34459);
UPDATE creature_template SET scriptname="mob_toc_boomkin" WHERE entry IN (34460,34451);
UPDATE creature_template SET scriptname="mob_toc_warlock" where entry IN (34474,34450);
UPDATE creature_template SET scriptname="mob_toc_pet_warlock" WHERE entry IN (35465);
UPDATE creature_template SET scriptname="mob_toc_pet_hunter" WHERE entry IN (35610);

UPDATE creature_template SET ScriptName="boss_light_twin" WHERE entry=34497; -- Fjola Lightbane 
UPDATE creature_template SET ScriptName="boss_dark_twin" WHERE entry=34496; -- Eydis Darkbane 
UPDATE creature_template SET ScriptName="light_essence" WHERE entry=34568; -- Light Essence (twins' fight) 
UPDATE creature_template SET ScriptName="dark_essence" WHERE entry=34567; -- Dark Essence (twins' fight) 
UPDATE creature_template SET ScriptName="mob_concetrated_light" WHERE entry=34630; -- Concentrated Light (twins' fight) 
UPDATE creature_template SET ScriptName="mob_concetrated_dark" WHERE entry=34628; -- Concentrated Dark (twins' fight) 
UPDATE creature_template SET ScriptName="boss_anubarak_trial" WHERE entry=34564; -- Anubarak 
UPDATE creature_template SET ScriptName="mob_swarm_scarab" WHERE entry=34605; -- Anub's adds 
UPDATE creature_template SET ScriptName="mob_nerubian_burrower" WHERE entry=34607; -- Anub's adds 
UPDATE creature_template SET scriptname="mob_anubarak_spike" WHERE entry=34660;
UPDATE creature_template SET ScriptName="mob_frost_sphere" WHERE entry = 34606;
UPDATE creature_template SET ScriptName="toc_tirion_fordring" WHERE entry=34996; -- Tirion Fordring 
UPDATE creature_template SET ScriptName="toc_barrett_ramsey" WHERE entry=34816; -- Barrett Ramsey (Arena Master) 
UPDATE instance_template SET script="instance_trial_of_the_crusader" WHERE map=649; -- Instance 

-- Additional 
UPDATE creature_template SET npcflag=1 WHERE entry IN(34816, 3481601, 3481602, 3481603, 34568, 3456801, 3456802, 3456803, 34567, 3456701, 3456702, 3456703); -- Make Barrett Ramsey, Dark and Light Essenes gossip creatures 
UPDATE creature_template SET IconName="Interact" WHERE entry IN(34568, 3456801, 3456802, 3456803, 34567, 3456701, 3456702, 3456703); -- Change white chat bubble on interaction wheel when mouse-overing Light and Dark Essences 
UPDATE creature_template SET unit_flags=4 WHERE entry IN(34813, 3481301, 3481302, 3481303, 34825, 3482501, 3482502, 3482503); -- Disable move for Jaraxxus' portals and vulcans 
UPDATE creature_template SET unit_flags=unit_flags|4 WHERE entry in (34784, 3478401, 3478402, 3478403); -- Disable move for Jaraxxus' spell's Legion Fire 
UPDATE creature_template SET modelid1=30039, modelid2=30039 where entry IN (348125, 3482501, 3482502, 3482503);  -- Set correct model for Jaraxxus' portal 
UPDATE creature_template SET faction_A=189, faction_H=189 WHERE entry IN (34605, 3460501, 3460502, 3460503); -- Make swarm scarab's neutral for players, faction switch implemented in anub's script 
UPDATE creature_template SET flags_extra=2 WHERE entry IN (34630, 3463001, 3463002, 3463003, 34628, 3462801, 3462802, 3462803); -- Makes Concentraded Energies ignore aggro 

-- Loot and Tribute Chests (from TC forum, thanks Gyullo) 
-- Chest Templates (this are for 10 Heroic)
DELETE FROM `gameobject_loot_template` WHERE entry IN (195665,195666,195667,195668,195669,195670,195671,195672);
DELETE FROM `gameobject_template` WHERE entry IN (195665,195666,195667,195668);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
(195665, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27514, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195666, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27515, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195667, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27516, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195668, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27513, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723);

-- Chest Templates (this are for 25 Heroic)
DELETE FROM `gameobject_template` WHERE entry IN (195669,195670,195671,195672);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
(195669, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27512, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195670, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27517, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195671, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27518, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195672, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27511, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723);

-- 10H mode (1-24 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27513;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27513,47242,100,1,0,2,2), -- 2 Trophys
(27513,47556,100,1,0,1,1); -- 1 Crusader Orb

-- 10H mode (25-44 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27514;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27514,47242,100,1,0,2,2), -- 2 Trophys
(27514,47556,100,1,0,1,1), -- 1 Crusader Orb
-- Alliance Loot (Handdle by conditions)
(27514,48713,0,1,1,1,1),
(27514,48711,0,1,1,1,1),
(27514,48712,0,1,1,1,1),
(27514,48714,0,1,1,1,1),
(27514,48709,0,1,1,1,1),
(27514,48710,0,1,1,1,1),
(27514,48708,0,1,1,1,1),
-- Horde Loot (Handdle by conditions)
(27514,48695,0,1,2,1,1),
(27514,48697,0,1,2,1,1),
(27514,48703,0,1,2,1,1),
(27514,48699,0,1,2,1,1),
(27514,48693,0,1,2,1,1),
(27514,48705,0,1,2,1,1),
(27514,48701,0,1,2,1,1);

-- 10H mode (45-49 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27515;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27515,47242,100,1,0,4,4), -- 4 Trophys
(27515,47556,100,1,0,1,1), -- 1 Crusader Orb
-- Alliance Loot (Handdle by conditions)
(27515,48713,0,1,1,1,1),
(27515,48711,0,1,1,1,1),
(27515,48712,0,1,1,1,1),
(27515,48714,0,1,1,1,1),
(27515,48709,0,1,1,1,1),
(27515,48710,0,1,1,1,1),
(27515,48708,0,1,1,1,1),
-- Horde Loot (Handdle by conditions)
(27515,48695,0,1,2,1,1),
(27515,48697,0,1,2,1,1),
(27515,48703,0,1,2,1,1),
(27515,48699,0,1,2,1,1),
(27515,48693,0,1,2,1,1),
(27515,48705,0,1,2,1,1),
(27515,48701,0,1,2,1,1);

-- 10H mode (50 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27516;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27516,47242,100,1,0,4,4), -- 4 Trophys
(27516,47556,100,1,0,1,1), -- 1 Crusader Orb
-- Alliance Loot (Handdle by conditions)
(27516,48713,0,1,1,1,1),
(27516,48711,0,1,1,1,1),
(27516,48712,0,1,1,1,1),
(27516,48714,0,1,1,1,1),
(27516,48709,0,1,1,1,1),
(27516,48710,0,1,1,1,1),
(27516,48708,0,1,1,1,1),
-- Horde Loot (Handdle by conditions)
(27516,48695,0,1,2,1,1),
(27516,48697,0,1,2,1,1),
(27516,48703,0,1,2,1,1),
(27516,48699,0,1,2,1,1),
(27516,48693,0,1,2,1,1),
(27516,48705,0,1,2,1,1),
(27516,48701,0,1,2,1,1),
-- Second Alliance Loot (Handdle by conditions)
(27516,49044,100,1,0,1,1),
(27516,48673,0,1,3,1,1),
(27516,48675,0,1,3,1,1),
(27516,48674,0,1,3,1,1),
(27516,48671,0,1,3,1,1),
(27516,48672,0,1,3,1,1),
-- Second Horde Loot (Handdle by conditions)
(27516,49046,100,1,0,1,1),
(27516,48668,0,1,4,1,1),
(27516,48670,0,1,4,1,1),
(27516,48669,0,1,4,1,1),
(27516,48666,0,1,4,1,1),
(27516,48667,0,1,4,1,1);

SET @RefTribute := 51000;

DELETE FROM `reference_loot_template` WHERE entry=@RefTribute;
DELETE FROM `reference_loot_template` WHERE entry=47557;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@RefTribute,47557,0,1,1,1,1),
(@RefTribute,47558,0,1,1,1,1),
(@RefTribute,47559,0,1,1,1,1);

-- 25H mode (1-24 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27511;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27511,1,100,1,0,-@RefTribute,2); -- 2 Tokens

-- 25H mode (25-44 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27512;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27512,1,100,1,0,-@RefTribute,2), -- 2 Tokens

-- Alliance Loot (Handdle by conditions)
(27512,47521,0,1,1,1,1),
(27512,47526,0,1,1,1,1),
(27512,47519,0,1,1,1,1),
(27512,47524,0,1,1,1,1),
(27512,47517,0,1,1,1,1),
(27512,47506,0,1,1,1,1),
(27512,47515,0,1,1,1,1),

-- Horde Loot (Handdle by conditions)
(27512,47523,0,1,2,1,1),
(27512,47528,0,1,2,1,1),
(27512,47520,0,1,2,1,1),
(27512,47525,0,1,2,1,1),
(27512,47518,0,1,2,1,1),
(27512,47513,0,1,2,1,1),
(27512,47516,0,1,2,1,1);

-- 25H mode (45-49 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27517;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27517,1,100,1,0,-@RefTribute,2), -- 2 Tokens
(27517,2,100,1,0,-@RefTribute,2), -- 2 Tokens

-- Alliance Loot (Handdle by conditions)
(27517,47521,0,1,1,1,1),
(27517,47526,0,1,1,1,1),
(27517,47519,0,1,1,1,1),
(27517,47524,0,1,1,1,1),
(27517,47517,0,1,1,1,1),
(27517,47506,0,1,1,1,1),
(27517,47515,0,1,1,1,1),

-- Horde Loot (Handdle by conditions)
(27517,47523,0,1,2,1,1),
(27517,47528,0,1,2,1,1),
(27517,47520,0,1,2,1,1),
(27517,47525,0,1,2,1,1),
(27517,47518,0,1,2,1,1),
(27517,47513,0,1,2,1,1),
(27517,47516,0,1,2,1,1);

-- 25H mode (50 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27518;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- (27518,1,100,1,0,-@RefTribute,2), -- 2 Tokens
-- (27518,2,100,1,0,-@RefTribute,2), -- 2 Tokens
-- Alliance Loot (Handdle by conditions)
(27518,47521,0,1,1,1,1),
(27518,47526,0,1,1,1,1),
(27518,47519,0,1,1,1,1),
(27518,47524,0,1,1,1,1),
(27518,47517,0,1,1,1,1),
(27518,47506,0,1,1,1,1),
(27518,47515,0,1,1,1,1),
-- Horde Loot (Handdle by conditions)
(27518,47523,0,1,2,1,1),
(27518,47528,0,1,2,1,1),
(27518,47520,0,1,2,1,1),
(27518,47525,0,1,2,1,1),
(27518,47518,0,1,2,1,1),
(27518,47513,0,1,2,1,1),
(27518,47516,0,1,2,1,1),
-- Second Alliance Loot (Handdle by conditions)
(27518,49096,100,1,0,1,1),
(27518,47553,0,1,3,1,1),
(27518,47552,0,1,3,1,1),
(27518,47549,0,1,3,1,1),
(27518,47547,0,1,3,1,1),
(27518,47545,0,1,3,1,1),
-- Second Horde Loot (Handdle by conditions)
(27518,49098,100,1,0,1,1),
(27518,47554,0,1,4,1,1),
(27518,47551,0,1,4,1,1),
(27518,47550,0,1,4,1,1),
(27518,47548,0,1,4,1,1),
(27518,47546,0,1,4,1,1);

-- Achievements criteria (thanks Gyullo) 
-- 10 Normal
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11684,11685,11686,11687,11688);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Crusade (10 player)
(11684,12,0,0),
(11685,12,0,0),
(11686,12,0,0),
(11687,12,0,0),
(11688,12,0,0);

-- 10 Hero
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11690,11689,11682,11693,11691);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Grand Crusade (10 player)
(11690,12,2,0),
(11689,12,2,0),
(11682,12,2,0),
(11693,12,2,0),
(11691,12,2,0);

-- 25 normal
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11679,11683,11680,11682,11681);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Crusade (25 player)
(11679,12,1,0),
(11683,12,1,0),
(11680,12,1,0),
(11682,12,1,0),
(11681,12,1,0);

-- 25 Hero
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11542,11546,11547,11549,11678,12350);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Grand Crusade (25 player)
(11542,12,3,0),
(11546,12,3,0),
(11547,12,3,0),
(11549,12,3,0),
(11678,12,3,0),
-- Realm First! Grand Crusader
(12350,12,3,0);

UPDATE creature_template SET mechanic_immune_mask=1|2|4|8|16|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|8388608|67108864|536870912 WHERE entry IN
(34796, 3479601, 3479602, 3479603,
 35144, 3514401, 3514402, 3514403,
 34799, 3479901, 3479902, 3479903,
 34797, 3479701, 3479702, 3479703,
 34780, 3478001, 3478002, 3478003,
 34497, 3449701, 3449702, 3449703,
 34496, 3449601, 3449602, 3449603,
 34564, 3456401, 3456402, 3456403,
 34800, 3480001, 3480002, 3480003);

-- Last StartUP error fix. 
UPDATE creature_template SET ScriptName="mob_cat" WHERE entry=35610;

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1649999 AND -1649000;
INSERT INTO `script_texts`
(`comment`,`sound`, `entry`,`type`,`language`,`emote`,`content_default`) VALUES
-- Northrend Beasts
-- Gormok
('34796','0','-1649000','3','0','0','My slaves! Destroy the enemy!'),
-- Acidmaw & Dreadscale
('34564','0','-1649010','3','0','0','%s buries itself in the earth!'),
('34564','0','-1649011','3','0','0','%s getting out of the ground!'),
('34799','0','-1649012','3','0','0','At its companion perishes, %s becomes enraged!'),
-- Icehowl
('34797','0','-1649020','3','0','0','%s looks at |3-3($n) and emits a guttural howl!'),
('34797','0','-1649021','3','0','0','%s crashes into a wall of the Colosseum and lose focus!'),
('34797','0','-1649022','3','0','0','|3-3(%s) covers boiling rage, and he tramples all in its path!'),
-- Jaraxxus
('34780','16143','-1649030','1','0','0','Trifling gnome, your arrogance will be your undoing!'),
('34780','16144','-1649031','1','0','0','You face Jaraxxus, eredar lord of the Burning Legion!'),
('34780','16147','-1649032','1','0','0','Another will take my place. Your world is doomed.'),
('34780','0','-1649033','3','0','0','$n has |cFF00FFFFIncinerate flesh!|R Heal $ghim:her;!'),
('34780','16149','-1649034','1','0','0','FLESH FROM BONE!'),
('34780','0','-1649035','3','0','0','|cFFFF0000Legion Flame|R on $n'),
('34780','0','-1649036','3','0','0','%s creates the gates of the Void!'),
('34780','16150','-1649037','1','0','0','Come forth, sister! Your master calls!'),
('34780','0','-1649038','3','0','0','%s creates an |cFF00FF00Infernal Volcano!|R'),
('34780','16151','-1649039','1','0','0','INFERNO!'),
-- Faction Champions
('34995','0','-1649115','1','0','0','Weakling!'),
('34995','0','-1649116','1','0','0','Pathetic!'),
('34995','0','-1649117','1','0','0','Overpowered.'),
('34995','0','-1649118','1','0','0','Lok\'tar!'),
('34990','0','-1649120','1','0','0','HAH!'),
('34990','0','-1649121','1','0','0','Hardly a challenge!'),
('34990','0','-1649122','1','0','0','Worthless scrub.'),
('34990','0','-1649123','1','0','0','Is this the best the Horde has to offer?'),
-- Twin Valkyrs
('34497','16272','-1649040','1','0','0','In the name of our dark master. For the Lich King. You. Will. Die.'),
('34496','16275','-1649041','1','0','0','The Scourge cannot be stopped...'),
('34497','16273','-1649042','1','0','0','YOU ARE FINISHED!'),
('34497','0','-1649043','3','0','0','%s begins to read the spell Treaty twins!'),
('34497','16274','-1649044','3','0','0','CHAOS!'),
('34496','16277','-1649045','1','0','0','UNWORTHY!'),
('34497','16276','-1649046','1','0','0','You appreciated and acknowledged nothing.'),
('34497','0','-1649047','3','0','0','%s begins to read a spell |cFFFFFFFFLight Vortex!|R switch to |cFFFFFFFFLight|r essence!'),
('34496','16279','-1649048','1','0','0','Let the light consume you!'),
('34496','0','-1649049','3','0','0','%s begins to read a spell |cFF9932CDBlack Vortex!|R switch to |cFF9932CDBlack|r essence!'),
('34496','16278','-1649050','1','0','0','Let the dark consume you!'),
-- Anub'arak
('34564','16235','-1649055','1','0','0','Ahhh... Our guests arrived, just as the master promised.'),
('34564','16234','-1649056','1','0','0','This place will serve as your tomb!'),
('34564','16236','-1649057','1','0','0','F-lakkh shir!'),
('34564','16237','-1649058','1','0','0','Another soul to sate the host.'),
('34564','16238','-1649059','1','0','0','I have failed you, master...'),
('34564','0','-1649060','3','0','0','%s spikes  pursuing $n!'),
('34564','16240','-1649061','1','0','0','Auum na-l ak-k-k-k, isshhh. Rise, minions. Devour...'),
('34564','0','-1649062','3','0','0','%s produces a swarm of beetles Peon to restore your health!'),
('34564','16241','-1649063','1','0','0','The swarm shall overtake you!'),
-- Event
-- Northrend Beasts
('34996','16036','-1649070','1','0','0','Welcome champions, you have heard the call of the Argent Crusade and you have boldly answered. It is here in the crusaders coliseum that you will face your greatest challenges. Those of you who survive the rigors of the coliseum will join the Argent Crusade on its marsh to ice crown citadel.'),
('34996','16038','-1649071','1','0','0','Hailing from the deepest, darkest carverns of the storm peaks, Gormok the Impaler! Battle on, heroes!'),
('34990','16069','-1649072','1','0','0','Your beast will be no match for my champions Tirion!'),
('34995','16026','-1649073','1','0','0','I have seen  more  worthy  challenges in the ring of blood, you waste our time paladin.'),
('34996','16039','-1649074','1','0','0','Steel yourselves, heroes, for the twin terrors Acidmaw and Dreadscale. Enter the arena!'),
('34996','16040','-1649075','1','0','0','The air freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!'),
('34996','16041','-1649076','1','0','0','The monstrous menagerie has been vanquished!'),
('34996','16042','-1649077','1','0','0','Tragic... They fought valiantly, but the beasts of Northrend triumphed. Let us observe a moment of silence for our fallen heroes.'),
-- Jaraxxus
('34996','16043','-1649080','1','0','0','Grand Warlock Wilfred Fizzlebang will summon forth your next challenge. Stand by for his entry!'),
('35458','16268','-1649081','1','0','0','Thank you, Highlord! Now challengers, I will begin the ritual of summoning! When I am done, a fearsome Doomguard will appear!'),
('35458','16269','-1649082','1','0','0','Prepare for oblivion!'),
('35458','16270','-1649083','1','0','0','Ah ha! Behold the absolute power of Wilfred Fizzlebang, master summoner! You are bound to ME, demon!'),
('35458','16271','-1649084','1','0','0','But I am in charge here-'),
('35458','0','-1649085','1','0','0','...'),
('34996','16044','-1649086','1','0','0','Quickly, heroes! Destroy the demon lord before it can open a portal to its twisted demonic realm!'),
('34996','16045','-1649087','1','0','0','The loss of Wilfred Fizzlebang, while unfortunate, should be a lesson to those that dare dabble in dark magic. Alas, you are victorious and must now face the next challenge.'),
('34995','16021','-1649088','1','0','0','Treacherous Alliance dogs! You summon a demon lord against warriors of the Horde!? Your deaths will be swift!'),
('34990','16064','-1649089','1','0','0','The Alliance doesnt need the help of a demon lord to deal with Horde filth. Come, pig!'),
('34996','16046','-1649090','1','0','0','Everyone, calm down! Compose yourselves! There is no conspiracy at play here. The warlock acted on his own volition - outside of influences from the Alliance. The tournament must go on!'),
-- Faction Champions
('34996','16047','-1649091','1','0','0','The next battle will be against the Argent Crusades most powerful knights! Only by defeating them will you be deemed worthy...'),
('34990','16066','-1649092','1','0','0','Our honor has been besmirched! They make wild claims and false accusations against us. I demand justice! Allow my champions to fight in place of your knights, Tirion. We challenge the Horde!'),
('34995','16023','-1649093','1','0','0','The Horde demands justice! We challenge the Alliance. Allow us to battle in place of your knights, paladin. We will show these dogs what it means to insult the Horde!'),
('34996','16048','-1649094','1','0','0','Very well, I will allow it. Fight with honor!'),
('34990','16065','-1649095','1','0','0','Fight for the glory of the Alliance, heroes! Honor your king and your people!'),
('34995','16022','-1649096','1','0','0','Show them no mercy, Horde champions! LOK-TAR OGAR!'),
('34990','16067','-1649097','1','0','0','GLORY OF THE ALLIANCE!'),
('34995','16024','-1649098','1','0','0','LOK-TAR OGAR!'),
('34996','16049','-1649099','1','0','0','A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death.'),
-- Twin Valkyrs
('34996','16050','-1649100','1','0','0','Only by working together will you overcome the final challenge. From the depths of Icecrown come two of the Scourges most powerful lieutenants: fearsome valkyr, winged harbingers of the Lich King!'),
('34996','16037','-1649101','1','0','0','Let the games begin!'),
('34990','16068','-1649102','1','0','0','Not even the Lich King most powerful minions can stand against the Alliance! All hail our victors!'),
('34995','16025','-1649103','1','0','0','Do you still question the might of the horde paladin? We will take on all comers.'),
-- Anub'arak
('34996','16051','-1649104','1','0','0','A mighty blow has been dealt to the Lich King! You have proven yourselves able bodied champions of the Argent Crusade. Together we will strike at Icecrown Citadel and destroy what remains of the Scourge! There is no challenge that we cannot face united!'),
('35877','16321','-1649105','1','0','0','You will have your challenge, Fordring.'),
('34996','16052','-1649106','1','0','0','Arthas! You are hopelessly outnumbered! Lay down Frostmourne and I will grant you a just death.'),
('35877','16322','-1649107','1','0','0','The Nerubians built an empire beneath the frozen wastes of Northrend. An empire that you so foolishly built your structures upon. MY EMPIRE.'),
('35877','16323','-1649108','1','0','0','The souls of your fallen champions will be mine, Fordring.'),
('36095','0','-1649109','1','0','0','Champions, you are alive! Not only have you defeated every challenge of the Trial of the Crusader, but thwarted Arthas directly! Your skill and cunning will prove to be a powerful weapon against the Scourge. Well done! Allow one of my mages to transport you back to the surface!'),
('36095','0','-1649110','1','0','0','Let me hand you the chests as a reward, and let its contents will serve you faithfully in the campaign against Arthas in the heart of the Icecrown Citadel!');

-- Faction Champions
UPDATE `creature_template` SET `scriptname`='mob_toc_warrior', `AIName` ='' WHERE `entry` IN (34475,34453);
UPDATE `creature_template` SET `scriptname`='mob_toc_mage', `AIName` ='' WHERE `entry` IN (34468,34449);
UPDATE `creature_template` SET `scriptname`='mob_toc_shaman', `AIName` ='' WHERE `entry` IN (34470,34444);
UPDATE `creature_template` SET `scriptname`='mob_toc_enh_shaman', `AIName` ='' WHERE `entry` IN (34463,34455);
UPDATE `creature_template` SET `scriptname`='mob_toc_hunter', `AIName` ='' WHERE `entry` IN (34467,34448);
UPDATE `creature_template` SET `scriptname`='mob_toc_rogue', `AIName` ='' WHERE `entry` IN (34472,34454);
UPDATE `creature_template` SET `scriptname`='mob_toc_priest', `AIName` ='' WHERE `entry` IN (34466,34447);
UPDATE `creature_template` SET `scriptname`='mob_toc_shadow_priest', `AIName` ='' WHERE `entry` IN (34473,34441);
UPDATE `creature_template` SET `scriptname`='mob_toc_dk', `AIName` ='' WHERE `entry` IN (34461,34458);
UPDATE `creature_template` SET `scriptname`='mob_toc_paladin', `AIName` ='' WHERE `entry` IN (34465,34445);
UPDATE `creature_template` SET `scriptname`='mob_toc_retro_paladin', `AIName` ='' WHERE `entry` IN (34471,34456);
UPDATE `creature_template` SET `scriptname`='mob_toc_druid', `AIName` ='' WHERE `entry` IN (34469,34459);
UPDATE `creature_template` SET `scriptname`='mob_toc_boomkin', `AIName` ='' WHERE `entry` IN (34460,34451);
UPDATE `creature_template` SET `scriptname`='mob_toc_warlock' WHERE `entry` IN (34474,34450);
UPDATE `creature_template` SET `scriptname`='mob_toc_pet_warlock', `AIName` ='' WHERE `entry` IN (35465);
UPDATE `creature_template` SET `scriptname`='mob_toc_pet_hunter', `AIName` ='' WHERE `entry` IN (35610);

-- -------------------------------------------------------------------------
-- ------------------------ Trial Of the Champion --------------------------
-- -------------------------------------------------------------------------
-- Gate
DELETE FROM `gameobject` WHERE `guid` in (150077,150080);
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`) VALUES 
(195649, 0, 411, 'South Portcullis', '', '', '', 0, 37, 3.26663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(195648, 0, 411, 'East Portcullis', '', '', '', 0, 37, 3.26663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(195650, 0, 411, 'North Portcullis', '', '', '', 0, 37, 3.26663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(150076, 195650, 650, 3, 65535, 807.66, 618.091, 412.394, 3.12015, 0, 0, 0.999943, 0.0107224, 25, 0, 0),
(150073, 195648, 650, 3, 65535, 746.561, 557.002, 412.393, 1.57292, 0, 0, 0.707856, 0.706357, 25, 0, 1),
(150074, 195649, 650, 3, 65535, 685.625, 617.977, 412.285, 6.28137, 0, 0, 0.000909718, -1, 25, 0, 1),
(150081, 195647, 650, 3, 1, 746.698, 677.469, 412.339, 1.5708, 0, 0, 1, 0, 0, 0, 1);
-- Mounts
DELETE FROM `vehicle_accessory` WHERE `guid` in (35491,33299,33418,33409,33300,33408,33301,33414,33297,33416,33298);
INSERT INTO `vehicle_accessory` (`guid`,`accessory_entry`,`seat_id`,`minion`,`description`) VALUES
(35491,35451,0,0, 'Black Knight'),
(33299,35323,0,1, 'Darkspear Raptor'),
(33418,35326,0,1, 'Silvermoon Hawkstrider'),
(33409,35314,0,1, 'Orgrimmar Wolf'),
(33300,35325,0,1, 'Thunder Bluff Kodo'),
(33408,35329,0,1, 'Ironforge Ram'),
(33301,35331,0,1, 'Gnomeregan Mechanostrider'),
(33414,35327,0,1, 'Forsaken Warhorse'),
(33297,35328,0,1, 'Stormwind Steed'),
(33416,35330,0,1, 'Exodar Elekk'),
(33298,35332,0,1, 'Darnassian Nightsaber');
UPDATE `creature_template` SET `minlevel` = 80,`maxlevel` = 80 WHERE `entry` in (33298,33416,33297,33301,33408,35640,33299,33300,35634,33418,35638,33409,33414,33299,35635,35641);
UPDATE `creature_template` SET `faction_A` = 14,`faction_H` = 14 WHERE `entry` in (33298,33416,33297,33301,33408,35545,33299,35564,35590,35119,34928,35309,35305,33414,35307,35325,33300,35327,35326,33418,35638,35314,33409,33299,35635,35640,35641,35634,35633,35636,35768,35637,34658);
UPDATE `creature_template` SET `Health_mod` = 10,`mindmg` = 20000,`maxdmg` = 30000 WHERE `entry` in (33298,33416,33297,33301,33408,33409,33418,33300,33414,33299,33298,33416,33297,33301,33408,35640,35638,35634,35635,35641,35633,35636,35768,35637,34658);
UPDATE `creature_template` SET `speed_run` = 2,`Health_mod` = 40,`mindmg` = 10000,`maxdmg` = 20000,`spell1` =62544,`spell2` =63010,`spell3` =0,`spell4` =0 WHERE `entry` in (35644,36558);
UPDATE `creature` SET `spawntimesecs` = 86400 WHERE `id` in (35644,36558);
-- ScriptName
UPDATE `creature_template` SET `ScriptName`='generic_vehicleAI_toc5' WHERE `entry`=33299;
-- VehicleId
UPDATE `creature_template` SET `VehicleId`=486 WHERE `entry` in (33299,35491);
-- faction for Vehicle
UPDATE `creature_template` SET `faction_A`=35,`faction_H`=35,`unit_flags`=33554432  WHERE `entry` in (35314,35326,35327,35325,35323,35331,35330,35329,35328,35332,35491);
-- Texts 
DELETE FROM `script_texts` WHERE `entry` <= -1999926 and `entry` >= -1999956;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1999926, 'Coming out of the gate Grand Champions other faction.  ' ,0,0,0,1, '' ),
(0,-1999927, 'Good work! You can get your award from Crusader\'s Coliseum chest!.  ' ,0,1,0,1, '' ),
(0,-1999928, 'You spoiled my grand entrance. Rat.' ,16256,1,0,5, '' ),
(0,-1999929, 'Did you honestly think an agent if the Lich King would be bested on the field of your pathetic little tournament?' ,16257,1,0,5, '' ),
(0,-1999930, 'I have come to finish my task ' ,16258,1,0,5, '' ),
(0,-1999931, 'This farce ends here!' ,16259,1,0,5, '' ),
(0,-1999932, '[Zombie]Brains.... .... ....' ,0,1,0,5, '' ),
(0,-1999933, 'My roting flash was just getting in the way!' ,16262,1,0,5, '' ),
(0,-1999934, 'I have no need for bones to best you!' ,16263,1,0,5, '' ),
(0,-1999935, 'No! I must not fail...again...' ,16264,1,0,5, '' ),
(0,-1999936, 'What\'s that. up near the rafters ?' ,0,1,0,5, '' ),
(0,-1999937, 'Please change your weapon! Next battle will be start now!' ,0,3,0,5, '' ),
(0,-1999939, 'Excellent work!' ,0,1,0,1, '' ),
(0,-1999940, 'Coming out of the gate Crusader\'s Coliseum Champion.' ,0,0,0,1, '' ),
(0,-1999941, 'Excellent work! You are win Argent champion!' ,0,3,0,0, '' ),
(0,-1999942, 'The Sunreavers are proud to present their representatives in this trial by combat.' ,0,0,0,1, '' ),
(0,-1999943, 'Welcome, champions. Today, before the eyes of your leeders and peers, you will prove youselves worthy combatants.' ,0,0,0,1, '' ),
(0,-1999944, 'Fight well, Horde! Lok\'tar Ogar!' ,0,1,0,5, '' ),
(0,-1999945, 'Finally, a fight worth watching.' ,0,1,0,5, '' ),
(0,-1999946, 'I did not come here to watch animals tear at each other senselessly, Tirion' ,0,1,0,5, '' ),
(0,-1999947, 'You will first be facing three of the Grand Champions of the Tournament! These fierce contenders have beaten out all others to reach the pinnacle of skill in the joust.' ,0,1,0,5, '' ),
(0,-1999948, 'Will tought! You next challenge comes from the Crusade\'s own ranks. You will be tested against their consederable prowess.' ,0,1,0,5, '' ),
(0,-1999949, 'You may begin!' ,0,0,0,5, '' ),
(0,-1999950, 'Well, then. Let us begin.' ,0,1,0,5, '' ),
(0,-1999951, 'Take this time to consider your past deeds.' ,16248,1,0,5, '' ),
(0,-1999952, 'What is the meaning of this?' ,0,1,0,5, '' ),
(0,-1999953, 'No...I\'m still too young' ,0,1,0,5, '' ),
(0,-1999954, 'Excellent work! You are win Argent champion!' ,0,3,0,0, '' );
-- Update mob's stats
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(35571, 12006, 0, 0, 0, 0, 28597, 0, 28597, 0, 'Runok Wildmane', 'Grand Champion of the Thunder Bluff', '', 0, 80, 80, 2, 1801, 1801, 0, 1, 1, 1, 420, 630, 0, 158, 10.2, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67529, 67530, 67528, 67534, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 0, 'boss_shaman_toc5'),
(12006, 0, 0, 0, 0, 0, 28597, 0, 28597, 0, 'Runok Wildmane', 'Grand Champion of the Thunder Bluff', '', 0, 80, 80, 2, 1801, 1801, 0, 1, 1, 1, 420, 630, 0, 158, 15.2, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 68319, 67530, 67528, 67534, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 1, ''),
(35569, 12005, 0, 0, 0, 0, 28637, 0, 28637, 0, 'Eressea Dawnsinger', 'Grand Champion of Silvermoon', '', 0, 80, 80, 2, 1801, 1801, 0, 1, 1, 1, 420, 630, 0, 158, 10.2, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66044, 66042, 66045, 66043, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 0, 'boss_mage_toc5'),
(12005, 0, 0, 0, 0, 0, 28637, 0, 28637, 0, 'Eressea Dawnsinger', 'Grand Champion of Silvermoon', '', 0, 80, 80, 2, 1801, 1801, 0, 1, 1, 1, 420, 630, 0, 158, 15.2, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 68312, 68310, 66045, 68311, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 1, ''),
(35572, 12009, 0, 0, 0, 0, 28587, 0, 28587, 0, 'Mokra the Skullcrusher', 'Grand Champion of Orgrimmar', '', 0, 80, 80, 2, 1801, 1801, 0, 1, 1, 1, 420, 630, 0, 158, 10.2, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 441, 1, 0, 617297499, 0, 'boss_warrior_toc5'),
(12009, 0, 0, 0, 0, 0, 28587, 0, 28587, 0, 'Mokra the Skullcrusher', 'Grand Champion of Orgrimmar', '', 0, 80, 80, 0, 1801, 1801, 0, 1, 1, 1, 420, 630, 0, 158, 15.2, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 35.38, 20, 0, 0, 0, 0, 0, 0, 0, 441, 1, 0, 617297499, 1, ''),
(35617, 12008, 0, 0, 0, 0, 28589, 0, 28589, 0, 'Deathstalker Visceri', 'Grand Champion of Undercity', '', 0, 80, 80, 2, 1801, 1801, 0, 1, 1, 1, 420, 630, 0, 158, 10.2, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67709, 67706, 67701, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 0, 'boss_rouge_toc5'),
(12008, 0, 0, 0, 0, 0, 28589, 0, 28589, 0, 'Deathstalker Visceri', 'Grand Champion of Undercity', '', 0, 80, 80, 0, 1801, 1801, 0, 1, 1, 1, 420, 630, 0, 158, 15.2, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67709, 67706, 67701, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 35.38, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 1, ''),
(35570, 12007, 0, 0, 0, 0, 28588, 0, 28588, 0, 'Zul\'tore', 'Grand Champion of Sen\'jin', '', 0, 80, 80, 2, 1801, 1801, 0, 1, 1, 1, 420, 630, 0, 158, 10.2, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 68340, 66083, 66081, 66079, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 0, 'boss_hunter_toc5'),
(12007, 0, 0, 0, 0, 0, 28588, 0, 28588, 0, 'Zul\'tore', 'Grand Champion of Sen\'jin', '', 0, 80, 80, 0, 1801, 1801, 0, 1, 1, 1, 420, 630, 0, 158, 15.2, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 68340, 66083, 66081, 66079, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 35.38, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 1, ''),
(34701, 12001, 0, 0, 0, 0, 28736, 0, 28736, 0, 'Colosos', 'Grand Champion of the Exodar', '', 0, 80, 80, 2, 1802, 1802, 0, 1, 1, 1, 420, 630, 0, 158, 10.2, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67529, 67530, 67528, 67534, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 0, 'boss_shaman_toc5'),
(12001, 0, 0, 0, 0, 0, 28736, 0, 28736, 0, 'Colosos', 'Grand Champion of the Exodar', '', 0, 80, 80, 2, 1802, 1802, 0, 1, 1, 1, 420, 630, 0, 158, 17, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 68319, 67530, 68318, 67534, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 1, ''),
(34703, 12003, 0, 0, 0, 0, 28564, 0, 28564, 0, 'Lana Stouthammer', 'Grand Champion of Ironforge', '', 0, 80, 80, 2, 1802, 1802, 0, 1, 1, 1, 420, 630, 0, 158, 10.2, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67709, 67706, 67701, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 441, 1, 0, 617297499, 0, 'boss_rouge_toc5'),
(12003, 0, 0, 0, 0, 0, 28564, 0, 28564, 0, 'Lana Stouthammer', 'Grand Champion of Ironforge', '', 0, 80, 80, 0, 1802, 1802, 0, 1, 1, 1, 420, 630, 0, 158, 15.2, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 35.38, 20, 0, 0, 0, 0, 0, 0, 0, 441, 1, 0, 617297499, 1, ''),
(34702, 12000, 0, 0, 0, 0, 28586, 0, 28586, 0, 'Ambrose Boltspark', 'Grand Champion of Gnomeregan', '', 0, 80, 80, 2, 1802, 1802, 0, 1, 1, 1, 420, 630, 0, 158, 10.2, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66044, 66042, 66045, 66043, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 0, 'boss_mage_toc5'),
(12000, 0, 0, 0, 0, 0, 28586, 0, 28586, 0, 'Ambrose Boltspark', 'Grand Champion of Gnomeregan', '', 0, 80, 80, 2, 1802, 1802, 0, 1, 1, 1, 420, 630, 0, 158, 15.2, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 68312, 68310, 66045, 68311, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 1, ''),
(34657, 12002, 0, 0, 0, 0, 28735, 0, 28735, 0, 'Jaelyne Evensong', 'Grand Champion of Darnassus', '', 0, 80, 80, 2, 1802, 1802, 0, 1, 1, 1, 420, 630, 0, 158, 10.2, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 68340, 66083, 66081, 66079, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 0, 'boss_hunter_toc5'),
(12002, 0, 0, 0, 0, 0, 28735, 0, 28735, 0, 'Jaelyne Evensong', 'Grand Champion of Darnassus', '', 0, 80, 80, 2, 1802, 1802, 0, 1, 1, 1, 420, 630, 0, 158, 15.2, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 68340, 66083, 66081, 66079, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 1, ''),
(34705, 12004, 0, 0, 0, 0, 28560, 0, 28560, 0, 'Marshal Jacob Alerius', 'Grand Champion of Stormwind', '', 0, 80, 80, 2, 1802, 1802, 0, 1, 1, 1, 420, 630, 0, 158, 10.2, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 0, 'boss_warrior_toc5'),
(12004, 0, 0, 0, 0, 0, 28560, 0, 28560, 0, 'Marshal Jacob Alerius', 'Grand Champion of Stormwind', '', 0, 80, 80, 0, 1802, 1802, 0, 1, 1, 1, 420, 630, 0, 158, 15.2, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 35.38, 20, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 617297499, 1, ''),
(35590, 12444, 0, 0, 0, 0, 24996, 24999, 24997, 0, 'Risen Champion', 'Black Knight\'s Minion', '', 0, 80, 80, 2, 14, 14, 0, 1, 1, 0, 420, 630, 0, 158, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67774, 67879, 67729, 67886, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1.5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, ''),
(12444, 0, 0, 0, 0, 0, 24996, 24999, 24997, 0, 'Risen Champion', 'Black Knight\'s Minion', '', 0, 80, 80, 0, 14, 14, 0, 1, 1, 0, 420, 630, 0, 158, 1.4, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67774, 67879, 67729, 67886, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 7.076, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, ''),
(35564, 12436, 0, 0, 0, 0, 25528, 0, 25528, 0, 'Risen Arelas Brightstar', 'Black Knight\'s Minion', '', 0, 80, 80, 2, 14, 14, 0, 1, 1, 0, 420, 630, 0, 158, 1.4, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67774, 67879, 67729, 67886, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2.5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_risen_ghoul'),
(12436, 0, 0, 0, 0, 0, 25528, 0, 25528, 0, 'Risen Arelas Brightstar', 'Black Knight\'s Minion', '', 0, 80, 80, 0, 14, 14, 0, 1, 1, 0, 420, 630, 0, 158, 1.4, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67879, 67886, 67880, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 9.43467, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, ''),
(35545, 0, 0, 0, 0, 0, 25528, 0, 25528, 0, 'Risen Jaeren Sunsworn', 'Black Knight\'s Minion', '', 0, 80, 80, 2, 14, 14, 0, 1, 1, 0, 420, 630, 0, 158, 1.4, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67774, 67879, 67729, 67886, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2.5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_risen_ghoul'),
(35451, 35490, 0, 0, 0, 0, 29837, 0, 29837, 0, 'The Black Knight', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1, 1, 420, 630, 0, 158, 11.8, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 6, 72, 35451, 0, 0, 0, 0, 0, 0, 0, 0, 67724, 67745, 67718, 67725, 0, 0, 0, 0, 0, 0, 9530, 9530, '', 0, 3, 5.95238, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 805257215, 0, 'boss_black_knight'),
(35490, 0, 0, 0, 0, 0, 29837, 0, 29837, 0, 'The Black Knight', '', '', 0, 80, 80, 0, 14, 14, 0, 1, 1, 1, 420, 630, 0, 158, 17.6, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 6, 72, 35490, 0, 0, 0, 0, 0, 0, 0, 0, 67884, 68306, 67881, 67883, 0, 0, 0, 0, 0, 0, 10700, 10700, '', 0, 3, 37.7387, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 805257215, 1, ''),
(35119, 12011, 0, 0, 0, 0, 29616, 0, 29616, 0, 'Eadric the Pure', 'Grand Champion of the Argent Crusade', '', 0, 82, 82, 2, 14, 14, 0, 1, 1, 1, 452, 678, 0, 170, 14.5, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66865, 66863, 66867, 66935, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 42.5, 20, 0, 0, 0, 0, 0, 0, 0, 151, 1, 0, 805257215, 0, 'boss_eadric'),
(12011, 0, 0, 0, 0, 0, 29616, 0, 29616, 0, 'Eadric the Pure', 'Grand Champion of the Argent Crusade', '', 0, 82, 82, 2, 14, 14, 0, 1, 1, 1, 452, 678, 0, 170, 22.4, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66865, 66863, 66867, 66935, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 42.5, 20, 0, 0, 0, 0, 0, 0, 0, 151, 1, 0, 805257215, 1, ''),
(34928, 12010, 0, 0, 0, 0, 29490, 0, 29490, 0, 'Argent Confessor Paletress', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 1, 1, 452, 678, 0, 170, 14.5, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66546, 66536, 66515, 66537, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 8, 20, 0, 0, 0, 0, 0, 0, 0, 151, 1, 0, 805257215, 0, 'boss_paletress'),
(12010, 0, 0, 0, 0, 0, 29490, 0, 29490, 0, 'Argent Confessor Paletress', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 1, 1, 452, 678, 0, 170, 22.4, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66546, 67674, 66515, 67675, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 8, 20, 0, 0, 0, 0, 0, 0, 0, 151, 1, 0, 805257215, 1, ''),
(35309, 12439, 0, 0, 0, 0, 29762, 29763, 29762, 0, 'Argent Lightwielder', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1, 1, 420, 630, 0, 158, 8.4, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67247, 67290, 15284, 67237, 0, 0, 0, 0, 0, 0, 7651, 7651, '', 0, 3, 8, 5, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_argent_soldier'),
(12439, 0, 0, 0, 0, 0, 29762, 29763, 29762, 0, 'Argent Lightwielder', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1, 1, 420, 630, 0, 158, 12.6, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67247, 67290, 15284, 67237, 0, 0, 0, 0, 0, 0, 7651, 7651, '', 0, 3, 8, 5, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, ''),
(35305, 12488, 0, 0, 0, 0, 29758, 29759, 29758, 0, 'Argent Monk', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1, 1, 420, 630, 0, 158, 8, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67251, 67255, 67233, 67235, 0, 0, 0, 0, 0, 0, 7661, 7661, '', 0, 3, 8, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_argent_soldier'),
(12488, 0, 0, 0, 0, 0, 29758, 29759, 29758, 0, 'Argent Monk', '', '', 0, 80, 80, 0, 14, 14, 0, 1, 1, 1, 420, 630, 0, 158, 12, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67251, 67255, 67233, 67235, 0, 0, 0, 0, 0, 0, 7661, 7661, '', 0, 3, 23.5867, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, ''),
(35307, 12448, 0, 0, 0, 0, 29760, 29761, 29760, 0, 'Argent Priestess', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1, 1, 420, 630, 0, 158, 5.5, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67194, 36176, 67289, 67229, 0, 0, 0, 0, 0, 0, 7653, 7653, '', 0, 3, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_argent_soldier'),
(12448, 0, 0, 0, 0, 0, 29760, 29761, 29760, 0, 'Argent Priestess', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1, 1, 420, 630, 0, 158, 8.5, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67194, 36176, 67289, 67229, 0, 0, 0, 0, 0, 0, 7653, 7653, '', 0, 3, 10, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '');
-- Memory's Stats
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(35052, 12446, 0, 0, 0, 0, 29553, 0, 29553, 0, 'Memory of Algalon', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 4, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67679, 67678, 67677, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12446, 0, 0, 0, 0, 0, 29553, 0, 29553, 0, 'Memory of Algalon', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 4, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67679, 67678, 67677, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35041, 12486, 0, 0, 0, 0, 29546, 0, 29546, 0, 'Memory of Archimonde', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12486, 0, 0, 0, 0, 0, 29546, 0, 29546, 0, 'Memory of Archimonde', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35033, 12438, 0, 0, 0, 0, 14367, 0, 14367, 0, 'Memory of Chromaggus', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12438, 0, 0, 0, 0, 0, 14367, 0, 14367, 0, 'Memory of Chromaggus', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35046, 12451, 0, 0, 0, 0, 29549, 0, 29549, 0, 'Memory of Cyanigosa', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12451, 0, 0, 0, 0, 0, 29549, 0, 29549, 0, 'Memory of Cyanigosa', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35043, 12482, 0, 0, 0, 0, 18699, 0, 18699, 0, 'Memory of Delrissa', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12482, 0, 0, 0, 0, 0, 18699, 0, 18699, 0, 'Memory of Delrissa', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35047, 12456, 0, 0, 0, 0, 26644, 0, 26644, 0, 'Memory of Eck', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12456, 0, 0, 0, 0, 0, 26644, 0, 26644, 0, 'Memory of Eck', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35044, 12440, 0, 0, 0, 0, 23428, 0, 23428, 0, 'Memory of Entropius', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12440, 0, 0, 0, 0, 0, 23428, 0, 23428, 0, 'Memory of Entropius', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35039, 12725, 0, 0, 0, 0, 18698, 0, 18698, 0, 'Memory of Gruul', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12725, 0, 0, 0, 0, 0, 18698, 0, 18698, 0, 'Memory of Gruul', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35034, 12453, 0, 0, 0, 0, 29540, 0, 29540, 0, 'Memory of Hakkar', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12453, 0, 0, 0, 0, 0, 29540, 0, 29540, 0, 'Memory of Hakkar', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35049, 12455, 0, 0, 0, 0, 29557, 0, 29557, 0, 'Memory of Heigan', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12455, 0, 0, 0, 0, 0, 29557, 0, 29557, 0, 'Memory of Heigan', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35030, 12454, 0, 0, 0, 0, 29537, 0, 29537, 0, 'Memory of Herod', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12454, 0, 0, 0, 0, 0, 29537, 0, 29537, 0, 'Memory of Herod', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(34942, 12484, 0, 0, 0, 0, 29525, 0, 29525, 0, 'Memory of Hogger', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12484, 0, 0, 0, 0, 0, 29525, 0, 29525, 0, 'Memory of Hogger', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35050, 12450, 0, 0, 0, 0, 29185, 0, 29185, 0, 'Memory of Ignis', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 5, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12450, 0, 0, 0, 0, 0, 29185, 0, 29185, 0, 'Memory of Ignis', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 5, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35042, 12442, 0, 0, 0, 0, 29547, 0, 29547, 0, 'Memory of Illidan', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12442, 0, 0, 0, 0, 0, 29547, 0, 29547, 0, 'Memory of Illidan', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35045, 12483, 0, 0, 0, 0, 29558, 0, 29558, 0, 'Memory of Ingvar', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12483, 0, 0, 0, 0, 0, 29558, 0, 29558, 0, 'Memory of Ingvar', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35037, 12437, 0, 0, 0, 0, 29542, 0, 29542, 0, 'Memory of Kalithresh', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66552, 66620, 66619, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29.2313, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12437, 0, 0, 0, 0, 0, 29542, 0, 29542, 0, 'Memory of Kalithresh', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66552, 66620, 66619, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35031, 12441, 0, 0, 0, 0, 29562, 0, 29562, 0, 'Memory of Lucifron', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 66619, 66552, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12441, 0, 0, 0, 0, 0, 29562, 0, 29562, 0, 'Memory of Lucifron', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 66619, 66552, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35038, 12445, 0, 0, 0, 0, 29543, 0, 29543, 0, 'Memory of Malchezaar', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12445, 0, 0, 0, 0, 0, 29543, 0, 29543, 0, 'Memory of Malchezaar', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35029, 12447, 0, 0, 0, 0, 29556, 0, 29556, 0, 'Memory of Mutanus', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12447, 0, 0, 0, 0, 0, 29556, 0, 29556, 0, 'Memory of Mutanus', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35048, 12449, 0, 0, 0, 0, 21401, 0, 21401, 0, 'Memory of Onyxia', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12449, 0, 0, 0, 0, 0, 21401, 0, 21401, 0, 'Memory of Onyxia', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35028, 12485, 0, 0, 0, 0, 29536, 0, 29536, 0, 'Memory of VanCleef', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12485, 0, 0, 0, 0, 0, 29536, 0, 29536, 0, 'Memory of VanCleef', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35040, 12452, 0, 0, 0, 0, 29545, 0, 0, 0, 'Memory of Vashj', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12452, 0, 0, 0, 0, 0, 29545, 0, 29545, 0, 'Memory of Vashj', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 452, 678, 0, 170, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 362, 542, 136, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35036, 12443, 0, 0, 0, 0, 29541, 0, 29541, 0, 'Memory of Vek\'nilash', '', '', 0, 82, 82, 2, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12443, 0, 0, 0, 0, 0, 29541, 0, 29541, 0, 'Memory of Vek\'nilash', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35051, 12487, 0, 0, 0, 0, 28548, 0, 28548, 0, 'Memory of Vezax', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory'),
(12487, 0, 0, 0, 0, 0, 28548, 0, 28548, 0, 'Memory of Vezax', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 122.031, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, ''),
(35032, 0, 0, 0, 0, 0, 14992, 0, 14992, 0, 'Memory of Thunderaan', '', '', 0, 82, 82, 0, 14, 14, 0, 1, 0.5, 1, 330, 495, 0, 124, 20.5, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 264, 396, 99, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66620, 67679, 66619, 67678, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 29, 25, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 617297499, 0, 'npc_memory');
-- Equipment
UPDATE `creature_template` SET `equipment_id`=2049 WHERE `entry` in (35314,35326,35327,35325,35323,35331,35330,35329,35328,35332);
UPDATE `creature_template` SET `equipment_id`=2025 WHERE `entry` in (35571,12006);
UPDATE `creature_template` SET `equipment_id`=2021 WHERE `entry` in (35569,12005);
UPDATE `creature_template` SET `equipment_id`=2018 WHERE `entry` in (35572,12009);
UPDATE `creature_template` SET `equipment_id`=2020 WHERE `entry` in (35617,12008);
UPDATE `creature_template` SET `equipment_id`=2019 WHERE `entry` in (35570,12007);
UPDATE `creature_template` SET `equipment_id`=2096 WHERE `entry` in (34701,12001);
UPDATE `creature_template` SET `equipment_id`=2093 WHERE `entry` in (34703,12003);
UPDATE `creature_template` SET `equipment_id`=2095 WHERE `entry` in (34657,12002);
UPDATE `creature_template` SET `equipment_id`=2092 WHERE `entry` in (34705,12004);
UPDATE `creature_template` SET `equipment_id`=834 WHERE `entry` in (35119,12011);
UPDATE `creature_template` SET `equipment_id`=235 WHERE `entry` in (34928,12010);
UPDATE `creature_template` SET `equipment_id`=0 WHERE `entry` in (35451,12012);
-- Griphon of black Knight
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35491, 0, 0, 0, 0, 0, 29842, 0, 0, 0, 'Black Knight\'s Skeletal Gryphon', '', '', 0, 80, 80, 2, 35, 35, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 33554432, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 486, 0, 0, '', 0, 4, 15, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 0, 0, 'npc_black_knight_skeletal_gryphon');
DELETE FROM `script_waypoint` WHERE `entry`=35491;
INSERT INTO `script_waypoint` VALUES
(35491,1,781.513062, 657.989624, 466.821472,0,''),
(35491,2,759.004639, 665.142029, 462.540771,0,''),
(35491,3,732.936646, 657.163879, 452.678284,0,''),
(35491,4,717.490967, 646.008545, 440.136902,0,''),
(35491,5,707.570129, 628.978455, 431.128632,0,''),
(35491,6,705.164063, 603.628418, 422.956635,0,''),
(35491,7,716.350891, 588.489746, 420.801666,0,''),
(35491,8,741.702881, 580.167725, 420.523010,0,''),
(35491,9,761.634033, 586.382690, 422.206207,0,''),
(35491,10,775.982666, 601.991943, 423.606079,0,''),
(35491,11,769.051025, 624.686157, 420.035126,0,''),
(35491,12,756.582214, 631.692322, 412.529785,0,''),
(35491,13,744.841,634.505,411.575,0,'');
-- Griphon of black Knight before battle start
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35492, 0, 0, 0, 0, 0, 29842, 0, 0, 0, 'Black Knight\'s Skeletal Gryphon', '', '', 0, 80, 80, 2, 35, 35, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 33554432, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 486, 0, 0, '', 0, 3, 15, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 0, 0, 'npc_gr');
DELETE FROM `script_waypoint` WHERE `entry`=35492;
INSERT INTO `script_waypoint` VALUES
(35492,1,741.067078, 634.471558, 411.569366,0,''),
(35492,2,735.726196, 639.247498, 414.725555,0,''),
(35492,3,730.187256, 653.250977, 418.913269,0,''),
(35492,4,734.517700, 666.071350, 426.259247,0,''),
(35492,5,739.638489, 675.339417, 438.226776,0,''),
(35492,6,741.833740, 698.797302, 456.986328,0,''),
(35492,7,734.647339, 711.084778, 467.165314,0,''),
(35492,8,715.388489, 723.820862, 470.333588,0,''),
(35492,9,687.178711, 730.140503, 470.569336,0,'');
-- Announcer for start event
DELETE FROM `creature_template` WHERE `entry` in (35591,35592);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35591, 0, 0, 0, 0, 0, 29894, 0, 0, 0, 'Jaeren Sunsworn', '', '', 0, 75, 75, 2, 14, 14, 0, 1, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_anstart'),
(35592, 0, 0, 0, 0, 0, 29893, 0, 0, 0, 'Arelas Brightstar', '', '', 0, 75, 75, 2, 14, 14, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_anstart');
-- Spawn Announcer in normal/heroic mode
DELETE FROM `creature` WHERE `id`=35004;
DELETE FROM `creature` WHERE `guid` in (180100);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(180100, 35591, 650, 3, 1, 0, 0, 746.626, 618.54, 411.09, 4.63158, 86400, 0, 0, 10635, 0, 0, 0);
-- Addons
REPLACE INTO `creature_template_addon` VALUES
-- Argent
(35309, 0, 0, 0, 1, 0, '63501 0'),
(12439, 0, 0, 0, 1, 0, '63501 0'),
(35305, 0, 0, 0, 1, 0, '63501 0'),
(12488, 0, 0, 0, 1, 0, '63501 0'),
(35307, 0, 0, 0, 1, 0, '63501 0'),
(12448, 0, 0, 0, 1, 0, '63501 0'),
(35119, 0, 0, 0, 1, 0, '63501 0'),
(12011, 0, 0, 0, 1, 0, '63501 0'),
(34928, 0, 0, 0, 1, 0, '63501 0'),
(12010, 0, 0, 0, 1, 0, '63501 0'),
-- Faction_champ
(35323, 0, 0, 0, 1, 0, '63399 0 62852 0 64723 0'),
(35570, 0, 0, 0, 1, 0, '63399 0 62852 0 64723 0'),
(12007, 0, 0, 0, 1, 0, '63399 0 62852 0 64723 0'),
(35326, 0, 0, 0, 1, 0, '63403 0 62852 0 64723 0'),
(35569, 0, 0, 0, 1, 0, '63403 0 62852 0 64723 0'),
(12005, 0, 0, 0, 1, 0, '63403 0 62852 0 64723 0'),
(35314, 0, 0, 0, 1, 0, '63433 0 62852 0 64723 0'),
(35572, 0, 0, 0, 1, 0, '63433 0 62852 0 64723 0'),
(12009, 0, 0, 0, 1, 0, '63433 0 62852 0 64723 0'),
(35325, 0, 0, 0, 1, 0, '63436 0 62852 0 64723 0'),
(35571, 0, 0, 0, 1, 0, '63436 0 62852 0 64723 0'),
(12006, 0, 0, 0, 1, 0, '63436 0 62852 0 64723 0'),
(35329, 0, 0, 0, 1, 0, '63427 0 62852 0 64723 0'),
(34703, 0, 0, 0, 1, 0, '63427 0 62852 0 64723 0'),
(12003, 0, 0, 0, 1, 0, '63427 0 62852 0 64723 0'),
(35331, 0, 0, 0, 1, 0, '63396 0 62852 0 64723 0'),
(34702, 0, 0, 0, 1, 0, '63396 0 62852 0 64723 0'),
(12000, 0, 0, 0, 1, 0, '63396 0 62852 0 64723 0'),
(35327, 0, 0, 0, 1, 0, '63430 0 62852 0 64723 0'),
(35617, 0, 0, 0, 1, 0, '63430 0 62852 0 64723 0'),
(12008, 0, 0, 0, 1, 0, '63430 0 62852 0 64723 0'),
(35328, 0, 0, 0, 1, 0, '62594 0 62852 0 64723 0'),
(34705, 0, 0, 0, 1, 0, '62594 0 62852 0 64723 0'),
(12004, 0, 0, 0, 1, 0, '62594 0 62852 0 64723 0'),
(35330, 0, 0, 0, 1, 0, '63423 0 62852 0 64723 0'),
(34701, 0, 0, 0, 1, 0, '63423 0 62852 0 64723 0'),
(12001, 0, 0, 0, 1, 0, '63423 0 62852 0 64723 0'),
(35332, 0, 0, 0, 1, 0, '63406 0 62852 0 64723 0'),
(12002, 0, 0, 0, 1, 0, '63406 0 62852 0 64723 0'),
(34657, 0, 0, 0, 1, 0, '63406 0 62852 0 64723 0');
-- Argent Warhorse
UPDATE `creature_template` SET `VehicleId` =486 WHERE `entry` =35644;
-- Immunes (crash fix xD )
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|1073741823 WHERE `entry` IN
(35309,12439, -- Argent Lightwielder
35305,12488, -- Argent Monk
35307,12448); -- Argent Priestess


-- -------------------------------------------------------------------------
-- ------------------------------------ULDUAR ------------------------------
-- -------------------------------------------------------------------------
-- Ignis
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 9, `vehicleId` = 342 WHERE `entry` = 33118;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 9 WHERE `entry` = 33190;
DELETE FROM creature WHERE id = 33121;
DELETE FROM conditions WHERE SourceEntry = 62343;
INSERT INTO `conditions` VALUES
('13','0','62343','0','18','1','33121','0','0','',NULL);

-- Razorscale
UPDATE `creature_template` SET `speed_run` = 0.00001 WHERE `entry` IN (34188, 34189);

-- XT-002
UPDATE `creature_template` SET `VehicleId` = 335 WHERE `entry` = 33293;

-- Assembly of Iron
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235 WHERE `entry` IN (32867, 32927, 33693, 33692);
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299803 WHERE `entry` IN (32857, 33694);
UPDATE `creature_template` SET `ScriptName` = 'npc_rune_of_power' WHERE `entry` = 33705;
UPDATE `creature_template` SET `difficulty_entry_1` = 33691, `ScriptName` = 'npc_rune_of_summoning' WHERE `entry` = 33051;
UPDATE `creature_template` SET `ScriptName` = 'npc_lightning_elemental' WHERE `entry` = 32958;
-- Runemaster Molgeim
UPDATE `creature_model_info` SET `bounding_radius` = 0.45, `combat_reach` = 4 WHERE `modelid` = 28381;
-- Steelbreaker
UPDATE `creature_model_info` SET `bounding_radius` = 0.45, `combat_reach` = 8 WHERE `modelid` = 28344;

-- Kologarn
UPDATE `creature_template` SET `baseattacktime` = 1800, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` IN (32930, 33909);
UPDATE `creature_model_info` SET `bounding_radius` = 1, `combat_reach` = 15 WHERE `modelid` = 28638;
UPDATE `creature_model_info` SET `bounding_radius` = 0.465, `combat_reach` = 15 WHERE `modelid` = 28821;
-- Left Arm
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_left_arm' WHERE `entry` = 32933;
UPDATE `creature_model_info` SET `bounding_radius` = 0.465, `combat_reach` = 15 WHERE `modelid` = 28821;
-- Right Arm
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_right_arm' WHERE `entry` = 32934;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235 WHERE `entry` IN (33910, 33911);
UPDATE `creature_model_info` SET `bounding_radius` = 0.465, `combat_reach` = 15 WHERE `modelid` = 28822;
-- Focused Eyebeam
UPDATE `creature_template` SET `ScriptName` = 'npc_focused_eyebeam' WHERE `entry` IN (33632, 33802);
DELETE FROM conditions WHERE SourceEntry IN (63676, 63702);
INSERT INTO `conditions` VALUES
('13','0','63676','0','18','1','32930','0','0','',"Focused Eyebeam (Kologarn)"),
('13','0','63702','0','18','1','32930','0','0','',"Focused Eyebeam (Kologarn)");
-- Cleanup
DELETE FROM `creature` WHERE `id` IN (33632, 33802, 34297, 32933, 32934, 33809, 33661, 33742);
DELETE FROM vehicle_accessory WHERE guid = 32930;


-- Auriaya
UPDATE `creature_template` SET `baseattacktime` = 1500, `equipment_id` = 2422, `mechanic_immune_mask` = 617299807, `flags_extra` = 1 WHERE `entry` = 33515;
UPDATE `creature_template` SET `baseattacktime` = 1500, `equipment_id` = 2422, `mechanic_immune_mask` = 617299807, `flags_extra` = 1 WHERE `entry` = 34175;
UPDATE `creature_model_info` SET `bounding_radius` = 0.775, `combat_reach` = 5 WHERE `modelid` = 28651;
-- Sanctum Sentry
UPDATE `creature_template` SET `speed_walk` = 1.66667, `mechanic_immune_mask` = 536870912, `flags_extra` = 1, `ScriptName` = 'npc_sanctum_sentry' WHERE `entry` = 34014;
UPDATE `creature_template` SET `baseattacktime` = 1500, `speed_walk` = 1.66667, `mechanic_immune_mask` = 536870912, `flags_extra` = 1 WHERE `entry` = 34166;
-- Feral Defender
UPDATE `creature_template` SET `speed_walk` = 2, `dmg_multiplier` = 3.5, `flags_extra` = 1, `ScriptName` = 'npc_feral_defender' WHERE `entry` = 34035;
UPDATE `creature_template` SET `speed_walk` = 2, `dmg_multiplier` = 5, `flags_extra` = 1, `baseattacktime` = 1500 WHERE `entry` = 34171;
UPDATE `creature_template` SET `unit_flags` = 33554432, `ScriptName` = 'npc_seeping_trigger' WHERE `entry` = 34098;
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` = 34174;
UPDATE `creature_template` SET `dmg_multiplier` = 1.5, `baseattacktime` = 1500 WHERE `entry` = 34169;
UPDATE `creature_template` SET `ScriptName` = 'npc_feral_defender_trigger' WHERE `entry` = 34096;
-- Mace equip
DELETE FROM `creature_equip_template` WHERE entry = 2422;
INSERT INTO `creature_equip_template` VALUES ('2422','45315','0','0');
-- Cleanup
DELETE FROM `creature` WHERE `id` = 34014;
-- Auriaya movement path
DELETE FROM `creature_addon` WHERE guid = 137496;
INSERT INTO `creature_addon` VALUES ('137496','1033515','0','0','0','0','0');
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 137496;
DELETE FROM `waypoint_data` WHERE id = 1033515;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
('1033515','1','1968.46','51.75','417.72','0','0','0','100','0'),
('1033515','2','1956.75','49.22','411.35','0','0','0','100','0'),
('1033515','3','1938.90','42.09','411.35','3000','0','0','100','0'),
('1033515','4','1956.75','49.22','411.35','0','0','0','100','0'),
('1033515','5','1968.46','51.75','417.72','0','0','0','100','0'),
('1033515','6','2011.43','44.91','417.72','0','0','0','100','0'),
('1033515','7','2022.65','37.74','411.36','0','0','0','100','0'),
('1033515','8','2046.65','9.61','411.36','0','0','0','100','0'),
('1033515','9','2053.4','-8.65','421.68','0','0','0','100','0'),
('1033515','10','2053.14','-39.8','421.66','0','0','0','100','0'),
('1033515','11','2046.26','-57.96','411.35','0','0','0','100','0'),
('1033515','12','2022.42','-86.39','411.35','0','0','0','100','0'),
('1033515','13','2011.26','-92.95','417.71','0','0','0','100','0'),
('1033515','14','1969.43','-100.02','417.72','0','0','0','100','0'),
('1033515','15','1956.66','-97.4','411.35','0','0','0','100','0'),
('1033515','16','1939.18','-90.90','411.35','3000','0','0','100','0'),
('1033515','17','1956.66','-97.4','411.35','0','0','0','100','0'),
('1033515','18','1969.43','-100.02','417.72','0','0','0','100','0'),
('1033515','19','2011.26','-92.95','417.71','0','0','0','100','0'),
('1033515','20','2022.42','-86.39','411.35','0','0','0','100','0'),
('1033515','21','2046.26','-57.96','411.35','0','0','0','100','0'),
('1033515','22','2053.14','-39.8','421.66','0','0','0','100','0'),
('1033515','23','2053.4','-8.65','421.68','0','0','0','100','0'),
('1033515','24','2046.65','9.61','411.36','0','0','0','100','0'),
('1033515','25','2022.65','37.74','411.36','0','0','0','100','0'),
('1033515','26','2011.43','44.91','417.72','0','0','0','100','0');



-- Hodir
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'boss_hodir' WHERE `entry` = 32845;
UPDATE `creature_template` SET `equipment_id` = 1843, `mechanic_immune_mask` = 650854239, `flags_extra` = 1 WHERE `entry` = 32846;
-- Hodir npcs
UPDATE `creature_template` SET `ScriptName` = 'npc_hodir_priest' WHERE `entry` IN (32897, 33326, 32948, 33330);
UPDATE `creature_template` SET `ScriptName` = 'npc_hodir_shaman' WHERE `entry` IN (33328, 32901, 33332, 32950);
UPDATE `creature_template` SET `ScriptName` = 'npc_hodir_druid' WHERE `entry` IN (33325, 32900, 32941, 33333);
UPDATE `creature_template` SET `ScriptName` = 'npc_hodir_mage' WHERE `entry` IN (32893, 33327, 33331, 32946);
UPDATE `creature_template` SET `ScriptName` = 'npc_toasty_fire' WHERE `entry` = 33342;
UPDATE `creature_template` SET `ScriptName` = 'npc_icicle' WHERE `entry` = 33169;
UPDATE `creature_template` SET `ScriptName` = 'npc_icicle_snowdrift' WHERE `entry` = 33173;
UPDATE `creature_template` SET `ScriptName` = 'npc_snowpacked_icicle' WHERE `entry` = 33174;
UPDATE `creature_template` SET `difficulty_entry_1` = 33352, `mechanic_immune_mask` = 612597599, `ScriptName` = 'npc_flash_freeze' WHERE `entry` = 32926;
UPDATE `creature_template` SET `difficulty_entry_1` = 33353, `mechanic_immune_mask` = 612597599, `ScriptName` = 'npc_flash_freeze' WHERE `entry` = 32938;
UPDATE `creature_template` SET `mechanic_immune_mask` = 612597599 WHERE `entry` IN (33352, 33353);
UPDATE `gameobject_template` SET `flags` = 4 WHERE `entry` = 194173;
-- Cleanup
DELETE FROM `creature` WHERE `id` IN (32950, 32941, 32948, 32946, 32938);

-- Mimiron Tram
UPDATE `gameobject_template` SET `flags` = 32, `data2` = 3000, `ScriptName` = 'go_call_tram' WHERE `entry` IN (194914, 194912, 194437);
DELETE FROM gameobject WHERE id = '194437';
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
('194437','603','1','1','2306.87','274.237','424.288','1.52255','0','0','0.689847','0.723956','300','0','1');
DELETE FROM gameobject_template WHERE entry = '194438';
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
('194438','1','8504','Activate Tram','','','','0','32','1','0','0','0','0','0','0','0','0','3000','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','go_call_tram','11159');
DELETE FROM gameobject WHERE id = '194438';
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(194438, 603, 1,1,2306.99, 2589.35, 424.382, 4.71676, 0, 0, 0.705559, -0.708651, 300, 0, 1);

-- Mimiron
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_mimiron' WHERE `entry` = 33350;
-- Leviathan MKII
UPDATE `creature_template` SET `vehicleid` = 370, `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_leviathan_mk' WHERE `entry` = 33432;
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 34106;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_leviathan_mk_turret' WHERE `entry` = 34071;
DELETE FROM vehicle_accessory WHERE guid = 33432;
INSERT INTO vehicle_accessory VALUE (33432, 34071, 3, 1, 'Leviathan Mk II turret',6,30000);
UPDATE creature_template SET ScriptName = 'npc_proximity_mine' WHERE entry = 34362;
DELETE FROM `creature_model_info` WHERE `modelid`=28831;
INSERT INTO `creature_model_info` (`modelid`, `bounding_radius`, `combat_reach`, `gender`, `modelid_other_gender`) VALUES
(28831, 0.5, 7, 2, 0);
-- VX-001
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `vehicleid` = 371, `ScriptName` = 'boss_vx_001' WHERE `entry` = 33651;
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 34108;
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` = 34050;
UPDATE `creature_template` SET `unit_flags` = 33686020, `flags_extra` = 2 WHERE `entry` = 34211;
UPDATE `creature_template` SET `ScriptName` = 'npc_rocket_strike' WHERE `entry` = 34047;
-- Aerial Command Unit
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'boss_aerial_unit' WHERE `entry` = 33670;
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 34109;
UPDATE `creature_template` SET `ScriptName` = 'npc_magnetic_core' WHERE `entry` = 34068;
UPDATE `creature_template` SET `ScriptName` = 'npc_assault_bot' WHERE `entry` = 34057;
UPDATE `creature_template` SET `difficulty_entry_1` = 34148, `ScriptName` = 'npc_emergency_bot' WHERE `entry` = 34147;
-- HardMode
UPDATE `gameobject_template` SET `flags` = 32, `ScriptName` = 'go_not_push_button' WHERE `entry` = 194739;
UPDATE `creature_template` SET `difficulty_entry_1` = 34361, `ScriptName` = 'npc_frost_bomb' WHERE `entry` = 34149;
UPDATE `creature_template` SET `speed_walk` = 0.15, `speed_run` = 0.15, `ScriptName` = 'npc_mimiron_flame_trigger' WHERE `entry` = 34363;
UPDATE `creature_template` SET `ScriptName` = 'npc_mimiron_flame_spread' WHERE `entry` = 34121;
-- CleanUp
DELETE FROM creature WHERE id IN (34071, 33856);
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 34143;




-- Freya
UPDATE `creature_template` SET `baseattacktime` = 1500, `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_freya' WHERE `entry` = 32906;
UPDATE `creature_template` SET `speed_walk` = 1.6, `baseattacktime` = 1500, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 33360;
-- Elders
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'npc_elder_brightleaf' WHERE `entry` = 32915;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'npc_elder_ironbranch' WHERE `entry` = 32913;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'npc_elder_stonebark' WHERE `entry` = 32914;
UPDATE `creature_template` SET `speed_walk` = 1.66666, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` IN (33393, 33392, 33391);
-- Iron roots
UPDATE `creature_template` SET `difficulty_entry_1` = 33397, `mechanic_immune_mask` = 650854239, `ScriptName` = 'npc_iron_roots' WHERE `entry` = 33168;
UPDATE `creature_template` SET `difficulty_entry_1` = 33396, `mechanic_immune_mask` = 650854239, `ScriptName` = 'npc_iron_roots' WHERE `entry` = 33088;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239 WHERE `entry` IN (33396, 33397);
-- Eonar Gift
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'npc_eonars_gift' WHERE `entry` = 33228;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 33385;
-- Unstable Sun Beam
UPDATE `creature_template` SET `ScriptName` = 'npc_unstable_sun_beam' WHERE `entry` = 33050;
-- Sun Beam
UPDATE `creature_template` SET `ScriptName` = 'npc_sun_beam' WHERE `entry` = 33170;
-- Nature Bomb
UPDATE `creature_template` SET `ScriptName` = 'npc_nature_bomb' WHERE `entry` = 34129;
UPDATE `gameobject_template` SET `flags` = 4 WHERE `entry` = 194902;
-- Detonating Lasher
UPDATE `creature_template` SET `flags_extra` = 256, `ScriptName` = 'npc_detonating_lasher' WHERE `entry` = 32918;
UPDATE `creature_template` SET `flags_extra` = 256 WHERE `entry` = 33399;
-- Ancient Conservator
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853979, `ScriptName` = 'npc_ancient_conservator' WHERE `entry` = 33203;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853979 WHERE `entry` = 33376;
-- Healthy Spore
UPDATE `creature_template` SET `ScriptName` = 'npc_healthy_spore' WHERE `entry` = 33215;
-- Storm Lasher
UPDATE `creature_template` SET `ScriptName` = 'npc_storm_lasher' WHERE `entry` = 32919;
-- Snaplasher
UPDATE `creature_template` SET `ScriptName` = 'npc_snaplasher' WHERE `entry` = 32916;
-- Ancient Water Spirit
UPDATE `creature_template` SET `ScriptName` = 'npc_ancient_water_spirit' WHERE `entry` = 33202;
-- Cleanup
DELETE FROM `creature` WHERE `guid` = 136607 OR id = 33575;



-- Thorim
UPDATE `creature_template` SET `speed_walk` = 1.66667, `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'boss_thorim' WHERE `entry` = 32865;
UPDATE `creature_template` SET `speed_walk` = 1.66667, `baseattacktime` = 1500, `equipment_id` = 1844, `mechanic_immune_mask` = 650854239 WHERE `entry` = 33147;
DELETE FROM `creature` WHERE `id`=32865;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(32865, 603, 3, 1, 28977, 0, 2134.967, -298.962, 438.331, 1.57, 604800, 0, 0, 4183500, 425800, 0, 1);
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=62042;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
('62042','62470','1','Thorim: Deafening Thunder');
-- Charge Orb
DELETE FROM conditions WHERE SourceEntry = 62016;
INSERT INTO `conditions` VALUES
('13','0','62016','0','18','1','33378','0','0','',NULL);
UPDATE `creature_template` SET `unit_flags` = 33685508 WHERE `entry` = 33378;
-- Gate
DELETE FROM `gameobject_scripts` WHERE `id`=55194;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(55194, 0, 11, 34155, 15, '0', 0, 0, 0, 0);
DELETE FROM `gameobject_template` WHERE `entry`=194265;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
('194265','1','295','Lever','','','','0','16','3','0','0','0','0','0','0','0','0','6000','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0');
UPDATE `gameobject` SET `id` = 194265, `rotation2` = 1, `rotation3` = 0, `spawntimesecs` = 7200, `animprogress` = 100 WHERE `guid` = 55194;
-- Cleanup
DELETE FROM `creature` WHERE `id` IN (32885, 32883, 32908, 32907, 32882, 33110, 32886, 32879, 32892, 33140, 33141, 33378, 32874, 32875)
OR guid IN (136694, 136695, 136666, 136706, 136754, 136653, 136756, 136757, 136725, 136718);
-- Pre adds
UPDATE `creature_template` SET `equipment_id` = 1849, `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32885;
UPDATE `creature_template` SET `equipment_id` = 1849 WHERE `entry` = 33153;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32883;
UPDATE `creature_template` SET `equipment_id` = 1847 WHERE `entry` = 33152;
UPDATE `creature_template` SET `equipment_id` = 1850, `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32908;
UPDATE `creature_template` SET `equipment_id` = 1850 WHERE `entry` = 33151;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32907;
UPDATE `creature_template` SET `equipment_id` = 1852 WHERE `entry` = 33150;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32882;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32886;
UPDATE `creature_template` SET `modelid1` = 16925, `modelid2` = 0 WHERE `entry`IN (33378, 32892);
-- Thorim Mini bosses
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'npc_runic_colossus' WHERE `entry` = 32872;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'npc_ancient_rune_giant' WHERE `entry` = 32873;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'npc_sif' WHERE `entry` = 33196;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_arena_phase' WHERE `entry` IN (32876, 32904, 32878, 32877, 32874, 32875, 33110);
DELETE FROM `creature_addon` WHERE `guid`IN (136059, 136816);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
('136059','0','0','0','1','0','40775 0'),
('136816','0','0','0','1','0','40775 0');


-- General Vezax
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299803, `flags_extra` = 257, `ScriptName` = 'boss_general_vezax' WHERE `entry` = 33271;
UPDATE `creature_template` SET `baseattacktime` = 1500, `mechanic_immune_mask` = 617299803, `flags_extra` = 257 WHERE `entry` = 33449;
UPDATE `creature_model_info` SET `bounding_radius` = 0.62, `combat_reach` = 12 WHERE `modelid` = 28548;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_saronite_vapors' WHERE `entry` = 33488;
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_saronite_animus' WHERE `entry` = 33524;
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `mechanic_immune_mask` = 650854235 WHERE `entry` IN (33789, 34152);
UPDATE `creature_model_info` SET `bounding_radius` = 0.62, `combat_reach` = 10 WHERE `modelid` = 28992;
-- CleanUp
DELETE FROM creature WHERE id = 33500;

/* ----------------------------------------------------------------------  ajout s@m ---------------------------------------------------------------------------*/


-- YoggSaron
-- Sara

UPDATE `creature_template` SET `unit_flags` = 0, `type_flags` = 0, `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_sara' WHERE `entry` = 33134;
UPDATE creature_model_info SET bounding_radius = 0.465, combat_reach = 45 WHERE modelid = 29117;
UPDATE `creature` SET `spawndist` = 0 WHERE `id` = 33134;

-- Ominous cloud
DELETE FROM `creature` WHERE `id`=33292;
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_flags` = 33947654, `type_flags` = 0, `speed_walk` = 0.2, modelid1 = 28549, modelid2 = 0, `ScriptName` = 'npc_ominous_cloud' WHERE `entry` IN (33292, 32406);

-- Guardian of Yogg-Saron
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 16, `faction_H` = 16, `mindmg` = 123, `maxdmg` = 123, `attackpower` = 123, `dmg_multiplier` = 123, `baseattacktime` = 1800, `mechanic_immune_mask` = 1234, `ScriptName` = 'npc_guardian_yoggsaron' WHERE `entry` = 33136;
UPDATE creature_model_info SET bounding_radius = 0.62, combat_reach = 1.5 WHERE modelid = 28465;

-- Yogg-Saron
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_flags` = 131076, `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_yoggsaron' WHERE `entry` = 33288;
UPDATE creature_model_info SET bounding_radius = 0.755, combat_reach = 18 WHERE modelid = 28817;
UPDATE `creature_template` SET  modelid1 = 16946, modelid2 = 0, `minlevel` = 80, `maxlevel` = 80, `faction_A` = 16, `faction_H` = 16, `unit_flags` = 33685510, `speed_walk` = 2, `ScriptName` = 'npc_death_orb' WHERE `entry` = 33882;

-- Brain of Yogg-Saron
UPDATE `creature_template` SET `difficulty_entry_1` = 33954, `faction_A` = 16, `faction_H` = 16, `unit_flags` = 131076, `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_brain_yoggsaron' WHERE `entry` = 33890;
UPDATE creature_model_info SET bounding_radius = 0.755, combat_reach = 30 WHERE modelid = 28951;

-- Illusions
UPDATE `creature_template` SET modelid1 = 15880, modelid2 = 0, `minlevel` = 82, `maxlevel` = 82, `faction_A` = 16, `faction_H` = 16, `unit_flags` = 33685510, `ScriptName` = 'npc_laughing_skull' WHERE `entry` = 33990;
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 7, `faction_H` = 7, `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_illusion' WHERE `entry` IN (33433, 33716, 33717, 33719, 33720, 33567);
UPDATE creature_model_info SET bounding_radius = 0.306, combat_reach = 1.5 WHERE modelid = 28621;
UPDATE creature_model_info SET bounding_radius = 1, combat_reach = 10 WHERE modelid IN (2718, 1687, 2717, 12869);

-- Passive Illusions
UPDATE `creature_template` SET  ScriptName = "npc_passive_illusions" WHERE `entry` IN (33436, 33437, 33536, 33535, 33495, 33523, 33441, 33442);

-- Influence Tentacle
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 16, `faction_H` = 16, `mindmg` = 123, `maxdmg` = 123, `attackpower` = 123, `dmg_multiplier` = 12 WHERE `entry` = 33943;
UPDATE creature_model_info SET bounding_radius = 0.306, combat_reach = 1.5 WHERE modelid = 28813;

-- Whispers
UPDATE `script_texts` SET `type` = 4 WHERE `entry` IN (-1603317, -1603340, -1603339);

-- Descend into madness portal
UPDATE `creature_template` SET `npcflag` = 16777216, `unit_flags` = 2, `type_flags` = 0, `ScriptName` = 'npc_descend_into_madness' WHERE `entry` = 34072;
DELETE FROM `creature_template` WHERE entry IN (34122, 34123);
INSERT INTO `creature_template` VALUES
('34122','0','0','0','0','0','29074','0','0','0','Descend Into Madness','','Interact','0','81','81','0','35','35','16777216','1','1.14286','1','0','0','0','0','0','1','2000','0','1','2','0','0','0','0','0','0','0','0','0','10','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','1','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_descend_into_madness','11159'),
('34123','0','0','0','0','0','29074','0','0','0','Descend Into Madness','','Interact','0','81','81','0','35','35','16777216','1','1.14286','1','0','0','0','0','0','1','2000','0','1','2','0','0','0','0','0','0','0','0','0','10','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','1','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_descend_into_madness','11159');

-- Flee to the Surface
UPDATE `gameobject_template` SET `data10` = 63992 WHERE `entry` = 194625;
DELETE FROM `gameobject` WHERE `id` = 194625;
INSERT INTO `gameobject` VALUES
(NULL, 194625, 603, 3, 1, 1996.41, -0.070, 240.59, 0, 0, 0, 1, 0, 300, 0, 1),
(NULL, 194625, 603, 3, 1, 1949.63, -26.07, 241.25, 0, 0, 0, 1, 0, 300, 0, 1),
(NULL, 194625, 603, 3, 1, 1995.03, -52.98, 241.02, 0, 0, 0, 1, 0, 300, 0, 1);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (34072, 34122, 34123);
INSERT INTO `npc_spellclick_spells` VALUES
(34072, 63989, 0, 0, 0, 3, 0, 0, 0), -- Stormwind
(34122, 63997, 0, 0, 0, 3, 0, 0, 0), -- Chamber
(34123, 63998, 0, 0, 0, 3, 0, 0, 0); -- Icecrown

-- Cancel Illusion Room Aura
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 63992;
INSERT INTO `spell_linked_spell` VALUES
(63992, -63988, 0, "Cancel Illusion Room Aura");

-- Dragon blood
DELETE FROM gameobject WHERE id = 194462;
INSERT INTO gameobject VALUES (NULL, 194462, 603, 3, 1, 2104.35, -25.3753, 242.647, 0, 0, 0, 0, -1, 300, 0, 1);

-- Remove spawned mobs
DELETE FROM `creature` WHERE `id`=34137 AND position_x = 1921.84;

-- Portals coordinates
DELETE FROM `spell_target_position` WHERE `id` IN (63989, 63992, 63997, 63998);
INSERT INTO `spell_target_position` VALUES
(63989, 603, 1953.91, 21.91, 239.71, 2.08),
(63992, 603, 1980.28, -25.59, 329.40, 3.14),
(63997, 603, 2042.02, -25.54, 239.72, 6.28),
(63998, 603, 1948.44, -82.04, 239.99, 4.18);

-- Tentacles
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_flags` = 131076, `type_flags` = 0, `ScriptName` = "npc_constrictor_tentacle" WHERE `entry` = 33983;
UPDATE creature_model_info SET bounding_radius = 0.306, combat_reach = 1.5 WHERE modelid = 28815;

-- Squeeze stun
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (64125, 64126);
INSERT INTO `spell_linked_spell` VALUES
(64125, 9032, 2, "Squeeze stun"),
(64126, 9032, 2, "Squeeze stun");
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_flags` = 4, `type_flags` = 0, `mindmg` = 123, `maxdmg` = 123, `attackpower` = 123, `dmg_multiplier` = 123, `baseattacktime` = 1800, `ScriptName` = 'npc_crusher_tentacle' WHERE `entry` = 33966;
UPDATE creature_model_info SET bounding_radius = 0.985, combat_reach = 5 WHERE modelid = 28814;
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_flags` = 131076, `ScriptName` = 'npc_corruptor_tentacle' WHERE `entry` = 33985;

-- Immortal Guardian
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `mindmg` = 123, `maxdmg` = 132, `attackpower` = 123, `dmg_multiplier` = 12, `type_flags` = 0, `ScriptName` = 'npc_immortal_guardian' WHERE `entry` = 33988;
UPDATE creature_model_info SET bounding_radius = 0.92, combat_reach = 4 WHERE modelid = 29024;

-- Shattered Illusion
DELETE FROM `spell_script_target` WHERE `entry` = 64173;
INSERT INTO `spell_script_target` VALUES
(64173, 1, 33966),
(64173, 1, 33983),
(64173, 1, 33985);

-- Remove area stun
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (64059, 65238);
INSERT INTO `spell_linked_spell` VALUES
(64059, 65238, 0, "Shattered illusion remove"),
(65238, -64173, 1, "Shattered illusion remove");

DELETE FROM gameobject WHERE id = 194560;

-- Ulduar Keepers Images
DELETE FROM `creature` WHERE `id` IN (33213, 33241, 33242, 33244);
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(33241, 603, 1, 1, 0, 0, 2057.81, -24.0768, 421.532, 3.12904, 604800, 0, 0, 14433075, 0, 0, 0),
(33242, 603, 1, 1, 0, 0, 2036.81, -73.7053, 411.353, 2.43575, 604800, 0, 0, 14433075, 0, 0, 0),
(33244, 603, 1, 1, 0, 0, 2036.74, 25.4642, 411.357, 3.81412, 604800, 0, 0, 14433075, 0, 0, 0),
(33213, 603, 1, 1, 0, 0, 1939.29, -90.6994, 411.357, 1.02595, 604800, 0, 0, 14433075, 0, 0, 0);

UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `npcflag` = 1, `flags_extra` = 2, `ScriptName` = 'npc_keeper_image' WHERE `entry` IN (33213, 33241, 33242, 33244);

-- Ulduar keepers
delete FROM creature WHERE id IN (33410,33411,33412,33413);
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('33410','603','1','1','0','0','2039.46','26.7057','338.416','3.65289','300','0','0','14433076','0','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('33411','603','1','1','0','0','2038.31','-75.761','338.415','2.31614','300','0','0','14433076','0','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('33412','603','1','1','0','0','1938.01','45.902','338.459','5.24253','300','0','0','14433076','0','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('33413','603','1','1','0','0','1938.91','-92.2094','338.459','0.977035','300','0','0','14433076','0','0','0','0','0','0');


UPDATE `creature_template` SET `ScriptName` = 'npc_ys_freya' WHERE `entry` = 33410;
UPDATE `creature_template` SET `ScriptName` = 'npc_ys_hodir' WHERE `entry` = 33411;
UPDATE `creature_template` SET `ScriptName` = 'npc_ys_mimiron' WHERE `entry` = 33412;
UPDATE `creature_template` SET `ScriptName` = 'npc_ys_thorim' WHERE `entry` = 33413;

-- Suppression des portes en trop monde illusion
DELETE FROM gameobject WHERE guid IN (3487247,3487248,3488313,3488314);







