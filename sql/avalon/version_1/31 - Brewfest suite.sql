-- apple trap workaround
UPDATE `creature_template` SET `modelid1`=11686, `minlevel`=30, `maxlevel`=30, `faction_A`=35, `faction_H`=35, `ScriptName`='npc_apple_trap_bunny' WHERE `entry`=24263;
-- bark quests credits
UPDATE `creature_template` SET `modelid1`=11686, `minlevel`=30, `maxlevel`=30, `ScriptName`='npc_bark_bunny' WHERE `entry` IN (24202,24203,24204,24205);
-- apply ram mount spell on quest accept
UPDATE `quest_template` SET `SrcSpell`=43883 WHERE `entry` IN (11409,11412,11318,11122,11293,11294,11407,11408);
-- temporary give more coins
UPDATE `quest_template` SET `RewItemCount1`=25 WHERE `entry` IN (11293,11294,11407,11408);
-- keg delivery npcs
UPDATE `creature_template` SET `ScriptName`='npc_keg_delivery' WHERE `entry` IN (24364,24527,24497,23558);
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry` IN (24497,23558);
UPDATE `creature_template` SET `minlevel`=30, `maxlevel`=30 WHERE `entry`=24527;

-- threw keg (player) target condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=43662;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,43662,18,1,24468),
(13,43662,18,1,24510);

-- make quest 11122 completable
UPDATE `quest_template` SET `StartScript`=11122 WHERE `entry`=11122;

DELETE FROM `quest_start_scripts` WHERE `id`=11122;
INSERT INTO `quest_start_scripts` (`id`, `command`, `datalong`) VALUES
(11122,15,51798);

-- remove ram fatigue debuff
DELETE FROM `spell_linked_spell` WHERE `spell_effect`=-43052;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(-43883,-43052,0, 'Remove Ram Fatigue with Rental Racing Ram');

-- some spawns
SET @guid := 303065;
SET @go_guid := 400045;

DELETE FROM `creature` WHERE `id` IN (24202,24203,24204,24205,24527,24263);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@guid,24202,1,1,1,0,0,1652.82,-4425.6,16.7553,1.94068,180,0,0,42,0,0,0,0,0),
(@guid+1,24202,0,1,1,0,0,-4919.44,-941.245,501.562,5.38547,180,0,0,42,0,0,0,0,0),
(@guid+2,24203,1,1,1,0,0,1933.84,-4676.55,27.6472,2.16765,180,0,0,42,0,0,0,0,0),
(@guid+3,24203,0,1,1,0,0,-4959.34,-1199.69,501.659,0.735904,180,0,0,42,0,0,0,0,0),
(@guid+4,24204,1,1,1,0,0,1927.43,-4298.46,25.3459,0.375365,180,0,0,42,0,0,0,0,0),
(@guid+5,24204,0,1,1,0,0,-4690.26,-1235.04,501.66,2.25665,180,0,0,42,0,0,0,0,0),
(@guid+6,24205,1,1,1,0,0,1573.16,-4202.9,43.1776,5.43725,180,0,0,42,0,0,0,0,0),
(@guid+7,24205,0,1,1,0,0,-4679.16,-968.932,501.658,3.88478,180,0,0,42,0,0,0,0,0),
(@guid+9,24263,1,1,1,0,0,1290.72,-4433.38,28.9128,2.38741,180,0,0,102,0,0,0,0,0),
(@guid+10,24263,1,1,1,0,0,1096.47,-4427.09,21.9768,0.600628,180,0,0,102,0,0,0,0,0),
(@guid+11,24263,1,1,1,0,0,1004.37,-4479.23,12.6481,1.44494,180,0,0,102,0,0,0,0,0),
(@guid+12,24263,1,1,1,0,0,813.71,-4550.15,6.76704,0.526026,180,0,0,102,0,0,0,0,0),
(@guid+13,24263,0,1,1,0,0,-5189.01,-482.731,389.012,3.23857,180,0,0,102,0,0,0,0,0),
(@guid+14,24263,0,1,1,0,0,-5355.19,-527.227,393.217,0.866664,180,0,0,102,0,0,0,0,0),
(@guid+15,24263,0,1,1,0,0,-5621.26,-477.593,398.716,6.23093,180,0,0,102,0,0,0,0,0),
(@guid+16,24263,0,1,1,0,0,-5492.14,-528.144,399.901,1.56881,180,0,0,102,0,0,0,0,0);

INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(24,@guid),
(24,@guid+1),
(24,@guid+2),
(24,@guid+3),
(24,@guid+4),
(24,@guid+5),
(24,@guid+6),
(24,@guid+7),
(24,@guid+8),
(24,@guid+9),
(24,@guid+10),
(24,@guid+11),
(24,@guid+12),
(24,@guid+13),
(24,@guid+14),
(24,@guid+15),
(24,@guid+16);

UPDATE `creature_template` SET `gossip_menu_id`=9549, `minlevel`=50, `maxlevel`=50, `faction_A`=35, `faction_H`=35, `npcflag`=129, `unit_flags`=768, `equipment_id`=357, `ScriptName`='npc_brew_vendor' WHERE `name`='Brew Vendor';