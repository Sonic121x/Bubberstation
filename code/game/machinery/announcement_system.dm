GLOBAL_LIST_EMPTY(announcement_systems)

/obj/machinery/announcement_system
	density = TRUE
	name = "\improper 自动公告系统"
	desc = "通过无线电发布日常公告的自动公告系统。"
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "AAS_On"
	base_icon_state = "AAS"

	verb_say = "冷淡地陈述"
	verb_ask = "询问"
	verb_exclaim = "发出警报"

	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.05

	circuit = /obj/item/circuitboard/machine/announcement_system

	///All possible announcements and their local configurations
	var/list/datum/aas_config_entry/config_entries = list()

	///The headset that we use for broadcasting
	var/obj/item/radio/headset/radio
	///AIs headset support all stations channels, but it may require an override for away site or syndie AASs.
	var/radio_type = /obj/item/radio/headset/silicon/ai

	var/greenlight = "Light_Green"
	var/pinklight = "Light_Pink"
	var/errorlight = "Error_Red"

/obj/machinery/announcement_system/Initialize(mapload)
	config_entries = init_subtypes(/datum/aas_config_entry, list())
	. = ..()
	radio = new radio_type(src)
	GLOB.announcement_systems += src
	update_appearance()

/obj/machinery/announcement_system/randomize_language_if_on_station()
	return

/obj/machinery/announcement_system/update_icon_state()
	icon_state = "[base_icon_state]_[is_operational && !(machine_stat & EMPED) ? "On" : "Off"][panel_open ? "_Open" : null]"
	return ..()

/obj/machinery/announcement_system/update_overlays()
	. = ..()
	var/datum/aas_config_entry/entry = locate(/datum/aas_config_entry/arrival) in config_entries
	if(entry && entry.enabled)
		. += greenlight

	entry = locate(/datum/aas_config_entry/newhead) in config_entries
	if(entry && entry.enabled)
		. += pinklight

	if(machine_stat & EMPED)
		. += errorlight

/obj/machinery/announcement_system/Destroy()
	QDEL_NULL(radio)
	QDEL_LAZYLIST(config_entries)
	GLOB.announcement_systems -= src //"OH GOD WHY ARE THERE 100,000 LISTED ANNOUNCEMENT SYSTEMS?!!"
	return ..()

/obj/machinery/announcement_system/screwdriver_act(mob/living/user, obj/item/tool)
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/announcement_system/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(user, tool)

/obj/machinery/announcement_system/multitool_act(mob/living/user, obj/item/tool)
	if(!panel_open || !(machine_stat & EMPED))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你重置了[src]的固件。"))
	set_machine_stat(machine_stat & ~EMPED)
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/// Does funny breakage stuff
/obj/machinery/announcement_system/proc/act_up()
	if (machine_stat & EMPED)
		return
	set_machine_stat(machine_stat | EMPED)
	update_appearance()
	for (var/datum/aas_config_entry/config in config_entries)
		config.act_up()

/obj/machinery/announcement_system/emp_act(severity)
	. = ..()
	if(!(machine_stat & (NOPOWER|EMPED|BROKEN)) && !(. & EMP_PROTECT_SELF))
		act_up()

/obj/machinery/announcement_system/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	act_up()
	balloon_alert(user, "公告文本已损坏")
	return TRUE

/obj/machinery/announcement_system/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AutomatedAnnouncement")
		ui.open()

/obj/machinery/announcement_system/ui_data()
	var/list/configs = list()
	for(var/datum/aas_config_entry/config in config_entries)
		configs += list(list(
			name = config.name,
			entryRef = REF(config),
			enabled = config.enabled,
			modifiable = config.modifiable,
			announcementLinesMap = config.announcement_lines_map,
			generalTooltip = config.general_tooltip,
			varsAndTooltipsMap = config.vars_and_tooltips_map
		))
	return list("config_entries" = configs)

/obj/machinery/announcement_system/ui_static_data(mob/user)
	var/list/data = list()

	data["max_announcement_len"] = MAX_AAS_LENGTH

	return data

/obj/machinery/announcement_system/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(!usr.can_perform_action(src, ALLOW_SILICON_REACH))
		return
	if(machine_stat & EMPED)
		visible_message(span_warning("[src]嗡嗡作响。"), span_hear("你听见一声微弱的嗡鸣。"))
		playsound(src.loc, 'sound/machines/buzz/buzz-two.ogg', 50, TRUE)
		return

	add_fingerprint(usr)
	var/datum/aas_config_entry/config = locate(params["entryRef"]) in config_entries
	if(!config || !config.modifiable)
		return

	switch(action)
		if("Toggle")
			config.enabled = !config.enabled
			if (config.type in list(/datum/aas_config_entry/arrival, /datum/aas_config_entry/newhead))
				update_appearance()
		if("Text")
			if(!(params["lineKey"] in config.announcement_lines_map))
				message_admins("[ADMIN_LOOKUPFLW(usr)]试图设置自动公告系统的[config.name]中不存在的公告行，可能是 href 注入。收到的行：[html_encode(params["lineKey"])]")
				log_game("[key_name(usr)] tried to mess with AAS. For [config.name] he tried to edit nonexistend [params["lineKey"]]")
				return
			var/new_message = trim(html_encode(params["newText"]), MAX_AAS_LENGTH)
			if(new_message)
				config.announcement_lines_map[params["lineKey"]] = new_message
				usr.log_message("updated [params["lineKey"]] line in the [config.name] to: [new_message]", LOG_GAME)

