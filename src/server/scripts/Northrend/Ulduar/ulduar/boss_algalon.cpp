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

/*
#include "ScriptPCH.h"
#include "ulduar.h"

#define GAMEOBJECT_GIVE_OF_THE_OBSERVER 194821

enum Spells
{
    SPELL_ASCEND                    = 64487,
    SPELL_BERSERK                   = 47008,
    SPELL_BIG_BANG                  = 64443,
    H_SPELL_BIG_BANG                = 64584,
    SPELL_COSMIC_SMASH              = 62301,
    H_SPELL_COSMIC_SMASH            = 64598,
    SPELL_PHASE_PUNCH               = 64412,
    SPELL_QUANTUM_STRIKE            = 64395,
    H_SPELL_QUANTUM_STRIKE          = 64592,
    SPELL_BLACK_HOLE_EXPLOSION      = 64122,
    SPELL_ARCANE_BARAGE             = 64599,
    H_SPELL_ARCANE_BARAGE           = 64607
};

enum Creatures
{
    CREATURE_COLLAPSING_STAR        = 32955,
    CREATURE_BLACK_HOLE             = 32953,
    CREATURE_LIVING_CONSTELLATION   = 33052,
    CREATURE_DARK_MATTER            = 33089
};

enum Yells
{
    SAY_AGGRO                                   = -1603000,
    SAY_SLAY_1                                  = -1603001,
    SAY_SLAY_2                                  = -1603002,
    SAY_ENGADED_FOR_FIRTS_TIME                  = -1603003,
    SAY_PHASE_2                                 = -1603004,
    SAY_SUMMON_COLLAPSING_STAR                  = -1603005,
    SAY_DEATH_1                                 = -1603006,
    SAY_DEATH_2                                 = -1603007,
    SAY_DEATH_3                                 = -1603008,
    SAY_DEATH_4                                 = -1603009,
    SAY_DEATH_5                                 = -1603010,
    SAY_BERSERK                                 = -1603011,
    SAY_BIG_BANG_1                              = -1603012,
    SAY_BIG_BANG_2                              = -1603013,
    SAY_TIMER_1                                 = -1603014,
    SAY_TIMER_2                                 = -1603015,
    SAY_TIMER_3                                 = -1603016,
    SAY_SUMMON_1                                = -1603017,
    SAY_SUMMON_2                                = -1603018,
    SAY_SUMMON_3                                = -1603019,
};

class boss_algalon : public CreatureScript
{
public:
    boss_algalon() : CreatureScript("boss_algalon") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_algalonAI(pCreature);
    }

    struct boss_algalonAI : public ScriptedAI
    {
        boss_algalonAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            Summon = false; // not in reset. intro speech done only once.
        }

        InstanceScript* pInstance;

        std::list<uint64> m_lCollapsingStarGUIDList;

        uint32 Phase;
        uint32 Ascend_Timer;
        uint32 Berserk_Timer;
        uint32 BigBang_Timer;
        uint32 CosmicSmash_Timer;
        uint32 PhasePunch_Timer;
        uint32 QuantumStrike_Timer;
        uint32 CollapsingStar_Timer;
        uint32 uiPhase_timer;
        uint32 uiStep;

        uint64 BlackHoleGUID;

        bool Enrage;
        bool Summon;

        void EnterCombat(Unit* who)
        {
            if (Summon)
            {
                DoScriptText(SAY_AGGRO, me);
                me->InterruptSpell(CURRENT_CHANNELED_SPELL);
                DoZoneInCombat(who->ToCreature());
            }
            else
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_PASSIVE);
                uiStep = 1;
            }

            if (pInstance)
                pInstance->SetData(BOSS_ALGALON, IN_PROGRESS);
        }

        void KilledUnit(Unit * /*victim*/
