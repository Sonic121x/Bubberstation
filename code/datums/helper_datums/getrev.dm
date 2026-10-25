/datum/getrev
	var/commit  // git rev-parse HEAD
	var/date
	var/originmastercommit  // git rev-parse origin/master
	var/list/testmerge = list()

/datum/getrev/New()
	commit = rustg_git_revparse("HEAD")
	if(commit)
		date = rustg_git_commit_date(commit)
	originmastercommit = rustg_git_revparse("origin/master")

/datum/getrev/proc/load_tgs_info()
	testmerge = world.TgsTestMerges()
	var/datum/tgs_revision_information/revinfo = world.TgsRevision()
	if(revinfo)
		commit = revinfo.commit
		originmastercommit = revinfo.origin_commit
		date = revinfo.timestamp || rustg_git_commit_date(commit)

	// goes to DD log and config_error.txt
	log_world(get_log_message())

/datum/getrev/proc/get_log_message()
	var/list/msg = list()
	msg += "Running /tg/ revision: [date]"
	if(originmastercommit)
		msg += "origin/master: [originmastercommit]"

	for(var/line in testmerge)
		var/datum/tgs_revision_information/test_merge/tm = line
		msg += "Test merge active of PR #[tm.number] commit [tm.head_commit]"
		SSblackbox.record_feedback("associative", "testmerged_prs", 1, list("number" = "[tm.number]", "commit" = "[tm.head_commit]", "title" = "[tm.title]", "author" = "[tm.author]"))

	if(commit && commit != originmastercommit)
		msg += "HEAD: [commit]"
	else if(!originmastercommit)
		msg += "No commit information"

	msg += "Running rust-g version [rustg_get_version()]"

	return msg.Join("\n")

/datum/getrev/proc/GetDatabaseCommitSha()
	. = originmastercommit
	if (commit == .)
		return .

	var/gh_url = CONFIG_GET(string/githuburl)
	if(!gh_url)
		return .

	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_GET, "[gh_url]/commit/[commit]", "", "")
	request.begin_async()
	UNTIL(request.is_complete())
	var/datum/http_response/response = request.into_response()

	if (response.status_code >= 200 && response.status_code < 300)
		return commit

	return .

/datum/getrev/proc/GetTestMergeInfo(header = TRUE)
	if(!testmerge.len)
		return ""
	. = header ? "当前测试合并了以下拉取请求：<br>" : ""
	for(var/line in testmerge)
		var/datum/tgs_revision_information/test_merge/tm = line
		var/cm = tm.head_commit
		var/details = "：“" + html_encode(tm.title) + "”，作者：" + html_encode(tm.author) + "，提交：" + html_encode(copytext_char(cm, 1, 11))
		. += "<a href=\"[CONFIG_GET(string/githuburl)]/pull/[tm.number]\">#[tm.number][details]</a><br>"

GAME_VERB_DESC(/client, showrevinfo, "查看服务器版本", "查看当前服务器的代码版本", "OOC")

	var/list/msg = list()
	// Round ID
	if(GLOB.round_id)
		msg += "<b>回合 ID：</b> [GLOB.round_id]"

	msg += "<b>BYOND 版本：</b> [world.byond_version].[world.byond_build]"
	if(DM_VERSION != world.byond_version || DM_BUILD != world.byond_build)
		msg += "<b>编译所用 BYOND 版本：</b> [DM_VERSION].[DM_BUILD]"

	// Revision information
	var/datum/getrev/revdata = GLOB.revdata
	msg += "<b>服务器版本编译日期：</b> [revdata.date]"
	var/pc = revdata.originmastercommit
	if(pc)
		msg += "<b>主分支提交：</b> <a href=\"[CONFIG_GET(string/githuburl)]/commit/[pc]\">[pc]</a>"
	if(length(revdata.testmerge))
		msg += revdata.GetTestMergeInfo()
	if(revdata.commit && revdata.commit != revdata.originmastercommit)
		msg += "<b>本地提交：</b> [revdata.commit]"
	else if(!pc)
		msg += "无提交信息"
	if(world.TgsAvailable())
		var/datum/tgs_version/version = world.TgsVersion()
		msg += "<b>TGS 版本</b>：[version.raw_parameter]"
		msg += "<b>DMAPI 版本</b>：[TGS_DMAPI_VERSION]"

	// Game mode odds
	msg += "<br><b>当前设置：</b>"
	msg += "<b>禁止管理职位成为叛徒：</b> [CONFIG_GET(flag/protect_roles_from_antagonist) ? "是" : "否"]"
	msg += "<b>禁止助理成为叛徒：</b> [CONFIG_GET(flag/protect_assistant_from_antagonist) ? "是" : "否"]"
	msg += "<b>强制由人类担任管理职位：</b> [CONFIG_GET(string/human_authority) ? "是" : "否"]"
	msg += "<b>允许迟到玩家成为反派：</b> [CONFIG_GET(flag/allow_latejoin_antagonists) ? "是" : "否"]"
	to_chat(src, fieldset_block("服务器版本信息", span_infoplain(jointext(msg, "<br>")), "boxed_message"), type = MESSAGE_TYPE_INFO)