/obj/machinery/announcement_system/can_interact(mob/user)
	. = ..()
	if (!.)
		return

	if (machine_stat & EMPED)
		to_chat(user, span_warning("[src]的固件似乎出现了故障！"))
		if (!isAI(user))	// Deus Ex Machina goes without multitool in his default complectation.
			to_chat(user, span_warning("不过，你可以在[EXAMINE_HINT("打开面板")]后，用[EXAMINE_HINT("多功能工具")]重置它！"))
		return FALSE

/// If AAS can't broadcast message, it shouldn't be picked by randomizer.
/obj/machinery/announcement_system/proc/has_supported_channels(list/channels)
	if (!LAZYLEN(channels) || (RADIO_CHANNEL_COMMON in channels))
		// Okay, I am not proud of this, but I don't want CentCom or Syndie AASs to broadcast on Common.
		// Because our overrides can just change radio withour creating new subtype we prefer to check both.
		return src.type == /obj/machinery/announcement_system && src.radio_type == /obj/machinery/announcement_system::radio_type
	for(var/channel in channels)
		if(radio.channels[channel])
			return TRUE
	return FALSE

/// Can AAS receive request for broadcast from you? Null source means yes.
/obj/machinery/announcement_system/proc/can_be_reached_from(atom/source)
	if(!source || !istype(source))
		return TRUE
	var/turf/source_turf = get_turf(source)
	if (!source_turf)
		return TRUE
	// Keep updated with broadcasting.dm (/datum/signal/subspace/vocal/New)
	// FFF (For Future Feature): think about adding radio relay support. Maybe implementing /datum/signal/subspace/aas_event or something similar.
	return z in SSmapping.get_connected_levels(source_turf)

/// Compiles the announcement message with the provided variables. Announcement line is optional.
/obj/machinery/announcement_system/proc/compile_config_message(aas_config_entry_type, list/variables_map, announcement_line, fail_if_disabled=FALSE)
	var/datum/aas_config_entry/config = locate(aas_config_entry_type) in config_entries
	if (!config || (fail_if_disabled && !config.enabled))
		return
	return config.compile_announce(variables_map, announcement_line)

/// Sends a message to the appropriate channels.
/obj/machinery/announcement_system/proc/broadcast(message, list/channels, command_span = FALSE)
	use_energy(active_power_usage)
	if(!LAZYLEN(channels))
		radio.talk_into(src, message, null, command_span ? list(speech_span, SPAN_COMMAND) : null)
		return

	// For some reasons, radio can't recognize RADIO_CHANNEL_COMMON in channels, so we need to handle it separately.
	if (RADIO_CHANNEL_COMMON in channels)
		radio.talk_into(src, message, null, command_span ? list(speech_span, SPAN_COMMAND) : null)
		channels -= RADIO_CHANNEL_COMMON
	for(var/channel in channels)
		radio.talk_into(src, message, channel, command_span ? list(speech_span, SPAN_COMMAND) : null)

/// Announces configs entry message with the provided variables. Channels, announcement_line and command_span are optional.
/obj/machinery/announcement_system/proc/announce(aas_config_entry_type, list/variables_map, list/channels, announcement_line, command_span)
	var/msg = compile_config_message(aas_config_entry_type, variables_map, announcement_line, TRUE)
	if (msg)
		broadcast(msg, channels, command_span)

/// Returns a random announcement system that is operational, has the specified config entry, signal can reach source and radio supports any channel in list. All args are optional.
/proc/get_announcement_system(aas_config_entry_type, source, list/channels)
	if (!GLOB.announcement_systems.len)
		return null
	var/list/intact_aass = list()
	for(var/obj/machinery/announcement_system/announce as anything in GLOB.announcement_systems)
		if(!QDELETED(announce) && announce.is_operational && announce.has_supported_channels(channels) && announce.can_be_reached_from(source))
			if(aas_config_entry_type)
				var/datum/aas_config_entry/entry = locate(aas_config_entry_type) in announce.config_entries
				if(!entry || !entry.enabled)
					continue
			intact_aass += announce
	return intact_aass.len ? pick(intact_aass) : null

