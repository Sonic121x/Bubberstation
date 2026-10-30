// Used for translating channels to tokens on examination
GLOBAL_LIST_INIT(channel_tokens, list(
	RADIO_CHANNEL_COMMON = RADIO_KEY_COMMON,
	RADIO_CHANNEL_SCIENCE = RADIO_TOKEN_SCIENCE,
	RADIO_CHANNEL_COMMAND = RADIO_TOKEN_COMMAND,
	RADIO_CHANNEL_MEDICAL = RADIO_TOKEN_MEDICAL,
	RADIO_CHANNEL_ENGINEERING = RADIO_TOKEN_ENGINEERING,
	RADIO_CHANNEL_SECURITY = RADIO_TOKEN_SECURITY,
	RADIO_CHANNEL_CENTCOM = RADIO_TOKEN_CENTCOM,
	RADIO_CHANNEL_FACTION = RADIO_TOKEN_FACTION, //SKYRAT EDIT ADDITION - Faction
	RADIO_CHANNEL_CYBERSUN = RADIO_TOKEN_CYBERSUN, //SKYRAT EDIT ADDITION - Mapping
	RADIO_CHANNEL_INTERDYNE = RADIO_TOKEN_INTERDYNE, //SKYRAT EDIT ADDITION - Mapping
	RADIO_CHANNEL_GUILD = RADIO_TOKEN_GUILD, //SKYRAT EDIT ADDITION - Mapping
	RADIO_CHANNEL_TARKON = RADIO_TOKEN_TARKON, //SKYRAT EDIT ADDITION - MAPPING
	RADIO_CHANNEL_TERRAGOV = RADIO_TOKEN_TERRAGOV, //SKYRAT EDIT ADDITION - TERRAGOV
	RADIO_CHANNEL_SYNDICATE = RADIO_TOKEN_SYNDICATE,
	RADIO_CHANNEL_SUPPLY = RADIO_TOKEN_SUPPLY,
	RADIO_CHANNEL_SERVICE = RADIO_TOKEN_SERVICE,
	MODE_BINARY = MODE_TOKEN_BINARY,
	RADIO_CHANNEL_AI_PRIVATE = RADIO_TOKEN_AI_PRIVATE,
	RADIO_CHANNEL_ENTERTAINMENT = RADIO_TOKEN_ENTERTAINMENT,
))

/obj/item/radio/headset
	name = "无线电耳机"
	desc = "可戴在头上的新式模块化对讲机。支持安装加密密钥。"
	icon = 'icons/obj/clothing/headsets.dmi'
	icon_state = "headset"
	inhand_icon_state = "headset"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	worn_icon_state = "headset"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT * 0.75)
	subspace_transmission = TRUE
	canhear_range = 0 // can't hear headsets from very far away
	interaction_flags_mouse_drop = FORBID_TELEKINESIS_REACH
	slot_flags = ITEM_SLOT_EARS
	dog_fashion = null
	equip_sound = SFX_HEADSET_EQUIP
	pickup_sound = SFX_HEADSET_PICKUP
	drop_sound = 'sound/items/handling/headset/headset_drop1.ogg'
	sound_vary = TRUE
	var/obj/item/encryptionkey/keyslot2 = null

	// headset is too small to display overlays
	overlay_speaker_idle = null
	overlay_mic_idle = null
	overlay_mic_active = null

/obj/item/radio/headset/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始把[src]的天线往自己鼻子里塞！看起来[user.p_they()]想让自己得癌症！"))
	return TOXLOSS

