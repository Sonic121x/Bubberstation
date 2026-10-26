/obj/item/clothing/suit/blastwave
	name = "冲击波风衣"
	desc = "一件平淡无奇战争中的通用风衣。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suit_digi.dmi'
	icon_state = "blastwave_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/blastwave/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blastwave_trenchcoat)

/datum/atom_skin/blastwave_trenchcoat
	abstract_type = /datum/atom_skin/blastwave_trenchcoat

/datum/atom_skin/blastwave_trenchcoat/default
	preview_name = "默认（紫色）"
	new_icon_state = "blastwave_suit"

/datum/atom_skin/blastwave_trenchcoat/red
	preview_name = "红色"
	new_icon_state = "blastwave_suit_r"

/datum/atom_skin/blastwave_trenchcoat/green
	preview_name = "绿色"
	new_icon_state = "blastwave_suit_g"

/datum/atom_skin/blastwave_trenchcoat/blue
	preview_name = "蓝色"
	new_icon_state = "blastwave_suit_b"

/datum/atom_skin/blastwave_trenchcoat/yellow
	preview_name = "黄色"
	new_icon_state = "blastwave_suit_y"
