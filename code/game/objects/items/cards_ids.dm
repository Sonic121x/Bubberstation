/// Fallback time if none of the config entries are set for USE_LOW_LIVING_HOUR_INTERN
#define INTERN_THRESHOLD_FALLBACK_HOURS 15

/// Max time interval between projecting holopays
#define HOLOPAY_PROJECTION_INTERVAL (7 SECONDS)

/* Cards
 * Contains:
 * DATA CARD
 * ID CARD
 * FINGERPRINT CARD HOLDER
 * FINGERPRINT CARD
 */



/*
 * DATA CARDS - Used for the IC data card reader
 */

/obj/item/card
	name = "卡片"
	desc = "用来做卡片该做的事。"
	icon = 'icons/obj/card.dmi'
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	pickup_sound = 'sound/items/handling/id_card/id_card_pickup1.ogg'
	drop_sound = 'sound/items/handling/id_card/id_card_drop1.ogg'
	sound_vary = TRUE

	/// Cached icon that has been built for this card. Intended to be displayed in chat. Cardboards IDs and actual IDs use it.
	var/icon/cached_flat_icon
	///What is our honorific name/title combo to be displayed?
	var/honorific_title

/obj/item/card/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始用[src]划自己的脖子！看起来[user.p_theyre()]想自杀！"))
	return BRUTELOSS

/obj/item/card/update_overlays()
	. = ..()
	cached_flat_icon = null

/// Called to get what name this card represents
/obj/item/card/proc/get_displayed_name(honorifics = FALSE)
	return null

/// If no cached_flat_icon exists, this proc creates it and crops it. This proc then returns the cached_flat_icon. Intended for use displaying ID card icons in chat.
/obj/item/card/proc/get_cached_flat_icon()
	if(!cached_flat_icon)
		cached_flat_icon = getFlatIcon(src)
		cached_flat_icon.Crop(ID_ICON_BORDERS)
	return cached_flat_icon

/*
 * ID CARDS
 */

/// "Retro" ID card that renders itself as the icon state with no overlays.
/obj/item/card/id
	name = "复古身份识别卡"
	desc = "用于证明身份及确定空间站各处通行权限的卡片。"
	icon_state = "card_grey"
	worn_icon_state = "nothing"
	slot_flags = ITEM_SLOT_ID
	interaction_flags_click = FORBID_TELEKINESIS_REACH
	armor_type = /datum/armor/card_id
	resistance_flags = FIRE_PROOF | ACID_PROOF
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	item_flags = parent_type::item_flags | NO_MAT_REDEMPTION // A little clemency to the people who fumble and misclick stuff, even if it's already easy enough to destroy one.

	/// The name registered on the card (for example: Dr Bryan See)
	var/registered_name = null
	/// Linked bank account.
	var/datum/bank_account/registered_account

	/// Linked holopay.
	var/obj/structure/holopay/my_store
	/// Cooldown between projecting holopays
	COOLDOWN_DECLARE(last_holopay_projection)
	/// List of logos available for holopay customization - via font awesome 5
	var/static/list/available_logos = list("angry", "ankh", "bacon", "band-aid", "cannabis", "cat", "cocktail", "coins", "comments-dollar",
	"cross", "cut", "dog", "donate", "dna", "fist-raised", "flask", "glass-cheers", "glass-martini-alt", "hamburger", "hand-holding-usd",
	"hat-wizard", "head-side-cough-slash", "heart", "heart-broken",  "laugh-beam", "leaf", "money-check-alt", "music", "piggy-bank",
	"pizza-slice", "prescription-bottle-alt", "radiation", "robot", "smile", "skull-crossbones", "smoking", "space-shuttle", "tram",
	"trash", "user-ninja", "utensils", "wrench")
	/// Replaces the "pay whatever" functionality with a set amount when non-zero.
	var/holopay_fee = 0
	/// The holopay icon chosen by the user
	var/holopay_logo = "donate"
	/// Maximum forced fee. It's unlikely for a user to encounter this type of money, much less pay it willingly.
	var/holopay_max_fee = 5000
	/// Minimum forced fee for holopay stations. Registers as "pay what you want."
	var/holopay_min_fee = 0
	/// The holopay name chosen by the user
	var/holopay_name = "全息收款台"

	/// Registered owner's age.
	var/registered_age = 18 //SKYRAT EDIT - ORIGINAL (30)

	/// The job name registered on the card (for example: Assistant).
	var/assignment

	/// Trim datum associated with the card. Controls which job icon is displayed on the card and which accesses do not require wildcards.
	var/datum/id_trim/trim
	/// Whether the trim on this card can be changed.
	var/trim_changeable = FALSE

	/// Access levels held by this card.
	var/list/access = list()

	/// List of wildcard slot names as keys with lists of wildcard data as values.
	var/list/wildcard_slots = list()

	/// Boolean value. If TRUE, the [Intern] tag gets prepended to this ID card when the label is updated.
	var/is_intern = FALSE

	///If true, the wearer will have bigger arrow when pointing at things. Passed down by trims.
	var/big_pointer = FALSE
	///If set, the arrow will have a different color.
	var/pointer_color
	/// Will this ID card use the first or last name as the name displayed with the honorific?
	var/honorific_position = HONORIFIC_POSITION_NONE
	/// What is our selected honorific?
	var/chosen_honorific


/datum/armor/card_id
	fire = 100
	acid = 100

/obj/item/card/id/apply_fantasy_bonuses(bonus)
	. = ..()
	if(bonus >= 15)
		add_access(SSid_access.get_region_access_list(list(REGION_ALL_GLOBAL)), mode = FORCE_ADD_ALL)
	else if(bonus >= 10)
		add_access(SSid_access.get_region_access_list(list(REGION_ALL_STATION)), mode = FORCE_ADD_ALL)
	else if(bonus <= -10)
		clear_access()

/obj/item/card/id/Initialize(mapload)
	. = ..()

	var/datum/bank_account/blank_bank_account = new("Unassigned", SSjob.get_job_type(/datum/job/unassigned), player_account = FALSE)
	set_account(blank_bank_account)
	registered_account.replaceable = TRUE

	// Applying the trim updates the label and icon, so don't do this twice.
	if(ispath(trim))
		SSid_access.apply_trim_to_card(src, trim)
	else
		update_label()
		update_appearance()

	// Apply any active RETA grants to this new ID card
	// This will only do something if there are active grants, so it's safe to call always
	apply_active_reta_grants_to_card(src)

	register_item_context()
	register_context()

	RegisterSignal(src, COMSIG_ATOM_UPDATED_ICON, PROC_REF(update_in_wallet))
	if(prob(1))
		ADD_TRAIT(src, TRAIT_TASTEFULLY_THICK_ID_CARD, ROUNDSTART_TRAIT)

/obj/item/card/id/Destroy()
	clear_account()
	QDEL_NULL(my_store)
	if (isitem(loc))
		UnregisterSignal(loc, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))
	return ..()

/obj/item/card/id/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	if(isitem(old_loc))
		unequip_from_item_loc(old_loc)
	. = ..()
	if(isitem(loc))
		equip_to_item_loc(loc)

/obj/item/card/id/equipped(mob/user, slot)
	. = ..()
	if (slot & ITEM_SLOT_ID)
		RegisterSignal(user, COMSIG_MOVABLE_POINTED, PROC_REF(on_pointed))
		if(ishuman(user))
			var/mob/living/carbon/human/as_human = user
			as_human.update_visible_name()
	if (slot & (ITEM_SLOT_ID|ITEM_SLOT_HANDS))
		RegisterSignal(user, COMSIG_MOB_RETRIEVE_ACCESS, PROC_REF(retrieve_access))
	if (slot & ITEM_SLOT_POCKETS)
		//putting it in your pocket doesn't let you use it as access.
		UnregisterSignal(user, COMSIG_MOB_RETRIEVE_ACCESS)

/obj/item/card/id/dropped(mob/user)
	UnregisterSignal(user, list(COMSIG_MOVABLE_POINTED, COMSIG_MOB_RETRIEVE_ACCESS))
	if(isitem(loc))
		equip_to_item_loc(loc) // "dropped" into an item, like a worn wallet
	if(ishuman(user))
		var/mob/living/carbon/human/as_human = user
		as_human.update_visible_name()
	return ..()

/obj/item/card/id/dropped(mob/user, silent = FALSE)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/as_human = user
		as_human.update_visible_name()

/// Getter for the registered name, with optional honorifics
/obj/item/card/id/get_displayed_name(honorifics = FALSE)
	if(honorifics && honorific_position != HONORIFIC_POSITION_NONE && honorific_title)
		return honorific_title
	return registered_name

/// ID card is being equipped to an item (like a pda or wallet)
/obj/item/card/id/proc/equip_to_item_loc(atom/new_loc)
	RegisterSignal(new_loc, COMSIG_ITEM_EQUIPPED, PROC_REF(on_loc_equipped), override = TRUE)
	RegisterSignal(new_loc, COMSIG_ITEM_DROPPED, PROC_REF(on_loc_dropped), override = TRUE)
	if (ismob(new_loc.loc))
		var/mob/wearer = new_loc.loc
		// Equip chain shenanigans
		UnregisterSignal(wearer, list(COMSIG_MOVABLE_POINTED, COMSIG_MOB_RETRIEVE_ACCESS))
		on_loc_equipped(new_loc, wearer, wearer.get_slot_by_item(new_loc))

/// ID card is being unequipped from an item (like a pda or wallet)
/obj/item/card/id/proc/unequip_from_item_loc(atom/old_loc)
	UnregisterSignal(old_loc, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))
	if (ismob(old_loc.loc))
		UnregisterSignal(old_loc.loc, list(COMSIG_MOVABLE_POINTED, COMSIG_MOB_RETRIEVE_ACCESS))

