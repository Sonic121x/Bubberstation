/// Some defines for items the cult altar can create.
#define ELDRITCH_WHETSTONE "Eldritch Whetstone"
#define CONSTRUCT_SHELL "Construct Shell"
#define UNHOLY_WATER "Flask of Unholy Water"
#define PROTEON_ORB "Portal Summoning Orb"

// Cult altar. Gives out consumable items.
/obj/structure/destructible/cult/item_dispenser/altar
	name = "祭坛"
	desc = "一座献给纳尔西的、血迹斑斑的祭坛。"
	cult_examine_tip = "可用于制造邪术磨石、构装体外壳和一瓶不洁之水。"
	icon_state = "talismanaltar"
	break_message = span_warning("祭坛碎裂，只剩下受诅咒者的哀嚎！")
	mansus_conversion_path = /obj/effect/heretic_rune
	custom_materials = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT * 3)

/obj/structure/destructible/cult/item_dispenser/altar/setup_options()
	var/static/list/altar_items = list(
		ELDRITCH_WHETSTONE = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "cult_sharpener"),
			OUTPUT_ITEMS = list(/obj/item/sharpener/cult),
			RADIAL_DESC = "提供[/obj/item/sharpener/cult::name]，可用于提升剑与匕首的伤害。仅可使用一次。",
			),
		CONSTRUCT_SHELL = list(
			PREVIEW_IMAGE = image(icon = 'icons/mob/shells.dmi', icon_state = "construct_cult"),
			OUTPUT_ITEMS = list(/obj/structure/constructshell),
			RADIAL_DESC = "产出[/obj/structure/constructshell::name]，在通过灵魂石注入幽魂之后，便会孕育出一具构装体。\
				构装体可为你的队伍带来力量、敏捷或实用能力。",
			),
		UNHOLY_WATER = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/drinks/bottles.dmi', icon_state = "unholyflask"),
			OUTPUT_ITEMS = list(/obj/item/reagent_containers/cup/beaker/unholywater),
			RADIAL_DESC = "提供[/obj/item/reagent_containers/cup/beaker/unholywater::name]，\
				小口饮用可治愈所有伤害类型，包括失血。\
				同时可作为凝血剂与温和兴奋剂（对眩晕和耐力伤害提供微弱抗性）。",
			),
	)

	var/extra_item = extra_options()

	options = altar_items
	if(!isnull(extra_item))
		options += extra_item

/obj/structure/destructible/cult/item_dispenser/altar/extra_options()
	if(!cult_team?.unlocked_heretic_items[PROTEON_ORB_UNLOCKED])
		return
	return list(PROTEON_ORB = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "summoning_orb"),
			OUTPUT_ITEMS = list(/obj/item/proteon_orb),
			RADIAL_DESC = "提供[/obj/item/proteon_orb::name]，可用于开启一道传送门，将次级构装体释放到空间站内。"
			),
	)

/obj/structure/destructible/cult/item_dispenser/altar/succcess_message(mob/living/user, obj/item/spawned_item)
	to_chat(user, span_cult_italic("你在[src]前跪下，你的信仰得到了[spawned_item]作为回报！"))

#undef ELDRITCH_WHETSTONE
#undef CONSTRUCT_SHELL
#undef UNHOLY_WATER
#undef PROTEON_ORB
