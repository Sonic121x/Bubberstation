/datum/controller/configuration
	name = "配置"

	var/directory = "config"

	var/warned_deprecated_configs = FALSE
	var/hiding_entries_by_type = TRUE //Set for readability, admins can set this to FALSE if they want to debug it
	var/list/entries
	var/list/entries_by_type

	var/list/maplist
	var/datum/map_config/defaultmap

	var/list/modes // allowed modes
	var/list/gamemode_cache
	var/list/votable_modes // votable modes
	var/list/mode_names
	var/list/mode_reports
	var/list/mode_false_report_weight

	var/motd
	var/policy

	/// If the configuration is loaded
	var/loaded = FALSE

	/// If a reload is in progress
	var/reload_in_progress = FALSE

	/// A regex that matches words blocked IC
	var/static/regex/ic_filter_regex

	/// A regex that matches words blocked OOC
	var/static/regex/ooc_filter_regex

	/// A regex that matches words blocked IC, but not in PDAs
	var/static/regex/ic_outside_pda_filter_regex

	/// A regex that matches words soft blocked IC
	var/static/regex/soft_ic_filter_regex

	/// A regex that matches words soft blocked OOC
	var/static/regex/soft_ooc_filter_regex

	/// A regex that matches words soft blocked IC, but not in PDAs
	var/static/regex/soft_ic_outside_pda_filter_regex

	/// An assoc list of blocked IC words to their reasons
	var/static/list/ic_filter_reasons

	/// An assoc list of words that are blocked IC, but not in PDAs, to their reasons
	var/static/list/ic_outside_pda_filter_reasons

	/// An assoc list of words that are blocked both IC and OOC to their reasons
	var/static/list/shared_filter_reasons

	/// An assoc list of soft blocked IC words to their reasons
	var/static/list/soft_ic_filter_reasons

	/// An assoc list of words that are soft blocked IC, but not in PDAs, to their reasons
	var/static/list/soft_ic_outside_pda_filter_reasons

	/// An assoc list of words that are soft blocked both IC and OOC to their reasons
	var/static/list/soft_shared_filter_reasons

	/// A list of configuration errors that occurred during load
	var/static/list/configuration_errors

/datum/controller/configuration/proc/admin_reload()
	if(IsAdminAdvancedProcCall() || !PreConfigReload())
		return

	log_admin("[key_name_admin(usr)]已强制从磁盘重新加载配置。")
	message_admins("[key_name_admin(usr)]已强制从磁盘重新加载配置。")
	full_wipe()
	Load(world.params[OVERRIDE_CONFIG_DIRECTORY_PARAMETER])

/datum/controller/configuration/proc/PreConfigReload()
	if(reload_in_progress)
		to_chat(usr, span_warning("已有其他用户正在重新加载配置！"))
		return FALSE

	reload_in_progress = TRUE
	world.TgsTriggerEvent("tg-PreConfigReload", wait_for_completion = TRUE)
	reload_in_progress = FALSE
	return TRUE

/datum/controller/configuration/proc/Load(_directory)
	if(IsAdminAdvancedProcCall()) //If admin proccall is detected down the line it will horribly break everything.
		return
	if(_directory)
		directory = _directory
	if(entries)
		CRASH("/datum/controller/configuration/Load() called more than once!")
	configuration_errors ||= list()
	InitEntries()
	if(fexists("[directory]/config.txt") && LoadEntries("config.txt") <= 1)
		var/list/legacy_configs = list("game_options.txt", "dbconfig.txt", "comms.txt")
		for(var/I in legacy_configs)
			if(fexists("[directory]/[I]"))
				log_config("config.txt 中未找到 $include 指令！正在加载旧版[legacy_configs.Join("/")]文件……")
				for(var/J in legacy_configs)
					LoadEntries(J)
				break
	if (fexists("[directory]/dev_overrides.txt"))
		LoadEntries("dev_overrides.txt")
	if (fexists("[directory]/ezdb.txt"))
		LoadEntries("ezdb.txt")
	loadmaplist(CONFIG_MAPS_FILE)
	LoadMOTD()
	LoadPolicy()
	LoadChatFilter()
	if(CONFIG_GET(flag/load_jobs_from_txt))
		validate_job_config()
		if(SSjob.initialized) // in case we're reloading from disk after initialization, wanna make sure the changes update in the ongoing shift
			SSjob.load_jobs_from_config()

	if(CONFIG_GET(flag/usewhitelist))
		load_whitelist()

	// SKYRAT EDIT ADDITION START
	populate_interaction_instances()
	remove_erp_things()
	// SKYRAT EDIT ADDITION END

	loaded = TRUE

	if (Master)
		Master.OnConfigLoad()
	process_config_errors()

