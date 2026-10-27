/obj/item/melee/tomahawk
	name = "远征战斧"
	desc = "斧刃略显钝拙，装在短纤维金属柄上。"
	icon = 'modular_skyrat/modules/exp_corps/icons/tomahawk.dmi'
	icon_state = "tomahawk"
	inhand_icon_state = "tomahawk"
	lefthand_file = 'modular_skyrat/modules/exp_corps/icons/tomahawk_l.dmi'
	righthand_file = 'modular_skyrat/modules/exp_corps/icons/tomahawk_r.dmi'
	worn_icon = 'modular_skyrat/modules/exp_corps/icons/tomahawk_worn.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 15 //Equivalent to a survival knife
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 18
	throw_speed = 4
	throw_range = 8
	embed_type = /datum/embedding/tomahawk
	attack_verb_continuous = list("劈砍", "撕裂", "割裂", "切砍")
	attack_verb_simple = list("劈砍", "撕裂", "割裂", "切砍")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/datum/embedding/tomahawk
	pain_mult = 6
	embed_chance = 60
	fall_chance = 10

/obj/item/melee/tomahawk/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, 70, 100)
