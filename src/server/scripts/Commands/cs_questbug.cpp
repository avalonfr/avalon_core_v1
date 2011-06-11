/*
 * Copyright (C) 2011 
 */

#include "ScriptPCH.h"
#include "Chat.h"

class questbug_commandscript : public CommandScript
{
    public:
        questbug_commandscript() : CommandScript("questdebug_commandscript") { }

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
            Player*  pPlayer = handler->GetSession()->GetPlayer();
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
            if (pPlayer->GetQuestStatus(entry) == QUEST_STATUS_NONE)
            {
                handler->PSendSysMessage(LANG_HAVENT_QUEST);
                handler->SetSentErrorMessage(true);
                return false;
            }
            pPlayer->CompleteQuest(entry);
            return true;
        }

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
};

void AddSC_questbug_commandscript()
{
    new questbug_commandscript();
}
