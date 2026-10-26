/obj/item/clothing/under/stripper_outfit
	name = "脱衣舞服装"
	desc = "一件几乎不给人留任何想象空间的衣服。"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-hoof.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE
	icon_state = "stripper_cyan"
	inhand_icon_state = "b_suit"
	interaction_flags_click = NEED_DEXTERITY

/obj/item/clothing/under/stripper_outfit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/stripper_outfit)

/datum/atom_skin/stripper_outfit
	abstract_type = /datum/atom_skin/stripper_outfit

/datum/atom_skin/stripper_outfit/cyan
	preview_name = "青色"
	new_icon_state = "stripper_cyan"

/datum/atom_skin/stripper_outfit/yellow
	preview_name = "黄色"
	new_icon_state = "stripper_yellow"

/datum/atom_skin/stripper_outfit/green
	preview_name = "绿色"
	new_icon_state = "stripper_green"

/datum/atom_skin/stripper_outfit/red
	preview_name = "红色"
	new_icon_state = "stripper_red"

/datum/atom_skin/stripper_outfit/latex
	preview_name = "乳胶"
	new_icon_state = "stripper_latex"

/datum/atom_skin/stripper_outfit/orange
	preview_name = "橙色"
	new_icon_state = "stripper_orange"

/datum/atom_skin/stripper_outfit/white
	preview_name = "白色"
	new_icon_state = "stripper_white"

/datum/atom_skin/stripper_outfit/purple
	preview_name = "紫色"
	new_icon_state = "stripper_purple"

/datum/atom_skin/stripper_outfit/black
	preview_name = "黑色"
	new_icon_state = "stripper_black"

/datum/atom_skin/stripper_outfit/black_teal
	preview_name = "黑青色"
	new_icon_state = "stripper_tealblack"
