-- Spells Torneo Montas
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62960,62575,62544,62863);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
('62960', 'spell_tournament_charge'),
('62575', 'spell_tournament_shield'),
('62544', 'spell_tournament_melee'),
('62863', 'spell_tournament_duel');
-- Quest Threat From Above
UPDATE `creature_template` SET `ScriptName`='npc_chillmaw' WHERE `entry`=33687;
-- -----------------------------------------------
-- ARGENT TOURNAMENT SOPORTE BLIZLIKE.
-- QUEST SOPORTES:
-- Quest The Argent Tournament A/H 13668 - 13667
-- Quest Mastery Of Melee A/H 13829 - 13828
-- Quest Mastery Of The Charge A/H 13839 - 13837
-- Quest Mastery Of The Shield-Breaker A/H 13838 - 13835
-- Quest Up To The Challenge A/H 13678 - 13672
-- Quest A Worthy Weapon A/H (daily) 13600-13669-13674-13742-13747-13753-13758-13763-13769-13774-13779-13784.
-- Quest The Edge of Winter A/H (daily) 13616-13670-13675-13743-13748-13754-13759-13764-13770-13775-13780-13785. (Faltante Agregar Textos Al EAI Segun video http://www.youtube.com/watch?v=iPzCEwf7B5Y).
-- Quest The Aspirant's Challenge 13679 - 13680
-- Quest A Blade Fit For A Champion (daily) 13603, 13666, 13673, 13741, 13746, 13752, 13757, 13762, 13768, 13773, 13778, 13783. Spawnear mas Ranas segun video http://www.youtube.com/watch?v=hYdl0BeR8a0 y darle movimiento.
-- Quest A Valiant's Field Training (daily) 13592-13744-13749-13755-13760-13765-13771-13776-13781-13786.
-- Quest The Grand Melee (daily) 13665-13745-13750-13756-13761-13767-13772-13777-13782-13787.
-- Quest At The Enemy's Gates NO FUNCIONAL YA QUE SE NECEISTA UN SNIF DE BLIZARD PARA SABER EL AURA QUE DEJA A LOS PLAYER EN LA OTAR FASE PARA PODER SPAWNEAR ESOS NPCS Y EL PUEBLO DE ESTA QUEST.
-- Quest The Valiant's Challenge 13699-13713-13723-13724-13725-13726-13727-13728-13729-13731.
-- -----------------------------------------------

-- -----------------------------------------------
-- TEXTOS
-- -----------------------------------------------
-- DELETE FROM `script_texts` WHERE `entry` BETWEEN -1850003 AND -1850013;
DELETE FROM `script_texts` WHERE `entry` IN (-1850000,-1850001,-1850002,-1850003,-1850004,-1850005,-1850006,-1850007,-1850008,-1850009,-1850010,-1850011,-1850012);
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc2`,`comment`) VALUES
(0, -1850004, 'Stand ready !', 'Stand ready !',''),
(0, -1850005, 'Let the battle begin!', 'Let the battle begin!',''),
(0, -1850006, 'Prepare your self !', 'Prepare your self! !',''),
(0, -1850007, 'You think you have the courage?  We shall see.', 'You think you have the courage in you? Will see.',''),
(0, -1850008, 'Impressive demonstration. I think you\'re able to join the ranks of the valiants.', 'Impressive demonstration. I think you\'re able to join the ranks of the valiants.',''),
(0, -1850009, 'I\ve won. Youll probably have more luck next time.', 'Ive won. Youll probably have more luck next time.',''),
(0, -1850010, 'I stand defeated. Nice battle !', 'I stand defeated. Nice battle !',''),
(0, -1850011, 'It seems that I\'ve underestimated your skills. Well done.', 'It seems that I\'ve underestimated your skills. Well done.',''),
(0, -1850012, 'You\'ll probably have more luck next time.', 'You\'ll probably have more luck next time.','');
 
-- -----------------------------------------------
-- ASIGNACION SCRIPTS.
-- -----------------------------------------------
UPDATE `creature_template` SET `ScriptName`='quest_givers_argent_tournament' WHERE `entry` IN (33593, 33592, 33225, 33312, 33335, 33379, 33373, 33361, 33403, 33372);
UPDATE `creature_template` SET `ScriptName`='npc_quest_givers_for_crusaders' WHERE `entry` IN (34882, 35094);
UPDATE `creature_template` SET `ScriptName`='npc_crusader_rhydalla' WHERE `entry`= 33417;
UPDATE `creature_template` SET `ScriptName`='npc_eadric_the_pure' WHERE `entry`= 33759;
UPDATE `creature_template` SET `ScriptName`='npc_crok_scourgebane_argent' WHERE `entry`= 33762;
UPDATE `creature_template` SET `ScriptName`='npc_valis_windchaser' WHERE `entry`= 33974;
UPDATE `creature_template` SET `ScriptName`='npc_rugan_steelbelly' WHERE `entry`= 33972;
UPDATE `creature_template` SET `ScriptName`='npc_jeran_lockwood' WHERE `entry`= 33973;
UPDATE `creature_template` SET `ScriptName`='npc_training_dummy_argent' WHERE `entry` IN (33272,33243,33229);
UPDATE `creature_template` SET `npcflag`='3' ,`ScriptName` = 'npc_valiant' WHERE `entry` IN (33739, 33749, 33745, 33744, 33748,  33746, 33740, 33743, 33747, 33738); 
UPDATE `creature_template` SET `ScriptName` = 'npc_keritose', `npcflag`='3' WHERE `entry`= 30946;
UPDATE `creature_template` SET `ScriptName`='npc_vendor_argent_tournament' WHERE `entry` IN (33553, 33554, 33556, 33555, 33557, 33307, 33310, 33653, 33650, 33657);
UPDATE `creature_template` SET `ScriptName`='npc_justicar_mariel_trueheart' WHERE `entry`=33817;

-- -----------------------------------------------
-- Misc
-- -----------------------------------------------
-- Monturas Soporte DB al hacer click Montas.
DELETE FROM `npc_spellclick_spells` WHERE npc_entry IN (33842,33796,33798,33791,33792,33799,33843,33800,33795,33790,33793,33794);
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) VALUES
(33842, 63791, 13668, 1, 13680, 1, 0, 0, 0),-- Aspirant
-- Orgrimmar
(33799, 62783, 13726, 0, 0, 1, 0, 0, 0), -- Champion Of Orgrimmar
(33799, 62783, 13691, 0, 0, 1, 0, 0, 0), -- A Valiant Of Orgrimmar
(33799, 62783, 13707, 0, 0, 1, 0, 0, 0), -- Valiant Of Orgrimmar
-- Sen'jin
(33796, 62784, 13727, 0, 0, 1, 0, 0, 0), -- Champion Of Sen'jin
(33796, 62784, 13693, 0, 0, 1, 0, 0, 0), -- A Valiant Of Sen'jin
(33796, 62784, 13708, 0, 0, 1, 0, 0, 0), -- Valiant Of Sen'jin
-- Thunder Bluff
(33792, 62785, 13728, 0, 0, 1, 0, 0, 0), -- Champion Of Thunder Bluff
(33792, 62785, 13694, 0, 0, 1, 0, 0, 0), -- A Valiant Of Thunder Bluff
(33792, 62785, 13709, 0, 0, 1, 0, 0, 0), -- Valiant Of Thunder Bluff
-- Undercity
(33798, 62787, 13729, 0, 0, 1, 0, 0, 0), -- Champion Of Undercity
(33798, 62787, 13695, 0, 0, 1, 0, 0, 0), -- A Valiant Of Undercity
(33798, 62787, 13710, 0, 0, 1, 0, 0, 0), -- Valiant Of Undercity
-- Silvermoon
(33791, 62786, 13731, 0, 0, 1, 0, 0, 0), -- Champion Of Silvermoon
(33791, 62786, 13696, 0, 0, 1, 0, 0, 0), -- A Valiant Of Silvermoon
(33791, 62786, 13711, 0, 0, 1, 0, 0, 0), -- Valiant Of Silvermoon
(33843, 63792, 13667, 1, 13679, 1, 0, 0, 0), -- Aspirant
-- Darnassus
(33794, 62782, 13725, 0, 0, 1, 0, 0, 0), -- Champion Of Darnassus
(33794, 62782, 13689, 0, 0, 1, 0, 0, 0), -- A Valiant Of Darnassus
(33794, 62782, 13706, 0, 0, 1, 0, 0, 0), -- Valiant Of Darnassus
-- Hurlevent
(33800, 62774, 13699, 0, 0, 1, 0, 0, 0), -- Champion Of Sen'jin
(33800, 62774, 13593, 0, 0, 1, 0, 0, 0), -- A Valiant Of Sen'jin
(33800, 62774, 13684, 0, 0, 1, 0, 0, 0), -- Valiant Of Sen'jin
-- Gnomregan
(33793, 62780, 13723, 0, 0, 1, 0, 0, 0), -- Champion Of Thunder Bluff
(33793, 62780, 13688, 0, 0, 1, 0, 0, 0), -- A Valiant Of Thunder Bluff
(33793, 62780, 13704, 0, 0, 1, 0, 0, 0), -- Valiant Of Thunder Bluff
-- Forgefer
(33795, 62779, 13713, 0, 0, 1, 0, 0, 0), -- Champion Of Forgefer
(33795, 62779, 13685, 0, 0, 1, 0, 0, 0), -- A Valiant Of Undercity
(33795, 62779, 13703, 0, 0, 1, 0, 0, 0), -- Valiant Of Forgefer
-- Exodar
(33790, 62781, 13724, 0, 0, 1, 0, 0, 0), -- Champion Of Exodar
(33790, 62781, 13690, 0, 0, 1, 0, 0, 0), -- A Valiant Of Exodar
(33790, 62781, 13705, 0, 0, 1, 0, 0, 0); -- Valiant Of Exodar
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 2 WHERE `entry` IN (33845, 33319, 33317, 33318, 33217, 33316);-- Inmunidades MOnturas Alliance.
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 2 WHERE `entry` IN (33844, 33320, 33321, 33322, 33323, 33324);-- Inmunidades MOnturas Horde.
UPDATE `creature_template` SET `speed_run`= 1.571429 WHERE `entry` IN (33845, 33319, 33317, 33318, 33217, 33316);-- Velocidad Correspondiente Monturas Alliance.
UPDATE `creature_template` SET `speed_run` = 1.571429 WHERE `entry` IN (33844, 33320, 33321, 33322, 33323, 33324);-- Velocidad Correspondiente Monturas Hordas.
UPDATE `creature_template` SET `Armor_mod`=0 WHERE `entry` IN (33243, 33272, 33229);-- Armor 0
-- Teleports Locations Tabard
DELETE FROM `spell_target_position` WHERE `id` IN (63986,63987);
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(63986,571,8574.87,700.595,547.29,5.48),
(63987,571,8460,700,547.4,3.839);
-- Spells Monturas Horda
UPDATE `creature_template` SET `spell1`=62544, `spell2`=62575, `spell3`=62960, `spell4`=62552, `spell5`=64077 WHERE `entry` IN (33844, 33320, 33321, 33322, 33323, 33324);
-- Spells Monturas Ally
UPDATE `creature_template` SET `spell1`=62544, `spell2`=62575, `spell3`=62960, `spell4`=62552, `spell5`=64077 WHERE `entry` IN (33845, 33319, 33317, 33318, 33217, 33316);

-- -----------------------------------------------
-- HORDE UPDATE QUEST
-- -----------------------------------------------
-- Aspirant Quest.
UPDATE `quest_template` SET `PrevQuestId`=0, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13668;
UPDATE `quest_template` SET `PrevQuestId`=13668, `NextQuestId`=13678, `ExclusiveGroup`=-13829, `NextQuestInChain`=0 WHERE `entry` IN (13829, 13839, 13838);
-- Daily Aspirant Quests
UPDATE `quest_template` SET `PrevQuestId`=-13678, `NextQuestId`=0, `ExclusiveGroup`=13673, `NextQuestInChain`=0 WHERE `entry`=13673;
UPDATE `quest_template` SET `PrevQuestId`=-13678, `NextQuestId`=0, `ExclusiveGroup`=13673, `NextQuestInChain`=0 WHERE `entry`=13675;
UPDATE `quest_template` SET `PrevQuestId`=-13678, `NextQuestId`=0, `ExclusiveGroup`=13673, `NextQuestInChain`=0 WHERE `entry`=13674;
UPDATE `quest_template` SET `PrevQuestId`=-13678, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13676;
UPDATE `quest_template` SET `PrevQuestId`=-13678, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13677;
-- End Of Aspirant Quests
UPDATE `quest_template` SET `PrevQuestId`=13678, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13680;
-- Valiant Quests
UPDATE `quest_template` SET `PrevQuestId`=13680 WHERE `entry` IN (13691, 13693, 13694, 13695, 13696);
UPDATE `quest_template` SET `RequiredRaces`=2, `NextQuestId`=13697, `NextQuestInChain`=13697, `ExclusiveGroup`=13691 WHERE `entry`=13691;
UPDATE `quest_template` SET `RequiredRaces`=128, `NextQuestId`=13719, `NextQuestInChain`=13719, `ExclusiveGroup`=13693 WHERE `entry`=13693;
UPDATE `quest_template` SET `RequiredRaces`=32, `NextQuestId`=13720, `NextQuestInChain`=13720, `ExclusiveGroup`=13694 WHERE `entry`=13694;
UPDATE `quest_template` SET `RequiredRaces`=16, `NextQuestId`=13721, `NextQuestInChain`=13721, `ExclusiveGroup`=13695 WHERE `entry`=13695;
UPDATE `quest_template` SET `RequiredRaces`=512, `NextQuestId`=13722, `NextQuestInChain`=13722, `ExclusiveGroup`=13696 WHERE `entry`=13696;
-- INFOS DEV  13687 --  13701
UPDATE `quest_template` SET `PrevQuestId`=13701 WHERE `entry` IN (13707, 13708, 13709, 13710, 13711); -- TOScript en el core (revisar 13687)
UPDATE `quest_template` SET `NextQuestId`=13697, `NextQuestInChain`=13697, `ExclusiveGroup`=13691 WHERE `entry`=13707;
UPDATE `quest_template` SET `NextQuestId`=13719, `NextQuestInChain`=13719, `ExclusiveGroup`=13693 WHERE `entry`=13708;
UPDATE `quest_template` SET `NextQuestId`=13720, `NextQuestInChain`=13720, `ExclusiveGroup`=13694 WHERE `entry`=13709;
UPDATE `quest_template` SET `NextQuestId`=13721, `NextQuestInChain`=13721, `ExclusiveGroup`=13695 WHERE `entry`=13710;
UPDATE `quest_template` SET `NextQuestId`=13722, `NextQuestInChain`=13722, `ExclusiveGroup`=13696 WHERE `entry`=13711;
UPDATE `quest_template` SET `PrevQuestId`=0, `ExclusiveGroup`=0 WHERE `entry` IN (13697, 13719, 13720, 13721, 13722);
UPDATE `quest_template` SET `PrevQuestId`=0, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=13680 WHERE `entry`=13678;
UPDATE `quest_template` SET `NextQuestId`=13726, `NextQuestInChain`=13726 WHERE `entry`=13697;
UPDATE `quest_template` SET `NextQuestId`=13727, `NextQuestInChain`=13727  WHERE `entry`=13719;
UPDATE `quest_template` SET `NextQuestId`=13728, `NextQuestInChain`=13728  WHERE `entry`=13720;
UPDATE `quest_template` SET `NextQuestId`=13729, `NextQuestInChain`=13729  WHERE `entry`=13721;
UPDATE `quest_template` SET `NextQuestId`=13731, `NextQuestInChain`=13731  WHERE `entry`=13722;
-- Valiant Daily Quests
-- A Blade Fit For A Champion
-- The Edge Of Winter
-- A Worthy Weapon
UPDATE `quest_template` SET `PrevQuestId`=-13697, `NextQuestId`=0, `ExclusiveGroup`=13762, `NextQuestInChain`=0 WHERE `entry` IN (13762, 13763, 13764);
UPDATE `quest_template` SET `PrevQuestId`=-13719, `NextQuestId`=0, `ExclusiveGroup`=13768, `NextQuestInChain`=0 WHERE `entry` IN (13768, 13769, 13770);
UPDATE `quest_template` SET `PrevQuestId`=-13720, `NextQuestId`=0, `ExclusiveGroup`=13773, `NextQuestInChain`=0 WHERE `entry` IN (13773, 13774, 13775);
UPDATE `quest_template` SET `PrevQuestId`=-13721, `NextQuestId`=0, `ExclusiveGroup`=13778, `NextQuestInChain`=0 WHERE `entry` IN (13778, 13779, 13780);
UPDATE `quest_template` SET `PrevQuestId`=-13722, `NextQuestId`=0, `ExclusiveGroup`=13783, `NextQuestInChain`=0 WHERE `entry` IN (13783, 13784, 13785);
-- A Valiant's Field Training
-- The Grand Melee
-- At The Enemy's Gates
UPDATE `quest_template` SET `PrevQuestId`=-13697, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry` IN (13765, 13767, 13856);
UPDATE `quest_template` SET `PrevQuestId`=-13719, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry` IN (13771, 13772, 13857);
UPDATE `quest_template` SET `PrevQuestId`=-13720, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry` IN (13776, 13777, 13858);
UPDATE `quest_template` SET `PrevQuestId`=-13721, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry` IN (13781, 13782, 13860);
UPDATE `quest_template` SET `PrevQuestId`=-13722, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry` IN (13786, 13787, 13859);
-- End Of Valiant Quests
UPDATE `quest_template` SET `PrevQuestId`=13697, `NextQuestId`=13736, `ExclusiveGroup`=0, `NextQuestInChain`=13736 WHERE `entry`=13726;
UPDATE `quest_template` SET `PrevQuestId`=13719, `NextQuestId`=13737, `ExclusiveGroup`=0, `NextQuestInChain`=13737 WHERE `entry`=13727;
UPDATE `quest_template` SET `PrevQuestId`=13720, `NextQuestId`=13738, `ExclusiveGroup`=0, `NextQuestInChain`=13738 WHERE `entry`=13728;
UPDATE `quest_template` SET `PrevQuestId`=13721, `NextQuestId`=13739, `ExclusiveGroup`=0, `NextQuestInChain`=13739 WHERE `entry`=13729;
UPDATE `quest_template` SET `PrevQuestId`=13722, `NextQuestId`=13740, `ExclusiveGroup`=0, `NextQuestInChain`=13740 WHERE `entry`=13731;
-- A Champion Rises (Final Quest)
UPDATE `quest_template` SET `PrevQuestId`=13726, `NextQuestId`=13794, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13736;
UPDATE `quest_template` SET `PrevQuestId`=13727, `NextQuestId`=13794, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13737;
UPDATE `quest_template` SET `PrevQuestId`=13728, `NextQuestId`=13794, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13738;
UPDATE `quest_template` SET `PrevQuestId`=13729, `NextQuestId`=13794, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13739;
UPDATE `quest_template` SET `PrevQuestId`=13740, `NextQuestId`=13794, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13740;
-- Debug Quest Requirements
UPDATE `quest_template` SET `RequiredRaces`=690 WHERE `entry` IN (13697, 13719, 13720, 13721, 13722);
UPDATE `quest_template` SET `RequiredRaces`=690 WHERE `entry` IN (13726, 13727, 13728, 13729, 13731);
UPDATE `quest_template` SET `RequiredRaces`=690 WHERE `entry` IN (13736, 13737, 13738, 13739, 13740);
-- Debug QuestRelation H2
DELETE FROM `creature_questrelation` WHERE `quest` IN (13691, 13693, 13694, 13695, 13696, 13829, 13680, 13678);
INSERT `creature_questrelation` (`id`, `quest`) VALUES 
(33542, 13691), 
(33542, 13693), 
(33542, 13694), 
(33542, 13695), 
(33542, 13696), 
(33542,13829), 
(33542, 13680), 
(33542, 13678);

-- -----------------------------------------------
-- ALLIANCE UPDATE QUEST
-- -----------------------------------------------
-- Aspirant Quests
UPDATE `quest_template` SET `PrevQuestId`=0, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13667;
UPDATE `quest_template` SET `PrevQuestId`=13667, `NextQuestId`=13672, `ExclusiveGroup`=-13828, `NextQuestInChain`=0 WHERE `entry` IN (13828, 13837, 13835);
UPDATE `quest_template` SET `PrevQuestId`=0, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=13679 WHERE `entry`=13672;
-- Daily Aspirant Quests
UPDATE `quest_template` SET `PrevQuestId`=-13672, `NextQuestId`=0, `ExclusiveGroup`=13666, `NextQuestInChain`=0 WHERE `entry`=13666;
UPDATE `quest_template` SET `PrevQuestId`=-13672, `NextQuestId`=0, `ExclusiveGroup`=13666, `NextQuestInChain`=0 WHERE `entry`=13670;
UPDATE `quest_template` SET `PrevQuestId`=-13672, `NextQuestId`=0, `ExclusiveGroup`=13666, `NextQuestInChain`=0 WHERE `entry`=13669;
UPDATE `quest_template` SET `PrevQuestId`=-13672, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13671;
UPDATE `quest_template` SET `PrevQuestId`=-13672, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13625;
-- End Of Aspirant Quests
UPDATE `quest_template` SET `PrevQuestId`=13672, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13679;
-- Valiant Quests
UPDATE `quest_template` SET `PrevQuestId`=13679 WHERE `entry` IN (13684, 13685, 13689, 13688, 13690);
UPDATE `quest_template` SET `RequiredRaces`=1, `NextQuestId`=13718, `NextQuestInChain`=13718, `ExclusiveGroup`=13684 WHERE `entry`=13684;
UPDATE `quest_template` SET `RequiredRaces`=4, `NextQuestId`=13714, `NextQuestInChain`=13714, `ExclusiveGroup`=13685 WHERE `entry`=13685;
UPDATE `quest_template` SET `RequiredRaces`=8, `NextQuestId`=13717, `NextQuestInChain`=13717, `ExclusiveGroup`=13689 WHERE `entry`=13689;
UPDATE `quest_template` SET `RequiredRaces`=64, `NextQuestId`=13715, `NextQuestInChain`=13715, `ExclusiveGroup`=13688 WHERE `entry`=13688;
UPDATE `quest_template` SET `RequiredRaces`=1024, `NextQuestId`=13716, `NextQuestInChain`=13716, `ExclusiveGroup`=13690 WHERE `entry`=13690;
-- INFOS DEV  13686 -- 13700
UPDATE `quest_template` SET `PrevQuestId`=13700 WHERE `entry` IN (13593, 13703, 13706, 13704, 13705); -- TOScript into the core (check of 13686)
UPDATE `quest_template` SET `NextQuestId`=13718, `NextQuestInChain`=13718, `ExclusiveGroup`=13718 WHERE `entry`=13593;
UPDATE `quest_template` SET `NextQuestId`=13714, `NextQuestInChain`=13714, `ExclusiveGroup`=13714 WHERE `entry`=13703;
UPDATE `quest_template` SET `NextQuestId`=13717, `NextQuestInChain`=13717, `ExclusiveGroup`=13717 WHERE `entry`=13706;
UPDATE `quest_template` SET `NextQuestId`=13715, `NextQuestInChain`=13715, `ExclusiveGroup`=13715 WHERE `entry`=13704;
UPDATE `quest_template` SET `NextQuestId`=13716, `NextQuestInChain`=13716, `ExclusiveGroup`=13716 WHERE `entry`=13705;
UPDATE `quest_template` SET `PrevQuestId`=0, `ExclusiveGroup`=0 WHERE `entry` IN (13718, 13714, 13717, 13715, 13716);
UPDATE `quest_template` SET `NextQuestId`=13699, `NextQuestInChain`=13699 WHERE `entry`=13718;
UPDATE `quest_template` SET `NextQuestId`=13713, `NextQuestInChain`=13713  WHERE `entry`=13714;
UPDATE `quest_template` SET `NextQuestId`=13725, `NextQuestInChain`=13725  WHERE `entry`=13717;
UPDATE `quest_template` SET `NextQuestId`=13723, `NextQuestInChain`=13723  WHERE `entry`=13715;
UPDATE `quest_template` SET `NextQuestId`=13724, `NextQuestInChain`=13724  WHERE `entry`=13716;
-- Valiant Daily Quests
-- A Blade Fit For A Champion
-- The Edge Of Winter
-- A Worthy Weapon
UPDATE `quest_template` SET `PrevQuestId`=-13718, `NextQuestId`=0, `ExclusiveGroup`=13603, `NextQuestInChain`=0 WHERE `entry` IN (13603, 13600, 13616);
UPDATE `quest_template` SET `PrevQuestId`=-13714, `NextQuestId`=0, `ExclusiveGroup`=13741, `NextQuestInChain`=0 WHERE `entry` IN (13741, 13742, 13743);
UPDATE `quest_template` SET `PrevQuestId`=-13717, `NextQuestId`=0, `ExclusiveGroup`=13757, `NextQuestInChain`=0 WHERE `entry` IN (13757, 13758, 13759);
UPDATE `quest_template` SET `PrevQuestId`=-13715, `NextQuestId`=0, `ExclusiveGroup`=13746, `NextQuestInChain`=0 WHERE `entry` IN (13746, 13747, 13748);
UPDATE `quest_template` SET `PrevQuestId`=-13716, `NextQuestId`=0, `ExclusiveGroup`=13752, `NextQuestInChain`=0 WHERE `entry` IN (13752, 13753, 13754);
-- A Valiant's Field Training
-- The Grand Melee
-- At The Enemy's Gates
UPDATE `quest_template` SET `PrevQuestId`=-13718, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry` IN (13592, 13665, 13847);
UPDATE `quest_template` SET `PrevQuestId`=-13714, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry` IN (13744, 13745, 13851);
UPDATE `quest_template` SET `PrevQuestId`=-13717, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry` IN (13760, 13761, 13855);
UPDATE `quest_template` SET `PrevQuestId`=-13715, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry` IN (13749, 13750, 13852);
UPDATE `quest_template` SET `PrevQuestId`=-13716, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry` IN (13755, 13756, 13854);
-- End Of Valiant Quests
UPDATE `quest_template` SET `PrevQuestId`=13718, `NextQuestId`=13702, `ExclusiveGroup`=0, `NextQuestInChain`=13702 WHERE `entry`=13699;
UPDATE `quest_template` SET `PrevQuestId`=13714, `NextQuestId`=13732, `ExclusiveGroup`=0, `NextQuestInChain`=13732 WHERE `entry`=13713;
UPDATE `quest_template` SET `PrevQuestId`=13717, `NextQuestId`=13735, `ExclusiveGroup`=0, `NextQuestInChain`=13735 WHERE `entry`=13725;
UPDATE `quest_template` SET `PrevQuestId`=13715, `NextQuestId`=13733, `ExclusiveGroup`=0, `NextQuestInChain`=13733 WHERE `entry`=13723;
UPDATE `quest_template` SET `PrevQuestId`=13716, `NextQuestId`=13734, `ExclusiveGroup`=0, `NextQuestInChain`=13734 WHERE `entry`=13724;
-- A Champion Rises (Final Quest)
UPDATE `quest_template` SET `PrevQuestId`=13699, `NextQuestId`=13794, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13702;
UPDATE `quest_template` SET `PrevQuestId`=13713, `NextQuestId`=13794, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13732;
UPDATE `quest_template` SET `PrevQuestId`=13725, `NextQuestId`=13794, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13735;
UPDATE `quest_template` SET `PrevQuestId`=13723, `NextQuestId`=13794, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13733;
UPDATE `quest_template` SET `PrevQuestId`=13734, `NextQuestId`=13794, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13734;
-- Debug Quest Requirements
UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `entry` IN (13718, 13714, 13717, 13715, 13716);
UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `entry` IN (13699, 13713, 13725, 13723, 13724);
UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `entry` IN (13702, 13732, 13735, 13733, 13734);
-- Debug QuestRelation A2
DELETE FROM `creature_questrelation` WHERE `quest` IN (13828, 13672, 13679, 13684, 13685, 13689, 13688, 13690);
INSERT `creature_questrelation` (`id`, `quest`) VALUES 
(33625, 13828), 
(33625, 13672), 
(33625, 13679), 
(33625, 13684), 
(33625, 13685), 
(33625,13689), 
(33625, 13688), 
(33625, 13690);

-- -----------------------------------------------
-- QUEST GRAL. UPDATE
-- -----------------------------------------------
-- Black Night chain
UPDATE `quest_template` SET `PrevQuestId`=0, `NextQuestId`=13641, `ExclusiveGroup`=13633, `NextQuestInChain`=13641 WHERE `entry` IN (13633, 13634);
UPDATE `quest_template` SET `PrevQuestId`=0, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=13643 WHERE `entry`=13641;
UPDATE `quest_template` SET `PrevQuestId`=13641, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=13654 WHERE `entry`=13643;
UPDATE `quest_template` SET `PrevQuestId`=13643, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=13663 WHERE `entry`=13654;
UPDATE `quest_template` SET `PrevQuestId`=13654, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=13664 WHERE `entry`=13663;
UPDATE `quest_template` SET `PrevQuestId`=13663, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=14016 WHERE `entry`=13664;
UPDATE `quest_template` SET `PrevQuestId`=13664, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=14017 WHERE `entry`=14016;
UPDATE `quest_template` SET `PrevQuestId`=14016, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=14017;
-- Champion Dailies
UPDATE `quest_template` SET `PrevQuestId`=0, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13794; -- Eadric the Pure 
UPDATE `quest_template` SET `PrevQuestId`=0, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13795; -- The Scourgebane
-- Among The Champions
UPDATE `quest_template` SET `RequiredRaces`=1101, `PrevQuestId`=13794, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13790; -- Alliance Among The Champions
UPDATE `quest_template` SET `RequiredRaces`=1101, `PrevQuestId`=13795, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13793; -- Alliance DK Among The Champions
UPDATE `quest_template` SET `RequiredRaces`=690, `PrevQuestId`=13794, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13811; -- Horde Among The Champions
UPDATE `quest_template` SET `RequiredRaces`=690, `PrevQuestId`=13795, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13814; -- Horde DK Among The Champions
-- Battle Before The Citadel
UPDATE `quest_template` SET `RequiredRaces`=1101, `PrevQuestId`=13794, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13861; -- Alliance Battle Before The Citadel
UPDATE `quest_template` SET `RequiredRaces`=1101, `PrevQuestId`=13795, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13864; -- Alliance DK Battle Before The Citadel
UPDATE `quest_template` SET `RequiredRaces`=690, `PrevQuestId`=13794, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13862; -- Horde Battle Before The Citadel
UPDATE `quest_template` SET `RequiredRaces`=690, `PrevQuestId`=13795, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13863; -- Horde DK Battle Before The Citadel
-- Taking Battle To The Enemy
UPDATE `quest_template` SET `RequiredRaces`=1101, `PrevQuestId`=13794, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13789; -- Alliance Taking Battle To The Enemy
UPDATE `quest_template` SET `RequiredRaces`=1101, `PrevQuestId`=13795, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13791; -- Alliance DK Taking Battle To The Enemy
UPDATE `quest_template` SET `RequiredRaces`=690, `PrevQuestId`=13794, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13810; -- Horde Taking Battle To The Enemy
UPDATE `quest_template` SET `RequiredRaces`=690, `PrevQuestId`=13795, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13813; -- Horde DK Taking Battle To The Enemy
-- Threat From Above
UPDATE `quest_template` SET `RequiredRaces`=1101, `PrevQuestId`=13794, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13682; -- Alliance Threat From Above
UPDATE `quest_template` SET `RequiredRaces`=1101, `PrevQuestId`=13795, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13788; -- Alliance DK Threat From Above
UPDATE `quest_template` SET `RequiredRaces`=690, `PrevQuestId`=13794, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13809; -- Horde Threat From Above
UPDATE `quest_template` SET `RequiredRaces`=690, `PrevQuestId`=13795, `NextQuestId`=0, `ExclusiveGroup`=0, `NextQuestInChain`=0 WHERE `entry`=13812; -- Horde DK Threat From Above
-- Crusader dailies
-- Mistcaller Yngvar
-- Drottinn Hrothgar
-- Ornolf The Scarred
-- Deathspeaker Kharos
UPDATE `quest_template` SET `ExclusiveGroup`=14102, `NextQuestId`=0, `NextQuestInChain`=0 WHERE `entry` IN (14102, 14101, 14104, 14105);
-- The Fate Of The Fallen
-- Get Kraken!
-- Identifying the Remains
UPDATE `quest_template` SET `ExclusiveGroup`=14107, `NextQuestId`=0, `NextQuestInChain`=0 WHERE `entry` IN (14107, 14108, 14095);
-- Covenant Quests
UPDATE `quest_template` SET `PrevQuestId`=13700, `RequiredMinRepFaction`=1094, `RequiredMinRepValue`=42000, `NextQuestId`=0, `NextQuestInChain`=0 WHERE `entry` IN (14112, 14076, 14090, 14096, 14152, 14080, 14077, 14074); -- Alliance
UPDATE `quest_template` SET `PrevQuestId`=13701, `RequiredMinRepFaction`=1124, `RequiredMinRepValue`=42000, `NextQuestId`=0, `NextQuestInChain`=0 WHERE `entry` IN (14145, 14092, 14141, 14142, 14136, 14140, 14144, 14143); -- Horde
-- What Do You Feed A Yeti, Anyway?
-- Breakfast Of Champions
-- Gormok Wants His Snobolds
UPDATE `quest_template` SET `ExclusiveGroup`=14112 WHERE `entry` IN (14112, 14145, 14076, 14092, 14090, 14141); -- A1, H1, A2, H2, A3, H3
-- You've Really Done It This Time, Kul
-- Rescue At Sea
-- Stop The Agressors
-- The Light's Mercy
-- A Leg Up
UPDATE `quest_template` SET `ExclusiveGroup`=14152 WHERE `entry` IN (14152, 14136, 14080, 14140, 14077, 14144, 14074, 14143); -- A1, H1, A2, H2, A3, H3, A4, H4
-- Champion Marker
UPDATE `quest_template` SET `NextQuestId`=13846, `ExclusiveGroup`=13700 WHERE `entry` IN (13700, 13701); -- Alliance, Horde
-- Contributin' To The Cause
UPDATE `quest_template` SET `RequiredMaxRepFaction`=1106, `RequiredMaxRepValue`=42000 WHERE `entry`=13846;
-- Goblin Dailies Removing
-- The Blastbolt Brothers
-- A Chip Off the Ulduar Block
-- Jack Me Some Lumber
DELETE FROM `creature_questrelation` WHERE `quest` IN (13820, 13681, 13627);
-- DK Quests Restrictions
-- The Scourgebane
-- Taking Battle To The Enemy (A, H)
-- Threat From Above (A, H)
-- Among the Champions (A, H)
-- Battle Before The Citadel (A, H)
UPDATE `quest_template` SET `SkillOrClassMask`=-32 WHERE `entry` IN (13795, 13791, 13813, 13788, 13812, 13793, 13814, 13864, 13863);
-- Non DK Quests Restrictions
-- Eadric The Pure
-- Taking Battle To The Enemy (A, H)
-- Threat From Above (A, H)
-- Among the Champions (A, H)
-- Battle Before The Citadel (A, H)
UPDATE `quest_template` SET `SkillOrClassMask`=-1503 WHERE `entry` IN (13794, 13788, 13789, 13810, 13682, 13809, 13790, 13811, 13861, 13862);
-- Quest A Blade Fit For A Champion: 13603, 13666, 13673, 13741, 13746, 13752, 13757, 13762, 13768, 13773, 13778, 13783
-- Lake Frog
-- Maiden Of Ahswood Lake
UPDATE `creature_template` SET `ScriptName` = 'npc_lake_frog' WHERE `entry` =33211;
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1, `ScriptName` = 'npc_maiden_of_ashwood_lake' WHERE `creature_template`.`entry` =33220;
DELETE FROM `creature` WHERE `id` =33211;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`)
VALUES 
('33211','571','1','1','0','0','3725.43','-4311.13','180.978','2.05551','300','0','0','40','120','0','0');-- Spawn Rana Quest (faltante añadir movimiento por la laguna con waypoints).
DELETE FROM `script_texts` WHERE `entry` = -1850015;
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES 
('0','-1850015','Can it really be? Free after all these years?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','');

