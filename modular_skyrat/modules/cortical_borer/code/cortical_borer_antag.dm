#define POP_PER_BORER 30

/proc/printborer(datum/mind/borer)
	var/list/text = list()
	var/mob/living/basic/cortical_borer/player_borer = borer.current
	if(!player_borer)
		text += span_redtext("[span_bold(borer.name)] 的躯体已被摧毁。")
		return text.Join("<br>")
	if(borer.current.stat != DEAD)
		text += "[span_bold(player_borer.name)] [span_greentext("存活")]"
	else
		text += "[span_bold(player_borer.name)] [span_redtext("死亡")]"
	text += span_bold("[span_bold(player_borer.name)] 产出了 [player_borer.children_produced] 只皮层钻虫。")
	var/list/string_of_genomes = list()

	for(var/evo_index in player_borer.past_evolutions)
		var/datum/borer_evolution/evolution = player_borer.past_evolutions[evo_index]
		string_of_genomes += evolution.name

	text += "[span_bold(player_borer.name)] 的进化如下：[english_list(string_of_genomes)]"
	return text.Join("<br>")

/proc/printborerlist(list/players,fleecheck)
	var/list/parts = list()

	parts += "<ul class='playerlist'>"
	for(var/datum/mind/M in players)
		parts += "<li>[printborer(M)]</li>"
	parts += "</ul>"
	return parts.Join("<br>")

/datum/antagonist/cortical_borer
	name = "皮层钻虫"
	pref_flag = ROLE_BORER
	show_in_antagpanel = TRUE
	roundend_category = "cortical borers"
	antagpanel_category = "Cortical Borers"
	show_to_ghosts = TRUE
	/// The team of borers
	var/datum/team/cortical_borers/borers

/datum/antagonist/cortical_borer/get_preview_icon()
	return finish_preview_icon(uni_icon('modular_skyrat/modules/cortical_borer/icons/animal.dmi', "brainslug"))

/datum/antagonist/cortical_borer/get_team()
	return borers

