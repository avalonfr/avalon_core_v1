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
SDName: Icecrown
SD%Complete: 100
SDComment: Quest support: 12807
SDCategory: Icecrown
EndScriptData */

/* ContentData
npc_arete
EndContentData */

#include "ScriptPCH.h"

/*######
## npc_arete
######*/

#define GOSSIP_ARETE_ITEM1 "Lord-Commander, I would hear your tale."
#define GOSSIP_ARETE_ITEM2 "<You nod slightly but do not complete the motion as the Lord-Commander narrows his eyes before he continues.>"
#define GOSSIP_ARETE_ITEM3 "I thought that they now called themselves the Scarlet Onslaught?"
#define GOSSIP_ARETE_ITEM4 "Where did the grand admiral go?"
#define GOSSIP_ARETE_ITEM5 "That's fine. When do I start?"
#define GOSSIP_ARETE_ITEM6 "Let's finish this!"
#define GOSSIP_ARETE_ITEM7 "That's quite a tale, Lord-Commander."

enum eArete
{
    GOSSIP_TEXTID_ARETE1        = 13525,
    GOSSIP_TEXTID_ARETE2        = 13526,
    GOSSIP_TEXTID_ARETE3        = 13527,
    GOSSIP_TEXTID_ARETE4        = 13528,
    GOSSIP_TEXTID_ARETE5        = 13529,
    GOSSIP_TEXTID_ARETE6        = 13530,
    GOSSIP_TEXTID_ARETE7        = 13531,

    QUEST_THE_STORY_THUS_FAR    = 12807
};

class npc_arete : public CreatureScript
{
public:
    npc_arete() : CreatureScript("npc_arete") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_THE_STORY_THUS_FAR) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE1, creature->GetGUID());
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
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE2, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE3, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE4, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE5, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE6, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+6:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE7, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+7:
                player->CLOSE_GOSSIP_MENU();
                player->AreaExploredOrEventHappens(QUEST_THE_STORY_THUS_FAR);
                break;
        }

        return true;
    }
};

/*######
## npc_dame_evniki_kapsalis
######*/

enum eDameEnvikiKapsalis
{
    TITLE_CRUSADER    = 123
};

class npc_dame_evniki_kapsalis : public CreatureScript
{
public:
    npc_dame_evniki_kapsalis() : CreatureScript("npc_dame_evniki_kapsalis") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->HasTitle(TITLE_CRUSADER))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());
        return true;
    }
};

/*######
## npc_squire_david
######*/

enum eSquireDavid
{
    QUEST_THE_ASPIRANT_S_CHALLENGE_H                    = 13680,
    QUEST_THE_ASPIRANT_S_CHALLENGE_A                    = 13679,

    NPC_ARGENT_VALIANT                                  = 33448,

    GOSSIP_TEXTID_SQUIRE                                = 14407
};

#define GOSSIP_SQUIRE_ITEM_1 "I am ready to fight!"
#define GOSSIP_SQUIRE_ITEM_2 "How do the Argent Crusader raiders fight?"

class npc_squire_david : public CreatureScript
{
public:
    npc_squire_david() : CreatureScript("npc_squire_david") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(QUEST_THE_ASPIRANT_S_CHALLENGE_H) == QUEST_STATUS_INCOMPLETE ||
            player->GetQuestStatus(QUEST_THE_ASPIRANT_S_CHALLENGE_A) == QUEST_STATUS_INCOMPLETE)//We need more info about it.
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_SQUIRE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->SummonCreature(NPC_ARGENT_VALIANT, 8575.451f, 952.472f, 547.554f, 0.38f);
        }
        return true;
    }
};

/*######
## npc_argent_valiant
######*/

enum eArgentValiant
{
    SPELL_CHARGE                = 63010,
    SPELL_SHIELD_BREAKER        = 65147,

    NPC_ARGENT_VALIANT_CREDIT   = 24108
};

class npc_argent_valiant : public CreatureScript
{
public:
    npc_argent_valiant() : CreatureScript("npc_argent_valiant") { }

    struct npc_argent_valiantAI : public ScriptedAI
    {
        npc_argent_valiantAI(Creature* creature) : ScriptedAI(creature)
        {
            creature->GetMotionMaster()->MovePoint(0, 8599.258f, 963.951f, 547.553f);
            creature->setFaction(35); //wrong faction in db?
        }

