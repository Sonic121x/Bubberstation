//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
GAME_VERB_HIDDEN(/client, wiki, "wiki")

	var/wikiurl = CONFIG_GET(string/wikiurl)
	if(!wikiurl)
		to_chat(src, span_danger("服务器配置中未设置 Wiki URL。"))
		return

	var/query = tgui_input_text(src,
		"输入你想了解的内容。这将在你的网页浏览器中打开 Wiki；什么都不输入则前往主页。",
		"Wiki",
		max_length = MAX_MESSAGE_LEN,
	)
	if(isnull(query)) //cancelled out
		return
	var/output = wikiurl
	if(query != "")
		output += "?title=Special%3ASearch&profile=default&search=[query]"
	DIRECT_OUTPUT(src, link(output))

GAME_VERB_HIDDEN(/client, forum, "forum")

	var/forumurl = CONFIG_GET(string/forumurl)
	if(!forumurl)
		to_chat(src, span_danger("服务器配置中未设置论坛 URL。"))
		return
	DIRECT_OUTPUT(src, link(forumurl))

GAME_VERB_HIDDEN(/client, rules, "rules")

	var/rulesurl = CONFIG_GET(string/rulesurl)
	if(!rulesurl)
		to_chat(src, span_danger("服务器配置中未设置规则 URL。"))
		return
	DIRECT_OUTPUT(src, link(rulesurl))

GAME_VERB_HIDDEN(/client, github, "github")

	var/githuburl = CONFIG_GET(string/githuburl)
	if(!githuburl)
		to_chat(src, span_danger("服务器配置中未设置 Github URL。"))
		return
	DIRECT_OUTPUT(src, link(githuburl))

GAME_VERB_HIDDEN(/client, config, "config")

	var/configurl = CONFIG_GET(string/configurl)
	if(!configurl)
		to_chat(src, span_danger("服务器配置中未设置配置 URL。"))
		return
	DIRECT_OUTPUT(src, link(configurl))

GAME_VERB_DESC(/client, reportissue, "报告问题", "报告问题", null)

	var/githuburl = CONFIG_GET(string/githuburl)
	if(!githuburl)
		to_chat(src, span_danger("服务器配置中未设置 Github URL。"))
		return

	var/testmerge_data = GLOB.revdata.testmerge
	var/has_testmerge_data = (length(testmerge_data) != 0)

	var/message = "这将在你的浏览器中打开 Github 问题报告器。你确定吗？"
	if(has_testmerge_data)
		message += "<br>以下实验性更改当前处于启用状态，可能正是你遇到任何新问题或突发问题的原因。如有可能，请尽量为你的问题找到专门的讨论帖，而不是发到通用问题追踪器：<br>"
		message += GLOB.revdata.GetTestMergeInfo(FALSE)

	// We still use tg_alert here because some people were concerned that if someone wanted to report that tgui wasn't working
	// then the report issue button being tgui-based would be problematic.
	if(tg_alert(src, message, "报告问题", "Yes", "No") != "Yes")
		return

	var/base_link = githuburl + "/issues/new?template=bug_report_form.yml"
	var/list/concatable = list(base_link)

	var/client_version = "[byond_version].[byond_build]"
	concatable += ("&reporting-version=" + client_version)

	// the way it works is that we use the ID's that are baked into the template YML and replace them with values that we can collect in game.
	if(GLOB.round_id)
		concatable += ("&round-id=" + GLOB.round_id)

	// Insert testmerges
	if(has_testmerge_data)
		var/list/all_tms = list()
		for(var/entry in testmerge_data)
			var/datum/tgs_revision_information/test_merge/tm = entry
			all_tms += "- \[[tm.title]\]([githuburl]/pull/[tm.number])"
		var/all_tms_joined = jointext(all_tms, "\n")

		concatable += ("&test-merges=" + url_encode(all_tms_joined))

	DIRECT_OUTPUT(src, link(jointext(concatable, "")))

GAME_VERB(/client, changelog, "更新日志", "OOC")

	if(!GLOB.changelog_tgui)
		GLOB.changelog_tgui = new /datum/changelog()

	GLOB.changelog_tgui.ui_interact(mob)
	if(prefs.lastchangelog != GLOB.changelog_hash)
		prefs.lastchangelog = GLOB.changelog_hash
		prefs.save_preferences()

GAME_VERB_HIDDEN(/client, hotkeys_help, "Hotkeys Help")

	if(!GLOB.hotkeys_tgui)
		GLOB.hotkeys_tgui = new /datum/hotkeys_help()

	GLOB.hotkeys_tgui.ui_interact(mob)

GAME_VERB_HIDDEN(/client, emote_panel, "Emote Panel")

	if(!isliving(mob))
		to_chat(mob, span_notice("你只能在存活时使用此项！"))
		return

	if(!GLOB.emote_panel)
		GLOB.emote_panel = new /datum/emote_panel()
	GLOB.emote_panel.ui_interact(mob)
