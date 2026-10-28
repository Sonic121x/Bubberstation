/*
Functional Toggle lets you convert stuff to functional (exo suit), with armor, cold and heat protection values, to non functional (neck), with all those set to zero.
It allows people to use a jacket over a piece or armor and only sacrifice the minimal amount of functionality in the pursuit of design.
Use CTRL + SHIFT + LEFT CLICK to turn them on and off.
*/
/obj/item/clothing/suit
	/// When set to TRUE, this particular suit is not able to use the functional toggle
	var/only_functional
	/// temp list to restore the intitial functional values (for armor, cold protection, etc) to the state they were in prior to using the functional toggle
	var/list/functional_suit_values

/obj/item/clothing/suit/Initialize(mapload)
	. = ..()
	if(!(flags_1 & HAS_CONTEXTUAL_SCREENTIPS_1))
		register_context()

/obj/item/clothing/suit/examine(mob/user)
	. = ..()
	if(!(HAS_TRAIT(src, TRAIT_NODROP)))
		. += span_notice("按住 Ctrl + Shift 并左键点击，可在功能模式（外套）与非功能模式（颈部）之间切换，以便在护甲外再套一件（非功能）夹克来获得视觉效果。")
	else
		only_functional = TRUE

#define PREV_SLOT_FLAGS "fs_slots"
#define PREV_COLD_PROTECTION "fs_cold"
#define PREV_HEAT_PROTECTION "fs_heat"
#define PREV_SLOWDOWN "fs_slow"
#define PREV_ARMOR_DATUM "fs_armor"

/obj/item/clothing/suit/click_ctrl_shift(mob/user)
	if(!iscarbon(user))
		return NONE
	if(only_functional)
		to_chat(user, span_danger("[src]没有非功能模式！"))
		return NONE
	var/mob/living/carbon/char = user
	if((char.get_item_by_slot(ITEM_SLOT_NECK) == src) || (char.get_item_by_slot(ITEM_SLOT_OCLOTHING) == src))
		to_chat(user, span_warning("穿着[src]时无法调整它！"))
		return CLICK_ACTION_BLOCKING
	if(!user.is_holding(src))
		to_chat(user, span_warning("你必须手持[src]才能调整它！"))
		return CLICK_ACTION_BLOCKING
	if(slot_flags & ITEM_SLOT_OCLOTHING)
		functional_suit_values = list(
			PREV_SLOT_FLAGS = slot_flags,
			PREV_COLD_PROTECTION = cold_protection,
			PREV_HEAT_PROTECTION = heat_protection,
			PREV_SLOWDOWN = slowdown,
			PREV_ARMOR_DATUM = armor_type,
		)
		slot_flags = ITEM_SLOT_NECK
		cold_protection = null
		heat_protection = null
		slowdown = 0
		set_armor(/datum/armor/none)
		user.visible_message(span_notice("[user]把[src]调整为非功能模式。"), span_notice("你把[src]调整为非功能模式。"))
	else if(!isnull(functional_suit_values))
		slot_flags = functional_suit_values[PREV_SLOT_FLAGS]
		cold_protection = functional_suit_values[PREV_COLD_PROTECTION]
		heat_protection = functional_suit_values[PREV_HEAT_PROTECTION]
		slowdown = functional_suit_values[PREV_SLOWDOWN]
		set_armor(functional_suit_values[PREV_ARMOR_DATUM])
		functional_suit_values = null
		user.visible_message(span_notice("[user]把[src]调整为功能模式。"), span_notice("你把[src]调整为功能模式。"))
	return CLICK_ACTION_SUCCESS

#undef PREV_SLOT_FLAGS
#undef PREV_COLD_PROTECTION
#undef PREV_HEAT_PROTECTION
#undef PREV_SLOWDOWN
#undef PREV_ARMOR_DATUM

/obj/item/clothing/suit/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	if(only_functional)
		return
	if(slot_flags == ITEM_SLOT_NECK)
		context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "切换为功能模式"
	else
		context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "切换为非功能模式"
	return CONTEXTUAL_SCREENTIP_SET

// Add the things here that shouldn't have this functionality.

/obj/item/clothing/suit/space
	only_functional = TRUE

// Stuff that gives other effects, like reactive armor, reflective armor, etc.

/obj/item/clothing/suit/armor/reactive
	only_functional = TRUE

/obj/item/clothing/suit/hooded/ablative
	only_functional = TRUE

/obj/item/clothing/suit/armor/heavy/adamantine
	only_functional = TRUE

/obj/item/clothing/suit/armor/laserproof
	only_functional = TRUE

/obj/item/clothing/suit/hooded/berserker
	only_functional = TRUE

/obj/item/clothing/suit/armor/abductor/vest
	only_functional = TRUE

/obj/item/clothing/suit/hooded/cultrobes/eldritch
	only_functional = TRUE
