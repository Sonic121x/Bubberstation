/// Some defines for items the daemon forge can create.
#define NARSIE_ARMOR "Nar'Sien Hardened Armor"
#define ELDRITCH_SWORD "Eldritch Longsword"
#define CURSED_BLADE "Cursed Ritual Blade"

// Cult forge. Gives out combat weapons.
/obj/structure/destructible/cult/item_dispenser/forge
	name = "恶魔锻炉"
	desc = "一座用于为纳尔西的大军打造邪恶武器的锻炉。"
	cult_examine_tip = "可用于制造纳尔西硬化护甲与邪异长剑。"
	icon_state = "forge"
	light_range = 2
	light_color = LIGHT_COLOR_LAVA
	break_message = span_warning("锻炉伴着尖啸声碎裂成片！")
	mansus_conversion_path = /obj/structure/destructible/eldritch_crucible
	custom_materials = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT * 3)

/obj/structure/destructible/cult/item_dispenser/forge/setup_options()
	var/static/list/forge_items = list(
		NARSIE_ARMOR = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/clothing/suits/armor.dmi', icon_state = "cult_armor"),
			OUTPUT_ITEMS = list(/obj/item/clothing/suit/hooded/cultrobes/hardened),
			RADIAL_DESC = "锻出一副[/obj/item/clothing/suit/hooded/cultrobes/hardened::name]，这是一套能抵御太空环境的坚固护甲。",
			),
		ELDRITCH_SWORD = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/weapons/sword.dmi', icon_state = "cultblade"),
			OUTPUT_ITEMS = list(/obj/item/melee/cultblade),
			RADIAL_DESC = "锻出一把[/obj/item/melee/cultblade::name]，这是一柄能劈开最坚固护甲的强力刀剑。",
			),
	)

	var/extra_item = extra_options()

	options = forge_items
	if(!isnull(extra_item))
		options += extra_item

/obj/structure/destructible/cult/item_dispenser/forge/extra_options()
	if(!cult_team?.unlocked_heretic_items[CURSED_BLADE_UNLOCKED])
		return
	return list(CURSED_BLADE = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/weapons/khopesh.dmi', icon_state = "cursed_blade"),
			OUTPUT_ITEMS = list(/obj/item/melee/sickly_blade/cursed),
			RADIAL_DESC = "锻出一把[/obj/item/melee/sickly_blade/cursed::name]，这是一柄强化匕首，可将其折断以进行紧急传送。",
			),
	)


/obj/structure/destructible/cult/item_dispenser/forge/succcess_message(mob/living/user, obj/item/spawned_item)
	to_chat(user, span_cult_italic("黑暗知识指引着你的双手，你操作着[src]，制造出了[spawned_item]！"))

/obj/structure/destructible/cult/item_dispenser/forge/engine
	name = "熔岩引擎"
	desc = "一台用于为穿梭机供能的奥术引擎。"
	debris = list()

#undef NARSIE_ARMOR
#undef ELDRITCH_SWORD
#undef CURSED_BLADE
