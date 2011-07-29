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
        switch(uiAction)
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

    GOSSIP_TEXTID_SQUIRE_DAVID                                = 14407
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


        player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_SQUIRE_DAVID, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {

           if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
           {
               player->CLOSE_GOSSIP_MENU();
               creature->SummonCreature(NPC_ARGENT_VALIANT,8575.451f,952.472f,547.554f,0.38f);
           }
           //else
               //pPlayer->SEND_GOSSIP_MENU(???, pCreature->GetGUID()); Missing text
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
    SPELL_DEFEND               = 62719,
    SPELL_THRUST               = 62544,
	
    NPC_ARGENT_VALIANT_CREDIT   = 24108
};

enum eValiantText
{
       NPC_FACTION_VAILIANT_TEXT_SAY_START_1   = -1850004,//   Tenez-vous prêt !
       NPC_FACTION_VAILIANT_TEXT_SAY_START_2   = -1850005,//   Que le combat commence !
       NPC_FACTION_VAILIANT_TEXT_SAY_START_3   = -1850006,//   Préparez-vous !
       NPC_ARGENT_VAILIANT_TEXT_SAY_START              = -1850007,//   Vous pensez avoir la vaillance en vous ? Nous verrons.
       NPC_ARGENT_VAILIANT_TEXT_SAY_WIN                = -1850008,//   Impressionnante démonstration. Je pense que vous êtes tout à fait en mesure de rejoindre les rangs des vaillants.
       NPC_ARGENT_VAILIANT_TEXT_SAY_LOOSE              = -1850009,//   J'ai gagné. Vous aurez sans doute plus de chance la prochaine fois.
       NPC_FACTION_VAILIANT_TEXT_SAY_WIN_1     = -1850010,//   Je suis vaincue. Joli combat !
       NPC_FACTION_VAILIANT_TEXT_SAY_WIN_2     = -1850011,//   On dirait que j'ai sous-estimé vos compétences. Bien joué.
       NPC_FACTION_VAILIANT_TEXT_SAY_LOOSE     = -1850012,//   J'ai gagné. Vous aurez sans doute plus de chance la prochaine fois.
};

class npc_argent_valiant : public CreatureScript
{
public:
    npc_argent_valiant() : CreatureScript("npc_argent_valiant") { }

    struct npc_argent_valiantAI : public ScriptedAI
    {
        npc_argent_valiantAI(Creature* creature) : ScriptedAI(creature)
        {

           me->CastSpell(me, SPELL_DEFEND, true);
           me->CastSpell(me, SPELL_DEFEND, true);
            creature->GetMotionMaster()->MovePoint(0, 8599.258f, 963.951f, 547.553f);
            creature->setFaction(35); //wrong faction in db?

        }

        uint32 uiChargeTimer;
        uint32 uiShieldBreakerTimer;
		uint32 uiDefendTimer;

        void Reset()
        {
            uiChargeTimer = 7000;
            uiShieldBreakerTimer = 10000;
			uiDefendTimer = 10000;
        }

        void MovementInform(uint32 uiType, uint32 /*uiId*/)
        {
            if (uiType != POINT_MOTION_TYPE)
                return;

            me->setFaction(14);
        }

        void DamageTaken(Unit* pDoneBy, uint32& uiDamage)
        {
            if(pDoneBy)
               {
                       if (uiDamage > me->GetHealth() && (pDoneBy->GetTypeId() == TYPEID_PLAYER || pDoneBy->GetOwner()))
                       {
                               DoScriptText(NPC_ARGENT_VAILIANT_TEXT_SAY_WIN, me);
                               uiDamage = 0;

                               if(pDoneBy->GetOwner())
                                       (pDoneBy->GetOwner())->ToPlayer()->KilledMonsterCredit(NPC_ARGENT_VALIANT_CREDIT,0);
                               if(pDoneBy->GetTypeId() == TYPEID_PLAYER)
                                       pDoneBy->ToPlayer()->KilledMonsterCredit(NPC_ARGENT_VALIANT_CREDIT,0);

                               me->setFaction(35);
                               me->ForcedDespawn(5000);
                               me->SetHomePosition(me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(),me->GetOrientation());
                               EnterEvadeMode();
                       }
               }
        }

        void KilledUnit(Unit* /*victim*/)
        {
                       me->setFaction(35);
                       me->ForcedDespawn(5000);
                       DoScriptText(NPC_ARGENT_VAILIANT_TEXT_SAY_LOOSE, me);
                       me->CombatStop(true);
        }

        void DoMeleeAttackIfReady()
       {
               if (me->HasUnitState(UNIT_STAT_CASTING))
                   return;

               //Make sure our attack is ready and we aren't currently casting before checking distance
               if (me->isAttackReady())
               {
                   //If we are within range melee the target
                   if (me->IsWithinMeleeRange(me->getVictim()))
                   {
                       DoCastVictim(SPELL_THRUST);
                       me->resetAttackTimer();
                   }
               }
       }

       void EnterCombat(Unit* /*who*/)
        {
               DoScriptText(NPC_ARGENT_VAILIANT_TEXT_SAY_START, me);
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
			
            if (uiDefendTimer <= uiDiff)
            {
               me->CastSpell(me, SPELL_DEFEND, true);
               uiDefendTimer = 10000;
            } else uiDefendTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature* creature) const
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

            switch(me->GetEntry())
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

