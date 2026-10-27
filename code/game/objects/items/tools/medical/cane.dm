/obj/item/cane
	name = "手杖"
	desc = "真正绅士用的手杖。或者小丑用的。"
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "cane"
	inhand_icon_state = "stick"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron= SMALL_MATERIAL_AMOUNT * 0.5)
	attack_verb_continuous = list("敲打", "重击", "惩戒", "抽打")
	attack_verb_simple = list("敲打", "重击", "惩戒", "抽打")
	/// The amount of slowdown to reduce for a limbless leg
	var/limbless_slowdown_modifier = 0.6 // reduces slowdown by 40%
	/// Does this cause waddling when held
	var/causes_waddling = FALSE

/obj/item/cane/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/walking_aid, limbless_slowdown_modifier, get_walking_aid_required_trait(), causes_waddling)

/// Determines if a trait is required to be used as a walking aid (ex. foldable canes)
/obj/item/cane/proc/get_walking_aid_required_trait()
	return null

/obj/item/cane/crutch
	name = "医疗拐杖"
	desc = "缺了一条腿的人所用的医疗拐杖。不过要是两条腿都没了，这东西就没那么有用了。"
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "crutch_med"
	inhand_icon_state = "crutch_med"
	icon_angle = 45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 12
	throwforce = 8
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5)
	attack_verb_continuous = list("敲打", "重击", "抽打")
	attack_verb_simple = list("敲打", "重击", "抽打")
	limbless_slowdown_modifier = 0.4 // reduces slowdown by 60%
	causes_waddling = TRUE

/obj/item/cane/crutch/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item)

/obj/item/cane/crutch/wood
	name = "木制拐杖"
	desc = "手工制作的拐杖。需要时也能当根不错的棍棒用。"
	icon_state = "crutch_wood"
	inhand_icon_state = "crutch_wood"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/cane/white
	name = "白手杖"
	desc = "传统上供盲人用来探路。可折叠，便于携带。"
	icon_state = "cane_white"
	inhand_icon_state = "cane_white"
	icon_angle = 45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 1
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 6)

/obj/item/cane/white/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item)
	AddComponent( \
		/datum/component/transforming, \
		force_on = 7, \
		hitsound_on = hitsound, \
		w_class_on = WEIGHT_CLASS_BULKY, \
		clumsy_check = FALSE, \
		attack_verb_continuous_on = list("猛拍", "击打", "抽裂", "痛揍"), \
		attack_verb_simple_on = list("猛拍", "击打", "抽裂", "痛揍"), \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

// White canes only provide support while extended
/obj/item/cane/white/get_walking_aid_required_trait()
	return TRAIT_TRANSFORM_ACTIVE

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Gives feedback to the user and makes it show up inhand.
 */
/obj/item/cane/white/proc/on_transform(obj/item/source, mob/living/user, active)
	SIGNAL_HANDLER

	if(user)
		balloon_alert(user, active ? "已展开" : "已收起")

	if(!HAS_TRAIT(src, TRAIT_BLIND_TOOL))
		ADD_TRAIT(src, TRAIT_BLIND_TOOL, INNATE_TRAIT)
	else
		REMOVE_TRAIT(src, TRAIT_BLIND_TOOL, INNATE_TRAIT)

	playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE
