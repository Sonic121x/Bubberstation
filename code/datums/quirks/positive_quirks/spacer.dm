#define LAST_STATE_PLANET "on_planet"
#define LAST_STATE_SPACE "in_space"
#define LAST_STATE_NOGRAV "in_nograv"

/datum/quirk/spacer_born
	name = "Spacer"
	desc = "你出生于太空，从未体验过行星重力带来的舒适。你的身体已经适应了这种生活。\
		你在零重力和人工重力下更加自在，也更能抵御太空环境的影响，\
		但在行星表面待得太久会让你感到不适。"
	gain_text = span_notice("太空让你有家的感觉。")
	lose_text = span_danger("你感到思乡了。")
	icon = FA_ICON_USER_ASTRONAUT
	value = 5
	quirk_flags = QUIRK_CHANGES_APPEARANCE //SKYRAT EDIT CHANGE - ORIGINAL: quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	medical_record_text = "患者十分适应非行星环境。"
	mail_goodies = list(
		/obj/item/storage/pill_bottle/ondansetron,
		/obj/item/reagent_containers/applicator/pill/gravitum,
	)
	/// How long on a planet before we get averse effects
	var/planet_period = 3 MINUTES
	/// TimerID for time spend on a planet
	VAR_FINAL/planetside_timer
	/// How long in space before we get beneficial effects
	var/recover_period = 1 MINUTES
	/// TimerID for time spend in space
	VAR_FINAL/recovering_timer
	/// Determines the last state we were in ([LAST_STATE_PLANET], [LAST_STATE_SPACE], or [LAST_STATE_NOGRAV])
	VAR_FINAL/last_state

	/// Modifier to damage taken from pressure/cold
	VAR_FINAL/damage_mod = 0.66
	/// Modifier to drift speed in zero G
	VAR_FINAL/drift_mod = 0.75

/datum/quirk/spacer_born/add(client/client_source)
	var/modded_height = GLOB.spacer_height_choices[client_source?.prefs?.read_preference(/datum/preference/choiced/spacer_height)]
	if(isnull(modded_height))
		modded_height = GLOB.spacer_height_choices[pick(GLOB.spacer_height_choices)]

	if(isdummy(quirk_holder))
		var/mob/living/carbon/human/dummy_quirker = quirk_holder
		dummy_quirker.set_mob_height(modded_height)
		return

	// Using Z moved because we don't urgently need to check on every single turf movement for planetary status.
	// If you've arrived at a "planet", the entire Z is gonna be a "planet".
	// It won't really make sense to walk 3 feet and then suddenly gain / lose gravity sickness.
	// If I'm proven wrong, swap this to use Moved.
	RegisterSignal(quirk_holder, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(spacer_moved))
	RegisterSignal(quirk_holder, COMSIG_LIVING_GRAVITY_CHANGED, PROC_REF(spacer_grav))

	// Yes, it's assumed for planetary maps that you start at gravity sickness.
	update_effects(quirk_holder, skip_timers = TRUE)

	// drift slightly faster through zero G
	quirk_holder.inertia_move_multiplier_passive *= drift_mod

	var/mob/living/carbon/human/human_quirker = quirk_holder
	//BUBBER EDIT REMOVAL START
	//human_quirker.set_mob_height(modded_height)
	//BUBBER EDIT REMOVAL END
	human_quirker.physiology.pressure_mod *= damage_mod
	human_quirker.physiology.cold_mod *= damage_mod

/datum/quirk/spacer_born/post_add()
	var/on_a_planet = SSmapping.is_planetary()
	var/planet_job = istype(quirk_holder.mind?.assigned_role, /datum/job/shaft_miner)
	if(!on_a_planet && !planet_job)
		return
	var/datum/bank_account/spacer_account = quirk_holder.get_bank_account()
	if(!isnull(spacer_account))
		spacer_account.payday_modifier *= 1.25
		to_chat(quirk_holder, span_info("考虑到你身为太空居民的背景，\
			由于你的[on_a_planet ?  "驻站" : "职业"]安排，你将获得 25% 的危险津贴。"))

	// Supply them with some patches to help out on their new assignment
	var/obj/item/storage/pill_bottle/ondansetron/disgust_killers = new()
	disgust_killers.desc += " 前往行星表面时最好用一片。"
	if(quirk_holder.equip_to_storage(disgust_killers, ITEM_SLOT_BACK, indirect_action = TRUE, del_on_fail = TRUE))
		to_chat(quirk_holder, span_info("你[isnull(spacer_account) ? "" : "还"]获得了一些止吐贴片，帮助你适应行星重力。"))

