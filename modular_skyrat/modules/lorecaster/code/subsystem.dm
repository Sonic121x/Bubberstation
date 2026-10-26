SUBSYSTEM_DEF(lorecaster)
	name = "设定播报"
	wait = 30 MINUTES
	/// List of all stories, that have run or not
	var/list/all_stories
	/// List of stories yet to have been run
	var/list/stories

/datum/controller/subsystem/lorecaster/Initialize()
	GLOB.news_network.create_feed_channel("纳米传讯新闻网", "NNN", "在此获取来自边区的最新故事！若想看并非最新的故事，现在就把“新闻档案”应用下载到任何基于 NTOS 的设备上！", locked = TRUE)
	var/config_delay = CONFIG_GET(number/lorecaster_delay)
	if(config_delay)
		wait = config_delay
	return SS_INIT_SUCCESS

/datum/controller/subsystem/lorecaster/fire(resumed)
	if(!fexists(NEWS_FILE))
		can_fire = FALSE
		return

	if(!length(all_stories)) // Ran out of stories? Run through 'em again
		all_stories = json_load(NEWS_FILE)

	if(!length(stories))
		stories = all_stories.Copy()
		return // But skip the cycle this time

	var/picked_story = pick(stories)
	var/text = stories[picked_story]["text"]
	var/title = stories[picked_story]["title"]
	text += "\n\n最初发布于：[stories[picked_story]["month"]]/[stories[picked_story]["day"]]/[stories[picked_story]["year"]]"
	GLOB.news_network.submit_article(text || "有人忘了填写这篇文章！", title || "纳米传讯新闻播报", "纳米传讯新闻网", null)
	stories -= picked_story
