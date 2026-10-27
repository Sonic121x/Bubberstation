
/datum/action/cooldown/spell/pointed/sword_fling
	name = "掷剑"
	desc = "试着用剑把自己甩来甩去。"
	ranged_mousepointer = 'icons/effects/mouse_pointers/cult_target.dmi'
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_cult_border"

	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "sword_fling"

	school = SCHOOL_EVOCATION
	cooldown_time = 4 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	cast_range = 6
	active_msg = "你调整姿态，准备起跳！"
	var/obj/item/melee/cultblade/haunted/flinged_sword

/datum/action/cooldown/spell/pointed/sword_fling/New(Target, to_fling)
	. = ..()
	flinged_sword = to_fling

/datum/action/cooldown/spell/pointed/sword_fling/Destroy()
	flinged_sword = null
	. = ..()

/datum/action/cooldown/spell/pointed/sword_fling/IsAvailable(feedback)
	if(flinged_sword.bound)
		return FALSE
	return ..()

/datum/action/cooldown/spell/pointed/sword_fling/is_valid_target(atom/cast_on)
	return isatom(cast_on)

/datum/action/cooldown/spell/pointed/sword_fling/cast(turf/cast_on)
	. = ..()
	var/atom/sword_loc = flinged_sword.loc
	if(ismob(sword_loc))
		var/mob/loccer = sword_loc
		var/resist_chance = 20
		var/fail_text = "你奋力挣扎，但 [loccer] 死死握着你！"
		var/particle_to_spawn = null
		if(IS_CULTIST_OR_CULTIST_MOB(loccer))
			resist_chance = 5 // your mastahs
			fail_text = "你奋力挣扎，但 [loccer] 的握力异常地难以抗拒！"
			particle_to_spawn = /obj/effect/temp_visual/cult/sparks
		if(IS_HERETIC_OR_MONSTER(loccer) || IS_LUNATIC(loccer))
			resist_chance = 10
			fail_text = "你奋力挣扎，但 [loccer] 灵巧地化解了你的抓握动作。"
			particle_to_spawn = /obj/effect/temp_visual/eldritch_sparks
		if(loccer.mind?.holy_role) // IS_PRIEST()
			resist_chance = 6
			fail_text = "你奋力挣扎，但 [loccer] 神圣的握持牢牢压制住你的挣动。"
			particle_to_spawn = /obj/effect/temp_visual/blessed
		if(IS_WIZARD(loccer))
			resist_chance = 3 // magic master
			fail_text = "你奋力挣扎，但 [loccer] 对魔法的掌控轻易化解了你的动作。"
			particle_to_spawn = /obj/effect/particle_effect/sparks/electricity

		new particle_to_spawn(get_turf(loccer))
		loccer.shake_up_animation()
		playsound(loccer, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, -1)

		if(prob(resist_chance))
			flinged_sword.forceMove(get_turf(loccer))
			flinged_sword.visible_message(span_alert("\the [flinged_sword] 从 [loccer] 的手中挣脱而出！"))
			// flung by later code
		else
			to_chat(owner, span_warning(fail_text))
			return

	if(isitem(sword_loc))
		flinged_sword.forceMove(get_turf(sword_loc))
		flinged_sword.visible_message(span_alert("\the [flinged_sword] 从 [sword_loc] 中挣脱而出！"))
		// flung by later code

	if(iscloset(sword_loc))
		var/obj/structure/closet/sword_closet = sword_loc
		if(!(sword_closet.open(owner, force = prob(5), special_effects = TRUE)))
			sword_closet.container_resist_act(owner, loc_required = FALSE)
		flinged_sword.visible_message(span_alert("\the [flinged_sword] 从 [sword_closet] 中挣脱而出！"))

	// no general struct/machinery check. imagine if someone put the sword in a vendor

	if(isturf(sword_loc))
		new /obj/effect/temp_visual/sword_sparks(sword_loc)
		flinged_sword.throw_at(cast_on, cast_range, flinged_sword.throw_speed, owner)
		flinged_sword.visible_message(\
			span_warning("\the [flinged_sword] 向 \the [cast_on] 猛扑过去！"))
		playsound(flinged_sword, 'sound/items/haunted/ghostitemattack.ogg', 100, TRUE)
		flinged_sword.add_filter("cool_glow", 2, list("type" = "outline", "color" = COLOR_HERETIC_GREEN, "size" = 0.7))
		addtimer(CALLBACK(flinged_sword, TYPE_PROC_REF(/datum, remove_filter), "cool_glow"), 0.7 SECONDS)

/obj/effect/temp_visual/eldritch_sparks
	icon_state = "purplesparkles"

/obj/effect/temp_visual/sword_sparks
	icon_state = "mech_toxin" // only used in one place and it looks kinda good

/obj/effect/temp_visual/blessed
	icon_state = "blessed"
