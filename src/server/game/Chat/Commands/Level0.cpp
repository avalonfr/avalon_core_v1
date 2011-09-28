
/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Common.h"
#include "DatabaseEnv.h"
#include "World.h"
#include "Player.h"
#include "Opcodes.h"
#include "Chat.h"
#include "ObjectAccessor.h"
#include "Language.h"
#include "AccountMgr.h"
#include "SystemConfig.h"
#include "revision.h"
#include "Util.h"
#include "ObjectMgr.h"
#include "SpellMgr.h"

bool ChatHandler::HandleHelpCommand(const char* args)
{
    char* cmd = strtok((char*)args, " ");
    if (!cmd)
    {
        ShowHelpForCommand(getCommandTable(), "help");
        ShowHelpForCommand(getCommandTable(), "");
    }
    else
    {
        if (!ShowHelpForCommand(getCommandTable(), cmd))
            SendSysMessage(LANG_NO_HELP_CMD);
    }

    return true;
}

bool ChatHandler::HandleCommandsCommand(const char* /*args*/)
{
    ShowHelpForCommand(getCommandTable(), "");
    return true;
}

bool ChatHandler::HandleStartCommand(const char* /*args*/)
{
    Player* chr = m_session->GetPlayer();

    if (chr->isInFlight())
    {
        SendSysMessage(LANG_YOU_IN_FLIGHT);
        SetSentErrorMessage(true);
        return false;
    }

    if (chr->isInCombat())
    {
        SendSysMessage(LANG_YOU_IN_COMBAT);
        SetSentErrorMessage(true);
        return false;
    }

    if ((chr->isDead()) || (chr->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST)))
    {
    // if player is dead and stuck, send ghost to graveyard
    chr->RepopAtGraveyard();
    return true;
    }

    // cast spell Stuck
    chr->CastSpell(chr, 7355, false);
    return true;
}

bool ChatHandler::HandleServerInfoCommand(const char* /*args*/)
{
    uint32 PlayersNum = sWorld->GetPlayerCount();
    uint32 MaxPlayersNum = sWorld->GetMaxPlayerCount();
    uint32 activeClientsNum = sWorld->GetActiveSessionCount();
    uint32 queuedClientsNum = sWorld->GetQueuedSessionCount();
    uint32 maxActiveClientsNum = sWorld->GetMaxActiveSessionCount();
    uint32 maxQueuedClientsNum = sWorld->GetMaxQueuedSessionCount();
    std::string uptime = secsToTimeString(sWorld->GetUptime());
    uint32 updateTime = sWorld->GetUpdateTime();

    SendSysMessage(_FULLVERSION);
    PSendSysMessage(LANG_CONNECTED_PLAYERS, PlayersNum, MaxPlayersNum);
    PSendSysMessage(LANG_CONNECTED_USERS, activeClientsNum, maxActiveClientsNum, queuedClientsNum, maxQueuedClientsNum);
    PSendSysMessage(LANG_UPTIME, uptime.c_str());
    PSendSysMessage("Update time diff: %u.", updateTime);

    return true;
}

bool ChatHandler::HandleDismountCommand(const char* /*args*/)
{
    //If player is not mounted, so go out :)
    if (!m_session->GetPlayer()->IsMounted())
    {
        SendSysMessage(LANG_CHAR_NON_MOUNTED);
        SetSentErrorMessage(true);
        return false;
    }

    if (m_session->GetPlayer()->isInFlight())
    {
        SendSysMessage(LANG_YOU_IN_FLIGHT);
        SetSentErrorMessage(true);
        return false;
    }

    m_session->GetPlayer()->Unmount();
    m_session->GetPlayer()->RemoveAurasByType(SPELL_AURA_MOUNTED);
    return true;
}

