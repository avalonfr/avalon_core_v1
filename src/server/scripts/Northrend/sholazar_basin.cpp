/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
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

/* ScriptData
SDName: Sholazar_Basin
SD%Complete: 100
SDComment: Quest support: 12570, 12573, 12621.
SDCategory: Sholazar_Basin
EndScriptData */

/* ContentData
npc_injured_rainspeaker_oracle
npc_vekjik
avatar_of_freya
EndContentData */

#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"

/*######
## npc_injured_rainspeaker_oracle
######*/

#define GOSSIP_ITEM1 "I am ready to travel to your village now."
#define GOSSIP_ITEM2 "<Reach down and pull the injured Rainspeaker Oracle to it's feet.>"

enum eRainspeaker
{
    SAY_START_IRO = -1571000,
    SAY_QUEST_ACCEPT_IRO = -1571001,
    SAY_END_IRO = -1571002,

    QUEST_FORTUNATE_MISUNDERSTANDINGS = 12570,
    QUEST_JUST_FOLLOWING_ORDERS = 12540,
    ENTRY_RAVENOUS_MANGAL_CROCOLISK = 28325,
    FACTION_ESCORTEE_A = 774,
    FACTION_ESCORTEE_H = 775
};

#define FACTION_FRENZYHEART 1104
#define FACTION_ORCLES 1105

class npc_injured_rainspeaker_oracle : public CreatureScript
{
public:
    npc_injured_rainspeaker_oracle() : CreatureScript("npc_injured_rainspeaker_oracle") { }

    struct npc_injured_rainspeaker_oracleAI : public npc_escortAI
    {
        npc_injured_rainspeaker_oracleAI(Creature* c) : npc_escortAI(c)
        {
            c_guid = c->GetGUID();
        }

        uint64 c_guid;

        void Reset()
        {
            me->RestoreFaction();
            // if we will have other way to assign this to only one npc remove this part
            if (GUID_LOPART(me->GetGUID()) != 101030)
            {
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }
        }

        void WaypointReached(uint32 i)
        {
            Player* player = GetPlayerForEscort();

            if (!player)
                return;

            switch(i)
            {
            case 1: SetRun(); break;
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
            case 18:
                me->RemoveUnitMovementFlag(MOVEMENTFLAG_SWIMMING);
                me->RemoveUnitMovementFlag(MOVEMENTFLAG_JUMPING);
                me->SetSpeed(MOVE_SWIM, 0.85f, true);
                me->AddUnitMovementFlag(MOVEMENTFLAG_SWIMMING | MOVEMENTFLAG_LEVITATING);
                break;
            case 19:
                me->SetUnitMovementFlags(MOVEMENTFLAG_JUMPING);
                break;
            case 28:
                player->GroupEventHappens(QUEST_FORTUNATE_MISUNDERSTANDINGS, me);
              // me->RestoreFaction();
                DoScriptText(SAY_END_IRO, me);
                SetRun(false);
                break;
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
                return;

            if (Player* player = GetPlayerForEscort())
              if (player->GetQuestStatus(QUEST_FORTUNATE_MISUNDERSTANDINGS) != QUEST_STATUS_COMPLETE)
                player->FailQuest(QUEST_FORTUNATE_MISUNDERSTANDINGS);
            }
    };

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_FORTUNATE_MISUNDERSTANDINGS) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        if (player->GetQuestStatus(QUEST_JUST_FOLLOWING_ORDERS) == QUEST_STATUS_INCOMPLETE
            && !creature->FindNearestCreature(ENTRY_RAVENOUS_MANGAL_CROCOLISK, 10.0f))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, false, player->GetGUID());
            CAST_AI(npc_escortAI, (creature->AI()))->SetMaxPlayerDistance(35.0f);
            creature->SetUnitMovementFlags(MOVEMENTFLAG_JUMPING);
            DoScriptText(SAY_START_IRO, creature);

            switch (player->GetTeam())
            {
            case ALLIANCE:
                creature->setFaction(FACTION_ESCORTEE_A);
                break;
            case HORDE:
                creature->setFaction(FACTION_ESCORTEE_H);
                break;
            }
        }
        else if (action == GOSSIP_ACTION_INFO_DEF + 2)
        {
            player->SummonCreature(ENTRY_RAVENOUS_MANGAL_CROCOLISK, *creature, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
            player->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    bool OnQuestAccept(Player* /*player*/, Creature* creature, Quest const* /*_Quest*/)
    {
        DoScriptText(SAY_QUEST_ACCEPT_IRO, creature);
        return false;
    }

    bool OnQuestReward(Player *player, Creature *_Creature, Quest const *_Quest, uint32 /*item*/)
    {
        switch(_Quest->GetQuestId())
        {
        case QUEST_JUST_FOLLOWING_ORDERS:
            player->GetReputationMgr().SetReputation(sFactionStore.LookupEntry(FACTION_ORCLES),3000);
            //player->GetReputationMgr().SetReputation(sFactionStore.LookupEntry(FACTION_FRENZYHEART),-600);
            break;
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_injured_rainspeaker_oracleAI(creature);
    }
};

/*######
## npc_vekjik
######*/

#define GOSSIP_VEKJIK_ITEM1 "Shaman Vekjik, I have spoken with the big-tongues and they desire peace. I have brought this offering on their behalf."
#define GOSSIP_VEKJIK_ITEM2 "No no... I had no intentions of betraying your people. I was only defending myself. it was all a misunderstanding."

enum eVekjik
{
    GOSSIP_TEXTID_VEKJIK1       = 13137,
    GOSSIP_TEXTID_VEKJIK2       = 13138,

    SAY_TEXTID_VEKJIK1          = -1000208,

    SPELL_FREANZYHEARTS_FURY    = 51469,

    QUEST_MAKING_PEACE          = 12573
};

class npc_vekjik : public CreatureScript
{
public:
    npc_vekjik() : CreatureScript("npc_vekjik") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_MAKING_PEACE) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_VEKJIK_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VEKJIK1, creature->GetGUID());
            return true;
        }

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_VEKJIK_ITEM2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VEKJIK2, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->CLOSE_GOSSIP_MENU();
                DoScriptText(SAY_TEXTID_VEKJIK1, creature, player);
				creature->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);
                player->AreaExploredOrEventHappens(QUEST_MAKING_PEACE);
                creature->CastSpell(player, SPELL_FREANZYHEARTS_FURY, false);
                break;
        }

        return true;
    }
};

