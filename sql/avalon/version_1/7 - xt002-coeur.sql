DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (33113, 33114, 33118, 33293, 33432, 33651);
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`) VALUES
(33113,46598,0,0,0,0,0,0,0), -- Flame Leviathan
(33114,46598,0,0,0,0,0,0,0), -- Flame Leviathan Seat
(33118,46598,0,0,0,0,0,0,0), -- Ignis
(33293,46598,0,0,0,0,0,0,0), -- XT-002
(33432,46598,0,0,0,0,0,0,0), -- Leviathan MK II
(33651,46598,0,0,0,0,0,0,0); -- VX-001
-- XT-002 correct vehicle id
UPDATE `creature_template` SET `VehicleId` = 353 WHERE `entry` = 33293;
-- XT-002 Hearth
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 33293;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`) VALUES
(33293, 33329, 0, 1, "XT-002 Hearth");