/*)
        {
            DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
        }

        void Reset()
        {
            Phase = 1;

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(BOSS_ALGALON, NOT_STARTED);

            BlackHoleGUID = 0;

            uiPhase_timer = 0;
            Ascend_Timer = 480000; //8 minutes
            QuantumStrike_Timer = 4000 + rand()%10000;
            Berserk_Timer = 360000; //6 minutes
            CollapsingStar_Timer = urand(15000, 20000); //Spawns between 15 to 20 seconds
            BigBang_Timer = 90000;
            PhasePunch_Timer = 8000;
            CosmicSmash_Timer = urand(30000, 60000);
            Enrage = false;
        }

        void JumpToNextStep(uint32 uiTimer)
        {
            uiPhase_timer = uiTimer;
            ++uiStep;
        }

        void DespawnCollapsingStar()
        {
            if (m_lCollapsingStarGUIDList.empty())
                return;

            for (std::list<uint64>::const_iterator itr = m_lCollapsingStarGUIDList.begin(); itr != m_lCollapsingStarGUIDList.end(); ++itr)
            {
                if (Creature* pTemp = Unit::GetCreature(*me, *itr))
                {
                    if (pTemp->isAlive())
                        pTemp->DespawnOrUnsummon();
                }
            }
            m_lCollapsingStarGUIDList.clear();
        }

        void JustSummoned(Creature* pSummoned)
        {
            if (pSummoned->GetEntry() == CREATURE_COLLAPSING_STAR)
            {
                Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0);
                if (me->getVictim())
                    pSummoned->AI()->AttackStart(pTarget ? pTarget : me->getVictim());
                m_lCollapsingStarGUIDList.push_back(pSummoned->GetGUID());
            }
        }

        void SummonCollapsingStar(Unit* target)
        {
            DoScriptText(SAY_SUMMON_COLLAPSING_STAR, me);
            me->SummonCreature(CREATURE_COLLAPSING_STAR, target->GetPositionX()+15.0f, target->GetPositionY()+15.0f, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 100000);
            me->SummonCreature(CREATURE_BLACK_HOLE, target->GetPositionX()+15.0f, target->GetPositionY()+15.0f, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 27000);
        }

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            if (Phase == 1 && HealthBelowPct(20))
            {
                Phase = 2;
                DoScriptText(SAY_PHASE_2, me);
            }

            if (HealthBelowPct(2))
            {
                me->SummonGameObject(GAMEOBJECT_GIVE_OF_THE_OBSERVER, 1634.258667f, -295.101166f, 417.321381f, 0, 0, 0, 0, 0, 0);

                // All of them. or random?
                DoScriptText(SAY_DEATH_1, me);
                DoScriptText(SAY_DEATH_2, me);
                DoScriptText(SAY_DEATH_3, me);
                DoScriptText(SAY_DEATH_4, me);
                DoScriptText(SAY_DEATH_5, me);

                me->DisappearAndDie();

                if (pInstance)
                    pInstance->SetData(BOSS_ALGALON, DONE);

                return;
            }

            if (Phase == 1)
            {
                if (!Summon)
                {
                    if (uiPhase_timer <= diff)
                    {
                        switch(uiStep)
                        {
                            case 1:
                                DoScriptText(SAY_SUMMON_1, me);
                                JumpToNextStep(3000);
                                break;
                            case 2:
                                DoScriptText(SAY_SUMMON_2, me);
                                JumpToNextStep(3000);
                                break;
                            case 3:
                                DoScriptText(SAY_SUMMON_3, me);
                                JumpToNextStep(3000);
                                break;
                            case 4:
                                DoScriptText(SAY_ENGADED_FOR_FIRTS_TIME, me);
                                JumpToNextStep(3000);
                                break;
                            case 5:
                                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                me->SetReactState(REACT_AGGRESSIVE);
                                Summon = true;
                                break;
                        }
                    } else uiPhase_timer -= diff;

                    return;
                }

                if (QuantumStrike_Timer <= diff)
                {
                    DoCast(me->getVictim(), RAID_MODE(SPELL_QUANTUM_STRIKE, H_SPELL_QUANTUM_STRIKE), true);

                    QuantumStrike_Timer = urand(4000, 14000);
                } else QuantumStrike_Timer -= diff;

                if (BigBang_Timer <= diff)
                {
                    DoScriptText(RAND(SAY_BIG_BANG_1, SAY_BIG_BANG_2), me);
                    DoCast(me->getVictim(), RAID_MODE(SPELL_BIG_BANG, H_SPELL_BIG_BANG), true);

                    BigBang_Timer = 90000;
                } else BigBang_Timer -= diff;

                if (Ascend_Timer <= diff)
                {
                    DoCast(me->getVictim(), SPELL_ASCEND, true);

                    Ascend_Timer = 480000;
                } else Ascend_Timer -= diff;

                if (PhasePunch_Timer <= diff)
                {
                    DoCast(me->getVictim(), SPELL_PHASE_PUNCH, true);

                    PhasePunch_Timer = 8000;
                } else PhasePunch_Timer -= diff;

                if (CosmicSmash_Timer <= diff)
                {
                    DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0), RAID_MODE(SPELL_COSMIC_SMASH, H_SPELL_COSMIC_SMASH), true);

                    CosmicSmash_Timer = urand(30000, 60000);
                } else CosmicSmash_Timer -= diff;

                if (Berserk_Timer <= diff)
                {
                    DoScriptText(SAY_BERSERK, me);
                    DoCast(me->getVictim(), SPELL_BERSERK, true);

                    Berserk_Timer = 360000;
                } else Berserk_Timer -= diff;

                DoMeleeAttackIfReady();

                EnterEvadeIfOutOfCombatArea(diff);
            }

            if (Phase == 2)
            {
                if (Enrage)
                {
                    if (Ascend_Timer <= diff)
                    {
                        DoCast(me, SPELL_ASCEND);
                        DoScriptText(SAY_BERSERK, me);
                        Ascend_Timer = urand(360000, 365000);
                        Enrage = false;
                    } else Ascend_Timer -= diff;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

};

//Collapsing Star
class mob_collapsing_star : public CreatureScript
{
public:
    mob_collapsing_star() : CreatureScript("mob_collapsing_star") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_collapsing_starAI(pCreature);
    }

    struct mob_collapsing_starAI : public ScriptedAI
    {
        mob_collapsing_starAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 BlackHoleExplosion_Timer;

        void Reset()
        {
            BlackHoleExplosion_Timer = 0;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (BlackHoleExplosion_Timer <= diff)
            {
                me->CastSpell(me, SPELL_BLACK_HOLE_EXPLOSION, false);
                BlackHoleExplosion_Timer = 0;
            } else BlackHoleExplosion_Timer -= diff;
        }
    };

};

void AddSC_boss_algalon()
{
    new boss_algalon();
    new mob_collapsing_star();
}
*/