-- frog speed from sniff
UPDATE `creature_template` SET `speed_run` = 1 WHERE `entry` = 33211;
UPDATE `creature_template` SET `speed_walk` = 1.6 WHERE `entry` = 33211;
-- Quest : Le fil de l'hiver
DELETE FROM `creature` WHERE `guid` = '336364';
INSERT INTO `creature` (`guid`,`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES  
(336364,33289,571,1,1,0,0,5136.74,-83.3769,347.326,1.44434,300,0,0,12600,3994,0,0);
DELETE FROM `creature_loot_template` WHERE `entry`=33289 AND `item`=45005;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`) VALUES (33289, 45005, -100);
DELETE FROM `script_texts` WHERE `entry` IN (-1850000,-1850001,-1850002,-1850003);
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc2`,`comment`) VALUES
(0, -1850000, 'Oh, these are winter hyacinths? For me ?', 'Oh, these are hyacinth\'s winter? For me  ?',''),
(0, -1850001, 'We had not had brought flowers here for so long.', 'We had not had brought flowers here for so long.',''),
(0, -1850002, 'The lake is a lonely spot for some years. Travelers have stopped coming over, and evil has invaded the waters.', 'The lake is a lonely spot some years. Travelers to come over, and evil has invaded the waters.',''),
(0, -1850003, 'Your gift shows a rare kindness, traveler. Please, take this blade as a token of my gratitude. Long ago, there was another traveler who had left it here, but I do not need it. ',' Your gift shows a rare kindness, traveler. Please, take this blade as a token of my gratitude. Long ago, there was another traveler who had left it here, but I do not need it.','');
DELETE FROM `event_scripts` WHERE `id`=20990;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) 
VALUES (20990, 0, 10, 33273, 42000, 4602.977, -1600.141, 156.7834, 0.7504916);

UPDATE `creature_template` SET `InhabitType`=5, `ScriptName`='npc_maiden_of_drak_mar' WHERE `entry`=33273;

DELETE FROM `creature_template_addon` WHERE `entry`=33273;
INSERT INTO `creature_template_addon` (`entry`, `emote`) VALUES (33273, 13); -- 13 = EMOTE_STATE_SIT
-- Quest : 
UPDATE `creature_template` SET `faction_A`=16,`faction_H`=16 WHERE `entry` IN (29720,29719,29722);
DELETE FROM `creature` WHERE `id` IN (29720,29719,29722);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 29720, 571, 1, 1, 0, 0, 8562.48, 2771.93, 759.958, 6.10672, 300, 15, 0, 12175, 0, 0, 1),
(NULL, 29720, 571, 1, 1, 0, 0, 8584.64, 2760.8, 759.958, 2.59599, 300, 15, 0, 12600, 0, 0, 1),
(NULL, 29720, 571, 1, 1, 0, 0, 8617.49, 2735.11, 759.958, 2.32895, 300, 15, 0, 12175, 0, 0, 1),
(NULL, 29720, 571, 1, 1, 0, 0, 8420.8, 2688.71, 759.957, 1.33806, 300, 15, 0, 12600, 0, 0, 1),
(NULL, 29719, 571, 1, 1, 0, 0, 8417.11, 2641.07, 759.957, 1.57604, 300, 15, 0, 12600, 0, 0, 1),
(NULL, 29719, 571, 1, 1, 0, 0, 8435.89, 2596.91, 759.957, 2.30577, 300, 15, 0, 12175, 0, 0, 1),
(NULL, 29720, 571, 1, 1, 0, 0, 8477.25, 2565.16, 759.957, 2.51783, 300, 15, 0, 12175, 0, 0, 1),
(NULL, 29719, 571, 1, 1, 0, 0, 8522.14, 2556.99, 759.957, 3.11709, 300, 15, 0, 12175, 0, 0, 1),
(NULL, 29720, 571, 1, 1, 0, 0, 8571.58, 2559.95, 759.957, 4.05564, 300, 0, 0, 12600, 0, 0, 0),
(NULL, 29720, 571, 1, 1, 0, 0, 8609.24, 2589.19, 759.958, 0.155352, 300, 15, 0, 12175, 0, 0, 1),
(NULL, 29719, 571, 1, 1, 0, 0, 8637.35, 2651.77, 759.958, 4.15303, 300, 15, 0, 12600, 0, 0, 1),
(NULL, 29719, 571, 1, 1, 0, 0, 8636.85, 2679.47, 759.958, 4.93842, 300, 15, 0, 12175, 0, 0, 1);
-- Quest Support Among the Champions 13790-13811-13793-13814
UPDATE `creature_template` SET `ScriptName`='npc_valiant', `dmg_multiplier`=2 WHERE `entry` IN (33285,33306,33384,33383,33382,33739,33749,33745,33744,33748,33740,33743,33747,33738,33746,33561,33558,33559,33562);
-- Fix Quest The Seer's Crystal - It Could Kill Us All
UPDATE `creature_template` SET `lootid`=33422,`mingold`=1584,`maxgold`=2640 WHERE `entry`=33422;
DELETE FROM `creature_loot_template` WHERE `entry`=33422;
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(33422,45064,-17,1,0,1,1);
-- Quest Gormok Wants His Snobolds
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-7033,-7035,-7034);
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=29618;
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` =29618;
INSERT INTO `creature_ai_scripts`(`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
(77770084,29618,8,0,100,1,66474,-1,6000,6000,33,34899,6,0,22,1,0,0,0,0,0,0,'Snowblind Follower Proxy credit - q14141 q14090'),
(77770085,29618,0,1,100,1,4000,4000,6000,6000,23,-1,0,0,41,0,0,0,0,0,0,0,'Snowblind Follower Proxy credit - q14141 q14090'),
(77770086,29618,1,1,100,1,4000,4000,6000,6000,23,-1,0,0,41,0,0,0,0,0,0,0,'Snowblind Follower Proxy credit - q14141 q14090'),
(77770087,29618,0,1,100,1,2000,2000,6000,6000,1,-7033,-7034,-7035,0,0,0,0,0,0,0,0,'Snowblind Follower say - q14141 q14090'),
(77770088,29618,1,1,100,1,2000,2000,6000,6000,1,-7033,-7034,-7035,0,0,0,0,0,0,0,0,'Snowblind Follower say - q14141 q14090');
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
(-7033,'You no take... me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,5,'c29618 Snowblind Follower - q14141 q14090'),
(-7034,'No! Me not afraid! Grrrrr! No kill me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,5,'c29618 Snowblind Follower - q14141 q14090'),
(-7035,'Net not stop me! No... net stop me',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,5,'c29618 Snowblind Follower - q14141 q14090');
-- Quest A Worthy Weapon A/H (daily) 13600-13669-13674-13742-13747-13753-13758-13763-13769-13774-13779-13784
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-7012,-7011);
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=33273;
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 33273;
INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
(77770019,33273,1,0,100,1,17000,17000,60000,60000,1,-7011,0,0,0,0,0,0,0,0,0,0,'Maiden of Drak\'Mar - all quest named \&quot;A Worthy Weapon\&quot;'),
(77770020,33273,1,0,100,1,9000,9000,60000,60000,1,-7012,0,0,0,0,0,0,0,0,0,0,'Maiden of Drak\'Mar - all quest named \&quot;A Worthy Weapon\&quot;');
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
(-7012,'It\'s been so long since a traveler has come here bearing flowers.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,1,'c33273 Maiden of Drak\'Mar - all quest named \&quot;A Worthy Weapon\&quot;'),
(-7011,'The lake has been too lonely these past years. The travelers stopped coming and evil came to these waters.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,1,'c33273 Maiden of Drak\'Mar - all quest named \&quot;A Worthy Weapon\&quot;');
DELETE FROM `gameobject` WHERE `id` =300009;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`)VALUES 
('300009','571','1','1','4601.68','-1601.91','156.659','1.0243','0','0','0.490051','0.871694','1','0','1');
-- Quest The Grand Melee Quests 13665-13745-13750-13756-13761-13767-13772-13777-13782-13787.- http://www.wowhead.com/search?q=The+Grand+Melee 
UPDATE `creature_template` SET `ScriptName`='npc_ValiantGrandMelee' WHERE `entry` IN (33561,33564,33558,33559,33562);
-- Quest The Valiant's Challenge 13699-13713-13723-13724-13725-13726-13727-13728-13729-13731. 
UPDATE `creature_template` SET `ScriptName`='npc_squire_danny' WHERE `entry` = 33518;
UPDATE `creature_template` SET `faction_a`=14,`faction_h`=14,`movementId`=48,`ScriptName`='npc_argent_champion' WHERE `entry` = 33707;
DELETE FROM `creature_template_addon` WHERE `entry`=33707;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
('33707','0','28918','0','0','0',NULL);-- Montura no es la original porfavor cambiar.
DELETE FROM `script_texts` WHERE `entry` IN (-1850013,-1850014);
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES 
('0','-1850013','You believe you are ready to be a champion? Defend yourself!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0',''),
('0','-1850014','Most impressive. You are worthy to gain the rank of champion!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','');

