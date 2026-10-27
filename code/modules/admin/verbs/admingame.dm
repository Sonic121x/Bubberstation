ADMIN_VERB(cmd_player_panel, R_ADMIN, "Player Panel", "See all players and their Player Panel.", ADMIN_CATEGORY_GAME)
	user.holder.player_panel_new()

ADMIN_VERB_ONLY_CONTEXT_MENU(show_player_panel, R_ADMIN, "Show Player Panel", /mob)
	VERB_ARG_TYPED(player, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	log_admin("[key_name(user)] 查看了 [key_name(player)] 的个人玩家面板[isobserver(user.mob)?"":"（游戏中）"]。")

	if(!player)
		to_chat(user, span_warning("你似乎选择了一个已经不存在的生物。"), confidential = TRUE)
		return

	// BUBBER EDIT ADDITION START
	if(user.prefs.read_preference(/datum/preference/toggle/use_tgui_player_panel) && !GLOB.tgui_fallback_enabled)
		if(isnull(player.mob_panel))
			player.create_player_panel()
		player.mob_panel.ui_interact(user.mob)
		return
	// BUBBER EDIT ADDITION END

	var/body = "<html><head><meta name='color-scheme' content='light dark'><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>[player.key] 的选项</title></head>" // BUBBER EDIT CHANGE - Add meta color-scheme tag
	body += "<body><b>[player]</b> 的选项面板"
	body += "<style>.mute-disabled { color: light-dark(blue, lightblue) } .mute-enabled { color: red }</style>" // BUBBER EDIT ADDITION - Dark mode
	if(player.client)
		body += " 由 <b>[player.client]</b> 操控 "
		body += "\[<A href='byond://?_src_=holder;[HrefToken()];editrights=[(GLOB.admin_datums[player.client.ckey] || GLOB.deadmins[player.client.ckey]) ? "rank" : "add"];key=[player.key]'>[player.client.holder ? player.client.holder.rank_names() : "玩家"]</A>\]"
		if(CONFIG_GET(flag/use_exp_tracking))
			body += "\[<A href='byond://?_src_=holder;[HrefToken()];getplaytimewindow=[REF(player)]'>" + player.client.get_exp_living(FALSE) + "</a>\]"
			// BUBBERS EDIT START - Job exemption
			body += "<br>\[<a href='byond://?_src_=holder;[HrefToken()];getjobexemptwindow=[player.client.ckey]'>职位豁免菜单</a>\]"
			// BUBBERS EDIT END
	if(isnewplayer(player))
		body += " <B>尚未进入游戏</B> "
	else
		body += " \[<A href='byond://?_src_=holder;[HrefToken()];revive=[REF(player)]'>治疗</A>\] "

	if(player.ckey)
		body += "<br>\[<A href='byond://?_src_=holder;[HrefToken()];ppbyckey=[player.ckey];ppbyckeyorigmob=[REF(player)]'>查找更新后的面板</A>\]"

	if(player.client)
		body += "<br>\[<b>首次出现：</b> [player.client.player_join_date]\]"
		body += "<br>\[<b>Byond 账号注册于：</b> [player.client.account_join_date]\]"
		// SKYRAT EDIT ADDITION START - Player Ranks
		var/list/player_ranks = list()

		if(SSplayer_ranks.is_donator(player.client, admin_bypass = FALSE))
			player_ranks += "捐助者"

		if(SSplayer_ranks.is_mentor(player.client, admin_bypass = FALSE))
			player_ranks += "导师"
		//BUBBER ADDITION START
		if(SSplayer_ranks.is_vetted(player.client, admin_bypass = FALSE))
			player_ranks |= "已认证"
		// BUBBER ADDITION END
		body += "<br><br><b>玩家头衔： </b>[length(player_ranks) ? player_ranks.Join(", ") : "无"]"
		// SKYRAT EDIT END
		body += "<br><br><b>中央指挥部银河封禁数据库： </b> "
		if(CONFIG_GET(string/centcom_ban_db))
			body += "<a href='byond://?_src_=holder;[HrefToken()];centcomlookup=[player.client.ckey]'>搜索</a>"
		else
			body += "<i>已禁用</i>"
		body += "<br><br><b>按以下方式显示关联账号：</b> "
		body += "\[ <a href='byond://?_src_=holder;[HrefToken()];showrelatedacc=cid;client=[REF(player.client)]'>CID</a> | "
		body += "<a href='byond://?_src_=holder;[HrefToken()];showrelatedacc=ip;client=[REF(player.client)]'>IP</a> \]"
		var/full_version = "未知"
		if(player.client.byond_version)
			full_version = "[player.client.byond_version].[player.client.byond_build ? player.client.byond_build : "xxx"]"
		body += "<br>\[<b>Byond 版本：</b> [full_version]\]<br>"


	body += "<br><br>\[ "
	body += "<a href='byond://?_src_=vars;[HrefToken()];Vars=[REF(player)]'>VV</a> - "
	if(player.mind)
		body += "<a href='byond://?_src_=holder;[HrefToken()];traitor=[REF(player)]'>TP</a> - "
		body += "<a href='byond://?_src_=holder;[HrefToken()];skill=[REF(player)]'>SKILLS</a> - "
	else
		body += "<a href='byond://?_src_=holder;[HrefToken()];initmind=[REF(player)]'>初始化意识</a> - "
	if (iscyborg(player))
		body += "<a href='byond://?_src_=holder;[HrefToken()];borgpanel=[REF(player)]'>BP</a> - "
	body += "<a href='byond://?priv_msg=[player.ckey]'>PM</a> - "
	body += "<a href='byond://?_src_=holder;[HrefToken()];subtlemessage=[REF(player)]'>SM</a> - "
	if (ishuman(player) && player.mind)
		body += "<a href='byond://?_src_=holder;[HrefToken()];HeadsetMessage=[REF(player)]'>HM</a> - "
	body += "<a href='byond://?_src_=holder;[HrefToken()];adminplayerobservefollow=[REF(player)]'>FLW</a> - "
	//Default to client logs if available
	var/source = LOGSRC_MOB
	if(player.ckey)
		source = LOGSRC_CKEY
	body += "<a href='byond://?_src_=holder;[HrefToken()];individuallog=[REF(player)];log_src=[source]'>LOGS</a>\] <br>"

	body += "<b>生物类型</b> = [player.type]<br><br>"

	if(HAS_CONNECTED_PLAYER(player))
		body += "<b>曾用名：</b> "
		if(player.persistent_client)
			body += player.persistent_client.get_played_names()
		else
			body += "<i>没有？！</i>"
		body += "<br><br>"

	body += "<A href='byond://?_src_=holder;[HrefToken()];boot2=[REF(player)]'>踢出</A> | "
	if(player.client)
		body += "<A href='byond://?_src_=holder;[HrefToken()];newbankey=[player.key];newbanip=[player.client.address];newbancid=[player.client.computer_id]'>封禁</A> | "
	else
		body += "<A href='byond://?_src_=holder;[HrefToken()];newbankey=[player.key]'>封禁</A> | "

	body += "<A href='byond://?_src_=holder;[HrefToken()];showmessageckey=[player.ckey]'>备注 | 消息 | 关注列表</A> | "
	if(player.client)
		body += "| <A href='byond://?_src_=holder;[HrefToken()];sendtoprison=[REF(player)]'>监狱</A> | "
		body += "\ <A href='byond://?_src_=holder;[HrefToken()];sendbacktolobby=[REF(player)]'>送回大厅</A> | "
		var/muted = player.client.prefs.muted
		body += "<br><b>禁言： </b> "
		// BUBBER EDIT CHANGE BEGIN - remove <font> tag, add class attribute to a tags
		body += "\[<A href='byond://?_src_=holder;[HrefToken()];mute=[player.ckey];mute_type=[MUTE_IC]' class='[(muted & MUTE_IC)?"mute-enabled":"mute-disabled"]'>IC</a> | "
		body += "<A href='byond://?_src_=holder;[HrefToken()];mute=[player.ckey];mute_type=[MUTE_OOC]' class='[(muted & MUTE_OOC)?"mute-enabled":"mute-disabled"]'>OOC</a> | "
		body += "<A href='byond://?_src_=holder;[HrefToken()];mute=[player.ckey];mute_type=[MUTE_PRAY]' class='[(muted & MUTE_PRAY)?"mute-enabled":"mute-disabled"]'>PRAY</a> | "
		body += "<A href='byond://?_src_=holder;[HrefToken()];mute=[player.ckey];mute_type=[MUTE_ADMINHELP]' class='[(muted & MUTE_ADMINHELP)?"mute-enabled":"mute-disabled"]'>ADMINHELP</a> | "
		//Skyrat Addition Begin - LOOC muting again.
		body += "<A href='byond://?_src_=holder;[HrefToken()];mute=[player.ckey];mute_type=[MUTE_LOOC]' class='[(muted & MUTE_LOOC)?"mute-enabled":"mute-disabled"]'>LOOC</a> | "
		//Skyrat Addition End - LOOC muting again.
		body += "<A href='byond://?_src_=holder;[HrefToken()];mute=[player.ckey];mute_type=[MUTE_INTERNET_REQUEST]' class='[(muted & MUTE_INTERNET_REQUEST)?"mute-enabled":"mute-disabled"]'>WEBREQ</a> | "
		body += "<A href='byond://?_src_=holder;[HrefToken()];mute=[player.ckey];mute_type=[MUTE_DEADCHAT]' class='[(muted & MUTE_DEADCHAT)?"mute-enabled":"mute-disabled"]'>DEADCHAT</a>\]"
		body += "(<A href='byond://?_src_=holder;[HrefToken()];mute=[player.ckey];mute_type=[MUTE_ALL]' class='[(muted & MUTE_ALL)?"mute-enabled":"mute-disabled"]'>全部切换</a>)"
		// BUBBER EDIT CHANGE END

	body += "<br><br>"
	body += "<A href='byond://?_src_=holder;[HrefToken()];jumpto=[REF(player)]'><b>跳转至</b></A> | "
	body += "<A href='byond://?_src_=holder;[HrefToken()];getmob=[REF(player)]'>获取</A> | "
	body += "<A href='byond://?_src_=holder;[HrefToken()];sendmob=[REF(player)]'>送至</A>"

	body += "<br><br>"
	body += "<A href='byond://?_src_=holder;[HrefToken()];traitor=[REF(player)]'>叛徒面板</A> | "
	body += "<A href='byond://?_src_=holder;[HrefToken()];narrateto=[REF(player)]'>向其叙述</A> | "
	body += "<A href='byond://?_src_=holder;[HrefToken()];subtlemessage=[REF(player)]'>隐秘消息</A> | "
	body += "<A href='byond://?_src_=holder;[HrefToken()];playsoundto=[REF(player)]'>向其播放声音</A> | "
	body += "<A href='byond://?_src_=holder;[HrefToken()];languagemenu=[REF(player)]'>语言菜单</A> | "
	body += "<A href='byond://?_src_=holder;[HrefToken()];rpreminder=[REF(player)]'>角色扮演提醒</A>"

	if(player.client)
		if(!isnewplayer(player))
			body += "<br><br>"
			body += "<b>变形：</b><br>"
			if(isobserver(player))
				body += "<b>幽灵</b> | "
			else
				body += "<A href='byond://?_src_=holder;[HrefToken()];simplemake=observer;mob=[REF(player)]'>变成幽灵</A> | "

			if(ishuman(player) && !ismonkey(player))
				body += "<b>人类</b> | "
			else
				body += "<A href='byond://?_src_=holder;[HrefToken()];simplemake=human;mob=[REF(player)]'>变成人类</A> | "

			if(ismonkey(player))
				body += "<b>猴子</b> | "
			else
				body += "<A href='byond://?_src_=holder;[HrefToken()];simplemake=monkey;mob=[REF(player)]'>变成猴子</A> | "

			if(iscyborg(player))
				body += "<b>半机械人</b> | "
			else
				body += "<A href='byond://?_src_=holder;[HrefToken()];simplemake=robot;mob=[REF(player)]'>变成半机械人</A> | "

			if(isAI(player))
				body += "<b>AI</b>"
			else
				body += "<A href='byond://?_src_=holder;[HrefToken()];makeai=[REF(player)]'>变成 AI</A>"

		body += "<br><br>"
		body += "<b>其他操作：</b>"
		body += "<br>"
		if(!isnewplayer(player))
			body += "<A href='byond://?_src_=holder;[HrefToken()];forcespeech=[REF(player)]'>强制发言</A> | "
			body += "<A href='byond://?_src_=holder;[HrefToken()];applyquirks=[REF(player)]'>应用客户端特质</A> | "
			body += "<A href='byond://?_src_=holder;[HrefToken()];tdome1=[REF(player)]'>雷霆竞技场 1</A> | "
			body += "<A href='byond://?_src_=holder;[HrefToken()];tdome2=[REF(player)]'>雷霆竞技场 2</A> | "
			body += "<A href='byond://?_src_=holder;[HrefToken()];tdomeadmin=[REF(player)]'>雷霆竞技场管理员</A> | "
			body += "<A href='byond://?_src_=holder;[HrefToken()];tdomeobserve=[REF(player)]'>雷霆竞技场观察者</A> | "
		body += "<A href='byond://?_src_=holder;[HrefToken()];admincommend=[REF(player)]'>表彰行为</A> | "

	body += "<br>"
	body += "</body></html>"

	user << browse(body, "window=adminplayeropts-[REF(player)];size=550x540")
	BLACKBOX_LOG_ADMIN_VERB("Player Panel")

ADMIN_VERB_ONLY_CONTEXT_MENU(show_occupants_player_panel, R_ADMIN, "Show Occupants PP", /obj)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_OBJ, VERB_ARG_SOURCE_WORLD, /obj)
	var/list/options = list()

	// Vehicles
	if(istype(target, /obj/vehicle))
		var/obj/vehicle/target_vehicle = target
		if(istype(target_vehicle.occupants, /list) && target_vehicle.occupants.len)
			for(var/mob/mob_occupant in target_vehicle.occupants)
				options["[mob_occupant.name] ([mob_occupant.tag])[target_vehicle.is_driver(mob_occupant) ? " (驾驶员)" : ""]"] = "\ref[mob_occupant]"
		// Searching for mobs in exosuit equipment (e.g. seccage, sleepers)
		for(var/obj/item/mecha_parts/mecha_equipment/obj_contents in target.contents)
			for(var/mob/mob_in_equipment in obj_contents.contents)
				options["[mob_in_equipment.name] ([mob_in_equipment.tag])"] = "\ref[mob_in_equipment]"

	// Closets, crates, bodybags, coffins, etc.
	else if(istype(target, /obj/structure/closet))
		for(var/mob/mob_occupant in target.contents)
			options["[mob_occupant.name] ([mob_occupant.tag])"] = "\ref[mob_occupant]"
		// Searching for mobs in bodybags placed inside closet
		for(var/obj/structure/closet/obj_contents in target.contents)
			for(var/mob/mob_in_bodybag in obj_contents.contents)
				options["[mob_in_bodybag.name] ([mob_in_bodybag.tag])"] = "\ref[mob_in_bodybag]"
		// That's basically the same for folded bodybags (e.g. bluespace bodybags with mobs inside)
		for(var/obj/item/bodybag/obj_contents_folded in target.contents)
			for(var/mob/mob_in_bodybag_folded in obj_contents_folded.contents)
				options["[mob_in_bodybag_folded.name] ([mob_in_bodybag_folded.tag])"] = "\ref[mob_in_bodybag_folded]"

	// Folded bodybags (e.g. bluespace bodybags with mobs inside)
	else if(istype(target, /obj/item/bodybag))
		for(var/mob/mob_occupant in target.contents)
			options["[mob_occupant.name] ([mob_occupant.tag])"] = "\ref[mob_occupant]"

	// Body containers (morgue trays, crematoriums)
	else if(istype(target, /obj/structure/bodycontainer))
		for(var/mob/mob_occupant in target.contents)
			options["[mob_occupant.name] ([mob_occupant.tag])"] = "\ref[mob_occupant]"
		// Searching for mobs in bodybags placed inside body container
		for(var/obj/structure/closet/obj_contents in target.contents)
			for(var/mob/mob_in_bodybag in obj_contents.contents)
				options["[mob_in_bodybag.name] ([mob_in_bodybag.tag])"] = "\ref[mob_in_bodybag]"
		// That's basically the same for folded bodybags (e.g. bluespace bodybags with mobs inside)
		for(var/obj/item/bodybag/obj_contents_folded in target.contents)
			for(var/mob/mob_in_bodybag_folded in obj_contents_folded.contents)
				options["[mob_in_bodybag_folded.name] ([mob_in_bodybag_folded.tag])"] = "\ref[mob_in_bodybag_folded]"

	// Machinery
	else if(istype(target, /obj/machinery))
		for(var/mob/mob_occupant in target.contents)
			options["[mob_occupant.name] ([mob_occupant.tag])"] = "\ref[mob_occupant]"

	else
		tgui_alert(user,"不支持的对象类型！支持的类型：/obj/vehicle；/obj/structure/closet；/obj/structure/bodycontainer；/obj/machinery；/obj/item/bodybag。")
		return

	if(!options.len)
		tgui_alert(user, "未发现乘员！")
		return

	var/choice
	if(options.len == 1)
		choice = options[1]
	else
		choice = tgui_input_list(user, "选择生物", "玩家面板", options)

	if(choice)
		var/mob/selected_mob = locate(options[choice])
		if(selected_mob)
			SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/show_player_panel, selected_mob)
		return