/obj/item/card/id/proc/on_loc_equipped(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if (slot & ITEM_SLOT_ID)
		RegisterSignal(equipper, COMSIG_MOVABLE_POINTED, PROC_REF(on_pointed))
	if (slot & (ITEM_SLOT_ID|ITEM_SLOT_HANDS))
		RegisterSignal(equipper, COMSIG_MOB_RETRIEVE_ACCESS, PROC_REF(retrieve_access))

/obj/item/card/id/proc/on_loc_dropped(datum/source, mob/dropper)
	SIGNAL_HANDLER
	UnregisterSignal(dropper, list(COMSIG_MOVABLE_POINTED, COMSIG_MOB_RETRIEVE_ACCESS))

///Called when we're being used as access.
/obj/item/card/id/proc/retrieve_access(datum/source, list/player_access)
	SIGNAL_HANDLER
	player_access += GetAccess()

/obj/item/card/id/proc/on_pointed(mob/living/user, atom/pointed, obj/effect/temp_visual/point/point)
	SIGNAL_HANDLER
	if ((!big_pointer && !pointer_color) || HAS_TRAIT(user, TRAIT_UNKNOWN_APPEARANCE))
		return
	if (point.icon_state != /obj/effect/temp_visual/point::icon_state) //it differs from the original icon_state already.
		return
	if (loc != user)
		if (!isitem(loc))
			return
		var/obj/item/as_item = loc
		if (as_item.GetID() != src)
			return
	if (big_pointer)
		point.icon_state = "arrow_large"
	if (pointer_color)
		point.icon_state = "[point.icon_state]_white"
		point.color = pointer_color
		var/mutable_appearance/highlight = mutable_appearance(point.icon, "[point.icon_state]_highlights", appearance_flags = RESET_COLOR)
		point.add_overlay(highlight)

/obj/item/card/id/get_id_examine_strings(mob/user)
	. = ..()
	. += list("[icon2html(get_cached_flat_icon(), user, extra_classes = "hugeicon")]")

/obj/item/card/id/get_examine_icon(mob/user)
	return icon2html(get_cached_flat_icon(), user)

/**
 * Helper proc, checks whether the ID card can hold any given set of wildcards.
 *
 * Returns TRUE if the card can hold the wildcards, FALSE otherwise.
 * Arguments:
 * * wildcard_list - List of accesses to check.
 * * try_wildcard - If not null, will attempt to add wildcards for this wildcard specifically and will return FALSE if the card cannot hold all wildcards in this slot.
 */
/obj/item/card/id/proc/can_add_wildcards(list/wildcard_list, try_wildcard = null)
	if(!length(wildcard_list))
		return TRUE

	var/list/new_wildcard_limits = list()

	for(var/flag_name in wildcard_slots)
		if(try_wildcard && !(flag_name == try_wildcard))
			continue
		var/list/wildcard_info = wildcard_slots[flag_name]
		new_wildcard_limits[flag_name] = wildcard_info["limit"] - length(wildcard_info["usage"])

	if(!length(new_wildcard_limits))
		return FALSE

	var/wildcard_allocated
	for(var/wildcard in wildcard_list)
		var/wildcard_flag = SSid_access.get_access_flag(wildcard)
		wildcard_allocated = FALSE
		for(var/flag_name in new_wildcard_limits)
			var/limit_flags = SSid_access.wildcard_flags_by_wildcard[flag_name]
			if(!(wildcard_flag & limit_flags))
				continue
			// Negative limits mean infinite slots. Positive limits mean limited slots still available. 0 slots means no slots.
			if(new_wildcard_limits[flag_name] == 0)
				continue
			new_wildcard_limits[flag_name]--
			wildcard_allocated = TRUE
			break
		if(!wildcard_allocated)
			return FALSE

	return TRUE

/**
 * Attempts to add the given wildcards to the ID card.
 *
 * Arguments:
 * * wildcard_list - List of accesses to add.
 * * try_wildcard - If not null, will attempt to add all wildcards to this wildcard slot only.
 * * mode - The method to use when adding wildcards. See define for ERROR_ON_FAIL
 */
/obj/item/card/id/proc/add_wildcards(list/wildcard_list, try_wildcard = null, mode = ERROR_ON_FAIL)
	var/wildcard_allocated
	// Iterate through each wildcard in our list. Get its access flag. Then iterate over wildcard slots and try to fit it in.
	for(var/wildcard in wildcard_list)
		var/wildcard_flag = SSid_access.get_access_flag(wildcard)
		wildcard_allocated = FALSE
		for(var/flag_name in wildcard_slots)
			if(flag_name == WILDCARD_NAME_FORCED)
				continue

			if(try_wildcard && !(flag_name == try_wildcard))
				continue

			var/limit_flags = SSid_access.wildcard_flags_by_wildcard[flag_name]

			if(!(wildcard_flag & limit_flags))
				continue

			var/list/wildcard_info = wildcard_slots[flag_name]
			var/wildcard_limit = wildcard_info["limit"]
			var/list/wildcard_usage = wildcard_info["usage"]

			var/wildcard_count = wildcard_limit - length(wildcard_usage)

			// Negative limits mean infinite slots. Positive limits mean limited slots still available. 0 slots means no slots.
			if(wildcard_count == 0)
				continue

			wildcard_usage |= wildcard
			access |= wildcard
			wildcard_allocated = TRUE
			break
		// Fallback for if we couldn't allocate the wildcard for some reason.
		if(!wildcard_allocated)
			if(mode == ERROR_ON_FAIL)
				CRASH("Wildcard ([wildcard]) could not be added to [src].")

			if(mode == TRY_ADD_ALL)
				continue

			// If the card has no info for historic forced wildcards, create the list.
			if(!wildcard_slots[WILDCARD_NAME_FORCED])
				wildcard_slots[WILDCARD_NAME_FORCED] = list(limit = 0, usage = list())

			var/list/wildcard_info = wildcard_slots[WILDCARD_NAME_FORCED]
			var/list/wildcard_usage = wildcard_info["usage"]
			wildcard_usage |= wildcard
			access |= wildcard
			wildcard_info["limit"] = length(wildcard_usage)

/**
 * Removes wildcards from the ID card.
 *
 * Arguments:
 * * wildcard_list - List of accesses to remove.
 */
/obj/item/card/id/proc/remove_wildcards(list/wildcard_list)
	var/wildcard_removed
	// Iterate through each wildcard in our list. Get its access flag. Then iterate over wildcard slots and try to remove it.
	for(var/wildcard in wildcard_list)
		wildcard_removed = FALSE
		for(var/flag_name in wildcard_slots)
			if(flag_name == WILDCARD_NAME_FORCED)
				continue

			var/list/wildcard_info = wildcard_slots[flag_name]
			var/wildcard_usage = wildcard_info["usage"]

			if(!(wildcard in wildcard_usage))
				continue

			wildcard_usage -= wildcard
			access -= wildcard
			wildcard_removed = TRUE
			break
		// Fallback to see if this was a force-added wildcard.
		if(!wildcard_removed)
			// If the card has no info for historic forced wildcards, that's an error state.
			if(!wildcard_slots[WILDCARD_NAME_FORCED])
				stack_trace("Wildcard ([wildcard]) could not be removed from [src]. This card has no forced wildcard data and the wildcard is not in this card's wildcard lists.")

			var/list/wildcard_info = wildcard_slots[WILDCARD_NAME_FORCED]
			var/wildcard_usage = wildcard_info["usage"]

			if(!(wildcard in wildcard_usage))
				stack_trace("Wildcard ([wildcard]) could not be removed from [src]. This access is not a wildcard on this card.")

			wildcard_usage -= wildcard
			access -= wildcard
			wildcard_info["limit"] = length(wildcard_usage)

			if(!wildcard_info["limit"])
				wildcard_slots -= WILDCARD_NAME_FORCED

/**
 * Attempts to add the given accesses to the ID card as non-wildcards.
 *
 * Depending on the mode, may add accesses as wildcards or error if it can't add them as non-wildcards.
 * Arguments:
 * * add_accesses - List of accesses to check.
 * * try_wildcard - If not null, will attempt to add all accesses that require wildcard slots to this wildcard slot only.
 * * mode - The method to use when adding accesses. See define for ERROR_ON_FAIL
 */
/obj/item/card/id/proc/add_access(list/add_accesses, try_wildcard = null, mode = ERROR_ON_FAIL)
	var/list/wildcard_access = list()
	var/list/normal_access = list()

	build_access_lists(add_accesses, normal_access, wildcard_access)

	// Check if we can add the wildcards.
	if(mode == ERROR_ON_FAIL)
		if(!can_add_wildcards(wildcard_access, try_wildcard))
			CRASH("Cannot add wildcards from \[[add_accesses.Join(",")]\] to [src]")

	// All clear to add the accesses.
	access |= normal_access
	if(mode != TRY_ADD_ALL_NO_WILDCARD)
		add_wildcards(wildcard_access, try_wildcard, mode = mode)

	return TRUE

/**
 * Removes the given accesses from the ID Card.
 *
 * Will remove the wildcards if the accesses given are on the card as wildcard accesses.
 * Arguments:
 * * rem_accesses - List of accesses to remove.
 */
/obj/item/card/id/proc/remove_access(list/rem_accesses)
	var/list/wildcard_access = list()
	var/list/normal_access = list()

	build_access_lists(rem_accesses, normal_access, wildcard_access)

	access -= normal_access
	remove_wildcards(wildcard_access)

/**
 * Attempts to set the card's accesses to the given accesses, clearing all accesses not in the given list.
 *
 * Depending on the mode, may add accesses as wildcards or error if it can't add them as non-wildcards.
 * Arguments:
 * * new_access_list - List of all accesses that this card should hold exclusively.
 * * mode - The method to use when setting accesses. See define for ERROR_ON_FAIL
 */
/obj/item/card/id/proc/set_access(list/new_access_list, mode = ERROR_ON_FAIL)
	var/list/wildcard_access = list()
	var/list/normal_access = list()

	if(length(new_access_list))
		build_access_lists(new_access_list, normal_access, wildcard_access)

	// Check if we can add the wildcards.
	if(mode == ERROR_ON_FAIL)
		if(!can_add_wildcards(wildcard_access))
			CRASH("Cannot add wildcards from \[[new_access_list.Join(",")]\] to [src]")

	clear_access()

	access = normal_access.Copy()

	if(mode != TRY_ADD_ALL_NO_WILDCARD)
		add_wildcards(wildcard_access, mode = mode)

	return TRUE

/// Clears all accesses from the ID card - both wildcard and normal.
/obj/item/card/id/proc/clear_access()
	// Go through the wildcards and reset them.
	for(var/flag_name in wildcard_slots)
		var/list/wildcard_info = wildcard_slots[flag_name]
		var/list/wildcard_usage = wildcard_info["usage"]
		wildcard_usage.Cut()

	// Hard reset access
	access.Cut()

/// Sets the bank account for the ID card.
/obj/item/card/id/proc/set_account(datum/bank_account/account, transfer_funds = FALSE)
	if(registered_account == account)
		return
	if(!isnull(registered_account))
		if(transfer_funds)
			account?.transfer_money(registered_account, registered_account.account_balance, "Account transfer")
		clear_account()
	if(isnull(account))
		return

	if(src in account.bank_cards)
		stack_trace("Despite [src] not being registered to [account], the account already has it within the bank_cards list.")

	registered_account = account
	LAZYOR(registered_account.bank_cards, src)
	registered_account.civilian_bounty?.on_selected(src)

/// Clears the economy account from the ID card.
/obj/item/card/id/proc/clear_account()
	if(isnull(registered_account))
		return

	registered_account.civilian_bounty?.on_reset(src)
	LAZYREMOVE(registered_account.bank_cards, src)
	registered_account = null


/**
 * Helper proc. Creates access lists for the access procs.
 *
 * Takes the accesses list and compares it with the trim. Any basic accesses that match the trim are
 * added to basic_access_list and the rest are added to wildcard_access_list.

 * This proc directly modifies the lists passed in as args. It expects these lists to be instantiated.
 * There is no return value.
 * Arguments:
 * * accesses - List of accesses you want to stort into basic_access_list and wildcard_access_list. Should not be null.
 * * basic_access_list - Mandatory argument. The proc modifies the list passed in this argument and adds accesses the trim supports to it.
 * * wildcard_access_list - Mandatory argument. The proc modifies the list passed in this argument and adds accesses the trim does not support to it.
 */
/obj/item/card/id/proc/build_access_lists(list/accesses, list/basic_access_list, list/wildcard_access_list)
	if(!length(accesses) || isnull(basic_access_list) || isnull(wildcard_access_list))
		CRASH("Invalid parameters passed to build_access_lists")

	var/list/trim_accesses = trim?.access

	// Populate the lists.
	for(var/new_access in accesses)
		if(new_access in trim_accesses)
			basic_access_list |= new_access
			continue

		wildcard_access_list |= new_access

/// Helper proc that determines if a card can be used in certain types of payment transactions.
/obj/item/card/id/proc/can_be_used_in_payment(mob/living/user)
	if(QDELETED(src) || isnull(registered_account?.account_job) || !isliving(user))
		return FALSE

	return TRUE

/obj/item/card/id/attack_self(mob/user)
	if(Adjacent(user))
		var/minor
		if(registered_name && registered_age && registered_age < AGE_MINOR)
			minor = " <b>[registered_age]</b>" //SKYRAT EDIT CHANGE
		user.visible_message(span_notice("[user]向你展示：[icon2html(src, viewers(user))] [src.name][minor]。"), span_notice("你展示了[src.name][minor]。"))
	add_fingerprint(user)

/obj/item/card/id/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!check_allowed_items(interacting_with) || !isfloorturf(interacting_with))
		return NONE
	try_project_paystand(user, interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/card/id/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	try_project_paystand(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/card/id/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	context[SCREENTIP_CONTEXT_RMB] = "投影收款台"

	if(isnull(held_item) || (held_item == src))
		context[SCREENTIP_CONTEXT_LMB] = "出示身份卡"
	else if(iscash(held_item) || istype(held_item, /obj/item/storage/bag/money))
		context[SCREENTIP_CONTEXT_LMB] = "插入"
	else if(istype(held_item, /obj/item/rupee))
		context[SCREENTIP_CONTEXT_LMB] = "插入？"

	if(isnull(registered_account) || registered_account.replaceable) //Same check we use when we check if we can assign an account
		context[SCREENTIP_CONTEXT_ALT_RMB] = "关联账户"
	else if(registered_account.account_balance > 0)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "提取[MONEY_NAME]"
	if(trim && length(trim.honorifics))
		context[SCREENTIP_CONTEXT_CTRL_LMB] = "切换敬称"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/card/id/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	. = ..()
	if(iscash(target))
		context[SCREENTIP_CONTEXT_LMB] = "存入卡片"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/card/id/proc/try_project_paystand(mob/user, turf/target)
	if(!COOLDOWN_FINISHED(src, last_holopay_projection))
		balloon_alert(user, "仍在充能")
		return
	if(!can_be_used_in_payment(user))
		balloon_alert(user, "没有账户！")
		to_chat(user, span_warning("你需要有效的银行账户才能这样做。"))
		return
	/// Determines where the holopay will be placed based on tile contents
	var/turf/projection
	var/turf/step_ahead = get_step(user, user.dir)
	var/turf/user_loc = user.loc
	if(target && can_proj_holopay(target))
		projection = target
	else if(can_proj_holopay(step_ahead))
		projection = step_ahead
	else if(can_proj_holopay(user_loc))
		projection = user_loc
	if(!projection)
		balloon_alert(user, "没有空间")
		to_chat(user, span_warning("你需要站在空地上或附近才能这样做。"))
		return
	/// Success: Valid tile for holopay placement
	if(my_store)
		my_store.dissipate()
	var/obj/structure/holopay/new_store = new(projection)
	if(new_store?.assign_card(projection, src))
		COOLDOWN_START(src, last_holopay_projection, HOLOPAY_PROJECTION_INTERVAL)
		playsound(projection, 'sound/effects/empulse.ogg', 40, TRUE)
		my_store = new_store

/**
 * Determines whether a new holopay can be placed on the given turf.
 * Checks if there are dense contents, too many contents, or another
 * holopay already exists on the turf.
 *
 * Arguments:
 * * turf/target - The target turf to be checked for dense contents
 * Returns:
 * * TRUE if the target is a valid holopay location, FALSE otherwise.
 */
/obj/item/card/id/proc/can_proj_holopay(turf/target)
	if(!isfloorturf(target))
		return FALSE
	if(target.density)
		return FALSE
	if(length(target.contents) > 5)
		return FALSE
	for(var/obj/checked_obj in target.contents)
		if(checked_obj.density)
			return FALSE
		if(istype(checked_obj, /obj/structure/holopay))
			return FALSE
	return TRUE

/**
 * Setter for the shop logo on linked holopays
 *
 * Arguments:
 * * new_logo - The new logo to be set.
 */
/obj/item/card/id/proc/set_holopay_logo(new_logo)
	if(!available_logos.Find(new_logo))
		CRASH("User input a holopay shop logo that didn't exist.")
	holopay_logo = new_logo

/**
 * Setter for changing the force fee on a holopay.
 *
 * Arguments:
 * * new_fee - The new fee to be set.
 */
/obj/item/card/id/proc/set_holopay_fee(new_fee)
	if(!isnum(new_fee))
		CRASH("User input a non number into the holopay fee field.")
	if(new_fee < holopay_min_fee || new_fee > holopay_max_fee)
		CRASH("User input a number outside of the valid range into the holopay fee field.")
	holopay_fee = new_fee

/**
 * Setter for changing the holopay name.
 *
 * Arguments:
 * * new_name - The new name to be set.
 */
/obj/item/card/id/proc/set_holopay_name(name)
	if(length(name) < 3 || length(name) > MAX_NAME_LEN)
		to_chat(usr, span_warning("长度必须为 3 至 42 个字符。"))
	else
		holopay_name = html_encode(trim(name, MAX_NAME_LEN))


/obj/item/card/id/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if(NAMEOF(src, assignment), NAMEOF(src, registered_name), NAMEOF(src, registered_age))
				update_label()
				update_appearance()
			if(NAMEOF(src, trim))
				if(ispath(trim))
					SSid_access.apply_trim_to_card(src, trim)

/obj/item/card/id/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/rupee))
		to_chat(user, span_warning("你的身份卡机智地拒绝了这块奇怪的玻璃碎片。谁能想到，它居然真的不值钱！"))
		return ITEM_INTERACT_BLOCKING
	else if(iscash(tool))
		return insert_money(tool, user) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING
	else if(istype(tool, /obj/item/storage/bag/money))
		var/obj/item/storage/bag/money/money_bag = tool
		var/list/money_contained = money_bag.contents
		var/money_added = mass_insert_money(money_contained, user)
		if(!money_added)
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你把里面的东西塞进卡片！它们在一阵蓝空间烟雾中消失，为关联账户增加了[money_added][MONEY_NAME]。"))
		return ITEM_INTERACT_SUCCESS
	/// SKYRAT EDIT BEGINS - Trim Tokens - Proc defined in modular_skyrat/modules/trim_tokens/code/cards_id.dm
	else if(istype(tool, /obj/item/trim_token))
		apply_token(tool, user)
		return
	/// SKYRAT EDIT ENDS
	return NONE

