INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`,`ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
('13376','0.032','-1','-1','-1','Greater Fire Elemental - Fire Shield'),
('57984','0.4289','-1','-1','-1','Greater Fire Elemental - Fire Blast');

UPDATE `creature_template` SET `ScriptName`='npc_fire_elemental' WHERE `entry`=15438;
UPDATE `creature_template` SET `ScriptName`='npc_earth_elemental' WHERE `entry`=15352;