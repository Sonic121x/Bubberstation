/// Dextrous guardians have some of the most powerful abilities of all: hands and pockets
/mob/living/basic/guardian/dextrous
	guardian_type = GUARDIAN_DEXTROUS
	melee_damage_lower = 10
	melee_damage_upper = 10
	physiology = list(BRUTE = 0.75, BURN = 0.75, TOX = 0.75, OXY = 0.75, STAMINA = 0)
	playstyle_string = span_holoparasite("作为<b>灵巧</b>型，你可以手持物品、在体内储存一件物品，并具有中等伤害抗性，但攻击伤害较低。召回和牵引会迫使你丢下未储存的物品！")
	creator_name = "灵巧"
	creator_desc = "攻击伤害较低，但能够手持物品并在体内储存一件物品。召回时会丢下手中的物品，但会保留储存的物品。"
	creator_icon = "dextrous"
	hud_type = /datum/hud/dextrous/guardian
	held_items = list(null, null)
	/// An internal pocket we can put stuff in
	var/obj/item/internal_storage

/mob/living/basic/guardian/dextrous/Initialize(mapload, datum/guardian_fluff/theme)
	. = ..()
	AddComponent(/datum/component/basic_inhands)
	add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP), ROUNDSTART_TRAIT)
	AddElement(/datum/element/dextrous, hud_type = hud_type, can_throw = TRUE)
	AddComponent(/datum/component/personal_crafting)
	AddComponent(/datum/component/basic_inhands)

/mob/living/basic/guardian/dextrous/death(gibbed)
	dropItemToGround(internal_storage)
	return ..()

/mob/living/basic/guardian/dextrous/create_actions()
	for (var/action_type in self_actions)
		if(isnull(action_type)) //no toggle button type
			continue
		if (locate(action_type) in actions)
			continue
		var/datum/action/new_action = new action_type(src)
		//Show up at the top left like usual.
		new_action.default_button_position = /datum/action::default_button_position
		new_action.Grant(src)
	update_action_buttons()

/mob/living/basic/guardian/dextrous/examine(mob/user)
	. = ..()
	if(isnull(internal_storage) || (internal_storage.item_flags & ABSTRACT))
		return
	. += span_info("它的内置储物空间里装着 [internal_storage.examine_title(user)]。")

/mob/living/basic/guardian/dextrous/manifest_effects()
	. = ..()
	REMOVE_TRAIT(src, TRAIT_HANDS_BLOCKED, GUARDIAN_RECALLED)

/mob/living/basic/guardian/dextrous/recall_effects()
	. = ..()
	drop_all_held_items()
	ADD_TRAIT(src, TRAIT_HANDS_BLOCKED, GUARDIAN_RECALLED)

// Bullshit related to having a fake pocket begins here

/mob/living/basic/guardian/dextrous/doUnEquip(obj/item/item_dropping, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	. = ..()
	if (!.)
		return FALSE
	update_held_items()
	if(item_dropping == internal_storage)
		internal_storage = null
		update_inv_internal_storage()
	return TRUE

/mob/living/basic/guardian/dextrous/can_equip(mob/living/M, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	if(slot != ITEM_SLOT_DEX_STORAGE)
		return FALSE
	return isnull(internal_storage)

/mob/living/basic/guardian/dextrous/get_item_by_slot(slot_id)
	if(slot_id == ITEM_SLOT_DEX_STORAGE)
		return internal_storage
	return ..()

/mob/living/basic/guardian/dextrous/get_slot_by_item(obj/item/looking_for)
	if(internal_storage == looking_for)
		return ITEM_SLOT_DEX_STORAGE
	return ..()

/mob/living/basic/guardian/dextrous/equip_to_slot(obj/item/equipping, slot, initial = FALSE, redraw_mob = FALSE, indirect_action = FALSE)
	if (slot != ITEM_SLOT_DEX_STORAGE)
		to_chat(src, span_danger("你正试图把物品装备到不支持的物品栏位。请向程序员报告！"))
		return FALSE

	var/index = get_held_index_of_item(equipping)
	if(index)
		held_items[index] = null
	update_held_items()

	if(equipping.pulledby)
		equipping.pulledby.stop_pulling()

	hud_used?.update_inventory_slot(slot)
	equipping.forceMove(src)
	SET_PLANE_EXPLICIT(equipping, ABOVE_HUD_PLANE, src)

	internal_storage = equipping
	update_inv_internal_storage()

	has_equipped(equipping, slot)
	return TRUE

/mob/living/basic/guardian/dextrous/getBackSlot()
	return ITEM_SLOT_DEX_STORAGE

/mob/living/basic/guardian/dextrous/proc/update_inv_internal_storage()
	hud_used?.update_inventory_slot(ITEM_SLOT_DEX_STORAGE)

/mob/living/basic/guardian/dextrous/regenerate_icons()
	update_inv_internal_storage()