/*######
## avatar_of_freya
######*/

#define GOSSIP_ITEM_AOF1 "I want to stop the Scourge as much as you do. How can I help?"
#define GOSSIP_ITEM_AOF2 "You can trust me. I am no friend of the Lich King."
#define GOSSIP_ITEM_AOF3 "I will not fail."

enum eFreya
{
    QUEST_FREYA_PACT         = 12621,

    SPELL_FREYA_CONVERSATION = 52045,

    GOSSIP_TEXTID_AVATAR1    = 13303,
    GOSSIP_TEXTID_AVATAR2    = 13304,
    GOSSIP_TEXTID_AVATAR3    = 13305
};

class npc_avatar_of_freya : public CreatureScript
{
public:
    npc_avatar_of_freya() : CreatureScript("npc_avatar_of_freya") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_FREYA_PACT) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXTID_AVATAR1, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (uiAction)
        {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXTID_AVATAR2, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXTID_AVATAR3, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->CastSpell(player, SPELL_FREYA_CONVERSATION, true);
            player->CLOSE_GOSSIP_MENU();
            break;
        }
        return true;
    }
};

/*######
## npc_bushwhacker
######*/

class npc_bushwhacker : public CreatureScript
{
public:
    npc_bushwhacker() : CreatureScript("npc_bushwhacker") { }

    struct npc_bushwhackerAI : public ScriptedAI
    {
        npc_bushwhackerAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void InitializeAI()
        {
            if (me->isDead())
                return;

            if (me->isSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                    if (summoner)
                        me->GetMotionMaster()->MovePoint(0, summoner->GetPositionX(), summoner->GetPositionY(), summoner->GetPositionZ());

            Reset();
        }

        void UpdateAI(const uint32 /*uiDiff*/)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bushwhackerAI(creature);
    }
};

/*######
## npc_engineer_helice
######*/

enum eEnums
{
    SPELL_EXPLODE_CRYSTAL       = 62487,
    SPELL_FLAMES                = 64561,

    SAY_WP_7                    = -1800047,
    SAY_WP_6                    = -1800048,
    SAY_WP_5                    = -1800049,
    SAY_WP_4                    = -1800050,
    SAY_WP_3                    = -1800051,
    SAY_WP_2                    = -1800052,
    SAY_WP_1                    = -1800053,