    CreatureAI *GetAI(Creature* creature) const
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

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_guardian_pavilionAI(creature);
    }
};

/*######
## npc_vendor_argent_tournament
######*/
const uint32 ArgentTournamentVendor[10][4] =
{
       {33553,13726,2,14460}, // Orc
       {33554,13726,8,14464}, // Troll
       {33556,13728,6,14458}, // Tauren
       {33555,13729,5,14459}, // Undead
       {33557,13731,10,14465}, // Blood Elf
       {33307,13699,1,14456}, // Human
       {33310,13713,3,14457}, // Dwarf
       {33653,13725,4,14463}, // Night Elf
       {33650,13723,7,14462}, // Gnome
       {33657,13724,11,14461} // Draenei
};

class npc_vendor_argent_tournament : public CreatureScript
{
public:
       npc_vendor_argent_tournament(): CreatureScript("npc_vendor_argent_tournament"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
               bool npcCheck = false;
               bool questCheck = false;
               bool raceCheck = false;
               uint32 textId = 0;

               for(int i = 0; (i < 10) && !npcCheck; i++)
               {
                       if(pCreature->GetEntry() == ArgentTournamentVendor[i][0])
                       {
                               npcCheck = true;
                               questCheck = pPlayer->GetQuestStatus(ArgentTournamentVendor[i][1]) == QUEST_STATUS_COMPLETE;
                               raceCheck = pPlayer->getRace() == ArgentTournamentVendor[i][2];
                               textId = ArgentTournamentVendor[i][3];
                       }
               }

               if(questCheck || raceCheck)
                       pPlayer->GetSession()->SendListInventory(pCreature->GetGUID());
               else
                   pPlayer->SEND_GOSSIP_MENU(textId, pCreature->GetGUID());
               return true;
       }

};

/*######
* quest_givers_argent_tournament
######*/

class quest_givers_argent_tournament : public CreatureScript
{
public:
       quest_givers_argent_tournament(): CreatureScript("quest_givers_argent_tournament"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
               //uint64 const guid = pCreature->GetGUID();

               if (pCreature->isQuestGiver())
               {
                       Object *pObject = (Object*)pCreature;
                       QuestRelations* pObjectQR = sObjectMgr->GetCreatureQuestRelationMap();
                       QuestRelations* pObjectQIR = sObjectMgr->GetCreatureQuestInvolvedRelation();

                       QuestMenu &qm = pPlayer->PlayerTalkClass->GetQuestMenu();
                       qm.ClearMenu();

                       for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
                       {
                               uint32 quest_id = i->second;
                               QuestStatus status = pPlayer->GetQuestStatus(quest_id);
                               if (status == QUEST_STATUS_COMPLETE && !pPlayer->GetQuestRewardStatus(quest_id))
                                       qm.AddMenuItem(quest_id, 4);
                               else if (status == QUEST_STATUS_INCOMPLETE)
                                       qm.AddMenuItem(quest_id, 4);
                               //else if (status == QUEST_STATUS_AVAILABLE)
                               //    qm.AddMenuItem(quest_id, 2);
                       }

                       bool EligibilityAlliance = pPlayer->GetQuestStatus(13686) == QUEST_STATUS_COMPLETE;
                       bool EligibilityHorde = pPlayer->GetQuestStatus(13687) == QUEST_STATUS_COMPLETE;

                       for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
                       {
                               uint32 quest_id = i->second;
                               Quest const* pQuest = sObjectMgr->GetQuestTemplate(quest_id);
                               if (!pQuest) continue;

                               switch(quest_id)
                               {
                                       case 13707: // Valiant Of Orgrimmar
                                       case 13708: // Valiant Of Sen'jin
                                       case 13709: // Valiant Of Thunder Bluff
                                       case 13710: // Valiant Of Undercity
                                       case 13711: // Valiant Of Silvermoon
                                               if(!EligibilityHorde)
                                               {
                                                       QuestStatus status = pPlayer->GetQuestStatus(quest_id);

                                                       if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 4);
                                                       else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 2);
                                               }
                                               break;
                                       case 13593: // Valiant Of Stormwind
                                       case 13703: // Valiant Of Ironforge
                                       case 13706: // Valiant Of Darnassus
                                       case 13704: // Valiant Of Gnomeregan
                                       case 13705: // Valiant Of The Exodar
                                               if(!EligibilityAlliance)
                                               {
                                                       QuestStatus status = pPlayer->GetQuestStatus(quest_id);

                                                       if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 4);
                                                       else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 2);
                                               }
                                               break;
                                       default:
                                               QuestStatus status = pPlayer->GetQuestStatus(quest_id);

                                               if (pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                       qm.AddMenuItem(quest_id, 4);
                                               else if (status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                       qm.AddMenuItem(quest_id, 2);
                                               break;
                               }
                       }
               }
           pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
           return true;
       }

};

/*######
* npc_training_dummy_argent
######*/
#define SPELL_DEFEND_AURA 62719
#define SPELL_DEFEND_AURA_1 64100
#define SPELL_ARGENT_CHARGE 68321
#define SPELL_ARGENT_BREAK_SHIELD 62626
#define SPELL_ARGENT_MELEE 62544

class npc_training_dummy_argent : public CreatureScript
{
public:
       npc_training_dummy_argent(): CreatureScript("npc_training_dummy_argent"){}