-- Fix Quest There's Something About the Squire (http://www.wowhead.com/quest=13654)
-- http://code.google.com/p/madboxpcwow/issues/detail?id=169&sort=-id#makechanges
UPDATE `creature_template` SET `scriptname`='npc_maloric' WHERE `entry`=33498;
-- Creature Script
UPDATE creature_template SET scriptname='npc_maloric' WHERE entry=33498;
-- Conditions
DELETE FROM `conditions` WHERE `SourceEntry` = 63124 AND `ConditionValue1` = 33498;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ErrorTextId`,`Comment`) VALUES 
(17,63124,1,19,33498,447,'Item Large Femur - Npc Maloric');
-- loot item Large Femur
UPDATE `creature_template` SET lootid = 33499 WHERE `entry` = 33499;
DELETE FROM `creature_loot_template` WHERE `item` = 45080;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('33499','45080','-100','1','0','1','1');
-- Spawn
UPDATE `creature_template` SET MovementType = 1 WHERE `entry` = '33499';
DELETE FROM `creature` WHERE `id` = '33499';
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
('33499','571','1','1','0','1858','5470.29','400.611','160.27','5.40927','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5478.44','369.635','152.741','5.60091','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5456.16','335.95','154.495','5.24198','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5380.89','373.719','173.494','5.53258','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5417.8','337.264','161.858','4.87128','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5450.22','317.678','153.375','5.7957','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5427.31','285.311','155.185','5.34723','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5446.45','250','151.935','6.22845','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5379','238.12','166.777','5.09198','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5419.02','200.04','153.596','5.89073','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5365.49','173.051','163.403','5.81062','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5421.02','149.316','150.516','0.0583642','300','5','0','12175','0','0','1'),
('33499','571','1','1','0','1858','5443.25','371.767','163.366','4.35449','300','5','0','12175','0','0','1');

SET @Guid=1000141; -- SELECT creature.guid FROM creature ORDER BY creature.guid DESC LIMIT 1;
DELETE FROM `creature` WHERE id=33429;
INSERT INTO `creature` (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(@Guid+0,33429,571,1,256,0,0,6253.47,2263.21,244.456,0.488692,120,0,0,1,0,0,0,0,0,0),
(@Guid+1,33429,571,1,256,0,0,6217.16,2252.59,496.038,0.488692,120,0,0,1,0,0,0,0,0,0),
(@Guid+2,33429,571,1,256,0,0,6234.1,2301.56,488.447,0.488692,120,0,0,1,0,0,0,0,0,0),
(@Guid+3,33429,571,1,256,0,0,6163.18,2231.77,506.981,0.488692,120,0,0,1,0,0,0,0,0,0),
(@Guid+4,33429,571,1,256,0,0,6172.18,2257.27,503.146,0.488692,120,0,0,1,0,0,0,0,0,0),
(@Guid+5,33429,571,1,256,0,0,6242.42,2246.47,491.941,0.56266,120,0,0,1,0,0,0,0,0,0),
(@Guid+6,33429,571,1,256,0,0,6202.35,2284.08,495.286,0.488692,120,0,0,1,0,0,0,0,0,0),
(@Guid+7,33429,571,1,256,0,0,6145.68,2208.17,512.426,0.488692,120,0,0,1,0,0,0,0,0,0);
-- Template updates for creature 33429 (Boneguard Lieutenant)
UPDATE `creature_template` SET speed_run=2 WHERE entry=33429; -- Boneguard Lieutenant
-- Model data 29098 (creature 33429 (Boneguard Lieutenant))
UPDATE creature_model_info SET bounding_radius=0.459,combat_reach=2.25,gender=0 WHERE modelid=29098; -- Boneguard Lieutenant
-- Addon data for creature 33429 (Boneguard Lieutenant)
DELETE FROM creature_template_addon WHERE entry=33429;
INSERT INTO creature_template_addon (entry,mount,bytes1,bytes2,emote,auras) VALUES
(33429,25678,0,1,0,NULL); -- Boneguard Lieutenant






-- Fix for Quest 12243 Fire on the Water
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 48455;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (48455, 50290, 'Apothecary\'s Burning Water');
UPDATE `creature_template` SET `lootid`=27232 WHERE `entry`=27232 LIMIT 1;
DELETE FROM `creature_loot_template` WHERE `entry` =27232;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`)
VALUES
(27232, 45912, 0.1, 1, 0, 1, 1),
(27232, 37304, -100, 1, 0, 1, 1),
(27232, 43851, 27, 1, 0, 1, 1),
(27232, 33470, 14, 1, 0, 1, 3),
(27232, 33443, 4, 1, 0, 1, 1),
(27232, 22829, 2, 1, 0, 1, 1),
(27232, 33444, 2, 1, 0, 1, 1);

