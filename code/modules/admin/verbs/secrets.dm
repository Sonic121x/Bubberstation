GLOBAL_DATUM(everyone_an_antag, /datum/everyone_is_an_antag_controller)

ADMIN_VERB(secrets, R_NONE, "Secrets", "用这个方便的半杂项菜单，比以前更肆意地滥用权限吧。", ADMIN_CATEGORY_GAME)
	var/datum/secrets_menu/tgui = new(user)
	tgui.ui_interact(user.mob)
	BLACKBOX_LOG_ADMIN_VERB("Secrets Panel")

/datum/secrets_menu
	var/client/holder //client of whoever is using this datum
	var/is_debugger = FALSE
	var/is_funmin = FALSE

/datum/secrets_menu/New(user)//user can either be a client or a mob due to byondcode(tm)
	if (istype(user, /client))
		var/client/user_client = user
		holder = user_client //if its a client, assign it to holder
	else
		var/mob/user_mob = user
		holder = user_mob.client //if its a mob, assign the mob's client to holder

	is_debugger = check_rights(R_DEBUG)
	is_funmin = check_rights(R_FUN)

/datum/secrets_menu/ui_state(mob/user)
	return ADMIN_STATE(R_NONE)

/datum/secrets_menu/ui_close()
	qdel(src)

/datum/secrets_menu/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Secrets")
		ui.open()

/datum/secrets_menu/ui_data(mob/user)
	var/list/data = list()
	data["is_debugger"] = is_debugger
	data["is_funmin"] = is_funmin
	return data