bool ChatHandler::HandleSaveCommand(const char* /*args*/)
{
    Player* player = m_session->GetPlayer();

    // save GM account without delay and output message
    if (!AccountMgr::IsPlayerAccount(m_session->GetSecurity()))
    {
        if (Player* target = getSelectedPlayer())
            target->SaveToDB();
        else
            player->SaveToDB();
        SendSysMessage(LANG_PLAYER_SAVED);
        return true;
    }

    // save if the player has last been saved over 20 seconds ago
    uint32 save_interval = sWorld->getIntConfig(CONFIG_INTERVAL_SAVE);
    if (save_interval == 0 || (save_interval > 20*IN_MILLISECONDS && player->GetSaveTimer() <= save_interval - 20*IN_MILLISECONDS))
        player->SaveToDB();

    return true;
}

/// Display the 'Message of the day' for the realm
bool ChatHandler::HandleServerMotdCommand(const char* /*args*/)
{
    PSendSysMessage(LANG_MOTD_CURRENT, sWorld->GetMotd());
    return true;
}

bool ChatHandler::HandlePlayerQuestCompleteCommand(const char *args)
{
 Player* pPlayer = m_session->GetPlayer();

 char* cId = extractKeyFromLink((char*)args,"Hquest");
 if (!cId)
 return false;
 uint32 entry = atol(cId);

 Quest const* pQuest = sObjectMgr->GetQuestTemplate(entry);

 if (!pQuest)
 {
 PSendSysMessage(LANG_COMMAND_QUEST_NOTFOUND,entry);
 SetSentErrorMessage(true);
 return true;
 }
 QueryResult result = WorldDatabase.PQuery("SELECT COUNT(quest_id) FROM quest_bug_list WHERE quest_id='%d'",entry);
 if ((*result)[0].GetUInt32() != 1)
 {
 PSendSysMessage(LANG_QUEST_NOBUG);
 SetSentErrorMessage(true);
 return false;
 }
 if (pPlayer->GetQuestStatus(entry) == QUEST_STATUS_NONE)
 {
 PSendSysMessage(LANG_HAVENT_QUEST);
 SetSentErrorMessage(true);
 return false;
 }
 pPlayer->CompleteQuest(entry);
 return true;
}

/*      char** ChatHandler::split(char* chaine,const char* delim,int vide)      */
/*      bool ChatHandler::Levelup(int levelcount)								*/
/*      bool ChatHandler::AddGold(int gold)										*/
/*      uint32 ChatHandler::getItemId(const char* args)							*/
/*      bool ChatHandler::Additem(int itemid)									*/
/*      int ChatHandler::coutlevel(int level)									*/
/*      bool ChatHandler::BoutiqueAdditem(const char* args)						*/
/*      bool ChatHandler::BoutiqueMetier(const char* args)						*/
/*      bool ChatHandler::BoutiqueGold(const char* args)						*/

/*                          SHOP ONLINE V1.0									*/
/* tables : db_char.compte : acct,points 										*/
/*			db_char.shop_log : id,acct,type,valeur1,valeur2,valeur3				*/
/*			db_char.shop_item : entry,prix,commentaire 							*/
/*			db_char.shop_level : level,prix 									*/
/*          db_char.shop_gold : minimum,maximum , prix_po						*/
/*          db_char.shop_gold : minimum,maximum , prix_po						*/
/*          db_char.shop_categorie: id,prix ,value,commentaire					*/
/*          db_char.shop_set : set_id,prix ,data,commentaire					*/
/*          db_char.shop_creation : id,prix ,data,commentaire				    */