        uint32 uiChargeTimer;
        uint32 uiShieldBreakerTimer;

        void Reset()
        {
            uiChargeTimer = 7000;
            uiShieldBreakerTimer = 10000;
        }

        void MovementInform(uint32 uiType, uint32 /*uiId*/)
        {
            if (uiType != POINT_MOTION_TYPE)
                return;

            me->setFaction(14);
        }

        void DamageTaken(Unit* pDoneBy, uint32& uiDamage)
        {
            if (uiDamage > me->GetHealth() && pDoneBy->GetTypeId() == TYPEID_PLAYER)
            {
                uiDamage = 0;
                CAST_PLR(pDoneBy)->KilledMonsterCredit(NPC_ARGENT_VALIANT_CREDIT, 0);
                me->setFaction(35);
                me->DespawnOrUnsummon(5000);
                me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                EnterEvadeMode();
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (uiChargeTimer <= uiDiff)
            {
                DoCastVictim(SPELL_CHARGE);
                uiChargeTimer = 7000;
            } else uiChargeTimer -= uiDiff;

            if (uiShieldBreakerTimer <= uiDiff)
            {
                DoCastVictim(SPELL_SHIELD_BREAKER);
                uiShieldBreakerTimer = 10000;
            } else uiShieldBreakerTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_argent_valiantAI(creature);
    }
};

/*######
## npc_alorah_and_grimmin
######*/

enum ealorah_and_grimmin
{
    SPELL_CHAIN                     = 68341,
    NPC_FJOLA_LIGHTBANE             = 36065,
    NPC_EYDIS_DARKBANE              = 36066,
    NPC_PRIESTESS_ALORAH            = 36101,
    NPC_PRIEST_GRIMMIN              = 36102
};

class npc_alorah_and_grimmin : public CreatureScript
{
public:
    npc_alorah_and_grimmin() : CreatureScript("npc_alorah_and_grimmin") { }

    struct npc_alorah_and_grimminAI : public ScriptedAI
    {
        npc_alorah_and_grimminAI(Creature* creature) : ScriptedAI(creature) {}

        bool uiCast;

        void Reset()
        {
            uiCast = false;
        }

        void UpdateAI(const uint32 /*uiDiff*/)
        {
            if (uiCast)
                return;
            uiCast = true;
            Creature* target = NULL;

            switch (me->GetEntry())
            {
                case NPC_PRIESTESS_ALORAH:
                    target = me->FindNearestCreature(NPC_EYDIS_DARKBANE, 10.0f);
                    break;
                case NPC_PRIEST_GRIMMIN:
                    target = me->FindNearestCreature(NPC_FJOLA_LIGHTBANE, 10.0f);
                    break;
            }
            if (target)
                DoCast(target, SPELL_CHAIN);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_alorah_and_grimminAI(creature);
    }
};

/*######
## npc_guardian_pavilion
######*/

enum eGuardianPavilion
{
    SPELL_TRESPASSER_H                            = 63987,
    AREA_SUNREAVER_PAVILION                       = 4676,

    AREA_SILVER_COVENANT_PAVILION                 = 4677,
    SPELL_TRESPASSER_A                            = 63986,
};

class npc_guardian_pavilion : public CreatureScript
{
public:
    npc_guardian_pavilion() : CreatureScript("npc_guardian_pavilion") { }

    struct npc_guardian_pavilionAI : public Scripted_NoMovementAI
    {
        npc_guardian_pavilionAI(Creature* creature) : Scripted_NoMovementAI(creature) {}