/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
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

#include "ScriptPCH.h"
#include "ulduar.h"

#define GAMEOBJECT_GIFT_OF_THE_OBSERVER 194821

enum Spells
{
    SPELL_ASCEND                    = 64487,
    SPELL_BIG_BANG                  = 64443,
    H_SPELL_BIG_BANG                = 64584,
	SPELL_BERSERK                   = 47008,
    SPELL_COSMIC_SMASH              = 62301,
    H_SPELL_COSMIC_SMASH            = 64598,
    SPELL_PHASE_PUNCH               = 64412,
    SPELL_QUANTUM_STRIKE            = 64395,
    H_SPELL_QUANTUM_STRIKE          = 64592,
    SPELL_BLACK_HOLE_EXPLOSION      = 64122,
	H_SPELL_BLACK_HOLE_EXPLOSION    = 65108,
    SPELL_ARCANE_BARAGE             = 64599,
    H_SPELL_ARCANE_BARAGE           = 64607,
    SPELL_BLACK_HOLE_PASSIVE        = 46228,
    SPELL_BLACK_HOLE_EFFECT         = 46230,
    SPELL_PHASE_PUNCH_EFFECT        = 64417,
    SPELL_SINGULARITY               = 46238,

    SPELL_BLACK_HOLE_PHASE          = 62168,
    SPELL_BLACK_HOLE_DAMAGE         = 62169,
    SPELL_BLACK_HOLE_SPAWN_VISUAL   = 62003,
    SPELL_SUMMON_BLACK_HOLE         = 62189,

    SPELL_ALGALON_EVENT_CLIMAX      = 64580,
    SPELL_COSMIC_SMASH_EFFECT       = 62311,
    H_SPELL_COSMIC_SMASH_EFFECT     = 64596,
    SPELL_SUMMON_AZEROTH            = 64994,
    SPELL_ALGALON_EVENT_BEAM        = 64367
};

enum Creatures
{
    CREATURE_COLLAPSING_STAR        = 32955,
    CREATURE_BLACK_HOLE             = 32953,
    CREATURE_LIVING_CONSTELLATION   = 33052,
    CREATURE_DARK_MATTER            = 33089,
    CREATURE_UNLEASHED_DARK_MATTER  = 34097,
	CREATURE_AZEROTH				= 34246
};

enum Yells
{
    SAY_AGGRO                                   = -1603000,
    SAY_SLAY_1                                  = -1603001,
    SAY_SLAY_2                                  = -1603002,
    SAY_ENGADED_FOR_FIRTS_TIME                  = -1603003,
    SAY_PHASE_2                                 = -1603004,
    SAY_SUMMON_COLLAPSING_STAR                  = -1603005,
    SAY_DEATH_1                                 = -1603006,
    SAY_DEATH_2                                 = -1603007,
    SAY_DEATH_3                                 = -1603008,
    SAY_DEATH_4                                 = -1603009,
    SAY_DEATH_5                                 = -1603010,
    SAY_BERSERK                                 = -1603011,
    SAY_BIG_BANG_1                              = -1603012,
    SAY_BIG_BANG_2                              = -1603013,
    SAY_TIMER_1                                 = -1603014,
    SAY_TIMER_2                                 = -1603015,
    SAY_TIMER_3                                 = -1603016,
    SAY_SUMMON_1                                = -1603017,
    SAY_SUMMON_2                                = -1603018,
    SAY_SUMMON_3                                = -1603019,
};

struct Locations
{
    float x, y, z;
};


static Locations BlackHolesPos[4]=
{
    {1595.22f, -310.01f, 417.45f},
    {1633.53f, -273.86f, 417.45f},
    {1666.99f, -307.47f, 417.45f},
    {1632.69f, -339.36f, 417.32f}
};

class boss_algalon : public CreatureScript
{
public:
    boss_algalon() : CreatureScript("boss_algalon") { }

