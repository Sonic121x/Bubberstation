/datum/keybinding/robot
	category = CATEGORY_ROBOT
	weight = WEIGHT_ROBOT

/datum/keybinding/robot/can_use(client/user)
	return iscyborg(user.mob)

/datum/keybinding/robot/moduleone
	hotkey_keys = list("1")
	name = "module_one"
	full_name = "切换模块 1"
	description = "装备或收起第一个模块"
	keybind_signal = COMSIG_KB_SILICON_TOGGLEMODULEONE_DOWN

/datum/keybinding/robot/moduleone/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/silicon/robot/R = user.mob
	R.toggle_module(1)
	return TRUE

/datum/keybinding/robot/moduletwo
	hotkey_keys = list("2")
	name = "module_two"
	full_name = "切换模块 2"
	description = "装备或收起第二个模块"
	keybind_signal = COMSIG_KB_SILICON_TOGGLEMODULETWO_DOWN

/datum/keybinding/robot/moduletwo/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/silicon/robot/R = user.mob
	R.toggle_module(2)
	return TRUE

/datum/keybinding/robot/modulethree
	hotkey_keys = list("3")
	name = "module_three"
	full_name = "切换模块 3"
	description = "装备或收起第三个模块"
	keybind_signal = COMSIG_KB_SILICON_TOGGLEMODULETHREE_DOWN

/datum/keybinding/robot/modulethree/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/silicon/robot/R = user.mob
	R.toggle_module(3)
	return TRUE

/datum/keybinding/robot/unequip_module
	hotkey_keys = list("Q")
	name = "unequip_module"
	full_name = "收起模块"
	description = "收起当前激活的模块"
	keybind_signal = COMSIG_KB_SILICON_UNEQUIPMODULE_DOWN

/datum/keybinding/robot/unequip_module/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/silicon/robot/R = user.mob
	R.uneq_active()
	return TRUE

/datum/keybinding/robot/undeploy
	category = CATEGORY_AI
	hotkey_keys = list("=")
	name = "undeploy"
	full_name = "断开外壳连接"
	description = "返回你的 AI 核心"
	keybind_signal = COMSIG_KB_SILION_UNDEPLOY_DOWN

/datum/keybinding/robot/undeploy/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/silicon/robot/shell/our_shell = user.mob
	//We make sure our shell is actually a shell
	if(our_shell.shell == FALSE)
		return
	our_shell.undeploy()
	return TRUE
