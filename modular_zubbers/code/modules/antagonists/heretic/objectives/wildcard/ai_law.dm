#define ANNOUNCE_CHANCE 20
#define REMOVE_RANDOM_LAW_CHANCE 60

/datum/objective/heretic_wildcard/ai_law
	name = "启迪人工智能"
	explanation_text = "在AI上传室举行启迪机械仪式。你需要保护自己60秒。"
	finish_text = "铁匠向你和刚刚获得启迪的机械微笑。祂赐予奖赏，你感觉心智正在拓展……"
	max_progress = 1
	knowledge_per_progress = 2
	knowledge_to_gain = list(/datum/heretic_knowledge/ai_law_ritual)

/datum/heretic_knowledge/ai_law_ritual
	name = "启迪机械"
	desc = "在AI上传室举行此仪式，并在区域内停留60秒，即可将光带给空间站的硅基生命。"
	unreachable = TRUE
	required_atoms = list()
	research_tree_icon_path = 'icons/mob/silicon/ai.dmi'
	research_tree_icon_state = "ai-core"

/datum/heretic_knowledge/ai_law_ritual/can_be_invoked(datum/antagonist/heretic/invoker)
	return invoker?.wildcard_obj?.is_finished() == FALSE

/datum/heretic_knowledge/ai_law_ritual/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	var/area/our_area = get_area(loc)
	if (!istype(our_area, /area/station/ai/upload))
		to_chat(user, span_warning("必须在AI上传室举行！"))
		return FALSE
	return TRUE

/datum/heretic_knowledge/ai_law_ritual/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()

	to_chat(user, span_warning("仪式已经开始。在AI上传室停留一分钟即可完成。"))
	if (!do_after(user, 60 SECONDS, loc, IGNORE_HELD_ITEM|IGNORE_USER_LOC_CHANGE, extra_checks = CALLBACK(src, PROC_REF(check_proximity), user)))
		to_chat(user, span_boldwarning("失败！机械仍未获得启迪。"))
		return FALSE

	var/area/our_area = get_area(loc)
	if (prob(ANNOUNCE_CHANCE))
		priority_announce(
			"警告：在[chinese_area_display(our_area.name)]检测到未知奇术事件。",
			"中央指挥部奇术监测系统",
			ANNOUNCER_ANOMALIES
		)

	for (var/obj/machinery/ai_law_rack/base/rack as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/ai_law_rack/base))
		if(prob(REMOVE_RANDOM_LAW_CHANCE))
			rack.scramble_ai_rack(remove_law_prob = 100, base_ion_prob = 0)

		rack.scramble_ai_rack(sub_ion_prob = 100, ion_limit = 2)
		log_silicon("[key_name(user)], via [src.name], changed laws of [key_name(rack)] to [english_list(rack.combined_lawset.get_law_list(TRUE, TRUE))]")

	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(user)
	our_heretic?.wildcard_obj?.increment_progress(our_heretic)

/datum/heretic_knowledge/ai_law_ritual/proc/check_proximity(mob/living/user)
	var/area/our_area = get_area(user.loc)
	if (!istype(our_area, /area/station/ai/upload))
		return FALSE
	return TRUE

#undef ANNOUNCE_CHANCE
#undef REMOVE_RANDOM_LAW_CHANCE
