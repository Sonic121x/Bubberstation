//Title Capitalization for names please!!!

/datum/loadout_category/ears
	category_name = "耳部"
	category_ui_icon = FA_ICON_EAR_LISTEN
	type_to_generate = /datum/loadout_item/ears
	tab_order = /datum/loadout_category/head::tab_order + 7

/datum/loadout_item/ears
	abstract_type = /datum/loadout_item/ears

/datum/loadout_item/ears/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.ears)
		LAZYADD(outfit.backpack_contents, outfit.ears)
	outfit.ears = item_path

/datum/loadout_item/ears/headphones
	name = "耳机"
	item_path = /obj/item/instrument/piano_synth/headphones

/datum/loadout_item/ears/earmuffs
	name = "耳罩"
	item_path = /obj/item/clothing/ears/earmuffs

/datum/loadout_item/ears/kinkphone_sharkenning
	name = "可疑的光亮耳机"
	item_path = /obj/item/clothing/ears/kinky_headphones/sharkenning
	ckeywhitelist = list("thesharkenning")

/datum/loadout_item/ears/headset_frontier_colonist
	name = "边疆无线电耳机"
	item_path = /obj/item/radio/headset/headset_frontier_colonist

/datum/loadout_item/ears/headset_frontier_colonist_wide
	name = "边疆无线电耳机（宽版）"
	item_path = /obj/item/radio/headset/headset_frontier_colonist/wide
