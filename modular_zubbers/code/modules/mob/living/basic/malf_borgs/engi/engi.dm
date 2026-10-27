/mob/living/basic/malf_borg/engi
	name = "故障工程半机械人"
	desc = "一台工程半机械人单位，遭到入侵或发生故障——我靠，那是一根等离子棒。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	icon_state = "evilbotengi"
	icon_living = "evilbotengi"
	icon_dead = "evilbotengi"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 100
	maxHealth = 100

	melee_damage_type = BURN
	wound_bonus = CANT_WOUND
	exposed_wound_bonus = 0
	sharpness = NONE

	attack_verb_continuous = "用电焊灼烧"
	attack_verb_simple = "用电焊烧"
	attack_sound = 'sound/items/tools/welder.ogg'

/mob/living/basic/malf_borg/engi/Initialize(mapload)
	. = ..()
