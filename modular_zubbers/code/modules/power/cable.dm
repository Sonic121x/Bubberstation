/obj/item/stack/cable_coil/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ishuman(interacting_with))
		return NONE

	if(user.combat_mode)
		return NONE

	return try_heal(interacting_with, user)

/obj/item/stack/cable_coil/proc/try_heal(atom/interacting_with, mob/living/user)
	var/mob/living/carbon/human/carbon_patient = interacting_with
	var/obj/item/bodypart/preferred_limb = carbon_patient.get_bodypart(check_zone(user.zone_selected))
	var/obj/item/clothing/under/uniform = carbon_patient.w_uniform
	if(uniform?.has_sensor == BROKEN_SENSORS)
		if(uniform?.repair_sensors(user))
			return ITEM_INTERACT_SUCCESS
	if(isnull(preferred_limb) || !IS_ROBOTIC_LIMB(preferred_limb))
		return NONE
	if(!(preferred_limb.burn_dam > 0))
		balloon_alert(user, "肢体未受损")
		return ITEM_INTERACT_BLOCKING
	var/list/damaged_limbs = list()
	for(var/obj/item/bodypart/limb as anything in carbon_patient.bodyparts)
		if(isnull(limb) || !IS_ROBOTIC_LIMB(limb) || !(limb.burn_dam > 0))
			continue
		damaged_limbs += limb
	return try_auto_heal(interacting_with, user, damaged_limbs, preferred_limb)

/obj/item/stack/cable_coil/proc/try_auto_heal(atom/interacting_with, mob/living/user, list/damaged_limbs, preferred_limb)
	var/mob/living/carbon/human/attacked_humanoid = interacting_with
	var/obj/item/bodypart/repaired = (preferred_limb in damaged_limbs) ? preferred_limb : damaged_limbs[1]
	if(!(repaired.burn_dam > 0))
		var/list/updated_damaged_limbs = damaged_limbs
		updated_damaged_limbs.Remove(repaired)
		if(!length(damaged_limbs))
			user.balloon_alert(user, "已完全修复")
			return ITEM_INTERACT_SUCCESS
		user.balloon_alert(user, "正在修复[updated_damaged_limbs[1]]")
		INVOKE_ASYNC(src, PROC_REF(try_auto_heal), interacting_with, user, updated_damaged_limbs, preferred_limb)
		return

	user.visible_message(span_notice("[user]开始修复[attacked_humanoid == user ? "自己" : "[attacked_humanoid]"]的[repaired.name]上的部分线缆。"),
		span_notice("你开始修复[attacked_humanoid == user ? "你" : "[attacked_humanoid]"]的[repaired.name]上的部分线缆。"))
	var/use_delay = 1 SECONDS
	if(user == attacked_humanoid)
		use_delay = 5 SECONDS

	if(!do_after(user, use_delay, attacked_humanoid))
		return ITEM_INTERACT_BLOCKING

	repaired.heal_damage(brute = 0, burn = 15, required_bodytype = BODYTYPE_ROBOTIC)
	user.visible_message(span_notice("[user]修好了[attacked_humanoid]的[repaired.name]上部分烧毁的线缆。"), \
		span_notice("你修好了[attacked_humanoid == user ? "你" : "[attacked_humanoid]"]的[repaired.name]上部分烧毁的线缆。"))

	if (use(1) && amount > 0)
		INVOKE_ASYNC(src, PROC_REF(try_auto_heal), interacting_with, user, damaged_limbs, preferred_limb)
	return ITEM_INTERACT_SUCCESS
