UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_rejek_first_blood' WHERE `entry` IN (28086,28096,28110,28109);
UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_stormwatcher' WHERE `entry`=28877;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=28877;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-10 WHERE `item`=39651; -- increase Droppchance of Venture Co. Explosives (1% is to less)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=39651;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,39651,0,24,2,28877,0,0,'','Venture Co. Explosives only target dead Stormwatcher');