    struct boss_algalonAI : public BossAI
    {
        boss_algalonAI(Creature *c) : BossAI(c, BOSS_ALGALON)
        {
			pInstance = (c->GetInstanceScript());
            Summon = false; 
			summondeath = false;
        }

        std::list<uint64> m_lCollapsingStarGUIDList;
        std::list<uint64> m_lLivingConstellationGUIDList;

		InstanceScript* pInstance;
        uint8 uiPhase;
        uint32 uiAscendTimer;
        uint32 uiBigBangTimer;
        uint32 uiCosmicSmashTimer;
        uint32 uiPhasePunchTimer;
        uint32 uiQuantumStrikeTimer;
        uint32 uiCollapsingStarsTimer;
        uint32 uiLivingConstellationsTimer ;
        uint32 uiBlackHolesTimer ;
        uint32 uiPhaseTimer;
        uint32 uiStep;

        bool bHasSpawnedBlackHoles ;
        bool bIsEnraged;
        bool Summon;
		bool summondeath;
		bool hasHit;
        bool hasCastedBigBang;

        void EnterCombat(Unit* who)
        {
			_EnterCombat();
            if (Summon)
            {
				if (pInstance)
					pInstance->HandleGameObject(pInstance->GetData64(DATA_UNIVERSE_GLOBE),true);
                DoZoneInCombat();
            }
            else
            {
				me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                uiStep = 0;
            }
        }