/datum/quirk/spacer_born/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOVABLE_Z_CHANGED)
	UnregisterSignal(quirk_holder, COMSIG_LIVING_GRAVITY_CHANGED)

	if(QDELING(quirk_holder))
		return

	quirk_holder.inertia_move_multiplier_passive /= drift_mod
	quirk_holder.clear_mood_event("spacer")
	quirk_holder.remove_movespeed_modifier(/datum/movespeed_modifier/spacer)
	quirk_holder.remove_status_effect(/datum/status_effect/spacer)

	var/mob/living/carbon/human/human_quirker = quirk_holder
	//BUBBER EDIT REMOVAL START
	//human_quirker.set_mob_height(HUMAN_HEIGHT_MEDIUM)
	//BUBBER EDIT REMOVAL END
	human_quirker.physiology.pressure_mod /= damage_mod
	human_quirker.physiology.cold_mod /= damage_mod

/// Check on Z change whether we should start or stop timers
/datum/quirk/spacer_born/proc/spacer_moved(mob/living/source, turf/old_turf, turf/new_turf, same_z_layer)
	SIGNAL_HANDLER

	update_effects(source)

/// Check on gravity change whether we should start or stop timers
/datum/quirk/spacer_born/proc/spacer_grav(mob/living/source, new_gravity, old_gravity)
	SIGNAL_HANDLER

	update_effects(source)

/**
 * Used to check if we should start or stop timers based on the quirk holder's location.
 *
 * * afflicted - the mob arriving / same as quirk holder
 * * skip_timers - if TRUE, this is being done instantly / should not have feedback (such as in init)
 */
/datum/quirk/spacer_born/proc/update_effects(mob/living/spacer, skip_timers = FALSE)
	if(is_on_a_planet(spacer))
		if(spacer.has_gravity())
			on_planet(spacer, skip_timers)
		else
			has_nograv(spacer, skip_timers)
	else
		in_space(spacer, skip_timers)

// Going to a planet

/**
 * Ran when we arrive on a planet.
 *
 * * afflicted - the mob arriving / same as quirk holder
 * * skip_timers - if TRUE, this is being done instantly / should not have feedback (such as in init)
 */
/datum/quirk/spacer_born/proc/on_planet(mob/living/afflicted, skip_timers = FALSE)
	if(planetside_timer || last_state == LAST_STATE_PLANET)
		return
	if(recovering_timer)
		deltimer(recovering_timer)
		recovering_timer = null

	last_state = LAST_STATE_PLANET

	if(skip_timers)
		on_planet_for_too_long(afflicted, TRUE)
		return

	// Recently exercising lets us last longer under heavy strain
	var/exercise_bonus = afflicted.has_status_effect(/datum/status_effect/exercised) ? 2 : 1
	planetside_timer = addtimer(CALLBACK(src, PROC_REF(on_planet_for_too_long), afflicted), planet_period * exercise_bonus, TIMER_STOPPABLE)
	afflicted.add_mood_event("spacer", /datum/mood_event/spacer/on_planet)
	afflicted.add_movespeed_modifier(/datum/movespeed_modifier/spacer/on_planet)
	afflicted.remove_status_effect(/datum/status_effect/spacer) // removes the wellness effect.
	to_chat(afflicted, span_danger("这里的重力让你有些不适。"))

/**
 * Ran after remaining on a planet for too long.
 *
 * * afflicted - the mob arriving / same as quirk holder
 * * skip_timers - if TRUE, this is being done instantly / should not have feedback (such as in init)
 */