/obj/item/radio/headset/examine(mob/user)
	. = ..()

	if(!(item_flags & IN_INVENTORY) || loc != user)
		. += span_notice("耳机上的小屏幕闪烁着，但太小了，必须拿在手里或戴上才能看清。")
		return

	// construction of frequency description
	var/list/available_channels = list()
	available_channels += "<li><b>[span_radio(RADIO_KEY_COMMON)]</b>：当前调谐频率</li>"
	if(special_channels & RADIO_SPECIAL_BINARY)
		available_channels += "<li><b>[span_binarysay(MODE_TOKEN_BINARY)]：[span_binarysay(chinese_radio_channel_display(capitalize(MODE_BINARY)))]</b></li>" // BUBBER EDIT: Chinese channel display

	for(var/i in 1 to length(channels))
		var/channel_name = channels[i]
		var/channel_token = GLOB.channel_tokens[channel_name]
		var/channel_span_class = get_radio_span(GLOB.default_radio_channels[channel_name])

		if(i == 1)
			available_channels += "<li><b>[span_class(channel_span_class, MODE_TOKEN_DEPARTMENT)]</b>或<b>[span_class(channel_span_class, channel_token)]</b>：<b>[span_class(channel_span_class, chinese_radio_channel_display(channel_name))]</b></li>" // BUBBER EDIT: Chinese channel display
		else
			available_channels += "<li><b>[span_class(channel_span_class, channel_token)]</b>：<b>[span_class(channel_span_class, chinese_radio_channel_display(channel_name))]</b></li>" // BUBBER EDIT: Chinese channel display

	. += span_notice("耳机上的小屏幕显示了以下可用频率：")
	. += span_notice("<ul style='display:inline-block; margin: 0; list-style: square;'>[available_channels.Join()]</ul>")

	if(command)
		. += span_info("<b>按住Alt点击</b>可切换高音量模式。")

/obj/item/radio/headset/Initialize(mapload)
	. = ..()
	if(ispath(keyslot2))
		keyslot2 = new keyslot2(src)
	set_listening(TRUE)
	set_broadcasting(TRUE)
	recalculateChannels()
	possibly_deactivate_in_loc()

/obj/item/radio/headset/proc/possibly_deactivate_in_loc()
	if(ismob(loc))
		set_listening(should_be_listening)
	else
		set_listening(FALSE, actual_setting = FALSE)

/obj/item/radio/headset/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	possibly_deactivate_in_loc()

/obj/item/radio/headset/Destroy()
	if(istype(keyslot2))
		QDEL_NULL(keyslot2)
	return ..()

/obj/item/radio/headset/ui_data(mob/user)
	. = ..()
	.["headset"] = TRUE

/obj/item/radio/headset/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	if(user == over)
		return attack_self(user)

/// Grants all the languages this headset allows the mob to understand via installed chips.
/obj/item/radio/headset/proc/grant_headset_languages(mob/grant_to)
	var/list/language_list = keyslot?.language_data?.Copy()

	if(keyslot2)
		if(length(language_list))
			for(var/language in keyslot2.language_data)
				if(language_list[language] < keyslot2.language_data[language])
					language_list[language] = keyslot2.language_data[language]
					continue
				language_list[language] = keyslot2.language_data[language]

		else
			language_list = keyslot2.language_data?.Copy()

	for(var/language in language_list)
		var/amount_understood = language_list[language]
		if(amount_understood >= 100)
			grant_to.grant_language(language, language_flags = UNDERSTOOD_LANGUAGE, source = LANGUAGE_RADIOKEY)
		else
			grant_to.grant_partial_language(language, amount = amount_understood, source = LANGUAGE_RADIOKEY)

/// Clears all radio related languages from the mob.
/obj/item/radio/headset/proc/remove_headset_languages(mob/remove_from)
	if(QDELETED(remove_from)) //This can be called as a part of destroy
		return
	remove_from.remove_all_languages(source = LANGUAGE_RADIOKEY)
	remove_from.remove_all_partial_languages(source = LANGUAGE_RADIOKEY)

/obj/item/radio/headset/equipped(mob/user, slot, initial)
	. = ..()
	if(!(slot_flags & slot))
		return

	grant_headset_languages(user)

/obj/item/radio/headset/dropped(mob/user, silent)
	. = ..()
	remove_headset_languages(user)

// Headsets do not become hearing sensitive as broadcasting instead controls their talk_into capabilities
/obj/item/radio/headset/set_broadcasting(new_broadcasting, actual_setting = TRUE)
	broadcasting = new_broadcasting
	if(actual_setting)
		should_be_broadcasting = broadcasting

	if (perform_update_icon && !isnull(overlay_mic_idle))
		update_icon()
	else if (!perform_update_icon)
		should_update_icon = TRUE