/// Announces the provided message with the provided variables and config entry type. Only aas_config_entry_type and variables_map are mandatory. Other args are optional.
/proc/aas_config_announce(aas_config_entry_type, list/variables_map, source, list/channels, announcement_line, command_span)
	var/obj/machinery/announcement_system/announcer = get_announcement_system(aas_config_entry_type, source, channels)
	if (!announcer)
		return
	announcer.announce(aas_config_entry_type, variables_map, channels, announcement_line, command_span)

/datum/aas_config_entry
	var/name = "自动公告系统配置项"
	// Should we broadcast this announcement?
	var/enabled = TRUE
	// The announcement message. Key will be displayed in the UI.
	var/list/announcement_lines_map = list("Message" = "这是一条默认公告。")
	// Goes before tooltips for vars, mainly used if announcement has no replacable vars
	var/general_tooltip
	// Contains all replacable vars and their tooltips
	var/list/vars_and_tooltips_map = list()
	// Can be changed or disabled by players
	var/modifiable = TRUE

/// Compiles the announcement message with the provided variables. Announcement line is optional, may be both index or line key.
/datum/aas_config_entry/proc/compile_announce(list/variables_map, announcement_line)
	var/announcement_message = LAZYACCESS(announcement_lines_map, announcement_line)
	// If index was provided LAZYACCESS will return us a key, not value
	if (isnum(announcement_line))
		announcement_message = announcement_lines_map[announcement_message]
	// Fallback - first line
	if (!announcement_message)
		announcement_message = announcement_lines_map[announcement_lines_map[1]]
	// Replace variables with their value
	for(var/variable in vars_and_tooltips_map)
		announcement_message = replacetext_char(announcement_message, "%[variable]", variables_map[variable] || "\[无数据\]")
	return announcement_message

/// Called when the announcement system is emagged or EMPed.
/datum/aas_config_entry/proc/act_up()
	SHOULD_CALL_PARENT(TRUE)

	// Please do not mess with entries, that players can't fix.
	if(!modifiable)
		return TRUE
	return FALSE

/*
	Global config entries for the announcement system.
*/

/datum/aas_config_entry/arrival
	name = "全站：到站公告"
	announcement_lines_map = list(
		"Message" = "%PERSON已报到，担任%RANK。")
	vars_and_tooltips_map = list(
		"PERSON" = "将替换为其姓名。",
		"RANK" = "将替换为其职位。"
	)

/datum/aas_config_entry/arrival/act_up()
	. = ..()
	if (.)
		return

	announcement_lines_map["Message"] = pick("#!@%错误-34%2 无法定@#职#文*件！",
		"严重错误 99。",
		"错)误#：未找*到数#据@#库！")

/datum/aas_config_entry/newhead
	name = "部门：主管公告"
	announcement_lines_map = list(
		"Message" = "%RANK %PERSON是本部门主管。")
	vars_and_tooltips_map = list(
		"PERSON" = "将替换为其姓名。",
		"RANK" = "将替换为其职位。"
	)

/datum/aas_config_entry/newhead/act_up()
	. = ..()
	if (.)
		return

	announcement_lines_map["Message"] = pick("过#载()：检*#测)到\[未知？？\]！",
		"错)#误 - 发*现@损*坏文本！",
		"AAS.exe 未响应。NanoOS 正在查找解决方案。")

/datum/aas_config_entry/researched_node
	name = "科研提示：研究节点公告"
	announcement_lines_map = list(
		"Message" = "科技网节点%NODE已研究完成。")
	vars_and_tooltips_map = list(
		"NODE" = "将替换为已研究的节点。"
	)

/datum/aas_config_entry/researched_node/act_up()
	. = ..()
	if (.)
		return

	announcement_lines_map["Message"] = pick(
		replacetext(/datum/aas_config_entry/researched_node::announcement_lines_map["Message"], "%NODE", /datum/techweb_node/mech_clown::display_name),
		"运/行错1误 A= ANNOUN-*#nt_SY!?EM.dm，第%£86行：节=0点为空！",
		"BEPIS BEPIS BEPIS",
		"错)#误 - 发*现@损*坏文本！")

/datum/aas_config_entry/arrivals_broken
	name = "工程提示：到站穿梭机故障公告"
	announcement_lines_map = list(
		"Message" = "到站穿梭机受损。正在停靠维修……")
	general_tooltip = "到站穿梭机停靠维修时广播。没有可替换变量。"
	modifiable = FALSE

/datum/aas_config_entry/announce_officer
	name = "安保提示：安保员到站公告"
	announcement_lines_map = list(
		"Message" = "安保员%OFFICER已被分配至%DEPARTMENT。")
	vars_and_tooltips_map = list(
		"OFFICER" = "将替换为安保员的姓名。",
		"DEPARTMENT" = "将替换为其分配到的部门。"
	)
	modifiable = FALSE
