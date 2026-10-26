/datum/heretic_knowledge/feast_of_owls
	is_starting_knowledge = FALSE
	abstract_type = /datum/heretic_knowledge/feast_of_owls

/datum/heretic_knowledge/spell/cloak_of_shadows
	is_starting_knowledge = FALSE
	drafting_tier = 1
	drafting_cost = 0.5

/datum/heretic_knowledge/enable_blades
	name = "镰剑锻造"
	desc = "让你能够制作所属道路的刀刃。这些刀刃坚实强劲、穿甲能力出色，但无法格挡，也不能用于传送。"
	gain_text = "藏匿的时日已经结束。光投下的阴影太过庞大——我已无处可藏。必须将他们的眼睛缝上。"
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "eldritch_blade"
	cost = 2

/datum/heretic_knowledge/enable_blades/can_be_invoked(datum/antagonist/heretic/invoker)
	return FALSE

/datum/heretic_knowledge/enable_blades/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	our_heretic.can_craft_blades = TRUE

/datum/heretic_knowledge/mansus_mark
	name = "漫宿印记"
	desc = "为漫宿之握启用所属道路的标记能力。印记是漫宿之握附加的次级能力，\
	当镰剑触发印记时，会对受害者造成各种效果。"
	gain_text = "漫宿在我身上留下了印记。我也将在他们身上留下印记。"
	research_tree_icon_path = 'icons/obj/weapons/hand.dmi'
	research_tree_icon_state = "mansus"
	cost = 2

/datum/heretic_knowledge/mansus_mark/can_be_invoked(datum/antagonist/heretic/invoker)
	return FALSE

/datum/heretic_knowledge/mansus_mark/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	our_heretic.mark_enabled = TRUE

/datum/heretic_knowledge/limited_amount/starting/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/heretic = GET_HERETIC(user)
	if (!istype(heretic))
		return FALSE

	if (!heretic.can_craft_blades)
		loc.balloon_alert(user, "尚未研究刀刃锻造！")
		return FALSE

	return ..()

/datum/heretic_knowledge/limited_amount/starting/proc/should_create_mark(mob/living/source, mob/living/target)
	var/datum/antagonist/heretic/heretic = GET_HERETIC(source)
	if (!istype(heretic))
		return FALSE

	return heretic.mark_enabled