/datum/controller/configuration/proc/full_wipe()
	if(IsAdminAdvancedProcCall())
		return
	entries_by_type.Cut()
	QDEL_LIST_ASSOC_VAL(entries)
	entries = null
	QDEL_LIST_ASSOC_VAL(maplist)
	maplist = null
	QDEL_NULL(defaultmap)
	configuration_errors?.Cut()

/datum/controller/configuration/Destroy()
	full_wipe()
	config = null

	return ..()

/datum/controller/configuration/proc/log_config_error(error_message)
	configuration_errors += error_message
	log_config(error_message)

/datum/controller/configuration/proc/process_config_errors()
	if(!CONFIG_GET(flag/config_errors_runtime))
		return
	for(var/error_message in configuration_errors)
		stack_trace(error_message)

/datum/controller/configuration/proc/InitEntries()
	var/list/_entries = list()
	entries = _entries
	var/list/_entries_by_type = list()
	entries_by_type = _entries_by_type

	for(var/I in valid_subtypesof(/datum/config_entry)) //typesof is faster in this case
		var/datum/config_entry/E = I
		E = new I
		var/esname = E.name
		var/datum/config_entry/test = _entries[esname]
		if(test)
			log_config_error("错误：[test.type]与[E.type]使用了相同的名称[esname]！将不初始化[E.type]！")
			qdel(E)
			continue
		_entries[esname] = E
		_entries_by_type[I] = E

/datum/controller/configuration/proc/RemoveEntry(datum/config_entry/CE)
	entries -= CE.name
	entries_by_type -= CE.type

/datum/controller/configuration/proc/LoadEntries(filename, list/stack = list())
	if(IsAdminAdvancedProcCall())
		return

	var/list/separate_levels = splittext(filename, "/")
	// allows for inheriting our folder from the thing that included us
	var/subfolder = ""
	// do we have an actual directory or is this just one file
	if(length(separate_levels) > 1)
		var/actual_filename = separate_levels[length(separate_levels)]
		// We need to sanitize out .. to ensure filename_to_test doesn't accidentially an infinte loop here
		// Need filename in absolute form
		var/list/parsed_folder_bits = list()
		// look at just the relative directory referenced
		for(var/entry in separate_levels - actual_filename)
			if(entry == ".." && length(parsed_folder_bits))
				parsed_folder_bits.Cut(length(parsed_folder_bits), 0)
			else
				parsed_folder_bits += entry
		if(length(parsed_folder_bits))
			subfolder = "[parsed_folder_bits.Join("/")]/"
		filename = "[subfolder][actual_filename]"

	var/filename_to_test = world.system_type == MS_WINDOWS ? LOWER_TEXT(filename) : filename
	if(filename_to_test in stack)
		log_config_error("警告：检测到配置循环引用（[english_list(stack)]），已中止！")
		return
	stack = stack + filename_to_test

	log_config("正在加载配置文件[filename]……")
	var/list/lines = world.file2list("[directory]/[filename]")
	var/list/_entries = entries
	for(var/L in lines)
		L = trim(L)
		if(!L)
			continue

		var/firstchar = L[1]
		if(firstchar == "#")
			continue

		var/lockthis = firstchar == "@"
		if(lockthis)
			L = copytext(L, length(firstchar) + 1)

		var/pos = findtext(L, " ")
		var/entry = null
		var/value = null

		if(pos)
			entry = LOWER_TEXT(copytext(L, 1, pos))
			value = copytext(L, pos + length(L[pos]))
		else
			entry = LOWER_TEXT(L)

		if(!entry)
			continue

		if(entry == "$include")
			if(!value)
				log_config_error("警告：无效的 $include 指令：[value]")
			else
				LoadEntries("[subfolder][value]", stack)
				++.
			continue

		// Reset directive, used for setting a config value back to defaults. Useful for string list config types
		if (entry == "$reset")
			var/datum/config_entry/resetee = _entries[LOWER_TEXT(value)]
			if (!value || !resetee)
				log_config_error("警告：无效的 $reset 指令：[value]")
				continue
			resetee.set_default()
			log_config("已将[value]的配置值恢复为原始默认值")
			continue

		var/datum/config_entry/E = _entries[entry]
		if(!E)
			log_config("配置中存在未知设置：“[entry]”")
			continue

		if(lockthis)
			E.protection |= CONFIG_ENTRY_LOCKED

		if(E.deprecated_by)
			var/datum/config_entry/new_ver = entries_by_type[E.deprecated_by]
			var/new_value = E.DeprecationUpdate(value)
			var/good_update = istext(new_value)
			log_config("配置项[entry]已弃用，即将移除。请迁移到[new_ver.name]！[good_update ? " 建议的新值为：[new_value]" : ""]")
			if(!warned_deprecated_configs)
				DelayedMessageAdmins("本服务器正在使用已弃用的配置设置。请检查日志并进行相应更新。")
				warned_deprecated_configs = TRUE
			if(good_update)
				value = new_value
				E = new_ver
			else
				warning("[new_ver.type] is deprecated but gave no proper return for DeprecationUpdate()")

		var/validated = E.ValidateAndSet(value)
		if(!validated)
			var/log_message = "配置项[entry]的值\"[value]\"未通过验证"
			log_config(log_message)
			stack_trace(log_message)
		else
			if(E.modified && !E.dupes_allowed && E.resident_file == filename)
				log_config_error("检测到[entry]的重复设置（[value]，[E.resident_file]）！将使用最新设置。")

		E.resident_file = filename

		if(validated)
			E.modified = TRUE

	++.

