#define INTERNALS_TOGGLE_DELAY (4 SECONDS)
#define POCKET_EQUIP_DELAY (1 SECONDS)

GLOBAL_LIST_INIT(strippable_human_items, create_strippable_list(list(
	/datum/strippable_item/mob_item_slot/head,
	/datum/strippable_item/mob_item_slot/back,
	/datum/strippable_item/mob_item_slot/mask,
	/datum/strippable_item/mob_item_slot/neck,
	/datum/strippable_item/mob_item_slot/eyes,
	/datum/strippable_item/mob_item_slot/ears,
	/datum/strippable_item/mob_item_slot/jumpsuit,
	/datum/strippable_item/mob_item_slot/suit,
	/datum/strippable_item/mob_item_slot/gloves,
	/datum/strippable_item/mob_item_slot/feet,
	/datum/strippable_item/mob_item_slot/suit_storage,
	/datum/strippable_item/mob_item_slot/id,
	/datum/strippable_item/mob_item_slot/belt,
	/datum/strippable_item/mob_item_slot/pocket/left,
	/datum/strippable_item/mob_item_slot/pocket/right,
	/datum/strippable_item/hand/left,
	/datum/strippable_item/hand/right,
	/datum/strippable_item/mob_item_slot/handcuffs,
	/datum/strippable_item/mob_item_slot/legcuffs,
)))

/mob/living/carbon/human/proc/should_strip(mob/user)
	if (user.pulling != src || user.grab_state != GRAB_AGGRESSIVE)
		return TRUE

	if (ishuman(user))
		var/mob/living/carbon/human/human_user = user
		return !human_user.can_be_firemanned(src)

	return TRUE

/datum/strippable_item/mob_item_slot/eyes
	key = STRIPPABLE_ITEM_EYES
	item_slot = ITEM_SLOT_EYES

/datum/strippable_item/mob_item_slot/ears
	key = STRIPPABLE_ITEM_EARS
	item_slot = ITEM_SLOT_EARS

/datum/strippable_item/mob_item_slot/jumpsuit
	key = STRIPPABLE_ITEM_JUMPSUIT
	item_slot = ITEM_SLOT_ICLOTHING

/datum/strippable_item/mob_item_slot/jumpsuit/get_alternate_actions(atom/source, mob/user, obj/item/item)
	. = ..()
	var/obj/item/clothing/under/jumpsuit = item
	if (!istype(jumpsuit))
		return

	if(jumpsuit.has_sensor == HAS_SENSORS)
		. += "adjust_sensor"
	if(jumpsuit.can_adjust)
		. += "adjust_jumpsuit"
	if(length(jumpsuit.attached_accessories))
		. += "strip_accessory"

/datum/strippable_item/mob_item_slot/jumpsuit/perform_alternate_action(atom/source, mob/user, action_key, obj/item/item)
	if (!..())
		return
	var/obj/item/clothing/under/jumpsuit = item
	if (!istype(jumpsuit))
		return null

	switch(action_key)
		if("adjust_jumpsuit")
			do_adjust_jumpsuit(source, user, jumpsuit)
		if("adjust_sensor")
			do_adjust_sensor(source, user, jumpsuit)
		if("strip_accessory")
			do_strip_accessory(source, user, jumpsuit)
		else
			stack_trace("Unknown action key: [action_key] for [type]")

/datum/strippable_item/mob_item_slot/jumpsuit/proc/do_adjust_jumpsuit(atom/source, mob/user, obj/item/clothing/under/jumpsuit)
	to_chat(source, span_notice("[user] 正试图调整你的 [jumpsuit]。"))
	if (!do_after(user, (jumpsuit.strip_delay * 0.5), source))
		return
	to_chat(source, span_notice("[user] 成功调整了你的 [jumpsuit]。"))
	jumpsuit.toggle_jumpsuit_adjust()

	if (!ismob(source))
		return

	var/mob/mob_source = source
	mob_source.update_worn_undersuit()
	mob_source.update_body()