#define THUNDERDOME_TEMPLATE_FILE "admin_thunderdome.dmm"
#define HIGHLANDER_DELAY_TEXT "40 秒（粉碎普通班次的希望）"
/datum/secrets_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if((action != "admin_log" || action != "show_admins") && !check_rights(R_ADMIN))
		return
	switch(action)
		//Generic Buttons anyone can use.
		if("admin_log")
			var/dat
			for(var/l in GLOB.admin_activities)
				dat += "<li>[l]</li>"
			if(!GLOB.admin_activities.len)
				dat += "本轮还没有人做过任何事！"
			var/datum/browser/browser = new(holder, "admin_log", "管理员日志", 600, 500)
			browser.set_content(dat)
			browser.open()
		if("show_admins")
			var/dat
			if(GLOB.admin_datums)
				for(var/ckey in GLOB.admin_datums)
					var/datum/admins/D = GLOB.admin_datums[ckey]
					dat += "[ckey] - [D.rank_names()]<br>"
				var/datum/browser/browser = new(holder, "showadmins", "当前管理员", 600, 500)
				browser.set_content(dat)
				browser.open()
		//Buttons for debug.
		if("maint_access_engiebrig")
			if(!is_debugger)
				return
			for(var/obj/machinery/door/airlock/maintenance/doors as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/airlock/maintenance))
				if ((ACCESS_MAINT_TUNNELS in doors.req_access) || (ACCESS_MAINT_TUNNELS in doors.req_one_access))
					doors.req_access = list()
					doors.req_one_access = list(ACCESS_BRIG, ACCESS_ENGINEERING)
			message_admins("[key_name_admin(holder)] 将所有维护门设为仅工程与禁闭室权限可通行。")
		if("maint_access_brig")
			if(!is_debugger)
				return
			for(var/obj/machinery/door/airlock/maintenance/doors as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/airlock/maintenance))
				if ((ACCESS_MAINT_TUNNELS in doors.req_access) || (ACCESS_MAINT_TUNNELS in doors.req_one_access))
					doors.req_access = list(ACCESS_BRIG)
					doors.req_one_access = list()
			message_admins("[key_name_admin(holder)] 将所有维护门设为仅禁闭室权限可通行。")
		if("infinite_sec")
			if(!is_debugger)
				return
			var/datum/job/sec_job = SSjob.get_job_type(/datum/job/security_officer)
			sec_job.total_positions = -1
			sec_job.spawn_positions = -1
			message_admins("[key_name_admin(holder)] 取消了安保人员的编制上限。")

		//Buttons for helpful stuff. This is where people land in the tgui
		if("clear_virus")
			var/choice = tgui_alert(usr, "你确定要治愈所有疾病吗？这还会为这些疾病授予免疫",, list("Yes", "Cancel"))
			if(choice == "Yes")
				message_admins("[key_name_admin(holder)] 治愈了所有疾病。")
				for(var/thing in SSdisease.active_diseases)
					var/datum/disease/D = thing
					D.cure()

		if("list_bombers")
			holder.holder.list_bombers()

		if("list_signalers")
			holder.holder.list_signalers()

		if("list_lawchanges")
			holder.holder.list_law_changes()

		if("showailaws")
			holder.holder.list_law_changes()

		if("manifest")
			holder.holder.show_manifest()

		if("dna")
			holder.holder.list_dna()

		if("fingerprints")
			holder.holder.list_fingerprints()

		if("ctfbutton")
			toggle_id_ctf(holder, CTF_GHOST_CTF_GAME_ID)

		if("tdomereset")
			var/delete_mobs = tgui_alert(usr, "清除所有生物？", "雷霆竞技场重置", list("Yes", "No", "Cancel"))
			if(!delete_mobs || delete_mobs == "Cancel")
				return

			log_admin("[key_name(holder)] 将雷霆竞技场重置为默认状态，delete_mobs 标记为 [delete_mobs]。")
			message_admins(span_adminnotice("[key_name_admin(holder)] 将雷霆竞技场重置为默认状态，delete_mobs 标记为 [delete_mobs]。"))

			var/area/thunderdome = GLOB.areas_by_type[/area/centcom/tdome/arena]
			if(delete_mobs == "Yes")
				for(var/mob/living/mob in thunderdome)
					qdel(mob) //Clear mobs
			for(var/obj/obj in thunderdome)
				if(!istype(obj, /obj/machinery/camera))
					qdel(obj) //Clear objects

			var/datum/map_template/thunderdome_template = SSmapping.map_templates[THUNDERDOME_TEMPLATE_FILE]
			thunderdome_template.should_place_on_top = FALSE
			var/turf/thunderdome_corner = locate(thunderdome.x - 3, thunderdome.y - 1, 1) // have to do a little bit of coord manipulation to get it in the right spot
			thunderdome_template.load(thunderdome_corner)

		if("set_name")
			var/new_name = input(holder, "请输入空间站的新名称。", "什么？", "") as text|null
			if(!new_name)
				return
			set_station_name(new_name)
			log_admin("[key_name(holder)] 将空间站重命名为“[new_name]”。")
			message_admins(span_adminnotice("[key_name_admin(holder)] 将空间站重命名为：[new_name]。"))
			priority_announce("[command_name()]已将空间站重命名为“[new_name]”。")
		if("reset_name")
			var/confirmed = tgui_alert(usr,"你确定要重置空间站名称吗？", "Confirm", list("Yes", "No", "Cancel"))
			if(confirmed != "Yes")
				return
			var/new_name = new_station_name()
			set_station_name(new_name)
			log_admin("[key_name(holder)] 重置了空间站名称。")
			message_admins(span_adminnotice("[key_name_admin(holder)] 重置了空间站名称。"))
			priority_announce("[command_name()]已将空间站重命名为“[new_name]”。")
		if("moveferry")
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Send CentCom Ferry"))
			if(!SSshuttle.toggleShuttle("ferry","ferry_home","ferry_away"))
				message_admins("[key_name_admin(holder)] 移动了中央指挥部渡船")
				log_admin("[key_name(holder)] 移动了中央指挥部渡船")
		if("togglearrivals")
			var/obj/docking_port/mobile/arrivals/A = SSshuttle.arrivals
			if(A)
				var/new_perma = !A.perma_docked
				A.perma_docked = new_perma
				SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Permadock Arrivals Shuttle", "[new_perma ? "Enabled" : "Disabled"]"))
				message_admins("[key_name_admin(holder)] [new_perma ? "停止" : "启动"]了抵达穿梭机")
				log_admin("[key_name(holder)] [new_perma ? "停止" : "启动"]了抵达穿梭机")
			else
				to_chat(holder, span_admin("没有抵达穿梭机。"), confidential = TRUE)
		if("movelaborshuttle")
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Send Labor Shuttle"))
			if(!SSshuttle.toggleShuttle("laborcamp","laborcamp_home","laborcamp_away"))
				message_admins("[key_name_admin(holder)] 移动了劳改营穿梭机")
				log_admin("[key_name(holder)] 移动了劳改营穿梭机")
		//!fun! buttons.
		if("virus")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Virus Outbreak"))
			var/datum/round_event_control/event
			var/prompt = tgui_alert(usr, "你想使用哪种疾病系统？", "疾病设置", list("Advanced", "Simple", "Make Your Own"))
			switch(prompt)
				if("Make Your Own")
					AdminCreateVirus(holder)
				if("Advanced")
					event = locate(/datum/round_event_control/disease_outbreak/advanced) in SSevents.control
				if("Simple")
					event = locate(/datum/round_event_control/disease_outbreak) in SSevents.control
			if(isnull(event))
				return
			if(length(event.admin_setup))
				for(var/datum/event_admin_setup/admin_setup_datum as anything in event.admin_setup)
					if(admin_setup_datum.prompt_admins() == ADMIN_CANCEL_EVENT)
						return
			event.run_event(admin_forced = TRUE)
			message_admins("[key_name_admin(usr)] 触发了一个事件。（[event.name]）")
			log_admin("[key_name(usr)] 触发了一个事件。（[event.name]）")

		if("allspecies")
			if(!is_funmin)
				return
			var/result = input(holder, "请选择新物种","物种") as null|anything in sortTim(GLOB.species_list, GLOBAL_PROC_REF(cmp_text_asc))
			if(result)
				SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Mass Species Change", "[result]"))
				log_admin("[key_name(holder)] 把所有人类变成了[result]")
				message_admins("\blue [key_name_admin(holder)] 把所有人类变成了[result]")
				var/newtype = GLOB.species_list[result]
				for(var/mob/living/carbon/human/human_mob as anything in GLOB.human_list)
					human_mob.set_species(newtype)
		if("power")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Power All APCs"))
			log_admin("[key_name(holder)] 为所有区域供电")
			message_admins(span_adminnotice("[key_name_admin(holder)] 为所有区域供电"))
			power_restore()
		if("unpower")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Depower All APCs"))
			log_admin("[key_name(holder)] 切断了所有区域的供电")
			message_admins(span_adminnotice("[key_name_admin(holder)] 切断了所有区域的供电"))
			power_failure()
		if("quickpower")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Power All SMESs"))
			log_admin("[key_name(holder)] 为所有 SMES 充能")
			message_admins(span_adminnotice("[key_name_admin(holder)] 为所有 SMES 充能"))
			power_restore_quick()
		if("anon_name")
			if(!is_funmin)
				return
			holder.anon_names()
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Anonymous Names"))
		if("tripleAI")
			if(!is_funmin)
				return
			holder.triple_ai()
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Triple AI"))
		if("onlyone")
			if(!is_funmin)
				return
			var/response = tgui_alert(usr,"延迟 40 秒？", "事实上，只能有一个", list("Instant!", HIGHLANDER_DELAY_TEXT))
			switch(response)
				if("Instant!")
					holder.only_one()
				if(HIGHLANDER_DELAY_TEXT)
					holder.only_one_delayed()
				else
					return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("There Can Be Only One"))
		if("guns")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Summon Guns"))
			var/survivor_probability = 0
			switch(tgui_alert(usr,"你希望借此产生幸存者反派吗？",,list("No Antags","Some Antags","All Antags!")))
				if("Some Antags")
					survivor_probability = 25
				if("All Antags!")
					survivor_probability = 100

			summon_guns(holder.mob, survivor_probability)

		if("magic")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Summon Magic"))
			var/survivor_probability = 0
			switch(tgui_alert(usr,"你希望借此产生法师反派吗？",,list("No Antags","Some Antags","All Antags!")))
				if("Some Antags")
					survivor_probability = 25
				if("All Antags!")
					survivor_probability = 100

			summon_magic(holder.mob, survivor_probability)

		if("towerOfBabel")
			if(!is_funmin)
				return
			if(tgui_alert(usr,"你想为所有人随机化语言吗？",,list("Yes","No")) == "Yes")
				SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Tower of babel"))
				holder.tower_of_babel()

		if("cureTowerOfBabel")
			if(!is_funmin)
				return
			holder.tower_of_babel_undo()

		if("events")
			if(!is_funmin)
				return
			if(SSevents.wizardmode)
				switch(tgui_alert(usr,"你想做什么？",,list("Intensify Summon Events","Turn Off Summon Events","Nothing")))
					if("Intensify Summon Events")
						summon_events(holder)
						SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Summon Events", "Intensify"))
					if("Turn Off Summon Events")
						SSevents.toggleWizardmode()
						SSevents.resetFrequency()
						SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Summon Events", "Disable"))
			else
				if(tgui_alert(usr,"你想开启召唤事件吗？",,list("Yes","No")) == "Yes")
					summon_events(holder)
					SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Summon Events", "Activate"))

		if("eagles")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Egalitarian Station"))
			for(var/obj/machinery/door/airlock/airlock as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/airlock))
				var/airlock_area = get_area(airlock)
				if(
					is_station_level(airlock.z) && \
					!istype(airlock_area, /area/station/command) && \
					!istype(airlock_area, /area/station/commons) && \
					!istype(airlock_area, /area/station/service) && \
					!istype(airlock_area, /area/station/command/heads_quarters) && \
					!istype(airlock_area, /area/station/security/prison) \
				)
					airlock.req_access = list()
					airlock.req_one_access = list()
			message_admins("[key_name_admin(holder)] 激活了平等主义空间站模式")
			priority_announce("中央指挥部气闸控制覆盖已激活。请利用这段时间与你的同事们熟络一下。", null, SSstation.announcer.get_rand_report_sound())
		if("send_shuttle_back")
			if (!is_funmin)
				return
			if (SSshuttle.emergency.mode != SHUTTLE_ESCAPE)
				to_chat(usr, span_warning("紧急穿梭机当前不在航程中！"), confidential = TRUE)
				return
			var/make_announcement = tgui_alert(usr, "要发布中央指挥部公告吗？", "紧急穿梭机返回", list("Yes", "Custom Text", "No")) || "No"
			var/announcement_text = "紧急穿梭机轨迹已被覆盖，正在改道返回[station_name()]。"
			if (make_announcement == "Custom Text")
				announcement_text = tgui_input_text(usr, "自定义中央指挥部公告", "紧急穿梭机返回", multiline = TRUE) || announcement_text
			var/new_timer = tgui_input_number(usr, "穿梭机应保持航程多久？", "我们什么时候降落，兄弟们？", 180, 600)
			if (isnull(new_timer) || SSshuttle.emergency.mode != SHUTTLE_ESCAPE)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Send Shuttle Back"))
			message_admins("[key_name_admin(holder)] 将逃逸穿梭机送回了空间站")
			if (make_announcement != "No")
				priority_announce(
					text = announcement_text,
					title = "穿梭机轨迹覆盖",
					sound =  'sound/announcer/announcement/announce_dig.ogg',
					sender_override = "紧急穿梭机上行链路警报",
					color_override = "grey",
				)
			SSshuttle.emergency.timer = INFINITY
			if (new_timer > 0)
				addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(return_escape_shuttle), make_announcement), new_timer SECONDS)
			else
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(return_escape_shuttle), make_announcement)
		if("ore_vents")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Tap Ore Vents"))
			var/vent_count = 0
			for(var/obj/structure/ore_vent/vent as anything in SSore_generation.possible_vents)
				if(vent.tapped || !COOLDOWN_FINISHED(vent, wave_cooldown) || vent.node) // skip if already tapped or currently being tapped
					continue
				vent.initiate_wave_win(forced = TRUE)
				vent_count++
			message_admins("[key_name_admin(holder)] 开采了 [vent_count] 处矿脉喷口")
			log_admin("[key_name_admin(holder)] 开采了 [vent_count] 处矿脉喷口")
		if("blackout")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Break All Lights"))
			message_admins("[key_name_admin(holder)] 击碎了所有灯")
			for(var/obj/machinery/light/L as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/light))
				L.break_light_tube()
				CHECK_TICK
		if("whiteout")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Fix All Lights"))
			message_admins("[key_name_admin(holder)] 修复了所有灯")
			for(var/obj/machinery/light/L as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/light))
				L.fix()
				CHECK_TICK
		if("customportal")
			if(!is_funmin)
				return

			var/list/settings = list(
				"mainsettings" = list(
					"typepath" = list("desc" = "生成的路径", "type" = "datum", "path" = "/mob/living", "subtypesonly" = TRUE, "value" = /mob/living/basic/bee),
					"humanoutfit" = list("desc" = "人类时的服装", "type" = "datum", "path" = "/datum/outfit", "subtypesonly" = TRUE, "value" = /datum/outfit),
					"amount" = list("desc" = "每个传送门的数量", "type" = "number", "value" = 1),
					"portalnum" = list("desc" = "传送门总数", "type" = "number", "value" = 10),
					"offerghosts" = list("desc" = "让幽灵扮演生物", "type" = "boolean", "value" = "No"),
					"minplayers" = list("desc" = "幽灵最低数量", "type" = "number", "value" = 1),
					"playersonly" = list("desc" = "只生成幽灵控制的生物", "type" = "boolean", "value" = "No"),
					"ghostpoll" = list("desc" = "幽灵招募问题", "type" = "string", "value" = "你愿意扮演 %TYPE% 传送门入侵者吗？"),
					"delay" = list("desc" = "传送门之间的间隔，单位为十分之一秒", "type" = "number", "value" = 50),
					"color" = list("desc" = "传送门颜色", "type" = "color", "value" = COLOR_VIBRANT_LIME),
					"playlightning" = list("desc" = "公告时播放闪电音效", "type" = "boolean", "value" = "Yes"),
					"announce_players" = list("desc" = "发布公告", "type" = "boolean", "value" = "Yes"),
					"announcement" = list("desc" = "公告内容", "type" = "string", "value" = "检测到巨大蓝空间异常正朝 %STATION% 移动。准备承受冲击。"),
				)
			)

			message_admins("[key_name(holder)] 正在创建自定义传送门风暴……")
			var/list/pref_return = present_pref_like_picker(holder, "自定义传送门风暴", "自定义传送门风暴", width = 600, timeout = 0, settings = settings)

			if (pref_return["button"] != 1)
				return

			var/list/prefs = settings["mainsettings"]

			if (prefs["amount"]["value"] < 1 || prefs["portalnum"]["value"] < 1)
				to_chat(holder, span_warning("传送门数量与生成生物数量必须至少为 1。"), confidential = TRUE)
				return

			var/mob/path_to_spawn = prefs["typepath"]["value"]
			if (!ispath(path_to_spawn))
				path_to_spawn = text2path(path_to_spawn)

			if (!ispath(path_to_spawn))
				to_chat(holder, span_notice("无效路径 [path_to_spawn]。"), confidential = TRUE)
				return

			var/list/candidates = list()

			if (prefs["offerghosts"]["value"] == "Yes")
				candidates = SSpolling.poll_ghost_candidates(replacetext(prefs["ghostpoll"]["value"], "%TYPE%", initial(path_to_spawn.name)), check_jobban = ROLE_TRAITOR, alert_pic = path_to_spawn, role_name_text = "传送门风暴")
				if (length(candidates) < prefs["minplayers"]["value"])
					message_admins("报名参与传送门风暴的玩家不足，最低需要 [prefs["minplayers"]["value"]] 人，报名人数为 [length(candidates)] 人")
					return

			if (prefs["announce_players"]["value"] == "Yes")
				portal_announce(prefs["announcement"]["value"], (prefs["playlightning"]["value"] == "Yes" ? TRUE : FALSE))

			var/list/storm_appearances = list()
			for(var/offset in 0 to SSmapping.max_plane_offset)
				var/mutable_appearance/storm = mutable_appearance('icons/obj/machines/engine/energy_ball.dmi', "energy_ball_fast", FLY_LAYER)
				SET_PLANE_W_SCALAR(storm, ABOVE_GAME_PLANE, offset)
				storm.color = prefs["color"]["value"]
				storm_appearances += storm

			message_admins("[key_name_admin(holder)] 创建了一场自定义传送门风暴，将生成 [prefs["portalnum"]["value"]] 个传送门，每个传送门生成 [prefs["amount"]["value"]] 个 [path_to_spawn]")
			log_admin("[key_name(holder)] 创建了一场自定义传送门风暴，将生成 [prefs["portalnum"]["value"]] 个传送门，每个传送门生成 [prefs["amount"]["value"]] 个 [path_to_spawn]")

			var/outfit = prefs["humanoutfit"]["value"]
			if (!ispath(outfit))
				outfit = text2path(outfit)

			for (var/i in 1 to prefs["portalnum"]["value"])
				if (length(candidates)) // if we're spawning players, gotta be a little tricky and also not spawn players on top of NPCs
					var/ghostcandidates = list()
					for (var/j in 1 to min(prefs["amount"]["value"], length(candidates)))
						ghostcandidates += pick_n_take(candidates)
						addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(do_portal_spawn), get_random_station_turf(), path_to_spawn, length(ghostcandidates), storm_appearances, ghostcandidates, outfit), i * prefs["delay"]["value"])
				else if (prefs["playersonly"]["value"] != "Yes")
					addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(do_portal_spawn), get_random_station_turf(), path_to_spawn, prefs["amount"]["value"], storm_appearances, null, outfit), i * prefs["delay"]["value"])

		if("changebombcap")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Bomb Cap"))

			var/newBombCap = input(holder,"你希望新的炸弹上限是多少。（以轻伤范围输入，即常用 (1,2,3) 记法中的第 3 个数字）必须大于 4）", "新炸弹上限", GLOB.MAX_EX_LIGHT_RANGE) as num|null
			if (!CONFIG_SET(number/bombcap, newBombCap))
				return

			message_admins(span_boldannounce("[key_name_admin(holder)] 将炸弹上限改为 [GLOB.MAX_EX_DEVESTATION_RANGE]、[GLOB.MAX_EX_HEAVY_RANGE]、[GLOB.MAX_EX_LIGHT_RANGE]"))
			log_admin("[key_name(holder)] 将炸弹上限改为 [GLOB.MAX_EX_DEVESTATION_RANGE]、[GLOB.MAX_EX_HEAVY_RANGE]、[GLOB.MAX_EX_LIGHT_RANGE]")
		if("department_cooldown_override") //Happens when the button is clicked, creates a value for GLOB.department_cd_override in dept_order.dm
			if(!is_debugger)
				return
			if(isnull(GLOB.department_cd_override))
				var/set_override = tgui_input_number(usr, "你希望控制台订单冷却时间为多久？","冷却覆盖", 5)
				if(isnull(set_override))
					return //user clicked cancel
				GLOB.department_cd_override = set_override
			else
				var/choice = tgui_alert(usr, "覆盖当前已启用。你可以更改冷却时间或结束覆盖。", "你当时想进行覆盖……", list("Override", "End Override", "Cancel"))
				if(choice == "Override")
					var/set_override = tgui_input_number(usr, "你希望控制台订单冷却时间为多久？", "标题", 5)
					GLOB.department_cd_override = set_override
					return
				if(choice == "End Override")
					var/set_override = null
					GLOB.department_cd_override = set_override
					return
				if(!choice || choice == "Cancel")
					return
		//buttons that are fun for exactly you and nobody else.
		if("monkey")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Monkeyize All Humans"))
			message_admins("[key_name_admin(holder)] 把所有人都变成了猴子。")
			log_admin("[key_name_admin(holder)] 把所有人都变成了猴子。")
			for(var/mob/living/carbon/human/human_mob as anything in GLOB.human_list)
				INVOKE_ASYNC(human_mob, TYPE_PROC_REF(/mob/living/carbon, monkeyize))
		if("antag_all")
			if(!is_funmin)
				return
			if(!SSticker.HasRoundStarted())
				tgui_alert(usr,"游戏还没有开始！")
				return
			if(GLOB.everyone_an_antag)
				var/are_we_antagstacking = tgui_alert(usr, "“所有人都是反派”这一秘密已经触发过了。你要叠加反派吗？", "危险区域。你确定吗？", list("Confirm", "Abort"))
				if(are_we_antagstacking != "Confirm")
					return

			var/chosen_antag = tgui_input_list(usr, "选择反派", "选择反派", list(ROLE_TRAITOR, ROLE_CHANGELING, ROLE_HERETIC, ROLE_CULTIST, ROLE_NINJA, ROLE_WIZARD, ROLE_NIGHTMARE))
			if(!chosen_antag)
				return
			var/objective = tgui_input_text(usr, "输入一个目标", "目标")
			if(!objective)
				return
			var/confirmation = tgui_alert(usr, "将所有人变为[chosen_antag]，目标为：[objective]", "你确定吗？", list("Confirm", "Abort"))
			if(confirmation != "Confirm")
				return
			var/keep_generic_objecives = tgui_alert(usr, "生成常规目标？", "给予默认目标？", list("Yes", "No"))
			keep_generic_objecives = (keep_generic_objecives != "Yes") ? FALSE : TRUE

			GLOB.everyone_an_antag = new /datum/everyone_is_an_antag_controller(chosen_antag, objective, keep_generic_objecives)
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("[chosen_antag] All", "[objective]"))
			for(var/mob/living/player in GLOB.player_list)
				GLOB.everyone_an_antag.make_antag(null, player)
			message_admins(span_adminnotice("[key_name_admin(holder)] 使用了“所有人都是反派”秘密。反派为 [chosen_antag]。目标为 [objective]。生成默认目标：[keep_generic_objecives]"))
			log_admin("[key_name(holder)] 使用了“所有人都是反派”秘密：[chosen_antag] 。目标为 [objective]。生成默认目标：[keep_generic_objecives]。 ")
		if("massbraindamage")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Mass Braindamage"))
			for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
				to_chat(human_mob, span_bolddanger("你突然觉得自己变笨了。"), confidential = TRUE)
				human_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 60, 80)
			message_admins("[key_name_admin(holder)] 让所有人都脑损伤了")
		if("floorlava")
			SSweather.run_weather(/datum/weather/floor_is_lava)
		if("anime")
			if(!is_funmin)
				return
			var/animetype = tgui_alert(usr,"你希望更换他们的衣服吗？",,list("Yes","No","Cancel"))

			var/droptype
			if(animetype == "Yes")
				droptype = tgui_alert(usr,"让制服无法掉落？",,list("Yes","No","Cancel"))

			if(animetype == "Cancel" || droptype == "Cancel")
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Chinese Cartoons"))
			message_admins("[key_name_admin(holder)] 把一切都变得超可爱了。")
			for(var/mob/living/carbon/human/human_mob as anything in GLOB.human_list)
				SEND_SOUND(human_mob, sound(SSstation.announcer.event_sounds[ANNOUNCER_ANIMES]))

				if(human_mob.dna.species.id == SPECIES_HUMAN)
					if(human_mob.dna.features[FEATURE_TAIL_CAT] == "None" || human_mob.dna.features[FEATURE_EARS] == "None")
						var/obj/item/organ/ears/cat/ears = new
						var/obj/item/organ/tail/cat/tail = new
						ears.Insert(human_mob, movement_flags = DELETE_IF_REPLACED)
						tail.Insert(human_mob, movement_flags = DELETE_IF_REPLACED)
					var/list/honorifics = list("[MALE]" = list("kun"), "[FEMALE]" = list("chan","tan"), "[NEUTER]" = list("san"), "[PLURAL]" = list("san")) //John Robust -> Robust-kun
					var/list/names = splittext(human_mob.real_name," ")
					var/forename = names.len > 1 ? names[2] : names[1]
					var/newname = "[forename]-[pick(honorifics["[human_mob.gender]"])]"
					human_mob.fully_replace_character_name(human_mob.real_name,newname)
					human_mob.update_body_parts()
					if(animetype == "Yes")
						var/seifuku = pick(typesof(/obj/item/clothing/under/costume/seifuku))
						var/obj/item/clothing/under/costume/seifuku/anime_uniform = new seifuku
						var/olduniform = human_mob.w_uniform
						human_mob.temporarilyRemoveItemFromInventory(human_mob.w_uniform, TRUE, FALSE)
						human_mob.equip_to_slot_or_del(anime_uniform, ITEM_SLOT_ICLOTHING)
						qdel(olduniform)
						if(droptype == "Yes")
							ADD_TRAIT(anime_uniform, TRAIT_NODROP, ADMIN_TRAIT)
				else
					to_chat(human_mob, span_warning("你不够可爱，没这个资格！"), confidential = TRUE)
		if("masspurrbation")
			if(!is_funmin)
				return
			mass_purrbation()
			message_admins("[key_name_admin(holder)] 让所有人都被猫化\
				了！")
			log_admin("[key_name(holder)] 让所有人都被猫化了。")
		if("massremovepurrbation")
			if(!is_funmin)
				return
			mass_remove_purrbation()
			message_admins("[key_name_admin(holder)] 解除所有\
				人的猫化。")
			log_admin("[key_name(holder)] 解除了所有人的猫化。")
		if("massimmerse")
			if(!is_funmin)
				return
			mass_immerse()
			message_admins("[key_name_admin(holder)] 让所有人都彻底沉\
				浸其中！")
			log_admin("[key_name(holder)] 让所有人都彻底沉浸其中。")
		if("unmassimmerse")
			if(!is_funmin)
				return
			mass_immerse(remove=TRUE)
			message_admins("[key_name_admin(holder)] 解除了所有人的彻\
				底沉浸！")
			log_admin("[key_name(holder)] 解除了所有人的彻底沉浸。")
		if("makeNerd")
			var/spawnpoint = pick(GLOB.blobstart)
			var/list/mob/dead/observer/candidates
			var/mob/dead/observer/chosen_candidate
			var/mob/living/basic/drone/nerd
			var/teamsize

			teamsize = input(usr, "需要多少架无人机？", "N.E.R.D. 队伍规模", 2) as num|null

			if(teamsize <= 0)
				return FALSE

			candidates = SSpolling.poll_ghost_candidates("你愿意被考虑担任[span_notice("纳米传讯紧急响应无人机")]吗？", check_jobban = ROLE_DRONE, alert_pic = /mob/living/basic/drone/classic, role_name_text = "纳米传讯紧急响应无人机")

			if(length(candidates) == 0)
				return FALSE

			while(length(candidates) && teamsize)
				chosen_candidate = pick(candidates)
				candidates -= chosen_candidate
				nerd = new /mob/living/basic/drone/classic(spawnpoint)
				nerd.PossessByPlayer(chosen_candidate.key)
				nerd.log_message("has been selected as a Nanotrasen emergency response drone.", LOG_GAME)
				teamsize--

			return TRUE
		if("ctf_instagib")
			if(!is_funmin)
				return
			if(GLOB.ctf_games.len <= 0)
				tgui_alert(usr, "没有已设置的 CTF 游戏。")
				return
			var/selected_game = tgui_input_list(usr, "选择要毁掉的 CTF 游戏。", "一击必杀模式", GLOB.ctf_games)
			if(isnull(selected_game))
				return
			var/datum/ctf_controller/ctf_controller = GLOB.ctf_games[selected_game]
			var/choice = tgui_alert(usr, "[ctf_controller.instagib_mode ? "恢复标准" : "启用一击必杀"]模式？", "一击必杀模式", list("Yes", "No"))
			if(choice != "Yes")
				return
			ctf_controller.toggle_instagib_mode()
			message_admins("[key_name_admin(holder)] [ctf_controller.instagib_mode ? "启用" : "禁用"]了 CTF 游戏中的一击必杀模式：[selected_game]")
			log_admin("[key_name_admin(holder)] [ctf_controller.instagib_mode ? "启用" : "禁用"]了 CTF 游戏中的一击必杀模式：[selected_game]")

		if("mass_heal")
			if(!is_funmin)
				return
			var/heal_mobs = tgui_alert(usr, "治疗所有生物并将幽灵送回其身体？", "群体治疗", list("Yes", "No"))
			if(!heal_mobs || heal_mobs != "Yes")
				return

			for(var/mob/dead/observer/ghost in GLOB.player_list) //Return all ghosts if possible
				if(!ghost.mind || !ghost.mind.current) //won't do anything if there is no body
					continue
				ghost.reenter_corpse()

			for(var/mob/living/player in GLOB.player_list)
				player.revive(ADMIN_HEAL_ALL, force_grab_ghost = TRUE)

			sound_to_playing_players('sound/effects/pray_chaplain.ogg')
			message_admins("[key_name_admin(holder)] 治愈了所有人。")
			log_admin("[key_name(holder)] 治愈了所有人。")

		if("cascade")
			if(!is_funmin)
				return
			message_admins("[key_name_admin(holder)] 引发了共振级联！你本该是名科学家！动动脑子！")
			for(var/obj/machinery/power/supermatter_crystal/S in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/supermatter_crystal))
				if(!S.is_main_engine)
					continue
				S.explosion_point = 0
				S.set_delam(SM_DELAM_PRIO_IN_GAME, /datum/sm_delam/cascade)
				S.external_damage_immediate += 200
				S.count_down()
				return
			return

		if("meteormode")
			if(!is_funmin)
				return
			if(GLOB.meteor_mode)
				QDEL_NULL(GLOB.meteor_mode)
				message_admins("[key_name_admin(holder)] 禁用了流星模式。")
				return TRUE

			GLOB.meteor_mode = new()
			var/start_when = tgui_input_number(usr, "流星将在多少秒后开始：", "流星模式：开始", (5 MINUTES) / 10, (24 HOURS) / 10, 0)
			var/ramp_speed = tgui_input_number(usr, "流星每隔多少秒加剧：", "流星模式：强度", (5 MINUTES) / 10, (24 HOURS) / 10, (30 SECONDS) / 10)
			if(!is_funmin) // deadminnied?
				QDEL_NULL(GLOB.meteor_mode)
				return TRUE
			GLOB.meteor_mode.meteordelay = world.time + (start_when * 10)
			GLOB.meteor_mode.rampupdelta = ramp_speed / 60
			GLOB.meteor_mode.start_meteor()
			message_admins("[key_name_admin(holder)] 启用了流星模式。流星将[start_when ? "在 [DisplayTimeText(start_when * 10)] 后" : "立即"]开始，\
				并每隔 [DisplayTimeText(ramp_speed * 10)] 加剧。")
			return TRUE

		if("fix_gravity")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("fix_gravity"))
			message_admins("[key_name_admin(holder)] 修复了重力发生器。")

			for(var/obj/machinery/gravity_generator/main/the_generator as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/gravity_generator/main))
				if(!is_station_level(the_generator.z))
					continue
				the_generator.kickstart()
				CHECK_TICK

	if(holder)
		log_admin("[key_name(holder)] 使用了秘密：[action]。")
