/datum/keybinding/living
	category = CATEGORY_HUMAN
	weight = WEIGHT_MOB

/datum/keybinding/living/can_use(client/user)
	return isliving(user.mob)

/datum/keybinding/living/resist
	hotkey_keys = list("B")
	name = "resist"
	full_name = "挣脱"
	description = "摆脱当前的束缚。被铐住了？着火了？快挣脱！"
	keybind_signal = COMSIG_KB_LIVING_RESIST_DOWN

/datum/keybinding/living/resist/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/owner = user.mob
	owner.resist()
	if (owner.hud_used?.screen_objects[HUD_MOB_RESIST])
		owner.hud_used.screen_objects[HUD_MOB_RESIST].icon_state = "[owner.hud_used.screen_objects[HUD_MOB_RESIST].base_icon_state]_on"
	return TRUE

/datum/keybinding/living/resist/up(client/user, turf/target)
	. = ..()
	if(.)
		return
	var/mob/living/owner = user.mob
	if (owner.hud_used?.screen_objects[HUD_MOB_RESIST])
		owner.hud_used.screen_objects[HUD_MOB_RESIST].icon_state = owner.hud_used.screen_objects[HUD_MOB_RESIST].base_icon_state

/datum/keybinding/living/look_up
	// hotkey_keys = list("L") // ORIGINAL
	hotkey_keys = list("P") //SKYRAT EDIT CHANGE - CUSTOMIZATION
	name = "look up"
	full_name = "向上看"
	description = "观察上一层，仅在正上方没有遮挡时可用。"
	keybind_signal = COMSIG_KB_LIVING_LOOKUP_DOWN

/datum/keybinding/living/look_up/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/L = user.mob
	L.look_up()
	return TRUE

/datum/keybinding/living/look_up/up(client/user, turf/target)
	. = ..()
	var/mob/living/L = user.mob
	L.end_look()
	return TRUE

/datum/keybinding/living/look_down
	// hotkey_keys = list(";") // ORIGINAL
	hotkey_keys = list("\[") //SKYRAT EDIT CHANGE - CUSTOMIZATION
	name = "look down"
	full_name = "向下看"
	description = "观察下一层，仅在正下方没有遮挡时可用。"
	keybind_signal = COMSIG_KB_LIVING_LOOKDOWN_DOWN

/datum/keybinding/living/look_down/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/L = user.mob
	L.look_down()
	return TRUE

/datum/keybinding/living/look_down/up(client/user, turf/target)
	. = ..()
	var/mob/living/L = user.mob
	L.end_look()
	return TRUE

/datum/keybinding/living/rest
	hotkey_keys = list("U")
	name = "rest"
	full_name = "休息"
	description = "躺下或起身。"
	keybind_signal = COMSIG_KB_LIVING_REST_DOWN

/datum/keybinding/living/rest/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/living_mob = user.mob
	living_mob.toggle_resting()
	return TRUE

/datum/keybinding/living/toggle_combat_mode
	hotkey_keys = list("F")
	name = "toggle_combat_mode"
	full_name = "切换战斗模式"
	description = "切换战斗模式。类似于帮助/伤害意图切换，但更酷。"
	keybind_signal = COMSIG_KB_LIVING_TOGGLE_COMBAT_DOWN


/datum/keybinding/living/toggle_combat_mode/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/user_mob = user.mob
	user_mob.set_combat_mode(!user_mob.combat_mode, FALSE)

/datum/keybinding/living/enable_combat_mode
	hotkey_keys = list("4")
	name = "enable_combat_mode"
	full_name = "开启战斗模式"
	description = "开启战斗模式。"
	keybind_signal = COMSIG_KB_LIVING_ENABLE_COMBAT_DOWN

/datum/keybinding/living/enable_combat_mode/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/user_mob = user.mob
	user_mob.set_combat_mode(TRUE, silent = FALSE)

/datum/keybinding/living/disable_combat_mode
	hotkey_keys = list("1")
	name = "disable_combat_mode"
	full_name = "关闭战斗模式"
	description = "关闭战斗模式。"
	keybind_signal = COMSIG_KB_LIVING_DISABLE_COMBAT_DOWN

/datum/keybinding/living/disable_combat_mode/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/user_mob = user.mob
	user_mob.set_combat_mode(FALSE, silent = FALSE)