// Retour tableau des chaines recupérer. Terminé par NULL.
// chaine : chaine à splitter
// delim : delimiteur qui sert à la decoupe
// vide : 0 : on n'accepte pas les chaines vides
// 1 : on accepte les chaines vides
char** ChatHandler::split(const char* chaine,const char* delim,int vide, int* sizeTabRet){

	char** tab=NULL; //tableau de chaine, tableau resultat
	const char *ptr; //pointeur sur une partie de
	int sizeStr; //taille de la chaine à recupérer
	int sizeTab=0; //taille du tableau de chaine
	const char* largestring; //chaine à traiter

	int sizeDelim=strlen(delim); //taille du delimiteur


	largestring = chaine; //comme ca on ne modifie pas le pointeur d'origine
	//(faut ke je verifie si c bien nécessaire)


	while( (ptr=strstr(largestring, delim))!=NULL ){
		sizeStr=ptr-largestring;

		//si la chaine trouvé n'est pas vide ou si on accepte les chaine vide
		if(vide==1 || sizeStr!=0){
			//on alloue une case en plus au tableau de chaines
			sizeTab++;
			tab= (char**) realloc(tab,sizeof(char*)*sizeTab);

			//on alloue la chaine du tableau
			tab[sizeTab-1]=(char*) malloc( sizeof(char)*(sizeStr+1) );
			strncpy(tab[sizeTab-1],largestring,sizeStr);
			tab[sizeTab-1][sizeStr]='\0';
		}

		//on decale le pointeur largestring pour continuer la boucle apres le premier elément traiter
		ptr=ptr+sizeDelim;
		largestring=ptr;
	}

	//si la chaine n'est pas vide, on recupere le dernier "morceau"
	if(strlen(largestring)!=0){
		sizeStr=strlen(largestring);
		sizeTab++;
		tab= (char**) realloc(tab,sizeof(char*)*sizeTab);
		tab[sizeTab-1]=(char*) malloc( sizeof(char)*(sizeStr+1) );
		strncpy(tab[sizeTab-1],largestring,sizeStr);
		tab[sizeTab-1][sizeStr]='\0';
	}
	else if(vide==1){ //si on fini sur un delimiteur et si on accepte les mots vides,on ajoute un mot vide
		sizeTab++;
		tab= (char**) realloc(tab,sizeof(char*)*sizeTab);
		tab[sizeTab-1]=(char*) malloc( sizeof(char)*1 );
		tab[sizeTab-1][0]='\0';
	}

	*sizeTabRet = sizeTab;

	return tab;
} 