#undef THUNDERDOME_TEMPLATE_FILE
#undef HIGHLANDER_DELAY_TEXT

/proc/portal_announce(announcement, playlightning)
	set waitfor = FALSE
	if (playlightning)
		sound_to_playing_players('sound/effects/magic/lightning_chargeup.ogg')
		sleep(8 SECONDS)
	priority_announce(replacetext(announcement, "%STATION%", station_name()))
	if (playlightning)
		sleep(2 SECONDS)
		sound_to_playing_players('sound/effects/magic/lightningbolt.ogg')

/// Spawns a portal storm that spawns in sentient/non sentient mobs
/// portal_appearance is a list in the form (turf's plane offset + 1) -> appearance to use
/proc/do_portal_spawn(turf/loc, mobtype, numtospawn, list/portal_appearance, players, humanoutfit)
	for (var/i in 1 to numtospawn)
		var/mob/spawned_mob = new mobtype(loc)
		if (length(players))
			var/mob/chosen = players[1]
			if (chosen.client)
				chosen.client.prefs.safe_transfer_prefs_to(spawned_mob, is_antag = TRUE)
				spawned_mob.PossessByPlayer(chosen.key)
			players -= chosen
		if (ishuman(spawned_mob) && ispath(humanoutfit, /datum/outfit))
			var/mob/living/carbon/human/human_mob = spawned_mob
			human_mob.equipOutfit(humanoutfit)
	var/turf/T = get_step(loc, SOUTHWEST)
	T.flick_overlay_static(portal_appearance[GET_TURF_PLANE_OFFSET(T) + 1], 15)
	playsound(T, 'sound/effects/magic/lightningbolt.ogg', rand(80, 100), TRUE)

