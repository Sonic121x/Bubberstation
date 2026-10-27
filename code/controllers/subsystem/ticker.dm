#define ROUND_START_MUSIC_LIST "strings/round_start_sounds.txt"
#define SS_TICKER_TRAIT "SS_Ticker"

SUBSYSTEM_DEF(ticker)
	name = "回合控制"
	priority = FIRE_PRIORITY_TICKER
	ss_flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	/// state of current round (used by process()) Use the defines GAME_STATE_* !
	var/current_state = GAME_STATE_STARTUP
	/// Boolean to track if round should be forcibly ended next ticker tick.
	/// Set by admin intervention ([ADMIN_FORCE_END_ROUND])
	/// or a "round-ending" event, like summoning Nar'Sie, a blob victory, the nuke going off, etc. ([FORCE_END_ROUND])
	var/force_ending = END_ROUND_AS_NORMAL
	/// If TRUE, there is no lobby phase, the game starts immediately.
	#ifdef AUTOSTART_GAME
	var/start_immediately = TRUE
	#else
	var/start_immediately = FALSE
	#endif
	/// Boolean to track and check if our subsystem setup is done.
	var/setup_done = FALSE

	var/login_music //music played in pregame lobby
	var/round_end_sound //music/jingle played when the world reboots
	var/round_end_sound_sent = TRUE //If all clients have loaded it

	var/list/datum/mind/minds = list() //The characters in the game. Used for objective tracking.

	var/delay_end = FALSE //if set true, the round will not restart on its own
	var/admin_delay_notice = "" //a message to display to anyone who tries to restart the world after a delay
	var/ready_for_reboot = FALSE //all roundend preparation done with, all that's left is reboot

	var/tipped = FALSE //Did we broadcast the tip of the day yet?
	var/selected_tip // What will be the tip of the day?

	/// Time left until the round starts after all subsystems initialize
	var/timeLeft = 120 SECONDS
	/// value used to initialize `timeLeft` when the master subsystem finishes initializing.
	/// We do this to allow for the timer to be set manually before all subsystems initialize,
	/// while also making sure that when the timer does start, it does so at the value we have set.
	/// This is set to the config value when SSticker initializes, so setting this only makes sense after that point.
	var/start_at = 120 SECONDS

	/// Num of players, used for pregame stats on statpanel
	var/totalPlayers = 0
	/// Num of ready players, used for pregame stats on statpanel (only viewable by admins)
	var/totalPlayersReady = 0
	/// Num of ready admins, used for pregame stats on statpanel (only viewable by admins)
	var/total_admins_ready = 0

	var/queue_delay = 0
	var/list/queued_players = list() //used for join queues when the server exceeds the hard population cap

	/// What is going to be reported to other stations at end of round?
	var/news_report


	var/roundend_check_paused = FALSE

	var/round_start_time = 0
	var/list/round_start_events
	var/list/round_end_events
	var/mode_result = "undefined"
	var/end_state = "undefined"

	/// People who have been commended and will receive a heart
	var/list/hearts

	/// Why an emergency shuttle was called
	var/emergency_reason

	///The display of how much time is left before a reboot, given to all clients post-game.
	var/atom/movable/screen/reboot_timer/reboot_hud
	/// ID of round reboot timer, if it exists
	var/reboot_timer = null
	var/real_round_start_time = 0 //SKYRAT EDIT ADDITION

	var/discord_alerted = FALSE //SKYRAT EDIT - DISCORD PING SPAM PREVENTION

/datum/controller/subsystem/ticker/Initialize()
	var/list/provisional_title_music = flist("[global.config.directory]/title_music/sounds/")
	var/list/music = list()
	var/use_rare_music = prob(1)

	for(var/S in provisional_title_music)
		var/lower = LOWER_TEXT(S)
		var/list/L = splittext(lower,"+")
		switch(L.len)
			if(3) //rare+MAP+sound.ogg or MAP+rare.sound.ogg -- Rare Map-specific sounds
				if(use_rare_music)
					if(L[1] == "rare" && L[2] == SSmapping.current_map.map_name)
						music += S
					else if(L[2] == "rare" && L[1] == SSmapping.current_map.map_name)
						music += S
			if(2) //rare+sound.ogg or MAP+sound.ogg -- Rare sounds or Map-specific sounds
				if((use_rare_music && L[1] == "rare") || (L[1] == SSmapping.current_map.map_name))
					music += S
			if(1) //sound.ogg -- common sound
				if(L[1] == "exclude")
					continue
				music += S

	var/old_login_music = trim(file2text("data/last_round_lobby_music.txt"))
	if(length(music) > 1)
		music -= old_login_music

	for(var/S in music)
		if(IS_SOUND_FILE(S))
			continue
		music -= S

	if(!length(music))
		music = world.file2list(ROUND_START_MUSIC_LIST, "\n")
		if(length(music) > 1)
			music -= old_login_music
		set_lobby_music(pick(music))
	else
		set_lobby_music("[global.config.directory]/title_music/sounds/[pick(music)]")

	start_at = CONFIG_GET(number/lobby_countdown) * (1 SECONDS)
	return SS_INIT_SUCCESS