        void MoveInLineOfSight(Unit* who)
        {
            if (me->GetAreaId() != AREA_SUNREAVER_PAVILION && me->GetAreaId() != AREA_SILVER_COVENANT_PAVILION)
                return;

            if (!who || who->GetTypeId() != TYPEID_PLAYER || !me->IsHostileTo(who) || !me->isInBackInMap(who, 5.0f))
                return;

            if (who->HasAura(SPELL_TRESPASSER_H) || who->HasAura(SPELL_TRESPASSER_A))
                return;

            if (who->ToPlayer()->GetTeamId() == TEAM_ALLIANCE)
                who->CastSpell(who, SPELL_TRESPASSER_H, true);
            else
                who->CastSpell(who, SPELL_TRESPASSER_A, true);

        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_guardian_pavilionAI(creature);
    }
};

/*######
## npc_webbed_crusader
######*/

enum eWebbedCrusaderSpells
{
    NPC_FORGOTTEN_DEEPS_AMBUSHER = 30204,
    NPC_FREED_CRUSADER = 30274,
    SPELL_FREED_CRUSADER = 56423
};
// UPDATE creature_template SET scriptname = 'npc_webbed_crusader' WHERE entry in (30273,30268);
class npc_webbed_crusader : public CreatureScript
{
public:
    npc_webbed_crusader() : CreatureScript("npc_webbed_crusader") { }

    struct npc_webbed_crusaderAI : public Scripted_NoMovementAI
    {
        npc_webbed_crusaderAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature) {}

        void JustDied(Unit* killer)
        {
            switch(urand(0,1))
            {
            case 0:
                {
                    Creature* temp = DoSpawnCreature(NPC_FREED_CRUSADER,0,0,0,0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,30000);
                    if(Player* pPlayer = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
                        pPlayer->KilledMonsterCredit(NPC_FREED_CRUSADER,temp->GetGUID());
                    //DoCast(me,SPELL_FREED_CRUSADER,true);
                }
                break;
            case 1:
                {
                    if(Creature* temp = DoSpawnCreature(NPC_FORGOTTEN_DEEPS_AMBUSHER,0,0,0,0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,30000))
                    {
                        temp->CastSpell(temp,56418,true);
                        temp->SetStandState(UNIT_STAND_STATE_STAND);
                        temp->AI()->AttackStart(killer);
                    }
                }
                break;
            }
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_webbed_crusaderAI(creature);
    }
};

enum ArgentCannonSpells
{
    SPELL_ARGENT_CANNON_SHOOT = 57385,
    SPELL_ARGENT_CANNON_SHOOT_TRIGGER = 57387,
    SPELL_RECONING_BOMB = 57412,
    SPELL_RECONING_BOMB_TRIGGER = 57414
};

class spell_argent_cannon : public SpellScriptLoader
{
    public:
        spell_argent_cannon() : SpellScriptLoader("spell_argent_cannon") { }

        class spell_argent_cannon_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_argent_cannon_SpellScript);

            bool Validate(SpellEntry const* /*spellInfo*/)
            {
                if (!sSpellStore.LookupEntry(SPELL_ARGENT_CANNON_SHOOT_TRIGGER))
                    return false;
                if (!sSpellStore.LookupEntry(SPELL_RECONING_BOMB_TRIGGER))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex effIndex)
            {
                const WorldLocation* loc = GetTargetDest();

                switch(GetSpellInfo()->Id)
                {
                case SPELL_ARGENT_CANNON_SHOOT:
                    GetCaster()->CastSpell(loc->m_positionX,loc->m_positionY,loc->m_positionZ,SPELL_ARGENT_CANNON_SHOOT_TRIGGER , true);
                    break;
                case SPELL_RECONING_BOMB:
                    GetCaster()->CastSpell(loc->m_positionX,loc->m_positionY,loc->m_positionZ,SPELL_RECONING_BOMB_TRIGGER , true);
                    break;
                }

                PreventHitDefaultEffect(effIndex);
            }

            void Register()
            {
                //OnEffect += SpellEffectFn(spell_argent_cannon_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnEffectHitTarget += SpellEffectFn(spell_argent_cannon_SpellScript::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_argent_cannon_SpellScript();
        }
};




enum BlessedBannerSpells
{
    SPELL_BLESSING_OF_THE_CRUSADE = 58026,
    SPELL_CRUSADERS_SPIRE_VICTORY = 58084,
};

enum BlessedBannerSummondNPCs
{
    ENTRY_BLESSED_BANNER = 30891,

    ENTRY_CRUSADER_LORD_DALFORS = 31003,
    ENTRY_ARGENT_BATTLE_PRIEST = 30919,
    ENTRY_ARGENT_MASON = 30900,