/datum/strippable_item/mob_item_slot/jumpsuit/proc/do_adjust_sensor(atom/source, mob/user, obj/item/clothing/under/jumpsuit)
	if(jumpsuit.has_sensor != HAS_SENSORS)
		return

	var/static/list/sensor_mode_text_to_num = list(
		"关闭" = SENSOR_OFF,
		"生死状态" = SENSOR_LIVING,
		"详细生命体征" = SENSOR_VITALS,
		"追踪信标" = SENSOR_COORDS,
	)
	var/static/list/senor_mode_num_to_text = list( // keep this as the inverse of the above list
		"[SENSOR_OFF]" = "关闭",
		"[SENSOR_LIVING]" = "生死状态",
		"[SENSOR_VITALS]" = "详细生命体征",
		"[SENSOR_COORDS]" = "追踪信标",
	)

	var/new_mode_str = tgui_input_list(user, "调整服装传感器", "调整传感器", sensor_mode_text_to_num, senor_mode_num_to_text["[jumpsuit.sensor_mode]"])
	var/new_mode = sensor_mode_text_to_num[new_mode_str]
	if(isnull(new_mode)) // also catches returning null
		return

	if(!user.Adjacent(source))
		source.balloon_alert(user, "够不到！")
		return

	to_chat(source, span_notice("[user] 正试图调整你的 [jumpsuit.name] 的传感器。"))
	if(!do_after(user, jumpsuit.strip_delay * 0.5, source) || !jumpsuit.set_sensor_mode(new_mode)) // takes the same amount of time as adjusting it
		source.balloon_alert(user, "失败！")
		return
	source.balloon_alert(user, "传感器已更改")
	to_chat(source, span_notice("[user] 成功调整了你的 [jumpsuit.name] 的传感器。"))
	user.log_message("将 [key_name(source)] 的服装传感器改为 [new_mode_str]", LOG_ATTACK, color="red")
	source.log_message("服装传感器被 [key_name(user)] 改为 [new_mode_str]", LOG_VICTIM, color="orange", log_globally=FALSE)

/datum/strippable_item/mob_item_slot/jumpsuit/proc/do_strip_accessory(atom/source, mob/user, obj/item/clothing/under/jumpsuit)
	var/list/accessory_choices = list()
	for(var/obj/item/clothing/accessory/jumpsuit_accessory as anything in jumpsuit.attached_accessories)
		if(!istype(jumpsuit_accessory))
			continue
		accessory_choices[jumpsuit_accessory.name] += jumpsuit_accessory

	var/chosen_accessory_name = tgui_input_list(user, "选择要取下的配饰", "选择配饰", accessory_choices)
	var/obj/item/clothing/accessory/chosen_accessory = accessory_choices[chosen_accessory_name]
	if(isnull(chosen_accessory))
		return

	if(!user.Adjacent(source))
		source.balloon_alert(user, "够不到！")
		return

	to_chat(source, span_notice("[user] 正试图从 [jumpsuit] 上取下 [chosen_accessory]！"))
	if(!do_after(user, chosen_accessory.strip_delay, source))
		source.balloon_alert(user, "失败！")
		return

	to_chat(source, span_notice("[user] 已从 [jumpsuit] 上取下了 [chosen_accessory]。"))
	jumpsuit.remove_accessory(chosen_accessory)
	jumpsuit.update_appearance()
	chosen_accessory.forceMove(jumpsuit.drop_location())

	if(!ismob(source))
		return

	var/mob/mob_source = source
	mob_source.update_worn_undersuit()

/datum/strippable_item/mob_item_slot/suit
	key = STRIPPABLE_ITEM_SUIT
	item_slot = ITEM_SLOT_OCLOTHING

/datum/strippable_item/mob_item_slot/gloves
	key = STRIPPABLE_ITEM_GLOVES
	item_slot = ITEM_SLOT_GLOVES

/datum/strippable_item/mob_item_slot/feet
	key = STRIPPABLE_ITEM_FEET
	item_slot = ITEM_SLOT_FEET

/datum/strippable_item/mob_item_slot/feet/get_alternate_actions(atom/source, mob/user, obj/item/item)
	. = ..()
	var/obj/item/clothing/shoes/shoes = item
	if (!istype(shoes) || shoes.fastening_type == SHOES_SLIPON)
		return

	switch (shoes.tied)
		if (SHOES_UNTIED)
			. += "knot"
		if (SHOES_TIED)
			. += "untie"
		if (SHOES_KNOTTED)
			. += "unknot"

/datum/strippable_item/mob_item_slot/feet/perform_alternate_action(atom/source, mob/user, action_key, obj/item/item)
	if(!..())
		return

	var/obj/item/clothing/shoes/shoes = item
	if (!istype(shoes))
		return
	switch(action_key)
		if("knot", "untie", "unknot")
			shoes.handle_tying(user)
		else
			stack_trace("Unknown action key: [action_key] for [type]")

/datum/strippable_item/mob_item_slot/suit_storage
	key = STRIPPABLE_ITEM_SUIT_STORAGE
	item_slot = ITEM_SLOT_SUITSTORE

/datum/strippable_item/mob_item_slot/suit_storage/get_alternate_actions(atom/source, mob/user, obj/item/item)
	. = ..()
	. += get_strippable_alternate_action_internals(item, source)

/datum/strippable_item/mob_item_slot/suit_storage/perform_alternate_action(atom/source, mob/user, action_key, obj/item/item)
	if(!..())
		return
	if(action_key in get_strippable_alternate_action_internals(item, source))
		strippable_alternate_action_internals(item, source, user)

/datum/strippable_item/mob_item_slot/id
	key = STRIPPABLE_ITEM_ID
	item_slot = ITEM_SLOT_ID
	can_be_silent = TRUE //SKYRAT EDIT ADDITION

/datum/strippable_item/mob_item_slot/belt
	key = STRIPPABLE_ITEM_BELT
	item_slot = ITEM_SLOT_BELT

