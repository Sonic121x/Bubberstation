/// BYOND timestamp corresponding to deadline (Jun. 16, 2025)
#define DEADLINE_TIMESTAMP 8033472000

/mob/dead/new_player
	/// Title screen is ready to receive signals
	var/title_screen_is_ready = FALSE
	/// Whether the player (if unvetted) has acknowledged the deadline warning
	var/unvetted_notified = FALSE

/**
 * Check player vetting status and if necessary warn about upcoming deadline
 *
 * Returns FALSE if unvetted and deadline has passed, TRUE otherwise
 */
/mob/dead/new_player/proc/trigger_unvetted_warning()
	if(!CONFIG_GET(flag/check_vetted))
		unvetted_notified = TRUE
		return TRUE
	if(!SSplayer_ranks.initialized)
		return TRUE
	if(SSplayer_ranks.is_vetted(client, admin_bypass = FALSE))
		unvetted_notified = TRUE
		return TRUE

	// Time's up
	if(DEADLINE_TIMESTAMP - world.realtime <= 0)
		tgui_alert(
			src,
			"未通过审核的玩家已无法加入或旁观回合，请前往Discord的#get-vetted频道提交审核申请。",
			"你尚未通过审核！",
			timeout = 10 SECONDS,
		)
		return FALSE

	var/remaining_time = round((DEADLINE_TIMESTAMP - world.realtime) / (1 DAYS), 1)
	tgui_deadline_alert(
		src,
		"未通过审核的玩家将在[remaining_time]天后无法加入或旁观回合！",
		"请在[time2text(DEADLINE_TIMESTAMP, "YYYY-MM-DD")]之前通过审核！",
		days_remaining = remaining_time,
		timeout = 10 SECONDS,
	)
	unvetted_notified = TRUE
	return TRUE

/mob/dead/new_player/Topic(href, href_list)
	if(src != usr)
		return

	if(!client)
		return

	if(client.interviewee)
		return FALSE

	if(href_list["observe"])
		play_lobby_button_sound()
		if(!unvetted_notified && !trigger_unvetted_warning())
			return FALSE
		make_me_an_observer()
		return

	if(href_list["job_traits"])
		play_lobby_button_sound()
		if(!unvetted_notified && !trigger_unvetted_warning())
			return FALSE
		show_job_traits()
		return

	if(href_list["server_swap"])
		play_lobby_button_sound()
		server_swap()
		return

	if(href_list["view_manifest"])
		play_lobby_button_sound()
		ViewManifest()
		return

	if(href_list["character_directory"])
		play_lobby_button_sound()
		client.show_character_directory()
		return

	if(href_list["toggle_antag"])
		play_lobby_button_sound()
		var/datum/preferences/preferences = client.prefs
		preferences.write_preference(GLOB.preference_entries[/datum/preference/toggle/be_antag], !preferences.read_preference(/datum/preference/toggle/be_antag))
		client << output(preferences.read_preference(/datum/preference/toggle/be_antag), "title_browser:toggle_antag")
		return

	if(href_list["character_setup"])
		play_lobby_button_sound()
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_CHARACTER_PREFERENCES
		preferences.update_static_data(src)
		preferences.ui_interact(src)
		return

	if(href_list["game_options"])
		play_lobby_button_sound()
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_GAME_PREFERENCES
		preferences.update_static_data(usr)
		preferences.ui_interact(usr)
		return

	if(href_list["toggle_ready"])
		play_lobby_button_sound()
		// Prevent readying up after the round has begun setting up or is already playing
		if(SSticker.current_state >= GAME_STATE_SETTING_UP)
			to_chat(src, span_notice("回合正在开始，此时无法准备。"))
			return FALSE
		if(CONFIG_GET(flag/min_flavor_text))
			var/datum/preferences/preferences = client.prefs
			var/uses_silicon_flavortext = (is_silicon_job(preferences?.get_highest_priority_job()) && length_char(client?.prefs?.read_preference(/datum/preference/text/silicon_flavor_text)) < CONFIG_GET(number/silicon_flavor_text_character_requirement))
			var/uses_normal_flavortext = (!is_silicon_job(preferences?.get_highest_priority_job()) && length_char(client?.prefs?.read_preference(/datum/preference/text/flavor_text)) < CONFIG_GET(number/flavor_text_character_requirement))
			if(uses_silicon_flavortext)
				to_chat(src, span_notice("硅基角色外貌描述至少需要[CONFIG_GET(number/silicon_flavor_text_character_requirement)]个字符才能准备加入本局。你目前填写了[length_char(client.prefs.read_preference(/datum/preference/text/silicon_flavor_text))]个字符。"))
				return
			if(uses_normal_flavortext)
				to_chat(src, span_notice("角色外貌描述至少需要[CONFIG_GET(number/flavor_text_character_requirement)]个字符才能准备加入本局。你目前填写了[length_char(client.prefs.read_preference(/datum/preference/text/flavor_text))]个字符。"))
				return

		if(!unvetted_notified && !trigger_unvetted_warning())
			return FALSE
		ready = is_ready_to_play() ? PLAYER_NOT_READY : PLAYER_READY_TO_PLAY
		client << output(ready, "title_browser:toggle_ready")
		return

	if(href_list["late_join"])
		play_lobby_button_sound()
		if(!unvetted_notified && !trigger_unvetted_warning())
			return FALSE
		GLOB.latejoin_menu.ui_interact(usr)
		return

	if(href_list["title_is_ready"])
		title_screen_is_ready = TRUE
		return

	if(href_list["polls_menu"])
		play_lobby_button_sound()
		handle_player_polling()
		return

	. = ..()

