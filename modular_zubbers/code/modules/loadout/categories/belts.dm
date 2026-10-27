/datum/loadout_category/belts
	category_name = "腰带"
	category_ui_icon = FA_ICON_USER_TIE
	type_to_generate = /datum/loadout_item/belts
	tab_order = /datum/loadout_category/head::tab_order + 6

/datum/loadout_item/belts
	abstract_type = /datum/loadout_item/belts

/datum/loadout_item/belts/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.belt)
		LAZYADD(outfit.backpack_contents, outfit.belt)
	outfit.belt = item_path

/datum/loadout_item/belts/fanny_pack_black
	name = "黑色腰包"
	item_path = /obj/item/storage/belt/fannypack/black

/datum/loadout_item/belts/fanny_pack_blue
	name = "蓝色腰包"
	item_path = /obj/item/storage/belt/fannypack/blue

/datum/loadout_item/belts/fanny_pack_brown
	name = "棕色腰包"
	item_path = /obj/item/storage/belt/fannypack

/datum/loadout_item/belts/fanny_pack_cyan
	name = "青色腰包"
	item_path = /obj/item/storage/belt/fannypack/cyan

/datum/loadout_item/belts/fanny_pack_green
	name = "绿色腰包"
	item_path = /obj/item/storage/belt/fannypack/green

/datum/loadout_item/belts/fanny_pack_orange
	name = "橙色腰包"
	item_path = /obj/item/storage/belt/fannypack/orange

/datum/loadout_item/belts/fanny_pack_pink
	name = "粉色腰包"
	item_path = /obj/item/storage/belt/fannypack/pink

/datum/loadout_item/belts/fanny_pack_purple
	name = "紫色腰包"
	item_path = /obj/item/storage/belt/fannypack/purple

/datum/loadout_item/belts/fanny_pack_red
	name = "红色腰包"
	item_path = /obj/item/storage/belt/fannypack/red

/datum/loadout_item/belts/fanny_pack_yellow
	name = "黄色腰包"
	item_path = /obj/item/storage/belt/fannypack/yellow

/datum/loadout_item/belts/fanny_pack_white
	name = "白色腰包"
	item_path = /obj/item/storage/belt/fannypack/white

/datum/loadout_item/belts/lantern
	name = "提灯"
	item_path = /obj/item/flashlight/lantern

/datum/loadout_item/belts/darksabresheath
	name = "暗黑军刀刀鞘"
	item_path = /obj/item/storage/belt/sheath/sabre/darksabre
	//ckeywhitelist = list("inferno707")

/datum/loadout_item/belts/trinket_belt
	name = "饰品腰带"
	item_path = /obj/item/storage/belt/fannypack/occult
	//ckeywhitelist = list("gamerguy14948")

/*
* Webbings
*/

/datum/loadout_item/belts/webbing
	name = "织带·基础"
	item_path = /obj/item/storage/belt/webbing

/datum/loadout_item/belts/webbing_colonial
	name = "织带·殖民地"
	item_path = /obj/item/storage/belt/webbing/colonial_webbing

/datum/loadout_item/belts/webbing_vest_brown
	name = "织带·背心（棕色）"
	item_path = /obj/item/storage/belt/webbing_vest

/datum/loadout_item/belts/webbing_vest_black
	name = "织带·背心（黑色）"
	item_path = /obj/item/storage/belt/webbing_vest/black

/datum/loadout_item/belts/webbing_vest_white
	name = "织带·背心（白色）"
	item_path = /obj/item/storage/belt/webbing_vest/white

/datum/loadout_item/belts/webbing_pouch_brown
	name = "织带·投放袋（棕色）"
	item_path = /obj/item/storage/belt/webbing_pouch

/datum/loadout_item/belts/webbing_pouch_black
	name = "织带·投放袋（黑色）"
	item_path = /obj/item/storage/belt/webbing_pouch/black

/datum/loadout_item/belts/webbing_pouch_white
	name = "织带·投放袋（白色）"
	item_path = /obj/item/storage/belt/webbing_pouch/white

/datum/loadout_item/belts/webbing_pilot_standard
	name = "织带·索具（标准）"
	item_path = /obj/item/storage/belt/webbing_pilot

/datum/loadout_item/belts/webbing_pilot_low
	name = "织带·索具（低垂）"
	item_path = /obj/item/storage/belt/webbing_pilot/low
