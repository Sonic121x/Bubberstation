/*
CONTAINS:
SAFES
FLOOR SAFES
*/

/// Chance for a sound clue
#define SOUND_CHANCE 10
/// Explosion number threshold for opening safe
#define BROKEN_THRESHOLD 3

//SAFES
/obj/structure/safe
	name = "保险柜"
	desc = "一块嵌有刻度盘的大块金属。刻度盘上的小字写着\"斯卡伯勒军火公司——2 转轮保险柜，保证耐铝热剂、耐爆炸、耐助理。\""
	icon = 'icons/obj/structures.dmi'
	icon_state = "safe"
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	obj_flags = CONDUCTS_ELECTRICITY
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT
	custom_materials = list(
		/datum/material/metalhydrogen = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/alloy/plastitanium = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
	)
	material_flags = MATERIAL_EFFECTS
	/// The maximum combined w_class of stuff in the safe
	var/maxspace = 24
	/// The amount of tumblers that will be generated
	var/number_of_tumblers = 2
	/// Whether the safe is open or not
	var/open = FALSE
	/// Whether the safe is locked or not
	var/locked = TRUE
	/// The position the dial is pointing to
	var/dial = 0
	/// The list of tumbler dial positions that need to be hit
	var/list/tumblers = list()
	/// The index in the tumblers list of the tumbler dial position that needs to be hit
	var/current_tumbler_index = 1
	/// The combined w_class of everything in the safe
	var/space = 0
	/// Tough, but breakable if explosion counts reaches set value
	var/explosion_count = 0

/obj/structure/safe/Initialize(mapload)
	. = ..()

	var/static/list/tool_behaviors = list(
		TOOL_WRENCH = list(
			SCREENTIP_CONTEXT_LMB = "重置锁具",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

	// Combination generation
	for(var/iterating in 1 to number_of_tumblers)
		tumblers.Add(rand(0, 99))

	if(density)
		AddElement(/datum/element/climbable)
		AddElement(/datum/element/elevation, pixel_shift = 22)

	if(open && !locked)
		return

	update_appearance(UPDATE_ICON)

	// Put as many items on our turf inside as possible
	for(var/obj/item/inserting_item in loc)
		if(space >= maxspace)
			return
		if(inserting_item.w_class + space <= maxspace)
			space += inserting_item.w_class
			inserting_item.forceMove(src)

/obj/structure/safe/examine(mob/user)
	. = ..()
	. += span_notice("锁具机构的齿轮已用<b>扳手</b>固定到位。")

/obj/structure/safe/update_icon_state()
	//uses the same icon as the captain's spare safe (therefore lockable storage) so keep it in line with that
	icon_state = "[initial(icon_state)][open ? null : "_locked"]"
	return ..()

/obj/structure/safe/wrench_act(mob/living/user, obj/item/tool)
	if(!open)
		balloon_alert(user, "必须先打开！")
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "正在重置锁具……")
	to_chat(user, span_notice("你开始为[src]重置锁具。你需要设置 [number_of_tumblers] 个数字。"))

	var/list/new_tumblers = list()
	for(var/tumbler_index in 1 to number_of_tumblers)
		var/input_value = tgui_input_number(user, "设置第 #[tumbler_index] 个转轮（0-99）：", "设置锁具", 0, 99, 0)
		if(isnull(input_value))
			balloon_alert(user, "重置已取消！")
			return ITEM_INTERACT_BLOCKING
		if(!user.can_perform_action(src))
			balloon_alert(user, "重置被打断！")
			return ITEM_INTERACT_BLOCKING
		new_tumblers.Add(input_value)

	tool.play_tool_sound(src)
	if(!do_after(user, 10 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING

	tumblers = new_tumblers
	current_tumbler_index = 1
	dial = 0
	tool.play_tool_sound(src)
	to_chat(user, span_notice("你成功为[src]重置了锁具。新密码为：[tumblers.Join("-")]。"))
	balloon_alert(user, "锁具已设置！")
	return ITEM_INTERACT_SUCCESS

/obj/structure/safe/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.combat_mode)
		return NONE

	if(!open)
		if(!istype(tool, /obj/item/clothing/neck/stethoscope))
			to_chat(user, span_warning("保险柜关闭时，你无法将[tool]放进去！"))
			return ITEM_INTERACT_BLOCKING

		attack_hand(user)
		return ITEM_INTERACT_SUCCESS

	if(tool.w_class + space > maxspace)
		to_chat(user, span_warning("[tool]放不进[src]。"))
		return ITEM_INTERACT_BLOCKING

	if(!user.transferItemToLoc(tool, src))
		to_chat(user, span_warning("[tool]粘在你手上，你无法把它放进保险柜！"))
		return ITEM_INTERACT_BLOCKING

	space += tool.w_class
	to_chat(user, span_notice("你把[tool]放进了[src]。"))
	return ITEM_INTERACT_SUCCESS


/obj/structure/safe/blob_act(obj/structure/blob/B)
	return

/obj/structure/safe/ex_act(severity, target)
	if(((severity == EXPLODE_HEAVY && target == src) || severity == EXPLODE_DEVASTATE) && explosion_count < BROKEN_THRESHOLD)
		explosion_count++
		switch(explosion_count)
			if(1)
				desc = initial(desc) + "\n它看起来有点被撞瘪了。"
			if(2)
				desc = initial(desc) + "\n它受损相当严重。"
			if(3)
				desc = initial(desc) + "\n锁具似乎已经损坏。"

		return TRUE

	return FALSE

/obj/structure/safe/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/simple/safe),
	)

