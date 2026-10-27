// BODY MORPHER QUIRK - Partly ported from SPLURT with some fixes. It's a quirk alternative to the NIF polymorph, for goopy/slime characters
/datum/quirk/body_morpher
	name = "Body Morpher"
	desc = "出于某种原因，你能像史莱姆人一样将身体塑造成不同形态。"
	value = 0
	gain_text = span_notice("你感觉身体变得更容易塑形。")
	lose_text = span_notice("你的身体恢复了正常质地。")
	medical_record_text = "患者表现出自主进行非典型塑性形变的能力。"
	mob_trait = TRAIT_BODY_MORPHER
	icon = FA_ICON_PEOPLE_ARROWS
	mail_goodies = list (
		/obj/item/toy/foamblade = 1 // Fake changeling
	)
	species_blacklist = list(
		SPECIES_SLIMESTART,
		SPECIES_PROTEAN
	)

/datum/action/innate/alter_form/body_morpher
	name = "改变形态"
	slime_restricted = FALSE
	shapeshift_text = "闭上眼睛集中精神，身体微微扭动变形。"

/datum/quirk/body_morpher/add(client/client_source)
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder
	// Add quirk ability action datum
	var/datum/action/innate/alter_form/body_morpher/quirk_action = new
	quirk_action.Grant(quirk_mob)

/datum/quirk/body_morpher/remove()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder
	if(QDELETED(quirk_mob))
		return
	// Remove quirk ability action datum
	var/datum/action/innate/alter_form/body_morpher/quirk_action = locate() in quirk_mob.actions
	quirk_action.Remove(quirk_mob)

/datum/action/innate/alter_form/body_morpher/change_form(mob/living/carbon/human/alterer)
	var/selected_alteration = show_radial_menu(
		alterer,
		alterer,
		list(
			"身体颜色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_rainbow"),
			"DNA" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "dna"),
			"毛发" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "scissors"),
			"花纹" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "rainbow_spraycan"),
			"角色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "alter_form")
		),
		tooltips = TRUE,
	)
	if(!selected_alteration)
		return
	switch(selected_alteration)
		if("身体颜色")
			alter_colours(alterer)
		if("DNA")
			alter_dna(alterer)
		if("毛发")
			alter_hair(alterer)
		if("花纹")
			alter_markings(alterer)
		if("角色")
			begin_character_alteration(alterer)