/obj/item/radio/headset/talk_into_impl(atom/movable/talking_movable, message, channel, list/spans, datum/language/language, list/message_mods)
	if (!broadcasting)
		return
	return ..()

/obj/item/radio/headset/syndicate //disguised to look like a normal headset for stealth ops

/obj/item/radio/headset/syndicate/Initialize(mapload)
	. = ..()
	make_syndie()

/obj/item/radio/headset/syndicate/alt //undisguised bowman with flash protection
	name = "辛迪加耳机"
	desc = "能够收听所有无线电频率的辛迪加耳机。可保护耳朵免受闪光弹伤害。"
	icon_state = "syndie_headset"
	worn_icon_state = "syndie_headset"

/obj/item/radio/headset/syndicate/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)

/obj/item/radio/headset/syndicate/alt/leader
	name = "小队队长耳机"
	command = TRUE

/obj/item/radio/headset/binary
	keyslot = /obj/item/encryptionkey/binary

/obj/item/radio/headset/headset_sec
	name = "安保无线电耳机"
	desc = "精锐安保部队使用的耳机。"
	icon_state = "sec_headset"
	worn_icon_state = "sec_headset"
	keyslot = /obj/item/encryptionkey/headset_sec

/obj/item/radio/headset/headset_sec/alt
	name = "安保战术耳机"
	desc = "精锐安保部队使用的耳机。可保护耳朵免受闪光弹伤害。"
	icon_state = "sec_headset_alt"
	worn_icon_state = "sec_headset_alt"

/obj/item/radio/headset/headset_sec/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)

/obj/item/radio/headset/headset_eng
	name = "工程无线电耳机"
	desc = "供工程师们像小姑娘一样闲聊。"
	icon_state = "eng_headset"
	worn_icon_state = "eng_headset"
	keyslot = /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/headset_rob
	name = "机器人学无线电耳机"
	desc = "专为拿不准该归哪个部门的机器人专家设计。"
	icon_state = "rob_headset"
	worn_icon_state = "rob_headset"
	keyslot = /obj/item/encryptionkey/headset_rob

/obj/item/radio/headset/headset_med
	name = "医疗无线电耳机"
	desc = "供医疗部受训人员使用的耳机。"
	icon_state = "med_headset"
	worn_icon_state = "med_headset"
	keyslot = /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/headset_sci
	name = "科研无线电耳机"
	desc = "一副很有科学范儿的耳机。一如既往。"
	icon_state = "sci_headset"
	worn_icon_state = "sci_headset"
	keyslot = /obj/item/encryptionkey/headset_sci

/obj/item/radio/headset/headset_medsci
	name = "医学研究无线电耳机"
	desc = "医疗与科研相结合的产物。"
	icon_state = "medsci_headset"
	worn_icon_state = "medsci_headset"
	keyslot = /obj/item/encryptionkey/headset_medsci

/obj/item/radio/headset/headset_srvsec
	name = "法律与秩序耳机"
	desc = "在刑事司法耳机中，加密密钥代表两个独立且同样重要的群体：调查犯罪的安保部，以及提供服务的服务部。这就是他们的通讯频道。"
	icon_state = "srvsec_headset"
	worn_icon_state = "srvsec_headset"
	keyslot = /obj/item/encryptionkey/headset_srvsec

/obj/item/radio/headset/headset_srvmed
	name = "服务医疗耳机"
	desc = "可与医疗部和服务部通话的耳机。"
	icon_state = "srv_headset"
	worn_icon_state = "srv_headset"
	keyslot = /obj/item/encryptionkey/headset_srvmed

/obj/item/radio/headset/headset_srvent
	name = "新闻耳机"
	desc = "可与服务部通话，并向娱乐频道广播的耳机。"
	icon_state = "srvent_headset"
	worn_icon_state = "srv_headset"
	keyslot = /obj/item/encryptionkey/headset_srvent

/obj/item/radio/headset/headset_com
	name = "指挥无线电耳机"
	desc = "能够接入指挥频道的耳机。"
	icon_state = "com_headset"
	worn_icon_state = "com_headset"
	keyslot = /obj/item/encryptionkey/headset_com

/obj/item/radio/headset/heads
	command = TRUE
	icon_state = "com_headset"
	worn_icon_state = "com_headset"

