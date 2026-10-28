/// Holotool mode names also identify icon states; localize only their presentation.
/proc/chinese_holotool_mode_display(value)
	var/static/list/names = list("off" = "关闭", "holo-screwdriver" = "全息螺丝刀", "holo-crowbar" = "全息撬棍", "holo-multitool" = "全息多功能工具", "holo-wrench" = "全息扳手", "holo-wirecutters" = "全息剪线钳", "holo-welder" = "全息焊接器", "holo-knife" = "全息刀")
	return names[value] || value

/datum/preference/choiced/proc/chinese_zubbers_quirk_choice()
	return istype(src, /datum/preference/choiced/permanent_limp) || istype(src, /datum/preference/choiced/seamless_heel_type) || istype(src, /datum/preference/choiced/entombed_skin) || istype(src, /datum/preference/choiced/entombed_hardlight_theme) || istype(src, /datum/preference/choiced/hypnotic_span) || istype(src, /datum/preference/choiced/pet_owner) || istype(src, /datum/preference/choiced/pet_gender)

/proc/chinese_holotool_radial(mob/user, atom/anchor, list/choices, datum/callback/custom_check, require_near = TRUE)
	var/list/displayed = list()
	var/list/original = list()
	for(var/datum/holotool_mode/mode as anything in choices)
		var/label = chinese_holotool_mode_display(mode.name)
		displayed[label] = choices[mode]
		original[label] = mode
	var/picked = show_radial_menu(user, anchor, displayed, custom_check = custom_check, require_near = require_near)
	return original[picked]

/proc/chinese_admin_radio_choice(mob/user, message, title, list/choices)
	var/list/displayed = list()
	for(var/choice in choices)
		displayed[chinese_radio_channel_display(choice)] = choice
	var/selected = tgui_input_list(user, message, title, displayed)
	return displayed[selected]

/proc/chinese_boombox_radial(mob/user, atom/anchor, list/choices)
	var/static/list/labels = list("Play" = "播放", "Stop" = "停止", "Eject" = "弹出")
	var/list/displayed = list()
	var/list/original = list()
	for(var/key in choices)
		var/label = labels[key] || key
		displayed[label] = choices[key]
		original[label] = key
	var/selected = show_radial_menu(user, anchor, displayed, radius = 36, require_near = TRUE)
	return original[selected]
