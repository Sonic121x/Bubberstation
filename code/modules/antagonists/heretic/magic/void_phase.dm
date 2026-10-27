/datum/action/cooldown/spell/pointed/void_phase
	name = "虚空相位"
	desc = "让你闪现到所指定的位置，并在所指目的地周围造成 3x3 的范围伤害气泡， \
		同时也会在你当前位置造成同样的效果。 \
		最小射程为 3 格，最大射程为 9 格。"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "voidblink"
	ranged_mousepointer = 'icons/effects/mouse_pointers/throw_target.dmi'

	school = SCHOOL_FORBIDDEN
	cooldown_time = 20 SECONDS

	invocation = "现'实'相'位"
	invocation_type = INVOCATION_WHISPER
	spell_requirements = NONE

	cast_range = 9
	/// The minimum range to cast the phase.
	var/min_cast_range = 3
	/// The radius of damage around the void bubble
	var/damage_radius = 1

/datum/action/cooldown/spell/pointed/void_phase/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	if(owner && get_dist(get_turf(owner), get_turf(cast_on)) < min_cast_range)
		cast_on.balloon_alert(owner, "太近了！")
		return . | SPELL_CANCEL_CAST

/datum/action/cooldown/spell/pointed/void_phase/cast(atom/cast_on)
	. = ..()
	var/turf/source_turf = get_turf(owner)
	var/turf/targeted_turf = get_turf(cast_on)

	cause_aoe(source_turf, /obj/effect/temp_visual/voidin)
	cause_aoe(targeted_turf, /obj/effect/temp_visual/voidout)

	do_teleport(
		owner,
		targeted_turf,
		precision = 1,
		no_effects = TRUE,
		channel = TELEPORT_CHANNEL_MAGIC,
	)

/// Does the AOE effect of the blinka t the passed turf
/datum/action/cooldown/spell/pointed/void_phase/proc/cause_aoe(turf/target_turf, effect_type = /obj/effect/temp_visual/voidin)
	new effect_type(target_turf)
	playsound(target_turf, 'sound/effects/magic/voidblink.ogg', 60, FALSE)
	for(var/mob/living/living_mob in range(damage_radius, target_turf))
		if(IS_HERETIC_OR_MONSTER(living_mob) || living_mob == owner)
			continue
		if(living_mob.can_block_magic(antimagic_flags))
			continue
		living_mob.apply_damage(40, BRUTE, wound_bonus = CANT_WOUND)
		living_mob.apply_status_effect(/datum/status_effect/void_chill, 2)

/obj/effect/temp_visual/voidin
	icon = 'icons/effects/96x96.dmi'
	icon_state = "void_blink_in"
	alpha = 150
	duration = 6
	pixel_x = -32
	pixel_y = -32

/obj/effect/temp_visual/voidout
	icon = 'icons/effects/96x96.dmi'
	icon_state = "void_blink_out"
	alpha = 150
	duration = 6
	pixel_x = -32
	pixel_y = -32
