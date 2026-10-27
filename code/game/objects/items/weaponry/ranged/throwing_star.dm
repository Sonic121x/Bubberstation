/obj/item/throwing_star
	name = "手里剑"
	desc = "一种古老的武器，至今仍在使用，因为它很容易扎进受害者的身体里。"
	icon = 'icons/obj/weapons/thrown.dmi'
	icon_state = "throwingstar"
	inhand_icon_state = "eshield"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	force = 2
	throwforce = 10 //10 + 2 (WEIGHT_CLASS_SMALL) * 4 (EMBEDDED_IMPACT_PAIN_MULTIPLIER) = 18 damage on hit due to guaranteed embedding
	throw_speed = 4
	embed_type = /datum/embedding/throwing_star
	armour_penetration = 40
	mob_throw_hit_sound = 'sound/items/weapons/pierce.ogg'
	hitsound = 'sound/items/weapons/bladeslice.ogg'

	w_class = WEIGHT_CLASS_SMALL
	sharpness = SHARP_POINTY
	custom_materials = list(/datum/material/iron= SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass= SMALL_MATERIAL_AMOUNT * 5)
	resistance_flags = FIRE_PROOF

/datum/embedding/throwing_star
	pain_mult = 4
	embed_chance = 100
	fall_chance = 0

/obj/item/throwing_star/stamina
	name = "电击手里剑"
	desc = "一种符合空气动力学的圆盘，扎进逃跑目标的体内时会造成剧烈疼痛，但愿不会造成致命伤害。"
	throwforce = 5
	embed_type = /datum/embedding/throwing_star/stamina

/datum/embedding/throwing_star/stamina
	pain_mult = 5
	jostle_chance = 10
	pain_stam_pct = 0.8
	jostle_pain_mult = 3

/obj/item/throwing_star/toy
	name = "玩具手里剑"
	desc = "一种缠有粘胶、可以粘在别人身上的空气动力学圆盘，很适合搞恶作剧，也很适合让你被安保打死。"
	sharpness = NONE
	force = 0
	throwforce = 0
	embed_type = /datum/embedding/throwing_star/toy

/datum/embedding/throwing_star/toy
	pain_mult = 0
	jostle_pain_mult = 0

//Ninja throwing stars are located in the ninja mod modules
