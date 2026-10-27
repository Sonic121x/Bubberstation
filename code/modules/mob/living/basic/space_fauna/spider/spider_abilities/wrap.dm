/datum/action/cooldown/mob_cooldown/wrap
	name = "包裹"
	desc = "将某物或某人包裹进茧里。\
		如果目标是人类或类似种族，你还会将其吞噬。\
		吞噬被包裹的受害者可以强化你的产卵能力。\
		激活此能力后，点击相邻的目标即可开始将其包裹。"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	button_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "wrap_0"
	click_to_activate = TRUE
	ranged_mousepointer = 'icons/effects/mouse_pointers/wrap_target.dmi'
	shared_cooldown = NONE
	/// The time it takes to wrap something.
	var/wrap_time = 5 SECONDS

/datum/action/cooldown/mob_cooldown/wrap/Grant(mob/grant_to)
	. = ..()
	if (!owner)
		return
	RegisterSignals(owner, list(COMSIG_DO_AFTER_BEGAN, COMSIG_DO_AFTER_ENDED), PROC_REF(update_status_on_signal))

/datum/action/cooldown/mob_cooldown/wrap/Remove(mob/removed_from)
	. = ..()
	UnregisterSignal(removed_from, list(COMSIG_DO_AFTER_BEGAN, COMSIG_DO_AFTER_ENDED))

/datum/action/cooldown/mob_cooldown/wrap/IsAvailable(feedback = FALSE)
	. = ..()
	if(!. || owner.incapacitated)
		return FALSE
	if(DOING_INTERACTION(owner, DOAFTER_SOURCE_SPIDER))
		if (feedback)
			owner.balloon_alert(owner, "正忙！")
		return FALSE
	return TRUE

/datum/action/cooldown/mob_cooldown/wrap/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	on_who.balloon_alert(on_who, "准备包裹")
	button_icon_state = "wrap_1"
	build_all_button_icons()

/datum/action/cooldown/mob_cooldown/wrap/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if (refund_cooldown)
		on_who.balloon_alert(on_who, "已取消包裹")
	button_icon_state = "wrap_0"
	build_all_button_icons()

/datum/action/cooldown/mob_cooldown/wrap/Activate(atom/to_wrap)
	if(!owner.Adjacent(to_wrap))
		owner.balloon_alert(owner, "必须再靠近一点！")
		return FALSE

	if(!ismovable(to_wrap) || to_wrap == owner)
		return FALSE
	if(isliving(to_wrap))
		var/mob/living/living_target = to_wrap
		if(living_target.mob_biotypes & MOB_SPECIAL)
			owner.balloon_alert(owner, "无法包裹，它太强了！")
			return FALSE
		if(living_target.mob_biotypes & MOB_SPIRIT)
			owner.balloon_alert(owner, "无法包裹幽灵！")
			return FALSE
		if(isspider(living_target))
			owner.balloon_alert(owner, "无法包裹蜘蛛！")
			return FALSE
	var/atom/movable/target_movable = to_wrap
	if(target_movable.anchored)
		return FALSE

	StartCooldown(wrap_time)
	INVOKE_ASYNC(src, PROC_REF(cocoon), to_wrap)
	return TRUE

/datum/action/cooldown/mob_cooldown/wrap/proc/cocoon(atom/movable/to_wrap)
	if(isliving(to_wrap))
		to_chat(to_wrap, span_userdanger("[owner] 开始在你周围分泌一种黏稠的物质。"))
	owner.visible_message(
		span_notice("[owner] 开始在 [to_wrap] 周围分泌一种黏稠的物质。"),
		span_notice("你开始把 [to_wrap] 包裹进茧里。"),
	)
	if(do_after(owner, wrap_time, target = to_wrap, interaction_key = DOAFTER_SOURCE_SPIDER))
		wrap_target(to_wrap)
	else
		owner.balloon_alert(owner, "被打断了！")

/datum/action/cooldown/mob_cooldown/wrap/proc/wrap_target(mob/living/to_wrap)
	var/obj/structure/spider/cocoon/casing = new(to_wrap.loc)
	if(isliving(to_wrap))
		var/mob/living/living_wrapped = to_wrap
		// You get a point every time you consume a living player, even if they've been consumed before.
		// You only get a point for any individual corpse once, so you can't keep breaking it out and eating it again.
		if(ishuman(living_wrapped) && (living_wrapped.stat != DEAD || !HAS_TRAIT(living_wrapped, TRAIT_SPIDER_CONSUMED)))
			var/datum/action/cooldown/mob_cooldown/lay_eggs/enriched/egg_power = locate() in owner.actions
			if(egg_power)
				egg_power.charges++
				egg_power.build_all_button_icons()
				owner.visible_message(
					span_danger("[owner] 把口器刺入 [living_wrapped]，吸出了一股黏稠的物质。"),
					span_notice("你从 [living_wrapped] 体内吸走了营养物质，足以让你产下一簇富集卵。"),
				)
			ADD_TRAIT(living_wrapped, TRAIT_SPIDER_CONSUMED, TRAIT_GENERIC)
			living_wrapped.investigate_log("因被裹进茧中而死亡。", INVESTIGATE_DEATHS)
			living_wrapped.death() //you just ate them, they're dead.
			log_combat(owner, living_wrapped, "用蜘蛛茧包裹了")
		else
			to_chat(owner, span_warning("[living_wrapped] 不能食用！"))

	to_wrap.forceMove(casing)
	if(isliving(to_wrap)&& (to_wrap.mob_biotypes & MOB_HUMANOID))
		casing.icon_state = pick("cocoon_large1", "cocoon_large2", "cocoon_large3")
	else
		casing.icon_state = pick("cocoon1", "cocoon2", "cocoon3")