       struct npc_training_dummy_argentAI : Scripted_NoMovementAI
       {
           npc_training_dummy_argentAI(Creature *c) : Scripted_NoMovementAI(c)
           {
               m_Entry = c->GetEntry();
           }

           uint64 m_Entry;
           uint32 ResetTimer;
           uint32 DespawnTimer;
               uint32 ShielTimer;
           void Reset()
           {
               me->SetControlled(true,UNIT_STAT_STUNNED);//disable rotate
               me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);//imune to knock aways like blast wave
               me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_STUN, true);
               ResetTimer = 10000;
               DespawnTimer = 15000;
                       ShielTimer=0;
           }

           void EnterEvadeMode()
           {
               if (!_EnterEvadeMode())
                   return;

               Reset();
           }

           void DamageTaken(Unit * /*done_by*/, uint32 &damage)
           {
               ResetTimer = 10000;
               damage = 0;
           }

           void EnterCombat(Unit * /*who*/)
           {
               if (m_Entry != 2674 && m_Entry != 2673)
                   return;
           }

               void SpellHit(Unit* caster,const SpellEntry* spell)
               {
                       if(caster->GetOwner())
                       {
                               if(m_Entry==33272)
                                       if(spell->Id==SPELL_ARGENT_CHARGE)
                                               if(!me->GetAura(SPELL_DEFEND_AURA))
                                                       caster->GetOwner()->ToPlayer()->KilledMonsterCredit(33340, 0);
                               if(m_Entry==33229){
                                       if(spell->Id==SPELL_ARGENT_MELEE)
                                       {
                                               caster->GetOwner()->ToPlayer()->KilledMonsterCredit(33341, 0);
                                               me->CastSpell(caster,62709,true);
                                       }
                               }

                       }

                       if(m_Entry==33243)
                                       if(spell->Id==SPELL_ARGENT_BREAK_SHIELD)
                                               if(!me->GetAura(SPELL_DEFEND_AURA))
                                                       if(caster->GetTypeId()==TYPEID_PLAYER)
                                                               caster->ToPlayer()->KilledMonsterCredit(33339, 0);
               }


           void UpdateAI(const uint32 diff)
           {
                       if (ShielTimer <= diff)
                       {
                               if(m_Entry==33243)
                                       me->CastSpell(me,SPELL_DEFEND_AURA,true);

                               if(m_Entry==33272 && !me->GetAura(SPELL_DEFEND_AURA_1))
                                               me->CastSpell(me,SPELL_DEFEND_AURA_1,true);
                               ShielTimer = 8000;
                       }
                       else
                               ShielTimer -= diff;

               if (!UpdateVictim())
                   return;
               if (!me->HasUnitState(UNIT_STAT_STUNNED))
                   me->SetControlled(true,UNIT_STAT_STUNNED);//disable rotate

               if (m_Entry != 2674 && m_Entry != 2673)
               {
                   if (ResetTimer <= diff)
                   {
                       EnterEvadeMode();
                       ResetTimer = 10000;
                   }
                   else
                       ResetTimer -= diff;
                   return;
               }
               else
               {
                   if (DespawnTimer <= diff)
                       me->ForcedDespawn();
                   else
                       DespawnTimer -= diff;
               }
           }
           void MoveInLineOfSight(Unit * /*who*/){return;}
       };

       CreatureAI* GetAI(Creature* pCreature) const
       {
           return new npc_training_dummy_argentAI(pCreature);
       }

};

/*######
* npc_quest_givers_for_crusaders
######*/

class npc_quest_givers_for_crusaders : public CreatureScript
{
public:
       npc_quest_givers_for_crusaders(): CreatureScript("npc_quest_givers_for_crusaders"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
               if (pPlayer->HasTitle(TITLE_CRUSADER))
                       if (pCreature->isQuestGiver())
                               pPlayer->PrepareQuestMenu(pCreature->GetGUID());

               pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
               return true;
       }

};

/*######
* npc_crusader_rhydalla
######*/

class npc_crusader_rhydalla : public CreatureScript
{
public:
       npc_crusader_rhydalla(): CreatureScript("npc_crusader_rhydalla"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
               // uint64 const guid = pCreature->GetGUID();

               if (pCreature->isQuestGiver())
               {
                       Object *pObject = (Object*)pCreature;
                       QuestRelations* pObjectQR = sObjectMgr->GetCreatureQuestRelationMap();
                       QuestRelations* pObjectQIR = sObjectMgr->GetCreatureQuestInvolvedRelation();

                       QuestMenu &qm = pPlayer->PlayerTalkClass->GetQuestMenu();
                       qm.ClearMenu();

                       for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
                       {
                               uint32 quest_id = i->second;
                               QuestStatus status = pPlayer->GetQuestStatus(quest_id);
                               if (status == QUEST_STATUS_COMPLETE && !pPlayer->GetQuestRewardStatus(quest_id))
                                       qm.AddMenuItem(quest_id, 4);
                               else if (status == QUEST_STATUS_INCOMPLETE)
                                       qm.AddMenuItem(quest_id, 4);
                               //else if (status == QUEST_STATUS_AVAILABLE)
                               //    qm.AddMenuItem(quest_id, 2);
                       }

                       for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
                       {
                               uint32 quest_id = i->second;
                               Quest const* pQuest = sObjectMgr->GetQuestTemplate(quest_id);
                               if (!pQuest) continue;
                               QuestStatus status;
                               bool allowed=false;
                               switch(quest_id)
                               {
                                       case 13664: // The Black Knigh's Fall
                                               allowed = (pPlayer->GetQuestStatus(13700) == QUEST_STATUS_COMPLETE) || (pPlayer->GetQuestStatus(13701) == QUEST_STATUS_COMPLETE);
                                               if(allowed)
                                               {
                                                       status = pPlayer->GetQuestStatus(quest_id);

                                                       if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 4);
                                                       else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 2);
                                               }
                                               break;
                                       default:
                                               status = pPlayer->GetQuestStatus(quest_id);

                                               if (pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                       qm.AddMenuItem(quest_id, 4);
                                               else if (status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                       qm.AddMenuItem(quest_id, 2);
                                               break;
                               }
                       }
               }
           pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
           return true;
       }

};