    QUEST_DISASTER              = 12688
};

class npc_engineer_helice : public CreatureScript
{
public:
    npc_engineer_helice() : CreatureScript("npc_engineer_helice") { }

    struct npc_engineer_heliceAI : public npc_escortAI
    {
        npc_engineer_heliceAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 m_uiChatTimer;

        void WaypointReached(uint32 i)
        {
            Player* player = GetPlayerForEscort();
            switch (i)
            {
                case 0:
                    DoScriptText(SAY_WP_2, me);
                    break;
                case 1:
                    DoScriptText(SAY_WP_3, me);
                    me->CastSpell(5918.33f, 5372.91f, -98.770f, SPELL_EXPLODE_CRYSTAL, true);
                    me->SummonGameObject(184743, 5918.33f, 5372.91f, -98.770f, 0, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN);     //approx 3 to 4 seconds
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    break;
                case 2:
                    DoScriptText(SAY_WP_4, me);
                    break;
                case 7:
                    DoScriptText(SAY_WP_5, me);
                    break;
                case 8:
                    me->CastSpell(5887.37f, 5379.39f, -91.289f, SPELL_EXPLODE_CRYSTAL, true);
                    me->SummonGameObject(184743, 5887.37f, 5379.39f, -91.289f, 0, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN);      //approx 3 to 4 seconds
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    break;
                case 9:
                    DoScriptText(SAY_WP_6, me);
                    break;
                case 13:
                    if (player)
                    {
                        player->GroupEventHappens(QUEST_DISASTER, me);
                        DoScriptText(SAY_WP_7, me);
                    }
                    break;
            }
        }

        void Reset()
        {
            m_uiChatTimer = 4000;
        }
        void JustDied(Unit* /*killer*/)
        {
            Player* player = GetPlayerForEscort();
            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (player)
                    player->FailQuest(QUEST_DISASTER);
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (m_uiChatTimer <= uiDiff)
                {
                    m_uiChatTimer = 12000;
                }
                else
                    m_uiChatTimer -= uiDiff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_engineer_heliceAI(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_DISASTER)
        {
            if (npc_engineer_heliceAI* pEscortAI = CAST_AI(npc_engineer_helice::npc_engineer_heliceAI, creature->AI()))
            {
                creature->GetMotionMaster()->MoveJumpTo(0, 0.4f, 0.4f);
                creature->setFaction(113);

                pEscortAI->Start(false, false, player->GetGUID());
                DoScriptText(SAY_WP_1, creature);
            }
        }
        return true;
    }
};

/*#####
## npc_jungle_punch_target
#####*/

#define SAY_OFFER     "Care to try Grimbooze Thunderbrew's new jungle punch?"
#define SAY_HEMET_1   "Aye, I'll try it."
#define SAY_HEMET_2   "That's exactly what I needed!"
#define SAY_HEMET_3   "It's got my vote! That'll put hair on your chest like nothing else will."
#define SAY_HADRIUS_1 "I'm always up for something of Grimbooze's."
#define SAY_HADRIUS_2 "Well, so far, it tastes like something my wife would drink..."
#define SAY_HADRIUS_3 "Now, there's the kick I've come to expect from Grimbooze's drinks! I like it!"
#define SAY_TAMARA_1  "Sure!"
#define SAY_TAMARA_2  "Oh my..."
#define SAY_TAMARA_3  "Tastes like I'm drinking... engine degreaser!"

enum utils
{
    NPC_HEMET   = 27986,
    NPC_HADRIUS = 28047,
    NPC_TAMARA  = 28568,
    SPELL_OFFER = 51962,
    QUEST_ENTRY = 12645,
};

class npc_jungle_punch_target : public CreatureScript
{
public:
    npc_jungle_punch_target() : CreatureScript("npc_jungle_punch_target") { }

    struct npc_jungle_punch_targetAI : public ScriptedAI
    {
        npc_jungle_punch_targetAI(Creature* creature) : ScriptedAI(creature) {}

        uint16 sayTimer;
        uint8 sayStep;

        void Reset()
        {
            sayTimer = 3500;
            sayStep = 0;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!sayStep)
                return;

