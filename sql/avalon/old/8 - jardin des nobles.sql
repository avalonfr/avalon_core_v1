-- Add Easter Lay Noblegarden Egg Aura to Noblegarden shapeshifts
DELETE FROM spell_linked_spell WHERE spell_trigger IN (61734,61716);
INSERT INTO spell_linked_spell (spell_trigger, spell_effect, type, comment) VALUES
(61734, 61719, 2, 'Noblegarden Bunny'),
(61716, 61719, 2, 'Rabbit Costume');

-- Hard Boiled
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (9118) AND `type`=6;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
(9118,6,543,0); -- Golakka Hot Spring

DELETE FROM `spell_script_names` WHERE `spell_id` IN (61719);
INSERT INTO `spell_script_names` (spell_id,ScriptName) VALUES 
(61719,'spell_61719_easter_lay_noblegarden_egg_aura');
