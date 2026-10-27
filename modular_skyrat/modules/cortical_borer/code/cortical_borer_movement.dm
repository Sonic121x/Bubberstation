
/// Checks if the target's head is bio protected, returns true if this is the case
/mob/living/basic/cortical_borer/proc/check_for_target_bio_protection(mob/living/carbon/human/target)
	if(isobj(target.head))
		if(target.head.get_armor_rating(BIO) >= 100)
			return TRUE
	if(isobj(target.wear_mask))
		if(target.wear_mask.get_armor_rating(BIO) >= 100)
			return TRUE
	if(isobj(target.wear_neck))
		if(target.wear_neck.get_armor_rating(BIO) >= 100)
			return TRUE
	return FALSE

/mob/living/basic/cortical_borer/proc/try_enter_host(mob/living/carbon/human/victim)
	if(check_for_target_bio_protection(victim))
		balloon_alert(src, "头部防护太强！")
		return FALSE
	if(victim.has_borer())
		balloon_alert(src, "已被占据")
		return FALSE
	if(!do_after(src, (((upgrade_flags & BORER_FAST_BORING) && !(upgrade_flags & BORER_HIDING)) ? 3 SECONDS : 6 SECONDS), target = victim))
		balloon_alert(src, "别乱动")
		return FALSE
	if(get_dist(victim, src) > 1)
		balloon_alert(src, "太远了")
		return FALSE
	var/obj/item/organ/brain/brain = victim.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(brain))
		balloon_alert(src, "没有大脑")
		return FALSE

	return enter_host(victim, brain)

/mob/living/basic/cortical_borer/proc/enter_host(mob/living/carbon/human/victim, obj/item/organ/brain/brain)
	human_host = victim
	forceMove(human_host)

	if(!(upgrade_flags & BORER_STEALTH_MODE))
		to_chat(human_host, span_notice("一阵寒意顺着你的脊背而下……"))
	copy_languages(human_host)

	var/obj/item/organ/borer_body/borer_organ = new()
	borer_organ.borer = src
	borer_organ.Insert(human_host)

	log_message("[key_name(src)] 在 [loc_name(get_turf(human_host))] 钻进了 [key_name(human_host)] 体内", LOG_GAME)

	ADD_TRAIT(src, TRAIT_WEATHER_IMMUNE, "borer_in_host")

	RegisterSignal(brain, COMSIG_ORGAN_REMOVED, PROC_REF(on_brain_removed))
	brain_host = brain
	return TRUE

/mob/living/basic/cortical_borer/proc/try_leave_host()
	if(host_sugar())
		balloon_alert(src, "宿主体内有糖分，无法运作")
		return TRUE // We force a cooldown over sugar
	balloon_alert(src, "已离开宿主")
	if(!(upgrade_flags & BORER_STEALTH_MODE))
		to_chat(human_host, span_notice("有什么东西正小心翼翼地挠着你的内耳……"))
	return leave_host()

/mob/living/basic/cortical_borer/proc/leave_host()
	var/turf/dropoff_turf = get_turf(human_host)
	log_message("[key_name(src)] 在 [loc_name(dropoff_turf)] 离开了 [key_name(human_host)]", LOG_GAME)

	leave_host_clean()
	forceMove(dropoff_turf)

	REMOVE_TRAIT(src, TRAIT_WEATHER_IMMUNE, "borer_in_host")
	return TRUE

///This is the version for correctly cleaning up the borer when qdeling/moving out. Don't call this directly
/mob/living/basic/cortical_borer/proc/leave_host_clean()
	var/obj/item/organ/borer_body/borer_organ = locate() in human_host.organs
	if(borer_organ)
		borer_organ.Remove(human_host)
	if(brain_host)
		UnregisterSignal(brain_host, COMSIG_ORGAN_REMOVED)
	human_host = null
	brain_host = null


///If a person is debrained, the borer is removed with this
/mob/living/basic/cortical_borer/proc/on_brain_removed(atom/source, mob/living/carbon/target)
	SIGNAL_HANDLER
	leave_host()
