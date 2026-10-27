/mob/living/basic/malf_borg/sec
	name = "故障安保半机械人"
	desc = "一台安保半机械人单位，遭到入侵或发生故障。它身上装着两把枪。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_skirmisher

	icon_state = "evilbotsec"
	icon_living = "evilbotsec"
	icon_dead = "evilbotsec"

	exposed_wound_bonus = 0
	sharpness = NONE

	attack_verb_continuous = "用枪托砸"
	attack_verb_simple = "用枪托砸"
	attack_sound = 'sound/items/weapons/smash.ogg'

	projectiletype = /obj/projectile/bullet/c45
	projectilesound = 'sound/items/weapons/gun/smg/shot.ogg'

/mob/living/basic/malf_borg/sec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ranged_attacks, projectile_type = projectiletype, projectile_sound = projectilesound)
	ADD_TRAIT(src, TRAIT_SUBTREE_REQUIRED_OPERATIONAL_DATUM, /datum/component/ranged_attacks)
