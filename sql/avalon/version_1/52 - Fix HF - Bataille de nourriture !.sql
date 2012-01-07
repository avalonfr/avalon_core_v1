DELETE FROM `spell_script_names` WHERE `ScriptName` IN (
'spell_gen_on_plate_pilgrims_bount_turkey',
'spell_gen_on_plate_pilgrims_bount_cranberries',
'spell_gen_on_plate_pilgrims_bount_stuffing',
'spell_gen_on_plate_pilgrims_bount_sweet_potatoes',
'spell_gen_on_plate_pilgrims_bount_pie'
);

INSERT INTO `spell_script_names` (`spell_id` ,`ScriptName`) VALUES
(66250, 'spell_gen_on_plate_pilgrims_bount_turkey'),
(66261, 'spell_gen_on_plate_pilgrims_bount_cranberries'),
(66259, 'spell_gen_on_plate_pilgrims_bount_stuffing'),
(66262, 'spell_gen_on_plate_pilgrims_bount_sweet_potatoes'),
(66260, 'spell_gen_on_plate_pilgrims_bount_pie'); 