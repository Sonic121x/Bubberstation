/// If we spawn an ERT with the "choose experienced leader" option, select the leader from the top X playtimes
#define ERT_EXPERIENCED_LEADER_CHOOSE_TOP 3

///Dummy mob reserve slot for admin use
#define DUMMY_HUMAN_SLOT_ADMIN "admintools"

// CENTCOM RESPONSE TEAM

/datum/admins/proc/makeERTTemplateModified(list/settings)
	. = settings
	var/datum/ert/newtemplate = settings["mainsettings"]["template"]["value"]
	if (isnull(newtemplate))
		return
	if (!ispath(newtemplate))
		newtemplate = text2path(newtemplate)
	newtemplate = new newtemplate
	.["mainsettings"]["teamsize"]["value"] = newtemplate.teamsize
	.["mainsettings"]["mission"]["value"] = newtemplate.mission
	.["mainsettings"]["polldesc"]["value"] = newtemplate.polldesc
	.["mainsettings"]["open_armory"]["value"] = newtemplate.opendoors ? "Yes" : "No"
	.["mainsettings"]["leader_experience"]["value"] = newtemplate.leader_experience ? "Yes" : "No"
	.["mainsettings"]["random_names"]["value"] = newtemplate.random_names ? "Yes" : "No"
	.["mainsettings"]["spawn_admin"]["value"] = newtemplate.spawn_admin ? "Yes" : "No"
	.["mainsettings"]["use_custom_shuttle"]["value"] = newtemplate.use_custom_shuttle ? "Yes" : "No"


/datum/admins/proc/equipAntagOnDummy(mob/living/carbon/human/dummy/mannequin, datum/antagonist/antag)
	for(var/I in mannequin.get_equipped_items(INCLUDE_POCKETS))
		qdel(I)
	if (ispath(antag, /datum/antagonist/ert))
		var/datum/antagonist/ert/ert = antag
		mannequin.equipOutfit(initial(ert.outfit), TRUE)

/datum/admins/proc/makeERTPreviewIcon(list/settings)
	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_ADMIN)

	var/prefs = settings["mainsettings"]
	var/datum/ert/template = prefs["template"]["value"]
	if (isnull(template))
		return null
	if (!ispath(template))
		template = text2path(prefs["template"]["value"]) // new text2path ... doesn't compile in 511

	template = new template
	var/datum/antagonist/ert/ert = template.leader_role

	equipAntagOnDummy(mannequin, ert)

	CHECK_TICK
	var/icon/preview_icon = icon('icons/effects/effects.dmi', "nothing")
	preview_icon.Scale(48+32, 16+32)
	CHECK_TICK
	mannequin.setDir(NORTH)
	var/icon/stamp = getFlatIcon(mannequin)
	CHECK_TICK
	preview_icon.Blend(stamp, ICON_OVERLAY, 25, 17)
	CHECK_TICK
	mannequin.setDir(WEST)
	stamp = getFlatIcon(mannequin)
	CHECK_TICK
	preview_icon.Blend(stamp, ICON_OVERLAY, 1, 9)
	CHECK_TICK
	mannequin.setDir(SOUTH)
	stamp = getFlatIcon(mannequin)
	CHECK_TICK
	preview_icon.Blend(stamp, ICON_OVERLAY, 49, 1)
	CHECK_TICK
	preview_icon.Scale(preview_icon.Width() * 2, preview_icon.Height() * 2) // Scaling here to prevent blurring in the browser.
	CHECK_TICK
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_ADMIN)
	return preview_icon