bool ChatHandler::Additem(int itemid, int count, int type, bool remplacement)
{
    Player* pl = m_session->GetPlayer();

	if(!pl) return false;

	uint64 receiver_guid = pl->GetGUID();
	int levelItem = 0;
	
	if (type == 0)
	{
		int typeRecup;

		QueryResult result = CharacterDatabase.PQuery("SELECT `typeRecup`, `level_item` FROM `recup_infos` WHERE name = '%s'",pl->GetName());
		if (!result) return false;
		Field* fields = result->Fetch();
		if (!fields) return false;
		typeRecup = fields[0].GetUInt32();
		levelItem = fields[1].GetUInt32();

		if(remplacement)
		{
			QueryResult result = CharacterDatabase.PQuery("SELECT `itemEpique`, `itemRare` FROM `recup_itemRemplacement` WHERE item = '%u'",itemid);
			if (result)
			{
				Field* fields = result->Fetch();
				if (fields)
				{
					if(typeRecup == 0 || typeRecup == 1)
						itemid = fields[typeRecup].GetUInt32();
				}
			}
		}
	}

	if(!levelItem)
		levelItem = 200;

	QueryResult result = WorldDatabase.PQuery("SELECT `ItemLevel` FROM `item_template` WHERE `entry` = '%d'",itemid);

	if (!result)
		return false;

	if (result)
	{
		Field* fields = result->Fetch();

		if(!fields)
			return false;

		if(fields)
		{
			int itemLevel = fields[0].GetUInt32();

			if(itemLevel > levelItem)
			{
				return false;
			}
		}
	}

    std::string name = pl->GetName();
    if(name.empty())
    {
        SendSysMessage(LANG_PLAYER_NOT_FOUND);
        SetSentErrorMessage(true);
        return false;
    }

    char* msgSubject;
	char* msgText;

	
	switch(type)
	{
		case 0 : msgSubject="Recuperation";sLog->outDetail("Recuperation");break;
		case 1 : msgSubject="Achat";sLog->outDetail("Achat");break;
	}
	
	
	switch(type)
	{
		case 0 : msgText="Voici les objets de votre recuperation. Nous vous remercions d'avoir choisi Avalon";sLog->outDetail("Voici les objets de votre recuperation. Nous vous remercions d'avoir choisi Avalon");break;
		case 1 : msgText="Merci pour votre achat. Bon jeu sur Avalon";sLog->outDetail("Merci pour votre achat. Bon jeu sur Avalon");break;
	}
	
    if (!msgSubject)
        return false;

    if (!msgText)
        return false;

    // msgSubject, msgText isn't NUL after prev. check
    std::string subject = msgSubject;
    std::string text    = msgText;

    // extract items
    typedef std::pair<uint32,uint32> ItemPair;
    typedef std::list< ItemPair > ItemPairs;
    ItemPairs items;

	uint32 item_id = itemid;
	if (!item_id)
		return false;

	ItemTemplate const* item_proto = sObjectMgr->GetItemTemplate(item_id);
	if (!item_proto)
	{
		PSendSysMessage(LANG_COMMAND_ITEMIDINVALID, item_id);
		SetSentErrorMessage(true);
		return false;
	}

	uint32 item_count = count;
	if (item_count < 1 || (item_proto->MaxCount > 0 && item_count > uint32(item_proto->MaxCount)))
	{
		PSendSysMessage(LANG_COMMAND_INVALID_ITEM_COUNT, item_count,item_id);
		SetSentErrorMessage(true);
		return false;
	}

	while (item_count > item_proto->GetMaxStackSize())
	{
		items.push_back(ItemPair(item_id,item_proto->GetMaxStackSize()));
		item_count -= item_proto->GetMaxStackSize();
	}

	items.push_back(ItemPair(item_id,item_count));

	if (items.size() > MAX_MAIL_ITEMS)
	{
		PSendSysMessage(LANG_COMMAND_MAIL_ITEMS_LIMIT, MAX_MAIL_ITEMS);
		SetSentErrorMessage(true);
		return false;
	}

    // from console show not existed sender
    MailSender sender(MAIL_NORMAL,m_session ? m_session->GetPlayer()->GetGUIDLow() : 0, MAIL_STATIONERY_GM);

    // fill mail
    MailDraft draft(subject, text);

    SQLTransaction trans = CharacterDatabase.BeginTransaction();

    for (ItemPairs::const_iterator itr = items.begin(); itr != items.end(); ++itr)
    {
        if (Item* item = Item::CreateItem(itr->first,itr->second,m_session ? m_session->GetPlayer() : 0))
        {
            item->SaveToDB(trans);                               // save for prevent lost at next mail load, if send fail then item will deleted
            draft.AddItem(item);
        }
    }

    draft.SendMailTo(trans, MailReceiver(pl,GUID_LOPART(receiver_guid)), sender);
    CharacterDatabase.CommitTransaction(trans);

    std::string nameLink = playerLink(name);
    PSendSysMessage(LANG_MAIL_SENT, nameLink.c_str());

    return true;
}

uint32 ChatHandler::getItemId(const char* args)
{

	uint32 itemId = 0;

    if(args[0]=='[')                                        // [name] manual form
    {
        char* citemName = citemName = strtok((char*)args, "]");

        if(citemName && citemName[0])
        {
            std::string itemName = citemName+1;
            WorldDatabase.EscapeString(itemName);
            QueryResult result = WorldDatabase.PQuery("SELECT entry FROM item_template WHERE name = '%s'", itemName.c_str());
            if (!result)
            {
                PSendSysMessage(LANG_COMMAND_COULDNOTFIND, citemName+1);
                SetSentErrorMessage(true);
                return 0;
            }
            itemId = result->Fetch()->GetUInt16();
        }
        else
            return 0;
    }
    else                                                    // item_id or [name] Shift-click form |color|Hitem:item_id:0:0:0|h[name]|h|r
    {
        char* cId = extractKeyFromLink((char*)args,"Hitem");
        if(!cId)
            return 0;
        itemId = atol(cId);
    }

	return itemId;
}