/**
 * Insert credits or coins into the ID card and add their value to the associated bank account.
 *
 * Returns TRUE if the money was successfully inserted, FALSE otherwise.
 * Arguments:
 * money - The item to attempt to convert to credits and insert into the card.
 * user - The user inserting the item.
 * physical_currency - Boolean, whether this is a physical currency such as a coin and not a holochip.
 */
/obj/item/card/id/proc/insert_money(obj/item/money, mob/user)
	var/physical_currency
	if(istype(money, /obj/item/stack/spacecash) || istype(money, /obj/item/coin) || istype(money, /obj/item/poker_chip))
		physical_currency = TRUE

	if(!registered_account)
		to_chat(user, span_warning("[src]没有可供存入[money]的关联账户！"))
		return FALSE
	var/cash_money = money.get_item_credit_value()
	if(!cash_money)
		to_chat(user, span_warning("[money]看起来一文不值！"))
		return FALSE
	registered_account.adjust_money(cash_money, "System: Deposit")
	SSblackbox.record_feedback("amount", "credits_inserted", cash_money)
	log_econ("[cash_money] [MONEY_NAME] were inserted into [src] owned by [src.registered_name]")
	if(physical_currency)
		to_chat(user, span_notice("你把[money]塞进[src]。它在一小阵蓝空间烟雾中消失，为关联账户增加了[cash_money][MONEY_NAME]。"))
	else
		to_chat(user, span_notice("你把[money]存入[src]，为关联账户增加了[cash_money][MONEY_NAME]。"))

	to_chat(user, span_notice("关联账户当前余额为[registered_account.account_balance][MONEY_SYMBOL]。"))
	qdel(money)
	return TRUE

/**
 * Insert multiple money or money-equivalent items at once.
 *
 * Arguments:
 * money - List of items to attempt to convert to credits and insert into the card.
 * user - The user inserting the items.
 */
/obj/item/card/id/proc/mass_insert_money(list/money, mob/user)
	if(!registered_account)
		to_chat(user, span_warning("[src]没有可供存款的关联账户！"))
		return FALSE

	if (!money || !length(money))
		return FALSE

	var/total = 0

	for (var/obj/item/physical_money in money)
		total += physical_money.get_item_credit_value()
		CHECK_TICK

	registered_account.adjust_money(total, "System: Deposit")
	SSblackbox.record_feedback("amount", "credits_inserted", total)
	log_econ("[total] [MONEY_NAME] were inserted into [src] owned by [src.registered_name]")
	QDEL_LIST(money)

	return total

/// Helper proc. Can the user alt-click the ID?
/obj/item/card/id/proc/alt_click_can_use_id(mob/living/user)
	if(!isliving(user))
		return FALSE
	return TRUE

/// Attempts to set a new bank account on the ID card.
/obj/item/card/id/proc/set_new_account(mob/living/user)
	. = FALSE
	if(loc != user)
		to_chat(user, span_warning("你必须拿着身份卡才能继续！"))
		return FALSE
	var/list/user_memories = user.mind.memories
	var/datum/memory/key/account/user_key = user_memories[/datum/memory/key/account]
	var/default_account = (istype(user_key) && user_key.remembered_id) || 11111
	var/new_bank_id = tgui_input_number(user, "请输入要与此卡关联的账户号码。", "关联银行账户", default_account, 999999, 111111)
	if(!new_bank_id || QDELETED(user) || QDELETED(src) || issilicon(user) || !alt_click_can_use_id(user) || loc != user)
		return FALSE
	if(registered_account?.account_id == new_bank_id)
		to_chat(user, span_warning("这个账户号码已经关联到此卡。"))
		return FALSE
	var/datum/bank_account/account = SSeconomy.bank_accounts_by_id["[new_bank_id]"]
	if(isnull(account))
		to_chat(user, span_warning("提供的账户号码无效。"))
		return FALSE
	set_account(account, transfer_funds = TRUE)
	to_chat(user, span_notice("提供的账户已关联到此身份卡，账户余额为[account.account_balance][MONEY_NAME]。"))
	return TRUE

/obj/item/card/id/click_alt(mob/living/user)
	if(!alt_click_can_use_id(user))
		return NONE
	if (LAZYLEN(registered_account.being_dumped))
		registered_account.bank_card_talk(span_warning("内部服务器错误"), TRUE)
		return CLICK_ACTION_SUCCESS
	if(registered_account.account_debt)
		var/choice = tgui_alert(user, "选择操作", "银行账户", list("取款", "偿还债务"))
		if(!choice || QDELETED(user) || QDELETED(src) || !alt_click_can_use_id(user) || loc != user)
			return CLICK_ACTION_BLOCKING
		if(choice == "偿还债务")
			pay_debt(user)
			return CLICK_ACTION_SUCCESS
	if(loc != user)
		to_chat(user, span_warning("你必须拿着身份卡才能继续！"))
		return CLICK_ACTION_BLOCKING
	if(registered_account.replaceable && !registered_account.account_balance)
		var/choice = tgui_alert(user, "此卡尚未关联账户。要关联银行账户吗？", "银行账户", list("关联账户", "保持未关联"))
		if(!choice || QDELETED(user) || QDELETED(src) || !alt_click_can_use_id(user) || loc != user)
			return CLICK_ACTION_BLOCKING
		if(choice == "关联账户")
			set_new_account(user)
			return CLICK_ACTION_SUCCESS
	var/amount_to_remove = tgui_input_number(user, "你想提取多少？（最多：[registered_account.account_balance][MONEY_SYMBOL]）", "取款", max_value = registered_account.account_balance)
	if(!amount_to_remove || QDELETED(user) || QDELETED(src) || issilicon(user) || loc != user)
		return CLICK_ACTION_BLOCKING
	if(!alt_click_can_use_id(user))
		return CLICK_ACTION_BLOCKING
	if(!registered_account.adjust_money(-amount_to_remove, "System: Withdrawal"))
		var/difference = amount_to_remove - registered_account.account_balance
		registered_account.bank_card_talk(span_warning("错误：关联账户还需要[difference][MONEY_NAME_AUTOPURAL(difference)]才能完成这笔取款。"), TRUE)
		return CLICK_ACTION_BLOCKING
	var/obj/item/holochip/holochip = new (user.drop_location(), amount_to_remove)
	user.put_in_hands(holochip)
	to_chat(user, span_notice("你将[amount_to_remove][MONEY_NAME]提取到了全息芯片中。"))
	SSblackbox.record_feedback("amount", "credits_removed", amount_to_remove)
	log_econ("[amount_to_remove] [MONEY_NAME] were removed from [src] owned by [registered_name]")
	return CLICK_ACTION_SUCCESS


