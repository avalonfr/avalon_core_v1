/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Moonglade
SD%Complete: 100
SDComment: Quest support: 30, 272, 5929, 5930, 10965. Special Flight Paths for Druid class.
SDCategory: Moonglade
EndScriptData */

/* ContentData
npc_bunthen_plainswind
npc_great_bear_spirit
npc_silva_filnaveth
npc_clintar_spirit
npc_clintar_dreamwalker
EndContentData */
#include "Group.h"
#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"

/*######
## npc_bunthen_plainswind
######*/

enum eBunthen
{
    QUEST_SEA_LION_HORDE        = 30,
    QUEST_SEA_LION_ALLY         = 272,
    TAXI_PATH_ID_ALLY           = 315,
    TAXI_PATH_ID_HORDE          = 316
};

#define GOSSIP_ITEM_THUNDER     "I'd like to fly to Thunder Bluff."
#define GOSSIP_ITEM_AQ_END      "Do you know where I can find Half Pendant of Aquatic Endurance?"

class npc_bunthen_plainswind : public CreatureScript
{
public:
    npc_bunthen_plainswind() : CreatureScript("npc_bunthen_plainswind") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch(uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->CLOSE_GOSSIP_MENU();
                if (player->getClass() == CLASS_DRUID && player->GetTeam() == HORDE)
                    player->ActivateTaxiPathTo(TAXI_PATH_ID_HORDE);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                player->SEND_GOSSIP_MENU(5373, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                player->SEND_GOSSIP_MENU(5376, creature->GetGUID());
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->getClass() != CLASS_DRUID)
            player->SEND_GOSSIP_MENU(4916, creature->GetGUID());
        else if (player->GetTeam() != HORDE)
        {
            if (player->GetQuestStatus(QUEST_SEA_LION_ALLY) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AQ_END, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

            player->SEND_GOSSIP_MENU(4917, creature->GetGUID());
        }
        else if (player->getClass() == CLASS_DRUID && player->GetTeam() == HORDE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_THUNDER, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            if (player->GetQuestStatus(QUEST_SEA_LION_HORDE) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AQ_END, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

            player->SEND_GOSSIP_MENU(4918, creature->GetGUID());
        }
        return true;
    }

};

/*######
## npc_great_bear_spirit
######*/

#define GOSSIP_BEAR1 "What do you represent, spirit?"
#define GOSSIP_BEAR2 "I seek to understand the importance of strength of the body."
#define GOSSIP_BEAR3 "I seek to understand the importance of strength of the heart."
#define GOSSIP_BEAR4 "I have heard your words, Great Bear Spirit, and I understand. I now seek your blessings to fully learn the way of the Claw."

class npc_great_bear_spirit : public CreatureScript
{
public:
    npc_great_bear_spirit() : CreatureScript("npc_great_bear_spirit") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_BEAR2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(4721, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_BEAR3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->SEND_GOSSIP_MENU(4733, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_BEAR4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->SEND_GOSSIP_MENU(4734, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                player->SEND_GOSSIP_MENU(4735, creature->GetGUID());
                if (player->GetQuestStatus(5929) == QUEST_STATUS_INCOMPLETE)
                    player->AreaExploredOrEventHappens(5929);
                if (player->GetQuestStatus(5930) == QUEST_STATUS_INCOMPLETE)
                    player->AreaExploredOrEventHappens(5930);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        //ally or horde quest
        if (player->GetQuestStatus(5929) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(5930) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_BEAR1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
            player->SEND_GOSSIP_MENU(4719, creature->GetGUID());
        }
        else
            player->SEND_GOSSIP_MENU(4718, creature->GetGUID());

        return true;
    }

};

/*######
## npc_silva_filnaveth
######*/

#define GOSSIP_ITEM_RUTHERAN    "I'd like to fly to Rut'theran Village."
#define GOSSIP_ITEM_AQ_AGI      "Do you know where I can find Half Pendant of Aquatic Agility?"

class npc_silva_filnaveth : public CreatureScript
{
public:
    npc_silva_filnaveth() : CreatureScript("npc_silva_filnaveth") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch(uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->CLOSE_GOSSIP_MENU();
                if (player->getClass() == CLASS_DRUID && player->GetTeam() == ALLIANCE)
                    player->ActivateTaxiPathTo(TAXI_PATH_ID_ALLY);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                player->SEND_GOSSIP_MENU(5374, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                player->SEND_GOSSIP_MENU(5375, creature->GetGUID());
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->getClass() != CLASS_DRUID)
            player->SEND_GOSSIP_MENU(4913, creature->GetGUID());
        else if (player->GetTeam() != ALLIANCE)
        {
            if (player->GetQuestStatus(QUEST_SEA_LION_HORDE) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AQ_AGI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

            player->SEND_GOSSIP_MENU(4915, creature->GetGUID());
        }
        else if (player->getClass() == CLASS_DRUID && player->GetTeam() == ALLIANCE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_RUTHERAN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            if (player->GetQuestStatus(QUEST_SEA_LION_ALLY) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AQ_AGI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

            player->SEND_GOSSIP_MENU(4914, creature->GetGUID());
        }
        return true;
    }

};

/*######
## npc_clintar_spirit
######*/

float Clintar_spirit_WP[41][5] =
{
 //pos_x   pos_y    pos_z    orien waitTime
{7465.28f, -3115.46f, 439.327f, 0.83f, 4000},
{7476.49f, -3101,    443.457f, 0.89f, 0},
{7486.57f, -3085.59f, 439.478f, 1.07f, 0},
{7472.19f, -3085.06f, 443.142f, 3.07f, 0},
{7456.92f, -3085.91f, 438.862f, 3.24f, 0},
{7446.68f, -3083.43f, 438.245f, 2.40f, 0},
{7446.17f, -3080.21f, 439.826f, 1.10f, 6000},
{7452.41f, -3085.8f,  438.984f, 5.78f, 0},
{7469.11f, -3084.94f, 443.048f, 6.25f, 0},
{7483.79f, -3085.44f, 439.607f, 6.25f, 0},
{7491.14f, -3090.96f, 439.983f, 5.44f, 0},
{7497.62f, -3098.22f, 436.854f, 5.44f, 0},
{7498.72f, -3113.41f, 434.596f, 4.84f, 0},
{7500.06f, -3122.51f, 434.749f, 5.17f, 0},
{7504.96f, -3131.53f, 434.475f, 4.74f, 0},
{7504.31f, -3133.53f, 435.693f, 3.84f, 6000},
{7504.55f, -3133.27f, 435.476f, 0.68f, 15000},
{7501.99f, -3126.01f, 434.93f,  1.83f, 0},
{7490.76f, -3114.97f, 434.431f, 2.51f, 0},
{7479.64f, -3105.51f, 431.123f, 1.83f, 0},
{7474.63f, -3086.59f, 428.994f, 1.83f, 2000},
{7472.96f, -3074.18f, 427.566f, 1.57f, 0},
{7472.25f, -3063,    428.268f, 1.55f, 0},
{7473.46f, -3054.22f, 427.588f, 0.36f, 0},
{7475.08f, -3053.6f,  428.653f, 0.36f, 6000},
{7474.66f, -3053.56f, 428.433f, 3.19f, 4000},
{7471.81f, -3058.84f, 427.073f, 4.29f, 0},
{7472.16f, -3064.91f, 427.772f, 4.95f, 0},
{7471.56f, -3085.36f, 428.924f, 4.72f, 0},
{7473.56f, -3093.48f, 429.294f, 5.04f, 0},
{7478.94f, -3104.29f, 430.638f, 5.23f, 0},
{7484.46f, -3109.61f, 432.769f, 5.79f, 0},
{7490.23f, -3111.08f, 434.431f, 0.02f, 0},
{7496.29f, -3108,    434.783f, 1.15f, 0},
{7497.46f, -3100.66f, 436.191f, 1.50f, 0},
{7495.64f, -3093.39f, 438.349f, 2.10f, 0},
{7492.44f, -3086.01f, 440.267f, 1.38f, 0},
{7498.26f, -3076.44f, 440.808f, 0.71f, 0},
{7506.4f,  -3067.35f, 443.64f,  0.77f, 0},
{7518.37f, -3057.42f, 445.584f, 0.74f, 0},
{7517.51f, -3056.3f,  444.568f, 2.49f, 4500}
};

#define ASPECT_RAVEN 22915

#define ASPECT_RAVEN_SUMMON_X 7472.96f
#define ASPECT_RAVEN_SUMMON_Y -3074.18f
#define ASPECT_RAVEN_SUMMON_Z 427.566f
#define CLINTAR_SPIRIT_SUMMON_X 7459.2275f
#define CLINTAR_SPIRIT_SUMMON_Y -3122.5632f
#define CLINTAR_SPIRIT_SUMMON_Z 438.9842f
#define CLINTAR_SPIRIT_SUMMON_O 0.8594f

//from -1000292 to -1000287 are signed for 7806. but all this texts ids wrong.
#define CLINTAR_SPIRIT_SAY_START -1000286
#define CLINTAR_SPIRIT_SAY_UNDER_ATTACK_1 -1000287
#define CLINTAR_SPIRIT_SAY_UNDER_ATTACK_2 -1000288
#define CLINTAR_SPIRIT_SAY_GET_ONE -1000289
#define CLINTAR_SPIRIT_SAY_GET_TWO -1000290
#define CLINTAR_SPIRIT_SAY_GET_THREE -1000291
#define CLINTAR_SPIRIT_SAY_GET_FINAL -1000292

class npc_clintar_spirit : public CreatureScript
{
public:
    npc_clintar_spirit() : CreatureScript("npc_clintar_spirit") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_clintar_spiritAI (creature);
    }

    struct npc_clintar_spiritAI : public npc_escortAI
    {
    public:
        npc_clintar_spiritAI(Creature* c) : npc_escortAI(c) {}

        uint32 Step;
        uint32 CurrWP;
        uint32 Event_Timer;
        uint32 checkPlayer_Timer;

        uint64 PlayerGUID;

        bool Event_onWait;

        void Reset()
        {
            if (!PlayerGUID)
            {
                Step = 0;
                CurrWP = 0;
                Event_Timer = 0;
                PlayerGUID = 0;
                checkPlayer_Timer = 1000;
                Event_onWait = false;
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            if (!PlayerGUID)
                return;

            Player* player = Unit::GetPlayer(*me, PlayerGUID);
            if (player && player->GetQuestStatus(10965) == QUEST_STATUS_INCOMPLETE)
            {
                player->FailQuest(10965);
                PlayerGUID = 0;
                Reset();
            }
        }

        void EnterEvadeMode()
        {
            Player* player = Unit::GetPlayer(*me, PlayerGUID);
            if (player && player->isInCombat() && player->getAttackerForHelper())
            {
                AttackStart(player->getAttackerForHelper());
                return;
            }
            npc_escortAI::EnterEvadeMode();
        }

        void EnterCombat(Unit* who)
        {
            uint32 rnd = rand()%2;
            switch(rnd)
            {
                case 0: DoScriptText(CLINTAR_SPIRIT_SAY_UNDER_ATTACK_1, me, who); break;
                case 1: DoScriptText(CLINTAR_SPIRIT_SAY_UNDER_ATTACK_2, me, who); break;
            }
        }

        void StartEvent(Player* player)
        {
            if (!player)
                return;
            if (player->GetQuestStatus(10965) == QUEST_STATUS_INCOMPLETE)
            {
                for (uint8 i = 0; i < 41; ++i)
                {
                    AddWaypoint(i, Clintar_spirit_WP[i][0], Clintar_spirit_WP[i][1], Clintar_spirit_WP[i][2], (uint32)Clintar_spirit_WP[i][4]);
                }
                PlayerGUID = player->GetGUID();
                Start(true, false, PlayerGUID);
            }
            return;
        }

        void UpdateAI(const uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);

            if (!PlayerGUID)
            {
                me->setDeathState(JUST_DIED);
                return;
            }

            if (!me->isInCombat() && !Event_onWait)
            {
                if (checkPlayer_Timer <= diff)
                {
                    Player* player = Unit::GetPlayer(*me, PlayerGUID);
                    if (player && player->isInCombat() && player->getAttackerForHelper())
                        AttackStart(player->getAttackerForHelper());
                    checkPlayer_Timer = 1000;
                } else checkPlayer_Timer -= diff;
            }

            if (Event_onWait && Event_Timer <= diff)
            {

                Player* player = Unit::GetPlayer(*me, PlayerGUID);
                if (!player || (player && player->GetQuestStatus(10965) == QUEST_STATUS_NONE))
                {
                    me->setDeathState(JUST_DIED);
                    return;
                }

                switch(CurrWP)
                {
                    case 0:
                        switch(Step)
                        {
                            case 0:
                                me->Say(CLINTAR_SPIRIT_SAY_START, 0, PlayerGUID);
                                Event_Timer = 8000;
                                Step = 1;
                                break;
                            case 1:
                                Event_onWait = false;
                                break;
                        }
                        break;
                    case 6:
                        switch(Step)
                        {
                            case 0:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 133);
                                Event_Timer = 5000;
                                Step = 1;
                                break;
                            case 1:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                                DoScriptText(CLINTAR_SPIRIT_SAY_GET_ONE, me, player);
                                Event_onWait = false;
                                break;
                        }
                        break;
                    case 15:
                        switch(Step)
                        {
                            case 0:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 133);
                                Event_Timer = 5000;
                                Step = 1;
                                break;
                            case 1:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                                Event_onWait = false;
                                break;
                        }
                        break;
                    case 16:
                        switch(Step)
                        {
                            case 0:
                                DoScriptText(CLINTAR_SPIRIT_SAY_GET_TWO, me, player);
                                Event_Timer = 15000;
                                Step = 1;
                                break;
                            case 1:
                                Event_onWait = false;
                                break;
                        }
                        break;
                    case 20:
                        switch(Step)
                        {
                            case 0:
                                {
                                Creature* mob = me->SummonCreature(ASPECT_RAVEN, ASPECT_RAVEN_SUMMON_X, ASPECT_RAVEN_SUMMON_Y, ASPECT_RAVEN_SUMMON_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000);
                                if (mob)
                                {
                                    mob->AddThreat(me, 10000.0f);
                                    mob->AI()->AttackStart(me);
                                }
                                Event_Timer = 2000;
                                Step = 1;
                                break;
                                }
                            case 1:
                                Event_onWait = false;
                                break;
                        }
                        break;
                    case 24:
                        switch(Step)
                        {
                            case 0:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 133);
                                Event_Timer = 5000;
                                Step = 1;
                                break;
                            case 1:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                                Event_onWait = false;
                                break;
                        }
                        break;
                    case 25:
                        switch(Step)
                        {
                            case 0:
                                DoScriptText(CLINTAR_SPIRIT_SAY_GET_THREE, me, player);
                                Event_Timer = 4000;
                                Step = 1;
                                break;
                            case 1:
                                Event_onWait = false;
                                break;
                        }
                        break;
                    case 40:
                        switch(Step)
                        {
                            case 0:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 2);
                                DoScriptText(CLINTAR_SPIRIT_SAY_GET_FINAL, me, player);
                                player->CompleteQuest(10965);
                                Event_Timer = 1500;
                                Step = 1;
                                break;
                            case 1:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                                Event_Timer = 3000;
                                Step = 2;
                                break;
                            case 2:
                                player->TalkedToCreature(me->GetEntry(), me->GetGUID());
                                PlayerGUID = 0;
                                Reset();
                                me->setDeathState(JUST_DIED);
                                break;
                        }
                        break;
                    default:
                        Event_onWait = false;
                        break;
                }

            } else if (Event_onWait) Event_Timer -= diff;
        }

        void WaypointReached(uint32 id)
        {
            CurrWP = id;
            Event_Timer = 0;
            Step = 0;
            Event_onWait = true;
        }
    };

};

/*####
# npc_clintar_dreamwalker
####*/

#define CLINTAR_SPIRIT 22916

class npc_clintar_dreamwalker : public CreatureScript
{
public:
    npc_clintar_dreamwalker() : CreatureScript("npc_clintar_dreamwalker") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const *quest)
    {
        if (quest->GetQuestId() == 10965)
        {
            Creature* clintar_spirit = creature->SummonCreature(CLINTAR_SPIRIT, CLINTAR_SPIRIT_SUMMON_X, CLINTAR_SPIRIT_SUMMON_Y, CLINTAR_SPIRIT_SUMMON_Z, CLINTAR_SPIRIT_SUMMON_O, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 100000);
            if (clintar_spirit)
                CAST_AI(npc_clintar_spirit::npc_clintar_spiritAI, clintar_spirit->AI())->StartEvent(player);
        }
        return true;
    }

};

