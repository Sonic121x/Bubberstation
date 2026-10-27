/// Used by Ghouls
/datum/action/cooldown/bloodsucker/recuperate
	name = "鲜血疗愈"
	desc = "消耗自身的部分血液和体力，借助主人的血液缓慢治疗自己。"
	button_icon_state = "power_recup"
	power_explanation = "疗愈：\n\
		启用此能力会开始治疗伤势。\n\
		以耐力损伤以及你和主人的血液为代价，治疗蛮力和毒素伤害。\n\
		如果你并非无血种族，还会额外治疗烧伤。\n\
		死亡或失去意识时，能力会被取消。"
	power_flags = BP_CONTINUOUS_EFFECT
	check_flags = AB_CHECK_CONSCIOUS
	bloodsucker_check_flags = NONE
	purchase_flags = NONE
	bloodcost = 1.5
	cooldown_time = 10 SECONDS
	level_current = -1

/datum/action/cooldown/bloodsucker/recuperate/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return
	if(user.stat >= DEAD || user.incapacitated)
		user.balloon_alert(user, "你已失去行动能力……")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/recuperate/ActivatePower(trigger_flags)
	. = ..()
	to_chat(owner, span_notice("主人的不死之血与你的血液混合，使肌肉绷紧，伤口逐渐愈合。"))
	owner.balloon_alert(owner, "疗愈已启用")
	return TRUE

/datum/action/cooldown/bloodsucker/recuperate/process(seconds_per_tick)
	. = ..()
	if(!.)
		return

	if(!active)
		return
	var/mob/living/carbon/user = owner
	var/datum/antagonist/ghoul/ghouldatum = IS_GHOUL(user)
	if(!ghouldatum || QDELETED(ghouldatum.master))
		to_chat(owner, span_warning("没有可供汲取血液的主人！"))
		DeactivatePower()
		return
	ghouldatum.master.AdjustBloodVolume(-1)
	user.set_timed_status_effect(5 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	user.adjust_stamina_loss(bloodcost * 1.1)
	user.adjust_brute_loss(-2.5, updating_health = FALSE)
	user.adjust_tox_loss(-2, forced = TRUE, updating_health = FALSE)
	// Plasmamen won't lose blood, they don't have any, so they don't heal from Burn.
	if(!HAS_TRAIT(user, TRAIT_NOBLOOD))
		user.blood_volume -= bloodcost
		user.adjust_fire_loss(-1.5, updating_health = FALSE)
	user.updatehealth()
	// Stop Bleeding
	if(istype(user) && user.is_bleeding())
		for(var/obj/item/bodypart/part in user.bodyparts)
			part.generic_bleedstacks--

/datum/action/cooldown/bloodsucker/recuperate/ContinueActive(mob/living/user, mob/living/target)
	if(user.stat >= DEAD)
		return FALSE
	if(INCAPACITATED_IGNORING(user, INCAPABLE_GRAB|INCAPABLE_RESTRAINTS))
		owner?.balloon_alert(owner, "太疲惫了……")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/recuperate/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	owner.balloon_alert(owner, "疗愈已关闭")
	return ..()
