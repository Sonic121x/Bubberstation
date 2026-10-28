
/**
 * # Status effect
 *
 * This is the status effect given to Bloodsuckers in a Frenzy
 * This deals with everything entering/exiting Frenzy is meant to deal with.
 */

/atom/movable/screen/alert/status_effect/frenzy
	name = "狂暴"
	desc = "你正陷入狂暴！你已完全失去理性，并且视氏族而定，正为生存而战！快找到并吸食鲜血，否则你将迎来终极死亡！"
	icon = 'modular_zubbers/icons/mob/actions/bloodsucker.dmi'
	icon_state = "power_recover"
	alerttooltipstyle = "cult"

/datum/status_effect/frenzy
	id = "Frenzy"
	status_type = STATUS_EFFECT_UNIQUE
	duration = STATUS_EFFECT_PERMANENT
	alert_type = /atom/movable/screen/alert/status_effect/frenzy
	show_duration = TRUE
	///Boolean on whether they were an AdvancedToolUser, to give the trait back upon exiting.
	var/was_tooluser = FALSE
	/// The stored Bloodsucker antag datum
	var/datum/antagonist/bloodsucker/bloodsuckerdatum
	var/trait_list = list(TRAIT_MUTE, TRAIT_SIGN_LANGUAGE_BLOCKED, TRAIT_DEAF, TRAIT_STRONG_GRABBER)

/datum/status_effect/frenzy/get_examine_text()
	return span_notice("他们看起来……毫无人性，且野性十足！")

/datum/status_effect/frenzy/on_apply()
	var/mob/living/carbon/human/user = owner
	bloodsuckerdatum = IS_BLOODSUCKER(user)

	// Disable ALL Powers and notify their entry
	bloodsuckerdatum.DisableAllPowers(forced = TRUE)
	to_chat(owner, span_userdanger("<FONT size = 3>血！你现在就需要血！你陷入了彻底的狂暴！若得不到血，你会死。"))
	to_chat(owner, span_announce("* 吸血鬼提示：狂暴期间，你的抓取会立即转为攻击性抓取，拥有眩晕抗性，但无法说话、听见，也无法使用吸血、化雾穿行、捕食猛扑、蛮力与不死疾行之外的任何能力（若你拥有它们）。"))
	owner.balloon_alert(owner, "你陷入狂暴！快吸血，否则你会死！")
	SEND_SIGNAL(bloodsuckerdatum, COMSIG_BLOODSUCKER_ENTERS_FRENZY)

	// Give the other Frenzy effects
	owner.add_traits(trait_list, FRENZY_TRAIT)
	if(HAS_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER))
		was_tooluser = TRUE
		REMOVE_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/frenzy_speedup)
	owner.add_client_colour(/datum/client_colour/manual_heart_blood, REF(src))
	var/obj/cuffs = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
	var/obj/legcuffs = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
	if((user.handcuffed && cuffs) || (user.legcuffed && legcuffs))
		user.clear_cuffs(cuffs, TRUE)
		user.clear_cuffs(legcuffs, TRUE)
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(owner, COMSIG_MOB_REMOVING_CUFFS, PROC_REF(on_removing_cuffs))
	return ..()

/datum/status_effect/frenzy/on_remove()
	owner.balloon_alert(owner, "你恢复了理智。")
	UnregisterSignal(owner, list(COMSIG_LIVING_DEATH, COMSIG_MOB_REMOVING_CUFFS))
	owner.remove_traits(trait_list, FRENZY_TRAIT)
	if(was_tooluser)
		ADD_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
		was_tooluser = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/frenzy_speedup)
	owner.remove_client_colour(REF(src))

	SEND_SIGNAL(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXITS_FRENZY)
	return ..()

/datum/status_effect/frenzy/proc/on_death(mob/living/source, gibbed)
	SIGNAL_HANDLER
	qdel(src)

/datum/status_effect/frenzy/proc/on_removing_cuffs(mob/living/carbon/source, obj/item/cuffs)
	SIGNAL_HANDLER
	if(cuffs != source.handcuffed && cuffs != source.legcuffed)
		return NONE
	source.clear_cuffs(cuffs, INSTANT_CUFFBREAK)
	return COMSIG_MOB_BLOCK_CUFF_REMOVAL