/*####
# The Nightmare Manifests (8736) quest-event
####*/

#define QUEST_NIGHTMARE_MANIFESTS    8736

#define NPC_REMULOS                  11832
#define NPC_ERANIKUS                 15491
#define NPC_TYRANDE                  15633
#define NPC_NIGHTMARE_PHANTASM       15629
#define NPC_MOONGLADE_WARDEN         11822 

#define WP_COUNT                       17
#define NPC_NIGHTMARE_PHANTASMS_COUNT  25 // "There are many of them" (c) wowhead
#define NPC_MOONGLADE_WARDENS_COUNT    10  // All city guards should assist in battle

#define spell_Conjure_Dream_Rift       25813
#define spell_Starfire                 21668


float remulos_WP[WP_COUNT][5] =
{
// x         y           z     orien   waitTime
{7829.66f, -2244.87f, 463.87f, 4.13f, 3000},
{7817.25f, -2306.20f, 456.00f, 6.19f, 0},
{7866.54f, -2312.20f, 463.32f, 6.21f, 0},
{7942.543457f, -2320.170654f, 476.770355f, 4.991899f, 0},
{7953.036133f, -2357.953613f, 486.379303f, 4.878017f, 0},
{7962.706055f, -2411.155518f, 488.955231f, 4.736650f, 0},
{7976.860352f, -2552.697998f, 490.081390f, 3.305654f, 0},
{7949.307617f, -2569.120361f, 489.716248f, 4.428772f, 0},
{7950.945801f, -2597.000000f, 489.765564f, 4.550511f, 0},
{7948.758301f, -2610.823486f, 492.368988f, 4.436631f, 0},
{7928.785156f, -2629.920654f, 492.524933f, 3.981101f, 0}, // 10, speaking with Eranikus
{7948.697754f, -2610.551758f, 492.363983f, 1.366361f, 0},
{7952.019531f, -2591.974609f, 490.081238f, 1.393850f, 0},
{7940.567871f, -2577.845703f, 488.946808f, 2.886107f, 0},
{7908.662109f, -2566.450439f, 488.634644f, 2.862545f, 0},
{7873.132324f, -2567.422363f, 486.946442f, 3.239536f, 0},
{7839.844238f, -2570.598877f, 489.286224f, 3.243463f, 0} // 16, fighting (with phantasms)
};

