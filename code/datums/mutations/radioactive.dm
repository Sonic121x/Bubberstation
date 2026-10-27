/datum/mutation/radioactive
	name = "放射性"
	desc = "受试者释放致命的贝塔辐射，危及自身及周围环境。"
	quality = NEGATIVE
	text_gain_indication = span_warning("你能感觉到它渗入了骨髓！")
	instability = NEGATIVE_STABILITY_MAJOR
	difficulty = 8
	power_coeff = 1
	mutation_icon_state = "radiation"
	offset_location = ENTIRE_BODY
	/// Weakref to our radiation emitter component
	var/datum/weakref/radioactivity_source_ref

/datum/mutation/radioactive/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	if(!.)
		return
	var/datum/component/radioactive_emitter/radioactivity_source = make_radioactive(acquirer)
	radioactivity_source_ref = WEAKREF(radioactivity_source)

/datum/mutation/radioactive/setup()
	. = ..()
	if(!QDELETED(owner))
		make_radioactive(owner)

/**
 * Makes the passed mob radioactive, or if they're already radioactive,
 * update their radioactivity to the newly set values
 */
/datum/mutation/radioactive/proc/make_radioactive(mob/living/carbon/human/who)
	return who.AddComponent(
		/datum/component/radioactive_emitter, \
		cooldown_time = 5 SECONDS, \
		range = 1 * (GET_MUTATION_POWER(src) * 2), \
		threshold = RAD_MEDIUM_INSULATION, \
	)

/datum/mutation/radioactive/on_losing(mob/living/carbon/human/owner)
	QDEL_NULL(radioactivity_source_ref)
	return ..()
