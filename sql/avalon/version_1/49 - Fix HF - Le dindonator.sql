SET @ENTRY := 32820; -- Wild Turkey
SET @SPELL := 62014; -- Turkey Tracker

UPDATE `creature_template` SET `ScriptName` = 'npc_wild_turkey' WHERE `entry` =@ENTRY;

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_turkey_tracker';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(@SPELL, 'spell_gen_turkey_tracker');