-- Fix Quest 'Catching up with Brann' #12920
SET @Brann  = 29579;
SET @Quest  = 12920;
UPDATE `creature_template` SET `gossip_menu_id` = @Brann, `npcflag` = `npcflag` | 1, `AIName` = 'SmartAI' WHERE `entry` = @Brann;
-- creature text
DELETE FROM `creature_text` WHERE `entry` = @Brann;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@Brann,1,0,"I... I can understand you now! Well, now that we can talk to each other, you have some explaining to do!",0,0,100,1,0,0,'Brann Bronzebeard text1'),
(@Brann,2,0,"How did you get my communicator from the Explorers' League?",0,0,100,1,5,0,'Brann Bronzebeard text2'),
(@Brann,3,0,"If the Explorers' League sent men, I didn't see any trace of them. I found your note buried in a camp overrun by iron dwarves.",0,0,100,1,0,0,'Player text3'),
(@Brann,4,0,"You have my thanks for dispatching the iron dwarves. But why would the Horde have an interest in me?",0,0,100,1,0,0,'Brann Bronzebeard text4'),
(@Brann,5,0,"A scout found the remains of your journal in Thor Modan. We've been looking for you ever since.",0,0,100,1,0,0,'Player text5'),
(@Brann,6,0,"That wouldn't be Scout Vor'takh, would it? Even I know of his reputation for ruthlessness. He means to abduct me, then?",0,0,100,1,0,0,'Brann Bronzebeard text6'),
(@Brann,7,0,"If you've seen the journal, then you know what I've been discovering. The titans' own creations are at war with each other!",0,0,100,1,0,0,'Brann Bronzebeard text7'),
(@Brann,8,0,"Loken and his iron dwarf minions have ousted the Earthen from Ulduar and taken over the city.",0,0,100,1,0,0,'Brann Bronzebeard text8'),
(@Brann,9,0,"If we spend our time and strength fighting with each other, Loken will use Ulduar's resources to destroy both Horde and Alliance.",0,0,100,1,0,0,'Brann Bronzebeard text9'),
(@Brann,10,0,"Speak to the commander at your post, lad, and persuade him to abandon Vor'takh's foolish plan.",0,0,100,1,0,0,'Brann Bronzebeard text10');
-- gossip_menu_option
DELETE FROM `gossip_menu_option` WHERE `menu_id` = @Brann;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`) VALUES
(@Brann,0,0,"Do you understand me? We should be able to understand each other now.",1,1,0,0,0,0,0,'');
-- SmartAI
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` = @Brann;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid` = @Brann*100;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@Brann,0,0,0,62,0,100,0,@Brann,0,0,0,80,@Brann*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'on gossip select - start script1'),
-- script1
(@Brann*100,9,0,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'turn off gossip & questgiver flag'),
(@Brann*100,9,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,23,0,0,0,0,0,0,0,'turn to invoker'),
(@Brann*100,9,2,0,0,0,100,0,1000,1000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'say text1'),
(@Brann*100,9,3,0,0,0,100,0,4000,4000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'say text2'),
(@Brann*100,9,4,0,0,0,100,0,6000,6000,0,0,84,3,0,0,0,0,0,7,0,0,0,0,0,0,0,'player say text3'),
(@Brann*100,9,5,0,0,0,100,0,9000,9000,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'say text4'),
(@Brann*100,9,6,0,0,0,100,0,7000,7000,0,0,84,5,0,0,0,0,0,7,0,0,0,0,0,0,0,'player say text5'),
(@Brann*100,9,7,0,0,0,100,0,6000,6000,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,'say text6'),
(@Brann*100,9,8,0,0,0,100,0,7000,7000,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,'say text7'),
(@Brann*100,9,9,0,0,0,100,0,8000,8000,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,'say text8'),
(@Brann*100,9,10,0,0,0,100,0,6000,6000,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,'say text9'),
(@Brann*100,9,11,0,0,0,100,0,9000,9000,0,0,1,10,0,0,0,0,0,1,0,0,0,0,0,0,0,'say text10'),
(@Brann*100,9,12,0,0,0,100,0,3000,3000,0,0,33,@Brann,0,0,0,0,0,7,0,0,0,0,0,0,0,'give quest credit'),
(@Brann*100,9,13,0,0,0,100,0,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'turn on gossip & questgiver flag');
-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = @Brann;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,@Brann,0,0,9,@Quest,0,0,0,'', 'show gossip menu option if player has quest 12920');


-- QUEST 12998 "The Heart of the Storm"
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=192181;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_H`=1954, `faction_A`=1954, `unit_flags`=768, `equipment_id`=749, `flags_extra`=2 WHERE `entry`=30299;

