/obj/item/clothing/mask/gas/bubber //Saves having to type the icon stuff, means you just type in the state, smiley face emoji heart
	name = "紧急情况！！"
	desc = "接下来的 72 小时将会十分危险。"
	icon = 'modular_zubbers/icons/obj/clothing/mask/mask.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/mask/mask.dmi'
	icon_state = null

//Sprites from Sojourn Station: https://github.com/sojourn-13/sojourn-station

/obj/item/clothing/mask/gas/bubber/clown
	name = "彩色小丑面具"
	desc = "在痛苦地延迟了 48 年之后，配套的非红发小丑面具终于到货了！鞋子仍在运输途中。"
	clothing_flags = MASKINTERNALS
	icon_state = "redclown"
	dye_color = DYE_CLOWN
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	actions_types = list(/datum/action/item_action/adjust)
	dog_fashion = /datum/dog_fashion/head/clown
	obj_flags = parent_type::obj_flags

/obj/item/clothing/mask/gas/bubber/clown/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/coloured_clown_mask, infinite = TRUE)
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/datum/atom_skin/coloured_clown_mask
	abstract_type = /datum/atom_skin/coloured_clown_mask
	// Masks rebuild icon_state from base_icon_state, so without this the colour is wiped
	// the next time the mask updates its icon.
	change_base_icon_state = TRUE

/datum/atom_skin/coloured_clown_mask/down_clown
	preview_name = "沮丧小丑"
	new_icon_state = "blueclown"

/datum/atom_skin/coloured_clown_mask/jumbo
	preview_name = "巨无霸"
	new_icon_state = "greenclown"

/datum/atom_skin/coloured_clown_mask/stepchild
	preview_name = "继子"
	new_icon_state = "redclown"

/datum/atom_skin/coloured_clown_mask/banana_brained
	preview_name = "香蕉脑"
	new_icon_state = "yellowclown"

/datum/atom_skin/coloured_clown_mask/rhubarb_rubber
	preview_name = "大黄橡胶"
	new_icon_state = "purpleclown"

/obj/item/clothing/mask/gas/bubber/clown/proc/on_reskin(datum/source, skin_name)
	SIGNAL_HANDLER
	if(ismob(loc))
		var/mob/clown = loc
		clown.update_worn_mask()
	voice_filter = null // performer masks expect to be talked through

/obj/item/clothing/mask/gas/half_mask
	name = "战术风脖套"
	desc = "一款黑色科技风面罩。低调的设计与锐利的风格形成反差。配有一个小型呼吸器，可与内部供气系统配合使用。"
	actions_types = list(/datum/action/item_action/adjust)
	alternate_worn_layer = BODY_FRONT_UNDER_CLOTHES
	icon_state = "half_mask"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	unique_death = 'modular_skyrat/master_files/sound/effects/hacked.ogg'
	voice_filter = null
	use_radio_beeps_tts = FALSE
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH
	visor_flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/gas/half_mask/ui_action_click(mob/user, action)
	adjust_visor(user)
