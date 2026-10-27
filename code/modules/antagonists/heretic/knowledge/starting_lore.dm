// Heretic starting knowledge.

/// Global list of all heretic knowledge that have is_starting_knowledge = TRUE. List of PATHS.
GLOBAL_LIST_INIT(heretic_start_knowledge, initialize_starting_knowledge())

/**
 * Returns a list of all heretic knowledge TYPEPATHS
 * that have route set to PATH_START.
 */
/proc/initialize_starting_knowledge()
	. = list()
	for(var/datum/heretic_knowledge/knowledge as anything in subtypesof(/datum/heretic_knowledge))
		if(initial(knowledge.is_starting_knowledge) == TRUE)
			. += knowledge

/*
 * The base heretic knowledge. Grants the Mansus Grasp spell.
 */
/datum/heretic_knowledge/spell/basic
	name = "破晓"
	desc = "开启你踏入漫宿的旅程。<br>\
		赋予你漫宿之握，一个强大且可升级的制服法术。"
	action_to_add = /datum/action/cooldown/spell/touch/mansus_grasp
	cost = 0
	is_starting_knowledge = TRUE
	max_charges = 8
	focus_recharge_amount = 0.25
	holywater_drain_amount = 0.125
	transmute_text = "汲取影响力并完成献祭将为该法术充能。"

// Heretics can enhance their fishing rods to fish better - fishing content.
// Lasts until successfully fishing something up.
/datum/heretic_knowledge/spell/basic/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(user, COMSIG_TOUCH_HANDLESS_CAST, PROC_REF(on_grasp_cast))
	RegisterSignal(our_heretic, COMSIG_HERETIC_INFLUENCE_DRAINED, PROC_REF(on_influence_tap))
	RegisterSignal(our_heretic, COMSIG_HERETIC_SACRIFICE, PROC_REF(on_sacrifice))

/datum/heretic_knowledge/spell/basic/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_TOUCH_HANDLESS_CAST)
	UnregisterSignal(our_heretic, COMSIG_HERETIC_INFLUENCE_DRAINED)
	UnregisterSignal(our_heretic, COMSIG_HERETIC_SACRIFICE)

/datum/heretic_knowledge/spell/basic/proc/on_grasp_cast(mob/living/carbon/cast_on, datum/action/cooldown/spell/touch/touch_spell)
	SIGNAL_HANDLER

	// Not a grasp, we dont want this to activate with say star or mending touch.
	if(!istype(touch_spell, action_to_add))
		return NONE

	var/obj/item/fishing_rod/held_rod = cast_on.get_active_held_item()
	if(!istype(held_rod, /obj/item/fishing_rod) || HAS_TRAIT(held_rod, TRAIT_ROD_MANSUS_INFUSED))
		return NONE

	INVOKE_ASYNC(cast_on, TYPE_PROC_REF(/atom/movable, say), message = "R'CH T'H F'SH!", forced = "fishing rod infusion invocation")
	playsound(cast_on, /datum/action/cooldown/spell/touch/mansus_grasp::sound, 15)
	cast_on.visible_message(span_notice("[cast_on]在[held_rod]旁打了个响指，一阵紫色火焰将其包裹！"))

	ADD_TRAIT(held_rod, TRAIT_ROD_MANSUS_INFUSED, REF(held_rod))
	held_rod.difficulty_modifier -= 20
	RegisterSignal(held_rod, COMSIG_FISHING_ROD_CAUGHT_FISH, PROC_REF(unfuse))
	held_rod.add_filter("mansus_infusion", 2, list("type" = "outline", "color" = COLOR_VOID_PURPLE, "size" = 1))
	return COMPONENT_CAST_HANDLESS

/datum/heretic_knowledge/spell/basic/proc/unfuse(obj/item/fishing_rod/item, reward, mob/user)
	if(reward == FISHING_INFLUENCE || prob(35))
		item.remove_filter("mansus_infusion")
		REMOVE_TRAIT(item, TRAIT_ROD_MANSUS_INFUSED, REF(item))
		item.difficulty_modifier += 20

