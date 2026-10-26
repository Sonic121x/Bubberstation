/datum/heretic_knowledge/lycan_booster
	name = "兽化觉醒"
	desc = "献祭一颗心脏、一块肉排和一只死老鼠，大幅提升咒裔兽化形态的战斗能力，赋予其\
	强大的生命再生、极其锋利的利爪等能力。"
	gain_text = "光为寻求者赐下月神的祝福。"
	research_tree_icon_path = 'modular_skyrat/modules/implants/icons/razorclaws.dmi'
	research_tree_icon_state = "wolverine"
	drafting_tier = 4
	drafting_cost = 7
	required_atoms = list(/obj/item/organ/heart = 1, /obj/item/food/meat/slab = 1, /obj/item/food/deadmouse = 1)

/datum/heretic_knowledge/lycan_booster/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if (!.)
		return FALSE

	var/mob/living/carbon/human/found_human = locate() in range(loc, 1)
	if (!iscursekin(found_human))
		loc.balloon_alert(user, "目标必须是咒裔！")
		return FALSE
	return TRUE

/datum/heretic_knowledge/lycan_booster/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/mob/living/carbon/human/found_human = locate() in range(loc, 1)
	if (!iscursekin(found_human))
		loc.balloon_alert(user, "目标必须是咒裔！")
		return FALSE

	found_human.add_gaian_physique()
	return TRUE