/*######
* npc_eadric_the_pure
######*/

class npc_eadric_the_pure : public CreatureScript
{
public:
       npc_eadric_the_pure(): CreatureScript("npc_eadric_the_pure"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
               // uint64 const guid = pCreature->GetGUID();

               if (pCreature->isQuestGiver())
               {
                       Object *pObject = (Object*)pCreature;
                       QuestRelations* pObjectQR = sObjectMgr->GetCreatureQuestRelationMap();
                       QuestRelations* pObjectQIR = sObjectMgr->GetCreatureQuestInvolvedRelation();

                       QuestMenu &qm = pPlayer->PlayerTalkClass->GetQuestMenu();
                       qm.ClearMenu();

                       for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
                       {
                               uint32 quest_id = i->second;
                               QuestStatus status = pPlayer->GetQuestStatus(quest_id);
                               if (status == QUEST_STATUS_COMPLETE && !pPlayer->GetQuestRewardStatus(quest_id))
                                       qm.AddMenuItem(quest_id, 4);
                               else if (status == QUEST_STATUS_INCOMPLETE)
                                       qm.AddMenuItem(quest_id, 4);
                               //else if (status == QUEST_STATUS_AVAILABLE)
                               //    qm.AddMenuItem(quest_id, 2);
                       }

                       for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
                       {
                               uint32 quest_id = i->second;
                               Quest const* pQuest = sObjectMgr->GetQuestTemplate(quest_id);
                               if (!pQuest) continue;
                               QuestStatus status;
                               bool allowed=false;
                               switch(quest_id)
                               {
                                       case 13682: // Alliance Threat From Above
                                       case 13809: // Horde Threat From Above
                                               allowed = (pPlayer->GetQuestStatus(13664) == QUEST_STATUS_COMPLETE) && pPlayer->GetQuestRewardStatus(13664);
                                               if(allowed)
                                               {
                                                       status = pPlayer->GetQuestStatus(quest_id);

                                                       if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 4);
                                                       else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 2);
                                               }
                                               break;
                                       default:
                                               status = pPlayer->GetQuestStatus(quest_id);

                                               if (pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                       qm.AddMenuItem(quest_id, 4);
                                               else if (status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                       qm.AddMenuItem(quest_id, 2);
                                               break;
                               }
                       }
               }
           pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
           return true;
       }

};

/*######
* npc_justicar_mariel_trueheart
######*/

class npc_justicar_mariel_trueheart : public CreatureScript
{
public:
       npc_justicar_mariel_trueheart(): CreatureScript("npc_justicar_mariel_trueheart"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
               // uint64 const guid = pCreature->GetGUID();

               if (pCreature->isQuestGiver())
               {
                       Object *pObject = (Object*)pCreature;
                       QuestRelations* pObjectQR = sObjectMgr->GetCreatureQuestRelationMap();
                       QuestRelations* pObjectQIR = sObjectMgr->GetCreatureQuestInvolvedRelation();

                       QuestMenu &qm = pPlayer->PlayerTalkClass->GetQuestMenu();
                       qm.ClearMenu();

                       for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
                       {
                               uint32 quest_id = i->second;
                               QuestStatus status = pPlayer->GetQuestStatus(quest_id);
                               if (status == QUEST_STATUS_COMPLETE && !pPlayer->GetQuestRewardStatus(quest_id))
                                       qm.AddMenuItem(quest_id, 4);
                               else if (status == QUEST_STATUS_INCOMPLETE)
                                       qm.AddMenuItem(quest_id, 4);
                               //else if (status == QUEST_STATUS_AVAILABLE)
                               //    qm.AddMenuItem(quest_id, 2);
                       }

                       for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
                       {
                               uint32 quest_id = i->second;
                               Quest const* pQuest = sObjectMgr->GetQuestTemplate(quest_id);
                               if (!pQuest) continue;
                               QuestStatus status;
                               bool allowed=false;
                               switch(quest_id)
                               {
                                       case 13795: // The Scourgebane
                                               allowed = (pPlayer->GetQuestStatus(13702) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13702)) || (pPlayer->GetQuestStatus(13732) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13732)) || (pPlayer->GetQuestStatus(13735) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13735)) || (pPlayer->GetQuestStatus(13733) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13733)) || (pPlayer->GetQuestStatus(13734) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13734)) || (pPlayer->GetQuestStatus(13736) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13736)) || (pPlayer->GetQuestStatus(13737) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13737)) || (pPlayer->GetQuestStatus(13738) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13738)) || (pPlayer->GetQuestStatus(13739) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13739)) || (pPlayer->GetQuestStatus(13740) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13740)); // If the player has finished any of the "A Champion Rises" quests
                                               if(allowed)
                                               {
                                                       status = pPlayer->GetQuestStatus(quest_id);

                                                       if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 4);
                                                       else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 2);
                                               }
                                               break;
                                       default:
                                               status = pPlayer->GetQuestStatus(quest_id);

                                               if (pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                       qm.AddMenuItem(quest_id, 4);
                                               else if (status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                       qm.AddMenuItem(quest_id, 2);
                                               break;
                               }
                       }
               }
           pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
           return true;
       }

};

