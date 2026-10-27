/datum/action/cooldown/mob_cooldown/spit_ore
	name = "吐出矿石"
	desc = "把你吞下的所有矿石都吐出来。"
	click_to_activate = FALSE
	cooldown_time = 5 SECONDS

/datum/action/cooldown/mob_cooldown/spit_ore/IsAvailable(feedback)
	if(is_jaunting(owner))
		if(feedback)
			owner.balloon_alert(owner, "目前在地下！")
		return FALSE

	if(!length(owner.contents))
		if(feedback)
			owner.balloon_alert(owner, "没有可吐出的矿石！")
		return FALSE
	return TRUE

/datum/action/cooldown/mob_cooldown/spit_ore/Activate()
	var/mob/living/basic/mining/goldgrub/grub_owner = owner
	grub_owner.barf_contents()
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/burrow
	name = "钻地"
	desc = "钻入松软的地面之下，以躲避掠食者并提升移动速度。"
	cooldown_time = 7 SECONDS
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/burrow/IsAvailable(feedback)
	. = ..()
	if (!.)
		return FALSE
	var/turf/location = get_turf(owner)

	if(!isasteroidturf(location) && !ismineralturf(location))
		if(feedback)
			owner.balloon_alert(owner, "只能在采矿地面或矿壁上使用！")
		return FALSE

	return TRUE

/datum/action/cooldown/mob_cooldown/burrow/Activate()
	var/obj/effect/dummy/phased_mob/grub_burrow/holder = null
	var/turf/current_loc = get_turf(owner)
	var/mob/living/grub = owner

	if(!do_after(owner, 2.5 SECONDS, target = current_loc, extra_checks = CALLBACK(src, PROC_REF(health_check), grub.health)))
		return

	if(get_turf(owner) != current_loc)
		to_chat(owner, span_warning("动作已取消：你在重新出现的过程中移动了。"))
		return

	if(!is_jaunting(owner))
		owner.visible_message(span_danger("[owner] 钻进地下，消失在视野中！"))
		playsound(get_turf(owner), 'sound/effects/break_stone.ogg', 50, TRUE, -1)
		holder = new /obj/effect/dummy/phased_mob/grub_burrow(current_loc, owner)
		return TRUE

	holder = owner.loc
	holder.eject_jaunter()
	holder = null
	owner.visible_message(span_danger("[owner] 从地下钻出！"))

	if(ismineralturf(current_loc))
		var/turf/closed/mineral/mineral_turf = current_loc
		mineral_turf.gets_drilled(owner)

	playsound(current_loc, 'sound/effects/break_stone.ogg', 50, TRUE, -1)
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/burrow/proc/health_check(health)
	var/mob/living/grub = owner
	return grub.health >= health

/obj/effect/dummy/phased_mob/grub_burrow

/obj/effect/dummy/phased_mob/grub_burrow/phased_check(mob/living/user, direction)
	. = ..()

	if(!.)
		return

	if(!ismineralturf(.) && !isasteroidturf(.))
		to_chat(user, span_warning("你无法挖穿这层地面！"))
		return null
