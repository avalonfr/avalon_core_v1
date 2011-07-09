SET @GUID := XXXX;
SET @GO_GUID := XXXX;

-- torch toss target condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (46054,45732);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,45732,18,1,25535),
(13,46054,18,1,25535);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=45723;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(45723,43313,2, 'Torch Tossing - Target Indicator Visual');

UPDATE `creature_template` SET `ScriptName`='npc_torch_tossing_bunny' WHERE `entry`=25535;

UPDATE `quest_template` SET `RewOrReqMoney`=74000, `RewMoneyMaxLevel`=132300 WHERE `entry` IN (11731,11922);
UPDATE `quest_template` SET `PrevQuestId`=11731, `RewOrReqMoney`=74000, `RewMoneyMaxLevel`=132300 WHERE `entry`=11921;
UPDATE `quest_template` SET `PrevQuestId`=11922, `RewOrReqMoney`=74000, `RewMoneyMaxLevel`=132300 WHERE `entry`=11926;
UPDATE `quest_template` SET `StartScript`=11731 WHERE `entry` IN (11731,11922);
UPDATE `quest_template` SET `StartScript`=11921 WHERE `entry` IN (11921,11926);

-- add torch toss aura on quest accept
DELETE FROM `quest_start_scripts` WHERE `id` IN (11731,11921);
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(11731,0,14,45724,0,0,0,0,0,0),
(11731,1,15,45716,0,0,0,0,0,0),
(11921,0,14,45724,0,0,0,0,0,0),
(11921,1,15,46630,0,0,0,0,0,0);

-- more objects
DELETE FROM `gameobject` WHERE `guid` BETWEEN @GO_GUID AND @GO_GUID+6;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GO_GUID,'187708','0','1','1','-8822.4','846.766','99.0875','2.10363','0','0','0.868324','0.495997','300','0','1'),
(@GO_GUID+1,'187708','0','1','1','-8817.63','851.846','98.9217','2.93222','0','0','0.994525','0.104495','300','0','1'),
(@GO_GUID+2,'187708','0','1','1','-8816.68','854.946','98.9073','2.92043','0','0','0.993892','0.110354','300','0','1'),
(@GO_GUID+3,'187708','0','1','1','-8816.66','858.591','98.9913','3.1427','0','0','1','-0.000551387','300','0','1'),
(@GO_GUID+4,'300068','0','1','1','-8834.32','857.823','99.8395','6.0196','0','0','0.131411','-0.991328','300','0','1'),
(@GO_GUID+5,'187708','1','1','1','1913.57','-4315.85','23.1799','4.90635','0','0','0.635316','-0.772252','300','0','1'),
(@GO_GUID+6,'300068','1','1','1','1914.7','-4336.27','22.1744','1.01471','0','0','0.485865','0.874034','300','0','1');

DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN @GO_GUID AND @GO_GUID+6;
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(1,@GO_GUID),
(1,@GO_GUID+1),
(1,@GO_GUID+2),
(1,@GO_GUID+3),
(1,@GO_GUID+4),
(1,@GO_GUID+5),
(1,@GO_GUID+6);

-- more bunnies
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+11;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@GUID,'25535','0','1','1','0','0','-8825.75','845.668','100.848','2.15624','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+1,'25535','0','1','1','0','0','-8822.48','846.841','100.883','2.2018','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+2,'25535','0','1','1','0','0','-8819.42','848.453','100.745','2.70837','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+3,'25535','0','1','1','0','0','-8817.56','851.801','100.717','2.7767','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+4,'25535','0','1','1','0','0','-8816.67','854.896','100.703','2.9275','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+5,'25535','0','1','1','0','0','-8816.57','858.57','100.787','3.28328','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+6,'25535','1','1','1','0','0','1925.17','-4321.24','23.4473','4.69918','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+7,'25535','1','1','1','0','0','1923.89','-4315.22','24.2852','4.59786','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+8,'25535','1','1','1','0','0','1920.46','-4319.27','23.6163','5.01334','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+9,'25535','1','1','1','0','0','1918.05','-4314.94','24.6482','5.04868','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+10,'25535','1','1','1','0','0','1913.58','-4315.8','24.9737','5.22382','30','0','0','4120','0','0','0','0','0','0'),
(@GUID+11,'25535','1','1','1','0','0','1915.54','-4320.43','23.6154','5.09658','30','0','0','4120','0','0','0','0','0','0');

DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @GUID AND @GUID+11;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(1,@GUID),
(1,@GUID+1),
(1,@GUID+2),
(1,@GUID+3),
(1,@GUID+4),
(1,@GUID+5),
(1,@GUID+6),
(1,@GUID+7),
(1,@GUID+8),
(1,@GUID+9),
(1,@GUID+10),
(1,@GUID+11);