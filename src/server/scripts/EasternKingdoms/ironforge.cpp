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
SDName: Ironforge
SD%Complete: 100
SDComment: Quest support: 3702
SDCategory: Ironforge
EndScriptData */

/* ContentData
npc_royal_historian_archesonus
EndContentData */

#include "ScriptPCH.h"

/*######
## npc_royal_historian_archesonus
######*/

#define GOSSIP_ITEM_ROYAL   "I am ready to listen"
#define GOSSIP_ITEM_ROYAL_1 "That is tragic. How did this happen?"
#define GOSSIP_ITEM_ROYAL_2 "Interesting, continue please."
#define GOSSIP_ITEM_ROYAL_3 "Unbelievable! How dare they??"
#define GOSSIP_ITEM_ROYAL_4 "Of course I will help!"

class npc_royal_historian_archesonus : public CreatureScript
{
public:
    npc_royal_historian_archesonus() : CreatureScript("npc_royal_historian_archesonus") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ROYAL_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(2236, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ROYAL_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->SEND_GOSSIP_MENU(2237, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ROYAL_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->SEND_GOSSIP_MENU(2238, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ROYAL_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                player->SEND_GOSSIP_MENU(2239, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                player->CLOSE_GOSSIP_MENU();
                player->AreaExploredOrEventHappens(3702);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(3702) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ROYAL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
            player->SEND_GOSSIP_MENU(2235, creature->GetGUID());
        }
        else
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

};

/*######
## boss_king_magni_bronzebeard
######*/

static Position IronforgeGuard[] =
{
{-4869.67f, -1037.57f, 502.30f, 0.347319f},
{-4860.41f, -1051.07f, 502.30f, 1.490071f},
{-4844.45f, -1048.32f, 502.30f, 2.299032f},
{-4840.58f, -1033.14f, 502.30f, 3.265075f},
{-4850.67f, -1018.92f, 502.30f, 4.482435f},
{-4865.12f, -1024.41f, 505.90f, 5.428836f}
};

enum eMagni
{
    SPELL_AVATAR = 19135,
    SPELL_KNOCK_AWAY = 20686,
    SPELL_STORM_BOLT = 20685,
    SPELL_CHARGE = 20508,
    SPELL_LAY_ON_HANDS = 633,

    ENTRY_IRONFORGE_GUARD = 5595,

    SAY_AGGRO = 1
};

class boss_king_magni_bronzebeard : public CreatureScript
{
public:
    boss_king_magni_bronzebeard() : CreatureScript("boss_king_magni_bronzebeard") {}

    struct boss_king_magni_bronzebeardAI : public ScriptedAI
    {
        boss_king_magni_bronzebeardAI(Creature* pCreature) : ScriptedAI(pCreature) , summons(me) {}

        void Reset()
        {
            summons.DespawnAll();

            _avatarTimer = 15 *IN_MILLISECONDS;
            _knockawayTimer = 15 *IN_MILLISECONDS;
            _stormboltTimer = urand(5, 7) *IN_MILLISECONDS;
            _chargeTimer = urand(13, 17) *IN_MILLISECONDS;
            _summonTimer = urand(20, 40) *IN_MILLISECONDS;
            _layonhandsTimer = 5 *MINUTE;
        }
        
        void JustSummoned(Creature* pSummoned)
        {
            summons.Summon(pSummoned);
        }

        void JustDied (Unit* /*victim*/)
        {
            summons.DespawnAll();
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
        }
        
        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (_stormboltTimer <= diff)
            {
                Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1);
                if (target)
                {
                    DoCast(target, SPELL_STORM_BOLT);
                    _stormboltTimer = urand(7, 9) *IN_MILLISECONDS;
                }
            }
            else
                _stormboltTimer -= diff;

            if (_avatarTimer <= diff)
            {
                DoCast(me, SPELL_AVATAR);
                _avatarTimer = 45 *IN_MILLISECONDS;
            }
            else
                _avatarTimer -= diff;

            if (_knockawayTimer <= diff)
            {
                DoResetThreat(); // Threat Reset
                DoCastVictim(SPELL_KNOCK_AWAY);
                _knockawayTimer = 15 *IN_MILLISECONDS;
            }
            else
                _knockawayTimer -= diff;

            if (_chargeTimer <= diff)
            {
                Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 25.0f);
                if (target)
                {
                    DoCast(target, SPELL_CHARGE);
                    _chargeTimer = 15 *IN_MILLISECONDS;
                }
            }
            else
                _chargeTimer -= diff;

            if (_summonTimer <= diff)
            {
                for (uint8 i = 0; i < 6; ++i)
                    me->SummonCreature(ENTRY_IRONFORGE_GUARD, IronforgeGuard[i], TEMPSUMMON_CORPSE_DESPAWN , 0);
                    _summonTimer = urand(20, 40) *IN_MILLISECONDS;
            }
            else
                _summonTimer -= diff;

            if (_layonhandsTimer <= diff)
            {
                DoCast(me, SPELL_LAY_ON_HANDS);
                _layonhandsTimer = 5 *MINUTE;
            }
            else
                _layonhandsTimer -=diff;

            DoMeleeAttackIfReady();
        }
    
    private:
        SummonList summons;
		uint32 _avatarTimer;
        uint32 _knockawayTimer;
        uint32 _stormboltTimer;
		uint32 _chargeTimer;
		uint32 _summonTimer;
		uint32 _layonhandsTimer;
    };
    
    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_king_magni_bronzebeardAI (pCreature);
    }
};
void AddSC_ironforge()
{
    new npc_royal_historian_archesonus();
	new boss_king_magni_bronzebeard();
}