// real positions are unknown, somewhere outside building
float phantasms_spawnpos[6][4] =
{
// x                  y         z           orien
{7870.747070f, -2589.451904f, 486.918121f, 1.744260f},
{7859.779297f, -2548.876709f, 486.872559f, 5.368867f},
{7930.114746f, -2548.529541f, 486.591217f, 3.660625f},
{7906.033691f, -2592.193115f, 485.090118f, 2.282248f},
{7925.208984f, -2574.688477f, 489.643951f, 2.922349f},
{7892.436523f, -2526.877441f, 485.581818f, 4.512779f},
};

// most of abilities not implemented - see http://www.wowhead.com/npc=11832#abilities for a full list
class npc_remulos : public CreatureScript
{
public:
    npc_remulos() : CreatureScript("npc_remulos") { }

    bool OnQuestAccept(Player* pPlayer, Creature* pCreature, Quest const *quest)
    {
        if (quest->GetQuestId() == QUEST_NIGHTMARE_MANIFESTS)
            CAST_AI(npc_remulos::npc_remulosAI, pCreature->AI())->StartEvent(pPlayer);

        return true;
    }

    struct npc_remulosAI : public npc_escortAI
    {
    public:
        npc_remulosAI(Creature *c) : npc_escortAI(c) {}

        uint64 PlayerGUID;
        uint32 uiEvent_Timer;
        uint32 uiPhase;
        uint32 uiCheckPlayer_Timer;
        uint32 uiStarfire_timer;
        bool bCanFight;
        // I'm using remulos as a storage for global event variables
        Creature* Eranikus; // it's easier to store it here than finding him every time when need
        uint32 uiCountDeadNightmares;