/obj/item/card/id/click_alt_secondary(mob/user)
	if(!alt_click_can_use_id(user))
		return
	if(!registered_account || registered_account.replaceable)
		set_new_account(user)

/obj/item/card/id/proc/pay_debt(user)
	var/amount_to_pay = tgui_input_number(user, "你想偿还多少？（最多：[registered_account.account_balance][MONEY_SYMBOL]）", "偿还债务", max_value = min(registered_account.account_balance, registered_account.account_debt))
	if(!amount_to_pay || QDELETED(src) || loc != user || !alt_click_can_use_id(user))
		return
	var/prev_debt = registered_account.account_debt
	var/amount_paid = registered_account.pay_debt(amount_to_pay)
	if(amount_paid)
		var/message = span_notice("你偿还了[prev_debt][MONEY_SYMBOL]债务中的[amount_to_pay][MONEY_NAME]，还剩[registered_account.account_debt][MONEY_SYMBOL]。")
		if(!registered_account.account_debt)
			message = span_nicegreen("你偿还了最后[amount_to_pay][MONEY_NAME]的债务，现已全部还清。恭喜！")
		to_chat(user, message)

/obj/item/card/id/examine(mob/user)
	. = ..()
	if(!user.can_read(src))
		return

	if(registered_account && !isnull(registered_account.account_id))
		. += "身份卡关联账户的持有人为‘[registered_account.account_holder]’，余额为[registered_account.account_balance][MONEY_SYMBOL]。"
		if(ACCESS_COMMAND in access)
			var/datum/bank_account/linked_dept = SSeconomy.get_dep_account(registered_account.account_job.paycheck_department)
			. += "身份卡关联的[linked_dept.account_holder]余额为[linked_dept.account_balance][MONEY_SYMBOL]。"
	else
		. += span_notice("按住 Alt 右键点击身份卡可设置关联的银行账户。")

	if(HAS_TRAIT(user, TRAIT_ID_APPRAISER))
		. += HAS_TRAIT(src, TRAIT_JOB_FIRST_ID_CARD) ? span_boldnotice("嗯……没错，这张身份卡是中央指挥部签发的！") : span_boldnotice("这张身份卡是在本星区制作的，并非中央指挥部签发。")
		if(HAS_TRAIT(src, TRAIT_TASTEFULLY_THICK_ID_CARD) && (user.is_holding(src) || (IsReachableBy(user) && user.put_in_hands(src, ignore_animation = FALSE))))
			ADD_TRAIT(src, TRAIT_NODROP, "psycho")
			. += span_hypnophrase("看看这细腻的配色……这恰到好处的厚度。天哪，它甚至还有水印……")
			var/sound/slowbeat = sound('sound/effects/health/slowbeat.ogg', repeat = TRUE)
			user.playsound_local(get_turf(src), slowbeat, 40, 0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
			if(isliving(user))
				var/mob/living/living_user = user
				living_user.adjust_jitter(10 SECONDS)
			addtimer(CALLBACK(src, PROC_REF(drop_card), user), 10 SECONDS)
	. += span_notice("<i>下方还有更多信息，你可以再次查看以仔细阅读……</i>")

/obj/item/card/id/proc/drop_card(mob/user)
	user.stop_sound_channel(CHANNEL_HEARTBEAT)
	REMOVE_TRAIT(src, TRAIT_NODROP, "psycho")
	if(user.is_holding(src))
		user.dropItemToGround(src)
	for(var/mob/living/carbon/human/viewing_mob in viewers(2, user))
		if(IS_UNCONSCIOUS_OR_CRIT(viewing_mob) || viewing_mob == user)
			continue
		viewing_mob.say("有什么不对吗？[first_name(user.name)]……你在流汗。", forced = "psycho")
		break

/obj/item/card/id/examine_more(mob/user)
	. = ..()
	if(!user.can_read(src))
		return

	. += span_notice("<i>你仔细查看[src]，注意到了以下信息……</i>")

	if(registered_age)
		. += "卡片显示持有人年龄为[registered_age]岁。[(registered_age < AGE_MINOR) ? "卡片底部的全息条带写着<b>[span_danger("‘未成年人：禁止提供烟酒’")]</b>。" : ""]"
	if(registered_account)
		if(registered_account.mining_points)
			. += "卡片的银行账户中存有[registered_account.mining_points]矿业积分。"
		. += "身份卡关联账户的持有人为‘[registered_account.account_holder]’，余额为[registered_account.account_balance][MONEY_SYMBOL]。"
		if(registered_account.account_debt)
			. += span_warning("账户目前欠款[registered_account.account_debt][MONEY_SYMBOL]。全部收入的[100*DEBT_COLLECTION_COEFF]%将用于偿还欠款。")
		if(registered_account.account_job)
			var/datum/bank_account/D = SSeconomy.get_dep_account(registered_account.account_job.paycheck_department)
			if(D)
				. += "[D.account_holder]余额为[D.account_balance][MONEY_SYMBOL]。"
		. += span_info("按住 Alt 点击身份卡，可以从关联账户中提取全息芯片形式的款项。")
		. += span_info("将全息芯片、现金或硬币贴到身份卡上，即可把[MONEY_NAME]存入关联账户。")
		if(registered_account.replaceable)
			. += span_info("按住 Alt 右键点击身份卡可更换关联的银行账户。")
		if(registered_account.civilian_bounty)
			. += span_info("<b>有一项进行中的平民悬赏。</b>")
			. += span_info("<i>[registered_account.bounty_text()]</i>")
			. += span_info("数量：[registered_account.bounty_num()]")
			. += span_info("奖励：[registered_account.bounty_value()]")
		if(registered_account.account_holder == user.real_name)
			. += span_boldnotice("如果丢失此身份卡，你可以手持空白身份卡，按住 Alt 点击并输入账户号码，以重新关联账户。")
	else
		. += span_info("此卡未关联任何注册账户。按住 Alt 点击以添加账户。")

	return .

/obj/item/card/id/GetAccess()
	var/list/total_access = access.Copy()

	// Add all RETA temporary access from all departments - code/modules/reta/reta_system.dm
	for(var/dept in reta_temp_access)
		if(reta_temp_access[dept])
			total_access |= reta_temp_access[dept]

	return total_access

/obj/item/card/id/GetID()
	return src

/obj/item/card/id/remove_id()
	return src

/// Called on COMSIG_ATOM_UPDATED_ICON. Updates the visuals of the wallet this card is in.
/obj/item/card/id/proc/update_in_wallet()
	SIGNAL_HANDLER

	if(istype(loc, /obj/item/storage/wallet))
		var/obj/item/storage/wallet/powergaming = loc
		if(powergaming.front_id == src)
			powergaming.update_label()
			powergaming.update_appearance()

/// Updates the name based on the card's vars and state.
/obj/item/card/id/proc/update_label()
	var/name_string
	if(registered_name)
		if(trim && (honorific_position & ~HONORIFIC_POSITION_NONE))
			name_string = "[update_honorific()]的身份卡"
		else
			name_string = "[registered_name]的身份卡"
	else
		name_string = initial(name)

	var/assignment_string= chinese_job_display(get_job_title()) // BUBBER EDIT: Adds a new proc which is used to get a job title

	/* BUBBER EDIT: Moved to `get_job_title()`
	if(is_intern)
		if(assignment)
			assignment_string = trim?.intern_alt_name || "Intern [assignment]"
		else
			assignment_string = "Intern"
	else
		assignment_string = assignment
	*/

	name = "[name_string] ([assignment_string])"

	if(ishuman(loc))
		var/mob/living/carbon/human/human = loc
		human.update_visible_name()

/// Re-generates the honorific title. Returns the compiled honorific_title value
/obj/item/card/id/proc/update_honorific()
	switch(honorific_position)
		if(HONORIFIC_POSITION_FIRST)
			honorific_title = "[chinese_id_honorific_display(chosen_honorific)] [first_name(registered_name)]"
		if(HONORIFIC_POSITION_LAST)
			honorific_title = "[chinese_id_honorific_display(chosen_honorific)] [last_name(registered_name)]"
		if(HONORIFIC_POSITION_FIRST_FULL)
			honorific_title = "[chinese_id_honorific_display(chosen_honorific)] [registered_name]"
		if(HONORIFIC_POSITION_LAST_FULL)
			honorific_title = "[registered_name][chinese_id_honorific_display(chosen_honorific)]"
	return honorific_title

/// Returns the trim assignment name.
/obj/item/card/id/proc/get_trim_assignment()
	return trim?.assignment || assignment

/// Returns the trim sechud icon state.
/obj/item/card/id/proc/get_trim_sechud_icon()
	return trim?.sechud_icon || DEFAULT_HUDS_DMI

/// Returns the trim sechud icon state.
/obj/item/card/id/proc/get_trim_sechud_icon_state()
	return trim?.sechud_icon_state || SECHUD_UNKNOWN

/obj/item/card/id/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(iscash(interacting_with))
		return insert_money(interacting_with, user) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING
	return NONE

/obj/item/card/id/item_ctrl_click(mob/user)
	if(!in_contents_of(user) || user.incapacitated) //Check if the ID is in the ID slot, so it can be changed from there too.
		return

	if(!trim)
		balloon_alert(user, "卡片没有饰边！")
		return

	if(!length(trim.honorifics))
		balloon_alert(user, "卡片没有可用敬称！")
		return

	var/list/choices = list()
	var/list/readable_names = HONORIFIC_POSITION_BITFIELDS()
	for(var/i in readable_names) //Filter out the options you don't have on your ID.
		if(trim.honorific_positions & readable_names[i]) //If the positions list has the same bit value as the readable list.
			choices += i

	var/chosen_position = tgui_input_list(user, "你想把敬称放在哪里？", "个性装点！", choices)
	if(user.incapacitated || !in_contents_of(user))
		return
	var/honorific_position_to_use = readable_names[chosen_position]

	honorific_position = initial(honorific_position) //In case you want to force an honorific on an ID, set a default that won't always be NONE.
	honorific_title = null //We reset this regardless so that we don't stack titles on accident.

	if(honorific_position_to_use & HONORIFIC_POSITION_NONE)
		balloon_alert(user, "已禁用敬称")
	else
		var/new_honorific = chinese_id_honorific_choice(user, "你想使用哪个敬称？", "个性装点！！！", trim.honorifics)
		if(!new_honorific || user.incapacitated || !in_contents_of(user))
			return
		chosen_honorific = new_honorific
		switch(honorific_position_to_use)
			if(HONORIFIC_POSITION_FIRST)
				honorific_position = HONORIFIC_POSITION_FIRST
				balloon_alert(user, "已设置敬称：显示名字")
			if(HONORIFIC_POSITION_LAST)
				honorific_position = HONORIFIC_POSITION_LAST
				balloon_alert(user, "已设置敬称：显示姓氏")
			if(HONORIFIC_POSITION_FIRST_FULL)
				honorific_position = HONORIFIC_POSITION_FIRST_FULL
				balloon_alert(user, "已设置敬称：全名之前")
			if(HONORIFIC_POSITION_LAST_FULL)
				honorific_position = HONORIFIC_POSITION_LAST_FULL
				balloon_alert(user, "已设置敬称：全名之后")

	update_label()

/obj/item/card/id/away
	name = "\proper 平平无奇的身份识别卡"
	desc = "一张平平无奇的身份识别卡，似乎需要添点特色。"
	trim = /datum/id_trim/away
	icon_state = "retro"
	registered_age = null

/obj/item/card/id/away/hotel
	name = "员工身份卡"
	desc = "用于开启酒店门禁的员工身份卡。"
	trim = /datum/id_trim/away/hotel

/obj/item/card/id/away/hotel/security
	name = "军官身份卡"
	trim = /datum/id_trim/away/hotel/security

/obj/item/card/id/away/old
	name = "\proper 平平无奇的身份识别卡"
	desc = "一张平平无奇的身份识别卡，似乎需要添点特色。"

/obj/item/card/id/away/old/sec
	name = "查理站安保官身份卡"
	desc = "一张褪色的查理站身份卡，依稀能辨认出“安保官”字样。"
	trim = /datum/id_trim/away/old/sec

/obj/item/card/id/away/old/sci
	name = "查理站科学家身份卡"
	desc = "一张褪色的查理站身份卡，依稀能辨认出“科学家”字样。"
	trim = /datum/id_trim/away/old/sci

/obj/item/card/id/away/old/eng
	name = "查理站工程师身份卡"
	desc = "一张褪色的查理站身份卡，依稀能辨认出“空间站工程师”字样。"
	trim = /datum/id_trim/away/old/eng

/obj/item/card/id/away/old/equipment
	name = "工程设备通行卡"
	desc = "一张能够使用工程设备的特殊身份卡。"
	trim = /datum/id_trim/away/old/equipment

/obj/item/card/id/away/old/robo
	name = "德尔塔站机器人专家身份卡"
	desc = "一张能够访问机器人维护协议的身份卡。"
	trim = /datum/id_trim/away/old/robo

/obj/item/card/id/away/deep_storage //deepstorage.dmm space ruin
	name = "地堡通行身份卡"

/obj/item/card/id/away/filmstudio
	name = "电影制片厂身份卡"
	desc = "一张能够开启电影制片厂内各种气闸的身份卡。"

/obj/item/card/id/departmental_budget
	name = "部门卡（错误）"
	desc = "用于支取部门预算。"
	icon_state = "budgetcard"
	var/department_ID = ACCOUNT_CIV
	var/department_name = ACCOUNT_CIV_NAME
	registered_age = null

/obj/item/card/id/departmental_budget/Initialize(mapload)
	. = ..()
	var/datum/bank_account/department_account = SSeconomy.get_dep_account(department_ID)
	if(department_account)
		set_account(department_account)
		name = "部门卡（[department_name]）"
		desc = "用于支取[department_name]。"
	SSeconomy.dep_cards += src

/obj/item/card/id/departmental_budget/Destroy()
	SSeconomy.dep_cards -= src
	return ..()

/obj/item/card/id/departmental_budget/update_label()
	return

/obj/item/card/id/departmental_budget/car
	department_ID = ACCOUNT_CAR
	department_name = ACCOUNT_CAR_NAME
	icon_state = "car_budget" //saving up for a new tesla

/obj/item/card/id/departmental_budget/click_alt(mob/living/user)
	registered_account.bank_card_talk(span_warning("此卡的设计不支持取款。"), TRUE) //prevents the vault bank machine being useless and putting money from the budget to your card to go over personal crates
	return CLICK_ACTION_BLOCKING

/obj/item/card/id/advanced
	name = "身份识别卡"
	desc = "用于证明身份及确定空间站各处通行权限的卡片，内置数字显示屏和先进微芯片。"
	icon_state = "card_grey"

	wildcard_slots = WILDCARD_LIMIT_GREY
	flags_1 = UNPAINTABLE_1
	trim_changeable = TRUE

	/// An overlay icon state for when the card is assigned to a name. Usually manifests itself as a little scribble to the right of the job icon.
	var/assigned_icon_state = "assigned"

	/// If this is set, will manually override the icon file for the trim. Intended for admins to VV edit and chameleon ID cards.
	var/trim_icon_override
	/// If this is set, will manually override the icon state for the trim. Intended for admins to VV edit and chameleon ID cards.
	var/trim_state_override
	/// If this is set, will manually override the department color for this trim. Intended for admins to VV edit and chameleon ID cards.
	var/department_color_override
	/// If this is set, will manually override the department icon state for the trim. Intended for admins to VV edit and chameleon ID cards.
	var/department_state_override
	/// If this is set, will manually override the subdepartment color for this trim. Intended for admins to VV edit and chameleon ID cards.
	var/subdepartment_color_override
	/// If this is set, will manually override the trim's assignmment as it appears in the crew monitor and elsewhere. Intended for admins to VV edit and chameleon ID cards.
	var/trim_assignment_override
	/// If this is set, will manually override the trim shown for SecHUDs. Intended for admins to VV edit and chameleon ID cards.
	var/sechud_icon_state_override = null

	/// A name (eg "Captain") that is "inherent" to this ID card
	/// If the assigned name matches the inherent name it does not apply the label
	var/inherent_assigned_name

/obj/item/card/id/advanced/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(update_intern_status))
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(remove_intern_status))