        void KilledUnit(Unit *victim)
        {
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2), me);
        }

        void Reset()
        {
            _Reset();
            uiPhase = 1;

			if (!Summon) // event pas finit
			{
				me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE);
				uiStep = 0;
				me->SetVisible(false);

			}
			if (pInstance)
				pInstance->HandleGameObject(pInstance->GetData64(DATA_UNIVERSE_GLOBE),false);

			uiPhaseTimer = 0;
            uiAscendTimer = 360000;
            uiQuantumStrikeTimer = 4000 + rand()%10000;
            uiCollapsingStarsTimer = 15000;
            uiLivingConstellationsTimer = 30000 ;
            uiBigBangTimer = 90000;
            uiPhasePunchTimer = 15000;
            uiCosmicSmashTimer = urand(30000, 60000);
            bIsEnraged = false;
            bHasSpawnedBlackHoles = false ;
            hasHit = false ;
            DespawnCollapsingStar() ;
            DespawnLivingConstellation() ;
        }

        void DespawnCollapsingStar()
        {
            if (m_lCollapsingStarGUIDList.empty())
                return;

            for (std::list<uint64>::const_iterator itr = m_lCollapsingStarGUIDList.begin(); itr != m_lCollapsingStarGUIDList.end(); ++itr)
            {
                if (Creature* pTemp = Unit::GetCreature(*me, *itr))
                {
                    if (pTemp->isAlive())
                        pTemp->ForcedDespawn();
                }
            }
            m_lCollapsingStarGUIDList.clear();
        }

		void DespawnLivingConstellation()
        {
            if (m_lLivingConstellationGUIDList.empty())
                return;

            for(std::list<uint64>::const_iterator itr = m_lLivingConstellationGUIDList.begin(); itr != m_lLivingConstellationGUIDList.end(); ++itr)
            {
                if (Creature* pTemp = Unit::GetCreature(*me, *itr))
                {
                    if (pTemp->isAlive())
                        pTemp->ForcedDespawn();
                }
            }
            m_lCollapsingStarGUIDList.clear();
        }

        void JustSummoned(Creature* pSummoned)
        {
            if (pSummoned->GetEntry() == CREATURE_COLLAPSING_STAR)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    pSummoned->AI()->AttackStart(pTarget);
                m_lCollapsingStarGUIDList.push_back(pSummoned->GetGUID());
            }
			if (pSummoned->GetEntry() == CREATURE_LIVING_CONSTELLATION)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    pSummoned->AI()->AttackStart(pTarget);
                m_lLivingConstellationGUIDList.push_back(pSummoned->GetGUID());
            }
        }

        void JumpToNextStep(uint32 time)
        {
            uiPhaseTimer = time ;
            uiStep ++ ;
        }

        void SpellHitTarget(Unit* who, const SpellEntry* spell)
        {
            if(spell->Id == RAID_MODE(SPELL_BIG_BANG,H_SPELL_BIG_BANG))
                hasHit = true ;
        }


        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            //if (!UpdateVictim())
            //    return;

			if((CheckWipe()) && (!UpdateVictim()))
				return;

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            if (uiPhase == 1)
            {
                if (!Summon)
                {
                    if (uiPhaseTimer <= diff)
                    {
                        switch(uiStep)
                        {

							case 0:
								me->AddAura(SPELL_ALGALON_EVENT_BEAM,me);
								me->SetVisible(true);
								JumpToNextStep(4000);
								break;
                            case 1:
								me->RemoveAura(SPELL_ALGALON_EVENT_BEAM);
                                DoScriptText(SAY_SUMMON_1, me);
                                JumpToNextStep(6000);
                                break;
                            case 2:
                                DoScriptText(SAY_SUMMON_2, me);
								DoCast(SPELL_SUMMON_AZEROTH);
                                JumpToNextStep(5000);
                                break;
                            case 3:
                                DoScriptText(SAY_SUMMON_3, me);
                                JumpToNextStep(10000);
                                break;
                            case 4:
                                DoScriptText(SAY_ENGADED_FOR_FIRTS_TIME, me);
                                JumpToNextStep(8000);
								if (pInstance)
                                    pInstance->HandleGameObject(pInstance->GetData64(DATA_UNIVERSE_GLOBE),true);
                                break;
                            case 5:
                                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
                                me->SetReactState(REACT_AGGRESSIVE);
                                Summon = true;
								me->FindNearestCreature(CREATURE_AZEROTH,20.0f)->DisappearAndDie();
								DoZoneInCombat();
                                break;
                        }
                    } else uiPhaseTimer -= diff;

                    return;
                }

                if (uiCollapsingStarsTimer <= diff)
                {
                    DoScriptText(SAY_SUMMON_COLLAPSING_STAR, me);
                    for (uint8 i = 0 ; i < 4 ; i++)
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                me->SummonCreature(CREATURE_COLLAPSING_STAR,target->GetPositionX()+15.0f,target->GetPositionY()+15.0f,target->GetPositionZ(),0, TEMPSUMMON_TIMED_DESPAWN, 100000);
                    }
                    uiCollapsingStarsTimer = 90000 ;
                } else uiCollapsingStarsTimer -= diff ;

                if (uiLivingConstellationsTimer <= diff)
                {
                    for (uint8 i = 0 ; i < 3 ; i++)
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                me->SummonCreature(CREATURE_LIVING_CONSTELLATION,target->GetPositionX()+15.0f,target->GetPositionY()+15.0f,target->GetPositionZ(),0, TEMPSUMMON_TIMED_DESPAWN, 100000);
                    }
                    uiLivingConstellationsTimer = 90000 ;
                } else uiLivingConstellationsTimer -= diff ;

                if (HealthBelowPct(20))
                {
                    uiPhase = 2;
                    uiBlackHolesTimer = 5000 ;
                    DespawnCollapsingStar();
                    DespawnLivingConstellation();
                    DoScriptText(SAY_PHASE_2, me);
                }
            }
            if (uiPhase == 2)
            {
                if(!bHasSpawnedBlackHoles)
                {
                    if (uiBlackHolesTimer <= diff)
                    {
                        for (uint8 i = 0 ; i < 4 ; i++)
                        {
                            if(Creature* blackHole = me->SummonCreature(CREATURE_BLACK_HOLE,BlackHolesPos[i].x, BlackHolesPos[i].y, BlackHolesPos[i].z, 0, TEMPSUMMON_TIMED_DESPAWN, 100000))
                                blackHole->AI()->SetData(DATA_PHASE, uiPhase) ;
                            bHasSpawnedBlackHoles = true ;
                        }
                        uiBlackHolesTimer = 100000 ;
                    } else uiBlackHolesTimer -= diff ;
                }

                if (HealthBelowPct(2))
                {
					if(!summondeath)
					{
						me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
						me->RemoveAllAuras();
						me->AttackStop();
						me->SetReactState(REACT_PASSIVE);
						summondeath = true ;
						uiStep = 1;
					}
                }

                if (summondeath)
                {
                    if (uiPhaseTimer <= diff)
                    {
                        switch(uiStep)
                        {
                            case 1:
                                DoScriptText(SAY_DEATH_1, me);
                                JumpToNextStep(3000);
                                break;
                            case 2:
                                DoScriptText(SAY_DEATH_2, me);
                                JumpToNextStep(3000);
                                break;
                            case 3:
                                DoScriptText(SAY_DEATH_3, me);
                                JumpToNextStep(3000);
                                break;
                            case 4:
                                DoScriptText(SAY_DEATH_4, me);
                                JumpToNextStep(3000);
                                break;
                            case 5:
                                DoScriptText(SAY_DEATH_5, me);
                                JumpToNextStep(3000);
                                break;
                            case 6:
                                me->SummonGameObject(GAMEOBJECT_GIFT_OF_THE_OBSERVER, 1634.258667f, -295.101166f, 417.321381f,0,0,0,0,0,-10);
                                me->DisappearAndDie() ;
                                _JustDied();
                                break;
                        }
                    } else uiPhaseTimer -= diff;

                    return;
                }
            }

            if (!hasCastedBigBang)
            {
                if (uiBigBangTimer <= diff)
                {
                    DoScriptText(RAND(SAY_BIG_BANG_1,SAY_BIG_BANG_2), me);
                    DoCast(me, RAID_MODE(SPELL_BIG_BANG,H_SPELL_BIG_BANG));
                    hasCastedBigBang = true ;
                    uiBigBangTimer = 4000;
                } else uiBigBangTimer -= diff;
            }
            else
            {
                if (uiBigBangTimer <= diff)
                {
                    if(hasHit)
                        uiAscendTimer = 5000 ;
					else 
					{
						DoCast(me,SPELL_BERSERK );
						uiAscendTimer = 5000 ;
					}

                    hasHit = false ;
                    hasCastedBigBang = false ;
                    uiBigBangTimer = 81000;
                } else uiBigBangTimer -= diff;
            }


            if (uiQuantumStrikeTimer <= diff)
            {
                DoCast(me->getVictim(), RAID_MODE(SPELL_QUANTUM_STRIKE,H_SPELL_QUANTUM_STRIKE));

                uiQuantumStrikeTimer = urand(4000, 14000);
            } else uiQuantumStrikeTimer -= diff;

            if (uiPhasePunchTimer <= diff)
            {
                DoCast(me->getVictim(),SPELL_PHASE_PUNCH);
                if(me->getVictim())
                    if(Aura* phasePunch = me->getVictim()->GetAura(SPELL_PHASE_PUNCH))
                    {
                        if(phasePunch->GetStackAmount() == 5)
                        {
                            me->AddAura(SPELL_PHASE_PUNCH_EFFECT, me->getVictim());
                            me->getVictim()->RemoveAurasDueToSpell(SPELL_PHASE_PUNCH) ;
                        }
                    }
                uiPhasePunchTimer = 15000;
            } else uiPhasePunchTimer -= diff;

            if (uiCosmicSmashTimer <= diff)
            {
                if (pInstance)
                {
                    for (uint8 i = 0 ; i < RAID_MODE(1, 3) ; i++)
                    {
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            DoCast(pTarget, RAID_MODE(SPELL_COSMIC_SMASH, H_SPELL_COSMIC_SMASH));
                    }
                }
                uiCosmicSmashTimer = 25000;
            } else uiCosmicSmashTimer -= diff;

            if (uiAscendTimer  <= diff)
            {
                DoCast(me, SPELL_ASCEND);
                if(pInstance)
                {
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BLACK_HOLE_DAMAGE);
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BLACK_HOLE_PHASE);
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_PHASE_PUNCH_EFFECT);
                }
                DoScriptText(SAY_BERSERK, me);
                uiAscendTimer = urand(360000,365000);
            } else uiAscendTimer -= diff;

            // Don't attack current target if he's not visible for us.
            if(me->getVictim() && me->getVictim()->GetPhaseMask() != 1)
                me->getThreatManager().modifyThreatPercent(me->getVictim(),0);

            DoMeleeAttackIfReady();

			//EnterEvadeIfOutOfCombatArea(diff);
        }

		 bool CheckWipe()
        {

            if (pInstance)
            {
                if (Map* pMap = me->GetMap())
                {
                    Map::PlayerList const &players = pMap->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    {
                        Player* pPlayer = itr->getSource();
                        if (!pPlayer)
							return true;

                        if (pPlayer->isGameMaster())
							 continue;

						if (!pPlayer->IsInRange(me,0.1f,50.0f))
							continue;

                        if (pPlayer->isAlive())
                            return false;
                    }
                }
            }
            return true;
        }

    };

	CreatureAI* GetAI(Creature* pCreature) const    
    {
        return new boss_algalonAI(pCreature);
    }
};

