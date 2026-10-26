/obj/item/rsd_interface
	name = "共鸣模拟装置命匣"
	desc = "一种通常植入无活性大脑的小型装置。由于共鸣无法在所谓的“真空”中持续存在，共鸣模拟装置会像它所模拟的大脑和处理器一样，以脑白噪声为基础，让共鸣得以在原本死寂的容器中存续。"
	icon = 'modular_skyrat/modules/aesthetics/implanter/implanter.dmi'
	icon_state = "implanter1"
	inhand_icon_state = "syringe_0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
	)

/// Attempts to use the item on the target brain.
/obj/item/rsd_interface/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/item/organ/brain))
		return NONE

	if(HAS_TRAIT(interacting_with, TRAIT_RSD_COMPATIBLE))
		user.balloon_alert(user, "已经升级过了！")
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user]用[src]升级了[interacting_with]。"), span_notice("你升级了[interacting_with]，使其兼容共鸣模拟装置。"))
	interacting_with.AddElement(/datum/element/rsd_interface)
	playsound(interacting_with.loc, 'sound/items/weapons/circsawhit.ogg', 50, vary = TRUE)

	qdel(src)
	return ITEM_INTERACT_SUCCESS

/datum/element/rsd_interface/Attach(datum/target)
	. = ..()
	if(!istype(target, /obj/item/organ/brain))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	ADD_TRAIT(target, TRAIT_RSD_COMPATIBLE, INNATE_TRAIT)

/// Adds text to the examine text of the parent item, explaining that the item can be used to enable the use of NIFSoft HUDs
/datum/element/rsd_interface/proc/on_examine(datum/source, mob/user, list/examine_text)
	SIGNAL_HANDLER
	examine_text += span_cyan("只要[source]没有活性，就可以将灵魂转移进去。")

/datum/element/rsd_interface/Detach(datum/target)
	UnregisterSignal(target, COMSIG_ATOM_EXAMINE)
	REMOVE_TRAIT(target, TRAIT_RSD_COMPATIBLE, INNATE_TRAIT)

	return ..()