/obj/item/card/id/advanced/Destroy()
	UnregisterSignal(src, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))

	return ..()

/obj/item/card/id/advanced/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(istype(held_item, /obj/item/toy/crayon))
		context[SCREENTIP_CONTEXT_LMB] = "为身份卡改色"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/card/id/advanced/proc/after_input_check(mob/user)
	if(QDELETED(user) || QDELETED(src) || !user.client || !user.can_perform_action(src, NEED_DEXTERITY|FORBID_TELEKINESIS_REACH))
		return FALSE
	return TRUE

/obj/item/card/id/advanced/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(.)
		return .

	if(istype(tool, /obj/item/toy/crayon))
		return recolor_id(user, tool)

/obj/item/card/id/advanced/proc/recolor_id(mob/living/user, obj/item/toy/crayon/our_crayon)
	if(our_crayon.is_capped)
		balloon_alert(user, "先取下笔帽！")
		return ITEM_INTERACT_BLOCKING
	var/choice = tgui_alert(usr, "要更改部门还是子部门的颜色？", "身份卡改色……", list("部门", "子部门"))
	if(isnull(choice) \
		|| QDELETED(user) \
		|| QDELETED(src) \
		|| QDELETED(our_crayon) \
		|| !usr.can_perform_action(src, ALLOW_RESTING) \
		|| !usr.can_perform_action(our_crayon, ALLOW_RESTING) \
	)
		return ITEM_INTERACT_BLOCKING

	switch(choice)
		if("部门")
			if(!do_after(user, 2 SECONDS))
				return ITEM_INTERACT_BLOCKING
			department_color_override = our_crayon.paint_color
			balloon_alert(user, "已改色")
		if("子部门")
			if(!do_after(user, 1 SECONDS))
				return ITEM_INTERACT_BLOCKING
			subdepartment_color_override = our_crayon.paint_color
			balloon_alert(user, "已改色")
	update_icon()
	return ITEM_INTERACT_SUCCESS

/obj/item/card/id/advanced/on_loc_equipped(datum/source, mob/equipper, slot)
	. = ..()
	if(istype(loc, /obj/item/storage/wallet) || istype(loc, /obj/item/modular_computer))
		update_intern_status(source, equipper, slot)

/obj/item/card/id/advanced/on_loc_dropped(datum/source, mob/dropper)
	. = ..()
	if(istype(loc, /obj/item/storage/wallet) || istype(loc, /obj/item/modular_computer))
		remove_intern_status(source, dropper)

/obj/item/card/id/advanced/proc/update_intern_status(datum/source, mob/user, slot)
	SIGNAL_HANDLER

	if(!user?.client)
		return
	if(!CONFIG_GET(flag/use_exp_tracking))
		return
	if(!CONFIG_GET(flag/use_low_living_hour_intern))
		return
	if(!SSdbcore.Connect())
		return

	var/intern_threshold = (CONFIG_GET(number/use_low_living_hour_intern_hours) * 60) || (CONFIG_GET(number/use_exp_restrictions_heads_hours) * 60) || INTERN_THRESHOLD_FALLBACK_HOURS * 60
	var/playtime = user.client.get_exp_living(pure_numeric = TRUE)

	if((intern_threshold >= playtime) && (user.mind?.assigned_role.job_flags & JOB_CAN_BE_INTERN))
		is_intern = TRUE
		update_label()
		return

	if(!is_intern)
		return

	is_intern = FALSE
	update_label()

/obj/item/card/id/advanced/proc/remove_intern_status(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!is_intern)
		return

	is_intern = FALSE
	update_label()

/obj/item/card/id/advanced/update_label()
	if(inherent_assigned_name && registered_name == inherent_assigned_name)
		name = "[initial(name)][(!assignment || assignment == inherent_assigned_name) ? "" : " ([chinese_job_display(assignment)])"]"
		return

	return ..()

/obj/item/card/id/advanced/update_overlays()
	. = ..()

	if(registered_name && registered_name != "Captain")
		. += mutable_appearance(icon, assigned_icon_state)

	var/trim_icon_file = trim_icon_override ? trim_icon_override : trim?.trim_icon
	var/trim_icon_state = trim_state_override ? trim_state_override : trim?.trim_state
	var/trim_department_color = department_color_override ? department_color_override : trim?.department_color
	var/trim_department_state = department_state_override ? department_state_override : trim?.department_state
	var/trim_subdepartment_color = subdepartment_color_override ? subdepartment_color_override : trim?.subdepartment_color

	if(!trim_icon_file || !trim_icon_state || !trim_department_color || !trim_subdepartment_color || !trim_department_state)
		return

	/// We handle department and subdepartment overlays first, so the job icon is always on top.
	var/mutable_appearance/department_overlay = mutable_appearance(trim_icon_file, trim_department_state)
	department_overlay.color = trim_department_color
	. += department_overlay

	var/mutable_appearance/subdepartment_overlay = mutable_appearance(trim_icon_file, "subdepartment")
	subdepartment_overlay.color = trim_subdepartment_color
	. += subdepartment_overlay

	/// Then we handle the job's icon here.
	. += mutable_appearance(trim_icon_file, trim_icon_state)

/obj/item/card/id/advanced/get_trim_assignment()
	if(trim_assignment_override)
		return trim_assignment_override

	if(ispath(trim))
		var/datum/id_trim/trim_singleton = SSid_access.trim_singletons_by_path[trim]
		return trim_singleton.assignment

	return ..()

/// Returns the trim sechud icon state.
/obj/item/card/id/advanced/get_trim_sechud_icon_state()
	return sechud_icon_state_override || ..()

/obj/item/card/id/advanced/rainbow
	name = "彩虹身份识别卡"
	desc = "一张彩虹色卡片，以‘符合商务规范’的方式倡导乐趣！"
	icon_state = "card_rainbow"

/obj/item/card/id/advanced/silver
	name = "银色身份识别卡"
	desc = "彰显荣誉与奉献精神的银色卡片。"
	icon_state = "card_silver"
	inhand_icon_state = "silver_id"
	assigned_icon_state = "assigned_silver"
	wildcard_slots = WILDCARD_LIMIT_SILVER

/obj/item/card/id/advanced/robotic
	name = "磁性身份识别卡"
	desc = "一张集成式卡片，彰显了为打开大门所付出的努力。"
	icon_state = "card_carp" //im not a spriter
	inhand_icon_state = "silver_id"
	assigned_icon_state = "assigned_silver"
	wildcard_slots = WILDCARD_LIMIT_GREY

