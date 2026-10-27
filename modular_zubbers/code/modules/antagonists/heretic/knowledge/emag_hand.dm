/datum/heretic_knowledge/emag_hand
	name = "铁匠之锤"
	desc = "献祭一把剪线钳和一颗钻石，强化你的漫宿之握，使其右键攻击能造成一次电磁破解效果。"
	gain_text = "铁匠既是创造者，也是毁灭者、腐化者。没有谁比祂更了解机械及其精妙之处。"
	required_atoms = list(
		/obj/item/wirecutters = 1,
		/obj/item/stack/sheet/mineral/diamond = 1,
	)
	drafting_tier = 1
	research_tree_icon_path = 'icons/obj/card.dmi'
	research_tree_icon_state = "emag"

/datum/heretic_knowledge/emag_hand/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if (HAS_TRAIT(user, TRAIT_EMAGGING_HAND))
		user.balloon_alert(user, "漫宿之握已强化！")
		return FALSE
	return TRUE

/datum/heretic_knowledge/emag_hand/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	ADD_TRAIT(user, TRAIT_EMAGGING_HAND, "emag_hand")
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY, PROC_REF(emag_on_mansus_grasp_secondary))
	to_chat(user, span_warning("你的下一次漫宿之握右键攻击会电磁破解命中的目标。"))
	return TRUE

/datum/heretic_knowledge/emag_hand/proc/emag_on_mansus_grasp_secondary(mob/living/source, atom/target)
	SIGNAL_HANDLER

	if (!target.emag_act(source))
		return

	REMOVE_TRAIT(source, TRAIT_EMAGGING_HAND, "emag_hand")
	UnregisterSignal(source, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY)
	to_chat(source, span_warning("铁匠挥锤击中了[target]。它屈从于你的意志，而你感到手中的力量逐渐消退……"))