        void Reset()
        {
            bCanFight = false;
            PlayerGUID = 0;
            uiEvent_Timer = 0;
            uiPhase = 0;
            uiCheckPlayer_Timer = 5000;
            uiStarfire_timer = urand(7*IN_MILLISECONDS, 10*IN_MILLISECONDS); // real timer is unknown

            Eranikus = NULL;
            uiCountDeadNightmares = 0;

            me->SetRespawnTime(0); // doesn't work?
            SetRun(true);
            SetDespawnAtEnd(false);
            SetDespawnAtFar(false); // on offy you should be within at least ~50 yards to Remulos
            // some stuff for restarting event
            //ResetStatus();
            // re-enable flags
            me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
        }

		std::string getClassName(Unit* pPlayer)
		{
			switch (pPlayer->getClass())
			{
			   case CLASS_WARRIOR:         return "Warrior";
				case CLASS_PALADIN:         return "Paladin";
				case CLASS_HUNTER:          return "Hunter";
				case CLASS_ROGUE:           return "Rogue";
				case CLASS_PRIEST:          return "Priest";
				case CLASS_DEATH_KNIGHT:    return "Death Knight";
				case CLASS_SHAMAN:          return "Shaman";
				case CLASS_MAGE:            return "Mage";
				case CLASS_WARLOCK:         return "Warlock";
				case CLASS_DRUID:           return "Druid";
			}
			return "";
		}

        void StartEvent(Player* pPlayer)
        {
            if (!pPlayer)
                return;

            PlayerGUID = pPlayer->GetGUID();

            for (uint8 i = 0; i < WP_COUNT; ++i)
                AddWaypoint(i, remulos_WP[i][0], remulos_WP[i][1], remulos_WP[i][2], (uint32)remulos_WP[i][4]);

            // no easier way? :/

            std::string sText =
                ("We will locate the origin of the Nightmare through the fragments you collected, " +
                std::string(pPlayer->GetName()) + 
                ". From there, we will pull Eranikus through a rift in the Dream. Steel yourself, " +
                getClassName(pPlayer) + ". We are inviting the embodiment of the Nightmare into our world." 
                );
            me->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);

            Start(false, true, PlayerGUID); // run, no attack

            return;
        }

        // loose - from Eranikus's death
        void CheckPlayer(bool loose = false)
        {
            if (!PlayerGUID)
                return;

            Player* pPlayer = GetPlayerForEscort();
            // Defend yourself
            if (!pPlayer) // player exited game
            {
                Reset();
                return;
            }
            else if (Group* pGroup = pPlayer->GetGroup())
			{
			    for (GroupReference* pRef = pGroup->GetFirstMember(); pRef != NULL; pRef = pRef->next())
			    {
			        if (Player* pMember = pRef->getSource())
			        {
						if (!pMember->isAlive())
							loose = true;
					}
			    }
            } else if (!pPlayer->isAlive()) // solo
            {
                pPlayer->FailQuest(QUEST_NIGHTMARE_MANIFESTS);

                Reset();

                return;
            }

            if (pPlayer && loose)
            {
                pPlayer->FailQuest(QUEST_NIGHTMARE_MANIFESTS);

                Reset();

                return;
            }

            return;
        }