/datum/id_trim/maint_reaper
	access = list(ACCESS_MAINT_TUNNELS)
	trim_state = "trim_janitor"
	assignment = "Reaper"

/obj/item/card/id/advanced/silver/reaper
	name = "十三的身份卡（收割者）"
	trim = /datum/id_trim/maint_reaper
	registered_name = "Thirteen"

/obj/item/card/id/advanced/platinum
	name = "铂金身份识别卡"
	desc = "彰显最高奉献精神的铂金卡片。"
	icon_state = "card_platinum"
	inhand_icon_state = "platinum_id"
	assigned_icon_state = "assigned_silver"
	wildcard_slots = WILDCARD_LIMIT_PLATINUM

/obj/item/card/id/advanced/platinum/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_TASTEFULLY_THICK_ID_CARD, INNATE_TRAIT)

/obj/item/card/id/advanced/gold
	name = "金色身份识别卡"
	desc = "彰显权力与威望的金色卡片。"
	icon_state = "card_gold"
	inhand_icon_state = "gold_id"
	assigned_icon_state = "assigned_silver"
	wildcard_slots = WILDCARD_LIMIT_GOLD

/obj/item/card/id/advanced/gold/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_TASTEFULLY_THICK_ID_CARD, INNATE_TRAIT)

/obj/item/card/id/advanced/gold/captains_spare
	name = "舰长备用身份卡"
	desc = "大领主本人的备用身份卡。"
	registered_name = "Captain"
	trim = /datum/id_trim/job/captain
	registered_age = null
	inherent_assigned_name = "Captain"

/obj/item/card/id/advanced/centcom
	name = "\improper 中央指挥部身份卡"
	desc = "直接由中央指挥部签发的身份卡。"
	icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	registered_name = JOB_CENTCOM
	registered_age = null
	trim = /datum/id_trim/centcom
	wildcard_slots = WILDCARD_LIMIT_CENTCOM

/obj/item/card/id/advanced/centcom/ert
	name = "\improper 中央指挥部身份卡"
	desc = "一张紧急响应小队身份卡。"
	registered_age = null
	registered_name = "Emergency Response Intern"
	trim = /datum/id_trim/centcom/ert

/obj/item/card/id/advanced/centcom/ert/commander
	registered_name = JOB_ERT_COMMANDER
	trim = /datum/id_trim/centcom/ert/commander

/obj/item/card/id/advanced/centcom/ert/security
	registered_name = JOB_ERT_OFFICER
	trim = /datum/id_trim/centcom/ert/security

/obj/item/card/id/advanced/centcom/ert/engineer
	registered_name = JOB_ERT_ENGINEER
	trim = /datum/id_trim/centcom/ert/engineer

/obj/item/card/id/advanced/centcom/ert/medical
	registered_name = JOB_ERT_MEDICAL_DOCTOR
	trim = /datum/id_trim/centcom/ert/medical

/obj/item/card/id/advanced/centcom/ert/chaplain
	registered_name = JOB_ERT_CHAPLAIN
	trim = /datum/id_trim/centcom/ert/chaplain

/obj/item/card/id/advanced/centcom/ert/janitor
	registered_name = JOB_ERT_JANITOR
	trim = /datum/id_trim/centcom/ert/janitor

/obj/item/card/id/advanced/centcom/ert/clown
	registered_name = JOB_ERT_CLOWN
	trim = /datum/id_trim/centcom/ert/clown

/obj/item/card/id/advanced/centcom/ert/militia
	registered_name = "Frontier Militia"
	trim = /datum/id_trim/centcom/ert/militia

/obj/item/card/id/advanced/centcom/ert/militia/general
	registered_name = "Frontier Militia General"
	trim = /datum/id_trim/centcom/ert/militia/general

/obj/item/card/id/advanced/black
	name = "黑色身份识别卡"
	desc = "这张卡只告诉你一件事：持有它的人绝对是个狠角色。"
	icon_state = "card_black"
	assigned_icon_state = "assigned_syndicate"
	wildcard_slots = WILDCARD_LIMIT_GOLD

/obj/item/card/id/advanced/black/deathsquad
	name = "\improper 死亡小队身份卡"
	desc = "一张死亡小队身份卡。"
	registered_name = JOB_ERT_DEATHSQUAD
	trim = /datum/id_trim/centcom/deathsquad
	wildcard_slots = WILDCARD_LIMIT_DEATHSQUAD

/obj/item/card/id/advanced/black/syndicate_command
	name = "辛迪加身份卡"
	desc = "直接由辛迪加签发的身份卡。"
	registered_name = "Syndicate"
	registered_age = null
	trim = /datum/id_trim/syndicom
	wildcard_slots = WILDCARD_LIMIT_SYNDICATE

/obj/item/card/id/advanced/black/syndicate_command/crew_id
	name = "辛迪加身份卡"
	desc = "直接由辛迪加签发的身份卡。"
	registered_name = "Syndicate"
	trim = /datum/id_trim/syndicom/crew

/obj/item/card/id/advanced/black/syndicate_command/captain_id
	name = "辛迪加舰长身份卡"
	desc = "直接由辛迪加签发的身份卡。"
	registered_name = "Syndicate"
	trim = /datum/id_trim/syndicom/captain


/obj/item/card/id/advanced/black/syndicate_command/captain_id/syndie_spare
	name = "辛迪加舰长备用身份卡"
	desc = "黑暗领主本人的备用身份卡。"
	registered_name = "Captain"
	registered_age = null
	inherent_assigned_name = "Captain"

/obj/item/card/id/advanced/debug
	name = "\improper 调试身份卡"
	desc = "一张调试身份卡，拥有全部通行权限和海量资金。你实在不该持有它。"
	icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	trim = /datum/id_trim/admin
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/obj/item/card/id/advanced/debug/Initialize(mapload)
	. = ..()
	set_account(new /datum/bank_account(player_account = FALSE))
	registered_account.account_id = ADMIN_ACCOUNT_ID // this is so bank_card_talk() can work.
	registered_account.account_job = SSjob.get_job_type(/datum/job/admin)
	registered_account.account_balance += 999999 // MONEY! We add more money to the account every time we spawn because it's a debug item and infinite money whoopie

/obj/item/card/id/advanced/debug/alt_click_can_use_id(mob/living/user)
	. = ..()
	if(!. || isnull(user.client?.holder)) // admins only as a safety so people don't steal all the dollars. spawn in a holochip if you want them to get some dosh
		registered_account.bank_card_talk(span_warning("仅纳米传讯授权代表可使用此卡。"), force = TRUE)
		return FALSE

	return TRUE

/obj/item/card/id/advanced/debug/can_be_used_in_payment(mob/living/user)
	. = ..()
	if(!. || isnull(user.client?.holder))
		registered_account.bank_card_talk(span_warning("仅纳米传讯授权代表可使用此卡。"), force = TRUE)
		return FALSE

	return TRUE

/obj/item/card/id/advanced/prisoner
	name = "囚犯身份卡"
	desc = "你只是一个编号，不是自由人。"
	icon_state = "card_prisoner"
	inhand_icon_state = "orange-id"
	registered_name = "Scum"
	registered_age = null
	trim = /datum/id_trim/job/prisoner

	wildcard_slots = WILDCARD_LIMIT_PRISONER

	/// Number of gulag points required to earn freedom.
	var/goal = 0
	/// Number of gulag points earned.
	var/points = 0
	/// If the card has a timer set on it for temporary stay.
	var/timed = FALSE
	/// Time to assign to the card when they pass through the security gate.
	var/time_to_assign
	/// Time left on a card till they can leave.
	var/time_left = 0

/obj/item/card/id/advanced/prisoner/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isidcard(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "设置刑期"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/card/id/advanced/prisoner/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(.)
		return .

	if(isidcard(tool))
		return set_sentence_time(user, tool)

/obj/item/card/id/advanced/prisoner/proc/set_sentence_time(mob/living/user, obj/item/card/id/our_card)
	var/list/id_access = our_card.GetAccess()
	if(!(ACCESS_BRIG in id_access))
		balloon_alert(user, "拒绝访问！")
		return ITEM_INTERACT_BLOCKING
	if(!user.is_holding(src))
		to_chat(user, span_warning("你必须拿着身份卡才能继续！"))
		return ITEM_INTERACT_BLOCKING

	if(timed) // If we already have a time set, reset the card
		timed = FALSE
		time_to_assign = initial(time_to_assign)
		registered_name = initial(registered_name)
		STOP_PROCESSING(SSobj, src)
		to_chat(user, "正在将囚犯身份卡重置为默认参数。")
		return ITEM_INTERACT_SUCCESS

	var/choice = tgui_input_number(user, "刑期（秒）", "判刑")
	if(isnull(choice) || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH) || !user.is_holding(src))
		return ITEM_INTERACT_BLOCKING
	time_to_assign = choice
	to_chat(user, "你将刑期设为[DisplayTimeText(time_to_assign * 10)]。")
	timed = TRUE
	return ITEM_INTERACT_SUCCESS

/obj/item/card/id/advanced/prisoner/proc/start_timer()
	say("刑期开始，欢迎来到公司改造中心！")
	START_PROCESSING(SSobj, src)

/obj/item/card/id/advanced/prisoner/examine(mob/user)
	. = ..()
	if(!.)
		return

	if(timed)
		if(time_to_assign > 0)
			. += span_notice("卡片上的数字计时器设为[DisplayTimeText(time_to_assign * 10)]。囚犯通过监狱大门扫描器后，计时器将开始计时。")
		else if(time_left <= 0)
			. += span_notice("卡片上的数字计时器剩余零秒。你出狱时已不再是从前的你，但终究重获自由。")
		else
			. += span_notice("卡片上的数字计时器还剩[DisplayTimeText(time_left * 10)]。受不了牢狱之苦，就别违法犯罪。")

	. += span_notice("在此卡上[EXAMINE_HINT("刷")]安保身份卡可[timed ? "重新" : ""]设置普通监区刑期。")
	. += span_notice("记得在普通监区储物柜上[EXAMINE_HINT("刷")]此卡以进行关联。")

/obj/item/card/id/advanced/prisoner/process(seconds_per_tick)
	if(!timed)
		return
	time_left -= seconds_per_tick
	if(time_left <= 0)
		say("刑期已满，感谢你配合公司的改造计划！")
		STOP_PROCESSING(SSobj, src)

/obj/item/card/id/advanced/prisoner/attack_self(mob/user)
	to_chat(usr, span_notice("你已积累[points]分，获得自由需要[goal]分。"))

/obj/item/card/id/advanced/prisoner/one
	name = "囚犯 #13-001"
	registered_name = "Prisoner #13-001"
	trim = /datum/id_trim/job/prisoner/one

/obj/item/card/id/advanced/prisoner/two
	name = "囚犯 #13-002"
	registered_name = "Prisoner #13-002"
	trim = /datum/id_trim/job/prisoner/two

/obj/item/card/id/advanced/prisoner/three
	name = "囚犯 #13-003"
	registered_name = "Prisoner #13-003"
	trim = /datum/id_trim/job/prisoner/three

/obj/item/card/id/advanced/prisoner/four
	name = "囚犯 #13-004"
	registered_name = "Prisoner #13-004"
	trim = /datum/id_trim/job/prisoner/four

/obj/item/card/id/advanced/prisoner/five
	name = "囚犯 #13-005"
	registered_name = "Prisoner #13-005"
	trim = /datum/id_trim/job/prisoner/five

/obj/item/card/id/advanced/prisoner/six
	name = "囚犯 #13-006"
	registered_name = "Prisoner #13-006"
	trim = /datum/id_trim/job/prisoner/six

/obj/item/card/id/advanced/prisoner/seven
	name = "囚犯 #13-007"
	registered_name = "Prisoner #13-007"
	trim = /datum/id_trim/job/prisoner/seven