bool ChatHandler::Levelup(int levelcount)
{
	if(levelcount<1 || levelcount > 79)
		return false;

    Player *chr = m_session->GetPlayer();

	if(chr && chr->getLevel()+levelcount > 80)
		return false;

    HandleCharacterLevel(chr,0,chr->getLevel(),chr->getLevel()+levelcount);

    return true;
}

int ChatHandler::coutlevel(int level)
{
	QueryResult result = CharacterDatabase.PQuery("SELECT `prix` FROM `shop_level` WHERE level = '%u'",level);
	if (!result) return 0;
	Field* fields = result->Fetch();
	if (!fields) return 0;
	return fields[0].GetUInt32();
}

bool ChatHandler::AddGold(int gold)
{
	if(gold <0) return false;

    int32 addmoney = gold*10000;
	Player * chr = m_session->GetPlayer();
    uint32 moneyuser = chr->GetMoney();

    if(addmoney < 0)
    {
        int32 newmoney = moneyuser + addmoney;

        if(newmoney <= 0 )
        {
            chr->SetMoney(0);
        }
        else
        {
            chr->SetMoney( newmoney );
        }
    }
    else
    {
        chr->ModifyMoney( addmoney );
    }

	m_session->GetPlayer()->SaveToDB();
    return true;
}

bool ChatHandler::BoutiqueLevel(const char* args)
{
	int asklvl = 0;
	int points = 0;
	int currentlevel = 0;
	int prix = 0;
	int i = 0;
	int bilan = 0;

	if (!*args)
	       return false;

	char* px = strtok((char*)args, " ");
	asklvl = atoi(px);

	if (asklvl < 0) return false;

	Player* character = m_session->GetPlayer();
		Player* plTarget = NULL;
    if(!plTarget)
        plTarget = character;

	QueryResult result = CharacterDatabase.PQuery("SELECT `points` FROM `compte` WHERE `acct` = '%u'",character->GetSession()->GetAccountId());
	if (!result) return false;

	Field* fields = result->Fetch();
	if (!fields) return false;

	points = fields[0].GetUInt32();
	currentlevel = character->getLevel();

	if ((currentlevel == 80)||(currentlevel+asklvl > 80))
	{
		m_session->SendNotification("Erreur sur le level demande");
		return false;
	}


	while (i<asklvl)
	{
	currentlevel = character->getLevel() + i;
	if(coutlevel(currentlevel)==0) return true;
	prix += coutlevel(currentlevel);
	i++;
	}

	if (prix > points)
	{
	m_session->SendNotification("Vous n'avez pas assez de points.Il vous faut %u points pour votre demande.",prix);
	return false;
	}
	bilan = points - prix;
	CharacterDatabase.PQuery("UPDATE `compte` SET `points` = '%u' WHERE acct='%u'",bilan,character->GetSession()->GetAccountId());
	CharacterDatabase.PQuery("INSERT INTO `shop_log` (`id`,`acct`,`type`,`valeur1`,`valeur2`) VALUES ('','%u','level','%u','%u')",character->GetSession()->GetAccountId(),character->getLevel(),asklvl);
	Levelup(asklvl);
	m_session->SendNotification("Il vous reste %u points sur votre compte",bilan);
	return true;

}