    ENTRY_REANIMATED_CAPTAIN = 30986,
    ENTRY_SCOURGE_DRUDGE = 30984,
    ENTRY_HIDEOUS_PLAGEBRINGER = 30987,
    ENTRY_HALOF_THE_DEATHBRINGER = 30989,
};


const Position CrusaderPos[8] =
{
    {6418.31f, 423.00f, 511.2f, 5.945f}, // Banner

    {6424.50f, 420.72f, 511.0f, 5.689f}, // Dalfors
    {6421.05f, 423.37f, 511.0f, 5.579f}, // Priest 1
    {6423.25f, 425.95f, 511.0f, 5.579f}, // Priest 2
    {6417.59f, 419.28f, 511.0f, 5.579f}, // Priest 3

    {6418.36f, 439.71f, 511.28f, 3.757f}, // Matron 1
    {6406.75f, 475.36f, 511.27f, 2.928f}, // Matron 2
    {6386.99f, 440.60f, 511.28f, 2.601f} // Matron 3
};

const Position ScourgePos =
{
    6460.16f, 403.45f, 490.07f, 2.700f //Scourge Spawn
};

#define SAY_PRE_1 "BY THE LIGHT! Those damned monsters! Look at what they've done to our people!"
#define SAY_PRE_2 "Burn it down, boys. Burn it all down."
#define SAY_START "Let 'em come. They'll pay for what they've done!"
#define YELL_FINISHED "We've done it, lads! We've taken the pinnacle from the Scourge! Report to Father Gustav at once and tell him the good news! We're gonna get to buildin' and settin' up! Go!"

/*
-- SQL Changes Needed
UPDATE creature_template SET scriptname = 'npc_blessed_banner' WHERE entry = 30891;
UPDATE creature_template SET faction_A = 2068, faction_H = 2068 WHERE entry IN (30986,30984,30987,30989);
UPDATE creature_template SET faction_A = 2131, faction_H = 2131 WHERE entry IN (31003,30919,30900);
UPDATE creature_template SET faction_A = 35, faction_H = 35 WHERE entry IN (30891);

DELETE FROM event_scripts WHERE id = 20082;
INSERT INTO event_scripts VALUES
(20082,0,10,30891,600000,0,6418.31,423.00,511.2,5.945);

*/

// Script for Battle for Crusaders' Pinnacle Controller
class npc_blessed_banner : public CreatureScript
{
public:
    npc_blessed_banner() : CreatureScript("npc_blessed_banner") { }

    struct npc_blessed_bannerAI : public Scripted_NoMovementAI
    {
        npc_blessed_bannerAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature) , Summons(me)
        {
            EventStarted = false;
            EventFinished = false;
            PhaseCount = 0;
            uiSummon_Timer = 0;
            say_Timer = 0;
            says = 0;
            Summons.DespawnAll();
        }

        bool EventStarted;
        bool EventFinished;

        uint32 PhaseCount;
        uint32 uiSummon_Timer;
        uint32 say_Timer;
        uint32 says;

        SummonList Summons;

        uint64 guidHalof;

        void Reset()
        {
            std::list<Creature*> _banners;
            GetCreatureListWithEntryInGrid(_banners, me, ENTRY_BLESSED_BANNER, 100.0f);
            if (!_banners.empty())
                for (std::list<Creature*>::iterator iter = _banners.begin(); iter != _banners.end(); ++iter)
                {
                    if((*iter)->GetGUID() != me->GetGUID())
                    {
                        EventFinished = true;
                        me->DespawnOrUnsummon(0);
                        Summons.DespawnAll();
                        return;
                    }
                }
        }

        void MoveInLineOfSight(Unit *attacker)
        {
            return;
        }

        void JustSummoned(Creature* pSummoned)
        {
            Summons.Summon(pSummoned);
        }

        void JustDied(Unit *killer)
        {
            Summons.DespawnAll();
        }

        void UpdateAI(const uint32 diff)
        {
            if(EventFinished)
                return;

            if(!EventStarted)
            {
                Creature *tempsum;

                if(tempsum = DoSummon(ENTRY_CRUSADER_LORD_DALFORS,ScourgePos,600000,TEMPSUMMON_TIMED_DESPAWN))
                {
                    tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[1]);
                    tempsum->SetHomePosition(CrusaderPos[1]);
                }

                for(int i = 0; i < 3; i++)
                {
                    if(tempsum = DoSummon(ENTRY_ARGENT_MASON,ScourgePos,600000,TEMPSUMMON_TIMED_DESPAWN))
                    {
                        tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[5+i]);
                        tempsum->SetHomePosition(CrusaderPos[5+i]);
                    }
                }