/datum/antagonist/cortical_borer/create_team(datum/team/cortical_borers/new_team)
	if(!new_team)
		for(var/datum/antagonist/cortical_borer/borer in GLOB.antagonists)
			if(!borer.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [borer]")
				continue
			if(borer.borers)
				borers = borer.borers
				return
		borers = new /datum/team/cortical_borers
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	borers = new_team

/datum/team/cortical_borers
	name = "\improper 皮层钻虫"

/datum/team/cortical_borers/roundend_report()
	var/list/parts = list()
	parts += span_header("以下是[name]：")
	parts += printborerlist(members)
	var/survival = FALSE
	for(var/mob/living/basic/cortical_borer/check_borer in GLOB.cortical_borers)
		if(check_borer.stat == DEAD)
			continue
		survival = TRUE
	if(survival)
		parts += span_greentext("皮层钻虫成功熬过了这个班次！")
	else
		parts += span_redtext("皮层钻虫没能熬过这个班次！")
	if(GLOB.successful_egg_number >= GLOB.objective_egg_borer_number)
		parts += span_greentext("皮层钻虫产出了足够的虫卵！")
	else
		parts += span_redtext("皮层钻虫没能产出足够的虫卵！")
	if(length(GLOB.willing_hosts) >= GLOB.objective_willing_hosts)
		parts += span_greentext("皮层钻虫召集到了足够的自愿宿主！")
	else
		parts += span_redtext("皮层钻虫没能召集到足够的自愿宿主！")
	if(GLOB.successful_blood_chem >= GLOB.objective_blood_borer)
		parts += span_greentext("皮层钻虫通过血液学会了足够的化学物质！")
	else
		parts += span_redtext("皮层钻虫没能通过血液学会足够的化学物质！")
	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/round_event_control/cortical_borer
	name = "皮层钻虫侵扰"
	typepath = /datum/round_event/ghost_role/cortical_borer
	weight = 10
	min_players = 999
	max_occurrences = 0 //should only ever happen once. If they were enabled, that is.
	category = EVENT_CATEGORY_ENTITIES
	description = "一只皮层钻虫出现在空间站上。它还会尝试产卵，并尝试召集自愿宿主、通过血液学习化学物质。"

/datum/round_event/ghost_role/cortical_borer
	announce_when = 400

/datum/round_event/ghost_role/cortical_borer/setup()
	announce_when = rand(announce_when, announce_when + 50)

/datum/round_event/ghost_role/cortical_borer/announce(fake)
	priority_announce("检测到不明生命体正在进入[station_name()]。请封锁所有外部通道，包括管道和通风系统。", "生命信号警报", ANNOUNCER_ALIENS)

/datum/round_event/ghost_role/cortical_borer/start()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/atmospherics/components/unary/vent_pump))
		if(QDELETED(temp_vent))
			continue
		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(!temp_vent_parent)
				continue // No parent vent
			// Stops Cortical Borers getting stuck in small networks.
			// See: Security, Virology
			if(length(temp_vent_parent.other_atmos_machines) > 20)
				vents += temp_vent
	if(!length(vents))
		return MAP_ERROR
	var/list/mob/dead/observer/candidates = SSpolling.poll_ghost_candidates(role = ROLE_BORER, check_jobban = ROLE_BORER, alert_pic = /mob/living/basic/cortical_borer, ignore_category = POLL_IGNORE_CORTICAL_BORER, role_name_text = "皮层钻虫")
	if(!length(candidates))
		return NOT_ENOUGH_PLAYERS
	var/living_number = max(length(GLOB.player_list) / POP_PER_BORER, 1)
	var/choosing_number = min(length(candidates), living_number)
	for(var/repeating_code in 1 to choosing_number)
		var/mob/dead/observer/new_borer = pick(candidates)
		candidates -= new_borer
		var/turf/vent_turf = get_turf(pick(vents))
		var/mob/living/basic/cortical_borer/spawned_cb = new /mob/living/basic/cortical_borer(vent_turf)
		spawned_cb.ckey = new_borer.ckey
		spawned_cb.mind.add_antag_datum(/datum/antagonist/cortical_borer)
		to_chat(spawned_cb, span_warning("你是一只皮层钻虫！你可以恐吓他人使其停止移动，但一定要寄宿他们！只有在宿主内部你才能成长、治疗和说话！"))
	for(var/mob/dead_mob in GLOB.dead_mob_list)
		to_chat(dead_mob, span_notice("皮层钻虫已经选定，你可以环绕观察它们！记住，它们能够繁殖！"))

/datum/dynamic_ruleset/midround/from_ghosts/cortical_borer
	name = "皮层钻虫侵扰"
	config_tag = "Midround Cortical Borer Infestation"
	preview_antag_datum = /datum/antagonist/cortical_borer
	midround_type = LIGHT_MIDROUND
	pref_flag = ROLE_BORER
	min_antag_cap = 1
	weight = 3
	min_pop = 20
	repeatable = TRUE

/datum/dynamic_ruleset/midround/from_ghosts/cortical_borer/create_ruleset_body()
	return new /mob/living/basic/cortical_borer

/datum/dynamic_ruleset/midround/from_ghosts/cortical_borer/create_execute_args()
	return list(find_vents())

/// Locate our vents to spawn in
/datum/dynamic_ruleset/midround/from_ghosts/cortical_borer/proc/find_vents()
	var/list/vents = list()
	var/list/vent_pumps = SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/atmospherics/components/unary/vent_pump)
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent as anything in vent_pumps)
		if(QDELETED(temp_vent))
			continue
		if(!is_station_level(temp_vent.loc.z) || temp_vent.welded)
			continue
		var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
		if(!temp_vent_parent)
			continue
		// Stops Borers getting stuck in small networks.
		// See: Security, Virology
		if(length(temp_vent_parent.other_atmos_machines) <= 20)
			continue
		vents += temp_vent
	return vents

/datum/dynamic_ruleset/midround/from_ghosts/cortical_borer/assign_role(datum/mind/candidate, list/vent_list)
	var/obj/vent = length(vent_list) >= 2 ? pick_n_take(vent_list) : vent_list[1]
	candidate.add_antag_datum(/datum/antagonist/cortical_borer)
	candidate.current.move_into_vent(vent)

#undef POP_PER_BORER
