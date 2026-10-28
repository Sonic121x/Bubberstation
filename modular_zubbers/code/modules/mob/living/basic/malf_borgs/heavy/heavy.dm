/mob/living/basic/malf_borg/heavy
	name = "故障重型半机械人"
	desc = "一台大型半机械人单位，遭到入侵或发生故障。它——我的天，那是电锯吗？！"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	icon_state = "evilbotheavy"
	icon_living = "evilbotheavy"
	icon_dead = "evilbotheavy"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 125
	maxHealth = 125

	speed = 0.85

	melee_damage_type = BRUTE
	wound_bonus = 25
	exposed_wound_bonus = 15
	sharpness = SHARP_EDGED

	attack_verb_continuous = "用电锯锯切"
	attack_verb_simple = "用电锯锯"
	attack_sound = 'sound/items/weapons/chainsawhit.ogg'

/mob/living/basic/malf_borg/heavy/Initialize(mapload)
	. = ..()