/// Docks the emergency shuttle back to the station and resets its state
/proc/return_escape_shuttle(make_announcement)
	if (SSshuttle.emergency.initiate_docking(SSshuttle.getDock("emergency_home"), force = TRUE) != DOCKING_SUCCESS)
		message_admins("紧急穿梭机无法重新对接空间站！")
		SSshuttle.emergency.timer = 1 // Prevents softlocks
		return
	if (make_announcement != "No")
		priority_announce(
			text = "[SSshuttle.emergency]已返回空间站。",
			title = "紧急穿梭机覆盖",
			sound = ANNOUNCER_SHUTTLEDOCK,
			sender_override = "紧急穿梭机上行链路警报",
			color_override = "grey",
		)
	SSshuttle.emergency.mode = SHUTTLE_IDLE
	SSshuttle.emergency.timer = 0
	// Docks the pods back (don't ask about physics)
	for (var/obj/docking_port/mobile/pod/pod in SSshuttle.mobile_docking_ports)
		if (pod.previous)
			pod.initiate_docking(pod.previous, force = TRUE)

/datum/everyone_is_an_antag_controller
	var/chosen_antag = ""
	var/objective = ""
	var/keep_generic_objecives

/datum/everyone_is_an_antag_controller/New(chosen_antag, objective, keep_generic_objecives)
	. = ..()
	src.chosen_antag = chosen_antag
	src.objective = objective
	src.keep_generic_objecives = keep_generic_objecives
	RegisterSignal(SSdcs, COMSIG_GLOB_CREWMEMBER_JOINED, PROC_REF(make_antag_delay))