                for(int i = 0; i < 3; i++)
                {
                    if(tempsum = DoSummon(ENTRY_ARGENT_BATTLE_PRIEST,ScourgePos,600000,TEMPSUMMON_TIMED_DESPAWN))
                    {
                        tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[2+i]);
                        tempsum->SetHomePosition(CrusaderPos[2+i]);
                    }
                }

                DoCast(SPELL_BLESSING_OF_THE_CRUSADE);
                uiSummon_Timer = 30000;
                EventStarted = true;
            }else
            {
                if(says < 3)
                    if(say_Timer <= diff)
                    {
                        switch(says)
                        {
                        case 0:
                            if(Creature* dalfors = GetClosestCreatureWithEntry(me,ENTRY_CRUSADER_LORD_DALFORS,100,true))
                                dalfors->MonsterSay(SAY_PRE_1, LANG_UNIVERSAL, NULL);
                            say_Timer = 10000;
                            break;
                        case 1:
                            if(Creature* dalfors = GetClosestCreatureWithEntry(me,ENTRY_CRUSADER_LORD_DALFORS,100,true))
                                dalfors->MonsterSay(SAY_PRE_2, LANG_UNIVERSAL, NULL);

                            say_Timer = 10000;
                            break;
                        case 2:
                            if(Creature* dalfors = GetClosestCreatureWithEntry(me,ENTRY_CRUSADER_LORD_DALFORS,100,true))
                                dalfors->MonsterSay(SAY_START, LANG_UNIVERSAL, NULL);

                            say_Timer = 10000;
                            break;
                        }
                        says++;
                        
                    }else say_Timer -= diff;


                if(uiSummon_Timer <= diff)
                {
                    if(PhaseCount == 9)
                    {
                        Creature *tempsum;

                        if(tempsum = DoSummon(ENTRY_SCOURGE_DRUDGE,ScourgePos,10000,TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                        {
                            tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[0].m_positionX - 10 + urand(0,10),CrusaderPos[0].m_positionY - 10 + urand(0,10),CrusaderPos[0].m_positionZ );
                            tempsum->SetHomePosition(CrusaderPos[0]);
                        }
                        if(tempsum = DoSummon(ENTRY_SCOURGE_DRUDGE,ScourgePos,10000,TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                        {
                            tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[0].m_positionX - 10 + urand(0,10),CrusaderPos[0].m_positionY - 10 + urand(0,10),CrusaderPos[0].m_positionZ );
                            tempsum->SetHomePosition(CrusaderPos[0]);
                        }
                        if(tempsum = DoSummon(ENTRY_HALOF_THE_DEATHBRINGER,ScourgePos,10000,TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                        {
                            guidHalof = tempsum->GetGUID();
                            tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[0]);
                            tempsum->SetHomePosition(CrusaderPos[0]);
                        }
                    }else
                    {
                        Creature *tempsum;

                        if(urand(0,1) == 0)
                        {
                            if(tempsum = DoSummon(ENTRY_HIDEOUS_PLAGEBRINGER,ScourgePos,10000,TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                            {
                                tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[0].m_positionX - 10 + urand(0,10),CrusaderPos[0].m_positionY - 10 + urand(0,10),CrusaderPos[0].m_positionZ );
                                tempsum->SetHomePosition(CrusaderPos[0]);
                            }
                            if(tempsum = DoSummon(ENTRY_HIDEOUS_PLAGEBRINGER,ScourgePos,10000,TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                            {
                                tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[0].m_positionX - 10 + urand(0,10),CrusaderPos[0].m_positionY - 10 + urand(0,10),CrusaderPos[0].m_positionZ );
                                tempsum->SetHomePosition(CrusaderPos[0]);
                            }
                            if(tempsum = DoSummon(ENTRY_SCOURGE_DRUDGE,ScourgePos,10000,TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                            {
                                tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[0].m_positionX - 10 + urand(0,10),CrusaderPos[0].m_positionY - 10 + urand(0,10),CrusaderPos[0].m_positionZ );
                                tempsum->SetHomePosition(CrusaderPos[0]);
                            }
                        }
                        else
                        {
                            if(tempsum = DoSummon(ENTRY_REANIMATED_CAPTAIN,ScourgePos,10000,TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                            {
                                tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[0].m_positionX - 10 + urand(0,10),CrusaderPos[0].m_positionY - 10 + urand(0,10),CrusaderPos[0].m_positionZ );
                                tempsum->SetHomePosition(CrusaderPos[0]);
                            }
                            if(tempsum = DoSummon(ENTRY_REANIMATED_CAPTAIN,ScourgePos,10000,TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                            {
                                tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[0].m_positionX - 10 + urand(0,10),CrusaderPos[0].m_positionY - 10 + urand(0,10),CrusaderPos[0].m_positionZ );
                                tempsum->SetHomePosition(CrusaderPos[0]);
                            }
                            if(tempsum = DoSummon(ENTRY_SCOURGE_DRUDGE,ScourgePos,10000,TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                            {
                                tempsum->GetMotionMaster()->MovePoint(0,CrusaderPos[0].m_positionX - 10 + urand(0,10),CrusaderPos[0].m_positionY - 10 + urand(0,10),CrusaderPos[0].m_positionZ );
                                tempsum->SetHomePosition(CrusaderPos[0]);
                            }
                        }

                    }

                    PhaseCount++;
                    uiSummon_Timer = 20000;
                }else uiSummon_Timer -= diff;

                if(PhaseCount > 8)
                {
                    if(Creature* Halof = me->GetCreature(*me,guidHalof))
                    {
                        if(Halof->isDead())
                        {
                            EventFinished = true;
                            DoCast(me,SPELL_CRUSADERS_SPIRE_VICTORY,true);

                            Summons.DespawnEntry(ENTRY_HIDEOUS_PLAGEBRINGER);
                            Summons.DespawnEntry(ENTRY_REANIMATED_CAPTAIN);
                            Summons.DespawnEntry(ENTRY_SCOURGE_DRUDGE);
                            Summons.DespawnEntry(ENTRY_HALOF_THE_DEATHBRINGER);

                            if(Creature* dalfors = GetClosestCreatureWithEntry(me,ENTRY_CRUSADER_LORD_DALFORS,100,true))
                                dalfors->MonsterYell(YELL_FINISHED, LANG_UNIVERSAL, NULL);

                            for(std::list<uint64>::iterator itr = Summons.begin(); itr != Summons.end(); ++itr)
                            {
                                if(Creature* temp = Creature::GetCreature(*me,*itr))
                                {
                                    temp->DespawnOrUnsummon(20000);
                                }
                            }

                            me->DespawnOrUnsummon(20000);
                        }
                    }
                }
            }
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_blessed_bannerAI(creature);
    }

};


/*######
## npc_vereth_the_cunning
######*/

enum eVerethTheCunning
{
    NPC_GEIST_RETURN_BUNNY_KC   = 31049,
    NPC_LITHE_STALKER           = 30894,
    SPELL_SUBDUED_LITHE_STALKER = 58151,
};

class npc_vereth_the_cunning : public CreatureScript
{
public:
    npc_vereth_the_cunning() : CreatureScript("npc_vereth_the_cunning") { }

    struct npc_vereth_the_cunningAI : public ScriptedAI
    {
        npc_vereth_the_cunningAI(Creature* creature) : ScriptedAI(creature) {}

        void MoveInLineOfSight(Unit* who)
        {
            ScriptedAI::MoveInLineOfSight(who);

            if (who->GetEntry() == NPC_LITHE_STALKER && me->IsWithinDistInMap(who, 10.0f))
            {
                if (Unit* owner = who->GetCharmer())
                {
                    if (who->HasAura(SPELL_SUBDUED_LITHE_STALKER))
                        {
                            owner->ToPlayer()->KilledMonsterCredit(NPC_GEIST_RETURN_BUNNY_KC, 0);
                            who->ToCreature()->DisappearAndDie();

                    }
                }
            }
        }
    };


    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_vereth_the_cunningAI(creature);
    }

};

void AddSC_icecrown()
{
    new npc_arete;
    new npc_alorah_and_grimmin;
    new npc_guardian_pavilion;
	new npc_webbed_crusader;
    new spell_argent_cannon;
    new npc_blessed_banner;
    new npc_vereth_the_cunning;
}
