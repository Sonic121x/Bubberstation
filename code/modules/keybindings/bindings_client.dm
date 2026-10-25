// Clients aren't datums so we have to define these procs indpendently.
// These verbs are called for all key press and release events
GAME_VERB_NATIVE_INSTANT(/client, keyDown, "keyDown", null, _key as text, mousepos_x as num, mousepos_y as num, sizex as num, sizey as num)

	client_keysend_amount += 1

	var/cache = client_keysend_amount

	if(keysend_tripped && next_keysend_trip_reset <= world.time)
		keysend_tripped = FALSE

	if(next_keysend_reset <= world.time)
		client_keysend_amount = 0
		next_keysend_reset = world.time + (1 SECONDS)

	//The "tripped" system is to confirm that flooding is still happening after one spike
	//not entirely sure how byond commands interact in relation to lag
	//don't want to kick people if a lag spike results in a huge flood of commands being sent
	if(cache >= MAX_KEYPRESS_AUTOKICK)
		if(!keysend_tripped)
			keysend_tripped = TRUE
			next_keysend_trip_reset = world.time + (2 SECONDS)
		else
			to_chat(src, span_userdanger("按键洪泛！这可能是由卡顿引起的，也可能是插着游戏手柄导致的。你已被服务器自动断开连接。"))
			log_admin("客户端 [ckey] 因按键洪泛被自动踢出；可能是滥用，但也可能是卡顿尖峰。")
			message_admins("客户端 [ckey] 因按键洪泛被自动踢出；可能是滥用，但也可能是卡顿尖峰。")
			qdel(src)
			return

	///Check if the key is short enough to even be a real key
	if(LAZYLEN(_key) > MAX_KEYPRESS_COMMANDLENGTH)
		to_chat(src, span_userdanger("检测到无效的按键按下事件！你已被服务器自动断开连接。"))
		log_admin("客户端 [ckey] 刚刚尝试发送无效按键。按键消息长度超过 [MAX_KEYPRESS_COMMANDLENGTH] 个字符，因疑似滥用而自动踢出。")
		message_admins("客户端 [ckey] 刚刚尝试发送无效按键。按键消息长度超过 [MAX_KEYPRESS_COMMANDLENGTH] 个字符，因疑似滥用而自动踢出。")
		qdel(src)
		return

	//Focus Chat failsafe. Overrides movement checks to prevent WASD.
	if(!hotkeys && length(_key) == 1 && _key != "Alt" && _key != "Ctrl" && _key != "Shift")
		winset(src, null, "input.focus=true ; input.text=[url_encode(_key)]")
		return

	if(length(keys_held) >= HELD_KEY_BUFFER_LENGTH && !keys_held[_key])
		keyUp(keys_held[1], mousepos_x, mousepos_y, sizex, sizey) //We are going over the number of possible held keys, so let's remove the first one.

	//the time a key was pressed isn't actually used anywhere (as of 2019-9-10) but this allows easier access usage/checking
	keys_held[_key] = world.time
	var/movement = movement_keys[_key]
	if(movement)
		calculate_move_dir()
		if(!movement_locked && !(next_move_dir_sub & movement))
			next_move_dir_add |= movement

	// Client-level keybindings are ones anyone should be able to do at any time
	// Things like taking screenshots, hitting tab, and adminhelps.
	var/AltMod = keys_held["Alt"] ? "Alt" : ""
	var/CtrlMod = keys_held["Ctrl"] ? "Ctrl" : ""
	var/ShiftMod = keys_held["Shift"] ? "Shift" : ""
	var/full_key
	switch(_key)
		if("Alt", "Ctrl", "Shift")
			full_key = "[AltMod][CtrlMod][ShiftMod]"
		else
			if(AltMod || CtrlMod || ShiftMod)
				full_key = "[AltMod][CtrlMod][ShiftMod][_key]"
				key_combos_held[_key] = full_key
			else
				full_key = _key

	var/list/click_data = get_loc_from_mousepos(mousepos_x, mousepos_y, sizex, sizey, src)

	var/keycount = 0
	for(var/kb_name in prefs.key_bindings_by_key[full_key])
		keycount++
		var/datum/keybinding/kb = GLOB.keybindings_by_name[kb_name]
		if(kb.can_use(src) && kb.down(src, click_data[1], click_data[2], click_data[3]) && keycount >= MAX_COMMANDS_PER_KEY)
			break

	holder?.key_down(_key, src, full_key)
	mob.focus?.key_down(_key, src, full_key)
	mob.update_mouse_pointer()

GAME_VERB_NATIVE_INSTANT(/client, keyUp, "keyUp", null, _key as text, mousepos_x as num, mousepos_y as num, sizex as num, sizey as num)

	var/key_combo = key_combos_held[_key]
	if(key_combo)
		key_combos_held -= _key
		keyUp(key_combo, mousepos_x, mousepos_y, sizex, sizey)

	if(!keys_held[_key])
		return

	keys_held -= _key

	var/movement = movement_keys[_key]
	if(movement)
		calculate_move_dir()
		if(!movement_locked && !(next_move_dir_add & movement))
			next_move_dir_sub |= movement
	var/list/click_data
	//manual calls of keyup
	if(mousepos_x && mousepos_y)
		click_data = get_loc_from_mousepos(mousepos_x, mousepos_y, sizex, sizey, src)
	// We don't do full key for release, because for mod keys you
	// can hold different keys and releasing any should be handled by the key binding specifically
	for (var/kb_name in prefs.key_bindings_by_key[_key])
		var/datum/keybinding/kb = GLOB.keybindings_by_name[kb_name]
		if(kb.can_use(src) && kb.up(src, click_data?[1]))
			break
	holder?.key_up(_key, src)
	mob.focus?.key_up(_key, src)
	mob.update_mouse_pointer()

