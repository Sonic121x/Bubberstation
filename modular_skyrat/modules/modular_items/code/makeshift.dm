//Tools that are made using makeshift item crafting

/obj/item/crowbar/makeshift
	name = "简易撬棍"
	desc = "一把用各种杂七杂八的零件草草拼凑而成的简易撬棍。它的头部很结实，看上去还能拿来当锤子用。"
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "makeshift_crowbar"
	worn_icon_state = "crowbar"
	force = 2
	throwforce = 2
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 1.5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4)

/obj/item/screwdriver/makeshift
	name = "简易螺丝刀"
	desc = "一把用布料和少量金属草草制成的简易螺丝刀。"
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "makeshift_screwdriver"
	post_init_icon_state = null
	inside_belt_icon_state = null
	random_color = FALSE
	force = 1
	throwforce = 1
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 1.5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/weldingtool/makeshift
	name = "简易焊接工具"
	desc = "一把用各种杂七杂八的零件草草拼凑而成的简易焊接工具。"
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "makeshift_welder"
	force = 1
	throwforce = 2
	toolspeed = 1.5
	w_class = WEIGHT_CLASS_NORMAL
	max_fuel = 10
	heat = 1800
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/wirecutters/makeshift
	name = "简易剪线钳"
	desc = "一把用各种杂七杂八的零件草草拼凑而成的简易剪线钳。"
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "makeshift_cutters"
	random_color = FALSE
	force = 3
	throwforce = 2
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 1.5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null

/obj/item/wrench/makeshift
	name = "简易扳手"
	desc = "一把用各种杂七杂八的零件草草拼凑而成的简易扳手。"
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "makeshift_wrench"
	force = 2
	throwforce = 2
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 1.5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.5)
