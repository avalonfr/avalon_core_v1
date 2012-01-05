SET @event := 85;

UPDATE `creature_template` SET `ScriptName`='npc_dark_iron_herald' WHERE `entry`=24536;
UPDATE `creature_template` SET `ScriptName`='npc_dark_iron_guzzler' WHERE `entry`=23709;
UPDATE `gameobject_questrelation` SET `id`=189989 WHERE `quest`=12020;
UPDATE `quest_template` SET `PrevQuestId`=0 WHERE `entry`=12020;

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (3557,3558);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
('3557','0','0','0',''),
('3558','0','0','0','');

DELETE FROM `creature` WHERE `id`=24536;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
('24536','1','1','1','0','0','1199.34','-4293.03','21.2255','2.15038','420','0','0','16026','0','0','0','0','0'),
('24536','0','1','1','0','0','-5158.79','-604.12','398.199','5.00486','420','0','0','16026','0','0','0','0','0');

DELETE FROM `game_event_creature` WHERE `eventEntry`=@event;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@event,@guid),
(@event,@guid+1);

DELETE FROM `game_event` WHERE `eventEntry`=@event;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `description`, `world_event`) VALUES
(@event,'2010-09-20 00:00:00','2020-12-31 06:00:00','30','8','0','Fête des brasseurs - Attaque des sombrefers','0');
