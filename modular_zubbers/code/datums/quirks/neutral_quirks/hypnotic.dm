/datum/quirk/hypnotic
	name = "Hypnotic"
	desc = "对于容易陷入恍惚的人，你有着极强的吸引力。"
	icon = FA_ICON_FACE_GRIN_HEARTS
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_HIDE_FROM_SCAN
	gain_text = "你的气场变得更加浓烈。"
	lose_text = "你强大的气场减弱了。"
	medical_record_text = "患者的气场明显比常人更强烈。"
	erp_quirk = TRUE
	var/hypnotic_text
	var/hypnotic_color

/datum/quirk/hypnotic/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/quirk/hypnotic/post_add()
	hypnotic_text = quirk_holder.client.prefs.read_preference(/datum/preference/text/hypnotic_text)
	hypnotic_color = quirk_holder.client.prefs.read_preference(/datum/preference/choiced/hypnotic_span)

/datum/quirk/hypnotic/remove()
	UnregisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE)

/datum/quirk/hypnotic/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/mob/living/examinee = source
	if(!istype(user))
		return
	if(!(examinee.client.prefs.read_preference(/datum/preference/toggle/erp/hypnosis)))
		return
	if(user.stat == DEAD)
		return
	if(isnull(hypnotic_color))
		return
	examine_list += pick_color()

/datum/quirk/hypnotic/proc/pick_color()
	var/choice
	switch(hypnotic_color)
		if("Hypnophrase")
			choice = "hypnophrase"
		if("Velvet")
			choice = "velvet"
		if("Yellow Flashy")
			choice = "glossy"
		if("Pink")
			choice = "pink"
		if("Cult")
			choice = "cult"

	return "<span class='[choice]'>[isnull(hypnotic_text) ? "那双眼睛令人忍不住凝视。" : hypnotic_text]</span>"

/datum/quirk_constant_data/hypnotic
	associated_typepath = /datum/quirk/hypnotic
	customization_options = list(
		/datum/preference/text/hypnotic_text,
		/datum/preference/choiced/hypnotic_span,
	)

/datum/preference/text/hypnotic_text
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "hypnotic_quirk_text"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	maximum_value_length = 100

/datum/preference/text/hypnotic_text/serialize(input)
	return htmlrendertext(input)

/datum/preference/text/hypnotic_text/deserialize(input, datum/preferences/preferences)
	return htmlrendertext(input)

/datum/preference/choiced/hypnotic_span
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "flashy_text"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/hypnotic_span/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/text/hypnotic_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/text/hypnotic_text/create_default_value()
	return "那双眼睛令人忍不住凝视。"

/datum/preference/choiced/hypnotic_span/create_default_value()
	return "Hypnophrase"

/datum/preference/choiced/hypnotic_span/init_possible_values()
	return list(
		"Hypnophrase",
		"Velvet",
		"Yellow Flashy",
		"Pink",
		"Cult",
	)