/datum/controller/subsystem/ticker/fire()
	switch(current_state)
		if(GAME_STATE_STARTUP)
			for(var/client/C in GLOB.clients)
				window_flash(C, ignorepref = TRUE) //let them know lobby has opened up.
			to_chat(world, span_notice("<b>欢迎来到[station_name()]！</b>"))
			for(var/channel_tag in CONFIG_GET(str_list/channel_announce_new_game))
				// BUBBER EDIT CHANGE BEGIN - Replace with more rich message
				// send2chat(new /datum/tgs_message_content("New round starting on [SSmapping.current_map.map_name]!"), channel_tag)
				send2chat(new /datum/tgs_message_content("第 **[GLOB.round_id]** 回合即将在[CONFIG_GET(string/servername)]的[SSmapping.current_map.map_name]开始！\n如果希望收到游戏相关提醒，请前往 <#[CONFIG_GET(string/role_assign_channel_id)]> 领取相应身份组。"), channel_tag)
				// BUBBER EDIT CHANGE END - Replace with more rich message

			current_state = GAME_STATE_PREGAME
		// BUBBERSTATION EDIT START
			var/storyteller = CONFIG_GET(string/default_storyteller)
			if(storyteller)
				SSgamemode.set_storyteller(text2path(storyteller), TRUE)
			else
				SSvote.initiate_vote(/datum/vote/storyteller, "故事讲述者投票", forced = TRUE)
		// BUBBERSTATION EDIT END
			SStitle.change_title_screen() //SKYRAT EDIT ADDITION - Title screen
			addtimer(CALLBACK(SStitle, TYPE_PROC_REF(/datum/controller/subsystem/title, change_title_screen)), 1 SECONDS) //SKYRAT EDIT ADDITION - Title screen
			//Everyone who wants to be an observer is now spawned
			SEND_SIGNAL(src, COMSIG_TICKER_ENTER_PREGAME)
			fire()
		if(GAME_STATE_PREGAME)
			//lobby stats for statpanels
			totalPlayers = LAZYLEN(GLOB.new_player_list)
			totalPlayersReady = 0
			total_admins_ready = 0
			var/list/readied_players = list() //BUBBER EDIT ADDITION
			for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
				if(player.ready == PLAYER_READY_TO_PLAY)
					readied_players[player.key] = player //BUBBER EDIT: job estimation, filling the readied list we use later
					++totalPlayersReady
					if(player.client?.holder)
						++total_admins_ready

			job_estimation_list = get_job_estimation(readied_players) //BUBBER EDIT ADDITION
			if(start_immediately)
				timeLeft = 0

			//countdown
			if(timeLeft < 0)
				return
			timeLeft -= wait

			if(timeLeft <= 300 && !tipped)
				send_tip_of_the_round(world, selected_tip)
				tipped = TRUE

			if(timeLeft <= 0)
				SEND_SIGNAL(src, COMSIG_TICKER_ENTER_SETTING_UP)
				current_state = GAME_STATE_SETTING_UP
				Master.SetRunLevel(RUNLEVEL_SETUP)
				SSevents.reschedule() // SKYRAT EDIT ADDITION
				if(start_immediately)
					fire()

		if(GAME_STATE_SETTING_UP)
			if(!setup())
				//setup failed
				current_state = GAME_STATE_STARTUP
				timeLeft = null
				Master.SetRunLevel(RUNLEVEL_LOBBY)
				SEND_SIGNAL(src, COMSIG_TICKER_ERROR_SETTING_UP)

		if(GAME_STATE_PLAYING)
			check_queue()

			if(!roundend_check_paused && (check_finished() || force_ending))
				current_state = GAME_STATE_FINISHED
				toggle_ooc(TRUE) // Turn it on
				toggle_dooc(TRUE)
				declare_completion(force_ending)
				Master.SetRunLevel(RUNLEVEL_POSTGAME)

		if(GAME_STATE_FINISHED)
			if(ready_for_reboot)
				if(isnull(reboot_timer))
					reboot_hud.maptext = MAPTEXT_PIXELLARI("<center>服务器重启\n\ 已推迟</center>")
				else
					reboot_hud.maptext = MAPTEXT_PIXELLARI("<center>服务器重启倒计时：\n\ [DisplayTimeText(timeleft(SSticker.reboot_timer), 1)]</center>")

/datum/controller/subsystem/ticker/vv_edit_var(var_name, var_value)
	if(var_name == NAMEOF(src, login_music))
		set_lobby_music(var_value, override = TRUE)
	return ..()

/// Checks if the round should be ending, called every ticker tick
/datum/controller/subsystem/ticker/proc/check_finished()
	if(!setup_done)
		return FALSE
	if(SSshuttle.emergency && (SSshuttle.emergency.mode == SHUTTLE_ENDGAME))
		return TRUE
	if(GLOB.station_was_nuked)
		return TRUE
	if(GLOB.revolution_handler?.result == REVOLUTION_VICTORY)
		return TRUE
	return FALSE

/// Gets a list of players with their readied state so we can post it as a log
/datum/controller/subsystem/ticker/proc/get_player_ready_states()
	var/list/player_states = list()
	for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
		player_states[player.ckey] = player.ready
	return player_states

/datum/controller/subsystem/ticker/proc/setup()
	to_chat(world, span_boldannounce("正在开始游戏……"))
	var/init_start = world.timeofday

	var/list/players_and_readiness = get_player_ready_states()
	log_game("Players and Readiness: [json_encode(players_and_readiness)]", players_and_readiness)

	CHECK_TICK
	//Configure mode and assign player to antagonists
	var/can_continue = FALSE
