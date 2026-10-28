/mob/living/basic/malf_borg/dog
	name = "故障犬型半机械人"
	desc = "一台犬型半机械人，遭到入侵或发生故障。这一台似乎是采矿型号。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs64x32.dmi'

	icon_state = "evilbotmine"
	icon_living = "evilbotmine"
	icon_dead = "evilbotmine"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 115
	maxHealth = 115

	speed = 1.3

	melee_damage_type = BRUTE
	wound_bonus = 10
	exposed_wound_bonus = 5
	sharpness = SHARP_EDGED

	attack_verb_continuous = "劈砍"
	attack_verb_simple = "猛砸"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'

/mob/living/basic/malf_borg/dog/Initialize(mapload)
	. = ..()

/mob/living/basic/malf_borg/dogstrong
	name = "腐化猎犬"
	desc = "一台犬型半机械人，遭到入侵或发生故障。这一台体型巨大、气势逼人，出手极重。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs64x32.dmi'

	icon_state = "evilbotelite"
	icon_living = "evilbotelite"
	icon_dead = "evilbotelite"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 130
	maxHealth = 130

	speed = 1.15

	melee_damage_type = BRUTE
	wound_bonus = 15
	exposed_wound_bonus = 8
	sharpness = SHARP_POINTY

	attack_verb_continuous = "啃咬"
	attack_verb_simple = "啃咬"
	attack_sound = 'sound/items/weapons/bite.ogg'

/mob/living/basic/malf_borg/dogstrong/Initialize(mapload)
	. = ..()