class mob_collapsing_star : public CreatureScript
{
public:
    mob_collapsing_star() : CreatureScript("mob_collapsing_star") { }

    struct mob_collapsing_starAI : public ScriptedAI
    {
        mob_collapsing_starAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 healthPercent ;
        uint32 uiHealthLostTimer ;
		uint32 uitargettimer ;
		uint32 uidisappear ;

        void Reset()
        {
            healthPercent = me->GetMaxHealth()/100 ;
            uiHealthLostTimer = 1000 ;
			uitargettimer = 5000 ;
		
        }

        void JustDied(Unit* who)
        {
            me->CastSpell(me, RAID_MODE(SPELL_BLACK_HOLE_EXPLOSION, H_SPELL_BLACK_HOLE_EXPLOSION), true);
            if(Creature* blackHole = me->SummonCreature(CREATURE_BLACK_HOLE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(),0, TEMPSUMMON_TIMED_DESPAWN, 27000))
                blackHole->AI()->SetData(DATA_PHASE, 1) ;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;
			
			if (uitargettimer <= diff)
			{
				// Don't attack current target if he's not visible for us & switch all 5s
				Unit *pVictim = SelectTarget(SELECT_TARGET_RANDOM, 0);
				if (!pVictim)
					return;
				else if (pVictim->GetPhaseMask() != 1)
						me->getThreatManager().modifyThreatPercent(pVictim, -100);
				uitargettimer = 3000;
			}else uitargettimer -= diff;



            if (uiHealthLostTimer <= diff)
            {
                if (me->GetHealth() > healthPercent)
                    me->SetHealth(me->GetHealth()-healthPercent);
                else 
				{
                    me->DealDamage(me, (me->GetHealth()-1));
					me->AI()->JustDied(me);
				}
				if (me->GetHealth() == 1)
					uidisappear = 0;
				
				uiHealthLostTimer = 1000 ;

            } else uiHealthLostTimer -= diff ;

			if ((uidisappear <= diff) && (me->GetHealth() < healthPercent))
			{
				me->DisappearAndDie(); //tempo le temps d appliquer le just died puis despawn
				uidisappear = 3600*7*24*1000;
			}
			else uidisappear -= diff;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const    
    {
        return new mob_collapsing_starAI(pCreature);
    }
};

class mob_black_hole : public CreatureScript
{
public:
    mob_black_hole() : CreatureScript("mob_black_hole") { }

