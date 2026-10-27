/// Shoe Slot Items (Deletes overrided items)
/datum/loadout_category/shoes
	category_name = "鞋类"
	category_ui_icon = FA_ICON_SHOE_PRINTS
	type_to_generate = /datum/loadout_item/shoes
	tab_order = 1

/datum/loadout_item/shoes
	abstract_type = /datum/loadout_item/shoes

/datum/loadout_item/shoes/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	outfit.shoes = item_path

/datum/loadout_item/shoes/sneakers
	name = "运动鞋"
	item_path = /obj/item/clothing/shoes/sneakers

/datum/loadout_item/shoes/sandals_laced
	name = "尼龙搭扣凉鞋"
	item_path = /obj/item/clothing/shoes/sandal/velcro

/datum/loadout_item/shoes/sandals_laced_black
	name = "黑色尼龙搭扣凉鞋"
	item_path = /obj/item/clothing/shoes/sandal/alt/velcro

/datum/loadout_item/shoes/laceup
	name = "系带皮鞋"
	item_path = /obj/item/clothing/shoes/laceup

/datum/loadout_item/shoes/cowboy_brown
	name = "牛仔靴（棕色）"
	item_path = /obj/item/clothing/shoes/cowboy/laced

/datum/loadout_item/shoes/cowboy_white
	name = "白色牛仔靴"
	item_path = /obj/item/clothing/shoes/cowboy/white/laced

/datum/loadout_item/shoes/cowboy_black
	name = "黑色牛仔靴"
	item_path = /obj/item/clothing/shoes/cowboy/black/laced

/datum/loadout_item/shoes/glow_shoes
	name = "发光鞋（可染色）"
	item_path = /obj/item/clothing/shoes/glow

/datum/loadout_item/shoes/jackboots
	name = "战术工作靴"
	item_path = /obj/item/clothing/shoes/workboots/black
