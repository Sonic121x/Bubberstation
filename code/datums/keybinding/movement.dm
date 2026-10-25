/datum/keybinding/movement
	category = CATEGORY_MOVEMENT
	weight = WEIGHT_HIGHEST

/datum/keybinding/movement/north
	hotkey_keys = list("W", "North")
	name = "North"
	full_name = "向北移动"
	description = "让你的角色向北移动"
	keybind_signal = COMSIG_KB_MOVEMENT_NORTH_DOWN

/datum/keybinding/movement/south
	hotkey_keys = list("S", "South")
	name = "South"
	full_name = "向南移动"
	description = "让你的角色向南移动"
	keybind_signal = COMSIG_KB_MOVEMENT_SOUTH_DOWN

/datum/keybinding/movement/west
	hotkey_keys = list("A", "West")
	name = "West"
	full_name = "向西移动"
	description = "让你的角色向左移动"
	keybind_signal = COMSIG_KB_MOVEMENT_WEST_DOWN

/datum/keybinding/movement/east
	hotkey_keys = list("D", "East")
	name = "East"
	full_name = "向东移动"
	description = "让你的角色向东移动"
	keybind_signal = COMSIG_KB_MOVEMENT_EAST_DOWN

/datum/keybinding/movement/zlevel_upwards
	hotkey_keys = list("Northeast") // PGUP
	name = "Upwards"
	full_name = "向上移动"
	description = "在条件允许时，让你的角色向上移动一层"
	keybind_signal = COMSIG_KB_MOVEMENT_ZLEVEL_MOVEUP_DOWN

/datum/keybinding/movement/zlevel_upwards/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.mob.up()
	return TRUE

/datum/keybinding/movement/zlevel_downwards
	hotkey_keys = list("Southeast") // PGDOWN
	name = "Downwards"
	full_name = "向下移动"
	description = "在条件允许时，让你的角色向下移动一层"
	keybind_signal = COMSIG_KB_MOVEMENT_ZLEVEL_MOVEDOWN_DOWN

/datum/keybinding/movement/zlevel_downwards/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.mob.down()
	return TRUE