            if (sayTimer < uiDiff)
            {
                switch (sayStep)
                {
                    case 0:
                    {
                        switch (me->GetEntry())
                        {
                            case NPC_HEMET:   me->MonsterSay(SAY_HEMET_1, LANG_UNIVERSAL, 0);   break;
                            case NPC_HADRIUS: me->MonsterSay(SAY_HADRIUS_1, LANG_UNIVERSAL, 0); break;
                            case NPC_TAMARA:  me->MonsterSay(SAY_TAMARA_1, LANG_UNIVERSAL, 0);  break;
                        }
                        sayTimer = 3000;
                        sayStep++;
                        break;
                    }
                    case 1:
                    {
                        switch (me->GetEntry())
                        {
                            case NPC_HEMET:   me->MonsterSay(SAY_HEMET_2, LANG_UNIVERSAL, 0);   break;
                            case NPC_HADRIUS: me->MonsterSay(SAY_HADRIUS_2, LANG_UNIVERSAL, 0); break;
                            case NPC_TAMARA:  me->MonsterSay(SAY_TAMARA_2, LANG_UNIVERSAL, 0);  break;
                        }
                        sayTimer = 3000;
                        sayStep++;
                        break;
                    }
                    case 2:
                    {
                        switch (me->GetEntry())
                        {
                            case NPC_HEMET:   me->MonsterSay(SAY_HEMET_3, LANG_UNIVERSAL, 0);   break;
                            case NPC_HADRIUS: me->MonsterSay(SAY_HADRIUS_3, LANG_UNIVERSAL, 0); break;
                            case NPC_TAMARA:  me->MonsterSay(SAY_TAMARA_3, LANG_UNIVERSAL, 0);  break;
                        }
                        sayTimer = 3000;
                        sayStep = 0;
                        break;
                    }
                }
            }
            else
                sayTimer -= uiDiff;
        }

        void SpellHit(Unit* caster, const SpellInfo* proto)
        {
            if (!proto || proto->Id != SPELL_OFFER)
                return;

            if (!caster->ToPlayer())
                return;

            QuestStatusMap::const_iterator itr = caster->ToPlayer()->getQuestStatusMap().find(QUEST_ENTRY);
            if (itr->second.m_status != QUEST_STATUS_INCOMPLETE)
                return;

            for (uint8 i=0; i<3; i++)
            {
                switch (i)
                {
                   case 0:
                       if (NPC_HEMET != me->GetEntry())
                           continue;
                       else
                           break;
                   case 1:
                       if (NPC_HADRIUS != me->GetEntry())
                           continue;
                       else
                           break;
                   case 2:
                       if (NPC_TAMARA != me->GetEntry())
                           continue;
                       else
                           break;
                }

                if (itr->second.m_creatureOrGOcount[i] != 0)
                    continue;

                caster->ToPlayer()->KilledMonsterCredit(me->GetEntry(), 0);
                caster->ToPlayer()->Say(SAY_OFFER, LANG_UNIVERSAL);
                sayStep = 0;
                break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_jungle_punch_targetAI(creature);
    }
};

/*######
## npc_adventurous_dwarf
######*/

#define GOSSIP_OPTION_ORANGE    "Can you spare an orange?"
#define GOSSIP_OPTION_BANANAS   "Have a spare bunch of bananas?"
#define GOSSIP_OPTION_PAPAYA    "I could really use a papaya."

enum eAdventurousDwarf
{
    QUEST_12634         = 12634,

    ITEM_BANANAS        = 38653,
    ITEM_PAPAYA         = 38655,
    ITEM_ORANGE         = 38656,

    SPELL_ADD_ORANGE    = 52073,
    SPELL_ADD_BANANAS   = 52074,
    SPELL_ADD_PAPAYA    = 52076,

    GOSSIP_MENU_DWARF   = 13307,

    SAY_DWARF_OUCH      = -1571042,
    SAY_DWARF_HELP      = -1571043
};

class npc_adventurous_dwarf : public CreatureScript
{
public:
    npc_adventurous_dwarf() : CreatureScript("npc_adventurous_dwarf") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        DoScriptText(SAY_DWARF_OUCH, creature);
        return NULL;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(QUEST_12634) != QUEST_STATUS_INCOMPLETE)
            return false;