/obj/item/card/id/advanced/mining
	name = "矿业身份卡"
	trim = /datum/id_trim/job/shaft_miner/spare

/obj/item/card/id/advanced/highlander
	name = "高地勇士身份卡"
	registered_name = "Highlander"
	desc = "只能活一个！"
	icon_state = "card_black"
	assigned_icon_state = "assigned_syndicate"
	trim = /datum/id_trim/highlander
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/// An ID that you can flip with attack_self_secondary, overriding the appearance of the ID (useful for plainclothes detectives for example).
/obj/item/card/id/advanced/plainclothes
	name = "便衣身份卡"
	///The trim that we use as plainclothes identity
	var/alt_trim = /datum/id_trim/job/assistant

/obj/item/card/id/advanced/plainclothes/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item) || (held_item == src))
		context[SCREENTIP_CONTEXT_LMB] = "出示/翻转身份卡"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/card/id/advanced/plainclothes/examine(mob/user)
	. = ..()
	if(trim_assignment_override)
		. += span_smallnotice("目前使用的是便衣身份。")
	else
		. += span_smallnotice("翻转它可切换为便衣身份。")

/obj/item/card/id/advanced/plainclothes/attack_self(mob/user)
	var/popup_input = tgui_input_list(user, "选择操作", "双面身份卡", list("出示", "翻转"))
	if(!popup_input || !after_input_check(user))
		return TRUE
	if(popup_input == "出示")
		return ..()
	balloon_alert(user, "已翻转")
	if(trim_assignment_override)
		SSid_access.remove_trim_override(src)
	else
		SSid_access.apply_trim_override(src, alt_trim)
	update_label()
	update_appearance()

/obj/item/card/id/advanced/plainclothes/update_label()
	if(!trim_assignment_override)
		return ..()
	var/name_string = registered_name ? "[registered_name]的身份卡" : initial(name)
	var/datum/id_trim/fake = SSid_access.trim_singletons_by_path[alt_trim]
	name = "[name_string] ([chinese_job_display(fake.assignment)])"

/obj/item/card/id/advanced/chameleon
	name = "特工身份卡"
	desc = "一张先进的变色龙身份卡。在其他身份卡或佩戴身份卡的人身上刷此卡，即可复制权限。\
		具有特殊磁性，能强制占据钱包最前方的卡位。"
	trim = /datum/id_trim/chameleon
	trim_changeable = FALSE
	actions_types = list(/datum/action/item_action/chameleon/change/id, /datum/action/item_action/chameleon/change/id_trim)
	action_slots = ALL

	/// Have we set a custom name and job assignment, or will we use what we're given when we chameleon change?
	var/forged = FALSE
	/// Anti-metagaming protections. If TRUE, anyone can change the ID card's details. If FALSE, only syndicate agents can.
	var/anyone = FALSE
	/// Weak ref to the ID card we're currently attempting to steal access from.
	var/datum/weakref/theft_target

/obj/item/card/id/advanced/chameleon/Destroy()
	theft_target = null
	return ..()

/obj/item/card/id/advanced/chameleon/equipped(mob/user, slot)
	. = ..()
	if (slot & ITEM_SLOT_ID)
		RegisterSignal(user, COMSIG_LIVING_CAN_TRACK, PROC_REF(can_track))

/obj/item/card/id/advanced/chameleon/dropped(mob/user)
	UnregisterSignal(user, COMSIG_LIVING_CAN_TRACK)
	return ..()

/obj/item/card/id/advanced/chameleon/proc/can_track(datum/source, mob/user)
	SIGNAL_HANDLER

	return COMPONENT_CANT_TRACK

/obj/item/card/id/advanced/chameleon/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(isidcard(interacting_with))
		theft_target = WEAKREF(interacting_with)
		ui_interact(user)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/card/id/advanced/chameleon/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	// If we're attacking a human, we want it to be covert. We're not ATTACKING them, we're trying
	// to sneakily steal their accesses by swiping our agent ID card near them. As a result, we
	// return ITEM_INTERACT_BLOCKING to cancel any part of the following the attack chain.
	if(ishuman(interacting_with))
		interacting_with.balloon_alert(user, "正在扫描身份卡……")

		if(!do_after(user, 2 SECONDS, interacting_with, cog_icon = null))
			interacting_with.balloon_alert(user, "已中断！")
			return ITEM_INTERACT_BLOCKING

		var/mob/living/carbon/human/human_target = interacting_with
		var/list/target_id_cards = human_target.get_all_contents_type(/obj/item/card/id)

		if(!length(target_id_cards))
			interacting_with.balloon_alert(user, "没有身份卡！")
			return ITEM_INTERACT_BLOCKING

		var/selected_id = pick(target_id_cards)
		interacting_with.balloon_alert(user, UNLINT("身份卡已同步"))
		theft_target = WEAKREF(selected_id)
		ui_interact(user)
		return ITEM_INTERACT_SUCCESS

	if(isitem(interacting_with))
		var/obj/item/target_item = interacting_with

		interacting_with.balloon_alert(user, "正在扫描身份卡……")

		var/list/target_id_cards = target_item.get_all_contents_type(/obj/item/card/id)
		var/target_item_id = target_item.GetID()

		if(target_item_id)
			target_id_cards |= target_item_id

		if(!length(target_id_cards))
			interacting_with.balloon_alert(user, "没有身份卡！")
			return ITEM_INTERACT_BLOCKING

		var/selected_id = pick(target_id_cards)
		interacting_with.balloon_alert(user, UNLINT("身份卡已同步"))
		theft_target = WEAKREF(selected_id)
		ui_interact(user)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/card/id/advanced/chameleon/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ChameleonCard", name)
		ui.open()

/obj/item/card/id/advanced/chameleon/ui_static_data(mob/user)
	var/list/data = list()
	data["wildcardFlags"] = SSid_access.wildcard_flags_by_wildcard
	data["accessFlagNames"] = SSid_access.access_flag_string_by_flag
	data["accessFlags"] = SSid_access.flags_by_access
	return data

/obj/item/card/id/advanced/chameleon/ui_host(mob/user)
	// Hook our UI to the theft target ID card for UI state checks.
	return theft_target?.resolve()

/obj/item/card/id/advanced/chameleon/ui_state(mob/user)
	return GLOB.always_state

/obj/item/card/id/advanced/chameleon/ui_status(mob/user, datum/ui_state/state)
	var/target = theft_target?.resolve()

	if(!target)
		return UI_CLOSE

	var/status = min(
		ui_status_user_strictly_adjacent(user, target),
		ui_status_user_is_advanced_tool_user(user),
		max(
			ui_status_user_is_conscious_and_lying_down(user),
			ui_status_user_is_abled(user, target),
		),
	)

	if(status < UI_INTERACTIVE)
		return UI_CLOSE

	return status

/obj/item/card/id/advanced/chameleon/ui_data(mob/user)
	var/list/data = list()

	data["showBasic"] = FALSE

	var/list/regions = list()

	var/obj/item/card/id/target_card = theft_target.resolve()
	if(target_card)
		var/list/tgui_region_data = SSid_access.all_region_access_tgui
		for(var/region in SSid_access.station_regions)
			regions += tgui_region_data[region]

	data["accesses"] = regions
	data["ourAccess"] = access
	data["ourTrimAccess"] = trim ? trim.access : list()
	data["theftAccess"] = target_card.access.Copy()
	data["wildcardSlots"] = wildcard_slots
	data["selectedList"] = access
	data["trimAccess"] = list()

	return data

/obj/item/card/id/advanced/chameleon/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/obj/item/card/id/target_card = theft_target?.resolve()
	if(QDELETED(target_card))
		to_chat(usr, span_notice("你尝试扫描的身份卡已离开范围。"))
		target_card = null
		return TRUE

	// Wireless ID theft!
	var/turf/our_turf = get_turf(src)
	var/turf/target_turf = get_turf(target_card)
	if(!our_turf.Adjacent(target_turf))
		to_chat(usr, span_notice("你尝试扫描的身份卡已离开范围。"))
		target_card = null
		return TRUE

	switch(action)
		if("mod_access")
			var/access_type = params["access_target"]
			var/try_wildcard = params["access_wildcard"]
			if(access_type in access)
				remove_access(list(access_type))
				LOG_ID_ACCESS_CHANGE(usr, src, "removed [SSid_access.get_access_desc(access_type)]")
				return TRUE

			if(!(access_type in target_card.access))
				to_chat(usr, span_notice("身份卡错误：身份卡拒绝了你的权限修改请求。"))
				LOG_ID_ACCESS_CHANGE(usr, src, "failed to add [SSid_access.get_access_desc(access_type)][try_wildcard ? " with wildcard [try_wildcard]" : ""]")
				return TRUE

			if(!can_add_wildcards(list(access_type), try_wildcard))
				to_chat(usr, span_notice("身份卡错误：身份卡拒绝了你的权限修改请求。"))
				LOG_ID_ACCESS_CHANGE(usr, src, "failed to add [SSid_access.get_access_desc(access_type)][try_wildcard ? " with wildcard [try_wildcard]" : ""]")
				return TRUE

			if(!add_access(list(access_type), try_wildcard))
				to_chat(usr, span_notice("身份卡错误：身份卡拒绝了你的权限修改请求。"))
				LOG_ID_ACCESS_CHANGE(usr, src, "failed to add [SSid_access.get_access_desc(access_type)][try_wildcard ? " with wildcard [try_wildcard]" : ""]")
				return TRUE

			if(access_type in ACCESS_ALERT_ADMINS)
				message_admins("[ADMIN_LOOKUPFLW(usr)]刚刚为身份卡[ADMIN_VV(src)]添加了[SSid_access.get_access_desc(access_type)]权限。[(registered_name) ? "持有人：[registered_name]。" : "此卡未登记姓名。"]")
			LOG_ID_ACCESS_CHANGE(usr, src, "added [SSid_access.get_access_desc(access_type)]")
			return TRUE

