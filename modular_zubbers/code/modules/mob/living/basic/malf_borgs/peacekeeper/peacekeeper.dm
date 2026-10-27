/mob/living/basic/malf_borg/peace
	name = "故障维和半机械人"
	desc = "一台半机械人单位，遭到入侵或发生故障。这是维和型号。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	icon_state = "evilbotpeace"
	icon_living = "evilbotpeace"
	icon_dead = "evilbotpeace"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 90
	maxHealth = 90

	melee_damage_type = BRUTE
	wound_bonus = CANT_WOUND
	exposed_wound_bonus = 0
	sharpness = NONE

	attack_verb_continuous = "用力拍打"
	attack_verb_simple = "拍打"
	attack_sound = 'sound/items/weapons/cqchit1.ogg'

/mob/living/basic/malf_borg/peace/Initialize(mapload)
	. = ..()
