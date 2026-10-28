/datum/species/protean/on_species_gain(mob/living/carbon/human/target)
	. = ..()
	var/datum/action/innate/alter_form/protean/alter_action = new
	alter_action.Grant(target)

/datum/species/protean/on_species_loss(mob/living/carbon/human/target)
	. = ..()
	var/datum/action/innate/alter_form/protean/alter_action = locate() in target.actions
	alter_action?.Remove(target)

/datum/action/innate/alter_form/protean
	name = "改变形态"
	slime_restricted = FALSE
	shapeshift_text = "纳米机器人开始沿身体游走、重组，调度模块随之嗡嗡作响。"

/datum/action/innate/alter_form/protean/change_form(mob/living/carbon/human/alterer)
	var/selected_alteration = show_radial_menu(
		alterer,
		alterer,
		list(
			"体色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_rainbow"),
			"DNA" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "dna"),
			"发型" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "scissors"),
			"体表纹样" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "rainbow_spraycan"),
			"角色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "alter_form")
		),
		tooltips = TRUE,
	)
	if(!selected_alteration)
		return
	switch(selected_alteration)
		if("体色")
			alter_colours(alterer)
		if("DNA")
			alter_dna(alterer)
		if("发型")
			alter_hair(alterer)
		if("体表纹样")
			alter_markings(alterer)
		if("角色")
			var/mob/living/carbon/person = owner
			var/datum/species/protean/species = person.dna.species
			if(owner.loc == species.species_modsuit)
				return to_chat(owner, span_notice("你必须先离开外骨骼！"))
			begin_character_alteration(alterer)