/datum/controller/configuration/can_vv_get(var_name)
	return (var_name != NAMEOF(src, entries_by_type) || !hiding_entries_by_type) && ..()

/datum/controller/configuration/vv_edit_var(var_name, var_value)
	var/list/banned_edits = list(NAMEOF(src, entries_by_type), NAMEOF(src, entries), NAMEOF(src, directory))
	return !(var_name in banned_edits) && ..()

/datum/controller/configuration/stat_entry(msg)
	msg = "编辑"
	return msg

/datum/controller/configuration/proc/Get(entry_type)
	var/datum/config_entry/E = entry_type
	var/entry_is_abstract = initial(E.abstract_type) == entry_type
	if(entry_is_abstract)
		CRASH("Tried to retrieve an abstract config_entry: [entry_type]")
	E = entries_by_type[entry_type]
	if(!E)
		CRASH("Missing config entry for [entry_type]!")
	if((E.protection & CONFIG_ENTRY_HIDDEN) && IsAdminAdvancedProcCall() && GLOB.LastAdminCalledProc == "Get" && GLOB.LastAdminCalledTargetRef == "[REF(src)]")
		log_admin_private("[key_name(usr)]试图访问配置项[entry_type]")
		return
	return E.config_entry_value

/datum/controller/configuration/proc/Set(entry_type, new_val)
	var/datum/config_entry/E = entry_type
	var/entry_is_abstract = initial(E.abstract_type) == entry_type
	if(entry_is_abstract)
		CRASH("Tried to set an abstract config_entry: [entry_type]")
	E = entries_by_type[entry_type]
	if(!E)
		CRASH("Missing config entry for [entry_type]!")
	if((E.protection & CONFIG_ENTRY_LOCKED) && IsAdminAdvancedProcCall() && GLOB.LastAdminCalledProc == "Set" && GLOB.LastAdminCalledTargetRef == "[REF(src)]")
		log_admin_private("[key_name(usr)]试图将配置项[entry_type]改写为[new_val]")
		return
	return E.ValidateAndSet("[new_val]")

/datum/controller/configuration/proc/LoadMOTD()
	var/list/motd_contents = list()

	var/list/motd_list = CONFIG_GET(str_list/motd)
	if (motd_list.len == 0 && fexists("[directory]/motd.txt"))
		motd_list = list("motd.txt")

	for (var/motd_file in motd_list)
		if (fexists("[directory]/[motd_file]"))
			motd_contents += file2text("[directory]/[motd_file]")
		else
			log_config("每日公告文件[motd_file]不存在")
			DelayedMessageAdmins("每日公告文件[motd_file]不存在")

	motd = motd_contents.Join("\n")

	var/tm_info = GLOB.revdata.GetTestMergeInfo()
	if(motd || tm_info)
		motd = motd ? "[motd]<br>[tm_info]" : tm_info

