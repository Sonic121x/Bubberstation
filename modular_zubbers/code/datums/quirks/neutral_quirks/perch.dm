/datum/quirk/perch
	name = "Perch"
	desc = "你能以某种方式挂在天花板上。显然是干坏事的好本领。"
	value = 0
	icon = FA_ICON_HAND_POINT_UP
	medical_record_text = "患者的皮肤表面能够产生黏附层。"
	/// The ceiling ability we have given our owner. Nullable, if we have no owner.
	var/datum/action/cooldown/spell/perch/perch_ability

/datum/quirk/perch/add(client/client_source)
	. = ..()

	perch_ability = new /datum/action/cooldown/spell/perch(quirk_holder)
	perch_ability.Grant(quirk_holder)

/datum/quirk/perch/remove()
	. = ..()

	if(QDELETED(quirk_holder))
		return

	QDEL_NULL(perch_ability)

/datum/action/cooldown/spell/perch
	name = "悬挂"
	desc = "挂在天花板上！"
	button_icon_state = "negative"
	button_icon = 'icons/hud/screen_alert.dmi'
	cooldown_time = 1 SECONDS
	spell_requirements = NONE
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_LYING|AB_CHECK_INCAPACITATED
	var/hangin = FALSE

/datum/action/cooldown/spell/perch/cast(mob/living/cast_on)
	. = ..()
	if(hangin)
		unflip(cast_on)
		return
	if(check_above(cast_on))
		RegisterSignal(cast_on, COMSIG_MOVABLE_MOVED, PROC_REF(on_step))
		cast_on.AddElement(/datum/element/forced_gravity, NEGATIVE_GRAVITY)
		owner.visible_message("<span class='notice'>[owner]升到空中，贴在了天花板上！")
		hangin = TRUE

/datum/action/cooldown/spell/perch/proc/unflip(mob/living/flipper)
	qdel(flipper.RemoveElement(/datum/element/forced_gravity, NEGATIVE_GRAVITY))
	UnregisterSignal(flipper, COMSIG_MOVABLE_MOVED)
	owner.visible_message("<span class='notice'>[owner]落回地面！")
	hangin = FALSE

/// Unflips the owner on movement
/datum/action/cooldown/spell/perch/proc/on_step(mob/living/flipper)
	SIGNAL_HANDLER
	unflip(flipper)

/datum/action/cooldown/spell/perch/proc/check_above(mob/living/target)
	var/turf/open/current_turf = get_turf(target)
	var/turf/open/openspace/turf_above = get_step_multiz(target, UP)
	if(current_turf && istype(turf_above))
		to_chat(target, span_warning("你头顶空无一物，没有可悬挂的地方！"))
		return FALSE
	return TRUE