/mob/dead/new_player/Login()
	. = ..()
	show_title_screen()

/**
 * Shows the titlescreen to a new player.
 */
/mob/dead/new_player/proc/show_title_screen()
	if (client?.interviewee)
		return

	winset(src, "title_browser", "is-disabled=false;is-visible=true")
	winset(src, "status_bar", "is-visible=false")

	var/datum/asset/assets = get_asset_datum(/datum/asset/simple/lobby) //Sending pictures to the client
	assets.send(src)

	update_title_screen()

/**
 * Hard updates the title screen HTML, it causes visual glitches if used.
 */
/mob/dead/new_player/proc/update_title_screen()
	var/dat = get_title_html()

	src << browse(SStitle.current_title_screen, "file=loading_screen.gif;display=0")
	src << browse(dat, "window=title_browser")

/datum/asset/simple/lobby
	assets = list(
		"FixedsysExcelsior3.01Regular.ttf" = 'html/browser/FixedsysExcelsior3.01Regular.ttf',
	)

/**
 * Removes the titlescreen entirely from a mob.
 */
/mob/dead/new_player/proc/hide_title_screen()
	if(client?.mob)
		winset(client, "title_browser", "is-disabled=true;is-visible=false")
		winset(client, "status_bar", "is-visible=true")

/mob/dead/new_player/proc/play_lobby_button_sound()
	SEND_SOUND(src, sound('modular_skyrat/master_files/sound/effects/save.ogg'))

/**
 * Allows the player to select a server to join from any loaded servers.
 */
/mob/dead/new_player/proc/server_swap()
	var/list/servers = CONFIG_GET(keyed_list/cross_server)
	if(LAZYLEN(servers) == 1)
		var/server_name = servers[1]
		var/server_ip = servers[server_name]
		var/confirm = tgui_alert(src, "确定要切换至[server_name]（[server_ip]）吗？", "切换服务器", list("连接过去！", "留在这里"))
		if(confirm == "连接过去！")
			to_chat_immediate(src, "再见，太空人。")
			client << link(server_ip)
		return
	var/server_name = tgui_input_list(src, "请选择要切换到的服务器：", "切换服务器", servers)
	if(!server_name)
		return
	var/server_ip = servers[server_name]
	var/confirm = tgui_alert(src, "确定要切换至[server_name]（[server_ip]）吗？", "切换服务器", list("连接过去！", "留在这里！"))
	if(confirm == "连接过去！")
		to_chat_immediate(src, "再见，太空人。")
		src.client << link(server_ip)

/**
 * Shows currently available job traits
 */
/mob/dead/new_player/proc/show_job_traits()
	if (!client || client.interviewee)
		return
	if(!length(GLOB.lobby_station_traits))
		to_chat(src, span_warning("目前没有可用的职业特性！"))
		return
	var/list/available_lobby_station_traits = list()
	for (var/datum/station_trait/trait as anything in GLOB.lobby_station_traits)
		if (!trait.can_display_lobby_button(client))
			continue
		available_lobby_station_traits += trait

	if(!LAZYLEN(available_lobby_station_traits))
		to_chat(src, span_warning("目前没有可用的职业特性！"))
		return

	var/datum/station_trait/clicked_trait = chinese_batch_ten_station_trait_choice(src, "选择要报名的职业特性：", "职业特性", available_lobby_station_traits)

	if(!clicked_trait)
		return

	clicked_trait.on_lobby_button_click(src)

/**
 * Shows the player a list of current polls, if any.
 */
/mob/dead/new_player/proc/playerpolls()
	if(!usr || !client)
		return

	var/output
	if (!SSdbcore.Connect())
		return
	var/isadmin = FALSE
	if(client?.holder)
		isadmin = TRUE
	var/datum/db_query/query_get_new_polls = SSdbcore.NewQuery({"
		SELECT id FROM [format_table_name("poll_question")]
		WHERE (adminonly = 0 OR :isadmin = 1)
		AND Now() BETWEEN starttime AND endtime
		AND deleted = 0
		AND id NOT IN (
			SELECT pollid FROM [format_table_name("poll_vote")]
			WHERE ckey = :ckey
			AND deleted = 0
		)
		AND id NOT IN (
			SELECT pollid FROM [format_table_name("poll_textreply")]
			WHERE ckey = :ckey
			AND deleted = 0
		)
	"}, list("isadmin" = isadmin, "ckey" = ckey))

	if(!query_get_new_polls.Execute())
		qdel(query_get_new_polls)
		return
	if(query_get_new_polls.NextRow())
		output +={"<a class="menu_button menu_newpoll" href='byond://?src=[text_ref(src)];polls_menu=1'>投票（新）</a>"}
	else
		output +={"<a class="menu_button" href='byond://?src=[text_ref(src)];polls_menu=1'>投票</a>"}
	qdel(query_get_new_polls)
	if(QDELETED(src))
		return
	return output

#undef DEADLINE_TIMESTAMP
