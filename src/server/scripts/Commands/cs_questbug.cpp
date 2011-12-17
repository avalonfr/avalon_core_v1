/*
 * Copyright (C) 2011 
 */

#include "ScriptPCH.h"
#include "Chat.h"

class questbug_commandscript : public CommandScript
{
    public:
        questbug_commandscript() : CommandScript("questdebug_commandscript") { }
		ChatCommand* GetCommands() const
    {
      static ChatCommand QuestbugAddRemoveCommandTable[] =
      {
        { "add",        SEC_GAMEMASTER, false, &HandleQuestBugAddCommand,    "", NULL },
        { "remove",     SEC_GAMEMASTER, false, &HandleQuestBugRemoveCommand, "", NULL },
        { NULL, 0, false, NULL, "", NULL }
      };
      static ChatCommand QuestbugCommandTable[] =
      {
        { "valide",     SEC_PLAYER,     false, &HandlePlayerQuestCompleteCommand, "", NULL },
        { "questbug",   SEC_GAMEMASTER, false, NULL, "", QuestbugAddRemoveCommandTable},
        { NULL, 0, false, NULL, "", NULL }
      };
	  
      return QuestbugCommandTable;
    }
	
        static bool HandleQuestBugAddCommand(ChatHandler* handler, const char *args)
        {
            char* cId = handler->extractKeyFromLink((char*)args,"Hquest");
            if (!cId)
                return false;

            uint32 entry = atol(cId);
            Quest const* pQuest = sObjectMgr->GetQuestTemplate(entry);
            if (!pQuest)
            {
                handler->PSendSysMessage(LANG_COMMAND_QUEST_NOTFOUND,entry);
                handler->SetSentErrorMessage(true);
                return false;
            }

            QueryResult result = WorldDatabase.PQuery("SELECT COUNT(quest_id) FROM quest_bug_list WHERE quest_id='%u'",entry);
            if ((*result)[0].GetUInt32() == 1)
            {
                handler->PSendSysMessage(LANG_QUEST_EVER_SIGNALED,entry);
                handler->SetSentErrorMessage(true);
                return false;
            }

            WorldDatabase.PExecute("INSERT INTO quest_bug_list (`quest_id`) VALUES ('%u')",entry);
            handler->PSendSysMessage(LANG_QUEST_SIGNALED,entry);
            return true;
        }

        static bool HandleQuestBugRemoveCommand(ChatHandler* handler, const char *args)
        {
            char* cId = handler->extractKeyFromLink((char*)args,"Hquest");
            if (!cId)
                return false;

            uint32 entry = atol(cId);

            Quest const* pQuest = sObjectMgr->GetQuestTemplate(entry);

            if (!pQuest)
            {
                handler->PSendSysMessage(LANG_COMMAND_QUEST_NOTFOUND,entry);
                handler->SetSentErrorMessage(true);
                return false;
            }
            QueryResult result = WorldDatabase.PQuery("SELECT COUNT(quest_id) FROM quest_bug_list WHERE quest_id='%u'",entry);
            if (!result)
            {
                handler->PSendSysMessage(LANG_QUEST_NEVER_SIGNALED,entry);
                handler->SetSentErrorMessage(true);
                return false;
            }
            WorldDatabase.PExecute("DELETE FROM quest_bug_list WHERE quest_id = '%u'",entry);
            handler->PSendSysMessage(LANG_QUEST_SIGNALED_REMOVED,entry);
            return true;
        }
        static bool HandlePlayerQuestCompleteCommand(ChatHandler* handler, const char *args)
        {
            Player*  player = handler->GetSession()->GetPlayer();
            char* cId = handler->extractKeyFromLink((char*)args,"Hquest");
            if (!cId)
                return false;
            uint32 entry = atol(cId);

            Quest const* pQuest = sObjectMgr->GetQuestTemplate(entry);

            if (!pQuest)
            {
                handler->PSendSysMessage(LANG_COMMAND_QUEST_NOTFOUND,entry);
                handler->SetSentErrorMessage(true);
                return true;
            }
            QueryResult result = WorldDatabase.PQuery("SELECT COUNT(quest_id) FROM quest_bug_list WHERE quest_id='%d'",entry);
            if ((*result)[0].GetUInt32() != 1)
            {
                handler->PSendSysMessage(LANG_QUEST_NOBUG);
                handler->SetSentErrorMessage(true);
                return false;
            }
            if (player->GetQuestStatus(entry) == QUEST_STATUS_NONE)
            {
                handler->PSendSysMessage(LANG_HAVENT_QUEST);
                handler->SetSentErrorMessage(true);
                return false;
            }
            // Add quest items for quests that require items
			for (uint8 x = 0; x < QUEST_ITEM_OBJECTIVES_COUNT; ++x)
		{
				uint32 id = pQuest->RequiredItemId[x];
				uint32 count = pQuest->RequiredItemCount[x];
				if (!id || !count)
					continue;

				uint32 curItemCount = player->GetItemCount(id, true);

			ItemPosCountVec dest;
			uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, id, count-curItemCount);
			if (msg == EQUIP_ERR_OK)
			{
				Item* item = player->StoreNewItem(dest, id, true);
				player->SendNewItem(item, count-curItemCount, true, false);
			}
		}

			// All creature/GO slain/casted (not required, but otherwise it will display "Creature slain 0/10")
			for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
		{
				int32 creature = pQuest->RequiredNpcOrGo[i];
				uint32 creaturecount = pQuest->RequiredNpcOrGoCount[i];

			if (uint32 spell_id = pQuest->RequiredSpellCast[i])
			{
				for (uint16 z = 0; z < creaturecount; ++z)
					player->CastedCreatureOrGO(creature, 0, spell_id);
			}
			else if (creature > 0)
			{
				if (CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(creature))
					for (uint16 z = 0; z < creaturecount; ++z)
						player->KilledMonster(cInfo, 0);
			}
			else if (creature < 0)
			{
				for (uint16 z = 0; z < creaturecount; ++z)
					player->CastedCreatureOrGO(creature, 0, 0);
			}
		}

			// If the quest requires reputation to complete
			if (uint32 repFaction = pQuest->GetRepObjectiveFaction())
			{
				uint32 repValue = pQuest->GetRepObjectiveValue();
				uint32 curRep = player->GetReputationMgr().GetReputation(repFaction);
				if (curRep < repValue)
					if (FactionEntry const *factionEntry = sFactionStore.LookupEntry(repFaction))
						player->GetReputationMgr().SetReputation(factionEntry, repValue);
			}

			// If the quest requires a SECOND reputation to complete
			if (uint32 repFaction = pQuest->GetRepObjectiveFaction2())
			{
				uint32 repValue2 = pQuest->GetRepObjectiveValue2();
				uint32 curRep = player->GetReputationMgr().GetReputation(repFaction);
				if (curRep < repValue2)
					if (FactionEntry const *factionEntry = sFactionStore.LookupEntry(repFaction))
						player->GetReputationMgr().SetReputation(factionEntry, repValue2);
			}

			// If the quest requires money
			int32 ReqOrRewMoney = pQuest->GetRewOrReqMoney();
			if (ReqOrRewMoney < 0)
				player->ModifyMoney(-ReqOrRewMoney);

					player->CompleteQuest(entry);
					return true;
        }
};

void AddSC_questbug_commandscript()
{
    new questbug_commandscript();
}
