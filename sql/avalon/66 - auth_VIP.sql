CREATE TABLE IF NOT EXISTS `account_VIP` (
  `id` int(11) NOT NULL default '0' COMMENT 'Account id',
  `setdate` bigint(40) NOT NULL default '0',
  `unsetdate` bigint(40) NOT NULL default '0',
  `VIP_type` tinyint(4) unsigned NOT NULL default '1',
  `active` tinyint(4) NOT NULL default '1',
  `id_parain` int(11) NOT NULL default '0',
  `ip_parain` int(255) NOT NULL default '0',
   PRIMARY KEY  (`id`,`setdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='VIP Accounts';