        if (player->GetItemCount(ITEM_ORANGE) < 1)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_OPTION_ORANGE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        if (player->GetItemCount(ITEM_BANANAS) < 2)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_OPTION_BANANAS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        if (player->GetItemCount(ITEM_PAPAYA) < 1)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_OPTION_PAPAYA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

        player->PlayerTalkClass->SendGossipMenu(GOSSIP_MENU_DWARF, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        uint32 spellId = 0;
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF + 1: spellId = SPELL_ADD_ORANGE;     break;
            case GOSSIP_ACTION_INFO_DEF + 2: spellId = SPELL_ADD_BANANAS;    break;
            case GOSSIP_ACTION_INFO_DEF + 3: spellId = SPELL_ADD_PAPAYA;     break;
        }
        if (spellId)
            player->CastSpell(player, spellId, true);
        DoScriptText(SAY_DWARF_HELP, creature);
        creature->DespawnOrUnsummon();
        return true;
    }
};

/*######
## npc_mosswalker_victim
######*/

#define GOSSIP_ITEM_PULSE "<Check den Puls...>"

enum
{
    QUEST_MOSSWALKER_SAVIOR         = 12580,
    SPELL_DEAD_SOLDIER              = 45801,                // not clear what this does, but looks like all have it
    SPELL_MOSSWALKER_QUEST_CREDIT   = 52157,

    TEXT_ID_INJURED                 = 13318,

    EMOTE_PAIN                      = -1000641,

    SAY_RESCUE_1                    = -1000642,
    SAY_RESCUE_2                    = -1000643,
    SAY_RESCUE_3                    = -1000644,
    SAY_RESCUE_4                    = -1000645,

    SAY_DIE_1                       = -1000646,
    SAY_DIE_2                       = -1000647,
    SAY_DIE_3                       = -1000648,
    SAY_DIE_4                       = -1000649,
    SAY_DIE_5                       = -1000650,
    SAY_DIE_6                       = -1000651,
};

class npc_mosswalker_victim : public CreatureScript
{
public:
    npc_mosswalker_victim() : CreatureScript("npc_mosswalker_victim") { }

	bool OnGossipHello(Player* pPlayer, Creature* pCreature)
	{
		if (pPlayer->GetQuestStatus(QUEST_MOSSWALKER_SAVIOR) == QUEST_STATUS_INCOMPLETE)
		{
			// doesn't appear they always emote
			if (urand(0,3) == 0)
				DoScriptText(EMOTE_PAIN, pCreature);

			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_PULSE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
		}

		pPlayer->SEND_GOSSIP_MENU(TEXT_ID_INJURED, pCreature->GetGUID());
		return true;
	}

	bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
	{
		pPlayer->PlayerTalkClass->ClearMenus();
		if (uiAction == GOSSIP_ACTION_INFO_DEF)
		{
			pPlayer->CLOSE_GOSSIP_MENU();

			// just to prevent double credit
			if (pCreature->GetLootRecipient())
				return true;
			else
				pCreature->SetLootRecipient(pPlayer);

			if (urand(0,2))                                     // die
			{
				switch(urand(0,5))
				{
					case 0: DoScriptText(SAY_DIE_1, pCreature, pPlayer); break;
					case 1: DoScriptText(SAY_DIE_2, pCreature, pPlayer); break;
					case 2: DoScriptText(SAY_DIE_3, pCreature, pPlayer); break;
					case 3: DoScriptText(SAY_DIE_4, pCreature, pPlayer); break;
					case 4: DoScriptText(SAY_DIE_5, pCreature, pPlayer); break;
					case 5: DoScriptText(SAY_DIE_6, pCreature, pPlayer); break;
				}
			}
			else                                                // survive
			{
				switch(urand(0,3))
				{
					case 0: DoScriptText(SAY_RESCUE_1, pCreature, pPlayer); break;
					case 1: DoScriptText(SAY_RESCUE_2, pCreature, pPlayer); break;
					case 2: DoScriptText(SAY_RESCUE_3, pCreature, pPlayer); break;
					case 3: DoScriptText(SAY_RESCUE_4, pCreature, pPlayer); break;
				}

				pCreature->CastSpell(pPlayer, SPELL_MOSSWALKER_QUEST_CREDIT, true);
			}

			// more details may apply, instead of just despawn
			pCreature->ForcedDespawn(5000);
		}
		return true;
	}
};

/*######
## npc_tipsy_mcmanus
######*/

enum TipsyMcManus
{
    DATA_EVENT = 1,
    DATA_OBJECT_ENTRY = 2,
    QUEST_STILL_AT_IT = 12644,
    GOSSIP_TIPSY_MCMANUS_TEXT = 13288,
    GO_JUNGLE_PUNCH = 190643
};

static uint32 const goEntry[5] =
{
    190635,
    190636,
    190637,
    190638,
    190639
};

static char const* Instructions[6] =
{
    "Benutze das Druckventil!",
    "Heize die Kohlenpfanne an!",
    "Wirf noch eine Orange hinein, schnell!",
    "Misch ein paar Bananen hinzu!",
    "Schnell, eine Papaya!",
    "Nein, das war falsch! Wir muessen noch einmal beginnen."
};

#define GOSSIP_ITEM_TIPSY "Ich bin bereit, lass uns anfangen."

class npc_tipsy_mcmanus : public CreatureScript
{
    public:
        npc_tipsy_mcmanus() : CreatureScript("npc_tipsy_mcmanus") { }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
        {
            if (action == GOSSIP_ACTION_INFO_DEF + 1)
            {
                player->CLOSE_GOSSIP_MENU();
                creature->AI()->SetData(DATA_EVENT, 1);
                creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            }
            return true;
        }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            if (player->GetQuestStatus(QUEST_STILL_AT_IT) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_TIPSY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            player->SEND_GOSSIP_MENU(GOSSIP_TIPSY_MCMANUS_TEXT, creature->GetGUID());
            return true;
        }

