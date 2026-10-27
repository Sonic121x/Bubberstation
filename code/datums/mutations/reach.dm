///Telekinesis lets you interact with objects from range, and gives you a light blue halo around your head.
/datum/mutation/telekinesis
	name = "念力"
	desc = "受试者能够通过意念与物体交互。"
	quality = POSITIVE
	difficulty = 18
	text_gain_indication = span_notice("你感觉更聪明了！")
	limb_req = BODY_ZONE_HEAD
	instability = POSITIVE_INSTABILITY_MAJOR
	mutation_icon = 'modular_skyrat/master_files/icons/effects/tele_effects.dmi' // BUBBER EDIT ADDITION
	mutation_icon_state = "telekinesishead"
	///Typecache of atoms that TK shouldn't interact with
	var/static/list/blacklisted_atoms = typecacheof(list(/atom/movable/screen))

/datum/mutation/telekinesis/on_acquiring(mob/living/carbon/human/homan)
	. = ..()
	if(!.)
		return
	RegisterSignal(homan, COMSIG_MOB_ATTACK_RANGED, PROC_REF(on_ranged_attack))

/datum/mutation/telekinesis/on_losing(mob/living/carbon/human/homan)
	. = ..()
	if(.)
		return
	UnregisterSignal(homan, COMSIG_MOB_ATTACK_RANGED)

///Triggers on COMSIG_MOB_ATTACK_RANGED. Usually handles stuff like picking up items at range.
/datum/mutation/telekinesis/proc/on_ranged_attack(mob/source, atom/target)
	SIGNAL_HANDLER
	if(is_type_in_typecache(target, blacklisted_atoms))
		return
	if(!tkMaxRangeCheck(source, target) || source.z != target.z)
		return
	return target.attack_tk(source)

/datum/mutation/elastic_arms
	name = "弹性手臂"
	desc = "受试者的手臂变得富有弹性，能够向外伸长一米。\
		然而，这种弹性也使佩戴手套、进行精细操作或抓取大型物体变得困难。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MAJOR
	text_gain_indication = span_warning("你感觉自己长臂过人！")
	text_lose_indication = span_warning("你的手臂不再总是软塌塌的了。")
	difficulty = 32
	mutation_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_NO_TWOHANDING)

/datum/mutation/elastic_arms/on_acquiring(mob/living/carbon/human/homan)
	. = ..()
	if(!.)
		return
	RegisterSignal(homan, COMSIG_LIVING_TRY_PUT_IN_HAND, PROC_REF(on_owner_equipping_item))
	RegisterSignal(homan, COMSIG_LIVING_TRY_PULL, PROC_REF(on_owner_try_pull))
	homan.reach_length++

/datum/mutation/elastic_arms/on_losing(mob/living/carbon/human/homan)
	. = ..()
	if(.)
		return
	UnregisterSignal(homan, list(COMSIG_LIVING_TRY_PUT_IN_HAND, COMSIG_LIVING_TRY_PULL))
	homan.reach_length = min(1, homan.reach_length - 1)

/// signal sent when prompting if an item can be equipped
/datum/mutation/elastic_arms/proc/on_owner_equipping_item(mob/living/carbon/human/owner, obj/item/pick_item)
	SIGNAL_HANDLER
	if((pick_item.w_class > WEIGHT_CLASS_BULKY) && !(pick_item.item_flags & (ABSTRACT|HAND_ITEM))) // cant decide if i should limit to huge or bulky.
		pick_item.balloon_alert(owner, "手臂太软，无法拿起！")
		return COMPONENT_LIVING_CANT_PUT_IN_HAND

/// signal sent when owner tries to pull
/datum/mutation/elastic_arms/proc/on_owner_try_pull(mob/living/carbon/owner, atom/movable/target, force)
	SIGNAL_HANDLER
	if(isliving(target))
		var/mob/living/living_target = target
		if(living_target.mob_size > MOB_SIZE_HUMAN)
			living_target.balloon_alert(owner, "手臂太软，拉不动！")
			return COMSIG_LIVING_CANCEL_PULL
	if(isitem(target))
		var/obj/item/item_target = target
		if(item_target.w_class > WEIGHT_CLASS_BULKY)
			item_target.balloon_alert(owner, "手臂太软，拉不动！")
			return COMSIG_LIVING_CANCEL_PULL
