-- Motivés, motivés, il faut les motiver…

DELETE FROM `spell_script_names` WHERE `spell_id` = '74035';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
('74035', 'spell_motivate_a_tron');
UPDATE `creature_template` SET `ScriptName` = 'npc_gnome_citizen', `InhabitType` = '3', `flags_extra` = '2', `modelid1` = '2590', `modelid2` = '2581' WHERE `entry` IN ('39466', '39624');
UPDATE `creature` SET `spawntimesecs` = '30' WHERE `id` IN ('39253', '39623');

DELETE FROM `creature_text` WHERE `entry` IN ('39466', '39624');
INSERT INTO `creature_text` VALUES ('39466', '0', '0', 'Sign me up!', '12', '0', '100', '66', '0', '0', 'Gnome Citizen JustSpawned');
INSERT INTO `creature_text` VALUES ('39466', '0', '1', 'Anything for King Mekkatorque!', '12', '0', '100', '0', '0', '0', 'Gnome Citizen JustSpawned');
INSERT INTO `creature_text` VALUES ('39466', '0', '2', 'I\'d love to help.', '12', '0', '100', '273', '0', '0', 'Gnome Citizen JustSpawned');
INSERT INTO `creature_text` VALUES ('39466', '0', '3', 'Is this going to hurt?', '12', '0', '100', '66', '0', '0', 'Gnome Citizen JustSpawned');
INSERT INTO `creature_text` VALUES ('39466', '1', '0', 'Wow! We\'re taking back Gnomeregan? I\'m in!', '12', '0', '100', '66', '0', '0', 'Gnome Citizen Quest Turn in');
INSERT INTO `creature_text` VALUES ('39466', '1', '1', 'My wrench of vengance awaits!', '12', '0', '100', '1', '0', '0', 'Gnome Citizen Quest Turn in');
INSERT INTO `creature_text` VALUES ('39466', '1', '2', 'I want to drive a Spider Tank', '12', '0', '100', '66', '0', '0', 'Gnome Citizen Quest Turn in');
INSERT INTO `creature_text` VALUES ('39466', '1', '3', 'This is going to be fascinating!', '12', '0', '100', '0', '0', '0', 'Gnome Citizen Quest Turn in');
INSERT INTO `creature_text` VALUES ('39466', '1', '4', 'When does the training start?', '12', '0', '100', '6', '0', '0', 'Gnome Citizen Quest Turn in');
INSERT INTO `creature_text` VALUES ('39624', '0', '0', 'Sign me up!', '12', '0', '100', '66', '0', '0', 'Gnome Citizen JustSpawned');
INSERT INTO `creature_text` VALUES ('39624', '0', '1', 'Anything for King Mekkatorque!', '12', '0', '100', '0', '0', '0', 'Gnome Citizen JustSpawned');
INSERT INTO `creature_text` VALUES ('39624', '0', '2', 'I\'d love to help.', '12', '0', '100', '273', '0', '0', 'Gnome Citizen JustSpawned');
INSERT INTO `creature_text` VALUES ('39624', '0', '3', 'Is this going to hurt?', '12', '0', '100', '66', '0', '0', 'Gnome Citizen JustSpawned');
INSERT INTO `creature_text` VALUES ('39624', '1', '0', 'Wow! We\'re taking back Gnomeregan? I\'m in!', '12', '0', '100', '66', '0', '0', 'Gnome Citizen Quest Turn in');
INSERT INTO `creature_text` VALUES ('39624', '1', '1', 'My wrench of vengance awaits!', '12', '0', '100', '1', '0', '0', 'Gnome Citizen Quest Turn in');
INSERT INTO `creature_text` VALUES ('39624', '1', '2', 'I want to drive a Spider Tank', '12', '0', '100', '66', '0', '0', 'Gnome Citizen Quest Turn in');
INSERT INTO `creature_text` VALUES ('39624', '1', '3', 'This is going to be fascinating!', '12', '0', '100', '0', '0', '0', 'Gnome Citizen Quest Turn in');
INSERT INTO `creature_text` VALUES ('39624', '1', '4', 'When does the training start?', '12', '0', '100', '6', '0', '0', 'Gnome Citizen Quest Turn in');

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN ('39253', '39623') AND `source_type` = '0');
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
('39253', '0', '0', '0', '8', '0', '100', '0', '73943', '0', '0', '0', '41', '1000', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', 'Operation Gnomeregan: On spellhit - force despawn'),
('39623', '0', '0', '0', '8', '0', '100', '0', '74080', '0', '0', '0', '41', '1000', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', 'Operation Gnomeregan: On spellhit - force despawn');