bool ChatHandler::BoutiqueAdditem(const char* args)
{
	int points;
	int prix;
	int bilan;
	uint32 ItemId = 0;

    if (!*args)
        return false;
	
	char** tab;
	int size = 0;

	tab=split(args," ",0,&size);
	
	int32 count = size==2?atoi(tab[1]):1;

	int i = 0;

	for(i=0;i<size;i++) {
		free(tab[i]);
	}
	free(tab); 
	
	

	if(count < 0){
		m_session->SendNotification("La quantité ne peut pas être négative");
		return false;
	}

    if (count == 0)
        count = 1;
		
	
	Player* character = m_session->GetPlayer();

	ItemId = getItemId(args);

	QueryResult result = CharacterDatabase.PQuery("SELECT `prix` FROM `shop_item` WHERE `entry` = '%u'",ItemId);

    if(!result){
		m_session->SendNotification("L'objet n'est pas disponible");
		return false;
	}

	Field* fields = result->Fetch();

	if(!fields)
    return false;

	if (fields[0].GetUInt32() == 0)
		return false;

	prix = count*(fields[0].GetUInt32());


	result = CharacterDatabase.PQuery("SELECT `points` FROM `compte` WHERE `acct` = '%u'",character->GetSession()->GetAccountId());

    if(!result)
       return false;

    fields = result->Fetch();


     if(!fields)
       return false;

      points = fields[0].GetUInt32();

      if(points < prix)
      {
      m_session->SendNotification("Vous n'avez pas assez de points.Il vous faut %u points pour votre demande.",prix);
	  return false;
      }

	  bilan = points - prix;
	  if(!Additem(ItemId, count,1, false))
	  {
	    m_session->SendNotification("Vous n'avez pas assez de place dans vos sacs");
		return false;
	  }
	  CharacterDatabase.PQuery("UPDATE `compte` SET `points` = '%u' WHERE acct='%u'",bilan,character->GetSession()->GetAccountId());
	  // On veut log, surtout au debut pour verifier les abus sur les prix pas tres juste :/
	  CharacterDatabase.PQuery("INSERT INTO `shop_log` (`acct`,`type`,`valeur1`,`valeur2`) VALUES ('%u','item','%u','%u')",character->GetSession()->GetAccountId(),ItemId,count);
	  return true;
}

bool ChatHandler::BoutiqueGold(const char* args) 
{
    if (!*args)
	       return false;

	uint32 bilan = 0;
	uint32 points = 0;
	float prix = 0;
	float Qt = 0;
	float askgold2 = 0;

	
    Player* character = m_session->GetPlayer();

	char* px = strtok((char*)args, " ");

	int askgold = atoi(px);
	askgold2 = askgold;
	if ((askgold <= 0)||(askgold>10000))
	{
		m_session->SendNotification("Cette Valeur n'est pas autorise");
        return false;
	}

    QueryResult result = CharacterDatabase.PQuery("SELECT id FROM shop_gold WHERE minimum <= '%u' AND maximum >= '%u'",askgold,askgold);
    if (!result) return false;
    Field* fields = result->Fetch();
	if (!fields) return false;
	uint32 ui = fields[0].GetUInt32();
	for(uint32 i = 1;i <= ui;i++)
	{
		result = CharacterDatabase.PQuery("SELECT maximum,prix_po,minimum FROM shop_gold WHERE id='%u'",i);
		if (!result) return false;
		Field* fields = result->Fetch();
		if (!fields) return false;
		if(fields[0].GetFloat() < askgold)  
		{
			askgold2 = askgold;
			Qt = fields[0].GetFloat() - (fields[2].GetFloat() - 1);          
			askgold2 -= fields[0].GetFloat();
		}
		else
		{
			Qt = askgold2;  
			askgold2 = 0;
		}
		prix += Qt*(fields[1].GetFloat());
	}
	  
	  result = CharacterDatabase.PQuery("SELECT `points` FROM `compte` WHERE `acct` = '%u'",character->GetSession()->GetAccountId());

       if(!result)
       return false;

      fields = result->Fetch();

      if(!fields)
       return false;

      points = fields[0].GetUInt32();
	  uint32 prix2 = (int)prix;

      if(points < prix2)
	  {
		m_session->SendNotification("Il vous manque %u points pour cet achat",prix2 - points);
        return false;
	  }
     

	  bilan = points - prix2;
	  CharacterDatabase.PQuery("UPDATE `compte` SET `points` = '%u' WHERE acct='%u'",bilan,character->GetSession()->GetAccountId());
	  CharacterDatabase.PQuery("INSERT INTO `shop_log` (`id`,`acct`,`type`,`valeur1`,`valeur2`) VALUES ('','%u','gold','%u','%u')",character->GetSession()->GetAccountId(),askgold,prix2);
	  character->SetMoney(character->GetMoney() + askgold*10000);
	  m_session->SendNotification("Il vous reste %u points sur votre compte",bilan);

	  return true;


}

