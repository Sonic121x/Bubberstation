// Semi-automatic rifle firing .310 with reduced damage compared to a Sakhno

/obj/item/gun/ballistic/automatic/lanca
	name = "\improper 骑枪战斗步枪"
	desc = "一款相对紧凑的长枪管无托战斗步枪，使用.310飞箭弹。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "lanca"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	worn_icon_state = "lanca"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "lanca"
	greyscale_config = /datum/greyscale_config/szot_dynamica_48
	greyscale_config_worn = /datum/greyscale_config/szot_dynamica_worn
	greyscale_config_inhand_left = /datum/greyscale_config/szot_dynamica_lefthand
	greyscale_config_inhand_right = /datum/greyscale_config/szot_dynamica_righthand
	greyscale_colors = "#83825E#CD445B"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_STANDARD

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	accepted_magazine_type = /obj/item/ammo_box/magazine/lanca

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/battle_rifle.ogg'
	suppressed_sound = 'modular_skyrat/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 0
	suppressor_y_offset = 0

	burst_size = 1
	fire_delay = 1 SECONDS
	actions_types = list()

	recoil = 0.5
	spread = 2.5
	projectile_wound_bonus = -20

/obj/item/gun/ballistic/automatic/lanca/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/// Shows which magazine is actually fitted rather than one generic block
/obj/item/gun/ballistic/automatic/lanca/update_overlays()
	. = ..()
	if(!magazine || internal_magazine || !mag_display)
		return
	if(istype(magazine, /obj/item/ammo_box/magazine/lanca/extended))
		. -= "[icon_state]_mag"
		. += "[icon_state]_mag_extended"

/obj/item/gun/ballistic/automatic/lanca/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.25)
	AddElement(/datum/element/gags_recolorable)

/obj/item/gun/ballistic/automatic/lanca/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/lanca/examine_more(mob/user)
	. = ..()

	. += "骑枪如今也已相对过时，当年却是卡拉什尼科夫式步枪的替代品，\
		被后来组成CIN的各国采用。尽管前代步枪\
		自有优点，许多军队的领导层还是逐渐意识到，卡拉什尼科夫式\
		步枪的变型编号都上千了，实在已经老迈。\
		当时的新公司绍特动力提出了解决方案。这款新步枪与\
		你现在看到的相差不大，采用了当时所有最新技术：\
		因萨赫诺步枪而闻名的轻型无壳弹药，以及各种电子设备\
		和其他惊人的科技进步。尽管这些技术\
		可能在萨赫诺诞生之前就已存在，但这款五十年前的设计如今仍在你眼前，\
		总能说明点什么，对吧？"

	return .

/obj/item/gun/ballistic/automatic/lanca/no_mag
	spawnwithmagazine = FALSE

// The AMR
// This sounds a lot scarier than it actually is, you'll just have to trust me here

/obj/item/gun/ballistic/automatic/wylom
	name = "\improper 破阵反器材步枪"
	desc = "一把硕大而过时的反器材步枪，曾被CIN军队使用。发射威力惊人的.60利箭无壳弹，\
		其过分强悍的穿透能力正是这款武器停产的原因。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_64.dmi'
	base_pixel_x = -16 // This baby is 64 pixels wide
	pixel_x = -16
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/inhands_64_left.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/inhands_64_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	icon_state = "wylom"
	inhand_icon_state = "wylom"
	worn_icon_state = "wylom"
	greyscale_config = /datum/greyscale_config/szot_dynamica_64
	greyscale_config_worn = /datum/greyscale_config/szot_dynamica_worn
	greyscale_config_inhand_left = /datum/greyscale_config/szot_dynamica_inhand64_right
	greyscale_config_inhand_right = /datum/greyscale_config/szot_dynamica_inhand64_left
	greyscale_colors = "#83825E#CD445B"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/wylom
	can_suppress = FALSE

	fire_sound = 'modular_skyrat/modules/novaya_ert/sound/amr_fire.ogg'
	fire_sound_volume = 100 // BOOM BABY

	recoil = 4

	weapon_weight = WEAPON_HEAVY
	burst_size = 1
	fire_delay = 2 SECONDS
	actions_types = list()

	force = 15 // I mean if you're gonna beat someone with the thing you might as well get damage appropriate for how big the fukken thing is

/obj/item/gun/ballistic/automatic/wylom/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)

/obj/item/gun/ballistic/automatic/wylom/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)
	AddElement(/datum/element/gun_launches_little_guys, throwing_force = 3, throwing_range = 5)

/obj/item/gun/ballistic/automatic/wylom/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/wylom/examine_more(mob/user)
	. = ..()

	. += "“破阵”反器材步枪最初并不是为人类徒手使用而设计的。\
		原型枪设有专用服装挂载系统的连接点，\
		与银河各地可见的重型智能枪十分相似。不过CIN军事\
		司令部认为，携带部队配属反器材系统不需要昂贵的外骨骼\
		和支架，士兵只要“自己想办法”就好。\
		不出所料，配发这款武器的士兵大多不喜欢这一决定，\
		于是CIN部队里常见各种土法妙招，让士兵尽可能省力地携带和使用\
		这些巨大的步枪。当然，这些新奇办法中的大多数，\
		往往在真正开枪时就会散架。"

	return .