        struct npc_tipsy_mcmanusAI : public ScriptedAI
        {
            npc_tipsy_mcmanusAI(Creature* c) : ScriptedAI(c) {}

            void Reset()
            {
                _event = false;
                _choice = true;
                _rnd = 0;
                _count = 0;
                _reactTimer = 10000;
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            }

            void SetData(uint32 id, uint32 data)
            {
                switch (id)
                {
                    case DATA_EVENT:
                        _event = data ? true : false;
                        break;
                    case DATA_OBJECT_ENTRY:
                        if (!_choice && data == goEntry[_rnd]) // used correct object
                        {
                            me->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
                            _choice = true;
                            _reactTimer = urand(5000, 7000);
                        }
                        break;
                }
            }

            void UpdateAI(uint32 const diff)
            {
                if (UpdateVictim())
                {
                    DoMeleeAttackIfReady();
                    return;
                }

                if (_event) // active
                {
                    if(_reactTimer <= diff)
                    {
                        if (_choice) // used correct object
                        {
                            ++_count;

                            if (_count > 10) // spawn quest reward and reset
                            {
                                float x, y, z;
                                me->GetPosition(x, y, z);
                                me->SummonGameObject(GO_JUNGLE_PUNCH, x + 1.2f, y + 0.8f, z - 0.23f, 0, 0, 0, 0, 0, 60);
                                Reset();
                                return;
                            }

                            _rnd = urand(0, 4);
                            me->MonsterSay(Instructions[_rnd], LANG_UNIVERSAL, 0); // give new instructions
                            me->HandleEmoteCommand(RAND(EMOTE_ONESHOT_EXCLAMATION, EMOTE_ONESHOT_POINT));
                            _choice = false; // reset choice
                        }
                        else // failed -> reset and try again
                        {
                            me->MonsterSay(Instructions[5], LANG_UNIVERSAL, 0);
                            me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                            Reset();
                            return;
                        }

                        _reactTimer = 10000;
                    }
                    else
                        _reactTimer -= diff;
                }
            }

        private:
            bool _event;
            bool _choice;
            uint8 _count;
            uint8 _rnd;
            uint32 _reactTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_tipsy_mcmanusAI(creature);
        }
};

/*######
## go_brew_event
######*/

enum BrewEvent
{
    NPC_TIPSY_MCMANUS = 28566
};

class go_brew_event : public GameObjectScript
{
    public:
        go_brew_event() : GameObjectScript("go_brew_event") { }

