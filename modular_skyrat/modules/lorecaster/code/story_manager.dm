ADMIN_VERB(lorecaster_story_manager, R_ADMIN, "设定播报故事", "打开设定播报故事管理器。", ADMIN_CATEGORY_EVENTS)
	var/datum/story_manager_interface/ui = new(usr)
	ui.ui_interact(usr)


/datum/story_manager_interface
	/// A static list of archived stories, generated on New()
	var/static/list/archived_stories = list()
	/// A static list of current stories, generated on New()
	var/static/list/current_stories = list()


/datum/story_manager_interface/New()
	. = ..()
	if(!length(archived_stories))
		archived_stories = generate_stories(ARCHIVE_FILE)

	if(!length(current_stories))
		current_stories = generate_stories(NEWS_FILE)


/// Return a list of generated stories in a dict from a passed in file location
/datum/story_manager_interface/proc/generate_stories(file, return_id_dict = FALSE)
	RETURN_TYPE(/list)
	if(!fexists(file))
		return

	var/list/compiled_stories = list()
	var/list/uncompiled_stories = json_load(file)
	var/list/date_list = list()

	for(var/story in uncompiled_stories)
		date_list += (text2num(uncompiled_stories[story]["year"]) * 365) + (text2num(uncompiled_stories[story]["month"]) * 30) + text2num(uncompiled_stories[story]["day"])

		// the TGUI needs _all_ of these to work
		if(!("title" in uncompiled_stories[story]))
			uncompiled_stories[story]["title"] = "纳米传讯新闻播报"
		if(!("text" in uncompiled_stories[story]))
			uncompiled_stories[story]["text"] = "有人忘了填写这篇文章！"
		if(!("year" in uncompiled_stories[story]))
			uncompiled_stories[story]["year"] = "[CURRENT_STATION_YEAR]"
		if(!("month" in uncompiled_stories[story]))
			uncompiled_stories[story]["month"] = "[time2text(world.timeofday, "MM")]"
		if(!("day" in uncompiled_stories[story]))
			uncompiled_stories[story]["day"] = "[time2text(world.timeofday, "DD")]"
		if(!("id" in uncompiled_stories[story]))
			uncompiled_stories[story]["id"] = story

	sortTim(date_list, cmp=/proc/cmp_numeric_dsc)

	for(var/date in date_list)
		for(var/story in uncompiled_stories)
			if((text2num(uncompiled_stories[story]["year"]) * 365) + (text2num(uncompiled_stories[story]["month"]) * 30) + text2num(uncompiled_stories[story]["day"]) == date)
				if(return_id_dict)
					compiled_stories[uncompiled_stories[story]["id"]] = uncompiled_stories[story]
				else
					compiled_stories += list(uncompiled_stories[story])
				uncompiled_stories -= story

	return compiled_stories


/datum/story_manager_interface/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "StoryManager")
		ui.open()


/datum/story_manager_interface/ui_state(mob/user)
	return ADMIN_STATE(R_ADMIN)


/datum/story_manager_interface/ui_static_data(mob/user)
	var/list/data = list()

	data["archived_stories"] = archived_stories
	data["current_stories"] = current_stories
	data["current_date"] = "[time2text(world.timeofday, "MM")]/[time2text(world.timeofday, "DD")]/[CURRENT_STATION_YEAR]"

	return data


/datum/story_manager_interface/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!check_rights(R_ADMIN))
		return

	switch(action)
		if("publish_article")
			var/title = params["title"] || ""
			var/text = params["text"] || ""
			var/id = params["id"] || ""

			if(!id)
				return

			id = LOWER_TEXT(id)
			id = replacetext(id, @"\W", "_")

			if(id in current_stories)
				return

			if(id in archived_stories) // Even if we're only publishing this, it'll cause issues down the line, so let's block it anyway
				return

			var/list/current_story_copy = generate_stories(NEWS_FILE, TRUE)
			current_story_copy[id] = list(
				"title" = title,
				"text" = text,
				"year" = "[CURRENT_STATION_YEAR]",
				"month" = "[time2text(world.timeofday, "MM")]",
				"day" = "[time2text(world.timeofday, "DD")]",
				"id" = id,
			)

			rustg_file_write(json_encode(current_story_copy), NEWS_FILE)
			log_admin("[usr.ckey] 发布了 ID 为 [id] 的设定播报文章。")
			current_stories = generate_stories(NEWS_FILE)
			SSlorecaster.all_stories = current_stories.Copy()
			ui.send_full_update()

		if("archive_article")
			var/id = params["id"]
			if(!id)
				return

			if(!(id in generate_stories(NEWS_FILE, TRUE)))
				return

			var/list/current_story_copy = generate_stories(NEWS_FILE, TRUE)
			var/list/archive_story_copy = generate_stories(ARCHIVE_FILE, TRUE)

			archive_story_copy[id] = current_story_copy[id]
			current_story_copy -= id

			rustg_file_write(json_encode(current_story_copy), NEWS_FILE)
			rustg_file_write(json_encode(archive_story_copy), ARCHIVE_FILE)
			log_admin("[usr.ckey] 归档了 ID 为 [id] 的设定播报文章。")
			current_stories = generate_stories(NEWS_FILE)
			SSlorecaster.all_stories = current_stories.Copy()
			archived_stories = generate_stories(ARCHIVE_FILE)
			ui.send_full_update()

		if("circulate_article")
			var/id = params["id"]
			if(!id)
				return

			if(!(id in generate_stories(ARCHIVE_FILE, TRUE)))
				return

			var/list/current_story_copy = generate_stories(NEWS_FILE, TRUE)
			var/list/archive_story_copy = generate_stories(ARCHIVE_FILE, TRUE)

			current_story_copy[id] = archive_story_copy[id]
			archive_story_copy -= id

			rustg_file_write(json_encode(current_story_copy), NEWS_FILE)
			rustg_file_write(json_encode(archive_story_copy), ARCHIVE_FILE)
			log_admin("[usr.ckey] 重新发布了 ID 为 [id] 的已归档设定播报文章。")
			current_stories = generate_stories(NEWS_FILE)
			SSlorecaster.all_stories = current_stories.Copy()
			archived_stories = generate_stories(ARCHIVE_FILE)
			ui.send_full_update()