//	can_continue = SSdynamic.select_roundstart_antagonists() //Choose antagonists // BUBBER EDIT - STORYTELLER (note: maybe disable)
	//BUBBER EDIT BEGIN - STORYTELLER
	SSgamemode.init_storyteller()
	can_continue = SSgamemode.pre_setup()
	//BUBBER EDIT END - STORYTELLER

	CHECK_TICK
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_PRE_JOBS_ASSIGNED, src)
	can_continue = can_continue && SSjob.divide_occupations() //Distribute jobs
	CHECK_TICK

	if(!GLOB.debugging_enabled)
		if(!can_continue)
			log_game("Game failed pre_setup")
			to_chat(world, "<B>游戏设置出错。</B>正在返回游戏大厅。")
			SSjob.reset_occupations()
			return FALSE
	else
		message_admins(span_notice("调试：正在跳过开局前检查……"))

	CHECK_TICK

	// There may be various config settings that have been set or modified by this point.
	// This is the point of no return before spawning in new players, let's run over the
	// job trim singletons and update them based on any config settings.
	SSid_access.refresh_job_trim_singletons()

	CHECK_TICK

	if(!CONFIG_GET(flag/ooc_during_round))
		toggle_ooc(FALSE) // Turn it off

	CHECK_TICK
	GLOB.start_landmarks_list = shuffle(GLOB.start_landmarks_list) //Shuffle the order of spawn points so they dont always predictably spawn bottom-up and right-to-left
	create_characters() //Create player characters
	collect_minds()
	equip_characters()

	GLOB.manifest.build()

	transfer_characters() //transfer keys to the new mobs

	for(var/I in round_start_events)
		var/datum/callback/cb = I
		cb.InvokeAsync()
	LAZYCLEARLIST(round_start_events)

	round_start_time = world.time //otherwise round_start_time would be 0 for the signals
	SEND_SIGNAL(src, COMSIG_TICKER_ROUND_STARTING, world.time)
	real_round_start_time = REALTIMEOFDAY //SKYRAT EDIT ADDITION
	SSautotransfer.new_shift(real_round_start_time) //SKYRAT EDIT ADDITION

	log_world("Game start took [(world.timeofday - init_start)/10]s")
	INVOKE_ASYNC(SSdbcore, TYPE_PROC_REF(/datum/controller/subsystem/dbcore,SetRoundStart))

	to_chat(world, span_notice(span_bold("欢迎来到[station_name()]，祝你玩得愉快！")))
	SEND_SOUND(world, sound(SSstation.announcer.get_rand_welcome_sound()))

	current_state = GAME_STATE_PLAYING
	Master.SetRunLevel(RUNLEVEL_GAME)

	if(length(GLOB.holidays))
		to_chat(world, span_notice("还有……"))
		for(var/holidayname in GLOB.holidays)
			var/datum/holiday/holiday = GLOB.holidays[holidayname]
			to_chat(world, span_info(holiday.greet()))

	PostSetup()

	return TRUE