/*######
* npc_crok_scourgebane
######*/

class npc_crok_scourgebane_quest : public CreatureScript
{
public:
       npc_crok_scourgebane_quest(): CreatureScript("npc_crok_scourgebane_quest"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
               // uint64 const guid = pCreature->GetGUID();

               if (pCreature->isQuestGiver())
               {
                       Object *pObject = (Object*)pCreature;
                       QuestRelations* pObjectQR = sObjectMgr->GetCreatureQuestRelationMap();
                       QuestRelations* pObjectQIR = sObjectMgr->GetCreatureQuestInvolvedRelation();

                       QuestMenu &qm = pPlayer->PlayerTalkClass->GetQuestMenu();
                       qm.ClearMenu();

                       for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
                       {
                               uint32 quest_id = i->second;
                               QuestStatus status = pPlayer->GetQuestStatus(quest_id);
                               if (status == QUEST_STATUS_COMPLETE && !pPlayer->GetQuestRewardStatus(quest_id))
                                       qm.AddMenuItem(quest_id, 4);
                               else if (status == QUEST_STATUS_INCOMPLETE)
                                       qm.AddMenuItem(quest_id, 4);
                               //else if (status == QUEST_STATUS_AVAILABLE)
                               //    qm.AddMenuItem(quest_id, 2);
                       }

                       for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
                       {
                               uint32 quest_id = i->second;
                               Quest const* pQuest = sObjectMgr->GetQuestTemplate(quest_id);
                               if (!pQuest) continue;
                               QuestStatus status;
                               bool allowed=false;
                               switch(quest_id)
                               {
                                       case 13788: // DK Threat From Above (Alliance)
                                       case 13812: // DK Threat From Above (Horde)
                                               allowed = (pPlayer->GetQuestStatus(13664) == QUEST_STATUS_COMPLETE) && pPlayer->GetQuestRewardStatus(13664);
                                               if(allowed)
                                               {
                                                       status = pPlayer->GetQuestStatus(quest_id);

                                                       if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 4);
                                                       else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                               qm.AddMenuItem(quest_id, 2);
                                               }
                                               break;
                                       default:
                                               status = pPlayer->GetQuestStatus(quest_id);

                                               if (pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                                       qm.AddMenuItem(quest_id, 4);
                                               else if (status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                                       qm.AddMenuItem(quest_id, 2);
                                               break;
                               }
                       }
               }
           pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
           return true;
       }

};

/*
* Npc Jeran Lockwood (33973)
*/
#define JERAN_DEFAULT_TEXTID 14453
#define JERAN_QUEST_TEXTID 14431
#define JERAN_RP_TEXTID 14434
#define GOSSIP_HELLO_JERAN_1 "Montrez-moi comment m'entraÃ®ner sur une cible de mÃªlÃ©e."
#define GOSSIP_HELLO_JERAN_2 "Parlez-moi de la dÃ©fense et du coup de lance."
#define SPELL_CREDIT_JERAN 64113

class npc_jeran_lockwood : public CreatureScript
{
public:
       npc_jeran_lockwood(): CreatureScript("npc_jeran_lockwood"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
               if((pPlayer->GetQuestStatus(13828) == QUEST_STATUS_INCOMPLETE) || (pPlayer->GetQuestStatus(13829) == QUEST_STATUS_INCOMPLETE))
               {
                       pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_JERAN_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                       pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_JERAN_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
               pPlayer->SEND_GOSSIP_MENU(JERAN_QUEST_TEXTID, pCreature->GetGUID());
               }
               else
               {
                       pPlayer->SEND_GOSSIP_MENU(JERAN_DEFAULT_TEXTID, pCreature->GetGUID());
               }
               return true;
       }

       bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
       {
               switch(uiAction)
               {
                       case GOSSIP_ACTION_INFO_DEF+1:
                               pPlayer->CastSpell(pPlayer,SPELL_CREDIT_JERAN,true);
                               pPlayer->CLOSE_GOSSIP_MENU();
                               break;
                       case GOSSIP_ACTION_INFO_DEF+2:
                               pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_JERAN_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                               pPlayer->SEND_GOSSIP_MENU(JERAN_RP_TEXTID, pCreature->GetGUID());
                               break;
               }
               return true;
       }

};

/*
* Npc Rugan Steelbelly (33972)
*/
#define RUGAN_DEFAULT_TEXTID 14453
#define RUGAN_QUEST_TEXTID 14436
#define RUGAN_RP_TEXTID 14437
#define GOSSIP_HELLO_RUGAN_1 "Montrez-moi comment m'entraÃ®ner sur une cible de charge."
#define GOSSIP_HELLO_RUGAN_2 "Parlez-moi de la charge"
#define SPELL_CREDIT_RUGAN 64114

class npc_rugan_steelbelly : public CreatureScript
{
public:
       npc_rugan_steelbelly(): CreatureScript("npc_rugan_steelbelly"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
               if((pPlayer->GetQuestStatus(13837) == QUEST_STATUS_INCOMPLETE) || (pPlayer->GetQuestStatus(13839) == QUEST_STATUS_INCOMPLETE))
               {
                       pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_RUGAN_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                       pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_RUGAN_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
               pPlayer->SEND_GOSSIP_MENU(RUGAN_QUEST_TEXTID, pCreature->GetGUID());
               }
               else
               {
                       pPlayer->SEND_GOSSIP_MENU(RUGAN_DEFAULT_TEXTID, pCreature->GetGUID());
               }
               return true;
       }

       bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
       {
               switch(uiAction)
               {
                       case GOSSIP_ACTION_INFO_DEF+1:
                               pPlayer->CastSpell(pPlayer,SPELL_CREDIT_RUGAN,true);
                               pPlayer->CLOSE_GOSSIP_MENU();
                               break;
                       case GOSSIP_ACTION_INFO_DEF+2:
                               pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_RUGAN_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                               pPlayer->SEND_GOSSIP_MENU(RUGAN_RP_TEXTID, pCreature->GetGUID());
                               break;
               }
               return true;
       }

};

/*
* Npc Valis Windchaser
*/
#define VALIS_DEFAULT_TEXTID 14453
#define VALIS_QUEST_TEXTID 14438
#define VALIS_RP_TEXTID 14439
#define GOSSIP_HELLO_VALIS_1 "Montrez-moi comment m'entraÃ®ner sur une cible Ã distance."
#define GOSSIP_HELLO_VALIS_2 "Expliquez-moi comment utiliser le brise-bouclier."
#define SPELL_CREDIT_VALIS 64115
class npc_valis_windchaser : public CreatureScript
{
public:
       npc_valis_windchaser(): CreatureScript("npc_valis_windchaser"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
               //Si il a la quete
               if((pPlayer->GetQuestStatus(13835) == QUEST_STATUS_INCOMPLETE) ||
                       (pPlayer->GetQuestStatus(13838) == QUEST_STATUS_INCOMPLETE))
               {
                       pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_VALIS_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                       pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_VALIS_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
               pPlayer->SEND_GOSSIP_MENU(VALIS_QUEST_TEXTID, pCreature->GetGUID());
               }
               //Sinon Texte par défaut
               else
                       pPlayer->SEND_GOSSIP_MENU(VALIS_DEFAULT_TEXTID, pCreature->GetGUID());
               return true;
       }

       bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
       {
               switch (uiAction)
               {
                       case GOSSIP_ACTION_INFO_DEF+1:
                               pPlayer->CastSpell(pPlayer,SPELL_CREDIT_VALIS,true);//Cast du sort de credit quest (valide l'objectif)
                               pPlayer->CLOSE_GOSSIP_MENU();//Ferme la fenetre du gossip coté client
                       break;
                       case GOSSIP_ACTION_INFO_DEF+2:
                               //Raconte un blabla
                               pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_VALIS_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                       pPlayer->SEND_GOSSIP_MENU(VALIS_RP_TEXTID, pCreature->GetGUID());
                       break;
               }
               return true;
       }

};

/*######
## npc_squire_danny
######*/

enum eSquireDanny
{
    QUEST_THE_VALIANT_S_CHALLENGE_0 = 13699,
    QUEST_THE_VALIANT_S_CHALLENGE_1 = 13713,
    QUEST_THE_VALIANT_S_CHALLENGE_2 = 13723,
    QUEST_THE_VALIANT_S_CHALLENGE_3 = 13724,
    QUEST_THE_VALIANT_S_CHALLENGE_4 = 13725,
    QUEST_THE_VALIANT_S_CHALLENGE_5 = 13726,
    QUEST_THE_VALIANT_S_CHALLENGE_6 = 13727,
    QUEST_THE_VALIANT_S_CHALLENGE_7 = 13728,
    QUEST_THE_VALIANT_S_CHALLENGE_8 = 13729,
    QUEST_THE_VALIANT_S_CHALLENGE_9 = 13731,

    NPC_ARGENT_CHAMPION = 33707,

    GOSSIP_TEXTID_SQUIRE_DANNY = 14407
};

#define GOSSIP_SQUIRE_ITEM_1 "I am ready to fight!"
#define GOSSIP_SQUIRE_ITEM_2 "How do the Argent Crusader raiders fight?"

class npc_squire_danny : public CreatureScript
{
public:
       npc_squire_danny(): CreatureScript("npc_squire_danny"){}

