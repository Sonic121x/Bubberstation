#define MODE_GRAVOFF "关闭"
#define MODE_ANTIGRAVITY "反重力场"
#define MODE_EXTRAGRAVITY "超重力场"
#define GRAVITY_FIELD_COST STANDARD_CELL_CHARGE * 0.05
#define OFF_STATE "gravityharness-off"
#define ANTIGRAVITY_STATE "gravityharness-anti"
#define EXTRAGRAVITY_STATE "gravityharness-extra"

/obj/item/gravity_harness
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	name = "重力悬吊背带"
	desc = "这是斯克雷尔常见建造设备的山寨改型，由深空部族大量制造和使用；这条背带利用悬浮技术，可消除或放大穿戴者周围的重力。"
	slot_flags = ITEM_SLOT_BACK
	icon_state = "gravityharness-off"
	worn_icon_state = "gravityharness-off"
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/back.dmi'
	actions_types = list(/datum/action/item_action/toggle_mode)
	w_class = WEIGHT_CLASS_HUGE
	/// The current operating mode
	var/mode = MODE_GRAVOFF
	/// The cell that the harness is currently using
	var/obj/item/stock_parts/power_store/cell/current_cell
	/// If the cell cover is open or not
	var/cell_cover_open = FALSE
	/// If it's manipulating gravity at all.
	var/gravity_on = FALSE
	/// Defines sound to be played upon mode switching
	var/modeswitch_sound = 'sound/effects/pop.ogg'
	/// Max weight class of items in the storage.
	var/max_w_class = WEIGHT_CLASS_NORMAL
	/// Max combined weight of all items in the storage.
	var/max_combined_w_class = 15
	/// Max amount of items in the storage.
	var/max_items = 7

/obj/item/gravity_harness/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, ITEM_SLOT_BACK)
	if(ispath(current_cell))
		current_cell = new current_cell(src)
	create_storage(max_specific_storage = max_w_class, max_total_storage = max_combined_w_class, max_slots = max_items)

/obj/item/gravity_harness/Destroy()
	if(isatom(current_cell))
		QDEL_NULL(current_cell)

	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/gravity_harness/equipped(mob/living/user, slot, current_mode)
	. = ..()
	if(slot & ITEM_SLOT_BACK)
		START_PROCESSING(SSobj, src)
		RegisterSignal(user, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_item))

	if(!slot == ITEM_SLOT_BACK)
		mode = MODE_GRAVOFF

/// This cycles the harness's current mode to the next one, likely using the action button. Goes from Off to Anti to Extra, always.
/obj/item/gravity_harness/proc/toggle_mode(mob/user, voluntary)

	if(!istype(user) || user.incapacitated)
		return FALSE

	if(!gravity_on && (!current_cell || current_cell.charge < GRAVITY_FIELD_COST))
		if(user)
			to_chat(user, span_warning("[src] 上的重力引擎没有电量。"))

		return FALSE

	switch(mode)
		if(MODE_GRAVOFF)
			change_mode(MODE_ANTIGRAVITY)

		if(MODE_ANTIGRAVITY)
			change_mode(MODE_EXTRAGRAVITY)

		if(MODE_EXTRAGRAVITY)
			change_mode(MODE_GRAVOFF)

	playsound(src, modeswitch_sound, 50, TRUE)

///Changes the mode to `target_mode`, returns `FALSE` if the mode cannot be changed
/obj/item/gravity_harness/proc/change_mode(target_mode)
	if(!target_mode)
		return FALSE

	var/mob/living/user = loc
	if(!istype(user))
		mode = MODE_GRAVOFF
		icon_state = OFF_STATE
		worn_icon_state = OFF_STATE
		gravity_on = FALSE
		update_item_action_buttons()
		update_appearance()
		return FALSE

	gravity_on = FALSE
	user.RemoveElement(/datum/element/forced_gravity, 0)
	REMOVE_TRAIT(user, TRAIT_NEGATES_GRAVITY, CLOTHING_TRAIT)

	switch(target_mode)
		if(MODE_ANTIGRAVITY)
			mode = MODE_ANTIGRAVITY

			if(user.has_gravity())
				new /obj/effect/temp_visual/mook_dust(get_turf(src))

			user.AddElement(/datum/element/forced_gravity, 0)
			playsound(src, 'sound/effects/gravhit.ogg', 50)
			to_chat(user, span_notice("[src] 发出金属嗡鸣，投射出一片局部反重力场。"))
			gravity_on = TRUE
			icon_state = ANTIGRAVITY_STATE
			worn_icon_state = ANTIGRAVITY_STATE

		if(MODE_EXTRAGRAVITY)
			mode = MODE_EXTRAGRAVITY

			if(!user.has_gravity())
				new /obj/effect/temp_visual/mook_dust/robot(get_turf(src))

			ADD_TRAIT(user, TRAIT_NEGATES_GRAVITY, CLOTHING_TRAIT)
			playsound(src, 'modular_skyrat/master_files/sound/effects/robot_sit.ogg', 25)
			to_chat(user, span_notice("[src] 震颤嘶鸣，投射出一片局部超重力场。"))
			gravity_on = TRUE
			icon_state = EXTRAGRAVITY_STATE
			worn_icon_state = EXTRAGRAVITY_STATE

		if(MODE_GRAVOFF)
			if(!user.has_gravity() && mode != MODE_GRAVOFF)
				new /obj/effect/temp_visual/mook_dust/robot(get_turf(src))
				playsound(src, 'modular_skyrat/master_files/sound/effects/robot_sit.ogg', 25)
				to_chat(user, span_notice("[src] 发出轻柔的嗡鸣，你的悬吊场随之消散，周围重力恢复正常。"))
				mode = MODE_GRAVOFF

			else
				if(user.has_gravity() && mode != MODE_GRAVOFF)
					new /obj/effect/temp_visual/mook_dust(get_turf(src))
					playsound(src, 'sound/effects/gravhit.ogg', 50)
					to_chat(user, span_notice("[src] 发出轻柔的嗡鸣，你的悬吊场随之消散，周围重力恢复正常。"))
					mode = MODE_GRAVOFF

			icon_state = OFF_STATE
			worn_icon_state = OFF_STATE

		else
			return FALSE

	update_item_action_buttons()
	update_appearance()

	return TRUE