/datum/heretic_knowledge/spell/basic/proc/on_influence_tap(...)
	SIGNAL_HANDLER
	add_charges(max_charges)

/datum/heretic_knowledge/spell/basic/proc/on_sacrifice(...)
	SIGNAL_HANDLER
	add_charges(max_charges)

/**
 * The Living Heart heretic knowledge.
 *
 * Gives the heretic a living heart.
 * Also includes a ritual to turn their heart into a living heart.
 */
/datum/heretic_knowledge/living_heart
	name = "活体心脏"
	desc = "赋予你一颗活体心脏，让你能够追踪献祭目标。"
	transmute_text = "若你失去了心脏，可以用一朵罂粟花、一滩血迹\
		和一些等离子体嬗变，将你的心脏唤醒为活体心脏。" // BUBBER EDIT
	required_atoms = list(
		/obj/effect/decal/cleanable/blood = 1,
		/obj/item/food/grown/flower/poppy = 1,
		/obj/item/stack/sheet/mineral/plasma = 1, // BUBBER EDIT ADDITION - you cant get a new heart in perma
	)
	cost = 0
	priority = MAX_KNOWLEDGE_PRIORITY - 1 // Knowing how to remake your heart is important
	is_starting_knowledge = TRUE
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "living_heart"
	research_tree_icon_frame = 1
	notice = "如果你的心脏是机械心脏，你将无法将其唤醒。"

/datum/heretic_knowledge/living_heart/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	var/obj/item/organ/where_to_put_our_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	// Our heart slot is not valid to put a heart
	if(!is_valid_heart(where_to_put_our_heart))
		where_to_put_our_heart = null

	// If a heretic is made from a species without a heart, we need to find a backup.
	if(!where_to_put_our_heart)
		var/static/list/backup_organs = list(
			ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
			ORGAN_SLOT_LIVER = /obj/item/organ/liver,
			ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		)

		for(var/backup_slot in backup_organs)
			var/obj/item/organ/look_for_backup = user.get_organ_slot(backup_slot)
			// This backup slot is not a valid slot to put a heart
			if(!is_valid_heart(look_for_backup))
				continue

			// We found a replacement place to put our heart
			where_to_put_our_heart = look_for_backup
			our_heretic.living_heart_organ_slot = backup_slot
			to_chat(user, span_boldnotice("由于你的种族没有心脏，你的活体心脏位于你的[look_for_backup.name]中。"))
			break

	if(where_to_put_our_heart)
		where_to_put_our_heart.AddComponent(/datum/component/living_heart)
		desc = "赋予你一颗与你的[where_to_put_our_heart.name]相连的活体心脏，让你能够追踪献祭目标。"
		transmute_text = "若你失去了你的[where_to_put_our_heart.name]，可以用一朵罂粟花和一滩血迹 \
			嬗变，将你的[where_to_put_our_heart.name]唤醒为活体心脏。 \
			机械的[where_to_put_our_heart.name]会阻断仪式！"

	else
		to_chat(user, span_boldnotice("你没有心脏，也没有任何胸腔器官。因此你没能获得活体心脏。"))

/datum/heretic_knowledge/living_heart/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	var/obj/item/organ/our_living_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	if(our_living_heart)
		qdel(our_living_heart.GetComponent(/datum/component/living_heart))

// Don't bother letting them invoke this ritual if they have a Living Heart already in their chest
/datum/heretic_knowledge/living_heart/can_be_invoked(datum/antagonist/heretic/invoker)
	if(invoker.has_living_heart() == HERETIC_HAS_LIVING_HEART)
		return FALSE
	return TRUE

