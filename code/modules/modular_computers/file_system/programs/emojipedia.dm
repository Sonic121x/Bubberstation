/// A tablet app that lets anyone see all the valid emoji they can send via a PDA message (and even OOC!)
/datum/computer_file/program/emojipedia
	filename = "emojipedia"
	filedesc = "表情百科"
	downloader_category = PROGRAM_CATEGORY_DEVICE // we want everyone to be able to access this application, since everyone can send emoji via PDA messages
	program_open_overlay = "generic"
	extended_desc = "该程序可让你查看所有可通过 PDA 消息发送的表情。"
	size = 3
	tgui_id = "NtosEmojipedia"
	program_icon = "icons"
	/// Store the list of potential emojis here.
	var/static/list/emoji_list = icon_states(icon(EMOJI_SET))

/datum/computer_file/program/emojipedia/ui_static_data(mob_user)
	var/list/data = list()
	for(var/emoji in emoji_list)
		data["emoji_list"] += list(list(
			"name" = emoji,
		))

	return data

/datum/computer_file/program/emojipedia/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet_batched/emojipedia),
	)
