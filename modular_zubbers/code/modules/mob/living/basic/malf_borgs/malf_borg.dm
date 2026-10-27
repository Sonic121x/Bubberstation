/mob/living/basic/malf_borg
	name = "故障半机械人"
	desc = "一台小型半机械人单位，遭到入侵或发生故障。它很可能具有敌意。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_skirmisher

	icon_state = "evilbotold"
	icon_living = "evilbotold"

	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC
	faction = list(FACTION_HOSTILE)
	combat_mode = TRUE

	health = 75
	maxHealth = 75

	speed = 1
	melee_damage_lower = 5
	melee_damage_upper = 10
	obj_damage = 15
	armour_penetration = 10
	melee_damage_type = BRUTE
	wound_bonus = CANT_WOUND
	sharpness = SHARP_EDGED

	melee_attack_cooldown = 2 SECONDS

	attack_verb_continuous = "挥爪劈砍"
	attack_verb_simple = "挥爪"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	attacked_sound = SFX_PUNCH

	///The type of projectile that fires from attacks.
	var/projectiletype = /obj/projectile/hivebotbullet
	///The sound that plays when the projectile is fired.
	var/projectilesound = 'sound/items/weapons/gun/pistol/shot.ogg'

	verb_say = "陈述道"
	verb_ask = "询问道"
	verb_exclaim = "宣告道"
	verb_yell = "发出警报"
	bubble_icon = "machine"
	speech_span = SPAN_ROBOT

	habitable_atmos = null
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY

	damage_coeff = list(
		BRUTE = 1,
		BURN = 1,
		TOX = 0,
		OXY = 0,
		STAMINA = 1
	)

	guaranteed_butcher_results = list(
		/obj/effect/decal/cleanable/blood/gibs/robot_debris = 1
	)

/mob/living/basic/malf_borg/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ranged_attacks, projectile_type = projectiletype, projectile_sound = projectilesound)

/mob/living/basic/malf_borg/death(gibbed)
	do_sparks(number = 3, cardinal_only = TRUE, source = src)
	return ..()