       bool OnGossipHello(Player* pPlayer, Creature* pCreature)
       {
           if (pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_0) == QUEST_STATUS_INCOMPLETE ||
               pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_1) == QUEST_STATUS_INCOMPLETE ||
               pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_2) == QUEST_STATUS_INCOMPLETE ||
               pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_3) == QUEST_STATUS_INCOMPLETE ||
               pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_4) == QUEST_STATUS_INCOMPLETE ||
               pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_5) == QUEST_STATUS_INCOMPLETE ||
               pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_6) == QUEST_STATUS_INCOMPLETE ||
               pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_7) == QUEST_STATUS_INCOMPLETE ||
               pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_8) == QUEST_STATUS_INCOMPLETE ||
               pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_9) == QUEST_STATUS_INCOMPLETE)
           {
               pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
               pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
           }

           pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_SQUIRE_DANNY, pCreature->GetGUID());
           return true;
       }

       bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
       {
           if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
           {
               pPlayer->CLOSE_GOSSIP_MENU();
               pCreature->SummonCreature(NPC_ARGENT_CHAMPION,8562.836914f,1099.153931f,556.787598f,5.026550f); // TODO (Récupérer les coordonnées réelles)
           }
           //else
               //pPlayer->SEND_GOSSIP_MENU(???, pCreature->GetGUID()); Missing text
           return true;
       }

};

/*######
## npc_argent_champion
######*/

enum eArgentChampion
{
    SPELL_CHARGE_CHAMPION                = 63010,
    SPELL_SHIELD_BREAKER_CHAMPION        = 65147,
    SPELL_DEFEND_CHAMPION              = 62719,
    SPELL_THRUST_CHAMPION              = 62544,

    NPC_ARGENT_CHAMPION_CREDIT   = 33708
};

enum eChampionText
{
       NPC_FACTION_CHAMPION_TEXT_SAY_START_1   = -1850004,//   Tenez-vous prêt !
       NPC_FACTION_CHAMPION_TEXT_SAY_START_2   = -1850005,//   Que le combat commence !
       NPC_FACTION_CHAMPION_TEXT_SAY_START_3   = -1850006,//   Préparez-vous !
       NPC_ARGENT_CHAMPION_TEXT_SAY_START              = -1850007,//   Vous pensez avoir la vaillance en vous ? Nous verrons.
       NPC_ARGENT_CHAMPION_TEXT_SAY_WIN                = -1850008,//   Impressionnante démonstration. Je pense que vous êtes tout à fait en mesure de rejoindre les rangs des vaillants.
       NPC_ARGENT_CHAMPION_TEXT_SAY_LOOSE              = -1850009,//   J'ai gagné. Vous aurez sans doute plus de chance la prochaine fois.
       NPC_FACTION_CHAMPION_TEXT_SAY_WIN_1     = -1850010,//   Je suis vaincue. Joli combat !
       NPC_FACTION_CHAMPION_TEXT_SAY_WIN_2     = -1850011,//   On dirait que j'ai sous-estimé vos compétences. Bien joué.
       NPC_FACTION_CHAMPION_TEXT_SAY_LOOSE     = -1850012,//   J'ai gagné. Vous aurez sans doute plus de chance la prochaine fois.
};

class npc_argent_champion : public CreatureScript
{
public:
       npc_argent_champion(): CreatureScript("npc_argent_champion"){}

       struct npc_argent_championAI : public ScriptedAI
       {
           npc_argent_championAI(Creature* pCreature) : ScriptedAI(pCreature)
           {
               me->CastSpell(me, SPELL_DEFEND_CHAMPION, true);
               me->CastSpell(me, SPELL_DEFEND_CHAMPION, true);
               pCreature->GetMotionMaster()->MovePoint(0,8552.469727f,1124.128784f,556.787598f); // TODO (Trouver les coordonnées exactes)
               pCreature->setFaction(35); //wrong faction in db?
           }

           uint32 uiChargeTimer;
           uint32 uiShieldBreakerTimer;
           uint32 uiDefendTimer;

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
                       if(pDoneBy)
                       {
                               if (uiDamage > me->GetHealth() && (pDoneBy->GetTypeId() == TYPEID_PLAYER || pDoneBy->GetOwner()))
                               {
                                       DoScriptText(NPC_ARGENT_CHAMPION_TEXT_SAY_WIN, me);
                                       uiDamage = 0;

                                       if(pDoneBy->GetOwner())
                                               (pDoneBy->GetOwner())->ToPlayer()->KilledMonsterCredit(NPC_ARGENT_CHAMPION_CREDIT,0);
                                       if(pDoneBy->GetTypeId() == TYPEID_PLAYER)
                                               pDoneBy->ToPlayer()->KilledMonsterCredit(NPC_ARGENT_CHAMPION_CREDIT,0);

                                       me->setFaction(35);
                                       me->ForcedDespawn(5000);
                                       me->SetHomePosition(me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(),me->GetOrientation());
                                       EnterEvadeMode();
                               }
                       }
           }

           void KilledUnit(Unit* /*victim*/)
           {
               me->setFaction(35);
               me->ForcedDespawn(5000);
               DoScriptText(NPC_ARGENT_CHAMPION_TEXT_SAY_LOOSE, me);
               me->CombatStop(true);
           }

           void DoMeleeAttackIfReady()
               {
                       if (me->HasUnitState(UNIT_STAT_CASTING))
                           return;

                       //Make sure our attack is ready and we aren't currently casting before checking distance
                       if (me->isAttackReady())
                       {
                           //If we are within range melee the target
                           if (me->IsWithinMeleeRange(me->getVictim()))
                           {
                               DoCastVictim(SPELL_THRUST_CHAMPION);
                               me->resetAttackTimer();
                           }
                       }
               }

           void EnterCombat(Unit* /*who*/)
           {
               DoScriptText(NPC_ARGENT_CHAMPION_TEXT_SAY_START, me);
           }