/datum/keybinding/living/toggle_move_intent
	hotkey_keys = list("Alt") //SKYRAT EDIT CHANGE - C IS FOR COMBAT INDICATOR - ORIGINAL: hotkey_keys = list("C")
	name = "toggle_move_intent"
	full_name = "按住切换移动方式"
	description = "按住时切换移动方式，松开后恢复原来的方式"
	keybind_signal = COMSIG_KB_LIVING_TOGGLEMOVEINTENT_DOWN

/datum/keybinding/living/toggle_move_intent/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/M = user.mob
	M.toggle_move_intent()
	return TRUE

/datum/keybinding/living/toggle_move_intent/up(client/user, turf/target)
	. = ..()
	var/mob/living/M = user.mob
	M.toggle_move_intent()
	return TRUE

/datum/keybinding/living/toggle_move_intent_alternative
	hotkey_keys = list(UNBOUND_KEY)
	name = "toggle_move_intent_alt"
	full_name = "按下切换移动方式"
	description = "按下后切换移动方式，松开不会恢复原来的方式"
	keybind_signal = COMSIG_KB_LIVING_TOGGLEMOVEINTENTALT_DOWN

/datum/keybinding/living/toggle_move_intent_alternative/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/M = user.mob
	M.toggle_move_intent()
	return TRUE

/datum/keybinding/living/toggle_throw_mode
	hotkey_keys = list("R", "Southwest") // END
	name = "toggle_throw_mode"
	full_name = "切换投掷模式"
	description = "切换是否投掷当前物品。"
	keybind_signal = COMSIG_KB_LIVING_TOGGLETHROWMODE_DOWN

/datum/keybinding/living/toggle_throw_mode/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	living_user.toggle_throw_mode()
	return TRUE

/datum/keybinding/living/hold_throw_mode
	hotkey_keys = list("Space")
	name = "hold_throw_mode"
	full_name = "按住进入投掷模式"
	description = "按住时开启投掷模式，松开后关闭"
	keybind_signal = COMSIG_KB_LIVING_HOLDTHROWMODE_DOWN

/datum/keybinding/living/hold_throw_mode/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	living_user.throw_mode_on(THROW_MODE_HOLD)

/datum/keybinding/living/hold_throw_mode/up(client/user, turf/target)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	living_user.throw_mode_off(THROW_MODE_HOLD)

/datum/keybinding/living/give
	hotkey_keys = list("G")
	name = "Give_Item"
	full_name = "递出物品"
	description = "将你当前手持的物品递给别人"
	keybind_signal = COMSIG_KB_LIVING_GIVEITEM_DOWN

/datum/keybinding/living/give/can_use(client/user)
	. = ..()
	if (!.)
		return FALSE
	if(!user.mob)
		return FALSE
	var/obj/item/object = user.mob.get_active_held_item()
	if(isnull(object))
		return FALSE
	if(HAS_TRAIT(object, TRAIT_BORG_GIVE))
		return TRUE
	if(!HAS_TRAIT(user.mob, TRAIT_CAN_HOLD_ITEMS))
		return FALSE
	return TRUE

/datum/keybinding/living/give/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	var/obj/item/held_item = living_user.get_active_held_item()
	if(isnull(held_item))
		return
	if(!HAS_TRAIT(living_user, TRAIT_CAN_HOLD_ITEMS) && !HAS_TRAIT(held_item, TRAIT_BORG_GIVE))
		return
	living_user.give()

/datum/keybinding/living/view_pet_data
	hotkey_keys = list("Shift")
	name = "view_pet_commands"
	full_name = "查看宠物指令"
	description = "按住以查看你能向宠物发出的所有指令！"
	keybind_signal = COMSIG_KB_LIVING_VIEW_PET_COMMANDS

/datum/keybinding/living/cancel_interactions
	name = "stop_interactions"
	full_name = "取消交互"
	description = "取消正在进行的交互（例如使用工具、进行手术或攀爬）。\
		部分交互无法中断，此快捷键也无法取消其他玩家发起的交互。"
	keybind_signal = COMSIG_KB_LIVING_STOP_INTERACTIONS_DOWN

/datum/keybinding/living/cancel_interactions/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/mob_user = user.mob
	if(!LAZYLEN(mob_user.do_afters) || HAS_TRAIT(mob_user, TRAIT_INCAPACITATED))
		return
	// this is currently the best way to stop all ongoing doafters
	mob_user.incapacitate(0.1 SECONDS, ignore_canstun = TRUE)