    struct mob_black_holeAI : public ScriptedAI
    {
        mob_black_holeAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint8 uiPhase ;
        uint32 uiDarkMatterSpawnTimer ;
		uint32 uicastsingularitytimer ;
		uint32 uitransferttimer ;
        void SetData(uint32 id, uint32 value)
        {
            if (id == DATA_PHASE)
            {
                uiPhase = value ;
                if(uiPhase == 2)
                    uiDarkMatterSpawnTimer = 30000 ;
            }
        }

        void SpellHitTarget(Unit* target, const SpellEntry* spell)
        {
            if (spell->Id == SPELL_SINGULARITY)
            {
                if(target && target->GetTypeId() == TYPEID_PLAYER)
                {
                    me->AddAura(SPELL_BLACK_HOLE_PHASE, target) ;
                    me->AddAura(SPELL_BLACK_HOLE_DAMAGE, target) ;
                }
            }
        }


		void selectTargettotransfer()
		{
			if (Map* pMap = me->GetMap())
            {
                Map::PlayerList const &players = pMap->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                {
                    Player* pPlayer = itr->getSource();
                    if (!pPlayer)
                            continue;

                    if (pPlayer->isGameMaster())
                            continue;

                                        
					if(me->IsInRange(pPlayer,0.1f,5.0f) && pPlayer->GetPhaseMask() != 16)
					{
						me->AddAura(SPELL_BLACK_HOLE_DAMAGE,pPlayer);
						me->AddAura(SPELL_BLACK_HOLE_PHASE,pPlayer);
						if(Aura* aur = pPlayer->GetAura(SPELL_BLACK_HOLE_DAMAGE))
							aur->SetDuration(5*60*1000);
						if(Aura* aur = pPlayer->GetAura(SPELL_BLACK_HOLE_PHASE))
							aur->SetDuration(5*60*1000);
					}

				}

			}
		}


        void Reset()
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
            DoCast(SPELL_BLACK_HOLE_SPAWN_VISUAL) ;
            DoCast(SPELL_BLACK_HOLE_PASSIVE) ;
            uiDarkMatterSpawnTimer = urand(1000, 4000) ;
            me->SetReactState(REACT_PASSIVE);
			uitransferttimer = 1000;
        }

        void UpdateAI(const uint32 diff)
        {
            if (uiDarkMatterSpawnTimer <= diff)
            {
                if(uiPhase == 2)
                {
                    if(Creature* darkMatter = me->SummonCreature(CREATURE_UNLEASHED_DARK_MATTER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000))
                        darkMatter->SetInCombatWithZone() ;
                }
                if(Creature* darkMatter = me->SummonCreature(CREATURE_DARK_MATTER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000))
                {
                    darkMatter->SetPhaseMask(16, true) ;
                    darkMatter->SetInCombatWithZone() ;
                }
                uiDarkMatterSpawnTimer = 30000 ;
            } else uiDarkMatterSpawnTimer -= diff ;

			if (uitransferttimer <= diff)
			{
				selectTargettotransfer();
				uitransferttimer = 1000;
			}
			else uitransferttimer -= diff;

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const    
    {
        return new mob_black_holeAI(pCreature);
    }
};

class mob_living_constellation : public CreatureScript
{
public:
    mob_living_constellation() : CreatureScript("mob_living_constellation") { }

    struct mob_living_constellationAI : public ScriptedAI
    {
        mob_living_constellationAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
        }

        uint32 uiArcaneBarrageTimer ;

