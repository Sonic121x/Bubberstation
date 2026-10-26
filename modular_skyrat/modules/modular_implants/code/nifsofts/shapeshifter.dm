/obj/item/disk/nifsoft_uploader/shapeshifter
	name = "变形术"
	loaded_nifsoft = /datum/nifsoft/action_granter/shapeshifter

/datum/nifsoft/action_granter/shapeshifter
	name = "变形术"
	program_desc = "该程序对分布于 NIF 使用者皮肤表面的纳米机器通道进行了大规模改造。它使纳米机器能够深入皮下，甚至进入宿主的骨骼结构；其中包括拟态材料的整合与飞米级操控装置，目的就是让使用者能够在低层次上实现变形。然而，尽管这些过程背后有着惊人的复杂性，使用者可采用的“形态”范围仍然存在限制。毕竟质量既不能被创造也不能被消灭，而在一具运作中的人形身体上，你也只能用有限的几种方式分配和重组它；这意味着使用者无法变成与自身“真实”形态相差太远的样子。"
	compatible_nifs = list(/obj/item/organ/cyberimp/brain/nif/standard)
	purchase_price = 350
	buying_category = NIFSOFT_CATEGORY_COSMETIC
	ui_icon = "paintbrush"
	action_to_grant = /datum/action/innate/alter_form/nif

/// The NIF version of alter form.
/datum/action/innate/alter_form/nif
	name = "变形术"
	slime_restricted =  FALSE
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "slime"
	shapeshift_text = "闭上眼睛集中精神，身体微微变形扭动。"

/datum/action/innate/alter_form/nif/change_form(mob/living/carbon/human/alterer)
	var/selected_alteration = show_radial_menu(
		alterer,
		alterer,
		list(
			"身体颜色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_rainbow"),
			"DNA" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "dna"),
			"头发" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "scissors"),
			"纹样" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "rainbow_spraycan"),
			"角色形象" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "alter_form")
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
		if("头发")
			alter_hair(alterer)
		if("纹样")
			alter_markings(alterer)
		if("角色形象")
			begin_character_alteration(alterer)
