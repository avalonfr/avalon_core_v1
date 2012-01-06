--T10 4P rogue
DELETE FROM spell_proc_event WHERE entry = 70803;
INSERT INTO `spell_proc_event` VALUES('70803', '0', '8', '4063232', '8', '0', '0', '0', '0', '0', '0');

--T10 2P rogue
UPDATE spell_proc_event SET procFlags=0 WHERE entry= 70805;