/datum/quirk/spacer_born/proc/on_planet_for_too_long(mob/living/afflicted, skip_timers = FALSE)
	if(QDELETED(src) || QDELETED(afflicted))
		return

	// Slightly reduced effects if we're on a planetary map to make it a bit more bearable
	var/nerfed_effects_because_planetary = SSmapping.is_planetary()
	var/moodlet_picked = nerfed_effects_because_planetary ? /datum/mood_event/spacer/on_planet/nerfed : /datum/mood_event/spacer/on_planet/too_long
	var/movespeed_mod_picked = nerfed_effects_because_planetary ? /datum/movespeed_modifier/spacer/on_planet/nerfed : /datum/movespeed_modifier/spacer/on_planet/too_long

	planetside_timer = null
	afflicted.apply_status_effect(/datum/status_effect/spacer/gravity_sickness)
	afflicted.add_mood_event("spacer", moodlet_picked)
	afflicted.add_movespeed_modifier(movespeed_mod_picked)

	if(!skip_timers)
		to_chat(afflicted, span_danger("你在这里待得太久了。重力开始让你难以承受。"))

// Going back into space

/**
 * Ran when returning to space / somewhere with low gravity.
 *
 * * afflicted - the mob arriving / same as quirk holder
 * * skip_timers - if TRUE, this is being done instantly / should not have feedback (such as in init)
 */
/datum/quirk/spacer_born/proc/in_space(mob/living/afflicted, skip_timers = FALSE)
	if(recovering_timer || last_state == LAST_STATE_SPACE)
		return
	if(planetside_timer)
		deltimer(planetside_timer)
		planetside_timer = null

	var/was_nograv = last_state == LAST_STATE_NOGRAV
	last_state = LAST_STATE_SPACE

	if(skip_timers || was_nograv)
		comfortably_in_space(afflicted, TRUE)
		return

	recovering_timer = addtimer(CALLBACK(src, PROC_REF(comfortably_in_space), afflicted), recover_period, TIMER_STOPPABLE)
	afflicted.remove_status_effect(/datum/status_effect/spacer)
	afflicted.clear_mood_event("spacer")
	// Does not remove the movement modifier yet, it lingers until you fully recover
	to_chat(afflicted, span_green("回到太空后，你开始感觉好些了。"))

/**
 * Ran when living back in space, or just no-grav in general, for a long enough period.
 *
 * * afflicted - the mob arriving / same as quirk holder
 * * skip_timers - if TRUE, this is being done instantly / should not have feedback (such as in init)
 */
/datum/quirk/spacer_born/proc/comfortably_in_space(mob/living/afflicted, skip_timers = FALSE)
	if(QDELETED(src) || QDELETED(afflicted))
		return

	recovering_timer = null
	afflicted.apply_status_effect(/datum/status_effect/spacer/gravity_wellness)
	afflicted.add_mood_event("spacer", /datum/mood_event/spacer/in_space)
	afflicted.add_movespeed_modifier(/datum/movespeed_modifier/spacer/in_space)
	if(!skip_timers)
		to_chat(afflicted, span_green("你感觉好多了。"))

// On a planet but has no gravity

/**
 * Ran when we are on a planet while having no gravity.
 *
 * * afflicted - the mob arriving / same as quirk holder
 * * skip_timers - if TRUE, this is being done instantly / should not have feedback (such as in init)
 */
/datum/quirk/spacer_born/proc/has_nograv(mob/living/afflicted, skip_timers = FALSE)
	if(last_state == LAST_STATE_NOGRAV)
		return
	if(planetside_timer)
		deltimer(planetside_timer)
		planetside_timer = null
	if(recovering_timer)
		deltimer(recovering_timer)
		recovering_timer = null

	var/was_in_space = last_state == LAST_STATE_SPACE
	last_state = LAST_STATE_NOGRAV

	afflicted.apply_status_effect(/datum/status_effect/spacer/gravity_wellness)
	afflicted.add_mood_event("spacer", /datum/mood_event/spacer/on_planet/low_grav)
	afflicted.add_movespeed_modifier(/datum/movespeed_modifier/spacer/in_space)
	if(!skip_timers && !was_in_space)
		to_chat(afflicted, span_green("你感觉自己又回到了太空！"))

#undef LAST_STATE_PLANET
#undef LAST_STATE_SPACE
#undef LAST_STATE_NOGRAV
