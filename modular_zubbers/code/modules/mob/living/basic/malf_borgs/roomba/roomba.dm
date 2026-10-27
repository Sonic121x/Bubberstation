/mob/living/basic/malf_borg/roomba
	name = "故障 Roomba 半机械人"
	desc = "一台 Roomba 扫地机器人，遭到入侵或发生故障——哎哟我的脚！"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	icon_state = "evilbotroomba"
	icon_living = "evilbotroomba"
	icon_dead = "evilbotroomba"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 80
	maxHealth = 80

	speed = 1.2

	melee_damage_type = BRUTE
	wound_bonus = 6
	exposed_wound_bonus = 3
	sharpness = SHARP_POINTY

	attack_verb_continuous = "戳刺"
	attack_verb_simple = "刺"
	attack_sound = 'sound/items/weapons/genhit2.ogg'

/mob/living/basic/malf_borg/roomba/Initialize(mapload)
	. = ..()