/*
Policy file should be a json file with a single object.
Value is raw html.
Possible keywords :
Job titles / Assigned roles (ghost spawners for example) : Assistant , Captain , Ash Walker
Mob types : /mob/living/basic/carp
Antagonist types : /datum/antagonist/highlander
Species types : /datum/species/lizard
special keywords defined in _DEFINES/admin.dm
Example config:
{
	JOB_ASSISTANT : "Don't kill everyone",
	"/datum/antagonist/highlander" : "<b>Kill everyone</b>",
	"Ash Walker" : "Kill all spacemans"
}
*/
/datum/controller/configuration/proc/LoadPolicy()
	policy = list()
	var/json_path = CONFIG_GET(string/policy_json_path)
	var/rawpolicy = file2text("[directory]/[json_path]")
	if(rawpolicy)
		var/parsed = safe_json_decode(rawpolicy)
		if(!parsed)
			log_config("policy.json 的 JSON 解析失败 {[json_path]}")
			DelayedMessageAdmins("policy.json 的 JSON 解析失败 {[json_path]}")
		else
			policy = parsed

/datum/controller/configuration/proc/loadmaplist(filename)
	log_config("正在加载配置文件[filename]……")
	filename = "[directory]/[filename]"
	var/list/Lines = world.file2list(filename)

	var/datum/map_config/currentmap = null
	for(var/t in Lines)
		if(!t)
			continue

		t = trim(t)
		if(length(t) == 0)
			continue
		else if(t[1] == "#")
			continue

		var/pos = findtext(t, " ")
		var/command = null
		var/data = null

		if(pos)
			command = LOWER_TEXT(copytext(t, 1, pos))
			data = copytext(t, pos + length(t[pos]))
		else
			command = LOWER_TEXT(t)

		if(!command)
			continue

		if (!currentmap && command != "map")
			continue

		switch (command)
			if ("map")
				currentmap = load_map_config(data, MAP_DIRECTORY_MAPS)
				if(currentmap.defaulted)
					var/error_message = "无法加载[data]的地图配置！"
					log_config(error_message)
					log_mapping(error_message, TRUE)
					currentmap = null
			if ("minplayers","minplayer")
				currentmap.config_min_users = text2num(data)
			if ("maxplayers","maxplayer")
				currentmap.config_max_users = text2num(data)
			if ("weight","voteweight")
				currentmap.voteweight = text2num(data)
			if ("default","defaultmap")
				defaultmap = currentmap
			if ("votable")
				currentmap.votable = TRUE
			if ("endmap")
				LAZYINITLIST(maplist)
				maplist[currentmap.map_name] = currentmap
				currentmap = null
			if ("disabled")
				currentmap = null
			if("feedbacklink")
				if(currentmap.map_name == SSmapping.current_map.map_name)
					SSmapping.current_map.feedback_link = data
			if("webmap_url")
				if(currentmap.map_name == SSmapping.current_map.map_name)
					SSmapping.current_map.mapping_url = data
			else
				log_config("地图投票配置中存在未知命令：“[command]”")

/datum/controller/configuration/proc/LoadChatFilter()
	if(!fexists("[directory]/word_filter.toml"))
		load_legacy_chat_filter()
		return

	log_config("正在加载配置文件 word_filter.toml……")
	var/list/result = rustg_raw_read_toml_file("[directory]/word_filter.toml")
	if(!result["success"])
		var/message = "词语过滤器配置不正确！[result["content"]]"
		log_config(message)
		DelayedMessageAdmins(message)
		return
	var/list/word_filter = json_decode(result["content"])

	ic_filter_reasons = try_extract_from_word_filter(word_filter, "ic")
	ic_outside_pda_filter_reasons = try_extract_from_word_filter(word_filter, "ic_outside_pda")
	shared_filter_reasons = try_extract_from_word_filter(word_filter, "shared")
	soft_ic_filter_reasons = try_extract_from_word_filter(word_filter, "soft_ic")
	soft_ic_outside_pda_filter_reasons = try_extract_from_word_filter(word_filter, "soft_ic_outside_pda")
	soft_shared_filter_reasons = try_extract_from_word_filter(word_filter, "soft_shared")

	update_chat_filter_regexes()

/datum/controller/configuration/proc/load_legacy_chat_filter()
	if (!fexists("[directory]/in_character_filter.txt"))
		return

	log_config("正在加载配置文件 in_character_filter.txt……")

	ic_filter_reasons = list()
	ic_outside_pda_filter_reasons = list()
	shared_filter_reasons = list()
	soft_ic_filter_reasons = list()
	soft_ic_outside_pda_filter_reasons = list()
	soft_shared_filter_reasons = list()

	for (var/line in world.file2list("[directory]/in_character_filter.txt"))
		if (!line)
			continue
		if (findtextEx(line, "#", 1, 2))
			continue
		// The older filter didn't apply to PDA
		ic_outside_pda_filter_reasons[line] = "未提供原因"

	update_chat_filter_regexes()

