/obj/item/ttsdevice
	name = "TTS 语音装置"
	desc = "一台带键盘的小型装置。在键盘上输入的任何内容都会从扬声器中播放出来。 \n<span class='notice'>按住 Ctrl 点击该装置可让它发出哔声。</span> \n<span class='notice'>按住 Ctrl+Shift 点击可为该装置命名。"
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "designator_mining"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = UNIQUE_RENAME

/obj/item/ttsdevice/attack_self(mob/user)
	user.balloon_alert_to_viewers("正在打字……", "开始打字……")
	playsound(src, 'modular_skyrat/master_files/sound/items/tts/started_type.ogg', 50, TRUE)
	var/str = tgui_input_text(user, "你想让装置说什么？", "朗读文本", "", MAX_MESSAGE_LEN, encode = FALSE)
	if(QDELETED(src) || !user.can_perform_action(src))
		return
	if(!str)
		user.balloon_alert_to_viewers("停止打字", "停止了打字")
		playsound(src, 'modular_skyrat/master_files/sound/items/tts/stopped_type.ogg', 50, TRUE)
		return

	chat_color_name = name
	chat_color = user.client?.prefs?.read_preference(/datum/preference/color/chat_color)
	if(chat_color)
		chat_color_darkened = process_chat_color(chat_color, sat_shift = 0.85, lum_shift = 0.85)

	say(str)
	str = null

/obj/item/ttsdevice/item_ctrl_click(mob/living/user)
	var/noisechoice = tgui_input_list(user, "你想发出什么声音？", "机器人音效", list("哔","嗡","叮"))
	if(noisechoice == "哔")
		user.audible_message("让 TTS 发出哔声！", audible_message_flags = EMOTE_MESSAGE)
		playsound(user, 'sound/machines/beep/twobeep.ogg', 50, 1, -1)
	if(noisechoice == "嗡")
		user.audible_message("让 TTS 发出嗡鸣！", audible_message_flags = EMOTE_MESSAGE)
		playsound(user, 'sound/machines/buzz/buzz-sigh.ogg', 50, 1, -1)
	if(noisechoice == "叮")
		user.audible_message("让 TTS 发出叮声！", audible_message_flags = EMOTE_MESSAGE)
		playsound(user, 'sound/machines/ping.ogg', 50, 1, -1)

/obj/item/ttsdevice/click_ctrl_shift(mob/living/user)
	var/new_name = reject_bad_name(tgui_input_text(user, "为你的 TTS 语音装置命名。这会影响它在聊天栏中的显示。", "设置 TTS 装置名称", "", MAX_NAME_LEN))
	if(new_name)
		name = "[new_name]的[initial(name)]"
	else
		name = initial(name)
