SET @HAIPHOON_W :=28999; -- WATER
SET @HAIPHOON_A :=28985; -- AIR
SET @STORM :=28858; -- Storm Revenant
SET @AQUEOUS :=28862; -- Aqueous Spirit
-- WATER SPELLS
SET @SPELL_W_1 :=61375; -- Water Bolt
SET @SPELL_W_2 :=61376; -- Frost Nova
SET @SPELL_W_3 :=52862; -- Devour Wind
SET @SPELL_W_4 :=52869; -- Evocation
-- AIR SPELLS
SET @SPELL_A_1 :=71934; -- Lightning Bolt (61374 original ID but needs mana - use another relative equal SpellID)
SET @SPELL_A_2 :=52870; -- Windshear
SET @SPELL_A_3 :=52864; -- Devour Water

UPDATE `creature_template` SET
`spell1`=@SPELL_W_1,
`spell2`=@SPELL_W_2,
`spell3`=@SPELL_W_3,
`spell4`=@SPELL_W_4,
`npcflag`=`npcflag`|16777216,
`unit_flags`=`unit_flags`|16777216,
`type_flags`=`type_flags`|2048,
`VehicleId`=257,
`AIName`='',
`exp`=2,
`minlevel`=80,
`maxlevel`=80,
`mindmg`=417,
`maxdmg`=582,
`attackpower`=608,
`minrangedmg`=341,
`maxrangedmg`=506,
`rangeatackpower`=80,
`ScriptName`='vehicle_haiphoon'
WHERE `entry`=@HAIPHOON_W;

UPDATE `creature_template` SET
`spell1`=@SPELL_A_1,
`spell2`=@SPELL_A_2,
`spell3`=@SPELL_A_3,
`npcflag`=`npcflag`|16777216,
`unit_flags`=`unit_flags`|16777216,
`type_flags`=`type_flags`|2048,
`VehicleId`=257,
`AIName`='',
`exp`=2,
`minlevel`=80,
`maxlevel`=80,
`mindmg`=417,
`maxdmg`=582,
`attackpower`=608,
`minrangedmg`=341,
`maxrangedmg`=506,
`rangeatackpower`=80,
`ScriptName`='vehicle_haiphoon'
WHERE `entry`=@HAIPHOON_A;

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (@HAIPHOON_W,@HAIPHOON_A);
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`) VALUES
(@HAIPHOON_W,46598,12726,1,12726,1,0,0,0),
(@HAIPHOON_A,46598,12726,1,12726,1,0,0,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry` IN (@SPELL_W_3,@SPELL_A_3);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=16 AND `SourceEntry` IN (@HAIPHOON_W,@HAIPHOON_A);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,@SPELL_W_3,0,19,@STORM,0,0,63,'','Spell only target Storm Revenant'),
(17,0,@SPELL_A_3,0,19,@AQUEOUS,0,0,63,'','Spell only target Aqueous Spirit'),
(16,0,@HAIPHOON_W,0,23,4392,0,0,0,'','Ride Vehicle only in Area'),
(16,0,@HAIPHOON_A,0,23,4392,0,0,0,'','Ride Vehicle only in Area');

UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry` IN (@STORM,@AQUEOUS);
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (@STORM,@AQUEOUS);
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (@STORM,@AQUEOUS);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@STORM,0,0,0,0,0,100,0,2000,4000,5000,7000,11,32018,1,0,0,0,0,2,0,0,0,0,0,0,0,'Storm Revenant - IC - Cast Call Lightning'),
(@AQUEOUS,0,0,0,0,0,100,0,6000,9000,7000,10000,11,55087,1,0,0,0,0,2,0,0,0,0,0,0,0,'Aqueous Spirit - IC - Cast Typhoon');