GAME_VERB_PROC(/client, cmd_admin_godmode, "Godmode", "Admin.Game")
	VERB_ARG_TYPED(mob, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	if(!check_rights(R_ADMIN))
		return

	var/had_trait = HAS_TRAIT_FROM(mob, TRAIT_GODMODE, ADMIN_TRAIT)
	if(had_trait)
		REMOVE_TRAIT(mob, TRAIT_GODMODE, ADMIN_TRAIT)
	else
		ADD_TRAIT(mob, TRAIT_GODMODE, ADMIN_TRAIT)
	to_chat(usr, span_adminnotice("已切换为[had_trait ? "关闭" : "开启"]"), confidential = TRUE)

	log_admin("[key_name(usr)] 把 [key_name(mob)] 的无敌状态切换为[had_trait ? "关闭" : "开启"]")
	var/msg = "[key_name_admin(usr)] 把 [ADMIN_LOOKUPFLW(mob)] 的无敌状态切换为[had_trait ? "关闭" : "开启"]"
	message_admins(msg)
	admin_ticket_log(mob, msg)
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Godmode", "[had_trait ? "Disabled" : "Enabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

/*
If a guy was gibbed and you want to revive him, this is a good way to do so.
Works kind of like entering the game with a new character. Character receives a new mind if they didn't have one.
Traitors and the like can also be revived with the previous role mostly intact.
/N */
ADMIN_VERB(respawn_character, R_ADMIN, "Respawn Character", "Respawn a player that has been round removed in some manner. They must be a ghost.", ADMIN_CATEGORY_GAME)
	var/input = ckey(input(user, "请指定要重生哪个玩家的 key。", "Key", ""))
	if(!input)
		return

	var/mob/dead/observer/G_found
	for(var/mob/dead/observer/G in GLOB.player_list)
		if(G.ckey == input)
			G_found = G
			break

	if(!G_found)//If a ghost was not found.
		to_chat(user, "<font color='red'>游戏中没有该 key 的活跃玩家，或者此人当前不是幽灵。</font>", confidential = TRUE)
		return

	if(G_found.mind && !G_found.mind.active) //mind isn't currently in use by someone/something
		//check if they were a monkey
		if(findtext(G_found.real_name,"monkey"))
			if(tgui_alert(user,"这个角色似乎曾是一只猴子。你想按猴子的身份重生他们吗？",,list("Yes","No")) == "Yes")
				var/mob/living/carbon/human/species/monkey/new_monkey = new
				SSjob.send_to_late_join(new_monkey)
				G_found.mind.transfer_to(new_monkey) //be careful when doing stuff like this! I've already checked the mind isn't in use
				new_monkey.PossessByPlayer(G_found.key)
				to_chat(new_monkey, "你已被完整重生。祝你游戏愉快。", confidential = TRUE)
				var/msg = span_adminnotice("[key_name_admin(user)] 把 [new_monkey.key] 重生为一只肮脏的猴子。")
				message_admins(msg)
				admin_ticket_log(new_monkey, msg)
				return //all done. The ghost is auto-deleted


	//Ok, it's not a monkey. So, spawn a human.
	var/mob/living/carbon/human/new_character = new//The mob being spawned.
	SSjob.send_to_late_join(new_character)

	var/datum/record/locked/record_found //Referenced to later to either randomize or not randomize the character.
	if(G_found.mind && !G_found.mind.active) //mind isn't currently in use by someone/something
		record_found = find_record(G_found.name, locked_only = TRUE)

	if(record_found)//If they have a record we can determine a few things.
		new_character.real_name = record_found.name
		new_character.gender = record_found.gender
		new_character.age = record_found.age
		var/datum/dna/found_dna = record_found.locked_dna
		new_character.hardset_dna(found_dna.unique_identity, found_dna.mutation_index, null, record_found.name, record_found.blood_type, new record_found.species_type, found_dna.features)
	else
		new_character.randomize_human_appearance()
		new_character.dna.update_dna_identity()

	new_character.name = new_character.real_name

	if(G_found.mind && !G_found.mind.active)
		G_found.mind.transfer_to(new_character) //be careful when doing stuff like this! I've already checked the mind isn't in use
	else
		new_character.mind_initialize()
	if(is_unassigned_job(new_character.mind.assigned_role))
		new_character.mind.set_assigned_role(SSjob.get_job_type(SSjob.overflow_role))

	new_character.PossessByPlayer(G_found.key)

	/*
	The code below functions with the assumption that the mob is already a traitor if they have a special role.
	So all it does is re-equip the mob with powers and/or items. Or not, if they have no special role.
	If they don't have a mind, they obviously don't have a special role.
	*/

	//Two variables to properly announce later on.
	var/admin = key_name_admin(user)
	var/player_key = G_found.key

	//Now for special roles and equipment.
	var/datum/antagonist/traitor/traitordatum = new_character.mind.has_antag_datum(/datum/antagonist/traitor)
	if(traitordatum)
		SSjob.equip_rank(new_character, new_character.mind.assigned_role, new_character.client)
		new_character.mind.give_uplink(silent = TRUE, antag_datum = traitordatum)

	var/skip_job_respawn = FALSE
	for(var/datum/antagonist/antag as anything in new_character.mind.antag_datums)
		skip_job_respawn ||= antag.on_respawn(new_character)
		if(skip_job_respawn)
			break

	if(!skip_job_respawn)
		new_character.mind.assigned_role.on_respawn(new_character)

	//Announces the character on all the systems, based on the record.
	if(!record_found && (new_character.mind.assigned_role.job_flags & JOB_CREW_MEMBER))
		//Power to the user!
		if(tgui_alert(new_character,"警告：未检测到数据核心记录。你希望通过把此角色加入医疗记录等各种数据库来公告他的到来吗？",,list("No","Yes")) == "Yes")
			GLOB.manifest.inject(new_character, null, src)	// SKYRAT EDIT CHANGE - ALTERNATIVE_JOB_TITLES - Original: GLOB.manifest.inject(new_character)

		if(tgui_alert(new_character,"你希望由活跃的 AI 来公告此角色吗？",,list("No","Yes")) == "Yes")
			announce_arrival(new_character, new_character.mind.assigned_role.title)

	var/msg = span_adminnotice("[admin] 把 [player_key] 重生为 [new_character.real_name]。")
	message_admins(msg)
	admin_ticket_log(new_character, msg)

	to_chat(new_character, "你已被完整重生。祝你游戏愉快。", confidential = TRUE)

	BLACKBOX_LOG_ADMIN_VERB("Respawn Character")
	return new_character

ADMIN_VERB(manage_job_slots, R_ADMIN, "Manage Job Slots", "Manage the number of available job slots.", ADMIN_CATEGORY_GAME)
	user.holder.manage_free_slots()
	BLACKBOX_LOG_ADMIN_VERB("Manage Job Slots")

/datum/admins/proc/manage_free_slots()
	if(!check_rights())
		return
	var/datum/browser/browser = new(usr, "jobmanagement", "管理空余职位", 520)
	var/list/dat = list()
	var/count = 0

	if(!SSjob.initialized)
		tgui_alert(usr, "职位子系统初始化之前无法管理职位！")
		return

	if(SSlag_switch.measures[DISABLE_NON_OBSJOBS])
		dat += "<div class='notice red' style='font-size: 125%'>延迟开关“禁止非观察者延迟加入”已开启。只有观察者可以加入！</div>"

	dat += "<table>"

	for(var/datum/job/job as anything in SSjob.joinable_occupations)
		count++
		var/J_title = html_encode(job.title)
		var/J_opPos = html_encode(job.total_positions - (job.total_positions - job.current_positions))
		var/J_totPos = html_encode(job.total_positions)
		dat += "<tr><td>[J_title]:</td> <td>[J_opPos]/[job.total_positions < 0 ? " (无限)" : J_totPos]"

		dat += "</td>"
		dat += "<td>"
		if(job.total_positions >= 0)
			dat += "<A href='byond://?src=[REF(src)];[HrefToken()];customjobslot=[job.title]'>自定义</A> | "
			dat += "<A href='byond://?src=[REF(src)];[HrefToken()];addjobslot=[job.title]'>增加 1</A> | "
			if(job.total_positions > job.current_positions)
				dat += "<A href='byond://?src=[REF(src)];[HrefToken()];removejobslot=[job.title]'>移除</A> | "
			else
				dat += "移除 | "
			dat += "<A href='byond://?src=[REF(src)];[HrefToken()];unlimitjobslot=[job.title]'>取消上限</A></td>"
		else
			dat += "<A href='byond://?src=[REF(src)];[HrefToken()];limitjobslot=[job.title]'>设置上限</A></td>"

	browser.height = min(100 + count * 20, 650)
	browser.set_content(dat.Join())
	browser.open()

ADMIN_VERB(toggle_view_range, R_ADMIN, "Change View Range", "Switch between 1x and custom views.", ADMIN_CATEGORY_GAME)
	if(user.view_size.getView() == user.view_size.default)
		user.view_size.setTo(input(user, "选择视野范围：", "太棒了", 7) in list(1,2,3,4,5,6,7,8,9,10,11,12,13,14,37) - 7)
	else
		user.view_size.resetToDefault()

	log_admin("[key_name(user)] 把自己的视野范围改为 [user.view]。")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Change View Range", "[user.view]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

ADMIN_VERB(combo_hud, R_ADMIN, "Toggle Combo HUD", "Toggles the Admin Combo HUD.", ADMIN_CATEGORY_GAME)
	if(user.combo_hud_enabled)
		user.disable_combo_hud()
	else
		user.enable_combo_hud()

	to_chat(user, "你把自己的管理员组合 HUD 切换为[user.combo_hud_enabled ? "开启" : "关闭"]。", confidential = TRUE)
	message_admins("[key_name_admin(user)] 把自己的管理员组合 HUD 切换为[user.combo_hud_enabled ? "开启" : "关闭"]。")
	log_admin("[key_name(user)] 把自己的管理员组合 HUD 切换为[user.combo_hud_enabled ? "开启" : "关闭"]。")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Combo HUD", "[user.combo_hud_enabled ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

/// List of hud traits in the admin combo hud
#define ADMIN_HUDS list(TRAIT_SECURITY_HUD, TRAIT_MEDICAL_HUD, TRAIT_DIAGNOSTIC_HUD, TRAIT_BOT_PATH_HUD)

/client/proc/enable_combo_hud()
	if (combo_hud_enabled)
		return

	combo_hud_enabled = TRUE

	for (var/hudtrait in ADMIN_HUDS)
		ADD_TRAIT(mob, hudtrait, ADMIN_TRAIT)

	for (var/datum/atom_hud/alternate_appearance/basic/antagonist_hud/antag_hud in GLOB.active_alternate_appearances)
		antag_hud.show_to(mob)

	mob.lighting_cutoff = mob.default_lighting_cutoff()
	mob.update_sight()

/client/proc/disable_combo_hud()
	if (!combo_hud_enabled)
		return

	combo_hud_enabled = FALSE

	for (var/hudtrait in ADMIN_HUDS)
		REMOVE_TRAIT(mob, hudtrait, ADMIN_TRAIT)

	for (var/datum/atom_hud/alternate_appearance/basic/antagonist_hud/antag_hud in GLOB.active_alternate_appearances)
		antag_hud.hide_from(mob)

	mob.lighting_cutoff = mob.default_lighting_cutoff()
	mob.update_sight()

#undef ADMIN_HUDS

ADMIN_VERB(show_traitor_panel, R_ADMIN, "Show Traitor Panel", "Edit mobs's memory and role", ADMIN_CATEGORY_GAME)
	VERB_ARG_TYPED(target_mob, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	var/datum/mind/target_mind = target_mob.mind
	if(!target_mind)
		to_chat(user, "这个生物没有意识！", confidential = TRUE)
		return
	if(!istype(target_mob) && !istype(target_mind))
		to_chat(user, "此功能只能用于 /mob 和 /mind 类型的实例", confidential = TRUE)
		return
	target_mind.traitor_panel()
	BLACKBOX_LOG_ADMIN_VERB("Traitor Panel")

ADMIN_VERB(show_skill_panel, R_ADMIN, "Show Skill Panel", "Edit mobs's experience and skill levels", ADMIN_CATEGORY_GAME)
	VERB_ARG_TYPED(target_mob, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	var/datum/mind/target_mind
	if(istype(target_mob, /datum/mind))
		target_mind = target_mob
	else
		target_mind = target_mob.mind

	var/datum/skill_panel/SP = new(user, target_mind)
	SP.ui_interact(user.mob)

ADMIN_VERB(lag_switch_panel, R_ADMIN, "Show Lag Switches", "Display the controls for drastic lag mitigation.", ADMIN_CATEGORY_GAME)
	if(!SSlag_switch.initialized)
		to_chat(user, span_notice("延迟开关子系统尚未初始化。"))
		return
	var/list/dat = list("<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>延迟开关</title></head><body><h2><B>延迟（缓解）开关</B></h2>")
	dat += "自动触发： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch_option=TOGGLE_AUTO'><b>[SSlag_switch.auto_switch ? "开" : "关"]</b></a><br/>"
	dat += "人口阈值： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch_option=NUM'><b>[SSlag_switch.trigger_pop]</b></a><br/>"
	dat += "慢速模式冷却（在下方开启/关闭）： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch_option=SLOWCOOL'><b>[SSlag_switch.slowmode_cooldown/10] 秒</b></a><br/>"
	dat += "<br/><b>设置全部措施： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=ALL_ON'>开启</a> | <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=ALL_OFF'>关闭</a></b><br/>"
	dat += "<br/>禁用幽灵缩放与透视动词（工作人员除外）： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=[DISABLE_GHOST_ZOOM_TRAY]'><b>[SSlag_switch.measures[DISABLE_GHOST_ZOOM_TRAY] ? "开" : "关"]</b></a><br/>"
	dat += "禁止延迟加入： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=[DISABLE_NON_OBSJOBS]'><b>[SSlag_switch.measures[DISABLE_NON_OBSJOBS] ? "开" : "关"]</b></a><br/>"
	dat += "<br/>============！疯狂幽灵区！============<br/>"
	dat += "禁用死亡生物 keyLoop（工作人员除外，会通知死者聊天）： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=[DISABLE_DEAD_KEYLOOP]'><b>[SSlag_switch.measures[DISABLE_DEAD_KEYLOOP] ? "开" : "关"]</b></a><br/>"
	dat += "==========================================<br/>"
	dat += "<br/><b>以下措施可以被 <abbr title='TRAIT_BYPASS_MEASURES'><u>特殊特质</u></abbr> 绕过</b><br/>"
	dat += "慢速模式说话动词（会向全场通知）： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=[SLOWMODE_SAY]'><b>[SSlag_switch.measures[SLOWMODE_SAY] ? "开" : "关"]</b></a><br/>"
	dat += "禁用头顶聊天： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=[DISABLE_RUNECHAT]'><b>[SSlag_switch.measures[DISABLE_RUNECHAT] ? "开" : "关"]</b></a> - <span style='font-size:80%'>特质作用于说话者</span><br/>"
	dat += "禁用死亡头顶聊天： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=[DISABLE_DEAD_RUNECHAT]'><b>[SSlag_switch.measures[DISABLE_DEAD_RUNECHAT] ? "开" : "关"]</b></a> - <span style='font-size:80%'>特质作用于说话者</span><br/>"
	dat += "禁用检视图标： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=[DISABLE_USR_ICON2HTML]'><b>[SSlag_switch.measures[DISABLE_USR_ICON2HTML] ? "开" : "关"]</b></a> - <span style='font-size:80%'>特质作用于检视者</span><br/>"
	dat += "禁用视差： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=[DISABLE_PARALLAX]'><b>[SSlag_switch.measures[DISABLE_PARALLAX] ? "开" : "关"]</b></a> - <span style='font-size:80%'>特质作用于角色</span><br />"
	dat += "禁用脚步声： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=[DISABLE_FOOTSTEPS]'><b>[SSlag_switch.measures[DISABLE_FOOTSTEPS] ? "开" : "关"]</b></a> - <span style='font-size:80%'>特质作用于角色</span><br />"
	dat += "禁用角色创建器： <a href='byond://?_src_=holder;[HrefToken()];change_lag_switch=[DISABLE_CREATOR]'><b>[SSlag_switch.measures[DISABLE_CREATOR] ? "开" : "关"]</b></a> - <span style='font-size:80%'>特质作用于所有人</span><br />" // SKYRAT EDIT ADDITION
	dat += "</body></html>"
	user << browse(dat.Join(), "window=lag_switch_panel;size=420x480")

ADMIN_VERB(spawn_panel, R_SPAWN, "Spawn Panel", "Spawn Panel (TGUI).", ADMIN_CATEGORY_GAME)
	var/datum/spawnpanel/panel = user.holder.spawn_panel
	if(!panel)
		panel = new()
		user.holder.spawn_panel = panel
	panel.ui_interact(user.mob)
	BLACKBOX_LOG_ADMIN_VERB("Spawn Panel")
