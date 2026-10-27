/// Glasses Slot Items (Moves overrided items to backpack)
/datum/loadout_category/glasses
	category_name = "眼镜"
	category_ui_icon = FA_ICON_GLASSES
	type_to_generate = /datum/loadout_item/glasses
	tab_order = /datum/loadout_category/head::tab_order + 1

/datum/loadout_item/glasses
	abstract_type = /datum/loadout_item/glasses

/datum/loadout_item/glasses/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, loadout_placement_preference) // SKYRAT EDIT CHANGE - Added loadout_placement
	// SKYRAT EDIT CHANGE
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.glasses)
		LAZYADD(outfit.backpack_contents, outfit.glasses)
	// SKYRAT EDIT END
	outfit.glasses = item_path

/datum/loadout_item/glasses/regular
	name = "眼镜"
	item_path = /obj/item/clothing/glasses/regular

/datum/loadout_item/glasses/circle_glasses
	name = "圆框眼镜"
	item_path = /obj/item/clothing/glasses/regular/circle

/datum/loadout_item/glasses/hipster_glasses
	name = "潮人眼镜"
	item_path = /obj/item/clothing/glasses/regular/hipster

/datum/loadout_item/glasses/jamjar_glasses
	name = "果酱罐眼镜"
	item_path = /obj/item/clothing/glasses/regular/jamjar

/datum/loadout_item/glasses/black_blindfold
	name = "黑色眼罩布"
	item_path = /obj/item/clothing/glasses/blindfold

/datum/loadout_item/glasses/cold_glasses
	name = "防寒护目镜"
	item_path = /obj/item/clothing/glasses/cold

/datum/loadout_item/glasses/heat_glasses
	name = "耐热护目镜"
	item_path = /obj/item/clothing/glasses/heat

/datum/loadout_item/glasses/orange_glasses
	name = "橙色眼镜"
	item_path = /obj/item/clothing/glasses/orange

/datum/loadout_item/glasses/red_glasses
	name = "红色眼镜"
	item_path = /obj/item/clothing/glasses/red

/datum/loadout_item/glasses/eyepatch
	name = "眼罩"
	item_path = /obj/item/clothing/glasses/eyepatch

/datum/loadout_item/glasses/eyepatch/medical
	name = "医疗眼罩"
	item_path = /obj/item/clothing/glasses/eyepatch/medical

/datum/loadout_item/glasses/kim
	name = "细框处方眼镜"
	item_path = /obj/item/clothing/glasses/regular/kim

/datum/loadout_item/glasses/monocle
	name = "单边眼镜"
	item_path = /obj/item/clothing/glasses/monocle