/datum/controller/subsystem/ticker/proc/PostSetup()
	set waitfor = FALSE

	// Spawn traitors and stuff
	for(var/datum/dynamic_ruleset/roundstart/ruleset in SSdynamic.queued_rulesets)
		ruleset.execute()
		SSdynamic.unqueue_ruleset(ruleset)
		SSdynamic.executed_rulesets += ruleset
	// Queue roundstart intercept report
	/* BUBBER EDIT REMOVAL BEGIN - Storyteller
	if(!CONFIG_GET(flag/no_intercept_report))
		GLOB.communications_controller.queue_roundstart_report()
	*/// BUBBER EDIT REMOVAL END - Storyteller
	// Queue admin logout report
	var/roundstart_logout_timer = CONFIG_GET(number/roundstart_logout_report_time_average)
	var/roundstart_report_variance = CONFIG_GET(number/roundstart_logout_report_time_variance)
	var/randomized_callback_timer = rand((roundstart_logout_timer - roundstart_report_variance), (roundstart_logout_timer + roundstart_report_variance))
	addtimer(CALLBACK(src, PROC_REF(display_roundstart_logout_report)), randomized_callback_timer)
	GLOB.logout_timer_set = randomized_callback_timer
	// Queue suicide slot handling
	if(CONFIG_GET(flag/reopen_roundstart_suicide_roles))
		var/delay = (CONFIG_GET(number/reopen_roundstart_suicide_roles_delay) * 1 SECONDS) || 4 MINUTES
		addtimer(CALLBACK(src, PROC_REF(reopen_roundstart_suicide_roles)), delay)
	// Handle database
	if(SSdbcore.Connect())
		var/list/to_set = list()
		var/arguments = list()
		if(GLOB.revdata.originmastercommit)
			to_set += "commit_hash = :commit_hash"
			arguments["commit_hash"] = GLOB.revdata.GetDatabaseCommitSha()
		if(to_set.len)
			arguments["round_id"] = GLOB.round_id
			var/datum/db_query/query_round_game_mode = SSdbcore.NewQuery(
				"UPDATE [format_table_name("round")] SET [to_set.Join(", ")] WHERE id = :round_id",
				arguments
			)
			query_round_game_mode.Execute()
			qdel(query_round_game_mode)

	SSgamemode.post_setup() // BUBBER EDIT - Storyteller
	GLOB.start_state = new /datum/station_state()
	GLOB.start_state.count()

	var/list/adm = get_admin_counts()
	var/list/allmins = adm["present"]
	send2adminchat("服务器", "回合[GLOB.round_id ? "#[GLOB.round_id]" : ""]已开始[allmins.len ? "。":"，当前没有活跃的管理员在线！"]")
	setup_done = TRUE

	for(var/i in GLOB.start_landmarks_list)
		var/obj/effect/landmark/start/S = i
		if(istype(S)) //we can not runtime here. not in this important of a proc.
			S.after_round_start()
		else
			stack_trace("[S] [S.type] found in start landmarks list, which isn't a start landmark!")

	// handle persistence stuff that requires ckeys, in this case hardcore mode and temporal scarring
	for(var/i in GLOB.player_list)
		if(!ishuman(i))
			continue
		var/mob/living/carbon/human/iter_human = i

		iter_human.increment_scar_slot()
		iter_human.load_persistent_scars()
		SSpersistence.load_modular_persistence(iter_human.get_organ_slot(ORGAN_SLOT_BRAIN)) // SKYRAT EDIT ADDITION - MODULAR_PERSISTENCE
		iter_human.add_to_player_list() // BUBBER EDIT ADDITION - CHARACTER DIRECTORY

		if(!iter_human.hardcore_survival_score)
			continue
		if(iter_human.is_antag())
			to_chat(iter_human, span_notice("如果你在本回合完成所有目标，将获得[round(iter_human.hardcore_survival_score) * 2]点硬核随机积分！"))
		else
			to_chat(iter_human, span_notice("如果你在本回合存活，将获得[round(iter_human.hardcore_survival_score)]点硬核随机积分！"))

/datum/controller/subsystem/ticker/proc/display_roundstart_logout_report()
	var/list/msg = list("[span_boldnotice("开局离线报告")]\n\n")

	for(var/i in GLOB.mob_living_list)
		var/mob/living/L = i
		var/mob/living/carbon/C = L
		if (istype(C) && !C.last_mind)
			continue  // never had a client

		if(L.ckey && !GLOB.directory[L.ckey])
			msg += "<b>[L.name]</b> ([L.key])，[L.job]（<font color='#ffcc00'><b>已断开连接</b></font>）\n"


		if(L.ckey && L.client)
			var/failed = FALSE
			if(L.client.inactivity >= GLOB.logout_timer_set) //Connected, but inactive (alt+tabbed or something)
				msg += "<b>[L.name]</b> ([L.key])，[L.job]（<font color='#ffcc00'><b>在线，未活动</b></font>）\n"
				failed = TRUE //AFK client
			if(!failed && IS_UNCONSCIOUS_OR_CRIT(L))
				if(HAS_TRAIT(L, TRAIT_SUICIDED)) //Suicider
					msg += "<b>[L.name]</b> ([L.key])，[L.job]（[span_bolddanger("自杀")]）\n"
					failed = TRUE //Disconnected client
				if(!failed && (L.stat == HARD_CRIT))
					msg += "<b>[L.name]</b> ([L.key])，[L.job]（濒死）\n"
					failed = TRUE //Unconscious
				if(!failed && L.stat == DEAD)
					msg += "<b>[L.name]</b> ([L.key])，[L.job]（死亡）\n"
					failed = TRUE //Dead

			continue //Happy connected client
		for(var/mob/dead/observer/D in GLOB.dead_mob_list)
			if(D.mind && D.mind.current == L)
				if(L.stat == DEAD)
					if(HAS_TRAIT(L, TRAIT_SUICIDED)) //Suicider
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)])，[L.job]（[span_bolddanger("自杀")]）\n"
						continue //Disconnected client
					else
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)])，[L.job]（死亡）\n"
						continue //Dead mob, ghost abandoned
				else
					if(D.can_reenter_corpse)
						continue //Adminghost, or cult/wizard ghost
					else
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)])，[L.job]（[span_bolddanger("已出窍")]）\n"
						continue //Ghosted while alive

	msg += "[span_boldnotice("开局离线报告生成于：[DisplayTimeText(GLOB.logout_timer_set)]")]\n"

	var/concatenated_message = msg.Join()
	log_admin(concatenated_message)
	to_chat(GLOB.admins, concatenated_message)

