/datum/keybinding/admin
	category = CATEGORY_ADMIN
	weight = WEIGHT_ADMIN

/datum/keybinding/admin/can_use(client/user)
	return user.holder ? TRUE : FALSE

/datum/keybinding/admin/admin_say
	hotkey_keys = list("F3")
	name = ADMIN_CHANNEL
	full_name = "管理员聊天"
	description = "与其他管理员交谈。"
	keybind_signal = COMSIG_KB_ADMIN_ASAY_DOWN

/datum/keybinding/admin/admin_ghost
	hotkey_keys = list("F5")
	name = "admin_ghost"
	full_name = "管理员幽灵"
	description = "进入幽灵状态"
	keybind_signal = COMSIG_KB_ADMIN_AGHOST_DOWN

/datum/keybinding/admin/admin_ghost/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/admin_ghost)
	return TRUE

/datum/keybinding/admin/jump_to_ghost
	hotkey_keys = list("F4")
	name = "jump_to_ghost"
	full_name = "身体传送至管理员幽灵"
	description = "将你的身体传送到管理员幽灵所在位置"
	keybind_signal = COMSIG_KB_ADMIN_JUMPTOGHOST_DOWN

/datum/keybinding/admin/jump_to_ghost/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/jump_to_ghost)
	return TRUE

/datum/keybinding/admin/player_panel_new
	hotkey_keys = list("F6")
	name = "player_panel_new"
	full_name = "新版玩家面板"
	description = "打开新版玩家面板"
	keybind_signal = COMSIG_KB_ADMIN_PLAYERPANELNEW_DOWN

/datum/keybinding/admin/player_panel_new/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.holder.player_panel_new()
	return TRUE

/datum/keybinding/admin/toggle_buildmode_self
	hotkey_keys = list("F7")
	name = "toggle_buildmode_self"
	full_name = "切换自身建造模式"
	description = "切换建造模式"
	keybind_signal = COMSIG_KB_ADMIN_TOGGLEBUILDMODE_DOWN

/datum/keybinding/admin/toggle_buildmode_self/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/build_mode_self)
	return TRUE

/datum/keybinding/admin/stealthmode
	hotkey_keys = list("CtrlF8")
	name = "stealth_mode"
	full_name = "隐匿模式"
	description = "进入隐匿模式"
	keybind_signal = COMSIG_KB_ADMIN_STEALTHMODETOGGLE_DOWN

/datum/keybinding/admin/stealthmode/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/stealth)
	return TRUE

/datum/keybinding/admin/invisimin
	hotkey_keys = list("F8")
	name = "invisimin"
	full_name = "管理员隐身"
	description = "切换幽灵般的隐身状态（请勿滥用）"
	keybind_signal = COMSIG_KB_ADMIN_INVISIMINTOGGLE_DOWN

/datum/keybinding/admin/invisimin/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/invisimin)
	return TRUE

/datum/keybinding/admin/deadsay
	hotkey_keys = list("F10")
	name = "dsay"
	full_name = "亡者聊天"
	description = "向亡者频道发送消息"
	keybind_signal = COMSIG_KB_ADMIN_DSAY_DOWN

/datum/keybinding/admin/deadsay/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.get_dead_say()
	return TRUE

/datum/keybinding/admin/deadmin
	hotkey_keys = list(UNBOUND_KEY)
	name = "deadmin"
	full_name = "卸下管理员权限"
	description = "暂时卸下你的管理员权限"
	keybind_signal = COMSIG_KB_ADMIN_DEADMIN_DOWN

/datum/keybinding/admin/deadmin/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/deadmin)
	return TRUE

/datum/keybinding/admin/readmin
	hotkey_keys = list(UNBOUND_KEY)
	name = "readmin"
	full_name = "恢复管理员权限"
	description = "重新获得你的管理员权限"
	keybind_signal = COMSIG_KB_ADMIN_READMIN_DOWN

/datum/keybinding/admin/readmin/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.readmin()
	return TRUE

/datum/keybinding/admin/view_tags
	hotkey_keys = list("F9")
	name = "view_tags"
	full_name = "查看标签"
	description = "打开标签查看菜单"
	keybind_signal = COMSIG_KB_ADMIN_VIEWTAGS_DOWN

/datum/keybinding/admin/view_tags/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/display_tags)
	return TRUE

/datum/keybinding/admin/admin_verb_panel
	hotkey_keys = list("`")
	name = "admin_verb_panel"
	full_name = "管理员命令面板"
	description = "打开管理员命令面板"
	keybind_signal = COMSIG_KB_ADMIN_VERBPANEL_DOWN

/datum/keybinding/admin/admin_verb_panel/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/admin_verb_panel)
	return TRUE