           void UpdateAI(const uint32 uiDiff)
           {
               if (!UpdateVictim())
                   return;

               if (uiChargeTimer <= uiDiff)
               {
                   DoCastVictim(SPELL_CHARGE_CHAMPION);
                   uiChargeTimer = 7000;
               } else uiChargeTimer -= uiDiff;

               if (uiShieldBreakerTimer <= uiDiff)
               {
                   DoCastVictim(SPELL_SHIELD_BREAKER_CHAMPION);
                   uiShieldBreakerTimer = 10000;
               } else uiShieldBreakerTimer -= uiDiff;

               if (uiDefendTimer <= uiDiff)
               {
                   me->CastSpell(me, SPELL_DEFEND_CHAMPION, true);
                   uiDefendTimer = 10000;
               } else uiDefendTimer -= uiDiff;
			   
			if (uiDefendTimer <= uiDiff)
            {
               me->CastSpell(me, SPELL_DEFEND, true);
               uiDefendTimer = 10000;
            } else uiDefendTimer -= uiDiff;

               DoMeleeAttackIfReady();
           }
       };

       CreatureAI* GetAI(Creature* pCreature) const
       {
           return new npc_argent_championAI (pCreature);
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
                OnEffect += SpellEffectFn(spell_argent_cannon_SpellScript::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
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

#define QUEST_FREE_YOUR_MIND               12893
#define SPELL_SOVEREIGN_ROD                29070
#define NPC_VILE_CREDIT_BUNNY              29845
#define NPC_LADY_NIGHTSWOOD_CREDIT_BUNNY   29846
#define NPC_LEAPER_BUNNY                   29847

class npc_vile : public CreatureScript
{
public:
    npc_vile() : CreatureScript("npc_vile") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_vileAI (pCreature);
    }

    struct npc_vileAI : public ScriptedAI
    {
        npc_vileAI(Creature *c) : ScriptedAI(c) {}

        bool spellHit;

        void Reset()
        {
            spellHit = false;
        }

        void SpellHit(Unit *Hitter, const SpellEntry *Spellkind)
        {
            if ((Spellkind->Id == SPELL_SOVEREIGN_ROD) && !spellHit &&
                (Hitter->GetTypeId() == TYPEID_PLAYER) && (CAST_PLR(Hitter)->IsActiveQuest(QUEST_FREE_YOUR_MIND)))
            {
                CAST_PLR(Hitter)->KilledMonsterCredit(NPC_VILE_CREDIT_BUNNY, 0);
                spellHit = true;
            }
        }
    };

};

class npc_lady_nightswood : public CreatureScript
{
public:
    npc_lady_nightswood() : CreatureScript("npc_lady_nightswood") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_lady_nightswoodAI (pCreature);
    }

    struct npc_lady_nightswoodAI : public ScriptedAI
    {
        npc_lady_nightswoodAI(Creature *c) : ScriptedAI(c) {}

        bool spellHit;

        void Reset()
        {
            spellHit = false;
        }

        void SpellHit(Unit *Hitter, const SpellEntry *Spellkind)
        {
            if ((Spellkind->Id == SPELL_SOVEREIGN_ROD) && !spellHit &&
                (Hitter->GetTypeId() == TYPEID_PLAYER) && (CAST_PLR(Hitter)->IsActiveQuest(QUEST_FREE_YOUR_MIND)))
            {
                CAST_PLR(Hitter)->KilledMonsterCredit(NPC_LADY_NIGHTSWOOD_CREDIT_BUNNY, 0);
                spellHit = true;
            }
        }
    };

};

class npc_leaper : public CreatureScript
{
public:
    npc_leaper() : CreatureScript("npc_leaper") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_leaperAI (pCreature);
    }

    struct npc_leaperAI : public ScriptedAI
    {
        npc_leaperAI(Creature *c) : ScriptedAI(c) {}

        bool spellHit;

        void Reset()
        {
            spellHit = false;
        }

        void SpellHit(Unit *Hitter, const SpellEntry *Spellkind)
        {
            if ((Spellkind->Id == SPELL_SOVEREIGN_ROD) && !spellHit &&
                (Hitter->GetTypeId() == TYPEID_PLAYER) && (CAST_PLR(Hitter)->IsActiveQuest(QUEST_FREE_YOUR_MIND)))
            {
                CAST_PLR(Hitter)->KilledMonsterCredit(NPC_LEAPER_BUNNY, 0);
                spellHit = true;
            }
        }
    };

};

void AddSC_icecrown()
{
    new npc_arete;
    new npc_dame_evniki_kapsalis;
    new npc_squire_david;
    new npc_argent_valiant;
    new npc_alorah_and_grimmin;
    new npc_guardian_pavilion;
	new npc_vendor_argent_tournament;
    new quest_givers_argent_tournament;
    new npc_training_dummy_argent;
    new npc_quest_givers_for_crusaders;
    new npc_justicar_mariel_trueheart;
    new npc_crusader_rhydalla;
    new npc_eadric_the_pure;
    new npc_crok_scourgebane_quest;
    new npc_valis_windchaser;
    new npc_rugan_steelbelly;
    new npc_jeran_lockwood;
    new npc_squire_danny;
    new npc_argent_champion;
	new npc_webbed_crusader;
    new spell_argent_cannon;
    new npc_blessed_banner;
	new npc_vile;
    new npc_lady_nightswood;
    new npc_leaper;
}
