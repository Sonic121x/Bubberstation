/datum/keybinding/mob
	category = CATEGORY_HUMAN
	weight = WEIGHT_MOB

/datum/keybinding/mob/stop_pulling
	hotkey_keys = list("H", "Delete")
	name = "stop_pulling"
	full_name = "停止拖拽"
	description = ""
	keybind_signal = COMSIG_KB_MOB_STOPPULLING_DOWN

/datum/keybinding/mob/stop_pulling/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/M = user.mob
	if(!M.pulling)
		to_chat(user, span_notice("你没有拖拽任何东西。"))
	else
		M.stop_pulling()
	return TRUE

/datum/keybinding/mob/swap_hands
	hotkey_keys = list("X")
	name = "swap_hands"
	full_name = "切换双手"
	description = ""
	keybind_signal = COMSIG_KB_MOB_SWAPHANDS_DOWN

/datum/keybinding/mob/swap_hands/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/M = user.mob
	M.swap_hand()
	return TRUE

/datum/keybinding/mob/select_hand
	var/hand_index = NONE

/datum/keybinding/mob/select_hand/right
	hotkey_keys = list(UNBOUND_KEY)
	name = "select_right_hand"
	full_name = "切换至右手"
	keybind_signal = COMSIG_KB_MOB_SELECTRIGHTHAND_DOWN
	hand_index = RIGHT_HANDS

/datum/keybinding/mob/select_hand/left
	hotkey_keys = list(UNBOUND_KEY)
	name = "select_left_hand"
	full_name = "切换至左手"
	keybind_signal = COMSIG_KB_MOB_SELECTLEFTHAND_DOWN
	hand_index = LEFT_HANDS

/datum/keybinding/mob/select_hand/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return

	var/mob/user_mob = user.mob
	var/active_hand_set = ceil(user_mob.active_hand_index / 2) - 1 //offset
	var/desired_hand_index = hand_index + (2 * active_hand_set)

	user_mob.swap_hand(desired_hand_index)

	return TRUE

/datum/keybinding/mob/activate_inhand
	hotkey_keys = list("Z")
	name = "activate_inhand"
	full_name = "使用手中物品"
	description = "使用你当前手持的物品"
	keybind_signal = COMSIG_KB_MOB_ACTIVATEINHAND_DOWN

/datum/keybinding/mob/activate_inhand/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/M = user.mob
	M.mode()
	return TRUE

/datum/keybinding/mob/drop_item
	hotkey_keys = list("Q")
	name = "drop_item"
	full_name = "放下物品"
	description = "将当前手中的物品放到地上。"
	keybind_signal = COMSIG_KB_MOB_DROPITEM_DOWN

/datum/keybinding/mob/drop_item/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	if(iscyborg(user.mob)) //cyborgs can't drop items
		return FALSE
	var/mob/user_mob = user.mob
	var/obj/item/item_dropped = user_mob.get_active_held_item()
	if(!item_dropped)
		to_chat(user, span_warning("你手里没有可以放下的物品！"))
		return TRUE
	user.mob.dropItemToGround(item_dropped)
	return TRUE

/datum/keybinding/mob/drop_item_specific
	hotkey_keys = list("CtrlX")
	name = "drop_item_specific"
	full_name = "放下物品（指定位置）"
	description = "若鼠标所指位置在范围内，将当前手中的物品放到那里。"
	keybind_signal = COMSIG_KB_MOB_DROPITEM_DOWN

/datum/keybinding/mob/drop_item_specific/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	if(iscyborg(user.mob)) //cyborgs can't drop items
		return FALSE
	var/mob/user_mob = user.mob
	var/obj/item/item_dropped = user_mob.get_active_held_item()
	if(!item_dropped)
		to_chat(user, span_warning("你手里没有可以放下的物品！"))
		return TRUE
	if(!user_mob.Adjacent(target) || target.is_blocked_turf(source_atom = item_dropped))
		return TRUE
	var/x_value = (mousepos_x >= 0) ? mousepos_x - ICON_SIZE_X / 2 : mousepos_x + ICON_SIZE_X / 2
	var/y_value = (mousepos_y >= 0) ? mousepos_y - ICON_SIZE_Y / 2 : mousepos_y + ICON_SIZE_Y / 2
	user_mob.transfer_item_to_turf(item_dropped, target, x_value, y_value)
	return TRUE

