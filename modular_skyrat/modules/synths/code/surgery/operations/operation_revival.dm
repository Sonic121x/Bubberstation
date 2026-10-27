/datum/surgery_operation/basic/revive_synth
	name = "重启神经网络"
	rnd_name = "重启神经网络（复苏）"
	desc = "重启仿生人神经网络的机械手术。"
	implements = list(
		TOOL_MULTITOOL = 1,
		/obj/item/shockpaddles = 1.43,
		/obj/item/melee/touch_attack/shock = 1.43,
		/obj/item/melee/baton/security = 2.86,
		/obj/item/gun/energy = 10,
	)
	operation_flags = OPERATION_MORBID | OPERATION_NOTABLE
	time = 5 SECONDS
	target_zone = BODY_ZONE_CHEST
	required_biotype = MOB_ROBOTIC
	required_bodytype = BODYTYPE_SYNTHETIC
	all_surgery_states_required = SURGERY_SKIN_OPEN | SURGERY_BONE_SAWED

/datum/surgery_operation/basic/revive_synth/get_default_radial_image()
	return image(/obj/item/multitool)

/datum/surgery_operation/basic/revive_synth/all_required_strings()
	return ..() + list("患者必须已经死亡", "患者必须处于可复苏状态", "患者必须是合成人")

/datum/surgery_operation/basic/revive_synth/state_check(mob/living/patient)
	if(patient.stat != DEAD)
		return FALSE
	if(HAS_TRAIT(patient, TRAIT_SUICIDED) || HAS_TRAIT(patient, TRAIT_HUSK) || HAS_TRAIT(patient, TRAIT_DEFIB_BLACKLISTED))
		return FALSE
	if(patient.has_limbs)
		var/obj/item/organ/brain/synth/brain = patient.get_organ_slot(ORGAN_SLOT_BRAIN)
		return !isnull(brain) && brain_check(brain)
	return mob_check(patient)

/datum/surgery_operation/basic/revive_synth/proc/brain_check(obj/item/organ/brain/brain)
	return !IS_ROBOTIC_ORGAN(brain)

/datum/surgery_operation/basic/revive_synth/proc/mob_check(mob/living/patient)
	return !(patient.mob_biotypes & MOB_ROBOTIC)

/datum/surgery_operation/basic/revive_synth/tool_check(obj/item/tool)
	if(istype(tool, /obj/item/shockpaddles))
		var/obj/item/shockpaddles/paddles = tool
		if((paddles.req_defib && !paddles.defib.powered) || !HAS_TRAIT(paddles, TRAIT_WIELDED) || paddles.cooldown || paddles.busy)
			return FALSE

	if(istype(tool, /obj/item/melee/baton/security))
		var/obj/item/melee/baton/security/baton = tool
		return baton.active

	if(istype(tool, /obj/item/gun/energy))
		var/obj/item/gun/energy/egun = tool
		return istype(egun.chambered, /obj/item/ammo_casing/energy/electrode)

	return TRUE

/datum/surgery_operation/basic/revive_synth/on_preop(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/brain_type = "正电子脑"
	var/obj/item/organ/brain/synth/synth_brain = patient.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(synth_brain)
		brain_type = synth_brain.name
	display_results(
		surgeon,
		patient,
		span_notice("你开始强制重启[patient]的[brain_type]……"),
		span_notice("[surgeon]开始强制重启[patient]的[brain_type]。"),
		span_notice("[surgeon]开始强制重启[patient]的[brain_type]。")
	)

	patient.notify_revival("有人正在尝试重启你的[brain_type]。", source = patient)

/datum/surgery_operation/basic/revive_synth/on_success(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/brain_type = "正电子脑"
	var/obj/item/organ/brain/synth/synth_brain = patient.get_organ_slot(ORGAN_SLOT_BRAIN)
	brain_type = synth_brain.name
	display_results(
		surgeon,
		patient,
		span_notice("你成功用[tool]电击了[patient]的[brain_type]……"),
		span_notice("[surgeon]用[tool]向[patient]的[brain_type]施加强力电击……"),
		span_notice("[surgeon]向[patient]的[brain_type]施加强力电击……"),
	)
	patient.grab_ghost()
	if(iscarbon(patient))
		var/mob/living/carbon/carbon_patient = patient
		carbon_patient.set_heartattack(FALSE)
	if(!patient.revive())
		on_no_revive(surgeon, patient)
		return

	on_revived(surgeon, patient)

/// Call when successfully revived
/datum/surgery_operation/basic/revive_synth/proc/on_revived(mob/living/surgeon, mob/living/patient)
	if (patient.stat < DEAD)
		patient.visible_message(span_notice("……[patient]完全没有受到影响！看来已经处于运行状态了！"))
		return TRUE
	patient.grab_ghost()
	if(patient.revive())
		patient.emote("chime")
		patient.visible_message(span_notice("……[patient]重新激活，机体恢复上线！"))
		if(HAS_MIND_TRAIT(surgeon, TRAIT_MORBID)) // Contrary to their typical hatred of resurrection, it wouldn't be very thematic if morbid people didn't love playing god
			surgeon.add_mood_event("morbid_revival_success", /datum/mood_event/morbid_revival_success)
		to_chat(patient, span_danger("[CONFIG_GET(string/blackoutpolicy)]"))
	patient.adjust_organ_loss(ORGAN_SLOT_BRAIN, 15, 180)

/// Called when revival fails
/datum/surgery_operation/basic/revive_synth/proc/on_no_revive(mob/living/surgeon, mob/living/patient)
	patient.emote("buzz")
	patient.visible_message(span_warning("……[patient]抽搐了一下，随后离线。"))
	patient.adjust_organ_loss(ORGAN_SLOT_BRAIN, 50, 199) // MAD SCIENCE

/// Flavor for failure
/datum/surgery_operation/basic/revive_synth/on_failure(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/brain_type = "正电子脑"
	var/obj/item/organ/brain/synth/synth_brain = patient.get_organ_slot(ORGAN_SLOT_BRAIN)
	brain_type = synth_brain.name
	display_results(
		surgeon,
		patient,
		span_warning("你用[tool]电击[patient]的[brain_type]，但毫无反应。"),
		span_warning("[surgeon]用[tool]电击[patient]的[brain_type]，但毫无反应。"),
		span_warning("[surgeon]用[tool]电击[patient]的[brain_type]，但毫无反应。"),
	)
/datum/surgery_operation/basic/revive_synth/brain_check(obj/item/organ/brain/synth/brain)
	return !..()

/datum/surgery_operation/basic/revive_synth/mob_check(mob/living/patient)
	return !..()