        bool OnGossipHello(Player* /*player*/, GameObject* go)
        {
            if (Creature* Tipsy = go->FindNearestCreature(NPC_TIPSY_MCMANUS, 30.0f, true))
                Tipsy->AI()->SetData(DATA_OBJECT_ENTRY, go->GetEntry());

            return false;
        }
};

/*######
## npc_stormwatcher
######*/

enum eSpells
{
    SPELL_CALL_LIGHTNING = 32018,
    SPELL_THROW_VENTURE_CO_EXPLOSIVES = 53145,
    SPELL_SUMMON_STORMWATCHERS_HEAD = 53162
};

class npc_stormwatcher : public CreatureScript
{
    public:
        npc_stormwatcher() : CreatureScript("npc_stormwatcher"){ }

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_stormwatcherAI(pCreature);
        }

        struct npc_stormwatcherAI : public ScriptedAI
        {
            npc_stormwatcherAI(Creature* pCreature) : ScriptedAI (pCreature){ }

            uint32 uiCallLightning_Timer;

            void Reset()
            {
                uiCallLightning_Timer = urand (3000,5000);
            }

            void SpellHit (Unit* /*caster*/, SpellInfo const* spell)
            {
                if (spell->Id == SPELL_THROW_VENTURE_CO_EXPLOSIVES)
                {
                    DoCast(me, SPELL_SUMMON_STORMWATCHERS_HEAD, true);
                    me->DespawnOrUnsummon();
                }
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (uiCallLightning_Timer <= diff)
                {
                    DoCastVictim(SPELL_CALL_LIGHTNING);
                    uiCallLightning_Timer = urand (3000,5000);
                }
                else uiCallLightning_Timer -= diff;

                DoMeleeAttackIfReady();
            }
        };
};

/*######
## Quest: Rejek: First Blood
######*/

enum enums
{
    ENTRY_SAPPHIRE_HIVE_WASP = 28086,
    ENTRY_HARDKNUCKLE_CHARGER = 28096,
    ENTRY_MISTWHISPER_ORACLE = 28110,
    ENTRY_MISTWHISPER_WARRIOR = 28109,
    // Kill Credit Entries from quest_template
    NPC_CREDIT_1 = 28040,
    NPC_CREDIT_2 = 36189,
    NPC_CREDIT_3 = 29043,

    SPELL_BLOOD_REJEKS_SWORD = 52992,
    SPELL_WASP_STINGER_RAGE = 34392,
    SPELL_CHARGER_CHARGE = 49758,
    SPELL_ORACLE_LIGHTNING_CLOUD= 54921,
    SPELL_WARRIOR_FLIP_ATTACK = 50533
};

class npc_rejek_first_blood : public CreatureScript
{
    public:
        npc_rejek_first_blood() : CreatureScript("npc_rejek_first_blood"){ }

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_rejek_first_bloodAI(pCreature);
        }

        struct npc_rejek_first_bloodAI : public ScriptedAI
        {
            npc_rejek_first_bloodAI(Creature* pCreature) : ScriptedAI (pCreature){ }

            uint32 uiFlipAttack_Timer;
            uint32 uiCharge_Timer;
            
            bool Frenzied;

            void Reset()
            {
                uiFlipAttack_Timer = urand (2000,6000);
                uiCharge_Timer = 0;
            }

            void EnterCombat (Unit* /*who*/)
            {
                Frenzied = false;

                if(me->GetEntry() == ENTRY_MISTWHISPER_ORACLE)
                    DoCast(me, SPELL_ORACLE_LIGHTNING_CLOUD, true);
            }

            void SpellHit (Unit* caster, SpellInfo const* spell)
            {
                if(spell->Id == SPELL_BLOOD_REJEKS_SWORD)
                {
                    if(caster && caster->ToPlayer())
                    {
                        switch(me->GetEntry())
                        {
                            case ENTRY_SAPPHIRE_HIVE_WASP:
                                caster->ToPlayer()->KilledMonsterCredit(NPC_CREDIT_1,0);
                                break;
                            case ENTRY_HARDKNUCKLE_CHARGER:
                                caster->ToPlayer()->KilledMonsterCredit(NPC_CREDIT_2,0);
                                break;
                            case ENTRY_MISTWHISPER_ORACLE:
                            case ENTRY_MISTWHISPER_WARRIOR:
                                caster->ToPlayer()->KilledMonsterCredit(NPC_CREDIT_3,0);
                                break;
                        }
                    }
                }
            }

            void UpdateAI(const uint32 diff)
            {
                if(!UpdateVictim())
                    return;

                if(me->GetEntry() == ENTRY_SAPPHIRE_HIVE_WASP)
                {
                    if(!Frenzied && HealthBelowPct(30))
                    {
                        DoCast(me, SPELL_WASP_STINGER_RAGE, true);
                        Frenzied = true;
                    }
                }

                if(me->GetEntry() == ENTRY_HARDKNUCKLE_CHARGER)
                {
                    if(uiCharge_Timer <= diff)
                    {
                        DoCastVictim(SPELL_CHARGER_CHARGE);
                        uiCharge_Timer = 5000;
                    }
                    else uiCharge_Timer -= diff;
                }

                if(me->GetEntry() == ENTRY_MISTWHISPER_WARRIOR)
                {
                    if(uiFlipAttack_Timer <= diff)
                    {
                        DoCastVictim(SPELL_WARRIOR_FLIP_ATTACK);
                        uiFlipAttack_Timer = urand (4000,7000);
                    }
                    else uiFlipAttack_Timer -= diff;
                }

                DoMeleeAttackIfReady();
            }
        };
};

