UPDATE `quest_template` SET `RequiredRaces`=690,`RewardMailTemplateId`=108,`RewardMailDelay`=86400,`RewardFactionid1`=169,`RewardFactionValueId1`=3 WHERE `id`=6963;
DELETE FROM `mail_loot_template` WHERE `entry`=108;
INSERT INTO `mail_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(108,17712,100,1,0,1,1);

UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~2,`AIName`='',`ScriptName`='boss_king_magni_bronzebeard' WHERE `entry`=2784;
DELETE FROM `creature_text` WHERE `entry`=2784;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(2784,1,0,'For Khaz''Modan!',14,0,0,5,0,5896,'Magni Bronzebeard - Aggro'),
(2784,1,1,'Feel the fury of the mountain!',14,0,0,5,0,5896,'Magni Bronzebeard - Aggro');

UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=5595;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=5595;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(5595,0,0,0,54,0,100,0,0,0,0,0,49,0,0,0,0,0,0,21,75,0,0,0,0,0,0,'Ironforge Guard - On Summon - Start Attack'),
(5595,0,1,0,0,0,100,0,5000,5000,5000,5000,49,0,0,0,0,0,0,5,0,0,0,0,0,0,0,'Ironforge Guard - every 5 sec - change Target'),
(5595,0,2,0,0,0,100,0,5000,7000,8000,10000,11,11971,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ironforge Guard - IC - cast Sunder Armor'),
(5595,0,3,0,0,0,100,0,5000,7000,10000,12000,11,8078,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ironforge Guard - IC - cast Thunderclap');
