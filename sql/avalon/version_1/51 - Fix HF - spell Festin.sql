DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_feast_on';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
('61784', 'spell_gen_feast_on'),
('61785', 'spell_gen_feast_on'),
('61786', 'spell_gen_feast_on'),
('61787', 'spell_gen_feast_on'),
('61788', 'spell_gen_feast_on');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN (
'spell_gen_well_fed_pilgrims_bount_ap',
'spell_gen_well_fed_pilgrims_bount_zm',
'spell_gen_well_fed_pilgrims_bount_hit',
'spell_gen_well_fed_pilgrims_bount_haste',
'spell_gen_well_fed_pilgrims_bount_spirit');
INSERT INTO `spell_script_names` (`spell_id` ,`ScriptName`) VALUES
(61807, 'spell_gen_well_fed_pilgrims_bount_ap'), -- A Serving of Turkey
(61804, 'spell_gen_well_fed_pilgrims_bount_zm'), -- A Serving of Cranberries
(61806, 'spell_gen_well_fed_pilgrims_bount_hit'), -- A Serving of Stuffing
(61808, 'spell_gen_well_fed_pilgrims_bount_haste'), -- A Serving of Sweet Potatoes
(61805, 'spell_gen_well_fed_pilgrims_bount_spirit'); -- A Serving of Pie