/datum/controller/subsystem/ticker/proc/reopen_roundstart_suicide_roles()
	var/include_command = CONFIG_GET(flag/reopen_roundstart_suicide_roles_command_positions)
	var/list/reopened_jobs = list()

	for(var/mob/living/quitter in GLOB.suicided_mob_list)
		var/datum/job/job = SSjob.get_job(quitter.job)
		if(!job || !(job.job_flags & JOB_REOPEN_ON_ROUNDSTART_LOSS))
			continue
		if(!include_command && job.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND)
			continue
		job.current_positions = max(job.current_positions - 1, 0)
		reopened_jobs += quitter.job

	if(CONFIG_GET(flag/reopen_roundstart_suicide_roles_command_report))
		if(reopened_jobs.len)
			var/reopened_job_report_positions
			for(var/dead_dudes_job in reopened_jobs)
				reopened_job_report_positions = "[reopened_job_report_positions ? "[reopened_job_report_positions]\n":""][dead_dudes_job]"

			var/suicide_command_report = {"
				<font size = 3><b>[command_name()]人力资源委员会</b><br>
				人员变动通知</font><hr>
				致[station_name()]的人事管理人员：<br><br>
				我们的医务人员在贵站部分员工的生命体征传感器上
				检测到了一系列异常。<br><br>
				经进一步调查，我们发现这些员工做出了
				一系列相当……令人遗憾的决定。<br><br>
				因此，我们已自行将那些决定不再参与研究的船员
				所占职位重新开放招聘。相关个案将转交雇佣审查委员会，
				以确定他们是否仍有资格继续为公司服务（当然，也包括是否
				继续将其克隆记录保存在中央医疗备份服务器中）。<br><br>
				<i>我们已重新开放以下职位：<br><br>
				[reopened_job_report_positions]</i>
			"}

			print_command_report(suicide_command_report, "中央指挥部人事通告")

//These callbacks will fire after roundstart key transfer
/datum/controller/subsystem/ticker/proc/OnRoundstart(datum/callback/cb)
	if(!HasRoundStarted())
		LAZYADD(round_start_events, cb)
	else
		cb.InvokeAsync()

//These callbacks will fire before roundend report
/datum/controller/subsystem/ticker/proc/OnRoundend(datum/callback/cb)
	if(current_state >= GAME_STATE_FINISHED)
		cb.InvokeAsync()
	else
		LAZYADD(round_end_events, cb)

/datum/controller/subsystem/ticker/proc/create_characters()
	for(var/i in GLOB.new_player_list)
		var/mob/dead/new_player/player = i
		if(player.ready == PLAYER_READY_TO_PLAY && player.mind)
			GLOB.joined_player_list += player.ckey
			var/atom/destination = player.mind.assigned_role.get_roundstart_spawn_point()
			if(!destination) // Failed to fetch a proper roundstart location, won't be going anywhere.
				player.show_title_screen() //SKYRAT EDIT CHANGE
				continue
			player.create_character(destination)
		else
			player.show_title_screen() //SKYRAT EDIT ADDITION


		CHECK_TICK

/datum/controller/subsystem/ticker/proc/collect_minds()
	for(var/i in GLOB.new_player_list)
		var/mob/dead/new_player/P = i
		if(P.new_character && P.new_character.mind)
			SSticker.minds += P.new_character.mind
		CHECK_TICK


/datum/controller/subsystem/ticker/proc/equip_characters()
	GLOB.security_officer_distribution = decide_security_officer_departments(
		shuffle(GLOB.new_player_list),
		shuffle(GLOB.available_depts),
	)

	var/captainless = TRUE

	var/highest_rank = length(SSjob.chain_of_command) + 1
	var/list/spare_id_candidates = list()
	var/mob/dead/new_player/picked_spare_id_candidate

	// Find a suitable player to hold captaincy.
	for(var/mob/dead/new_player/new_player_mob as anything in GLOB.new_player_list)
		if(is_banned_from(new_player_mob.ckey, list(JOB_CAPTAIN)))
			CHECK_TICK
			continue
		if(!ishuman(new_player_mob.new_character))
			continue
		var/mob/living/carbon/human/new_player_human = new_player_mob.new_character
		if(!new_player_human.mind || is_unassigned_job(new_player_human.mind.assigned_role))
			continue
		// Keep a rolling tally of who'll get the cap's spare ID vault code.
		// Check assigned_role's priority and curate the candidate list appropriately.
		var/player_assigned_role = new_player_human.mind.assigned_role.title
		var/spare_id_priority = SSjob.chain_of_command[player_assigned_role]
		if(spare_id_priority)
			if(spare_id_priority < highest_rank)
				spare_id_candidates.Cut()
				spare_id_candidates += new_player_mob
				highest_rank = spare_id_priority
			else if(spare_id_priority == highest_rank)
				spare_id_candidates += new_player_mob
		CHECK_TICK

	if(length(spare_id_candidates))
		picked_spare_id_candidate = pick(spare_id_candidates)

	for(var/mob/dead/new_player/new_player_mob as anything in GLOB.new_player_list)
		if(QDELETED(new_player_mob) || !isliving(new_player_mob.new_character))
			CHECK_TICK
			continue
		var/mob/living/new_player_living = new_player_mob.new_character
		if(!new_player_living.mind)
			CHECK_TICK
			continue
		var/datum/job/player_assigned_role = new_player_living.mind.assigned_role
		if(player_assigned_role.job_flags & JOB_EQUIP_RANK)
			SSjob.equip_rank(new_player_living, player_assigned_role, new_player_mob.client)
		player_assigned_role.after_roundstart_spawn(new_player_living, new_player_mob.client)
		if(picked_spare_id_candidate == new_player_mob)
			captainless = FALSE
			var/acting_captain = !is_captain_job(player_assigned_role)
			SSjob.promote_to_captain(new_player_living, acting_captain)
			OnRoundstart(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(minor_announce), player_assigned_role.get_captaincy_announcement(new_player_living)))
		if(ishuman(new_player_living))
			if(player_assigned_role.job_flags & JOB_ASSIGN_QUIRKS)
				if(CONFIG_GET(flag/roundstart_traits))
					if(new_player_mob.client?.prefs?.should_be_random_hardcore(player_assigned_role, new_player_living.mind))
						new_player_mob.client.prefs.hardcore_random_setup(new_player_living)
					SSquirks.AssignQuirks(new_player_living, new_player_mob.client)
			else // clear any personalities the prefs added since our job clearly does not want them
				new_player_living.clear_personalities()

		if(ishuman(new_player_living))
			SEND_SIGNAL(new_player_living, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED)
		CHECK_TICK

	if(captainless)
		for(var/mob/dead/new_player/new_player_mob as anything in GLOB.new_player_list)
			var/mob/living/carbon/human/new_player_human = new_player_mob.new_character
			if(new_player_human)
				to_chat(new_player_mob, span_notice("未强制任命任何人为舰长。"))
			CHECK_TICK


