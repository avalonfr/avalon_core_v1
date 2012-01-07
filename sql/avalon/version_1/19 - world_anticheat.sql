INSERT INTO `command` (`name`,`security`,`help`) VALUES 
('anticheat global', '2', 'Syntax: .anticheat global retourne les rapports montant total et la moyenne. (top 3 cheaters)'),
('anticheat player', '2', 'Syntax: .anticheat player $name retourne le montant total d\'avertissements, la moyenne et le montant de chaque type de triche du joueur.'),
('anticheat handle', '2', 'Syntax: .anticheat handle [on|off] Rend on/off la détection de cheat.'),
('anticheat delete', '2', 'Syntax: .anticheat delete [deleteall|$name] Supprime les enregistrements de tous les joueurs ou supprime tous les rapports du joueur $name.');