        void WaypointReached(uint32 id)
        {
            CheckPlayer();
            switch (id)
            {
                case 0:
                    me->MonsterSay("To Nighthaven! Keep your army close, champion.", LANG_UNIVERSAL, 0);
                    break;
                // start phase with Eranikus (speaking)
                case 10:
                    {
                        uiPhase = 2;
                        SetEscortPaused(true); // No move
                        Player* pPlayer = GetPlayerForEscort();

                        std::string sText =
                            ("The rift will be opened there, above the Lake Elun'ara. Prepare yourself, " +
                            std::string(getClassName(pPlayer)) + 
                            ". Eranikus's entry into our world will be wrought with chaos and strife." 
                            );
                        me->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);
                        uiEvent_Timer = 5000; // start using it as a speech timer
                        break;
                    }
                // fighting with shades, it's last waypoint. Remulos should follow player after this one.
                case WP_COUNT-1:
                    {
                        //SetRun(true);
                        Player* pPlayer = GetPlayerForEscort();
                        me->SetFacingToObject(GetPlayerForEscort()); // or -180 degrees

                        std::string sText =
                            ("Please, champion, protect our people." 
                            );
                        me->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiPhase++;
                        uiEvent_Timer = 3000;
                        SetEscortPaused(true); // No move on waypoints
                        break;
                    }
            }
        }

        void EnterCombat(Unit * /*who*/)
        {
        }

        void JustDied(Unit * /*killer*/)
        {
            if (!PlayerGUID)
                return;

            if (Player* pPlayer = GetPlayerForEscort())
                pPlayer->FailQuest(QUEST_NIGHTMARE_MANIFESTS);
			
            npc_escortAI::JustDied(NULL);

            Reset(); // will it be called when respawned?
            //me->Respawn(true); // not offlike?
        }

        void JustRespawned()
        {
            if (!PlayerGUID)
                return;

            if (Player* pPlayer = GetPlayerForEscort())
                pPlayer->FailQuest(QUEST_NIGHTMARE_MANIFESTS);

            npc_escortAI::JustRespawned();
        }

        void UpdateAI(const uint32 diff)
        {           
            if (!PlayerGUID)
                return;

            npc_escortAI::UpdateAI(diff);


            // uiEvent_Timer partly handled in WaypointReached
            if (uiEvent_Timer <= diff)
            {
                Player* pPlayer = GetPlayerForEscort();
                if (!pPlayer) // not in world
                    EnterEvadeMode();


                switch (uiPhase)
                {
                // standing on floor of a 'house' and speaking a lot
                case 2:
                    {
						sLog->outError("Phase %d ****************************************************",uiPhase);

                        std::string sText =
                            ("He will stop at nothing to get to Malfurion's physical manifistation. That must not happen... We must keep the beast occupied long enough for Tyrande to arrive." 
                            );
                        me->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiPhase++;
                        uiEvent_Timer = 4000;
                        break;
                    }
                // still speaking
                case 3:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        std::string sText =
                            ("Defend Nighthaven, hero..." 
                            );
                        me->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);
                        DoCast(spell_Conjure_Dream_Rift); // visual

                        uiPhase++;
                        uiEvent_Timer = 10000; // casting time
                        break;
                    }
                // summon Eranikus
                case 4:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        // not server-wide emote on 3.3.5+ !
                        std::string sText =
                            ("Eranikus, Tyrant of the Dream, has entered our world." 
                            );
                        me->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0); // TODO: make it real 'Zone' (now radius is 500.0f)
                        // near right coords, looks better than on offy
                        Position pos;
                        me->GetPosition(&pos);
                        pos.m_positionX -= 20;
                        pos.m_positionY -= 20;
                        pos.m_positionZ += 20;
                        // we will need NPC_ERANIKUS until event finish
                        if (Creature* e = me->SummonCreature(NPC_ERANIKUS, pos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60*IN_MILLISECONDS))
                        {
                            Eranikus = e;
                            Eranikus->SetFlying(true);
                            Eranikus->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                            Eranikus->SetReactState(REACT_PASSIVE);
                            Eranikus->SetFacingToObject(me);
                        }
                        else Reset(); // Should never happens

                        uiPhase++;
                        uiEvent_Timer = 5000;
                        break;
                    }
                // First Eranikus speach
                case 5:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        std::string sText =
                            ("Pitful predictable mortals... You know not what you have done! The master's will fulfilled. The Moonglade shall be destroyed and Malfurion along with it!" 
                            );
                        Eranikus->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiPhase++;
                        uiEvent_Timer = 5000;
                        break;
                    }
                // Renaulos answering
                case 6:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        std::string sText =
                            ("Fiend! Face the might of Cenarius!" 
                            );
                        me->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiPhase++;
                        uiEvent_Timer = 2000;
                        break;
                    }
                // Eranikus answering
                case 7:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        Eranikus->MonsterTextEmote(" lets loose a sinister laugh.", true);
                        std::string sText =
                            ("You are certanly not your father, insect. Should it interest me, I would crush you with but a swipe of my claws. Turn Shan'do Stormrage over to me and your pitiful life will be spared along with the lives of your people." 
                            );
                        Eranikus->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiPhase++;
                        uiEvent_Timer = 6500;
                        break;
                    }
                // Renaulos answering 2
                case 8:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        std::string sText =
                            ("Who is the predictable one, beast? Surely you did not think that we would summon you on top of Malfurion? Your redemption comes, Eranikus. You will be cleansed of this madness - this corruption." 
                            );
                        me->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiPhase++;
                        uiEvent_Timer = 6000;
                        break;
                    }
                // Eranikus answering 2
                case 9:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        std::string sText =
                            ("My redemption? You are bold, little one. My redemption comes by the will of my god." 
                            );
                        Eranikus->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);
                        Eranikus->MonsterTextEmote(" lets loose a sinister laugh.", true);
                        Eranikus->GetMotionMaster()->MoveCharge(7908.616699f, -2568.102539f, 520.725739f, 30.0f);//(remulos_WP[15][1], remulos_WP[15][2], remulos_WP[15][3]+30.0f, 30.0f);

                        uiPhase++;
                        uiEvent_Timer = 3000;
                        break;
                    }
                // Renaulos answering 3 and continue moving
                case 10:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        std::string sText =
                            ("Hurry, " +
                            std::string(pPlayer->GetName()) +
                            "! We must find protective cover!"
                            );
                        me->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);
                        //Eranikus->SetVisibility(VISIBILITY_OFF); invisible for a some time?

                        //SetRun(false); Looks like his speed is getting slower, but not as walking speed
                        SetEscortPaused(false); // Continue move
                        uiEvent_Timer = 600000; // wait until remulos goes to waypoint 16 and change phase, this case block shouldn't be called twice
                        break;
                    }
                // First fighting
                case 11:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        std::string sText =
                            ("Rise, servants of the Nightmare! Rise and destroy this world! Let there be no survivors..." 
                            );
                        Eranikus->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);

                        SetEscortPaused(true);
                        std::string sText2 = ("We will battle these fiends, together! Nighthaven's Defenders are also among us. They will fight to the death if asked. Now, quickly, we must drive these aberations back to the Nightmare. Destroy them all!");
                        me->MonsterSay(sText2.c_str(), LANG_UNIVERSAL, 0);

                        // summon phantasms and add Remalous as variable (because of uiCountDeadNightmares)
                        for (int i = 0; i < NPC_NIGHTMARE_PHANTASMS_COUNT; i++)
                        {
                            uint32 r = urand(0, 5);
                            float collision = (float)urand(4, 8); // 4-8 yards, just for visual
                            if (Creature* phantasm = Eranikus->SummonCreature(NPC_NIGHTMARE_PHANTASM, phantasms_spawnpos[r][0]+collision, phantasms_spawnpos[r][1]+collision, phantasms_spawnpos[r][2], phantasms_spawnpos[r][3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60*IN_MILLISECONDS))
                            {
                                // store Remulos in phantasms script                              
                                phantasm->AI()->JustSummoned(me);
                            }
                        }

                        // he should attack phantasms if they are near
                        SetCanAttack(true); bCanFight = true;

                        uiPhase++;
                        uiCheckPlayer_Timer = 0;
                        uiEvent_Timer = 5000;
                        break;
                    }
                // Eranikus phrase
                case 12:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        std::string sText =
                            ("Where is your savior? How long can you hold out against my attacks?"
                            );
                        Eranikus->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);

                        // Some guards running here for help (summoning or existed guards?)
                        for (int i = 0; i < NPC_MOONGLADE_WARDENS_COUNT; i++)
                        {
                            float collision = (float)urand(4, 8); // 4-8 yards, just for visual
                            uint32 r = urand(0, 1) ? 1 : 0; // seems like only left and right sides
                            if (Creature* warden = me->SummonCreature(NPC_MOONGLADE_WARDEN, phantasms_spawnpos[r][0]+collision, phantasms_spawnpos[r][1]+collision, phantasms_spawnpos[r][2], phantasms_spawnpos[r][3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60*IN_MILLISECONDS))
                            {
                                if (pPlayer->isInCombat() && pPlayer->getAttackerForHelper())
                                {
                                    warden->Attack(pPlayer->getAttackerForHelper(), true);
                                    break;
                                } else
                                    warden->GetMotionMaster()->MoveCharge(remulos_WP[15][1]+collision, remulos_WP[15][2]+collision, remulos_WP[15][3], 20.0f);
                            }
                        }

                        me->GetMotionMaster()->MoveFollow(pPlayer, 5.0f, PET_FOLLOW_ANGLE);

                        uiPhase++;
                        uiEvent_Timer = 1000;
                        break;
                    }
                // still fighting
                case 13:
                    {						sLog->outError("Phase %d ****************************************************",uiPhase);

                        // waiting until all phantasms got killed
                        if (uiCountDeadNightmares == NPC_NIGHTMARE_PHANTASMS_COUNT)
                        {
                            SetCanAttack(false); bCanFight = false;
                            SetEscortPaused(false); // Continue move
                            uiPhase++;

                            std::string sText =
                                ("Defeated my minions? Then face me, mortals!"
                                );
                            Eranikus->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);
                            // CAST_AI is impossible here, so use existed virtual functions
                            Eranikus->AI()->DoAction(1);
							sLog->outError("avanrt spawn ****************************************************");
                            // A LOT OF guards helping here with their rifles (they should run from the whole city)
                            for (int i = 0; i < NPC_MOONGLADE_WARDENS_COUNT*2; i++)
                            {
                                float collision = (float)urand(5, 20);
                                uint32 r = urand(0, 5);
                                if (Creature* warden = me->SummonCreature(NPC_MOONGLADE_WARDEN, phantasms_spawnpos[r][0]+collision, phantasms_spawnpos[r][1]+collision, phantasms_spawnpos[r][2], phantasms_spawnpos[r][3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60*IN_MILLISECONDS))
                                    warden->Attack(Eranikus, false);
                            }
                        }
                        uiEvent_Timer = 3000;
                        break;
                    }
                // fighting with Eranikus
                case 14:
					{
						sLog->outError("Phase %d ****************************************************",uiPhase);

                    uiEvent_Timer = 6000000; // nothing to do
                    break;
					}
                default: break;
                }
            } else uiEvent_Timer -= diff;
            
            if (uiCheckPlayer_Timer <= diff)
            {
                CheckPlayer();
                if (bCanFight && !me->isInCombat())
                {
                    Player* pPlayer = GetPlayerForEscort();
                    if (pPlayer)
                    {
                        if (pPlayer->isInCombat() && pPlayer->getVictim())
                        {
                            if (pPlayer->getVictim()->IsHostileTo(me))
                                AttackStart(pPlayer->getVictim());
                        }
                        else  
                            me->GetMotionMaster()->MoveFollow(pPlayer, 5.0f, PET_FOLLOW_ANGLE);
                    }
                    uiCheckPlayer_Timer = 3000;
                } else
                    uiCheckPlayer_Timer = 5000;
            } else uiCheckPlayer_Timer -= diff;

            if (bCanFight)
            {
                if (uiStarfire_timer <= diff)
                {
                    DoCast(me->getVictim(), spell_Starfire);
                    uiStarfire_timer = urand(7*IN_MILLISECONDS, 10*IN_MILLISECONDS);
                } else uiStarfire_timer -= diff;
                DoMeleeAttackIfReady();
            }
        }

        // it will be good if we get no call of it
        void EnterEvadeMode()
        {
            Player* pPlayer = GetPlayerForEscort();
            if (pPlayer)
            {
                if (pPlayer->isInCombat() && pPlayer->getVictim())
                {
                    if (pPlayer->getVictim()->IsHostileTo(me))
                        AttackStart(pPlayer->getVictim());
                    return;
                } else
                {
                    // follow player
                    me->GetMotionMaster()->MoveFollow(pPlayer, 10.0f, PET_FOLLOW_ANGLE);
                    return;
                }    
            }
            npc_escortAI::EnterEvadeMode();
        }

        void Increment()
        {
            //sLog.outError("uiCountDeadNightmares %u", uiCountDeadNightmares);
            uiCountDeadNightmares++;
        }

        // yeah, event ends successfully
        void HappyEnd()
        {
            if (Player* pPlayer = GetPlayerForEscort())
                pPlayer->GroupEventHappens(QUEST_NIGHTMARE_MANIFESTS, me);
        }
    };
 
    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_remulosAI(pCreature);
    }
};