/datum/controller/subsystem/ticker/proc/decide_security_officer_departments(
	list/new_players,
	list/departments,
)
	var/list/officer_mobs = list()
	var/list/officer_preferences = list()

	for (var/mob/dead/new_player/new_player_mob as anything in new_players)
		var/mob/living/carbon/human/character = new_player_mob.new_character
		if (istype(character) && is_security_officer_job(character.mind?.assigned_role))
			officer_mobs += character

			var/datum/client_interface/client = GET_CLIENT(new_player_mob)
			var/preference = client?.prefs?.read_preference(/datum/preference/choiced/security_department)
			officer_preferences += preference

	var/distribution = get_officer_departments(officer_preferences, departments)

	var/list/output = list()

	for (var/index in 1 to officer_mobs.len)
		output[REF(officer_mobs[index])] = distribution[index]

	return output

/datum/controller/subsystem/ticker/proc/transfer_characters()
	var/list/livings = list()
	for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
		var/mob/living = player.transfer_character()
		if(living)
			qdel(player)
			ADD_TRAIT(living, TRAIT_NO_TRANSFORM, SS_TICKER_TRAIT)
			if(living.client)
				var/atom/movable/screen/splash/fade_out = new(null, null, living.client, TRUE)
				fade_out.fade(TRUE)
				living.client.init_verbs()
				living.client.show_spawn_text_overlay()

			livings += living
	if(livings.len)
		addtimer(CALLBACK(src, PROC_REF(release_characters), livings), 3 SECONDS, TIMER_CLIENT_TIME)

/datum/controller/subsystem/ticker/proc/release_characters(list/livings)
	for(var/mob/living/living_mob as anything in livings)
		REMOVE_TRAIT(living_mob, TRAIT_NO_TRANSFORM, SS_TICKER_TRAIT)

/datum/controller/subsystem/ticker/proc/check_queue()
	if(!queued_players.len)
		return
	var/hard_popcap = CONFIG_GET(number/hard_popcap)
	if(!hard_popcap)
		list_clear_nulls(queued_players)
		for (var/mob/dead/new_player/new_player in queued_players)
			to_chat(new_player, span_userdanger("存活玩家人数限制已解除！<br><a href='byond://?src=[REF(new_player)];late_join=override'>[html_encode(">>加入游戏<<")]</a>"))
			SEND_SOUND(new_player, sound('sound/announcer/notice/notice1.ogg'))
			GLOB.latejoin_menu.ui_interact(new_player)
		queued_players.len = 0
		queue_delay = 0
		return

	queue_delay++
	var/mob/dead/new_player/next_in_line = queued_players[1]

	switch(queue_delay)
		if(5) //every 5 ticks check if there is a slot available
			list_clear_nulls(queued_players)
			if(living_player_count() < hard_popcap)
				if(next_in_line?.client)
					to_chat(next_in_line, span_userdanger("有空位了！你有约20秒的时间加入。<a href='byond://?src=[REF(next_in_line)];late_join=override'>\>\>加入游戏\<\<</a>"))
					SEND_SOUND(next_in_line, sound('sound/announcer/notice/notice1.ogg'))
					next_in_line.ui_interact(next_in_line)
					return
				queued_players -= next_in_line //Client disconnected, remove he
			queue_delay = 0 //No vacancy: restart timer
		if(25 to INFINITY)  //No response from the next in line when a vacancy exists, remove he
			to_chat(next_in_line, span_danger("未收到响应，你已被移出队列。"))
			queued_players -= next_in_line
			queue_delay = 0

///Whether the game has started, including roundend.
/datum/controller/subsystem/ticker/proc/HasRoundStarted()
	return current_state >= GAME_STATE_PLAYING

///Whether the game is currently in progress, excluding roundend
/datum/controller/subsystem/ticker/proc/IsRoundInProgress()
	return current_state == GAME_STATE_PLAYING

///Whether the game is currently in progress, excluding roundend
/datum/controller/subsystem/ticker/proc/IsPostgame()
	return current_state == GAME_STATE_FINISHED

/datum/controller/subsystem/ticker/Recover()
	current_state = SSticker.current_state
	force_ending = SSticker.force_ending

	login_music = SSticker.login_music
	round_end_sound = SSticker.round_end_sound

	minds = SSticker.minds

	delay_end = SSticker.delay_end

	tipped = SSticker.tipped
	selected_tip = SSticker.selected_tip

	timeLeft = SSticker.timeLeft

	totalPlayers = SSticker.totalPlayers
	totalPlayersReady = SSticker.totalPlayersReady
	total_admins_ready = SSticker.total_admins_ready

	queue_delay = SSticker.queue_delay
	queued_players = SSticker.queued_players
	round_start_time = SSticker.round_start_time

	queue_delay = SSticker.queue_delay
	queued_players = SSticker.queued_players

	if (Master) //Set Masters run level if it exists
		switch (current_state)
			if(GAME_STATE_SETTING_UP)
				Master.SetRunLevel(RUNLEVEL_SETUP)
			if(GAME_STATE_PLAYING)
				Master.SetRunLevel(RUNLEVEL_GAME)
			if(GAME_STATE_FINISHED)
				Master.SetRunLevel(RUNLEVEL_POSTGAME)

