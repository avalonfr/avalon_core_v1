DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10062,10063,10054,10055,10046,10047,10048,10049,10050,10051,10044,10045) AND `type`!=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(10062,12,0,0, ''),
(10063,12,1,0, ''),
(10044,12,0,0, ''),
(10045,12,1,0, ''),
(10054,12,0,0, ''),
(10055,12,1,0, ''),
(10046,12,0,0, ''),
(10047,12,0,0, ''),
(10048,12,0,0, ''),
(10049,12,1,0, ''),
(10050,12,1,0, ''),
(10051,12,1,0, '');
