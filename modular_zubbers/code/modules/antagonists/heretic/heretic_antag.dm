#define OBJECTIVES_TO_WIN 2
#define MAX_INFLUENCE_DRAIN 8

/datum/antagonist/heretic
	name = "\improper Acolyte"
	roundend_category = "Acolytes"
	antagpanel_category = "Acolyte"
	knowledge_points = 15 + 1 // we always have to spend one to unlock a path
	unlimited_blades = TRUE
	passive_level = 0
	passive_gain_timer = 40 MINUTES // passive progression is VERY... SLOW...
	ui_name = "AntagInfoHereticV2"
	var/max_combat_capability = 100
	/// How many influences have we personally drained?
	var/drained_num = 0
	var/met_drained_num = FALSE
	var/datum/objective/open_ways/way_obj
	var/ways_opened = 0
	var/met_ways_num = FALSE

	var/can_craft_blades = FALSE
	var/mark_enabled = FALSE

	/// Will this heretic antag datum be added to the global reality smash tracker list?
	var/generate_influences = TRUE

	var/static/list/possible_wildcard_objs = list(
		/datum/objective/heretic_wildcard/sacrifice = 80,
		/datum/objective/heretic_wildcard/supermatter = 80,
		/datum/objective/heretic_wildcard/ai_law = 80,
		/datum/objective/heretic_wildcard/steal_money = 70,
	)
	var/datum/objective/heretic_wildcard/wildcard_obj

/datum/antagonist/heretic/on_gain()
	. = ..()

	var/mob/living/carbon/owner_carbon = owner.current
	if (!istype(owner_carbon))
		return
	if (has_living_heart() != HERETIC_HAS_LIVING_HEART)
		var/obj/item/organ/heart/our_heart = owner_carbon.get_organ_slot(ORGAN_SLOT_HEART)
		our_heart.AddComponent(/datum/component/living_heart) // even synths get one free go

	to_chat(owner_carbon, span_doyourjobidiot("侍徒与异教徒有很大不同。即便你是老玩家，也请重新阅读全部说明。"))

/datum/antagonist/heretic/forge_primary_objectives(heretic_research_tree)
	// total override
	for(var/datum/objective/pick_path/filler in objectives)
		filler.owner = null
		objectives -= filler
		qdel(filler)

	var/datum/objective/open_ways/way_obj = new()
	way_obj.owner = owner
	src.way_obj = way_obj
	objectives += way_obj

	var/datum/objective/heretic_wildcard/wildcard_type = pick_weight(possible_wildcard_objs)
	src.wildcard_obj = new wildcard_type()
	wildcard_obj.owner = owner
	wildcard_obj.apply_to(src)
	objectives += wildcard_obj

/datum/antagonist/heretic/proc/adjust_drained(adjustment)
	drained_num += adjustment
	if (!met_drained_num)
		adjust_knowledge_points(HERETIC_POINTS_PER_INFLUENCE) // TODO - consider if codex should give more. proooobably not. codex needs a new identity...
	if (drained_num >= MAX_INFLUENCE_DRAIN && !met_drained_num)
		met_drained_num = TRUE
		to_chat(owner, span_hypnophrase("世界的接缝已在你面前显露。你已登高！你已洞见！！"))
		to_chat(owner, span_warning("你无法再从影响中获得知识点。"))
		SEND_SOUND(owner.current, sound('sound/effects/magic/knock.ogg'))

/datum/antagonist/heretic/proc/adjust_ways_opened(adjustment)
	ways_opened += adjustment
	if (!way_obj)
		return
	if (!met_ways_num)
		adjust_knowledge_points(HERETIC_POINTS_PER_WAY)
	if (ways_opened >= way_obj.target_amount && !met_ways_num)
		met_ways_num = TRUE
		way_obj.completed = TRUE
		to_chat(owner, span_hypnophrase("光芒令你的心智目眩神迷！你亲眼所见的漫宿，已远超任何凡人所能梦及！！"))
		to_chat(owner, span_warning("目标已完成，你无法再通过开启通路获得知识点。"))
		SEND_SOUND(owner.current, sound('sound/effects/magic/knock.ogg'))
		// its important we only give heretics very limtied progression. while progression is nice, unchecked progression ruins the way nonantags interact with them

/datum/antagonist/heretic/proc/get_allocated_combat_points()
	var/total = 0
	for (var/datum/heretic_knowledge/knowledge as anything in researched_knowledge)
		total += knowledge::combat_specialty
	return total

/datum/antagonist/heretic/purchase_knowledge(datum/heretic_knowledge/knowledge_type, category, update)
	var/budget = max_combat_capability - get_allocated_combat_points()
	var/wanted = knowledge_type::combat_specialty
	if (wanted > budget)
		return FALSE

	return ..()

/datum/antagonist/heretic/get_knowledge_data(datum/heretic_knowledge/knowledge, list/source_list, done, category)
	. = ..()

	.["combat_specialty"] = knowledge.combat_specialty

/datum/antagonist/heretic/ui_data(mob/user)
	. = ..()

	.["combat_points"] = get_allocated_combat_points()
	.["influences_drained"] = drained_num
	.["ways_opened"] = ways_opened

/datum/antagonist/heretic/ui_static_data(mob/user)
	. = ..()

	.["win_amount"] = OBJECTIVES_TO_WIN

/datum/antagonist/heretic/should_show_aura()
	return FALSE // no aura thx

/datum/antagonist/heretic/roundend_report()
	var/list/parts = list()

	parts += printplayer(owner)
	parts += "<b>已汲取的影响：</b>[drained_num]"
	parts += "<b>已开启的通路：</b>[ways_opened]"
	var/completed = 0
	if(length(objectives))
		var/count = 1
		for(var/o in objectives)
			var/datum/objective/objective = o
			if(objective.check_completion())
				parts += "<b>目标 #[count]</b>：[objective.explanation_text] <span class='greentext'>成功！</b></span>"
				completed++
			else
				parts += "<b>目标 #[count]</b>：[objective.explanation_text] [span_redtext("失败。")]"
			count++
	parts += span_boldnotice("需要完成[OBJECTIVES_TO_WIN]个目标才能获胜……")
	if(completed >= min(OBJECTIVES_TO_WIN, objectives.len))
		parts += span_greentext("[heretic_path.route]侍徒成功了！")
	else
		parts += span_redtext("[heretic_path.route]侍徒失败了。")

	parts += "<b>已研究的知识：</b>"

	var/list/string_of_knowledge = list()

	for(var/knowledge_path in researched_knowledge)
		var/list/knowledge_info = researched_knowledge[knowledge_path]
		var/datum/heretic_knowledge/knowledge = knowledge_info[HKT_INSTANCE]
		string_of_knowledge += knowledge.name

	parts += english_list(string_of_knowledge)

	return parts.Join("<br>")

/datum/antagonist/heretic/proc/purge_shop_of_duplicates()
	for (var/iter_path in heretic_shops[HERETIC_KNOWLEDGE_SHOP])
		if (iter_path in researched_knowledge)
			heretic_shops[HERETIC_KNOWLEDGE_SHOP] -= iter_path

/datum/antagonist/heretic/event
	name = "Acolyte (No Influence Spawning)"

	generate_influences = FALSE

#undef OBJECTIVES_TO_WIN
#undef MAX_INFLUENCE_DRAIN