/datum/controller/subsystem/ticker/proc/send_news_report()
	var/news_message
	var/news_source = "纳米传讯新闻网"
	var/decoded_station_name = html_decode(CONFIG_GET(string/cross_comms_name)) //decode station_name to avoid minor_announce double encode // SKYRAT EDIT: CROSS COMMS CONFIG
	var/decoded_emergency_reason = html_decode(emergency_reason)

	switch(news_report)
		// The nuke was detonated on the syndicate recon outpost
		if(NUKE_SYNDICATE_BASE)
			news_message = "在一次大胆的突袭中，[decoded_station_name]的英勇船员\
				在恐怖分子基地的核心引爆了一枚核装置。"
		// The station was destroyed by nuke ops
		if(STATION_DESTROYED_NUKE)
			news_message = "我们在此向全体员工保证，所谓辛迪加\
				支持对[decoded_station_name]发动核袭击的报道实为谣言。祝各位平安！"
		// The station was evacuated (normal result)
		if(STATION_EVACUATED)
			// Had an emergency reason supplied to pass along
			if(emergency_reason)
				news_message = "[decoded_station_name]在发出以下\
					求救信号后已撤离：\n\n[decoded_emergency_reason]"
			else
				news_message = "有未经证实的报告称存在敌对活动，\
					[decoded_station_name]的船员现已撤离。"
		// A blob won
		if(BLOB_WIN)
			news_message = "[decoded_station_name]被不明生物灾害吞噬，\
				全体船员遇难。不要让悲剧在你身上重演！牢记：整洁的工作场所才是安全的工作场所。"
		// A blob was destroyed
		if(BLOB_DESTROYED)
			news_message = "生物危害已被消灭，[decoded_station_name]\
				目前正在进行消杀。提醒各位：如有船员出现\
				痉挛或腹胀，请立即向安保部报到并接受焚烧处理。"
		// A certain percentage of all cultists managed to escape at the end of round
		if(CULT_ESCAPE)
			news_message = "安保警报：一群宗教狂热分子已从[decoded_station_name]逃脱。"
		// Cult was completely or almost completely wiped out
		if(CULT_FAILURE)
			news_message = "[decoded_station_name]上的非法教团已被取缔，\
				在此提醒所有员工，严禁在礼拜堂之外举行宗教活动，\
				违者将被终止雇佣。"
		// Cult summoned Nar'sie
		if(CULT_SUMMON)
			news_message = "公司负责人在此澄清，[decoded_station_name]在今年早些时候\
				遭受陨石损坏后便已计划退役。先前关于\
				不可名状恐怖存在的报道纯属错误。"
		// Nuke detonated, but missed the station entirely
		if(NUKE_MISS)
			news_message = "辛迪加对[decoded_station_name]的恐怖袭击失败了，\
				他们在附近空无一物的太空中引爆了核武器。"
		// All nuke ops got killed
		if(OPERATIVES_KILLED)
			news_message = "船员歼灭了一支辛迪加精英\
				死亡小队，[decoded_station_name]的修复工作现已展开。"
		// Nuke ops results inconclusive - Crew escaped without the disk, or nukies were left alive, or something
		if(OPERATIVE_SKIRMISH)
			news_message = "[decoded_station_name]上的安保部队与辛迪加特工发生了一场小规模冲突，\
				双方均有伤亡，但都保持了战斗力。"
		// Revolution victory
		if(REVS_WIN)
			news_message = "公司负责人向投资者保证，尽管[decoded_station_name]发生了工会领导的叛乱，\
				工人的工资也不会因此上涨。"
		// Revolution defeat
		if(REVS_LOSE)
			news_message = "[decoded_station_name]迅速平定了一场误入歧途的叛乱。\
				请牢记，组织工会是违法的！"
		// All wizards (plus apprentices) have been killed
		if(WIZARD_KILLED)
			news_message = "太空巫师联邦的一名成员在[decoded_station_name]死亡，\
				导致双方关系骤然紧张。"
		// The station was nuked generically
		if(STATION_NUKED)
			// There was a blob on board, guess it was nuked to stop it
			if(length(GLOB.overminds))
				for(var/mob/eye/blob/overmind as anything in GLOB.overminds)
					if(overmind.max_count < overmind.announcement_size)
						continue

					news_message = "[decoded_station_name]以受控辐射爆发清除了一团\
						生物黏液，目前正在进行消杀。全体员工事先均已安全撤离，\
						正在享受轻松愉快的假期。"
					break
			// A self destruct or something else
			else
				news_message = "[decoded_station_name]因不明原因启动了自毁装置。\
					目前正在尝试克隆舰长，以便将其逮捕并处决。"
		// The emergency escape shuttle was hijacked
		if(SHUTTLE_HIJACK)
			news_message = "在例行撤离过程中，[decoded_station_name]的紧急穿梭机\
				因导航协议损坏而偏离航线，但不久后便已找回。\
				撤离前曾发出以下求救信号：\n\n[Gibberish(decoded_emergency_reason, FALSE, 8)]"
		// A supermatter cascade triggered
		if(SUPERMATTER_CASCADE)
			news_message = "官方正在通知附近殖民地，\
				[decoded_station_name]周边星区已被划为禁区。"

	//SKYRAT EDIT - START
	if(SSblackbox.first_death)
		var/list/ded = SSblackbox.first_death
		if(ded.len)
			news_message += " 纳米传讯授权灵能者在空间站附近捕捉到某人的微弱痕迹，据称此人已经死亡。其姓名为[ded["name"]]，职位为[ded["role"]]，地点为[ded["area"]]。[ded["last_words"] ? " 其遗言为：\"[ded["last_words"]]\"" : ""]" // " // An Extra quote and comment because highlighting goes weird
		else
			news_message += " 纳米传讯授权灵能者自豪地证实，本班次无人死亡！"
	//SKYRAT EDIT - END

	if(news_message && length(CONFIG_GET(keyed_list/cross_server))) //SKYRAT EDIT - CONFIG CHECK MOVED FROM ROUNDEND.DM
		news_message += " （[CONFIG_GET(string/cross_server_name)]的班次即将结束！）" //SKYRAT EDIT ADDITION
		send2otherserver(news_source, news_message,"News_Report")
	//SKYRAT EDIT - START
	if(news_message)
		return news_message
	else
		return "很遗憾地告诉大家，这事儿简直乱套了。我们的记者没一个搞得清究竟发生了什么，或者根本没发生什么。"
	//SKYRAT EDIT - END