/*######
## vehicle_haiphoon
######*/

enum eHaiphoon
{
    SPELL_DEVOUR_WIND = 52862,
    SPELL_DEVOUR_WATER = 52864,

    NPC_HAIPHOON_WATER = 28999,
    NPC_HAIPHOON_AIR = 28985
};

class vehicle_haiphoon : public CreatureScript
{
public:
    vehicle_haiphoon() : CreatureScript("vehicle_haiphoon") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new vehicle_haiphoonAI(pCreature);
    }

    struct vehicle_haiphoonAI : public VehicleAI
    {
        vehicle_haiphoonAI(Creature* pCreature) : VehicleAI(pCreature) { }

        void SpellHitTarget(Unit* target,SpellInfo const* spell)
        {
            if(target == me)
                return;
        
            if(spell->Id == SPELL_DEVOUR_WIND)
            {
                if(Player* player = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                {
                    player->KilledMonsterCredit(29009, 0);
                    me->UpdateEntry(NPC_HAIPHOON_AIR);
                    player->VehicleSpellInitialize();
                    me->setFaction(player->getFaction());
                }
            }

            if(spell->Id == SPELL_DEVOUR_WATER)
            {
                if(Player* player = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                {
                    player->KilledMonsterCredit(29008, 0);
                    me->UpdateEntry(NPC_HAIPHOON_WATER);
                    player->VehicleSpellInitialize();
                    me->setFaction(player->getFaction());
                }
            }
        }
	};	
};

enum mistwhisperTreasure
{
    QUEST_LOST_MISTWHISPER_TREASURE = 12575,
    NPC_WARLORD_TARTEK = 28105,
    ITEM_MISTWHISPER_TREASURE = 38601,
};

class go_mistwhisper_treasure : public GameObjectScript
{
public:
    go_mistwhisper_treasure() : GameObjectScript("go_mistwhisper_treasure") { }

    bool OnGossipHello(Player* player, GameObject* go)
    {
        if (player->HasItemCount(ITEM_MISTWHISPER_TREASURE, 1) && player->GetQuestStatus(QUEST_LOST_MISTWHISPER_TREASURE) == QUEST_STATUS_INCOMPLETE)
        {
            if (tartekGUID)
                if (Creature* tartek = player->GetCreature(*player, tartekGUID))
                    if (tartek->isAlive())
                        return false;
                    else
                        tartek->DespawnOrUnsummon();

            if (Creature* tartek = go->SummonCreature(NPC_WARLORD_TARTEK, 6708.30f, 5147.15f, 0.92712f, 4.9878f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000))
            {
                tartekGUID = tartek->GetGUID();
                tartek->GetMotionMaster()->MovePoint(0, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ());
            }
        }
        return true;
    }
private:
    uint64 tartekGUID;
};

void AddSC_sholazar_basin()
{
    new npc_injured_rainspeaker_oracle();
    new npc_vekjik();
    new npc_avatar_of_freya();
    new npc_bushwhacker();
    new npc_engineer_helice();
    new npc_adventurous_dwarf();
    new npc_jungle_punch_target();
	new npc_mosswalker_victim();
    new npc_tipsy_mcmanus();
    new go_brew_event();
    new npc_stormwatcher();
    new npc_rejek_first_blood();
	new vehicle_haiphoon();
	new go_mistwhisper_treasure();
}
