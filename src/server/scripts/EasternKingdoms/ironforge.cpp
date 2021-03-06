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

enum Magni
{
    SPELL_AVATAR            = 19135,
    SPELL_KNOCK_AWAY        = 20686,
    SPELL_STORM_BOLT        = 20685,
    SPELL_CHARGE            = 20508,	
    SPELL_LAY_ON_HANDS      = 633,  // may the wrong spell - but works fine in this case

    ENTRY_IRONFORGE_GUARD   = 5595,

    SAY_AGGRO               = 1
};

class boss_king_magni_bronzebeard : public CreatureScript
{
public:
    boss_king_magni_bronzebeard() : CreatureScript("boss_king_magni_bronzebeard") {}

    struct boss_king_magni_bronzebeardAI : public ScriptedAI
    {
        boss_king_magni_bronzebeardAI(Creature* creature) : ScriptedAI(creature) , summons(me) {}

        void Reset()
        {
            summons.DespawnAll();

            _avatarTimer = 15 *IN_MILLISECONDS;
            _knockawayTimer = 15 *IN_MILLISECONDS;
            _stormboltTimer = urand(5, 7) *IN_MILLISECONDS;
            _chargeTimer = urand(13, 17) *IN_MILLISECONDS;
            _summonTimer = urand(20, 40) *IN_MILLISECONDS;
            _layonhandsTimer = 5*IN_MILLISECONDS*MINUTE;
        }

        void JustSummoned(Creature* summoned)
        {
            summons.Summon(summoned);
        }

        void JustDied (Unit* /*victim*/)
        {
            summons.DespawnAll();
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
        }

        void UpdateAI(uint32 const diff)
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
                DoResetThreat();									// Threat Reset
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
        uint32	_avatarTimer;
        uint32	_knockawayTimer;
        uint32	_stormboltTimer;
        uint32	_chargeTimer;
        uint32	_summonTimer;
        uint32	_layonhandsTimer;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_king_magni_bronzebeardAI(creature);
    }
};

/*######
## npc_gnome_citizen
## spell_motivate_a_tron
######*/

enum Spells
{
    SPELL_CITIZEN_AURA                  = 74034,
    SPELL_PETACT_AURA                   = 74071,
    SPELL_QUEST_CREDIT                  = 73960,

    SPELL_MOTIVATE_1                    = 73943,
    SPELL_MOTIVATE_2                    = 74080,

    SPELL_TURNIN                        = 75078,
    SPELL_AOE_TURNIN                    = 73955,
};

enum Creatures
{
    NPC_SPARKNOZZLE                     = 39675,

    NPC_CITIZEN_1                       = 39253,
    NPC_CITIZEN_2                       = 39623,

    NPC_MOTIVATED_CITIZEN_1             = 39466,
    NPC_MOTIVATED_CITIZEN_2             = 39624,
};

enum Points
{
    POINT_SPARKNOZZLE                   = 4026500,
};

enum Texts
{
    SAY_CITIZEN_START                   = 0,
    SAY_CITIZEN_END                     = 1,
};

class npc_gnome_citizen : public CreatureScript
{
    public:
        npc_gnome_citizen() : CreatureScript("npc_gnome_citizen") { }

        struct npc_gnome_citizenAI : public ScriptedAI
        {
            npc_gnome_citizenAI(Creature* creature) : ScriptedAI(creature)
            {
                Reset();
                Player* player = me->GetOwner()->ToPlayer();

                switch (urand(1, 4))
                {
                    case 1:
                        _mountModel = 6569;
                        break;
                    case 2:
                        _mountModel = 9473;
                        break;
                    case 3:
                        _mountModel = 9474;
                        break;
                    case 4:
                        _mountModel = 9475;
                        break;
                }
                if (player)
                    me->GetMotionMaster()->MoveFollow(player, 5.0f, float(rand_norm() + 1.0f) * M_PI / 3.0f * 4.0f);
            }

            void Reset()
            {
                _complete = false;
                me->AddAura(SPELL_CITIZEN_AURA, me);
                DoCast(me, SPELL_PETACT_AURA);
                me->SetReactState(REACT_PASSIVE);
                Talk(SAY_CITIZEN_START);
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE)
                    return;
                if (id == POINT_SPARKNOZZLE)
                    me->DespawnOrUnsummon();
            }

            void SpellHit(Unit* caster, SpellEntry const* spell)
            {
                if (spell->Id == SPELL_AOE_TURNIN && caster->GetEntry() == NPC_SPARKNOZZLE && !_complete)
                {
                    _complete = true;    // Preventing from giving credit twice
                    DoCast(me, SPELL_TURNIN);
                    DoCast(me, SPELL_QUEST_CREDIT);
                    Talk(SAY_CITIZEN_END);
                    me->GetMotionMaster()->MovePoint(POINT_SPARKNOZZLE, caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ());
                }
            }

            void UpdateAI(const uint32 diff)
            {
                Unit* owner = me->GetOwner();

                if (!owner)
                    return;

                if (owner->IsMounted() && !me->IsMounted())
                    me->Mount(_mountModel);
                else if (!owner->IsMounted() && me->IsMounted())
                    me->Dismount();

                me->SetSpeed(MOVE_RUN, owner->GetSpeedRate(MOVE_RUN));
                me->SetSpeed(MOVE_WALK, owner->GetSpeedRate(MOVE_WALK));
            }

        private:
            uint32 _mountModel;
            bool _complete;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_gnome_citizenAI(creature);
        }
};

class spell_motivate_a_tron : public SpellScriptLoader
{
    public:
        spell_motivate_a_tron() : SpellScriptLoader("spell_motivate_a_tron") {}

        class spell_motivate_a_tron_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_motivate_a_tron_SpellScript)
            bool Validate(SpellEntry const* /*spellEntry*/)
            {
                if (!sSpellStore.LookupEntry(SPELL_MOTIVATE_1))
                    return false;
                if (!sSpellStore.LookupEntry(SPELL_MOTIVATE_2))
                    return false;
               return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    uint32 motivate = 0;
                    if (target->GetEntry() == NPC_CITIZEN_1)
                        motivate = SPELL_MOTIVATE_1;
                    else if (target->GetEntry() == NPC_CITIZEN_2)
                        motivate = SPELL_MOTIVATE_2;
                    if (motivate)
                        caster->CastSpell(target, motivate, true, NULL, NULL, caster->GetGUID());
                }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_motivate_a_tron_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_motivate_a_tron_SpellScript();
        }
};


void AddSC_ironforge()
{
    new npc_royal_historian_archesonus();
    new boss_king_magni_bronzebeard();
	new npc_gnome_citizen();
    new spell_motivate_a_tron();

}