// lazy to do it uppercase
#define spell_Shadow_Bolt_Volley  17228 
#define spell_Swell_of_Souls      21307
#define spell_Aura_of_Fear        26641
// they also have some emotion - skipped

class npc_nightmare_phantasm : public CreatureScript
{
public:
    npc_nightmare_phantasm() : CreatureScript("npc_nightmare_phantasm") { }

    struct npc_nightmare_phantasmAI : public ScriptedAI
    {
    public:
        npc_nightmare_phantasmAI(Creature *c) : ScriptedAI(c) {}

        uint32 uiTimer_SBV; // spell_Shadow_Bolt_Volley timer
        uint32 uiTimer_die; // if by some reason isn't dead (they like to run somewhere). Also on offy you shouldn't kill all of them
        Creature* Remulos;

        void Reset()
        {
            uiTimer_SBV = urand(7*IN_MILLISECONDS, 12*IN_MILLISECONDS); // suggested by quest video, real time is unknown
            DoCast(me, spell_Aura_of_Fear);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FEAR, true); // without this they affected by aura of fear
            Remulos = NULL;
            uiTimer_die = 120*IN_MILLISECONDS;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
            {
                FindVictim();
                // stuck
                if (uiTimer_die <= diff)
                {
                    me->Kill(me); // JustDied will be called
                    //uiTimer_die = 15*IN_MILLISECONDS;
                } else uiTimer_die -= diff;
                return;
            }
            
            if (uiTimer_SBV <= diff)
            {
                DoCast(me->getVictim(), spell_Shadow_Bolt_Volley);
                uiTimer_SBV = urand(7*IN_MILLISECONDS, 12*IN_MILLISECONDS);
            } else uiTimer_SBV -= diff;

            DoMeleeAttackIfReady();
        }

        // only player?
        void KilledUnit(Unit * /*victim*/)
        {
            DoCast(me, spell_Swell_of_Souls, true);
        }

