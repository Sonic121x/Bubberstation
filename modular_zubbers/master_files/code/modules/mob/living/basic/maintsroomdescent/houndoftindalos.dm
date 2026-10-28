///this could cause serious trouble if this thing ever got station side, thankfully i dont think we have anybody psychotic or stupid enough to try something like that.
/mob/living/basic/mining/legion/houndoftindalos
	name = "廷达罗斯猎犬"
	desc = "它看起来隐约像条狗——如果那条狗被塞进碎木机，剩下的部分被做成细丝，再勉强拼回狗的轮廓，还带着彩虹般的颜色。"
	icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	icon_state = "legion" ///these are just placeholder sprites until i can get a real sprite made or ported from CDDA
	icon_living = "legion"
	icon_dead = "legion"
	icon_gib = "syndicate_gib"
	basic_mob_flags = DEL_ON_DEATH
	speed = 6
	maxHealth = 5
	health = 5
	obj_damage = 50
	melee_damage_lower = 50
	melee_damage_upper = 50
	faction = list(FACTION_NETHER)
	attack_verb_continuous = "猛抽向"
	attack_verb_simple = "猛抽"
	death_message = "它扭曲了片刻，随即向内折叠——让别的东西从中钻了出来。"
	brood_type = /mob/living/basic/creature
	corpse_type = /mob/living/basic/migo
	ai_controller = /datum/ai_controller/basic_controller/legion/houndoftindalos

/datum/ai_controller/basic_controller/legion/houndoftindalos
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_AGGRO_RANGE = 5,
		BB_BASIC_MOB_FLEE_DISTANCE = 6,
	)
