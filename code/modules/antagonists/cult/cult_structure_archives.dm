/// Some defines for items the cult archives can create.
#define CULT_BLINDFOLD "Zealot's Blindfold"
#define CURSE_ORB "Shuttle Curse"
#define VEIL_WALKER "Veil Walker"
#define CRIMSON_MEDALLION "Crimson Medallion"

// Cult archives. Gives out utility items.
/obj/structure/destructible/cult/item_dispenser/archives
	name = "档案馆"
	desc = "一张堆满未知语言的神秘手稿与典籍的书桌。看着这些文字，你的皮肤阵阵发麻。"
	cult_examine_tip = "可用于制造狂信者眼罩、穿梭机诅咒宝珠和帷幕行者装备。"
	icon_state = "tomealtar"
	light_range = 1.5
	light_color = LIGHT_COLOR_FIRE
	break_message = span_warning("书桌碎裂的同时，档案馆的书籍与典籍尽数化为灰烬！")
	mansus_conversion_path = /obj/item/codex_cicatrix
	custom_materials = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT * 3)

/obj/structure/destructible/cult/item_dispenser/archives/setup_options()
	var/static/list/archive_items = list(
		CULT_BLINDFOLD = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/clothing/glasses.dmi', icon_state = "blindfold"),
			OUTPUT_ITEMS = list(/obj/item/clothing/glasses/hud/health/night/cultblind),
			RADIAL_DESC = "制造[/obj/item/clothing/glasses/hud/health/night/cultblind::name]，这是一种不会遮蔽教徒视线的特殊眼罩。\
				此外，它还能显示敌友的生命值、提供夜视能力，甚至能抵御强光。",
			),
		CURSE_ORB = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "shuttlecurse"),
			OUTPUT_ITEMS = list(/obj/item/shuttle_curse),
			RADIAL_DESC = "产出[/obj/item/shuttle_curse::name]，在穿梭机已被呼叫后捏碎它便可施加诅咒，\
				使其抵达延迟一段时间。最多只能使用 [MAX_SHUTTLE_CURSES] 次。",
			),
		VEIL_WALKER = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "shifter"),
			OUTPUT_ITEMS = list(/obj/item/cult_shift),
			RADIAL_DESC = "制造[/obj/item/cult_shift::name]，这根小魔杖可将使用者\
				——以及被使用者拖拽的任何人——向前传送一段距离。拥有 [/obj/item/cult_shift::uses] 次使用次数。",
			),
	)

	var/extra_item = extra_options()

	options = archive_items
	if(!isnull(extra_item))
		options += extra_item

/obj/structure/destructible/cult/item_dispenser/archives/extra_options()
	if(!cult_team?.unlocked_heretic_items[CRIMSON_MEDALLION_UNLOCKED])
		return
	return list(CRIMSON_MEDALLION = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/clothing/neck.dmi', icon_state = "crimson_medallion"),
			OUTPUT_ITEMS = list(/obj/item/clothing/neck/heretic_focus/crimson_medallion),
			RADIAL_DESC = "制造[/obj/item/clothing/neck/heretic_focus/crimson_medallion::name]，这件强大的器物可提供被动治疗，并允许你额外准备一个法术。\
				也可在手心捏碎，将其消耗以获得强效治疗。",
			),
	)

/obj/structure/destructible/cult/item_dispenser/archives/succcess_message(mob/living/user, obj/item/spawned_item)
	to_chat(user, span_cult_italic("你从[src]中召唤出了[spawned_item]！"))

// Preset for the library that doesn't spawn runed metal on destruction, or glow.
/obj/structure/destructible/cult/item_dispenser/archives/library
	icon_state = "tomealtar_off"
	debris = list()

#undef CULT_BLINDFOLD
#undef CURSE_ORB
#undef VEIL_WALKER
#undef CRIMSON_MEDALLION