        void JustDied(Unit * /*victim*/)
        {
            if (Remulos)
                CAST_AI(npc_remulos::npc_remulosAI, Remulos->AI())->Increment();
            // happens when Remulos is too far or when Reset() called from evade?
            else
                if (Creature* r = me->FindNearestCreature(NPC_REMULOS, 1000.0f))
                    CAST_AI(npc_remulos::npc_remulosAI, r->AI())->Increment();
        }

        void JustSummoned(Creature *pSummoner)
        {
            Remulos = pSummoner;

            //me->GetMotionMaster()->MoveCharge(remulos_WP[15][1], remulos_WP[15][2], remulos_WP[15][3], 20.0f);
            FindVictim();

            // DoZoneInCombat(); - it's selects summoners enemy - our friend
        }

        void FindVictim()
        {
            if (Unit *pUnit = me->SelectNearestTarget(80.0f))
            {
                me->GetMotionMaster()->MoveChase(pUnit);
                AttackStart(pUnit);
            }
            // Main target - Remulos
            else if (Remulos)
            {
                me->GetMotionMaster()->MoveChase(Remulos);
                AttackStart(Remulos);
            }
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_nightmare_phantasmAI(pCreature);
    }
};

#define spell_Acid_Breath          24839
#define spell_Noxious_Breath       24818
#define spell_Shadow_Bolt_Volley2  25586

class npc_eranikus : public CreatureScript
{
public:
    npc_eranikus() : CreatureScript("npc_eranikus") { }

    struct npc_eranikusAI : public ScriptedAI
    {
    public:
        npc_eranikusAI(Creature *c) : ScriptedAI(c) {}

        uint32 uiTimer_SBV; // spell_Shadow_Bolt_Volley timer
        uint32 uiTimer_breath_acid;
        uint32 uiTimer_breath_nox;
        uint32 uiTimer_event;
        uint32 uiPhase;
        bool bFightTime;

        void Reset()
        {
            // real timers are unknown
            uiTimer_SBV = urand(5*IN_MILLISECONDS, 12*IN_MILLISECONDS);
            uiTimer_breath_acid = urand(7*IN_MILLISECONDS, 14*IN_MILLISECONDS);
            uiTimer_breath_nox = urand(20*IN_MILLISECONDS, 30*IN_MILLISECONDS);
            uiTimer_event = 10000; // don't trigger at summon
            uiPhase = 0;
            bFightTime = false;

            me->SetFlying(true);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_PASSIVE);
        }