/datum/admins/proc/make_emergency_response_team(datum/ert/ertemplate = null)
	if (ertemplate)
		ertemplate = new ertemplate
	else
		ertemplate = new /datum/ert/centcom_official

	var/human_authority_setting = CONFIG_GET(string/human_authority)

	var/list/settings = list(
		"preview_callback" = CALLBACK(src, PROC_REF(makeERTPreviewIcon)),
		"mainsettings" = list(
		"template" = list("desc" = "模板", "callback" = CALLBACK(src, PROC_REF(makeERTTemplateModified)), "type" = "datum", "path" = "/datum/ert", "subtypesonly" = TRUE, "value" = ertemplate.type),
		"teamsize" = list("desc" = "小队规模", "type" = "number", "value" = ertemplate.teamsize),
		"mission" = list("desc" = "任务", "type" = "string", "value" = ertemplate.mission),
		"polldesc" = list("desc" = "幽灵投票说明", "type" = "string", "value" = ertemplate.polldesc),
		"enforce_human" = list("desc" = "强制人类权限", "type" = "boolean", "value" = "[(human_authority_setting == HUMAN_AUTHORITY_ENFORCED ? "Yes" : "No")]"),
		"open_armory" = list("desc" = "打开军械库大门", "type" = "boolean", "value" = "[(ertemplate.opendoors ? "Yes" : "No")]"),
		"leader_experience" = list("desc" = "挑选有经验的队长", "type" = "boolean", "value" = "[(ertemplate.leader_experience ? "Yes" : "No")]"),
		"random_names" = list("desc" = "随机化姓名", "type" = "boolean", "value" = "[(ertemplate.random_names ? "Yes" : "No")]"),
		"spawn_admin" = list("desc" = "将你生成为简报官", "type" = "boolean", "value" = "[(ertemplate.spawn_admin ? "Yes" : "No")]"),
		"notify_players" = list("desc" = "通知玩家你已派出紧急响应小队", "type" = "boolean", "value" = "[(ertemplate.notify_players ? "Yes" : "No")]"), //SKYRAT EDIT ADDITION
		"use_custom_shuttle" = list("desc" = "使用紧急响应小队的自定义穿梭机（若有）", "type" = "boolean", "value" = "[(ertemplate.use_custom_shuttle ? "Yes" : "No")]"),
		"mob_type" = list("desc" = "基础种族", "callback" = CALLBACK(src, PROC_REF(makeERTTemplateModified)), "type" = "datum", "path" = "/mob/living/carbon/human", "subtypesonly" = TRUE, "value" = ertemplate.mob_type),
		)
	)

	var/list/pref_return = present_pref_like_picker(usr, "自定义紧急响应小队", "自定义紧急响应小队", width = 600, timeout = 0, settings = settings)

	if (isnull(pref_return) || pref_return["button"] != 1)
		message_admins("[key_name_admin(owner)]改变了主意，没有创建中央指挥部响应小队。")
		return FALSE

	var/list/prefs = settings["mainsettings"]

	var/templtype = prefs["template"]["value"]
	if (!ispath(prefs["template"]["value"]))
		templtype = text2path(prefs["template"]["value"]) // new text2path ... doesn't compile in 511

	if (ertemplate.type != templtype)
		ertemplate = new templtype

	ertemplate.teamsize = prefs["teamsize"]["value"]
	ertemplate.mission = prefs["mission"]["value"]
	ertemplate.polldesc = prefs["polldesc"]["value"]
	ertemplate.enforce_human = prefs["enforce_human"]["value"] == "Yes" // these next 6 are effectively toggles
	ertemplate.opendoors = prefs["open_armory"]["value"] == "Yes"
	ertemplate.leader_experience = prefs["leader_experience"]["value"] == "Yes"
	ertemplate.random_names = prefs["random_names"]["value"] == "Yes"
	ertemplate.spawn_admin = prefs["spawn_admin"]["value"] == "Yes"
	ertemplate.use_custom_shuttle = prefs["use_custom_shuttle"]["value"] == "Yes"
	ertemplate.mob_type = prefs["mob_type"]["value"]
	ertemplate.notify_players = prefs["notify_players"]["value"] == "Yes" //SKYRAT EDIT ADDITION

	var/list/spawn_points = GLOB.emergencyresponseteamspawn

	var/list/mob/dead/observer/candidates = SSpolling.poll_ghost_candidates("你希望被考虑加入[span_notice(ertemplate.polldesc)]吗？", check_jobban = "deathsquad", alert_pic = /obj/item/card/id/advanced/centcom/ert/commander, role_name_text = "紧急响应小队")

	if(!length(candidates))
		message_admins("[key_name_admin(owner)]尝试创建中央指挥部响应小队，但没有找到任何候选人。")
		return FALSE

	// This list will take priority over spawn_points if not empty
	var/list/spawn_turfs = list()

	// Takes precedence over spawn_points[1] if not null
	var/turf/brief_spawn

	if(ertemplate.use_custom_shuttle && ertemplate.ert_template)
		to_chat(usr, span_boldnotice("正在尝试生成紧急响应小队的自定义穿梭机，这可能需要几秒钟……"))
		var/datum/map_template/shuttle/ship = new ertemplate.ert_template
		var/x = rand(TRANSITIONEDGE, world.maxx - TRANSITIONEDGE - ship.width)
		var/y = rand(TRANSITIONEDGE, world.maxy - TRANSITIONEDGE - ship.height)
		var/z = SSmapping.empty_space.z_value
		var/turf/located_turf = locate(x, y, z)
		if(!located_turf)
			CRASH("紧急响应小队穿梭机找不到可加载的位置")

		if(!ship.load(located_turf))
			CRASH("加载紧急响应小队穿梭机失败！")

		var/list/shuttle_turfs = ship.get_affected_turfs(located_turf)

		for(var/turf/affected_turf as anything in shuttle_turfs)
			for(var/obj/effect/landmark/ert_shuttle_spawn/spawner in affected_turf)
				spawn_turfs += get_turf(spawner)

			if(!brief_spawn)
				brief_spawn = get_turf(locate(/obj/effect/landmark/ert_shuttle_brief_spawn) in affected_turf)

		if(!length(spawn_turfs))
			stack_trace("紧急响应小队穿梭机已加载，但未找到生成点，改为将小队放置在穿梭机内的任意位置。")

			for(var/turf/open/floor/open_turf in shuttle_turfs)
				if(!is_safe_turf(open_turf))
					continue
				spawn_turfs += open_turf


	if(ertemplate.spawn_admin)
		if(isobserver(usr))
			var/mob/living/carbon/human/admin_officer = new (brief_spawn || spawn_points[1])
			var/chosen_outfit = usr.client?.prefs?.read_preference(/datum/preference/choiced/brief_outfit)
			usr.client.prefs.safe_transfer_prefs_to(admin_officer, is_antag = TRUE)
			admin_officer.equipOutfit(chosen_outfit)
			admin_officer.PossessByPlayer(usr.key)

		else
			to_chat(usr, span_warning("你并非幽灵，无法将你作为简报官生成！"))

	//Pick the (un)lucky players
	var/numagents = min(ertemplate.teamsize, length(candidates))

	//Create team
	var/datum/team/ert/ert_team = new ertemplate.team()
	if(ertemplate.rename_team)
		ert_team.name = ertemplate.rename_team

	//Assign team objective
	var/datum/objective/missionobj = new ()
	missionobj.team = ert_team
	missionobj.explanation_text = ertemplate.mission
	missionobj.completed = TRUE
	ert_team.objectives += missionobj
	ert_team.mission = missionobj

	var/mob/dead/observer/earmarked_leader
	var/leader_spawned = FALSE // just in case the earmarked leader disconnects or becomes unavailable, we can try giving leader to the last guy to get chosen

	if(ertemplate.leader_experience)
		var/list/candidate_living_exps = list()
		for(var/i in candidates)
			var/mob/dead/observer/potential_leader = i
			candidate_living_exps[potential_leader] = potential_leader.client?.get_exp_living(TRUE)

		candidate_living_exps = sort_list(candidate_living_exps, cmp=/proc/cmp_numeric_dsc)
		if(candidate_living_exps.len > ERT_EXPERIENCED_LEADER_CHOOSE_TOP)
			candidate_living_exps.Cut(ERT_EXPERIENCED_LEADER_CHOOSE_TOP+1) // pick from the top ERT_EXPERIENCED_LEADER_CHOOSE_TOP contenders in playtime
		earmarked_leader = pick(candidate_living_exps)
	else
		earmarked_leader = pick(candidates)

	var/spawn_index = 0
	while(numagents && candidates.len)
		var/turf/spawnloc
		if(length(spawn_turfs))
			spawnloc = pick(spawn_turfs)
		else
			spawnloc = spawn_points[spawn_index+1]
			spawn_index = WRAP_UP(spawn_index, spawn_points.len)

		var/mob/dead/observer/chosen_candidate = earmarked_leader || pick(candidates) // this way we make sure that our leader gets chosen
		candidates -= chosen_candidate

		//Spawn the body
		var/mob/living/carbon/human/ert_operative
		if(ertemplate.mob_type)
			ert_operative = new ertemplate.mob_type(spawnloc)
		else
			ert_operative = new /mob/living/carbon/human(spawnloc)
			chosen_candidate.client.prefs.safe_transfer_prefs_to(ert_operative, is_antag = TRUE)
		ert_operative.PossessByPlayer(chosen_candidate.key)

		if(ertemplate.enforce_human || !(ert_operative.dna.species.changesource_flags & ERT_SPAWN))
			ert_operative.set_species(/datum/species/human)

		//Give antag datum
		var/datum/antagonist/ert/ert_antag

		if((chosen_candidate == earmarked_leader) || (numagents == 1 && !leader_spawned))
			ert_antag = new ertemplate.leader_role ()
			earmarked_leader = null
			leader_spawned = TRUE
		else
			ert_antag = ertemplate.roles[WRAP(numagents,1,length(ertemplate.roles) + 1)]
			ert_antag = new ert_antag ()
		ert_antag.random_names = ertemplate.random_names

		ert_operative.mind.add_antag_datum(ert_antag,ert_team)
		ert_operative.mind.set_assigned_role(SSjob.get_job_type(ert_antag.ert_job_path))

		//Logging and cleanup
		ert_operative.log_message("已被选为[ert_antag.name]。", LOG_GAME)
		numagents--

	//Open the Armory doors
	if(ertemplate.opendoors)
		for(var/obj/machinery/door/poddoor/ert/door as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/poddoor/ert))
			door.open()
			CHECK_TICK

	message_admins("[key_name_admin(owner)]创建了中央指挥部响应小队。")
	message_admins("[capitalize(ertemplate.polldesc)]已生成，任务：[ertemplate.mission]")
	// BUBBER EDIT ADDITION BEGIN
	if(ertemplate.notify_players)
		priority_announce("中央指挥部已回应你们对[chinese_ert_code_display(ertemplate.code)]级紧急响应小队的请求，并确认小队正在赶来。", "紧急响应小队请求", ANNOUNCER_ERTYES)
		// shitcode begin!
		if(istype(ertemplate, /datum/ert/deathsquad))
			SSsecurity_level.set_level(SEC_LEVEL_EPSILON)
	// BUBBER EDIT ADDITION END

	return TRUE

ADMIN_VERB(summon_ert, R_FUN, "召唤紧急响应小队", "召唤一支紧急响应小队。", ADMIN_CATEGORY_FUN)
	message_admins("[key_name_admin(user)]正在创建中央指挥部响应小队……")
	if(user.holder?.make_emergency_response_team())
		log_admin("[key_name(user)]创建了中央指挥部响应小队。")
	else
		log_admin("[key_name(user)]创建中央指挥部响应小队失败。")

#undef ERT_EXPERIENCED_LEADER_CHOOSE_TOP
#undef DUMMY_HUMAN_SLOT_ADMIN