/obj/item/radio/headset/heads/captain
	name = "\proper 舰长耳机"
	desc = "王者的耳机。"
	keyslot = /obj/item/encryptionkey/heads/captain

/obj/item/radio/headset/heads/captain/alt
	name = "\proper 舰长战术耳机"
	desc = "老大的耳机。可保护耳朵免受闪光弹伤害。"
	icon_state = "com_headset_alt"
	worn_icon_state = "com_headset_alt"

/obj/item/radio/headset/heads/captain/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)

/obj/item/radio/headset/heads/rd
	name = "\proper 科研主管耳机"
	desc = "推动社会迈向技术奇点之人的耳机。"
	keyslot = /obj/item/encryptionkey/heads/rd

/obj/item/radio/headset/heads/hos
	name = "\proper 安保主管耳机"
	desc = "负责维持秩序、保护空间站之人的耳机。"
	keyslot = /obj/item/encryptionkey/heads/hos

/obj/item/radio/headset/heads/hos/advisor
	name = "\proper 资深安保顾问耳机"
	desc = "曾负责维持秩序、保护空间站之人的耳机……"
	keyslot = /obj/item/encryptionkey/heads/hos
	command = FALSE

/obj/item/radio/headset/heads/hos/alt
	name = "\proper 安保主管战术耳机"
	desc = "负责维持秩序、保护空间站之人的耳机。可保护耳朵免受闪光弹伤害。"
	icon_state = "com_headset_alt"
	worn_icon_state = "com_headset_alt"

/obj/item/radio/headset/heads/hos/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)

/obj/item/radio/headset/heads/ce
	name = "\proper 总工程师耳机"
	desc = "负责保障空间站供电与设施完好之人的耳机。"
	keyslot = /obj/item/encryptionkey/heads/ce

/obj/item/radio/headset/heads/cmo
	name = "\proper 首席医疗官耳机"
	desc = "训练有素的医疗主管使用的耳机。"
	keyslot = /obj/item/encryptionkey/heads/cmo

/obj/item/radio/headset/heads/hop
	name = "\proper 人事主管耳机"
	desc = "总有一天会当上舰长之人的耳机。"
	keyslot = /obj/item/encryptionkey/heads/hop

/obj/item/radio/headset/heads/qm
	name = "\proper 货运主管耳机"
	desc = "货运部门负责人的耳机。"
	keyslot = /obj/item/encryptionkey/heads/qm

/obj/item/radio/headset/headset_cargo
	name = "货运无线电耳机"
	desc = "货运主管的苦力们使用的耳机。"
	icon_state = "cargo_headset"
	worn_icon_state = "cargo_headset"
	keyslot = /obj/item/encryptionkey/headset_cargo

/obj/item/radio/headset/headset_cargo/mining
	name = "采矿无线电耳机"
	desc = "矿工使用的耳机。带有采矿网络上行链路，可向同伴快速传达指令，并在低压环境下放大声音。"
	icon_state = "mine_headset"
	worn_icon_state = "mine_headset"
	// "puts the antenna down" while the headset is off
	overlay_speaker_idle = "headset_up"
	overlay_mic_idle = "headset_up"
	keyslot = /obj/item/encryptionkey/headset_mining

/obj/item/radio/headset/headset_cargo/mining/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/callouts, ITEM_SLOT_EARS, examine_text = span_info("按住Ctrl点击可开关呼叫功能。"), active = FALSE)

/obj/item/radio/headset/headset_cargo/mining/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_EARS)
		ADD_TRAIT(user, TRAIT_SPEECH_BOOSTER, CLOTHING_TRAIT)

/obj/item/radio/headset/headset_cargo/mining/dropped(mob/living/carbon/human/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_SPEECH_BOOSTER, CLOTHING_TRAIT)

/obj/item/radio/headset/headset_srv
	name = "服务无线电耳机"
	desc = "服务人员使用的耳机，他们负责让全站吃饱喝足、愉快整洁。"
	icon_state = "srv_headset"
	worn_icon_state = "srv_headset"
	keyslot = /obj/item/encryptionkey/headset_service