-- Spawn GO
DELETE FROM `gameobject` WHERE `id` = 192181;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(192181,571,1,1,7308.97,-727.868,791.609,1.56851,0,0,0.706299,0.707914,300,0,1);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (30299,3029900,192181,19218100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Overseer Narvir script
(30299,0,0,0,25,0,100,0,0,0,0,0,80,3029900,0,2,0,0,0,1,0,0,0,0,0,0,0, 'On summon Overseer Narvir start script'),
(3029900,9,0,0,0,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Set react passive'),
(3029900,9,1,0,0,0,100,0,500,500,0,0,69,0,0,0,0,0,0,8,0,0,0,7313.045,-726.853,791.610,0, 'Walk to the Heart of the Storm'),
(3029900,9,2,0,0,0,100,0,6500,6500,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,2.437, 'Set orientation'),
(3029900,9,3,0,0,0,100,0,2000,2000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Overseer Narvir say text 0'),
(3029900,9,4,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Overseer Narvir say text 1'),
(3029900,9,5,0,0,0,100,0,6000,6000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3.334, 'Set orientation'),
(3029900,9,6,0,0,0,100,0,500,500,0,0,17,133,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Loot the heart'),
(3029900,9,7,0,0,0,100,0,5000,5000,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Stop looting'),
(3029900,9,8,0,0,0,100,0,1500,1500,0,0,5,463,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Disappear emote'),
(3029900,9,9,0,0,0,100,0,500,500,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn'),
-- Heart of the Storm script
(192181,1,0,0,64,0,100,0x01,0,0,0,0,80,19218100,0,2,0,0,0,1,0,0,0,0,0,0,0, 'On use start script'),
(19218100,9,0,0,0,0,100,0,1000,1000,0,0,12,30299,1,60000,0,0,0,8,0,0,0,7312.130,-710.919,791.610,4.643, 'Summon Overseer Narvir'),
(19218100,9,1,0,0,0,100,0,0,0,0,0,75,56485,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Cyclone the invoker'),
(19218100,9,2,0,0,0,100,0,27000,27000,0,0,33,30299,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Give quest credit');

DELETE FROM `creature_text` WHERE `entry`=30299;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(30299,0,0,'You didn\'t think that I was going to let you walk in here and take the Heart of the Storm, did you?',0,0,100,6,0,0,'Narvir text 0'),
(30299,1,0,'You may have killed Valduran, but that will not stop me from completing the colossus.',0,0,100,274,0,0,'Narvir text 1');

-- Quest 12291 "The Forgotten Tale"
-- SAI for Forgotten Knight, Forgotten Rifleman, Forgotten Peasant, Forgotten Footman, Orik, & Forgotten Soul
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry` IN (27224,27225,27226,27229,27220,27347,27465);
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (27224,27225,27226,27229,27220,27347,27465);
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (27224,27225,27226,27229,27220,27347,27465);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Forgotten Knight
(27224,0,0,1,62,0,100,0,9544,0,0,0,11,48831,3,0,0,0,0,7,0,0,0,0,0,0,0, 'Forgotten Knight - On gossip option select quest credit'),
(27224,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Forgotten Knight - Close Gossip'),
(27224,0,2,0,23,0,100,0,48143,0,0,0,11,48143,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Knight - Add Forgotten Aura if missing'),
(27224,0,3,4,4,0,100,0,0,0,0,0,11,38556,1,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Knight - Cast Throw on Aggro'),
(27224,0,4,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Knight - Set Phase 1 on Aggro'),
(27224,0,5,6,0,1,100,0,5,35,2300,3900,11,38556,1,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Knight - Cast Throw (Phase 1)'),
(27224,0,6,0,61,1,100,0,0,0,0,0,40,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Knight - Set Ranged Weapon Model (Phase 1)'),
(27224,0,7,8,9,1,100,0,25,80,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Knight - Start Combat Movement at 25 Yards (Phase 1)'),
(27224,0,8,0,61,1,100,0,0,0,0,0,20,1,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Knight - Start Melee at 25 Yards (Phase 1)'),
(27224,0,9,10,9,1,100,0,0,5,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Knight - Start Combat Movement Below 5 Yards (Phase 1)'),
(27224,0,10,11,61,1,100,0,0,0,0,0,40,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Knight - Set Ranged Weapon Model Below 5 Yards (Phase 1)'),
(27224,0,11,0,61,1,100,0,0,0,0,0,20,1,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Knight - Start Melee Below 5 Yards (Phase 1)'),
(27224,0,12,13,9,1,100,0,5,15,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Knight - Prevent Combat Movement at 15 Yards (Phase 1)'),
(27224,0,13,0,61,1,100,0,0,0,0,0,20,0,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Knight - Prevent Melee at 15 Yards (Phase 1)'),
(27224,0,14,0,7,0,100,0,0,0,0,0,40,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Knight - Set Melee Weapon Model on Evade'),
-- Forgotten Rifleman
(27225,0,0,1,62,0,100,0,9543,0,0,0,11,48830,3,0,0,0,0,7,0,0,0,0,0,0,0, 'Forgotten Rifleman - On gossip option select quest credit'), 
(27225,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Forgotten Rifleman - Close Gossip'), 
(27225,0,2,3,11,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Prevent Combat Movement on Spawn'),
(27225,0,3,0,61,0,100,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Prevent Melee on Spawn'),
(27225,0,4,0,23,0,100,0,48143,0,0,0,11,48143,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Add Forgotten Aura if missing'),
(27225,0,5,6,4,0,100,0,0,0,0,0,11,15547,1,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Rifleman - Cast Shoot on Aggro'),
(27225,0,6,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Set Phase 1 on Aggro'),
(27225,0,7,8,0,1,100,0,5,30,2300,3900,11,15547,1,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Rifleman - Cast Shoot (Phase 1)'),
(27225,0,8,0,61,1,100,0,0,0,0,0,40,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Set Ranged Weapon Model (Phase 1)'),
(27225,0,9,0,0,1,100,0,9000,12000,9000,14000,11,17174,1,1,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Rifleman - Cast Concussive Shot (Phase 1)'),
(27225,0,10,11,9,1,100,0,25,80,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Start Combat Movement at 25 Yards (Phase 1)'),
(27225,0,11,0,61,1,100,0,0,0,0,0,20,1,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Rifleman - Start Melee at 25 Yards (Phase 1)'),
(27225,0,12,13,9,1,100,0,0,5,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Start Combat Movement Below 5 Yards (Phase 1)'),
(27225,0,13,14,61,1,100,0,0,0,0,0,40,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Set Ranged Weapon Model Below 5 Yards (Phase 1)'),
(27225,0,14,0,61,1,100,0,0,0,0,0,20,1,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Rifleman - Start Melee Below 5 Yards (Phase 1)'),
(27225,0,15,16,9,1,100,0,5,15,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Prevent Combat Movement at 15 Yards (Phase 1)'),
(27225,0,16,0,61,1,100,0,0,0,0,0,20,0,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Rifleman - Prevent Melee at 15 Yards (Phase 1)'),
(27225,0,17,0,2,1,100,0,0,15,0,0,23,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Set Phase 2 at 15% HP'),
(27225,0,18,19,2,2,100,0,0,15,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Start Combat Movement at 15% HP (Phase 2)'),
(27225,0,19,20,61,2,100,0,0,0,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Flee at 15% HP (Phase 2)'),
(27225,0,20,21,61,2,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - Say text0 at 15% HP (Phase 2)'),
(27225,0,21,0,61,2,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Rifleman - set phase 1 at 15% HP (Phase 2)'),
(27225,0,22,0,7,0,100,0,0,0,0,0,40,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Knight - Set Melee Weapon Model on Evade'),                              
-- Forgotten Peasant
(27226,0,0,1,62,0,100,0,9541,0,0,0,11,48829,3,0,0,0,0,7,0,0,0,0,0,0,0, 'Forgotten Peasant - On gossip option select quest credit'),
(27226,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Forgotten Peasant - Close Gossip'),
(27226,0,2,0,23,0,100,0,48143,0,0,0,11,48143,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Peasant - Add Forgotten Aura if missing'),
(27226,0,3,0,0,0,100,0,0,5,7000,10000,11,51601,1,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Peasant - Cast Bonk'),
-- Forgotten Footman
(27229,0,0,1,62,0,100,0,9545,0,0,0,11,48832,3,0,0,0,0,7,0,0,0,0,0,0,0, 'Forgotten Footman - On gossip option select quest credit'),
(27229,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Forgotten Footman - Close Gossip'),
(27229,0,2,0,23,0,100,0,48143,0,0,0,11,48143,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Footman - Add Forgotten Aura if missing'),
(27229,0,3,0,0,0,100,0,3000,7000,9000,12000,11,32587,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Forgotten Footman - Cast Shield Block'),
-- Forgotten Captain
(27220,0,0,0,23,0,100,0,48143,0,0,0,11,48143,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Captain - Add Forgotten Aura if missing'),
(27220,0,1,0,0,0,100,0,6000,9000,8000,12000,11,51591,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Forgotten Captain - Cast Stormhammer'),
-- Orik
(27347,0,0,1,62,0,100,0,9542,0,0,0,11,48828,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Orik - On gossip option select create Murkweed Elixir'),
(27347,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Orik - Close Gossip'),
-- Forgotten Soul
(27465,0,0,0,11,0,100,0,0,0,0,0,11,29266,3,0,0,0,0,1,0,0,0,0,0,0,0, 'Forgotten Soul - On aura self');

-- Assign Gossip_id's to creatures
UPDATE `creature_template` SET `gossip_menu_id`=9544 WHERE `entry`=27224; -- Forgotten Knight
UPDATE `creature_template` SET `gossip_menu_id`=9543 WHERE `entry`=27225; -- Forgotten Rifleman
UPDATE `creature_template` SET `gossip_menu_id`=9541 WHERE `entry`=27226; -- Forgotten Peasant
UPDATE `creature_template` SET `gossip_menu_id`=9545 WHERE `entry`=27229; -- Forgotten Footman
UPDATE `creature_template` SET `gossip_menu_id`=9542 WHERE `entry`=27347; -- Orik
-- Add gossip menu items
DELETE FROM `gossip_menu` WHERE `entry`=9544  AND `text_id`=12859;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9544,12859);
DELETE FROM `gossip_menu` WHERE `entry`=9543  AND `text_id`=12858;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9543,12858);
DELETE FROM `gossip_menu` WHERE `entry`=9541  AND `text_id`=12856;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9541,12856);
DELETE FROM `gossip_menu` WHERE `entry`=9545  AND `text_id`=12860;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9545,12860);
DELETE FROM `gossip_menu` WHERE `entry`=9542  AND `text_id`=12857;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9542,12857);

-- Gossip Options
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (9544,9543,9541,9545,9542);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`action_script_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9544,0,0,'I must be going now, soldier. Stay vigilant!',1,1,0,0,0,0,0,''), -- Forgotten Knight
(9543,0,0,'I''m sure Arthas will be back any day now, soldier. Keep your chin up!',1,1,0,0,0,0,0,''), -- Forgotten Rifleman
(9541,0,0,'Sorry to have bothered you, friend. Carry on!',1,1,0,0,0,0,0,''), -- Forgotten Peasant
(9545,0,0,'I''m sure everything will work out, footman.',1,1,0,0,0,0,0,''), -- Forgotten Footman
(9542,0,0,'Orik, I need another Murkweed Elixir.',1,1,0,0,0,0,0,''); -- Orik

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (9544,9543,9541,9545,9542);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,9544,0,0,9,12291,0,0,0,'','Show gossip option 0 if player has Quest 12291 "The Forgotten Tale"'),
(15,9543,0,0,9,12291,0,0,0,'','Show gossip option 0 if player has Quest 12291 "The Forgotten Tale"'),
(15,9541,0,0,9,12291,0,0,0,'','Show gossip option 0 if player has Quest 12291 "The Forgotten Tale"'),
(15,9545,0,0,9,12291,0,0,0,'','Show gossip option 0 if player has Quest 12291 "The Forgotten Tale"'),
(15,9542,0,0,9,12291,0,0,0,'','Show gossip option 0 if player has Quest 12291 "The Forgotten Tale"');

-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry` IN (27225);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27225,0,0, '%s attempts to run away in fear!',2,0,100,0,0,0, 'Forgotten Rifleman');

-- Add spell linking
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (48810,-48809,48143,-48143);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(48810,48809,0,'Cast Binding Life when cast Death''s Door'),
(-48809,-48143,0,'Removing Binding Life removes Forgotten Aura'),
(48143,48357,0,'Aura Wintergarde Invisibility Type B when aura Forgotten Aura'),
(-48143,-48357,0,'Removing Binding Forgotten Aura removes Aura Wintergarde Invisibility Type B');

-- Add See Wintergarde Invisibility Type B Spell to areas in Dragonblight
DELETE FROM `spell_area` WHERE `spell`=48358;
INSERT INTO `spell_area` (`spell`,`area`,`racemask`,`gender`,`autocast`) VALUES
(48358,4151,0,2,1),(48358,4152,0,2,1),(48358,4153,0,2,1),(48358,4154,0,2,1),
(48358,4155,0,2,1),(48358,4156,0,2,1),(48358,4157,0,2,1),(48358,4158,0,2,1),
(48358,4160,0,2,1),(48358,4161,0,2,1),(48358,4162,0,2,1),(48358,4163,0,2,1),
(48358,4164,0,2,1),(48358,4165,0,2,1),(48358,4166,0,2,1),(48358,4167,0,2,1),
(48358,4168,0,2,1),(48358,4169,0,2,1),(48358,4170,0,2,1),(48358,4171,0,2,1),
(48358,4172,0,2,1),(48358,4173,0,2,1),(48358,4174,0,2,1),(48358,4175,0,2,1),
(48358,4176,0,2,1),(48358,4177,0,2,1),(48358,4178,0,2,1),(48358,4179,0,2,1),
(48358,4180,0,2,1),(48358,4181,0,2,1),(48358,4182,0,2,1),(48358,4183,0,2,1),
(48358,4184,0,2,1),(48358,4185,0,2,1),(48358,4186,0,2,1),(48358,4187,0,2,1),
(48358,4188,0,2,1),(48358,4189,0,2,1),(48358,4190,0,2,1),(48358,4191,0,2,1),
(48358,4192,0,2,1),(48358,4193,0,2,1),(48358,4194,0,2,1),(48358,4195,0,2,1),
(48358,4198,0,2,1),(48358,4123,0,2,1),(48358,4124,0,2,1),(48358,4125,0,2,1),
(48358,4127,0,2,1),(48358,4130,0,2,1),(48358,4132,0,2,1),(48358,4133,0,2,1),
(48358,4134,0,2,1),(48358,4141,0,2,1),(48358,4143,0,2,1),(48358,4146,0,2,1),
(48358,4396,0,2,1),(48358,4414,0,2,1),(48358,4478,0,2,1);

-- Quest 11895 "Master the Storm", 
-- Quest 11896 "Weakness to Lightning", 
-- Quest 11907 "The Sub-Chieftains" 
-- Quest 11788 "Lefty Loosey, Righty Tighty"
DELETE FROM `creature` WHERE `id`=26048;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(107478,26048,571,1,1,16988,0,3410.110,4128.981,18.054,5.699,60,0,0,8982,3155,0,0,0,0,0);

DELETE FROM `gameobject` WHERE `id` IN (188109,187987);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(188898,187987,571,1,1,3793.746,4805.559,-12.185,5.667,0,0,0,1,300,100,1),
(188899,188109,571,1,1,3791.950,4804.803,-12.158,4.571,0,0,0,1,300,100,1);

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=26048;
UPDATE `creature_template` SET `unit_flags`=4, `AIName`='SmartAI' WHERE `entry`=26045;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25752;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25753;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25758;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25792;

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=26048;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`) VALUES
(26048,74772,11895,1,0,0,0,0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (26048,2604800,26045,25752,25753,25758,25792);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26048,0,0,0,8,0,100,0,74772,0,0,0,80,2604800,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit start script'),
(2604800,9,0,0,60,0,100,0,0,0,0,0,12,26045,1,60000,0,1,0,8,0,0,0,3399.917,4135.566,18.054,5.699, 'Summon Storm Tempest'),
(2604800,9,1,0,60,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn'),
(26045,0,0,0,25,0,100,0,0,0,0,0,11,35487,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On summon Storm Tempest cast Lightning Cloud'),
(26045,0,1,0,4,0,100,0,0,0,60000,60000,1,0,0,0,0,0,0,2,0,0,0,0,0,0,0, 'On aggro Storm Tempest say text'),
(26045,0,2,0,0,0,100,0,0,0,4000,5000,11,15659,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Storm Tempest cast Chain Lightning'),
(26045,0,3,0,0,0,50,0,0,0,3000,4000,11,31272,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Storm Tempest cast Wind Shock'),
(26045,0,4,0,6,0,100,0,0,0,0,0,85,46424,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On death apply Master the Storm'),
(25752,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25752,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25752,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura'),
(25753,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25753,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25753,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura'),
(25758,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25758,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25758,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura'),
(25792,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25792,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25792,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura');

DELETE FROM `creature_text` WHERE `entry`=26045;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(26045,0,0,'You will not defeat me, puny $R!',0,0,100,0,0,0, 'Storm Tempest text');

DELETE FROM `spell_scripts` WHERE `id` IN (46550);
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(46550,0,0,14,46424,0,0,0,0,0,0);


-- Quest 11324, 11326 "Alpha Worg"
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_H`=14, `faction_A`=14 WHERE `entry`=24277;
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `id`=24210; -- Riven Widow Cocoons disable random movement

DELETE FROM `creature_addon` WHERE `guid`=199999;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(199999,1999990,0,0,0,0,'49415 0'); -- Invisibility and waypoint asignment

DELETE FROM `creature` WHERE `id`=24277;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(199999,24277,571,1,1,22233,0,2461.043,-3099.657,141.533,5.812,300,0,0,13936,0,0,2,0,0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid`=24277;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(24277,0,0,0,0,0,100,0,2000,4000,10000,12000,11,50046,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Gnaw Bone'),
(24277,0,1,0,0,0,100,0,1000,3000,15000,18000,11,13443,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Rend'),
(24277,0,2,0,0,0,100,0,1500,2500,4000,6000,11,31279,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Swipe'),
(24277,0,3,0,0,0,100,0,10000,12000,20000,25000,11,6749,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Wide Swipe'),
(24277,0,4,5,2,0,100,0x01,0,50,0,0,3,0,26791,0,0,0,0,1,0,0,0,0,0,0,0,'Below 50% transform to worgen model'),
(24277,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Say text Garwal');

DELETE FROM `waypoint_data` WHERE `id`=1999990;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(1999990,1,2461.043,-3099.657,141.533,0,0,0,100,0),
(1999990,2,2502.133,-3097.822,134.418,0,0,0,100,0),
(1999990,3,2559.702,-3097.267,121.556,0,0,0,100,0),
(1999990,4,2622.817,-3088.243,120.314,0,0,0,100,0),
(1999990,5,2638.738,-3096.804,121.635,0,0,0,100,0),
(1999990,6,2696.031,-3118.550,110.453,0,0,0,100,0),
(1999990,7,2744.101,-3110.267,115.296,0,0,0,100,0),
(1999990,8,2774.326,-3109.235,111.222,0,0,0,100,0),
(1999990,9,2797.473,-3106.683,110.129,0,0,0,100,0),
(1999990,10,2831.518,-3105.365,100.868,0,0,0,100,0),
(1999990,11,2847.851,-3089.628,91.186,0,0,0,100,0),
(1999990,12,2874.736,-3063.742,85.386,0,0,0,100,0),
(1999990,13,2872.254,-3045.130,82.085,0,0,0,100,0),
(1999990,14,2867.529,-3020.512,84.268,0,0,0,100,0),
(1999990,15,2811.413,-3018.185,88.837,0,0,0,100,0),
(1999990,16,2772.952,-3014.391,92.935,0,0,0,100,0),
(1999990,17,2700.462,-2996.456,92.247,0,0,0,100,0),
(1999990,18,2666.411,-2986.375,96.447,0,0,0,100,0),
(1999990,19,2649.578,-2979.369,95.366,0,0,0,100,0),
(1999990,20,2598.768,-2987.893,109.434,0,0,0,100,0),
(1999990,21,2560.210,-2988.716,111.262,0,0,0,100,0),
(1999990,22,2526.068,-3031.698,121.382,0,0,0,100,0),
(1999990,23,2501.948,-3041.872,126.281,0,0,0,100,0),
(1999990,24,2477.311,-3053.944,138.013,0,0,0,100,0),
(1999990,25,2467.604,-3071.109,141.345,0,0,0,100,0);

DELETE FROM `creature_text` WHERE `entry`=24277;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(24277,0,0,'Enough of this charade!',1,0,100,0,0,0,'Garwal morph text');

DELETE FROM `spell_scripts` WHERE `id`=50103;
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(50103,0,0,14,43060,1,0,0,0,0,0); -- Remove Eyes of the Eagle on quest turn in


DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (43682,50104);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(43682,43060,1,'Apply Eyes of the Eagle'),
(50104,50103,1,'Remove Eyes of the Eagle');

UPDATE `quest_template` SET `SrcSpell`=43682 WHERE `entry` IN (11324,11326);

-- Fix Taxi from Quest 'To Westguard Keep!' #11291 
SET @Emilune    = 27930; -- Emilune Winterwind
SET @Gossip     = 9618;   -- gossip_menu_id
SET @Quest      = 11291; -- Quest
SET @Spell      = 50028; -- Gryphon Taxi to Westguard Keep
-- Update creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI', `npcflag` = `npcflag` | 1 WHERE `entry` = @Emilune;
-- gossip_menu_option
DELETE FROM `gossip_menu_option` WHERE `menu_id` = @Gossip;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`) VALUES 
(@Gossip,0,0,'Please, Take me to Westguard Keep!',1,1,0,0,0,0,0,'');
-- SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = @Emilune;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@Emilune,0,0,0,62,0,100,0,@Gossip,0,0,0,11,@Spell,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast taxi');
-- conditions
DELETE FROM `conditions` WHERE `SourceGroup` = @Gossip AND `SourceTypeOrReferenceId` = 15;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15,@Gossip,0,0,28,@Quest,0,0,0,'','show gossip menu option if player has completed 11291');