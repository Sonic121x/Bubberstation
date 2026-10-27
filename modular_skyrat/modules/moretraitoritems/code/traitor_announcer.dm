#define INFINITE_CHARGES -1

/obj/item/traitor_announcer
	name = "古怪的装置"
	desc = "嗯……这是做什么用的？"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "一个遥控器，可发送由你自行编写的虚假公告。"
	icon = 'icons/obj/devices/scanner.dmi'
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	icon_state = "inspector"
	worn_icon_state = "salestagger"
	inhand_icon_state = "electronic"
	///How many uses does it have? -1 for infinite
	var/uses = 1

/proc/try_user_announce(mob/living/user, list/available_sounds = GLOB.announcer_keys)
	//build our announcement
	var/origin = reject_bad_text(tgui_input_text(user, "公告由谁发布，或来自哪里？", "公告来源", chinese_area_display(get_area_name(user)), max_length = 28))
	if(!origin)
		user.balloon_alert(user, "来源无效！")
		return FALSE
	var/audio_key = chinese_skyrat_item_choice(user, "要播放哪种公告音频？（默认为“截获通讯”）", "公告音频", available_sounds, ANNOUNCER_INTERCEPT)
	if(!audio_key)
		user.balloon_alert(user, "音频无效！")
		return FALSE
	var/color = chinese_skyrat_item_choice(user, "公告使用什么颜色？", "公告颜色", ANNOUNCEMENT_COLORS, "default")
	if(!color)
		user.balloon_alert(user, "颜色无效！")
		return FALSE
	var/title = reject_bad_text(tgui_input_text(user, "请输入公告标题。", "公告标题", max_length = 42))
	if(!title)
		user.balloon_alert(user, "标题无效！")
		return FALSE
	var/input = reject_bad_text(tgui_input_text(user, "请输入公告正文。", "公告正文", max_length = 512, multiline = TRUE))
	if(!input)
		user.balloon_alert(user, "正文无效！")
		return FALSE
	//treat voice
	var/list/message_data = user.treat_message(input)
	//send
	priority_announce(
		text = message_data["message"],
		title = title,
		sound = audio_key,
		has_important_message = TRUE,
		sender_override = origin,
		color_override = color,
		encode_text = FALSE,
		encode_title = FALSE
	)

	deadchat_broadcast("从[span_name("[chinese_area_display(get_area_name(usr, TRUE))]")]发布了一则虚假优先公告。", span_name("[user.real_name]"), user, message_type=DEADCHAT_ANNOUNCEMENT)
	user.log_talk("\[公告标题\]：[title]，\[正文\]：[input]，\[音频键\]：[audio_key]", LOG_TELECOMMS, tag = "priority announcement")
	message_admins("[ADMIN_LOOKUPFLW(user)]发布了虚假公告：[input]。")

	return TRUE

/obj/item/traitor_announcer/attack_self(mob/living/user, modifiers)
	. = ..()
	//can we use this?
	if(!isliving(user) || (uses == 0))
		user.balloon_alert(user, "使用次数已耗尽！")
		return

	var/result = try_user_announce(user)
	if(result)
		if(uses != INFINITE_CHARGES)
			uses--

// Adminbus
/obj/item/traitor_announcer/infinite
	uses = -1

#undef INFINITE_CHARGES