/obj/item/card/id/advanced/chameleon/attack_self(mob/user)
	if(!user.can_perform_action(user, NEED_DEXTERITY| FORBID_TELEKINESIS_REACH))
		return ..()
	var/popup_input = tgui_input_list(user, "选择操作", "特工身份卡", list("出示", "伪造/重置", "更改账户号码"))
	if(!popup_input || !after_input_check(user))
		return TRUE
	switch(popup_input)
		if ("更改账户号码")
			set_new_account(user)
			return
		if("出示")
			return ..()

	///"Forge/Reset", kept outside the switch() statement to reduce indentation.
	if(forged) //reset the ID if forged
		registered_name = initial(registered_name)
		assignment = initial(assignment)
		SSid_access.remove_trim_override(src)
		REMOVE_TRAIT(src, TRAIT_MAGNETIC_ID_CARD, CHAMELEON_ITEM_TRAIT)
		user.log_message("reset \the [initial(name)] named \"[src]\" to default.", LOG_GAME)
		update_label()
		update_appearance()
		forged = FALSE
		to_chat(user, span_notice("你成功重置了身份卡。"))
		return

	///forge the ID if not forged.s
	var/input_name = tgui_input_text(user, "你想在此卡上填写什么姓名？留空则随机生成。", "特工身份卡姓名", registered_name ? registered_name : (ishuman(user) ? user.real_name : user.name), max_length = MAX_NAME_LEN, encode = FALSE)

	if(!after_input_check(user))
		return TRUE
	if(input_name)
		input_name = sanitize_name(input_name, allow_numbers = TRUE)
	if(!input_name)
		// Invalid/blank names give a randomly generated one.
		if(user.gender == MALE)
			input_name = "[pick(GLOB.first_names_male)] [pick(GLOB.last_names)]"
		else if(user.gender == FEMALE)
			input_name = "[pick(GLOB.first_names_female)] [pick(GLOB.last_names)]"
		else
			input_name = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]"

	var/target_occupation = tgui_input_text(user, "你想在此卡上填写什么职业？\n注意：这不会赋予任何权限。", "特工身份卡职业", assignment ? assignment : "Assistant", max_length = MAX_NAME_LEN)
	if(!after_input_check(user))
		return TRUE
	var/default_age = AGE_MIN
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		default_age = human_user.age ? clamp(human_user.age, AGE_MIN, AGE_MAX) : AGE_MIN
	var/new_age = tgui_input_number(user, "选择身份卡上的年龄", "特工身份卡年龄", default_age, AGE_MAX, AGE_MIN)
	if(!after_input_check(user))
		return TRUE

	var/wallet_spoofing = tgui_alert(user, "启用钱包身份卡伪装，让此卡强制占据钱包中可见的身份卡位吗？", "钱包身份卡伪装", list("是", "否"))
	if(!after_input_check(user))
		return

	registered_name = input_name
	if(target_occupation)
		assignment = sanitize(target_occupation)
	if(new_age)
		registered_age = new_age
	if(wallet_spoofing  == "是")
		ADD_TRAIT(src, TRAIT_MAGNETIC_ID_CARD, CHAMELEON_ITEM_TRAIT)

	update_label()
	update_appearance()
	forged = TRUE
	to_chat(user, span_notice("你成功伪造了身份卡。"))
	user.log_message("forged \the [initial(name)] with name \"[registered_name]\", occupation \"[assignment]\" and trim \"[trim?.assignment]\".", LOG_GAME)

	if(!ishuman(user) || registered_account)
		return

	var/mob/living/carbon/human/owner = user
	var/datum/bank_account/account = SSeconomy.bank_accounts_by_id["[owner.account_id]"]
	if(account)
		set_account(account)
		to_chat(user, span_notice("你的账户号码已自动关联。"))

/obj/item/card/id/advanced/chameleon/add_item_context(obj/item/source, list/context, atom/target, mob/living/user,)
	. = ..()

	if(!in_range(user, target))
		return .
	if(isidcard(target))
		context[SCREENTIP_CONTEXT_LMB] = "复制权限"
		return CONTEXTUAL_SCREENTIP_SET
	if(ishuman(target))
		context[SCREENTIP_CONTEXT_RMB] = "复制权限"
		return CONTEXTUAL_SCREENTIP_SET
	if(isitem(target))
		context[SCREENTIP_CONTEXT_RMB] = "扫描权限"
		return CONTEXTUAL_SCREENTIP_SET
	return .

/obj/item/card/id/advanced/chameleon/black
	icon_state = "card_black"
	assigned_icon_state = "assigned_syndicate"

/// Upgraded variant of agent id, can hold unlimited amount of accesses.
/obj/item/card/id/advanced/chameleon/elite
	desc = "一张极其先进的变色龙身份卡。在其他身份卡或佩戴身份卡的人身上刷此卡，即可复制权限。\
		具有特殊磁性，能强制占据钱包最前方的卡位，并内置高端微芯片，可存储无限数量的权限代码。"
	wildcard_slots = WILDCARD_LIMIT_GOLD

/obj/item/card/id/advanced/chameleon/elite/black
	icon_state = "card_black"
	assigned_icon_state = "assigned_syndicate"

/obj/item/card/id/advanced/engioutpost
	registered_name = "George 'Plastic' Miller"
	desc = "用于证明身份及确定空间站各处通行权限的卡片，角落还滴着血。真恶心。"
	trim = /datum/id_trim/engioutpost
	registered_age = 47

/obj/item/card/id/advanced/simple_bot
	name = "简单机器人身份卡"
	desc = "空间站非智能机器人使用的内部身份卡。如果你拿到了它，请报告给开发人员。"
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/obj/item/card/id/red
	name = "红队身份识别卡"
	desc = "用于识别夺旗赛红队成员的卡片。"
	icon_state = "ctf_red"

/obj/item/card/id/blue
	name = "蓝队身份识别卡"
	desc = "用于识别夺旗赛蓝队成员的卡片。"
	icon_state = "ctf_blue"

/obj/item/card/id/yellow
	name = "黄队身份识别卡"
	desc = "用于识别夺旗赛黄队成员的卡片。"
	icon_state = "ctf_yellow"

/obj/item/card/id/green
	name = "绿队身份识别卡"
	desc = "用于识别夺旗赛绿队成员的卡片。"
	icon_state = "ctf_green"

#undef INTERN_THRESHOLD_FALLBACK_HOURS
#undef HOLOPAY_PROJECTION_INTERVAL

#define INDEX_NAME_COLOR 1
#define INDEX_ASSIGNMENT_COLOR 2
#define INDEX_TRIM_COLOR 3

/**
 * A fake ID card any silly-willy can craft with wirecutters, cardboard and a writing utensil
 * Beside the gimmick of changing the visible name when worn, they do nothing. They cannot have an account.
 * They don't fit in PDAs nor wallets, They have no access. They won't trick securitrons. They won't work with chameleon masks.
 * Etcetera etcetera. Furthermore, talking, or getting examined on will pretty much give it away.
 */
/obj/item/card/cardboard
	name = "纸板身份识别卡"
	desc = "用于证明身份及确——喂，等等，这只是一块剪下来的纸板！"
	icon_state = "cardboard_id"
	inhand_icon_state = "cardboard-id"
	worn_icon_state = "nothing"
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_ID
	custom_materials = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT)
	///The "name" of the "owner" of this "ID"
	var/scribbled_name
	///The assignment written on this card.
	var/scribbled_assignment
	///An icon state used as trim.
	var/scribbled_trim
	///The colors for each of the above variables, for when overlays are updated.
	var/details_colors = list(COLOR_BLACK, COLOR_BLACK, COLOR_BLACK)
	pickup_sound = 'sound/items/handling/materials/cardboard_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/cardboard_drop.ogg'

/obj/item/card/cardboard/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/card/cardboard/get_displayed_name(honorifics = FALSE)
	return scribbled_name

/obj/item/card/cardboard/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.can_write(tool, TRUE))
		INVOKE_ASYNC(src, PROC_REF(modify_card), user, tool)
		return ITEM_INTERACT_SUCCESS

///Lets the user write a name, assignment or trim on the card, or reset it. Only the name is important for the component.
/obj/item/card/cardboard/proc/modify_card(mob/living/user, obj/item/item)
	if(!user.mind)
		return
	var/popup_input = tgui_input_list(user, "要修改什么？", "纸板身份卡", list("姓名", "职业", "饰边", "重置"))
	if(!after_input_check(user, item, popup_input))
		return
	switch(popup_input)
		if("姓名")
			var/raw_input = tgui_input_text(user, "你想在此卡上填写什么姓名？", "纸板身份卡姓名", scribbled_name || (ishuman(user) ? user.real_name : user.name), max_length = MAX_NAME_LEN)
			var/input_name = sanitize_name(raw_input, allow_numbers = TRUE)
			if(!after_input_check(user, item, input_name, scribbled_name))
				return
			playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
			scribbled_name = input_name
			var/list/details = item.get_writing_implement_details()
			details_colors[INDEX_NAME_COLOR] = details["color"] || COLOR_BLACK
		if("职业")
			var/input_assignment = tgui_input_text(user, "你想在此卡上填写什么职业？", "纸板身份卡职业", scribbled_assignment || "助理", max_length = MAX_NAME_LEN)
			if(!after_input_check(user, item, input_assignment, scribbled_assignment))
				return
			playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
			scribbled_assignment = sanitize(input_assignment)
			var/list/details = item.get_writing_implement_details()
			details_colors[INDEX_ASSIGNMENT_COLOR] = details["color"] || COLOR_BLACK
		if("饰边")
			var/static/list/possible_trims
			if(!possible_trims)
				possible_trims = list()
				for(var/trim_path in typesof(/datum/id_trim))
					var/datum/id_trim/trim = SSid_access.trim_singletons_by_path[trim_path]
					if(trim?.trim_state && trim.assignment)
						possible_trims |= replacetext(trim.trim_state, "trim_", "")
				sortTim(possible_trims, GLOBAL_PROC_REF(cmp_typepaths_asc))
			var/input_trim = chinese_id_trim_choice(user, "选择要应用到卡片上的饰边。\n注意：这不会赋予饰边对应的权限。", "伪造饰边", possible_trims)
			if(!input_trim || !after_input_check(user, item, input_trim, scribbled_trim))
				return
			playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
			scribbled_trim = "cardboard_[input_trim]"
			var/list/details = item.get_writing_implement_details()
			details_colors[INDEX_TRIM_COLOR] = details["color"] || COLOR_BLACK
		if("重置")
			scribbled_name = null
			scribbled_assignment = null
			scribbled_trim = null
			details_colors = list(COLOR_BLACK, COLOR_BLACK, COLOR_BLACK)

	update_appearance()

///Checks that the conditions to be able to modify the cardboard card are still present after user input calls.
/obj/item/card/cardboard/proc/after_input_check(mob/living/user, obj/item/item, input, value)
	if(!input || (value && input == value))
		return FALSE
	if(QDELETED(user) || QDELETED(item) || QDELETED(src) || user.incapacitated || !user.is_holding(item) || !IsReachableBy(user) || !user.can_write(item))
		return FALSE
	return TRUE

/obj/item/card/cardboard/attack_self(mob/user)
	if(!Adjacent(user))
		return
	user.visible_message(span_notice("[user]向你展示：[icon2html(src, viewers(user))] [name]。"), span_notice("你展示了[name]。"))
	add_fingerprint(user)

/obj/item/card/cardboard/update_name()
	. = ..()
	if(!scribbled_name)
		name = initial(name)
		return
	name = "[scribbled_name]的身份卡（[chinese_job_display(scribbled_assignment)]）"

/obj/item/card/cardboard/update_overlays()
	. = ..()
	if(scribbled_name)
		var/mutable_appearance/name_overlay = mutable_appearance(icon, "cardboard_name")
		name_overlay.color = details_colors[INDEX_NAME_COLOR]
		. += name_overlay
	if(scribbled_assignment)
		var/mutable_appearance/assignment_overlay = mutable_appearance(icon, "cardboard_assignment")
		assignment_overlay.color = details_colors[INDEX_ASSIGNMENT_COLOR]
		. += assignment_overlay
	if(scribbled_trim)
		var/mutable_appearance/frame_overlay = mutable_appearance(icon, "cardboard_frame")
		frame_overlay.color = details_colors[INDEX_TRIM_COLOR]
		. += frame_overlay
		var/mutable_appearance/trim_overlay = mutable_appearance(icon, scribbled_trim)
		trim_overlay.color = details_colors[INDEX_TRIM_COLOR]
		. += trim_overlay

/obj/item/card/cardboard/get_id_examine_strings(mob/user)
	. = ..()
	. += list("[icon2html(get_cached_flat_icon(), user, extra_classes = "hugeicon")]")

/obj/item/card/cardboard/get_examine_icon(mob/user)
	return icon2html(get_cached_flat_icon(), user)

/obj/item/card/cardboard/examine(mob/user)
	. = ..()
	. += span_notice("你可以使用钢笔或蜡笔伪造姓名、职业或饰边。")

/obj/item/card/cardboard/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item) || (held_item == src))
		context[SCREENTIP_CONTEXT_LMB] = "出示身份卡"
		return CONTEXTUAL_SCREENTIP_SET
	else if(IS_WRITING_UTENSIL(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "修改"
		return CONTEXTUAL_SCREENTIP_SET

#undef INDEX_NAME_COLOR
#undef INDEX_ASSIGNMENT_COLOR
#undef INDEX_TRIM_COLOR