/datum/keybinding/mob/target/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return .

	var/original = user.mob.zone_selected
	switch(keybind_signal)
		if(COMSIG_KB_MOB_TARGETCYCLEHEAD_DOWN)
			user.body_toggle_head()
		if(COMSIG_KB_MOB_TARGETHEAD_DOWN)
			user.body_head()
		if(COMSIG_KB_MOB_TARGETEYES_DOWN)
			user.body_eyes()
		if(COMSIG_KB_MOB_TARGETMOUTH_DOWN)
			user.body_mouth()
		if(COMSIG_KB_MOB_TARGETRIGHTARM_DOWN)
			user.body_r_arm()
		if(COMSIG_KB_MOB_TARGETBODYCHEST_DOWN)
			user.body_chest()
		if(COMSIG_KB_MOB_TARGETLEFTARM_DOWN)
			user.body_l_arm()
		if(COMSIG_KB_MOB_TARGETRIGHTLEG_DOWN)
			user.body_r_leg()
		if(COMSIG_KB_MOB_TARGETBODYGROIN_DOWN)
			user.body_groin()
		if(COMSIG_KB_MOB_TARGETLEFTLEG_DOWN)
			user.body_l_leg()
		else
			stack_trace("Target keybind pressed but not implemented! '[keybind_signal]'")
			return FALSE
	user.mob.log_manual_zone_selected_update("keybind", old_target = original)

/datum/keybinding/mob/target/head_cycle
	hotkey_keys = list("Numpad8")
	name = "target_head_cycle"
	full_name = "瞄准：循环选择头部"
	description = "按下此键瞄准头部，继续按可循环选择眼睛和嘴部。这会改变攻击命中的部位，也可用于手术。"
	keybind_signal = COMSIG_KB_MOB_TARGETCYCLEHEAD_DOWN

/datum/keybinding/mob/target/head
	hotkey_keys = list(UNBOUND_KEY)
	name = "target_head"
	full_name = "瞄准：头部"
	description = "按下此键瞄准头部。这会改变攻击命中的部位，也可用于手术。"
	keybind_signal = COMSIG_KB_MOB_TARGETHEAD_DOWN

/datum/keybinding/mob/target/eyes
	hotkey_keys = list("Numpad7")
	name = "target_eyes"
	full_name = "瞄准：眼睛"
	description = "按下此键瞄准眼睛。这会改变攻击命中的部位，也可用于手术。"
	keybind_signal = COMSIG_KB_MOB_TARGETEYES_DOWN

/datum/keybinding/mob/target/mouth
	hotkey_keys = list("Numpad9")
	name = "target_mouths"
	full_name = "瞄准：嘴部"
	description = "按下此键瞄准嘴部。这会改变攻击命中的部位，也可用于手术。"
	keybind_signal = COMSIG_KB_MOB_TARGETMOUTH_DOWN

/datum/keybinding/mob/target/r_arm
	hotkey_keys = list("Numpad4")
	name = "target_r_arm"
	full_name = "瞄准：右臂"
	description = "按下此键瞄准右臂。这会改变攻击命中的部位，也可用于手术。"
	keybind_signal = COMSIG_KB_MOB_TARGETRIGHTARM_DOWN

/datum/keybinding/mob/target/body_chest
	hotkey_keys = list("Numpad5")
	name = "target_body_chest"
	full_name = "瞄准：躯干"
	description = "按下此键瞄准躯干。这会改变攻击命中的部位，也可用于手术。"
	keybind_signal = COMSIG_KB_MOB_TARGETBODYCHEST_DOWN

/datum/keybinding/mob/target/left_arm
	hotkey_keys = list("Numpad6")
	name = "target_left_arm"
	full_name = "瞄准：左臂"
	description = "按下此键瞄准左臂。这会改变攻击命中的部位，也可用于手术。"
	keybind_signal = COMSIG_KB_MOB_TARGETLEFTARM_DOWN

/datum/keybinding/mob/target/right_leg
	hotkey_keys = list("Numpad1")
	name = "target_right_leg"
	full_name = "瞄准：右腿"
	description = "按下此键瞄准右腿。这会改变攻击命中的部位，也可用于手术。"
	keybind_signal = COMSIG_KB_MOB_TARGETRIGHTLEG_DOWN

/datum/keybinding/mob/target/body_groin
	hotkey_keys = list("Numpad2")
	name = "target_body_groin"
	full_name = "瞄准：腹股沟"
	description = "按下此键瞄准腹股沟。这会改变攻击命中的部位，也可用于手术。"
	keybind_signal = COMSIG_KB_MOB_TARGETBODYGROIN_DOWN

/datum/keybinding/mob/target/left_leg
	hotkey_keys = list("Numpad3")
	name = "target_left_leg"
	full_name = "瞄准：左腿"
	description = "按下此键瞄准左腿。这会改变攻击命中的部位，也可用于手术。"
	keybind_signal = COMSIG_KB_MOB_TARGETLEFTLEG_DOWN

/datum/keybinding/mob/prevent_movement
	hotkey_keys = list("Alt")
	name = "block_movement"
	full_name = "阻止移动"
	description = "阻止你移动"
	keybind_signal = COMSIG_KB_MOB_BLOCKMOVEMENT_DOWN

/datum/keybinding/mob/prevent_movement/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.movement_locked = TRUE

/datum/keybinding/mob/prevent_movement/up(client/user, turf/target)
	. = ..()
	if(.)
		return
	user.movement_locked = FALSE