/obj/structure/safe/ui_state(mob/user)
	return GLOB.physical_state

/obj/structure/safe/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Safe", name)
		ui.open()

/obj/structure/safe/ui_data(mob/user)
	var/list/data = list()
	data["dial"] = dial
	data["open"] = open
	data["locked"] = locked
	data["broken"] = check_broken()

	if(open)
		var/list/contents_names = list()
		data["contents"] = contents_names
		for(var/obj/jewel in contents)
			contents_names[++contents_names.len] = list("name" = jewel.name, "sprite" = jewel.icon_state)
			user << browse_rsc(icon(jewel.icon, jewel.icon_state), "[jewel.icon_state].png")

	return data

/obj/structure/safe/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!ishuman(usr))
		return
	var/mob/living/carbon/human/user = usr
	if(!user.can_perform_action(src))
		return

	var/canhear = FALSE
	if(user.is_holding_item_of_type(/obj/item/clothing/neck/stethoscope))
		canhear = TRUE

	switch(action)
		if("open")
			if(!check_unlocked() && !open && !broken)
				to_chat(user, span_warning("你无法打开[src]，因为锁具已锁上！"))
				return
			to_chat(user, span_notice("你[open ? "关上" : "打开"]了[src]。"))
			open = !open
			update_appearance()
			return TRUE
		if("turnright")
			if(open)
				return
			if(broken)
				to_chat(user, span_warning("刻度盘无法转动，因为机械结构已损坏！"))
				return
			var/ticks = text2num(params["num"])
			for(var/iterate in 1 to ticks)
				dial = WRAP(dial - 1, 0, 100)

				var/invalid_turn = current_tumbler_index % 2 == 0 || current_tumbler_index > number_of_tumblers
				if(invalid_turn) // The moment you turn the wrong way or go too far, the tumblers reset
					current_tumbler_index = 1

				if(!invalid_turn && dial == tumblers[current_tumbler_index])
					notify_user(user, canhear, list("tink", "krink", "plink"), ticks, iterate)
					current_tumbler_index++
				else
					notify_user(user, canhear, list("clack", "scrape", "clank"), ticks, iterate)
			check_unlocked()
			return TRUE
		if("turnleft")
			if(open)
				return
			if(broken)
				to_chat(user, span_warning("刻度盘无法转动，因为机械结构已损坏！"))
				return
			var/ticks = text2num(params["num"])
			for(var/iterate in 1 to ticks)
				dial = WRAP(dial + 1, 0, 100)

				var/invalid_turn = current_tumbler_index % 2 != 0 || current_tumbler_index > number_of_tumblers
				if(invalid_turn) // The moment you turn the wrong way or go too far, the tumblers reset
					current_tumbler_index = 1

				if(!invalid_turn && dial == tumblers[current_tumbler_index])
					notify_user(user, canhear, list("tonk", "krunk", "plunk"), ticks, iterate)
					current_tumbler_index++
				else
					notify_user(user, canhear, list("click", "chink", "clink"), ticks, iterate)
			check_unlocked()
			return TRUE
		if("retrieve")
			if(!open)
				return
			var/index = text2num(params["index"])
			if(!index)
				return
			var/obj/item/retrieved_item = contents[index]
			if(!retrieved_item || !in_range(src, user))
				return
			user.put_in_hands(retrieved_item)
			space -= retrieved_item.w_class
			return TRUE

/**
 * Checks if safe is considered in a broken state for force-opening the safe
 */
/obj/structure/safe/proc/check_broken()
	return broken || explosion_count >= BROKEN_THRESHOLD

/**
 * Called every dial turn to determine whether the safe should unlock or not.
 */
/obj/structure/safe/proc/check_unlocked()
	if(check_broken())
		return TRUE
	if(current_tumbler_index > number_of_tumblers)
		locked = FALSE
		visible_message(span_boldnotice("[pick("Spring", "Sprang", "Sproing", "Clunk", "Krunk")]!"))
		return TRUE
	locked = TRUE
	return FALSE

/**
 * Called every dial turn to provide feedback if possible.
 */
/obj/structure/safe/proc/notify_user(user, canhear, sounds, total_ticks, current_tick)
	if(!canhear)
		return
	if(current_tick == 2)
		to_chat(user, span_italics("[src]发出的声音太快，混在一起了。"))
	if(total_ticks == 1 || prob(SOUND_CHANCE))
		balloon_alert(user, pick(sounds))

/obj/structure/safe/open
	open = TRUE
	locked = FALSE

//FLOOR SAFES
/obj/structure/safe/floor
	name = "地板保险柜"
	icon_state = "floorsafe"
	density = FALSE
	layer = LOW_OBJ_LAYER
	custom_materials = list(
		/datum/material/metalhydrogen = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/alloy/plastitanium = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.55,
	)

/obj/structure/safe/floor/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/undertile)

/obj/structure/safe/floor/open
	open = TRUE
	locked = FALSE

///Special safe for the station's vault. Not explicitly required, but the piggy bank inside it is.
/obj/structure/safe/vault

/obj/structure/safe/vault/Initialize(mapload)
	. = ..()
	var/obj/item/piggy_bank/vault/piggy = new(src)
	space += piggy.w_class

#undef SOUND_CHANCE
#undef BROKEN_THRESHOLD
