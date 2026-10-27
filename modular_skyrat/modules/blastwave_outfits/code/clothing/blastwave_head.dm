/obj/item/clothing/head/blastwave
	name = "冲击波头盔"
	desc = "一顶刷了漆的塑料头盔。防护效果和一个写着“防空洞”的纸箱差不多。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "blastwave_helmet"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/blastwave/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blastwave_helmet)

/datum/atom_skin/blastwave_helmet
	abstract_type = /datum/atom_skin/blastwave_helmet

/datum/atom_skin/blastwave_helmet/default
	preview_name = "默认（紫色）"
	new_icon_state = "blastwave_helmet"

/datum/atom_skin/blastwave_helmet/red
	preview_name = "红色"
	new_icon_state = "blastwave_helmet_r"

/datum/atom_skin/blastwave_helmet/green
	preview_name = "绿色"
	new_icon_state = "blastwave_helmet_g"

/datum/atom_skin/blastwave_helmet/blue
	preview_name = "蓝色"
	new_icon_state = "blastwave_helmet_b"

/datum/atom_skin/blastwave_helmet/yellow
	preview_name = "黄色"
	new_icon_state = "blastwave_helmet_y"

/obj/item/clothing/head/blastwave/officer
	name = "冲击波大檐帽"
	desc = "一顶简洁的军装大檐帽。"
	icon_state = "blastwave_offcap"
	flags_inv = 0

/obj/item/clothing/head/blastwave/officer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blastwave_officer_cap)

/datum/atom_skin/blastwave_officer_cap
	abstract_type = /datum/atom_skin/blastwave_officer_cap

/datum/atom_skin/blastwave_officer_cap/default
	preview_name = "默认（紫色）"
	new_icon_state = "blastwave_offcap"

/datum/atom_skin/blastwave_officer_cap/red
	preview_name = "红色"
	new_icon_state = "blastwave_offcap_r"

/datum/atom_skin/blastwave_officer_cap/green
	preview_name = "绿色"
	new_icon_state = "blastwave_offcap_g"

/datum/atom_skin/blastwave_officer_cap/blue
	preview_name = "蓝色"
	new_icon_state = "blastwave_offcap_b"

/datum/atom_skin/blastwave_officer_cap/yellow
	preview_name = "黄色"
	new_icon_state = "blastwave_offcap_y"