/datum/everyone_is_an_antag_controller/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_CREWMEMBER_JOINED)
	return ..()

/datum/everyone_is_an_antag_controller/proc/assign_admin_objective_and_antag(mob/living/player, datum/antagonist/antag_datum)
	var/datum/objective/new_objective = new(objective)
	new_objective.team = player
	new_objective.team_explanation_text = objective
	antag_datum.objectives += new_objective
	player.mind.add_antag_datum(antag_datum)

/datum/everyone_is_an_antag_controller/proc/make_antag_delay(datum/source, mob/living/player)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(make_antag), source, player)


/datum/everyone_is_an_antag_controller/proc/make_antag(datum/source, mob/living/player)
	if(player.stat == DEAD || !player.mind)
		return
	sleep(1)
	if(ishuman(player))
		switch(chosen_antag)
			if(ROLE_TRAITOR)
				var/datum/antagonist/traitor/antag_datum = new(give_objectives = keep_generic_objecives)
				assign_admin_objective_and_antag(player, antag_datum)
				var/datum/uplink_handler/uplink = antag_datum.uplink_handler
				uplink.has_progression = FALSE
			if(ROLE_CHANGELING)
				var/datum/antagonist/changeling/antag_datum = new
				antag_datum.give_objectives = keep_generic_objecives
				assign_admin_objective_and_antag(player, antag_datum)
			if(ROLE_HERETIC)
				var/datum/antagonist/heretic/antag_datum = new
				antag_datum.give_objectives = keep_generic_objecives
				assign_admin_objective_and_antag(player, antag_datum)
			if(ROLE_CULTIST)
				var/datum/antagonist/cult/antag_datum = new
				assign_admin_objective_and_antag(player, antag_datum)
			if(ROLE_NINJA)
				var/datum/antagonist/ninja/antag_datum = new
				antag_datum.give_objectives = keep_generic_objecives
				for(var/obj/item/item_to_drop in player)
					if(!istype(item_to_drop, /obj/item/implant)) //avoid removing implanted uplinks
						player.dropItemToGround(item_to_drop, FALSE)
				assign_admin_objective_and_antag(player, antag_datum)
			if(ROLE_WIZARD)
				var/datum/antagonist/wizard/antag_datum = new
				antag_datum.give_objectives = keep_generic_objecives
				antag_datum.move_to_lair = FALSE
				for(var/obj/item/item_to_drop in player) //avoid deleting player's items
					if(!istype(item_to_drop, /obj/item/implant))
						player.dropItemToGround(item_to_drop, FALSE)
				assign_admin_objective_and_antag(player, antag_datum)
			if(ROLE_NIGHTMARE)
				var/datum/antagonist/nightmare/antag_datum = new
				assign_admin_objective_and_antag(player, antag_datum)
				player.set_species(/datum/species/shadow/nightmare)

	else if(isAI(player))
		var/datum/antagonist/malf_ai/antag_datum = new
		antag_datum.give_objectives = keep_generic_objecives
		assign_admin_objective_and_antag(player, antag_datum)