// customize characters
bool ChatHandler::BoutiqueCustomize(const char* args)
{
	int points = 0;
	int prix_custom = 200;
	int bilan = 0;
	Player* character = m_session->GetPlayer();

	//TODO : faire la requete voir si l'object à 1 prix
	QueryResult result = CharacterDatabase.PQuery("SELECT `points` FROM `compte` WHERE `acct` = '%u'",character->GetSession()->GetAccountId());

    if(!result)
       return false;

    Field* fields = result->Fetch();


     if(!fields)
       return false;

      points = fields[0].GetUInt32();

      if(points < prix_custom)
      {
      m_session->SendNotification("Vous n'avez pas assez de points.Il vous faut 200 points pour votre demande.");
	  return false;
      }

    Player* target = m_session->GetPlayer();
	bilan = points - prix_custom;
    if(target)
    {
        PSendSysMessage(LANG_CUSTOMIZE_PLAYER, GetNameLink(target).c_str());
        target->SetAtLoginFlag(AT_LOGIN_CUSTOMIZE);
		CharacterDatabase.PQuery("UPDATE `compte` SET `points` = '%u' WHERE acct='%u'",bilan,character->GetSession()->GetAccountId());
        CharacterDatabase.PExecute("UPDATE characters SET at_login = at_login | '8' WHERE guid = '%u'", target->GetGUIDLow());
    }
    else
    {
        return false;
    }

    return true;
}

// rename characters
bool ChatHandler::BoutiqueRename(const char* args)
{
	int points = 0;
	int prix_rename = 100;
	int bilan = 0;
	
	Player* character = m_session->GetPlayer();

	//TODO : faire la requete voir si l'object à 1 prix
	QueryResult result = CharacterDatabase.PQuery("SELECT `points` FROM `compte` WHERE `acct` = '%u'",character->GetSession()->GetAccountId());

    if(!result)
       return false;

    Field* fields = result->Fetch();


     if(!fields)
       return false;

      points = fields[0].GetUInt32();

      if(points < prix_rename)
      {
      m_session->SendNotification("Vous n'avez pas assez de points.Il vous faut 100 points pour votre demande.");
	  return false;
      }

    Player* target = m_session->GetPlayer();
	bilan = points - prix_rename;
    if(target)
    {
        PSendSysMessage(LANG_RENAME_PLAYER, GetNameLink(target).c_str());
        target->SetAtLoginFlag(AT_LOGIN_RENAME);
		CharacterDatabase.PQuery("UPDATE `compte` SET `points` = '%u' WHERE acct='%u'",bilan,character->GetSession()->GetAccountId());
        //CharacterDatabase.PExecute("UPDATE characters SET at_login = at_login | '8' WHERE guid = '%u'", target->GetGUIDLow());
    }
    else
    {
        return false;
    }

    return true;
}

