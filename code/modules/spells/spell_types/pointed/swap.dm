/datum/action/cooldown/spell/pointed/swap
	name = "换位"
	desc = "该法术让你与任何活着的生物交换位置。\
		右键：标记一个次要换位目标。交换一旦完成，这个次要目标就会被清除，\
		你也可以用右键点击自己来清除次要目标。"
	button_icon_state = "swap"
	ranged_mousepointer = 'icons/effects/mouse_pointers/swap_target.dmi'
	active_overlay_icon_state = "bg_spell_border_active_blue"

	school = SCHOOL_TRANSLOCATION
	cooldown_time = 25 SECONDS
	cooldown_reduction_per_rank = 10 SECONDS
	spell_max_level = 3
	cast_range = 9
	invocation_type = INVOCATION_NONE
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_STATION
	active_msg = "你准备与一个目标交换位置……"

	smoke_type = /datum/effect_system/fluid_spread/smoke
	smoke_amt = 0

	/// A variable for holding the second selected target with right click.
	var/mob/living/second_target

/datum/action/cooldown/spell/pointed/swap/Destroy()
	second_target = null
	return ..()

/datum/action/cooldown/spell/pointed/swap/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	if(!isliving(cast_on))
		to_chat(owner, span_warning("你只能与活着的生物交换位置！"))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/swap/InterceptClickOn(mob/living/clicker, params, atom/target)
	if(!LAZYACCESS(params2list(params), RIGHT_CLICK))
		return ..()

	if(!IsAvailable(feedback = TRUE))
		return FALSE
	if(!target)
		return FALSE
	if(!isliving(target) || isturf(target))
		// Find any living being in the list. We aren't picky, it's aim assist after all
		target = locate(/mob/living) in target
		if(!target)
			to_chat(owner, span_warning("你只能选择活着的生物作为次要目标！"))
			return FALSE
	if(target == owner)
		if(!isnull(second_target))
			to_chat(owner, span_notice("你取消了次要换位目标！"))
			second_target = null
		else
			to_chat(owner, span_warning("你没有次要换位目标！"))
		return FALSE
	second_target = target
	to_chat(owner, span_notice("你将 [target.name] 选定为次要换位目标！"))
	return FALSE

/datum/action/cooldown/spell/pointed/swap/cast(mob/living/carbon/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(owner, span_warning("法术没有产生任何效果！"))
		to_chat(cast_on, span_warning("你感到空间正在弯折，但它很快就消散了。"))
		return FALSE

	to_chat(cast_on, span_userdanger("你感到空间正在弯折。"))
	if(ispath(smoke_type, /datum/effect_system/fluid_spread/smoke))
		do_smoke(smoke_amt, owner, get_turf(owner), smoke_type = smoke_type)

	var/turf/target_location = get_turf(cast_on)
	if(!isnull(second_target) && get_dist(owner, second_target) <= cast_range && !(cast_on == second_target))
		to_chat(second_target, span_userdanger("你感到空间正在弯折。"))
		if(ispath(smoke_type, /datum/effect_system/fluid_spread/smoke))
			do_smoke(smoke_amt, owner, get_turf(second_target))
		var/turf/second_location = get_turf(second_target)
		do_teleport(second_target, owner.loc, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		do_teleport(cast_on, second_location, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		do_teleport(owner, target_location, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		second_target.playsound_local(get_turf(second_target), 'sound/effects/magic/swap.ogg', 50, 1)
		cast_on.playsound_local(get_turf(cast_on), 'sound/effects/magic/swap.ogg', 50, 1)
		owner.playsound_local(get_turf(owner), 'sound/effects/magic/swap.ogg', 50, 1)
	else
		do_teleport(cast_on, owner.loc, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		do_teleport(owner, target_location, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		cast_on.playsound_local(get_turf(cast_on), 'sound/effects/magic/swap.ogg', 50, 1)
		owner.playsound_local(get_turf(owner), 'sound/effects/magic/swap.ogg', 50, 1)
	second_target = null
