/obj/item/clothing/under/blastwave
	name = "冲击波制服"
	desc = "一套实用主义的粗犷战争制服。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "blastwave_uniform"
	can_adjust = FALSE

/obj/item/clothing/under/blastwave/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blastwave_uniform)

/datum/atom_skin/blastwave_uniform
	abstract_type = /datum/atom_skin/blastwave_uniform

/datum/atom_skin/blastwave_uniform/default
	preview_name = "默认（紫色）"
	new_icon_state = "blastwave_uniform"

/datum/atom_skin/blastwave_uniform/red
	preview_name = "红色"
	new_icon_state = "blastwave_uniform_r"

/datum/atom_skin/blastwave_uniform/green
	preview_name = "绿色"
	new_icon_state = "blastwave_uniform_g"

/datum/atom_skin/blastwave_uniform/blue
	preview_name = "蓝色"
	new_icon_state = "blastwave_uniform_b"

/datum/atom_skin/blastwave_uniform/yellow
	preview_name = "黄色"
	new_icon_state = "blastwave_uniform_y"