// race characters
bool ChatHandler::BoutiqueRace(const char* args)
{
	int points = 0;
	int prix_race = 250;
	int bilan = 0;
	
	Player* character = m_session->GetPlayer();

	//TODO : faire la requete voir si l'object à 1 prix
	QueryResult result = CharacterDatabase.PQuery("SELECT `points` FROM `compte` WHERE `acct` = '%u'",character->GetSession()->GetAccountId());

    if(!result)
       return false;

    Field* fields = result->Fetch();


     if(!fields)
       return false;

      points = fields[0].GetUInt32();

      if(points < prix_race)
      {
      m_session->SendNotification("Vous n'avez pas assez de points.Il vous faut 250 points pour votre demande.");
	  return false;
      }

    Player* target = m_session->GetPlayer();
	bilan = points - prix_race;
    if(target)
    {
        PSendSysMessage(LANG_CUSTOMIZE_PLAYER, GetNameLink(target).c_str());
        target->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
        CharacterDatabase.PExecute("UPDATE characters SET at_login = at_login | '128' WHERE guid = %u", target->GetGUIDLow());
		CharacterDatabase.PQuery("UPDATE `compte` SET `points` = '%u' WHERE acct='%u'",bilan,character->GetSession()->GetAccountId());
    }
    else
    {
        return false;
    }

    return true;
}

// faction characters
bool ChatHandler::BoutiqueFaction(const char* args)
{
	int points = 0;
	int prix_faction = 300;
	int bilan = 0;
	
	Player* character = m_session->GetPlayer();

	//TODO : faire la requete voir si l'object à 1 prix
	QueryResult result = CharacterDatabase.PQuery("SELECT `points` FROM `compte` WHERE `acct` = '%u'",character->GetSession()->GetAccountId());

    if(!result)
       return false;

    Field* fields = result->Fetch();


     if(!fields)
       return false;

      points = fields[0].GetUInt32();

      if(points < prix_faction)
      {
      m_session->SendNotification("Vous n'avez pas assez de points.Il vous faut 300 points pour votre demande.");
	  return false;
      }

    Player* target = m_session->GetPlayer();
	bilan = points - prix_faction;
    if(target)
    {
        PSendSysMessage(LANG_CUSTOMIZE_PLAYER, GetNameLink(target).c_str());
        target->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
        CharacterDatabase.PExecute("UPDATE characters SET at_login = at_login | '64' WHERE guid = %u", target->GetGUIDLow());
		CharacterDatabase.PQuery("UPDATE `compte` SET `points` = '%u' WHERE acct='%u'",bilan,character->GetSession()->GetAccountId());
    }
    else
    {
        return false;
    }

    return true;
}

bool ChatHandler::BoutiqueSet(const char* args){

	int points = 0;
	int id = 0;

    if (!*args)
	       return false;

	char* px = strtok((char*)args, " ");

	id = atoi(px);

	Player* character = m_session->GetPlayer();

	QueryResult result = CharacterDatabase.PQuery("SELECT `points` FROM `compte` WHERE `acct` = '%u'",character->GetSession()->GetAccountId());
	
	if(!result) return false;

	Field* fields = result->Fetch();

	if (!fields) return false;

	points = fields[0].GetUInt32();

	result = CharacterDatabase.PQuery("SELECT `data`,`prix` FROM `shop_set` WHERE `set_id` = '%u'",id);

	if(!result) return false;

	fields = result->Fetch();

	if (!fields) return false;

	const char* data = fields[0].GetCString();
	int prix = fields[1].GetUInt32();

	if(prix>points){
		m_session->SendNotification("Il vous manque %u points pour cet achat",prix - points);
        return false;
	}

	CharacterDatabase.PQuery("UPDATE `compte` SET `points` = '%u' WHERE acct='%u'",points-prix,character->GetSession()->GetAccountId());

	char** tab;
	int size = 0;

	tab=split(data," ",0,&size);

	int i = 0;

	for(i=0;i<size;i++) {
		Additem(atoi(tab[i]),1,1,false);
		free(tab[i]);
	}
	free(tab); 

	return true;
}
