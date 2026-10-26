#define POWERLESS_DURATION 10 MINUTES

// prevents the sm from generating power for x time - maybe a longer term effect too
/datum/objective/heretic_wildcard/supermatter
	name = "汲取超物质"
	explanation_text = "对空间站的超物质引擎举行收回光芒仪式。"
	knowledge_to_gain = list(/datum/heretic_knowledge/supermatter_ritual)
	finish_text = "守望女士为你收回光芒的功绩赐下恩惠。你感到心智正在拓展……"
	max_progress = 1
	knowledge_per_progress = 2

/datum/heretic_knowledge/supermatter_ritual
	name = "收回光芒"
	desc = "在超物质反应室内举行此仪式，完成你的第三项目标、获得知识点，并削弱超物质的发电能力10分钟。\
	此仪式耗时较长，且只能举行一次。"
	unreachable = TRUE
	required_atoms = list()
	research_tree_icon_path = 'icons/obj/machines/engine/supermatter.dmi'
	research_tree_icon_state = "sm"

/datum/heretic_knowledge/supermatter_ritual/can_be_invoked(datum/antagonist/heretic/invoker)
	return invoker?.wildcard_obj?.is_finished() == FALSE

/datum/heretic_knowledge/supermatter_ritual/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	for (var/obj/machinery/power/supermatter_crystal/iter_crys in range(1, loc))
		return TRUE
	to_chat(user, span_warning("失败！必须在超物质晶体下方举行此仪式。"))
	return FALSE

/datum/heretic_knowledge/supermatter_ritual/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()

	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(user)
	if (isnull(our_heretic))
		stack_trace("Somehow got no heretic on a SM ritual. [user]")
		return FALSE

	var/obj/machinery/power/supermatter_crystal/crys
	for (var/obj/machinery/power/supermatter_crystal/iter_crys in range(1, loc))
		crys = iter_crys
		break

	if (isnull(crys))
		return FALSE

	to_chat(user, span_warning("你开始举行仪式……"))
	if (!do_after(user, 20 SECONDS, crys, IGNORE_HELD_ITEM))
		to_chat(user, span_boldwarning("失败！仪式已中止。"))
		return FALSE

	crys.cursed = TRUE
	crys.update_appearance(UPDATE_OVERLAYS)
	addtimer(CALLBACK(crys, TYPE_PROC_REF(/obj/machinery/power/supermatter_crystal, clear_curse)), POWERLESS_DURATION)

	priority_announce(
		"超物质引擎内检测到奇术异常。观测到功率输出大幅下降——预计[POWERLESS_DURATION / 10]秒后恢复。",
		"中央指挥部奇术监测系统",
		'sound/machines/engine_alert/engine_alert3.ogg'
	)

	our_heretic.wildcard_obj?.increment_progress(our_heretic, crys)

/obj/machinery/power/supermatter_crystal
	/// If TRUE, 30% of the crystal's energy will be drained every tick. Used by a heretic ritual.
	var/cursed = FALSE

/obj/machinery/power/supermatter_crystal/proc/clear_curse()
	if (cursed)
		priority_announce("奇术异常已消散，晶体输出读数已恢复正常。", "异常已解除")

	cursed = FALSE
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/power/supermatter_crystal/update_overlays()
	. = ..()

	if (cursed)
		. += mutable_appearance('icons/mob/effects/heretic_aura.dmi', "heretic_aura")

/obj/machinery/power/supermatter_crystal/examine(mob/user)
	. = ..()

	if (cursed)
		. += span_boldwarning("这块超物质遭到了侍徒的诅咒。诅咒消退前，其功率输出将大幅降低。")

#undef POWERLESS_DURATION