/// Will update the internal regexes of the chat filter based on the filter reasons
/datum/controller/configuration/proc/update_chat_filter_regexes()
	ic_filter_regex = compile_filter_regex(ic_filter_reasons + ic_outside_pda_filter_reasons + shared_filter_reasons)
	ic_outside_pda_filter_regex = compile_filter_regex(ic_filter_reasons + shared_filter_reasons)
	ooc_filter_regex = compile_filter_regex(shared_filter_reasons)
	soft_ic_filter_regex = compile_filter_regex(soft_ic_filter_reasons + soft_ic_outside_pda_filter_reasons + soft_shared_filter_reasons)
	soft_ic_outside_pda_filter_regex = compile_filter_regex(soft_ic_filter_reasons + soft_shared_filter_reasons)
	soft_ooc_filter_regex = compile_filter_regex(soft_shared_filter_reasons)

/datum/controller/configuration/proc/try_extract_from_word_filter(list/word_filter, key)
	var/list/banned_words = word_filter[key]

	if (isnull(banned_words))
		return list()
	else if (!islist(banned_words))
		var/message = "词语过滤配置中的“[key]”键无效，请联系有配置权限的人员检查设置。"
		log_config(message)
		DelayedMessageAdmins(message)
		return list()

	var/list/formatted_banned_words = list()

	for (var/banned_word in banned_words)
		formatted_banned_words[LOWER_TEXT(banned_word)] = banned_words[banned_word]
	return formatted_banned_words

/datum/controller/configuration/proc/compile_filter_regex(list/banned_words)
	if (isnull(banned_words) || banned_words.len == 0)
		return null

	var/static/regex/should_join_on_word_bounds = regex(@"^\w+$")

	// Stuff like emoticons needs another split, since there's no way to get ":)" on a word bound.
	// Furthermore, normal words need to be on word bounds, so "(adminhelp)" gets filtered.
	var/list/to_join_on_whitespace_splits = list()
	var/list/to_join_on_word_bounds = list()

	for (var/banned_word in banned_words)
		if (findtext(banned_word, should_join_on_word_bounds))
			to_join_on_word_bounds += REGEX_QUOTE(banned_word)
		else
			to_join_on_whitespace_splits += REGEX_QUOTE(banned_word)

	// We don't want a whitespace_split part if there's no stuff that requires it
	var/whitespace_split = to_join_on_whitespace_splits.len > 0 ? @"(?:(?:^|\s+)(" + jointext(to_join_on_whitespace_splits, "|") + @")(?:$|\s+))" : ""
	var/word_bounds = @"(\b(" + jointext(to_join_on_word_bounds, "|") + @")\b)"
	var/regex_filter = whitespace_split != "" ? "([whitespace_split]|[word_bounds])" : word_bounds
	return regex(regex_filter, "i")

/// Check to ensure that the jobconfig is valid/in-date.
/datum/controller/configuration/proc/validate_job_config()
	var/config_toml = "[directory]/jobconfig.toml"
	var/config_txt = "[directory]/jobs.txt"
	var/message = "服务器运维通知："
	log_config("正在验证配置文件 jobconfig.toml……")

	if(!fexists(file(config_toml)))
		SSjob.legacy_mode = TRUE
		message += "未找到 jobconfig.toml，正在回退到旧版模式（使用 jobs.txt）。要消除此警告，请在服务器选项卡中运行“生成职业配置”（Generate Job Configuration）指令以生成 jobconfig.toml。\n\
			然后将该文件放入服务器的 /config 文件夹，即可在后续回合中生效。"

		if(!fexists(file(config_txt)))
			message += "\n\n旧版模式设置失败：未找到 jobs.txt！将使用代码中的默认值。如果不想使用此系统，请注释掉 LOAD_JOBS_FROM_TXT 配置标志以将其禁用。"

		log_config(message)
		DelayedMessageAdmins(span_notice(message))
		return

	var/list/result = rustg_raw_read_toml_file(config_toml)
	if(!result["success"])
		message += "职业配置（jobconfig.toml）设置不正确！[result["content"]]"
		log_config(message)
		DelayedMessageAdmins(span_notice(message))

//Message admins when you can.
/datum/controller/configuration/proc/DelayedMessageAdmins(text)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(message_admins), text), 0)