/obj/item/radio/headset/headset_cent
	name = "\improper 中央指挥部耳机"
	desc = "纳米传讯高层使用的耳机。"
	icon_state = "cent_headset"
	worn_icon_state = "cent_headset"
	keyslot = /obj/item/encryptionkey/headset_cent
	keyslot2 = /obj/item/encryptionkey/headset_com

/obj/item/radio/headset/headset_cent/empty
	keyslot = null
	keyslot2 = null

/obj/item/radio/headset/headset_cent/commander
	keyslot2 = /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/headset_cent/alt
	name = "\improper 中央指挥部战术耳机"
	desc = "专为紧急响应人员配备的耳机。可保护耳朵免受闪光弹伤害。"
	icon_state = "cent_headset_alt"
	worn_icon_state = "cent_headset_alt"
	keyslot2 = null

/obj/item/radio/headset/headset_cent/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)

/obj/item/radio/headset/headset_cent/alt/leader
	command = TRUE

/obj/item/radio/headset/silicon/pai
	name = "\proper 微型集成子空间收发器"
	subspace_transmission = FALSE

/obj/item/radio/headset/silicon/ai
	name = "\proper 集成子空间收发器"
	keyslot2 = new /obj/item/encryptionkey/ai
	command = TRUE

/obj/item/radio/headset/silicon/human_ai
	name = "\proper 断开的子空间收发器"
	desc = "据说有朝一日会被直接植入缸中之脑的耳机。"
	icon_state = "rob_headset"
	worn_icon_state = "rob_headset"
	keyslot2 = new /obj/item/encryptionkey/ai_with_binary
	command = TRUE

/obj/item/radio/headset/silicon/human_ai/equipped(mob/user, slot, initial)
	. = ..()
	ADD_TRAIT(user, TRAIT_LOUD_BINARY, REF(src))

/obj/item/radio/headset/silicon/human_ai/dropped(mob/user, slot, initial)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_LOUD_BINARY, REF(src))

/obj/item/radio/headset/silicon/ai/evil
	name = "\proper 邪恶集成子空间收发器"
	keyslot2 = new /obj/item/encryptionkey/ai/evil
	command = FALSE

/obj/item/radio/headset/silicon/ai/evil/Initialize(mapload)
	. = ..()
	make_syndie()

/obj/item/radio/headset/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == keyslot2)
		keyslot2 = null
		if(!QDELING(src))
			recalculateChannels()

/obj/item/radio/headset/remove_keys(mob/living/user)
	. = ..()
	if(!keyslot2)
		return

	. += keyslot2
	user.put_in_hands(keyslot2) // null via Exited

/obj/item/radio/headset/install_key(mob/living/user, obj/item/encryptionkey/key)
	if(!keyslot)
		return ..()

	if(keyslot2)
		loc.balloon_alert(user, "装不下第三把密钥！")
		return ITEM_INTERACT_BLOCKING

	if(!user.transferItemToLoc(key, src))
		loc.balloon_alert(user, "无法安装！")
		return ITEM_INTERACT_BLOCKING

	keyslot2 = key
	recalculateChannels()
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	loc.balloon_alert(user, "加密密钥已安装")
	return ITEM_INTERACT_SUCCESS

/obj/item/radio/headset/recalculateChannels()
	. = ..()
	if(keyslot2)
		for(var/channel_name in keyslot2.channels)
			if(!(channel_name in channels))
				channels[channel_name] = keyslot2.channels[channel_name]

		special_channels |= keyslot2.special_channels

		for(var/ch_name in channels)
			LAZYSET(secure_radio_connections, ch_name, add_radio(src, GLOB.default_radio_channels[ch_name]))

	// Updates radio languages entirely for the mob wearing the headset
	var/mob/mob_loc = loc
	if(istype(mob_loc) && mob_loc.get_item_by_slot(slot_flags) == src)
		remove_headset_languages(mob_loc)
		grant_headset_languages(mob_loc)

/obj/item/radio/headset/click_alt(mob/living/user)
	if(!istype(user) || !command)
		return CLICK_ACTION_BLOCKING
	use_command = !use_command
	to_chat(user, span_notice("你[use_command ? "开启" : "关闭"]了高音量模式。"))
	return CLICK_ACTION_SUCCESS
