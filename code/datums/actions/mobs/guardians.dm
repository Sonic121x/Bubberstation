/datum/action/cooldown/guardian
	button_icon = 'icons/hud/guardian.dmi'

/datum/action/cooldown/guardian/IsAvailable(feedback)
	. = ..()
	if(!.)
		return .
	return !!isguardian(owner)

/datum/action/cooldown/guardian/check_type
	name = "查看类型"
	desc = "查看你的能力说明。"
	//this is based off of the antag ui icon, if that changes then change this too please.
	button_icon_state = /datum/action/antag_info::button_icon_state
	default_button_position = SCRN_OBJ_INSERT_FIRST

/datum/action/cooldown/guardian/check_type/Activate(atom/target)
	. = ..()
	to_chat(owner, astype(owner, /mob/living/basic/guardian)?.playstyle_string)

/datum/action/cooldown/guardian/communicate
	name = "心灵交流"
	desc = "通过心灵感应与你的宿主交流。"
	button_icon_state = "communicate"
	default_button_position = ui_guardian_communication

/datum/action/cooldown/guardian/communicate/Activate()
	astype(owner, /mob/living/basic/guardian)?.communicate()

/datum/action/cooldown/guardian/manifest
	name = "现身"
	desc = "现身投入战斗！"
	button_icon_state = "manifest"
	default_button_position = ui_guardian_manifest

/datum/action/cooldown/guardian/manifest/Activate()
	astype(owner, /mob/living/basic/guardian)?.manifest()

/datum/action/cooldown/guardian/recall
	name = "返回"
	desc = "回到你的宿主体内。"
	button_icon_state = "recall"
	default_button_position = ui_guardian_recall

/datum/action/cooldown/guardian/recall/Activate()
	astype(owner, /mob/living/basic/guardian)?.recall()

/datum/action/cooldown/guardian/toggle_light
	name = "切换发光"
	desc = "像星尘一样发光。"
	button_icon_state = "light"

/datum/action/cooldown/guardian/toggle_light/Activate()
	astype(owner, /mob/living/basic/guardian)?.toggle_light()

/datum/action/cooldown/guardian/toggle_mode
	name = "切换模式"
	desc = "切换能力模式。"
	button_icon_state = "toggle"
	default_button_position = ui_guardian_special

/datum/action/cooldown/guardian/toggle_mode/Activate()
	astype(owner, /mob/living/basic/guardian)?.toggle_modes()

/datum/action/cooldown/guardian/toggle_mode/assassin
	name = "切换潜行"
	desc = "进入或退出潜行状态。"
	button_icon_state = "stealth"
	transparent_when_unavailable = TRUE

/datum/action/cooldown/guardian/toggle_mode/assassin/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return owner.has_status_effect(/datum/status_effect/guardian_stealth)

/datum/action/cooldown/guardian/toggle_mode/gases
	name = "切换气体"
	desc = "切换可释放的气体。"
	button_icon_state = "gases"