        void UpdateAI(const uint32 diff)
        {
            // observer phase
            if (!bFightTime)
                return;

            if (!UpdateVictim() && uiPhase < 7)
            {
                FindVictim();
                return;
            }
            
            if (uiTimer_SBV <= diff)
            {
                DoCast(me->getVictim(), spell_Shadow_Bolt_Volley2);
                uiTimer_SBV = urand(7*IN_MILLISECONDS, 12*IN_MILLISECONDS);
            } else uiTimer_SBV -= diff;

            if (uiTimer_breath_acid <= diff)
            {
                DoCast(me->getVictim(), spell_Acid_Breath);
                uiTimer_breath_acid = urand(7*IN_MILLISECONDS, 14*IN_MILLISECONDS);
            } else uiTimer_breath_acid -= diff;

            if (uiTimer_breath_nox <= diff)
            {
                DoCast(me->getVictim(), spell_Noxious_Breath);
                uiTimer_breath_nox = urand(20*IN_MILLISECONDS, 30*IN_MILLISECONDS);
            } else uiTimer_breath_nox -= diff;

            if (uiTimer_event <= diff)
            {
                // seems like timer, it's near 80%
                switch (uiPhase)
                {
                case 0:
                    if (HealthBelowPct(80))
                    {
                        std::string sText =
                            ("Remulos, look how easy they fall before me? You can stop this, fool. Turn the druid over to me and it will all be over..."
                            );
                        me->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);

                        // "She spawns in Moonglade as a part of the Ahn'Qiraj scepter chain. You have to hold Eranikus off for some time until she comes to help."
                        // so don't matter where she should be spawned
                        if (Creature* Remulos = me->FindNearestCreature(NPC_REMULOS, 1000.0f))
                        {
                            float x = 7945.326172f;
                            float y = -2579.838135f;
                            float z = 489.947205f;
                            if (Creature* tyrande = Remulos->SummonCreature(NPC_TYRANDE, x, y, z, 2.673891f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60*IN_MILLISECONDS))
                            {
								tyrande->SetVisible(0);
                                std::string sText2 =
                                    ("Grant us serenity! Watch over our fallen..."
                                    );
                                tyrande->MonsterYell(sText2.c_str(), LANG_UNIVERSAL, 0);
                            }
                        }
                        uiPhase++;
                    }
                    uiTimer_event = 3000;
                    break;
                // next phrases - timer is unknown, using health %
                case 1:
                    if (HealthBelowPct(70))
                    {
                        if (Creature* tyrande = me->FindNearestCreature(NPC_TYRANDE, 100.0f))
                        {
                            std::string sText =
                                ("Seek absolution, Eranikus. All will be forgiven.."
                                );
                            tyrande->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);
                        }
                        uiPhase++;
                    }
                    uiTimer_event = 3000;
                    break;
                case 2:
                    if (HealthBelowPct(60))
                    {
                        if (Creature* tyrande = me->FindNearestCreature(NPC_TYRANDE, 100.0f))
                        {
                            std::string sText =
                                ("You will be forgiven, Eranikus. Elune will always love you. Break free of the bonds that command you!"
                                );
                            tyrande->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);
                        }
                        uiPhase++;
                    }
                    uiTimer_event = 3000;
                    break;
                case 3:
                    if (HealthBelowPct(40))
                    {
                        if (Creature* tyrande = me->FindNearestCreature(NPC_TYRANDE, 100.0f))
                        {
                            std::string sText =
                                ("The grasp of the Old Gods is unmoving. He is consumed by their dark thoughts... I... I... I cannot... cannot channel much longer... Elune aide me."
                                );
                            tyrande->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);
                        }
                        uiPhase++;
                    }
                    uiTimer_event = 3000;
                    break;
                case 4:
                    if (HealthBelowPct(25))
                    {
                        std::string sText =
                            ("IT BURNS! THE PAIN.. SEARING..."
                            );
                        me->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiPhase++;
                    }
                    uiTimer_event = 3000;
                    break;
                case 5:
                    if (HealthBelowPct(22))
                    {
                        std::string sText =
                            ("WHY? Why did this happen to... to me? Where were you Tyrande? Where were you when I fell from the grace of Elune?"
                            );
                        me->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiPhase++;
                    }
                    uiTimer_event = 3000;
                    break;
                case 6:
                    // there is should be timer condition - can't see it on videos (Eranikus fake death after 20%)
                    if (HealthBelowPct(20))
                    {
                        std::string sText =
                            ("I... I feel... I feel the touch of Elune upon my being once more... She smiles upon me... Yes... I..."
                            );
                        me->MonsterYell(sText.c_str(), LANG_UNIVERSAL, 0);

                        for (std::set<Unit*>::const_iterator i = me->getAttackers().begin(); i != me->getAttackers().end(); ++i)
                            if ((*i))
                            {
                                (*i)->RemoveAura(spell_Acid_Breath);
                                (*i)->RemoveAura(spell_Noxious_Breath);
                            }
                        me->SetReactState(REACT_PASSIVE);
                        me->GetMotionMaster()->Clear();
                        me->RemoveAllAuras();
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        me->DeleteThreatList();
                        me->InterruptNonMeleeSpells(true);
                        me->CombatStop(true);
                        me->setFaction(35);

                        // Tyrande and priestess should appear and moving to center
                        // priestess are not implemented
                        if (Creature* tyrande = me->FindNearestCreature(NPC_TYRANDE, 300.0f))
                        {
                            tyrande->SetVisible(1);
                            tyrande->GetMotionMaster()->MoveCharge(7873.132324f, -2567.422363f, 486.946442f, 20.0f);
                        }

                        uiTimer_event = 10000;
                        uiPhase++;
                    } else
                        uiTimer_event = 3000;
                    break;
                case 7:
                    {
                        //me->setDeathState(JUST_DIED); don't use it

                        me->SetUInt64Value(UNIT_FIELD_TARGET, 0); // clear target
                        me->SetStandState(UNIT_STAND_STATE_DEAD);

                        std::string sText2 =
                            ("Eranikus, Tyrant of the Dream is wholly consumed by the Light of Elune. Tranquility sets in over the Moonglade."
                            );
                        // not server-wide emote in 3.3.5
                        me->MonsterYell(sText2.c_str(), LANG_UNIVERSAL, 0); 
						
                        uiTimer_event = 3000;
                        uiPhase++;
                        break;
                    }
                case 8:
                    {
                    // Tyrande and her group should be in center now
                    if (Creature* tyrande = me->FindNearestCreature(NPC_TYRANDE, 300.0f))
                    {
                        tyrande->SetFacingToObject(me);                                     

                        std::string sText =
                            ("Tyrande falls to one knee."
                            );
                        tyrande->MonsterTextEmote(sText.c_str(), 0);

                        std::string sText2 =
                            ("Praise be to Elune... Eranikus is redeemed."
                            );
                        tyrande->MonsterYell(sText2.c_str(), LANG_UNIVERSAL, 0);
                    }

                    uiTimer_event = 5000;
                    uiPhase++;
                    break;
                    }
                case 9:
                    {
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->UpdateEntry(15628); // Eranikus the Redeemed
                    // model changed in script, even on offy
                    me->SetDisplayId(16783); // wrong

                    std::string sText =
                        ("For so long, I was lost... The Nightmare's corruption had consumed me... And now, you... all of you.. you have saved me. Released me from its grasp."
                        );
                    me->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);

                    uiTimer_event = 8000;
                    uiPhase++;
                    break;
                    }
                case 10:
                    {
                        std::string sText =
                            ("But... Malfurion, Cenarius, Ysera... They still fight. They need me. I must return to the Dream at once."
                            );
                        me->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiTimer_event = 5000;
                        uiPhase++;
                        break;
                    }
                case 11:
                    {
                        std::string sText =
                            ("My lady, I am unworthy of your prayer. Truly, you are an angel of light. Please, assist me in returning to the barrow den so that I may return to the Dream. I like Malfurion, also have a love awaiting me... I must return to her... to protect her..."
                            );
                        me->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiTimer_event = 10000;
                        uiPhase++;
                        break;
                    }
                case 12:
                    {
                        std::string sText =
                            ("And heroes... I hold that which you seek. May it once more see the evil dissolved. Remulos, see to it that our champion receives the shard of the Green Flight."
                            );
                        me->MonsterSay(sText.c_str(), LANG_UNIVERSAL, 0);

                        uiTimer_event = 8000;
                        uiPhase++;
                        break;
                    }
                case 13:
                    {
                        // Eranikus and Tyrande should disappear in previos phase
                        if (Creature* Remulos = me->FindNearestCreature(NPC_REMULOS, 1000.0f))
                        {
                            std::string sText2 =
                                ("It will be done, Eranikus. Be well, ancient one."
                                );
                            Remulos->MonsterSay(sText2.c_str(), LANG_UNIVERSAL, 0);

                            CAST_AI(npc_remulos::npc_remulosAI, Remulos->AI())->HappyEnd();
                            Remulos->DisappearAndDie(); // quest won't be failed because of check in FailQuestForRaid()
                        }

                        if (Creature* tyrande = me->FindNearestCreature(NPC_TYRANDE, 100.0f))
                            tyrande->DisappearAndDie();

                        me->DisappearAndDie();

                        // THE END!
                        uiTimer_event = 120000;
                        uiPhase++;
                        break;
                    }
                default: uiTimer_event = 3000; break;
                } // switch end
            } else uiTimer_event -= diff;

            DoMeleeAttackIfReady();
        }

        void FindVictim()
        {
            if (Unit *pUnit = me->SelectNearestTarget(50.0f))
                AttackStart(pUnit);
            else if (Creature* r = me->FindNearestCreature(NPC_REMULOS, 1000.0f))
                AttackStart(r);
        }

        // not possible now, need more info from official server
        void JustDied(Unit * /*victim*/)
        {
            // Death = quest fail
            if (Creature* r = me->FindNearestCreature(NPC_REMULOS, 1000.0f))
                CAST_AI(npc_remulos::npc_remulosAI, r->AI())->CheckPlayer(true);
        }

        void DoAction(const int32 param)
        {
            if (param && !bFightTime)
                SetFightPhase();
        }

        void SetFightPhase()
        {
            float ground = me->GetMap()->GetHeight(me->GetPositionX(), me->GetPositionY(), MAX_HEIGHT, true);
            me->GetMotionMaster()->MoveFall(ground+2.0f); // SetFlying(false); also here.
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_AGGRESSIVE);
            bFightTime = true;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_eranikusAI(pCreature);
    }
};void AddSC_moonglade()
{
    new npc_bunthen_plainswind();
    new npc_great_bear_spirit();
    new npc_silva_filnaveth();
    new npc_clintar_dreamwalker();
    new npc_clintar_spirit();
	new npc_remulos(); 
    new npc_nightmare_phantasm(); 
    new npc_eranikus(); 

}