/datum/controller/subsystem/ticker/proc/GetTimeLeft()
	return timeLeft

/datum/controller/subsystem/ticker/proc/SetTimeLeft(newtime)
	start_at = newtime
	timeLeft = newtime

/datum/controller/subsystem/ticker/proc/SetRoundEndSound(the_sound)
	set waitfor = FALSE
	round_end_sound_sent = FALSE
	round_end_sound = fcopy_rsc(the_sound)
	for(var/thing in GLOB.clients)
		var/client/C = thing
		if (!C)
			continue
		C.Export("##action=load_rsc", round_end_sound)
	round_end_sound_sent = TRUE

/datum/controller/subsystem/ticker/proc/Reboot(reason, end_string, delay)
	set waitfor = FALSE
	if(usr && !check_rights(R_SERVER, TRUE))
		return

	if(!delay)
		delay = CONFIG_GET(number/round_end_countdown) * 10

	var/skip_delay = check_rights()
	if(delay_end && !skip_delay)
		to_chat(world, span_boldannounce("管理员已推迟本回合结束。"))
		return

	to_chat(world, span_boldannounce("服务器将在[DisplayTimeText(delay)]后重启。[reason]"))

	var/statspage = CONFIG_GET(string/roundstatsurl)
	var/gamelogloc = CONFIG_GET(string/gamelogurl)
	if(statspage)
		to_chat(world, span_info("回合统计与日志可在<a href=\"[statspage][GLOB.round_id]\">此网站</a>查看！"))
	else if(gamelogloc)
		to_chat(world, span_info("回合日志可在<a href=\"[gamelogloc]\">此网站</a>查看！"))

	var/start_wait = world.time
	UNTIL(round_end_sound_sent || (world.time - start_wait) > (delay * 2)) //don't wait forever
	if(!isnull(reboot_timer)) //Override existing reboot timers.
		deltimer(reboot_timer)
	reboot_timer = addtimer(CALLBACK(src, PROC_REF(reboot_callback), reason, end_string), delay - (world.time - start_wait), TIMER_STOPPABLE)


/datum/controller/subsystem/ticker/proc/reboot_callback(reason, end_string)
	if(end_string)
		end_state = end_string

	log_game(span_boldannounce("Rebooting World. [reason]"))

	world.Reboot()

/**
 * Deletes the current reboot timer and nulls the var
 *
 * Arguments:
 * * user - the user that cancelled the reboot, may be null
 */
/datum/controller/subsystem/ticker/proc/cancel_reboot(mob/user)
	if(!reboot_timer)
		to_chat(user, span_warning("当前没有待执行的重启！"))
		return FALSE
	to_chat(world, span_boldannounce("管理员已推迟本回合结束。"))
	deltimer(reboot_timer)
	reboot_timer = null
	return TRUE

/datum/controller/subsystem/ticker/Shutdown()
	gather_newscaster() //called here so we ensure the log is created even upon admin reboot
	if(!round_end_sound)
		round_end_sound = choose_round_end_song()
	for(var/mob/M in GLOB.player_list)
		var/pref_volume = M.client.prefs.read_preference(/datum/preference/numeric/volume/sound_midi)
		if(pref_volume > 0)
			SEND_SOUND(M.client, sound(round_end_sound, volume = pref_volume))

	text2file(login_music, "data/last_round_lobby_music.txt")

/datum/controller/subsystem/ticker/proc/choose_round_end_song()
	var/list/reboot_sounds = flist("[global.config.directory]/reboot_themes/")
	var/list/possible_themes = list()

	for(var/themes in reboot_sounds)
		possible_themes += themes
	if(possible_themes.len)
		return "[global.config.directory]/reboot_themes/[pick(possible_themes)]"

/// Updates the lobby music
/// Does not update if override is FALSE and login_music is already set
/datum/controller/subsystem/ticker/proc/set_lobby_music(new_music, override = FALSE)
	if(!override && login_music)
		return

	login_music = new_music
	//we just overrode the song, let's update everyone.
	if(override)
		for(var/mob/dead/new_player/new_player as anything in GLOB.new_player_list)
			new_player?.client.playtitlemusic()

#undef ROUND_START_MUSIC_LIST
#undef SS_TICKER_TRAIT