        void Reset()
        {
            uiArcaneBarrageTimer = urand(5000, 8000) ;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            // Don't attack current target if he's not visible for us.
            if(me->getVictim() && me->getVictim()->GetPhaseMask() != 1)
                me->getThreatManager().modifyThreatPercent(me->getVictim(), -100);

            if (uiArcaneBarrageTimer <= diff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(pTarget, RAID_MODE(SPELL_ARCANE_BARAGE, H_SPELL_ARCANE_BARAGE)) ;
                uiArcaneBarrageTimer = urand(9000, 12000) ;
            } else uiArcaneBarrageTimer -= diff ;

            if (Creature* blackHole = me->FindNearestCreature(CREATURE_BLACK_HOLE, 5.0f))
            {
                me->DisappearAndDie() ;
                blackHole->ForcedDespawn() ;
            }
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const    
    {
        return new mob_living_constellationAI(pCreature);
    }
};

class mob_algalon_stalker_asteroid_target : public CreatureScript
{
public:
    mob_algalon_stalker_asteroid_target() : CreatureScript("mob_algalon_stalker_asteroid_target") { }

    struct mob_algalon_stalker_asteroid_targetAI : public Scripted_NoMovementAI
    {
        mob_algalon_stalker_asteroid_targetAI(Creature *pCreature) : Scripted_NoMovementAI(pCreature)
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_AGGRESSIVE);
            SetCombatMovement(false);
        }

        uint32 uiCosmicSmashTimer ;

        void Reset()
        {
            uiCosmicSmashTimer = 6000 ;
        }

        void UpdateAI(const uint32 diff)
        {
            if (uiCosmicSmashTimer <= diff)
            {
                Unit *pTarget = NULL;
                uint32 damage ;
				if (Map* pMap = me->GetMap())
				{
					Map::PlayerList const &players = pMap->GetPlayers();
					for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
					{
						Player* pTarget = itr->getSource();
						if (!pTarget)
							continue;

						if (pTarget->GetPhaseMask() != 1)
							continue;

						if(me->GetDistance2d(pTarget) <= 1.0f)
							damage = RAID_MODE(43000, 55000) ;
						else
							damage = RAID_MODE(float(43000)/me->GetDistance2d(pTarget), float(55000)/me->GetDistance2d(pTarget)) ;
						me->SendSpellNonMeleeDamageLog(pTarget,RAID_MODE(SPELL_COSMIC_SMASH_EFFECT, H_SPELL_COSMIC_SMASH_EFFECT),damage,SPELL_SCHOOL_MASK_FIRE,0,0,false,0,false);
						me->DealDamage(pTarget, damage, 0, SPELL_DIRECT_DAMAGE, SPELL_SCHOOL_MASK_FIRE);
					}
				}
                me->DisappearAndDie();
            } else uiCosmicSmashTimer -= diff ;

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const    
    {
        return new mob_algalon_stalker_asteroid_targetAI(pCreature);
    }
};

enum eAccess
{
    ITEM_CELESTIAL_PLANETARIUM_KEY             = 45796,
    ITEM_HEROIC_CELESTIAL_PLANETARIUM_KEY      = 45798,
};

class go_celestial_planetarium_access : public GameObjectScript
{
public:
    go_celestial_planetarium_access() : GameObjectScript("go_celestial_planetarium_access") { }

    bool OnGossipHello(Player* pPlayer, GameObject* pGo)
    {
        InstanceScript* pInstance = pGo->GetInstanceScript();
        if (!pInstance)
            return false;
        switch(pGo->GetEntry())
        {
            case 194628:
                if (pPlayer->HasItemCount(ITEM_CELESTIAL_PLANETARIUM_KEY, 1))
				{
                    pInstance->SetData(BOSS_ALGALON, TO_BE_DECIDED);
				}
                break;
            case 194752:
                if (pPlayer->HasItemCount(ITEM_HEROIC_CELESTIAL_PLANETARIUM_KEY, 1))
                    pInstance->SetData(BOSS_ALGALON, TO_BE_DECIDED);
                break;
        }

        return true;
    }
};

class spell_algalon_event_beam: public SpellScriptLoader
{
    public:
        spell_algalon_event_beam() : SpellScriptLoader("spell_algalon_event_beam") { }

        class spell_algalon_event_beam_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_algalon_event_beam_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, /*AuraApplication const* aurApp,*/ AuraEffectHandleModes /*mode*/)
            {
				SetMaxDuration(5000);
            }

			void OnRemove(AuraEffect const* /*aurEff*/,/* AuraApplication const* aurApp,*/ AuraEffectHandleModes /*mode*/)
            {

			}

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_algalon_event_beam_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_algalon_event_beam_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }

        };

        AuraScript* GetAuraScript() const
        {
            return new spell_algalon_event_beam_AuraScript();
        }
};

void AddSC_boss_algalon()
{
    new boss_algalon();
    new mob_collapsing_star();
	new mob_black_hole();
    new mob_living_constellation();
    new mob_algalon_stalker_asteroid_target();
    new go_celestial_planetarium_access();
	new spell_algalon_event_beam();
}
