/**
 *	# WITHOUT THIS POWER:
 *
 *	- Mid-Blood: SHOW AS PALE
 *	- Low-Blood: SHOW AS DEAD
 *	- No Heartbeat
 *  - Examine shows actual blood
 *	- Thermal homeostasis (ColdBlooded)
 * 		WITH THIS POWER:
 *	- Normal body temp -- remove Cold Blooded (return on deactivate)
 */

/datum/action/cooldown/bloodsucker/masquerade
	name = "避世伪装"
	desc = "伪造凡人的生命体征，使日常观察和医学检查都无法识破你的怪物本质。"
	button_icon_state = "power_human"
	power_flags = BP_CONTINUOUS_EFFECT|BP_AM_STATIC_COOLDOWN|BP_AM_COSTLESS_UNCONSCIOUS
	check_flags = NONE
	bloodsucker_check_flags = BP_CANT_USE_IN_FRENZY
	purchase_flags = BLOODSUCKER_DEFAULT_POWER
	bloodcost = 10
	level_current = -1
	cooldown_time = 5 SECONDS
	constant_bloodcost = 0.1

/datum/action/cooldown/bloodsucker/masquerade/get_power_explanation_extended()
	. = list()
	. += "避世伪装会让你的身份特征与人类几乎完全一致。"
	. += "- 你会失去几乎全部吸血鬼优势，包括自愈，以及睡眠、辐射、濒死、疾病、开膛和寒冷免疫。"
	. += "- 你的眼睛变得与普通人类一样，心脏开始跳动。"
	. += "- 你会获得基因序列，健康分析仪扫描时显示血量为100%。"
	. += "- 被查看时不会显得苍白，但比苍白更严重的外貌特征无法隐藏。"
	. += "结束避世伪装后，你会恢复吸血鬼能力，并清除可能患有的疾病。"

/datum/action/cooldown/bloodsucker/masquerade/ActivatePower(atom/target)
	var/mob/living/carbon/user = owner
	owner.balloon_alert(owner, "避世伪装已启用")
	to_chat(user, span_notice("你的心脏在死寂的胸腔中伪装着跳动，双眼也不再畏光。你或许还能冒充凡人。"))
	to_chat(user, span_warning("模仿生命时，吸血鬼的自愈能力会停止。"))

	// Give status effect
	user.apply_status_effect(/datum/status_effect/masquerade)

	// Handle Traits
	user.remove_traits(bloodsuckerdatum_power.bloodsucker_traits, BLOODSUCKER_TRAIT)

	ADD_TRAIT(user, TRAIT_MASQUERADE, BLOODSUCKER_TRAIT)
	var/obj/item/bodypart/chest/target_chest = user.get_bodypart(BODY_ZONE_CHEST)
	if(target_chest)
		target_chest.bodypart_flags &= ~BODYPART_UNREMOVABLE
	// Handle organs
	var/obj/item/organ/heart/vampheart = user.get_organ_slot(ORGAN_SLOT_HEART)
	if(vampheart)
		vampheart.Restart()
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.flash_protect = initial(eyes.flash_protect)
		eyes.color_cutoffs = initial(eyes.color_cutoffs)
		eyes.sight_flags = initial(eyes.sight_flags)
		user.update_sight()
	return TRUE

/// todo, make bloodsuckerification into it's own proc, ie, eyes, traits, and such
/datum/action/cooldown/bloodsucker/masquerade/DeactivatePower(deactivate_flags)
	. = ..() // activate = FALSE
	if(!.)
		return
	var/mob/living/carbon/user = owner
	owner.balloon_alert(owner, "避世伪装已关闭")

	// Remove status effect, mutations & diseases that you got while on masq.
	user.remove_status_effect(/datum/status_effect/masquerade)
	for(var/datum/disease/diseases as anything in user.diseases)
		diseases.cure()

	// Handle Traits
	user.add_traits(bloodsuckerdatum_power.bloodsucker_traits, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_MASQUERADE, BLOODSUCKER_TRAIT)
	var/obj/item/bodypart/chest/target_chest = user.get_bodypart(BODY_ZONE_CHEST)
	if(target_chest)
		target_chest.bodypart_flags |= BODYPART_UNREMOVABLE
	// Handle organs
	var/obj/item/organ/heart/vampheart = user.get_organ_slot(ORGAN_SLOT_HEART)
	if(vampheart)
		vampheart.Stop()
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.flash_protect = max(initial(eyes.flash_protect) - 1, FLASH_PROTECTION_SENSITIVE)
		eyes.color_cutoffs = BLOODSUCKER_SIGHT_COLOR_CUTOFF
		eyes.sight_flags = SEE_MOBS
		user.update_sight()
	to_chat(user, span_notice("你的心脏最后一次跳动，皮肤逐渐干枯，冰冷的苍白重新浮现。"))

/**
 * # Status effect
 *
 * This is what the Masquerade power gives, handles their bonuses and gives them a neat icon to tell them they're on Masquerade.
 */

/datum/status_effect/masquerade
	id = "masquerade"
	duration = STATUS_EFFECT_PERMANENT
	duration = STATUS_EFFECT_NO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/masquerade

/atom/movable/screen/alert/status_effect/masquerade
	name = "避世伪装"
	desc = "你正通过避世伪装能力隐藏身份，这会暂停吸血鬼的自愈。"
	icon = 'modular_zubbers/icons/mob/actions/bloodsucker.dmi'
	icon_state = "power_human"
	alerttooltipstyle = "cult"

/atom/movable/screen/alert/status_effect/masquerade/MouseEntered(location,control,params)
	desc = initial(desc)
	return ..()