/datum/heretic_knowledge/living_heart/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(user)
	var/obj/item/organ/our_living_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	// No heart, nothing to give living heart to
	if(QDELETED(our_living_heart))
		loc.balloon_alert(user, "仪式失败，没有[our_heretic.living_heart_organ_slot]！")
		return FALSE

	// For sanity's sake, check if they've got a living heart -
	// even though it's not invokable if you already have one,
	// they may have gained one unexpectantly in between now and then
	if(HAS_TRAIT(our_living_heart, TRAIT_LIVING_HEART))
		loc.balloon_alert(user, "仪式失败，已经拥有活体心脏！")
		return FALSE

	// By this point they are making a new heart
	// If their current heart is organic / not synthetic, we can continue the ritual as normal
	if(is_valid_heart(our_living_heart))
		return TRUE

	loc.balloon_alert(user, "仪式失败，[our_heretic.living_heart_organ_slot]无法被唤醒！") // "heart can't be awakened!"
	return FALSE

/datum/heretic_knowledge/living_heart/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(user)
	var/obj/item/organ/our_new_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	// Don't delete our shiny new heart
	selected_atoms -= our_new_heart
	// Make it the living heart
	our_new_heart.AddComponent(/datum/component/living_heart)
	to_chat(user, span_warning("你感觉你的[our_new_heart.name]在苏醒时跳动得越来越快！"))
	playsound(user, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
	return TRUE

/// Checks if the passed heart is a valid heart to become a living heart
/datum/heretic_knowledge/living_heart/proc/is_valid_heart(obj/item/organ/new_heart)
	if(QDELETED(new_heart))
		return FALSE
	if(new_heart.organ_flags & (ORGAN_UNUSABLE|ORGAN_ROBOTIC|ORGAN_FAILING))
		return FALSE

	return TRUE

/datum/heretic_knowledge/feast_of_owls
	name = "猫头鹰之宴"
	desc = "允许你进行一场仪式，获得五点知识，但会失去升格资格。"
	gain_text = "在非理性的柔光之下，有一头野兽在夜色中潜行。我将把它召来，让它进入我的面前。它将以我的野心为食，并在身后留下知识。"
	is_starting_knowledge = TRUE
	required_atoms = list()
	research_tree_icon_path = 'icons/mob/actions/actions_animal.dmi'
	research_tree_icon_state = "god_transmit"
	notice = "此仪式只能进行一次，且无法撤销。"
	/// amount of research points granted
	var/reward = 5

/datum/heretic_knowledge/feast_of_owls/can_be_invoked(datum/antagonist/heretic/invoker)
	return !invoker.feast_of_owls

/datum/heretic_knowledge/feast_of_owls/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/alert = tgui_alert(user,"你真的想放弃你的升格吗？此操作无法撤销。", "猫头鹰之宴", list("Yes I'm sure", "No"), 30 SECONDS)
	if(alert != "Yes I'm sure" || QDELETED(user) || QDELETED(src) || get_dist(user, loc) > 2)
		return FALSE
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	if(QDELETED(heretic_datum) || heretic_datum.feast_of_owls)
		return FALSE

	. = TRUE

	heretic_datum.feast_of_owls = TRUE
	heretic_datum.update_heretic_aura()
	user.set_temp_blindness(reward * 1 SECONDS)
	user.AdjustParalyzed(reward * 1 SECONDS)
	user.playsound_local(get_turf(user), 'sound/music/antag/heretic/heretic_gain_intense.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	for(var/i in 1 to reward)
		user.emote("scream")
		playsound(loc, 'sound/items/eatfood.ogg', 100, TRUE)
		heretic_datum.adjust_knowledge_points(1)

		to_chat(user, span_danger("你感到某种无形之物正在撕扯你的本质！"))
		user.do_jitter_animation()
		sleep(1 SECONDS)
		if(QDELETED(user) || QDELETED(heretic_datum))
			return FALSE

	to_chat(user, span_danger(span_big("你的野心被摧残殆尽，但它的残骸中留下了某种强大的东西……")))
	var/drain_message = pick_list(HERETIC_INFLUENCE_FILE, "drain_message")
	to_chat(user, span_hypnophrase(span_big("[drain_message]")))
	return .
