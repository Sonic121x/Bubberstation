/datum/action/cooldown/spell/touch/star_touch
	name = "星辰之触"
	desc = "可用于给目标施加星辰标记。\
		如果受害者已被施加星辰标记，则会用一道宇宙射线将你与目标拴系起来。\
		如果拴系保持 8 秒未被打断，对方将陷入沉睡并被传送至你身边。\
		星辰之触还能移除宇宙符文；在手中使用时，还可以把你传送至你的观星者处。"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "star_touch"

	sound = 'sound/items/tools/welder.ogg'
	school = SCHOOL_FORBIDDEN
	cooldown_time = 15 SECONDS
	invocation = "ST'R 'N'RG'!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE
	antimagic_flags = MAGIC_RESISTANCE

	hand_path = /obj/item/melee/touch_attack/star_touch
	/// Stores the weakref for the Star Gazer after ascending
	var/datum/weakref/star_gazer
	/// If the heretic is ascended or not
	var/ascended = FALSE

/datum/action/cooldown/spell/touch/star_touch/is_valid_target(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/touch/star_touch/on_antimagic_triggered(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	victim.visible_message(
		span_danger("法术在你身上弹开了！"),
	)

/datum/action/cooldown/spell/touch/star_touch/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	if(!victim.has_status_effect(/datum/status_effect/star_mark))
		victim.apply_status_effect(/datum/status_effect/star_mark, caster)
		return TRUE
	victim.remove_status_effect(/datum/status_effect/star_mark)
	victim.adjust_drowsiness(8 SECONDS)
	for(var/turf/cast_turf as anything in get_turfs(victim))
		create_cosmic_field(cast_turf, caster)
	caster.apply_status_effect(/datum/status_effect/cosmic_beam, victim)
	return TRUE

/datum/action/cooldown/spell/touch/star_touch/proc/get_turfs(mob/living/victim)
	var/list/target_turfs = list(get_turf(owner))
	var/range = ascended ? 2 : 1
	var/list/directions = list(turn(owner.dir, 90), turn(owner.dir, 270))
	for (var/direction in directions)
		for (var/i in 1 to range)
			target_turfs += get_ranged_target_turf(owner, direction, i)
	return target_turfs

/// To set the star gazer
/datum/action/cooldown/spell/touch/star_touch/proc/set_star_gazer(mob/living/basic/heretic_summon/star_gazer/star_gazer_mob)
	star_gazer = WEAKREF(star_gazer_mob)

/// To obtain the star gazer if there is one
/datum/action/cooldown/spell/touch/star_touch/proc/get_star_gazer()
	var/mob/living/basic/heretic_summon/star_gazer/star_gazer_resolved = star_gazer?.resolve()
	if(star_gazer_resolved)
		return star_gazer_resolved
	return FALSE

/obj/item/melee/touch_attack/star_touch
	name = "星辰之触"
	desc = "一团外表邪恶、会扭曲周围现实流动的光环。\
		使带有星辰标记的人沉睡 4 秒，并使没有星辰标记的人获得一个。"
	icon_state = "star"
	inhand_icon_state = "star"

/obj/item/melee/touch_attack/star_touch/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/effect_remover, \
		success_feedback = "你移除了%THEEFFECT。", \
		tip_text = "清除符文", \
		on_clear_callback = CALLBACK(src, PROC_REF(after_clear_rune)), \
		effects_we_clear = list(/obj/effect/cosmic_rune), \
	)

/obj/item/melee/touch_attack/star_touch/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(!isliving(interacting_with))
		return
	var/mob/living/living_target = interacting_with
	if(get_dist(living_target, user) > 3)
		return
	return melee_attack_chain(user, living_target, modifiers)

/*
 * Callback for effect_remover component.
 */
/obj/item/melee/touch_attack/star_touch/proc/after_clear_rune(obj/effect/target, mob/living/user)
	new /obj/effect/temp_visual/cosmic_rune_fade(get_turf(target))
	var/datum/action/cooldown/spell/touch/star_touch/star_touch_spell = spell_which_made_us?.resolve()
	star_touch_spell?.spell_feedback(user)
	if(!QDELETED(star_touch_spell))
		qdel(star_touch_spell)
	var/datum/action/cooldown/spell/cosmic_rune/rune_spell = locate() in user.actions
	var/obj/effect/cosmic_rune/first_rune = rune_spell.first_rune.resolve()
	var/obj/effect/cosmic_rune/second_rune = rune_spell.second_rune.resolve()
	if(!QDELETED(first_rune))
		new /obj/effect/temp_visual/cosmic_rune_fade(get_turf(first_rune))
		QDEL_NULL(first_rune)
	if(!QDELETED(second_rune))
		new /obj/effect/temp_visual/cosmic_rune_fade(get_turf(second_rune))
		QDEL_NULL(second_rune)

/obj/item/melee/touch_attack/star_touch/ignition_effect(atom/to_light, mob/user)
	. = span_rose("[user]在[to_light]旁轻描淡写地打了个响指，用宇宙能量将其点燃。真他妈帅！")
	remove_hand_with_no_refund(user)

/obj/item/melee/touch_attack/star_touch/attack_self(mob/living/user)
	var/datum/action/cooldown/spell/touch/star_touch/star_touch_spell = spell_which_made_us?.resolve()
	var/mob/living/basic/heretic_summon/star_gazer/star_gazer_mob = star_touch_spell?.get_star_gazer()
	if(!star_gazer_mob)
		balloon_alert(user, "没有关联的观星者！")
		return ..()
	new /obj/effect/temp_visual/cosmic_explosion(get_turf(user))
	do_teleport(
		user,
		get_turf(star_gazer_mob),
		no_effects = TRUE,
		channel = TELEPORT_CHANNEL_MAGIC,
		asoundin = 'sound/effects/magic/cosmic_energy.ogg',
		asoundout = 'sound/effects/magic/cosmic_energy.ogg',
	)
	remove_hand_with_no_refund(user)

/obj/effect/ebeam/cosmic
	name = "宇宙光束"

/datum/status_effect/cosmic_beam
	id = "cosmic_beam"
	tick_interval = 0.2 SECONDS
	duration = 8 SECONDS
	status_type = STATUS_EFFECT_NO_TICK
	alert_type = null
	/// Stores the current beam target
	var/mob/living/current_target
	/// Checks the time of the last check
	var/last_check = 0
	/// The delay of when the beam gets checked
	var/check_delay = 10 //Check los as often as possible, max resolution is SSobj tick though
	/// The maximum range of the beam
	var/max_range = 8
	/// Wether the beam is active or not
	var/active = FALSE
	/// The storage for the beam
	var/datum/beam/current_beam = null
	/// The timer for the teleport effect
	var/teleport_timer
	/// The effect trail that we add to our victim
	var/cosmic_effect_trail
	/// Whether the teleport was successful or not
	var/successful_teleport = FALSE

/datum/status_effect/cosmic_beam/on_creation(mob/living/new_owner, mob/living/current_target)
	cosmic_effect_trail = cosmic_trail_based_on_passive(new_owner)
	start_beam(current_target, new_owner)
	return ..()

/datum/status_effect/cosmic_beam/on_remove()
	if(current_target && get_dist(owner, current_target) <= max_range)
		yoink_victim()
		successful_teleport = TRUE
	lose_target()
	return ..()

/// Puts the victim to sleep and teleports them to the casters' location
/datum/status_effect/cosmic_beam/proc/yoink_victim()
	current_target.apply_effect(8 SECONDS, effecttype = EFFECT_UNCONSCIOUS)
	do_teleport(current_target, owner, channel = TELEPORT_CHANNEL_MAGIC, forced = TRUE)
	current_target.apply_status_effect(/datum/status_effect/star_mark)

/datum/status_effect/cosmic_beam/be_replaced()
	if(active)
		QDEL_NULL(current_beam)
		active = FALSE
	return ..()


/**
 * Proc that always is called when we want to end the beam and makes sure things are cleaned up, see beam_died()
 */
/datum/status_effect/cosmic_beam/proc/lose_target()
	deltimer(teleport_timer)
	if(active)
		QDEL_NULL(current_beam)
		active = FALSE
	if(current_target)
		on_beam_release(current_target)
	current_target = null

/**
 * Proc that is only called when the beam fails due to something, so not when manually ended.
 * manual disconnection = lose_target, so it can silently end
 * automatic disconnection = beam_died, so we can give a warning message first
 */
/datum/status_effect/cosmic_beam/proc/beam_died()
	SIGNAL_HANDLER
	if(successful_teleport)
		return
	to_chat(owner, span_warning("你与[current_target]之间的宇宙拴系被打断了！"))
	active = FALSE
	lose_target()
	duration = 0

/// Used for starting the beam when a target has been acquired
/datum/status_effect/cosmic_beam/proc/start_beam(atom/target, mob/living/user)

	if(current_target)
		lose_target()
	if(!isliving(target))
		return

	current_target = target
	active = TRUE
	current_beam = user.Beam(current_target, icon_state = "cosmic_beam", maxdistance = max_range, beam_type = /obj/effect/ebeam/cosmic)
	RegisterSignal(current_beam, COMSIG_QDELETING, PROC_REF(beam_died))
	RegisterSignal(current_target, COMSIG_QDELETING, PROC_REF(beam_died))

	SSblackbox.record_feedback("tally", "gun_fired", 1, type)
	if(current_target)
		on_beam_hit(current_target, user)

/// What to add when the beam connects to a target
/datum/status_effect/cosmic_beam/proc/on_beam_hit(mob/living/target, mob/living/user)
	if(isstargazer(target))
		return
	ADD_TRAIT(target, TRAIT_NO_TELEPORT, REF(src))
	target.AddElement(cosmic_effect_trail, /obj/effect/forcefield/cosmic_field/star_touch)

/// What to remove when the beam disconnects from a target
/datum/status_effect/cosmic_beam/proc/on_beam_release(mob/living/target)
	if(isstargazer(target))
		return
	REMOVE_TRAIT(target, TRAIT_NO_TELEPORT, REF(src))
	target.RemoveElement(cosmic_effect_trail, /obj/effect/forcefield/cosmic_field/star_touch)
