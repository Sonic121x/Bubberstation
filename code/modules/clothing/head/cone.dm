/obj/item/clothing/head/cone
	desc = "这个路锥在试图警告你什么！"
	name = "警示路锥"
	icon = 'icons/obj/service/janitor.dmi'
	worn_icon = 'icons/mob/clothing/head/utility.dmi'
	icon_state = "cone"
	inhand_icon_state = null
	worn_y_offset = 1
	force = 1
	throwforce = 3
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("warns", "cautions", "smashes")
	attack_verb_simple = list("warn", "caution", "smash")
	pickup_sound = 'sound/items/handling/materials/plastic_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/plastic_drop.ogg'
	resistance_flags = NONE
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/clothing/head/cone/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/floor_placeable)

/obj/item/clothing/head/cone/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)