/datum/strippable_item/mob_item_slot/belt/get_alternate_actions(atom/source, mob/user, obj/item/item)
	. = ..()
	. += get_strippable_alternate_action_internals(item, source)

/datum/strippable_item/mob_item_slot/belt/perform_alternate_action(atom/source, mob/user, action_key, obj/item/item)
	if (!..())
		return
	if(action_key in get_strippable_alternate_action_internals(item, source))
		strippable_alternate_action_internals(item, source, user)

/datum/strippable_item/mob_item_slot/pocket
	/// Which pocket we're referencing. Used for visible text.
	var/pocket_side
	can_be_silent = TRUE //SKYRAT EDIT ADDITION

/datum/strippable_item/mob_item_slot/pocket/get_obscuring(atom/source)
	return isnull(get_item(source)) \
		? STRIPPABLE_OBSCURING_NONE \
		: STRIPPABLE_OBSCURING_HIDDEN

/datum/strippable_item/mob_item_slot/pocket/get_equip_delay(obj/item/equipping)
	return POCKET_EQUIP_DELAY

/datum/strippable_item/mob_item_slot/pocket/start_equip(atom/source, obj/item/equipping, mob/user)
	. = ..()
	if (!.)
		warn_owner(source)

/datum/strippable_item/mob_item_slot/pocket/start_unequip(atom/source, mob/user)
	var/obj/item/item = get_item(source)
	if (isnull(item))
		return FALSE

	to_chat(user, span_notice("你试着掏空 [source] 的[pocket_side]口袋。"))

	user.log_message("正在扒窃 [key_name(source)] 的 [item]（[pocket_side]侧）", LOG_ATTACK, color="red")
	source.log_message("正被 [key_name(user)] 扒走 [item]（[pocket_side]侧）", LOG_VICTIM, color="orange", log_globally=FALSE)
	item.add_fingerprint(src)

	var/result = start_unequip_mob(item, source, user, strip_delay = POCKET_STRIP_DELAY, hidden = TRUE)

	if (!(result || HAS_TRAIT(user, TRAIT_STICKY_FINGERS))) //SKYRAT EDIT ADDITION original if (!result)
		warn_owner(source)

	return result

/datum/strippable_item/mob_item_slot/pocket/proc/warn_owner(atom/owner)
	to_chat(owner, span_warning("你感觉自己的[pocket_side]口袋被乱摸了！"))

/datum/strippable_item/mob_item_slot/pocket/left
	key = STRIPPABLE_ITEM_LPOCKET
	item_slot = ITEM_SLOT_LPOCKET
	pocket_side = "左"

/datum/strippable_item/mob_item_slot/pocket/right
	key = STRIPPABLE_ITEM_RPOCKET
	item_slot = ITEM_SLOT_RPOCKET
	pocket_side = "右"

/proc/get_strippable_alternate_action_internals(obj/item/item, atom/source)
	if (!iscarbon(source))
		return

	var/mob/living/carbon/carbon_source = source
	if (carbon_source.can_breathe_internals() && istype(item, /obj/item/tank))
		if(carbon_source.internal != item)
			return list("enable_internals")
		else
			return list("disable_internals")

/proc/strippable_alternate_action_internals(obj/item/item, atom/source, mob/user)
	var/obj/item/tank/tank = item
	if (!istype(tank))
		return

	var/mob/living/carbon/carbon_source = source
	if (!istype(carbon_source))
		return

	if (!carbon_source.can_breathe_internals())
		return

	carbon_source.visible_message(
		span_danger("[user] 正试图[(carbon_source.internal != item) ? "打开" : "关闭"] [source] 的 [item.name] 上的阀门。"),
		span_userdanger("[user] 正试图[(carbon_source.internal != item) ? "打开" : "关闭"]你的 [item.name] 上的阀门。"),
		ignored_mobs = user,
	)

	to_chat(user, span_notice("你试着[(carbon_source.internal != item) ? "打开" : "关闭"] [source] 的 [item.name] 上的阀门……"))

	if(!do_after(user, INTERNALS_TOGGLE_DELAY, carbon_source))
		return

	if (carbon_source.internal == item)
		carbon_source.close_internals()
	// This isn't meant to be FALSE, it correlates to the item's name.
	else if (!QDELETED(item))
		if(!carbon_source.try_open_internals(item))
			return

	carbon_source.visible_message(
		span_danger("[user] [isnull(carbon_source.internal) ? "关闭" : "打开"]了 [source] 的 [item.name] 上的阀门。"),
		span_userdanger("[user] [isnull(carbon_source.internal) ? "关闭" : "打开"]了你 [item.name] 上的阀门。"),
		ignored_mobs = user,
	)

	to_chat(user, span_notice("你[isnull(carbon_source.internal) ? "关闭" : "打开"]了 [source] 的 [item.name] 上的阀门。"))

#undef INTERNALS_TOGGLE_DELAY
#undef POCKET_EQUIP_DELAY
