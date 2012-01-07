UPDATE `creature_template` SET `ScriptName` = 'mob_dark_matter' WHERE `entry` = 28235;
UPDATE `creature_template` SET `ScriptName` = 'mob_searing_gaze' WHERE `entry` = 28265;

DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=7590 AND `type`=11;