/obj/item/gravity_harness/dropped(mob/user)
	. = ..()
	change_mode(MODE_GRAVOFF)
	user.RemoveElement(/datum/element/forced_gravity, 0)
	REMOVE_TRAIT(user, TRAIT_NEGATES_GRAVITY, CLOTHING_TRAIT)
	STOP_PROCESSING(SSobj, src)
	UnregisterSignal(user, COMSIG_MOB_GET_STATUS_TAB_ITEMS)

/obj/item/gravity_harness/attack_self(mob/user)
	toggle_mode(user, TRUE)
/// This outputs the harness's current mode and cell charge to your status tab, so you don't need to examine it every time.
/obj/item/gravity_harness/proc/get_status_tab_item(mob/living/source, list/items)
	SIGNAL_HANDLER
	items += "个人重力场：[mode]"
	items += "电池电量：[current_cell ? "[round(current_cell.percent(), 0.1)]%" : "无电池！"]"

/obj/item/gravity_harness/process(seconds_per_tick)
	var/mob/living/carbon/human/user = loc
	if(!user || !ishuman(user) || user.back != src)
		if(mode != MODE_GRAVOFF)
			change_mode(MODE_GRAVOFF)

		return

	// Do nothing if the harness isn't emitting gravity of any kind.area
	if(!gravity_on)
		return

	// If we got here, the gravity field is on. If there's no cell, turn that shit off
	if(!current_cell)
		change_mode(MODE_GRAVOFF)
		return

	// cell.use will return FALSE if charge is lower than GRAVITY_FIELD_COST
	if(!current_cell.use(GRAVITY_FIELD_COST))
		to_chat(user, span_warning("随着 [current_cell] 电量耗尽，重力引擎停止运作了。"))
		change_mode(MODE_GRAVOFF)

/obj/item/gravity_harness/get_cell()
	if(cell_cover_open)
		return current_cell

// Show the status of the harness and cell
/obj/item/gravity_harness/examine(mob/user)
	. = ..()
	if(in_range(src, user) || isobserver(user))
		. += "重力背带处于[gravity_on ? "开启" : "关闭"]状态，力场模式为 [mode]"
		. += "电量表显示剩余电量 [current_cell ? "<b>[round(current_cell.percent(), 0.1)]%</b>。" : "[span_warning("“缺少电池”")]"]"

		if(cell_cover_open)
			. += "电池盖已打开，电池暴露在外。"
			if(!current_cell)
				. += span_warning("电池槽是空的，只露出裸露的接头。")
			else
				. += "[current_cell] 已牢牢固定到位。"

	return .

/obj/item/gravity_harness/screwdriver_act(mob/living/user, obj/item/screwdriver)
	balloon_alert(user, "[cell_cover_open ? "正在关闭" : "正在打开"]电池盖……")
	screwdriver.play_tool_sound(src, 100)

	if(!screwdriver.use_tool(src, user, 1 SECONDS))
		balloon_alert(user, "被打断了！")
		return FALSE

	screwdriver.play_tool_sound(src, 100)
	balloon_alert(user, "电池盖已[cell_cover_open ? "关闭" : "打开"]")
	cell_cover_open = !cell_cover_open
	return TRUE

/obj/item/gravity_harness/attack_hand(mob/user, list/modifiers)
	if(!cell_cover_open || loc != user)
		return ..()

	if(!current_cell)
		balloon_alert(user, "没有电池！")
		return

	balloon_alert(user, "正在取出电池……")
	if(!do_after(user, 1.5 SECONDS, target = src))
		balloon_alert(user, "被打断了！")
		return

	change_mode(MODE_GRAVOFF)
	balloon_alert(user, "电池已取出")
	playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
	if(!user.put_in_hands(current_cell))
		current_cell.forceMove(drop_location())

	current_cell = FALSE
	return

/obj/item/gravity_harness/emp_act(severity)
	. = ..()
	if(current_cell)
		current_cell.emp_act(severity)
		change_mode(MODE_GRAVOFF)

/obj/item/gravity_harness/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/cell))
		return ..()

	if(!cell_cover_open)
		balloon_alert(user, "请先打开电池盖！")
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return ITEM_INTERACT_BLOCKING

	if(current_cell)
		balloon_alert(user, "电池已安装！")
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return ITEM_INTERACT_BLOCKING

	/// Shadow realm? I'm sending you to Lake City, FL!
	tool.moveToNullspace()
	current_cell = tool
	balloon_alert(user, "电池已安装")
	playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
	return ITEM_INTERACT_SUCCESS

#undef MODE_GRAVOFF
#undef MODE_ANTIGRAVITY
#undef MODE_EXTRAGRAVITY
#undef GRAVITY_FIELD_COST
#undef OFF_STATE
#undef ANTIGRAVITY_STATE
#undef EXTRAGRAVITY_STATE
