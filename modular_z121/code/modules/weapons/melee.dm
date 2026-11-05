/obj/item/claymore/shishkebab
	name = "烤肉串火焰剑"
	desc = "一把略显钝拙的简易长剑，拨动开关便能喷出灼热的不公。"
	icon = 'modular_z121/icons/weapons/melee.dmi'
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	worn_icon_state = "empty_placeholder"
	icon_state = "shishkebab_off"
	inhand_icon_state = "shishkebab_off"
	worn_icon_state = "shishkebab"
	pickup_sound = 'modular_z121/sound/weapons/meleesounds/blade_pickup2.ogg'
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	wound_bonus = 5
	throwforce = 10
	exposed_wound_bonus = 5
	armour_penetration = 25
	toolspeed = 2
	var/on = FALSE

/obj/item/claymore/shishkebab/attack_self(mob/user)
	on = !on
	icon_state = "shishkebab_[on ? "on" : "off"]"
	inhand_icon_state = "shishkebab_[on ? "on" : "off"]"

	if(on)
		attack_verb_continuous = list("烧灼", "焊接", "烙烫", "熔化", "烧焦")
		attack_verb_simple = list("烧灼", "焊接", "烙烫", "熔化", "烧焦")
		to_chat(user, span_notice("你打开阀门并按下点火器，[src]开始喷出火焰。"))
		hitsound = 'modular_z121/sound/weapons/meleesounds/burn_sword.ogg'
		damtype = BURN
		force = 30

	else
		attack_verb_continuous = list("刺击", "切割", "劈砍", "割伤", "撕裂")
		attack_verb_simple = list("刺击", "切割", "劈砍", "割伤", "撕裂")
		to_chat(user, span_notice("你关上[src]的阀门，火焰随之熄灭。"))
		hitsound = 'modular_z121/sound/weapons/meleesounds/blade_hit1.ogg'
		damtype = BRUTE
		force = 20
