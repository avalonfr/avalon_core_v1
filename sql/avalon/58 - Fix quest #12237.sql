DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=48363;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,48363,18,1,27315),
(13,48363,18,1,27336);

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q12237_rescue_villager';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q12237_drop_off_villager';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(48363, 'spell_q12237_rescue_villager'),
(48397, 'spell_q12237_drop_off_villager');

UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 27341 WHERE `entry` = 12237;