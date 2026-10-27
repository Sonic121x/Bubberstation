/mob/living/basic/malf_borg/protect
	name = "故障标准机器人"
	desc = "一台民用型号机器人，遭到入侵或发生故障，装有机械爪臂。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	icon_state = "protectbot"
	icon_living = "protectbot"
	icon_dead = "protectbot"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 100
	maxHealth = 100

	melee_damage_type = BRUTE
	wound_bonus = 5
	exposed_wound_bonus = 2
	sharpness = SHARP_POINTY

	attack_verb_continuous = "挥爪劈砍"
	attack_verb_simple = "猛揍"
	attack_sound = 'sound/items/weapons/genhit2.ogg'

/mob/living/basic/malf_borg/protect/Initialize(mapload)
	. = ..()
