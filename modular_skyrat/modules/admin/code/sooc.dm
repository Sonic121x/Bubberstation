GLOBAL_VAR_INIT(SOOC_COLOR, "#ff5454")
GLOBAL_VAR_INIT(sooc_allowed, TRUE)	// used with admin verbs to disable sooc - not a config option
GLOBAL_LIST_EMPTY(ckey_to_sooc_name)

#define SOOC_LISTEN_PLAYER 1
#define SOOC_LISTEN_ADMIN 2

GAME_VERB(/client, sooc, "SOOC", "OOC")
	VERB_ARG(msg, VERB_ARG_TYPE_TEXT, VERB_ARG_SOURCE_INPUT)
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("发言目前已被管理员禁用。"))
		return

	if(!mob)
		return

	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE,
		JOB_HEAD_OF_SECURITY=TRUE,
		JOB_WARDEN=TRUE, JOB_DETECTIVE=TRUE,
		JOB_SECURITY_OFFICER=TRUE,
		JOB_CORRECTIONS_OFFICER=TRUE,
		JOB_SECURITY_MEDIC=TRUE,
		)
	if(!holder)
		var/job = mob?.mind.assigned_role.title
		if(!job || !job_lookup[job])
			to_chat(src, span_danger("你不是安保部门的角色！"))
			return
		if(!GLOB.sooc_allowed)
			to_chat(src, span_danger("SOOC 已被全局静音。"))
			return
		if(prefs.muted & MUTE_OOC)
			to_chat(src, span_danger("你无法使用 OOC（已被静音）。"))
			return
	if(is_banned_from(ckey, "OOC"))
		to_chat(src, span_danger("你已被禁止使用 OOC。"))
		return
	if(QDELETED(src))
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	var/raw_msg = msg

	if(!msg)
		return

	msg = emoji_parse(msg)

	if(!(prefs.chat_toggles & CHAT_OOC))
		to_chat(src, span_danger("你已静音 OOC。"))
		return

	mob.log_talk(raw_msg, LOG_OOC, tag="SOOC")

	var/keyname = key
	var/anon = FALSE

	//Anonimity for players and deadminned admins
	if(!holder || holder.deadmined)
		if(!GLOB.ckey_to_sooc_name[key])
			GLOB.ckey_to_sooc_name[key] = "副警长 [pick(GLOB.phonetic_alphabet)] [rand(1, 99)]"
		keyname = GLOB.ckey_to_sooc_name[key]
		anon = TRUE

	var/list/listeners = list()

	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		//Admins with muted OOC do not get to listen to SOOC, but normal players do, as it could be admins talking important stuff to them
		if(iterated_mob.client?.holder && !iterated_mob.client?.holder?.deadmined && iterated_mob.client?.prefs?.chat_toggles & CHAT_OOC)
			listeners[iterated_mob.client] = SOOC_LISTEN_ADMIN
		else
			if(iterated_mob.mind)
				var/datum/mind/mob_mind = iterated_mob.mind
				if(job_lookup[mob_mind.assigned_role?.title])
					listeners[iterated_mob.client] = SOOC_LISTEN_PLAYER

	for(var/iterated_listener in listeners)
		var/client/iterated_client = iterated_listener
		var/mode = listeners[iterated_listener]
		var/color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color)) ? iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color) : GLOB.SOOC_COLOR
		var/name = (mode == SOOC_LISTEN_ADMIN && anon) ? "([key])[keyname]" : keyname
		to_chat(iterated_client, span_oocplain("<font color='[color]'><b><span class='prefix'>SOOC:</span> <EM>[name]:</EM> <span class='message linkify'>[msg]</span></b></font>"))

#undef SOOC_LISTEN_PLAYER
#undef SOOC_LISTEN_ADMIN

/proc/toggle_sooc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling sooc
		if(toggle != GLOB.sooc_allowed)
			GLOB.sooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.sooc_allowed = !GLOB.sooc_allowed
	var/list/listeners = list()
	var/static/list/job_lookup = list(JOB_SECURITY_OFFICER = TRUE, JOB_WARDEN = TRUE, JOB_DETECTIVE = TRUE, JOB_HEAD_OF_SECURITY = TRUE, JOB_CAPTAIN = TRUE, JOB_BLUESHIELD = TRUE)
	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		if(!iterated_mob.client?.holder?.deadmined)
			listeners[iterated_mob.client] = TRUE
		else
			if(iterated_mob.mind)
				var/datum/mind/mob_mind = iterated_mob.mind
				if(job_lookup[mob_mind.assigned_role])
					listeners[iterated_mob.client] = TRUE
	for(var/iterated_listener in listeners)
		var/client/iterated_client = iterated_listener
		to_chat(iterated_client, span_oocplain("<b>SOOC 频道已在全局范围内[GLOB.sooc_allowed ? "启用" : "禁用"]。</b>"))

ADMIN_VERB(togglesooc, R_ADMIN, "切换安保 OOC", "切换安保 OOC。", ADMIN_CATEGORY_SERVER)
	toggle_sooc()
	log_admin("[key_name(usr)] 切换了安保 OOC。")
	message_admins("管理员 [key_name_admin(usr)] 切换了安保 OOC。")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.sooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
