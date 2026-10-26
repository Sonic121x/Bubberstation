/obj/item/crowbar/freeman
	name = "浸血撬棍"
	desc = "一根沉重得有些粗暴的撬棍，还在滴着血。"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/freeman.dmi'
	icon_state = "crowbar"
	force = 35
	throwforce = 45
	toolspeed = 0.1
	wound_bonus = 10
	hitsound = 'modular_skyrat/master_files/sound/weapons/crowbar2.ogg'
	mob_throw_hit_sound = 'modular_skyrat/master_files/sound/weapons/crowbar2.ogg'
	force_opens = TRUE

/obj/item/crowbar/freeman/ultimate
	name = "\improper 弗里曼的撬棍"
	desc = "一位古老物理学家所持的武器，数百人的鲜血从这根充满铁与恶意的铁杆中渗出。"
	force = 45

/obj/item/crowbar/freeman/ultimate/Initialize(mapload)
	. = ..()
	add_filter("rad_glow", 2, list("type" = "outline", "color" = "#fbff1479", "size" = 2))

/obj/item/shield/riot/pointman/hecu
	name = "防弹盾"
	desc = "适合那些想一头冲进未知的人！笨重得要命。可用铁修复。"
	icon_state = "ballistic"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/ballistic.dmi'
	worn_icon_state = "ballistic_worn"
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/ballistic.dmi'
	inhand_icon_state = "ballistic"
	lefthand_file = 'modular_skyrat/modules/awaymissions_skyrat/icons/ballistic_l.dmi'
	righthand_file = 'modular_skyrat/modules/awaymissions_skyrat/icons/ballistic_r.dmi'
	force = 14
	throwforce = 5
	throw_speed = 1
	throw_range = 1
	block_chance = 45
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("推撞", "猛击")
	attack_verb_simple = list("推撞", "猛击")
	transparent = TRUE
	max_integrity = 150
	repairable_by = /obj/item/stack/sheet/iron //what to repair the shield with
	shield_break_leftover = /obj/item/ballistic_broken

/obj/item/ballistic_broken
	name = "破损的防弹盾"
	desc = "一堆无法挽救、无法回收的装甲钢与凯夫拉残骸。你早该好好保养它的，对吧？"
	icon_state = "ballistic_broken"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/ballistic.dmi'
	w_class = WEIGHT_CLASS_BULKY
