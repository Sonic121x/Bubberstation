/datum/species/jelly
	mutant_bodyparts = list()
	hair_alpha = 160 //a notch brighter so it blends better.
	facial_hair_alpha = 160

/datum/species/jelly/get_default_mutant_bodyparts()
	return list(
		"tail" = list("None", FALSE),
		"snout" = list("None", FALSE),
		"ears" = list("None", FALSE),
		"legs" = list("Normal Legs", FALSE),
		"taur" = list("None", FALSE),
		"wings" = list("None", FALSE),
		"horns" = list("None", FALSE),
		"spines" = list("None", FALSE),
		"frills" = list("None", FALSE),
	)

/datum/species/jelly/roundstartslime
	name = "史莱姆人"
	id = SPECIES_SLIMESTART
	examine_limb_id = SPECIES_SLIMEPERSON
	coldmod = 3
	heatmod = 1
	specific_alpha = 155
	markings_alpha = 130 //This is set lower than the other so that the alpha values don't stack on top of each other so much
	mutanteyes = /obj/item/organ/eyes
	mutanttongue = /obj/item/organ/tongue/jelly

	bodypart_overrides = list( //Overriding jelly bodyparts
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/jelly/slime/roundstart,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/jelly/slime/roundstart,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/jelly/slime/roundstart,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/jelly/slime/roundstart,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/jelly/slime/roundstart,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/jelly/slime/roundstart,
	)

/datum/species/jelly/roundstartslime/get_species_description()
	return list(
		"史莱姆人是纳米传讯多年异种生物学实验的产物。他们的身体简单而富有流动性，类似单细胞生物。他们怕冷。",
		"他们由史莱姆凝胶构成，并靠毒性来治疗。",
	)

/datum/species/jelly/get_species_lore()
	return list(
		"史莱姆人本质上是由纳米传讯 C7 星区研发部门从头打造的物种， \
		通过将实验室环境中制造的异种生物学史莱姆提升而来。 \
		此后他们以少量群体散布到宇宙各处，但大多数仍留在公司的势力范围内。",

		"他们的身体可塑，结构上类似单细胞，器官简单地位于身体中央。 \
		他们没有固定的外观，但很难完全冒充其他种族。",

		"史莱姆人发展出一套优美的身体语言系统，通常涉及光以及身体流畅的舞蹈和手势。 \
		由于其化学构成，他们能在细胞膜内产生生物荧光照明。 \
		有记录表明，一个人可以像非智慧异种生物学史莱姆那样被“融化”成史莱姆人。 \
		这对智慧几乎没有影响，因此纳米传讯研发部的一些研究者以这种方式转变了自己。",
	)

/datum/species/jelly/roundstartslime/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "biohazard",
		SPECIES_PERK_NAME = "柔软形体",
		SPECIES_PERK_DESC = "由于由史莱姆构成，你能够随意改变自己的肉体形态！只需按下按钮、打个响指，你就能长出耳朵、更换发型，甚至变成半人马般的形态！"
	))

	return perk_descriptions

/datum/species/jelly/roundstartslime/prepare_human_for_preview(mob/living/carbon/human/slime)
	slime.dna.features["mcolor"] = "#AA07DE"
	regenerate_organs(slime, src, visual_only = TRUE)
	slime.hairstyle = "Bob Hair 2"
	slime.hair_color = COLOR_PINK
	slime.update_body(is_creating = TRUE)

/datum/species/jelly/roundstartslime/apply_supplementary_body_changes(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only = FALSE)
	if(preferences.read_preference(/datum/preference/toggle/allow_mismatched_hair_color))
		target.dna.species.hair_color_mode = null

/**
 * Alter Form is the ability of slimes to edit many of their character attributes at will
 * This covers most thing about their character, from body size or colour, to adding new wings, tails, ears, etc, to changing the presence of their genitalia
 * There are some balance concerns with some of these (looking at you, body size), but nobody has abused it Yet:tm:, and it would be exceedingly obvious if they did
 */
/datum/action/innate/alter_form
	name = "改变形态"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "alter_form"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"
	/// Do you need to be a slime-person to use this ability?
	var/slime_restricted = TRUE
	///Is the person using this ability oversized?
	var/oversized_user = FALSE
	///What text is shown to others when the person uses the ability?
	var/shapeshift_text = "变得全神贯注，一动不动地站着。他们的身体似乎在变化，开始变得更加黏稠。"
	///List containing all of the avalible parts
	var/static/list/available_choices

/datum/action/innate/alter_form/New(Target)
	. = ..()
	if(length(available_choices))
		return

	available_choices = deep_copy_list(SSaccessories.sprite_accessories)
	for(var/parts_list in available_choices)
		for(var/parts in available_choices[parts_list])
			var/datum/sprite_accessory/part = available_choices[parts_list][parts]
			if(part.locked)
				available_choices[parts_list] -= parts

/datum/action/innate/alter_form/unrestricted
	slime_restricted = FALSE

/datum/action/innate/alter_form/Activate()
	var/mob/living/carbon/human/alterer = owner
	if(slime_restricted && !isjellyperson(alterer))
		return
	alterer.visible_message(
		span_notice("[owner] [shapeshift_text]"),
		span_notice("你全神贯注地改造自己的身体，一动不动地站着……")
	)
	change_form(alterer)

/**
 * Change form is the initial proc when using the alter form action
 * It brings up a radial menu to allow you to pick what about your character it is that you want to edit
 * Each of these radial menus should be kept from being too long where possible, really
 */
/datum/action/innate/alter_form/proc/change_form(mob/living/carbon/human/alterer)
	var/selected_alteration = show_radial_menu(
		alterer,
		alterer,
		list(
			"体色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_rainbow"),
			"DNA" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "dna"),
			"发型" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "scissors"),
			"体表纹样" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "rainbow_spraycan"),
			"角色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "alter_form"),
		),
		tooltips = TRUE,
	)
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
			begin_character_alteration(alterer)
/**
 * Alter colours handles the changing of mutant colours
 * This affects skin tone primarily, though has the option to change hair, markings, and mutant body parts to match
 */
/datum/action/innate/alter_form/proc/alter_colours(mob/living/carbon/human/alterer)
	var/color_choice = show_radial_menu(
		alterer,
		alterer,
		list(
			"主色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_red"),
			"次色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_green"),
			"第三色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_blue"),
			"全部" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_rainbow"),
		),
		tooltips = TRUE,
	)
	var/color_target
	switch(color_choice)
		if("主色", "全部")
			color_target = FEATURE_MUTANT_COLOR
		if("次色")
			color_target = FEATURE_MUTANT_COLOR_TWO
		if("第三色")
			color_target = FEATURE_MUTANT_COLOR_THREE
		else
			return

	var/new_mutant_colour = tgui_color_picker(
		alterer,
		"为你的角色选择新的 [color_choice = "全部" ? "" : LOWER_TEXT(color_choice)] 颜色：",
		"形态改造",
		alterer.dna.features[color_target]
	)
	if(!new_mutant_colour)
		return

	var/marking_reset = tgui_alert(
		alterer,
		"要将你的体表纹样重置为与新颜色匹配吗？",
		"重置纹样",
		list("是", "否"),
	)
	var/mutant_part_reset = tgui_alert(
		alterer,
		"要将你的变异部位（不含肢体）重置为与新颜色匹配吗？",
		"重置变异部位",
		list("是", "否"),
	)
	var/hair_reset = tgui_alert(
		alterer,
		"要将你的头发重置为与新颜色匹配吗？",
		"重置头发",
		list("头发", "面部毛发", "两者", "无"),
	)

	if(color_choice == "全部")
		alterer.dna.features[FEATURE_MUTANT_COLOR] = sanitize_hexcolor(new_mutant_colour)
		alterer.dna.features[FEATURE_MUTANT_COLOR_TWO] = sanitize_hexcolor(new_mutant_colour)
		alterer.dna.features[FEATURE_MUTANT_COLOR_THREE] = sanitize_hexcolor(new_mutant_colour)
		alterer.dna.update_uf_block(/datum/dna_block/feature/mutant_color)
		alterer.dna.update_uf_block(/datum/dna_block/feature/mutant_color/two)
		alterer.dna.update_uf_block(/datum/dna_block/feature/mutant_color/three)
	else
		alterer.dna.features[color_target] = sanitize_hexcolor(new_mutant_colour)
		switch(color_target)
			if(FEATURE_MUTANT_COLOR)
				alterer.dna.update_uf_block(/datum/dna_block/feature/mutant_color)
			if(FEATURE_MUTANT_COLOR_TWO)
				alterer.dna.update_uf_block(/datum/dna_block/feature/mutant_color/two)
			if(FEATURE_MUTANT_COLOR_THREE)
				alterer.dna.update_uf_block(/datum/dna_block/feature/mutant_color/three)

	if(marking_reset == "是")
		for(var/zone in alterer.dna.species.body_markings)
			for(var/key in alterer.dna.species.body_markings[zone])
				var/datum/body_marking/iterated_marking = GLOB.body_markings[key]
				if(iterated_marking.always_color_customizable)
					continue
				alterer.dna.species.body_markings[zone][key] = iterated_marking.get_default_color(alterer.dna.features, alterer.dna.species)

	if(mutant_part_reset == "是")
		alterer.mutant_renderkey = "" //Just in case
		for(var/mutant_key in alterer.dna.species.mutant_bodyparts)
			var/mutant_list = alterer.dna.species.mutant_bodyparts[mutant_key]
			var/datum/sprite_accessory/changed_accessory = SSaccessories.sprite_accessories[mutant_key][mutant_list[MUTANT_INDEX_NAME]]
			mutant_list[MUTANT_INDEX_COLOR_LIST] = changed_accessory.get_default_color(alterer.dna.features, alterer.dna.species)

	if(hair_reset)
		switch(hair_reset)
			if("头发")
				alterer.hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.update_body_parts()
			if("面部毛发")
				alterer.facial_hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.update_body_parts()
			if("两者")
				alterer.hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.facial_hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.update_body_parts()

	alterer.update_body(is_creating = TRUE)

/**
 * Alter hair lets you adjust both the hair on your head as well as your facial hair
 * You can adjust the style of either
 */
/datum/action/innate/alter_form/proc/alter_hair(mob/living/carbon/human/alterer)
	var/target_hair = show_radial_menu(
		alterer,
		alterer,
		list(
			"头发" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "scissors"),
			"面部毛发" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "straight_razor"),
			"发色" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "rainbow_spraycan")
		),
		tooltips = TRUE,
	)
	if(!target_hair)
		return
	switch(target_hair)
		if("头发")
			var/new_style = chinese_accessory_choice(owner, "选择一种发型", "发型改造", SSaccessories.hairstyles_list)
			if(new_style)
				alterer.set_hairstyle(new_style, update = TRUE)
		if("面部毛发")
			var/new_style = chinese_accessory_choice(alterer, "选择一种面部毛发样式", "发型改造", SSaccessories.facial_hairstyles_list)
			if(new_style)
				alterer.set_facial_hairstyle(new_style, update = TRUE)
		if("发色")
			var/hair_area = tgui_alert(alterer, "选择你想更改颜色的部位", "发色改造", list("发型", "面部毛发", "两者"))
			if(!hair_area)
				return
			var/new_hair_color = tgui_color_picker(alterer, "选择你的新发色", "发色改造", alterer.dna.features[FEATURE_MUTANT_COLOR])
			if(!new_hair_color)
				return

			switch(hair_area)

				if("发型")
					alterer.set_haircolor(sanitize_hexcolor(new_hair_color), update = TRUE)
				if("面部毛发")
					alterer.set_facial_haircolor(sanitize_hexcolor(new_hair_color), update = TRUE)
				if("两者")
					alterer.set_haircolor(sanitize_hexcolor(new_hair_color), update = FALSE)
					alterer.set_facial_haircolor(sanitize_hexcolor(new_hair_color), update = TRUE)

/**
 * Alter DNA is an intermediary proc for the most part
 * It lets you pick between a few options for DNA specifics
 */
/datum/action/innate/alter_form/proc/alter_dna(mob/living/carbon/human/alterer)
	var/list/key_list = list("体型", "生殖器", "变异部位")
	if(CONFIG_GET(flag/disable_erp_preferences))
		key_list.Remove("生殖器")
	var/dna_alteration = tgui_input_list(
		alterer,
		"选择你想改造的 DNA 部分",
		"DNA 改造",
		key_list,
	)
	if(!dna_alteration)
		return
	switch(dna_alteration)
		if("体型")
			if(oversized_user && !HAS_TRAIT(alterer, TRAIT_OVERSIZED))
				var/reset_size = tgui_alert(alterer, "你想恢复为超大体型吗？", "体型更改", list("是", "否"))
				if(reset_size == "是")
					alterer.add_quirk(/datum/quirk/oversized)
					return

			var/new_body_size = tgui_input_number(
				alterer,
				"选择你想要的精灵尺寸：（[(RESIZE_DEFAULT_SIZE * 0.8) * 100]% 到 [(RESIZE_DEFAULT_SIZE * 1.5) * 100]%）。警告：可能使你的角色看起来扭曲",
				"体型更改",
				default = min(alterer.current_size * 100, (RESIZE_DEFAULT_SIZE * 1.5) * 100),
				max_value = (RESIZE_DEFAULT_SIZE * 1.5) * 100,
				min_value = (RESIZE_DEFAULT_SIZE * 0.8) * 100,
			)
			if(!new_body_size)
				return

			if(HAS_TRAIT(alterer, TRAIT_OVERSIZED))
				oversized_user = TRUE
				alterer.remove_quirk(/datum/quirk/oversized)

			new_body_size = new_body_size * 0.01
			if(new_body_size == RESIZE_DEFAULT_SIZE)
				alterer.update_transform(RESIZE_DEFAULT_SIZE / alterer.current_size)
			else
				alterer.update_transform(new_body_size / alterer.current_size)

		if("生殖器")
			alter_genitals(alterer)
		if("变异部位")
			alter_parts(alterer)

	alterer.mutant_renderkey = "" //Just in case
	alterer.update_body_parts()

/**
 * Alter parts lets you adjust mutant bodyparts
 * This can be adding (or removing) things like ears, tails, wings, et cetera.
 */
/datum/action/innate/alter_form/proc/alter_parts(mob/living/carbon/human/alterer)
	var/list/mutant_part_list = list()
	for(var/datum/dna_block/feature/mutant/block as anything in subtypesof(/datum/dna_block/feature/mutant))
		if(CONFIG_GET(flag/disable_erp_preferences) && (block::feature_key in ORGAN_ERP_LIST))
			continue
		mutant_part_list[block::feature_key] = block
	var/chosen_key = tgui_input_list(
		alterer,
		"选择你想要改造的部位",
		"身体部位改造",
		mutant_part_list,
	)
	if(!chosen_key)
		return

	var/choice_list = available_choices[chosen_key]
	var/chosen_name_key = chinese_accessory_choice(
		alterer,
		"你想让这个部位变成什么？",
		"身体部位改造",
		choice_list,
	)
	if(!chosen_name_key)
		return

	var/datum/sprite_accessory/selected_sprite_accessory = SSaccessories.sprite_accessories[chosen_key][chosen_name_key]
	alterer.mutant_renderkey = "" //Just in case
	if(!selected_sprite_accessory.factual)
		if(selected_sprite_accessory.organ_type)
			var/obj/item/organ/organ_path = selected_sprite_accessory.organ_type
			var/slot = initial(organ_path.slot)
			var/obj/item/organ/got_organ = alterer.get_organ_slot(slot)
			if(got_organ)
				got_organ.Remove(alterer)
				qdel(got_organ)
		else
			alterer.dna.species.mutant_bodyparts -= chosen_key
	else
		if(selected_sprite_accessory.organ_type)
			var/robot_organs = HAS_TRAIT(alterer, TRAIT_ROBOTIC_DNA_ORGANS)

			var/obj/item/organ/organ_path = selected_sprite_accessory.organ_type
			var/slot = initial(organ_path.slot)
			var/obj/item/organ/got_organ = alterer.get_organ_slot(slot)
			if(got_organ)
				got_organ.Remove(alterer)
				qdel(got_organ)

			var/obj/item/organ/replacement_organ = SSwardrobe.provide_type(selected_sprite_accessory.organ_type)
			replacement_organ.sprite_accessory_flags = selected_sprite_accessory.flags_for_organ
			replacement_organ.relevant_layers = selected_sprite_accessory.relevent_layers

			var/list/new_acc_list = list()
			new_acc_list[MUTANT_INDEX_NAME] = selected_sprite_accessory.name
			// using a var here to save some horizontal space
			var/color = alterer.dna.mutant_bodyparts[chosen_key]?[MUTANT_INDEX_COLOR_LIST] || selected_sprite_accessory.get_default_color(alterer.dna.features, alterer.dna.species)
			new_acc_list[MUTANT_INDEX_COLOR_LIST] = color
			alterer.dna.mutant_bodyparts[chosen_key] = new_acc_list.Copy()

			if(robot_organs)
				replacement_organ.organ_flags |= ORGAN_ROBOTIC
			replacement_organ.build_from_dna(alterer.dna, chosen_key)
			replacement_organ.Insert(alterer, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		else
			var/list/new_acc_list = list()
			new_acc_list[MUTANT_INDEX_NAME] = selected_sprite_accessory.name
			new_acc_list[MUTANT_INDEX_COLOR_LIST] = selected_sprite_accessory.get_default_color(alterer.dna.features, alterer.dna.species)
			alterer.dna.species.mutant_bodyparts[chosen_key] = new_acc_list
			alterer.dna.mutant_bodyparts[chosen_key] = new_acc_list.Copy()
		alterer.dna.update_uf_block(mutant_part_list[chosen_key])
	alterer.update_body_parts()
	alterer.update_clothing(ALL) // for any clothing that has alternate versions (e.g. muzzled masks)

/**
 * Alter markings lets you add a particular body marking
 */
/datum/action/innate/alter_form/proc/alter_markings(mob/living/carbon/human/alterer)
	var/list/candidates = GLOB.body_marking_sets
	var/chosen_name = chinese_accessory_choice(
		alterer,
		"选择你想更换为哪套体表纹样",
		"纹样改造",
		candidates,
	)
	if(!chosen_name)
		return
	var/datum/body_marking_set/marking_set = GLOB.body_marking_sets[chosen_name]
	alterer.dna.species.body_markings = assemble_body_markings_from_set(marking_set, alterer.dna.features, alterer.dna.species)
	alterer.update_body(is_creating = TRUE)

/**
 * Alter genitals lets you adjust the size or functionality of genitalia
 * If you don't own the genital you try to adjust, it'll ask you if you want to add it first
 */
/datum/action/innate/alter_form/proc/alter_genitals(mob/living/carbon/human/alterer)
	var/list/genital_list
	if(alterer.get_organ_slot(ORGAN_SLOT_BREASTS))
		genital_list += list("乳房泌乳", "乳房大小")
	if(alterer.get_organ_slot(ORGAN_SLOT_PENIS))
		genital_list += list("阴茎粗细", "阴茎长度", "阴茎包皮", "阴茎半人马模式")
	if(alterer.get_organ_slot(ORGAN_SLOT_TESTICLES))
		genital_list += list("睾丸大小")
	if(alterer.get_organ_slot(ORGAN_SLOT_BUTT))
		genital_list += list("臀部大小")
	if(alterer.get_organ_slot(ORGAN_SLOT_BELLY))
		genital_list += list("腹部大小")
	if(!length(genital_list))
		alterer.balloon_alert(alterer, "没有生殖器！")

	var/dna_alteration = tgui_input_list(
		alterer,
		"选择你想改造的身体部位",
		"生殖器改造",
		genital_list
	)
	if(!dna_alteration)
		return
	switch(dna_alteration)
		if("乳房泌乳")
			var/obj/item/organ/genital/breasts/melons = alterer.get_organ_slot(ORGAN_SLOT_BREASTS)
			alterer.dna.features["breasts_lactation"] = !alterer.dna.features["breasts_lactation"]
			melons.lactates = alterer.dna.features["breasts_lactation"]
			alterer.balloon_alert(alterer, "[alterer.dna.features["breasts_lactation"] ? "泌乳中" : "未泌乳"]")

		if("乳房大小")
			var/obj/item/organ/genital/breasts/melons = alterer.get_organ_slot(ORGAN_SLOT_BREASTS)
			var/new_size = tgui_input_list(
				alterer,
				"选择你角色的乳房大小：",
				"DNA 改造",
				GLOB.breast_size_to_number,
			)
			if(!new_size)
				return
			alterer.dna.features["breasts_size"] = melons.breasts_cup_to_size(new_size)
			melons.set_size(alterer.dna.features["breasts_size"])

		if("阴茎粗细")
			var/obj/item/organ/genital/penis/sausage = alterer.get_organ_slot(ORGAN_SLOT_PENIS)
			var/max_girth = PENIS_MAX_GIRTH
			if(alterer.dna.features["penis_size"] >= max_girth)
				max_girth = alterer.dna.features["penis_size"]
			var/new_girth = tgui_input_number(
				alterer,
				"选择你的阴茎粗细：\n（1-[max_girth]（基于长度），单位英寸）",
				"角色偏好",
				max_value = max_girth,
				min_value = 1
			)
			if(new_girth)
				alterer.dna.features["penis_girth"] = new_girth
				sausage.girth = alterer.dna.features["penis_girth"]

		if("阴茎长度")
			var/obj/item/organ/genital/penis/wang = alterer.get_organ_slot(ORGAN_SLOT_PENIS)
			var/new_length = tgui_input_number(
				alterer,
				"选择你的阴茎长度：\n（[PENIS_MIN_LENGTH]-[PENIS_MAX_LENGTH] 英寸）",
				"DNA 改造",
				max_value = PENIS_MAX_LENGTH,
				min_value = PENIS_MIN_LENGTH,
			)
			if(!new_length)
				return
			alterer.dna.features["penis_size"] = new_length
			if(alterer.dna.features["penis_girth"] >= new_length)
				alterer.dna.features["penis_girth"] = new_length - 1
				wang.girth = alterer.dna.features["penis_girth"]
			wang.set_size(alterer.dna.features["penis_size"])

		if("阴茎包皮")
			var/obj/item/organ/genital/penis/schlong = alterer.get_organ_slot(ORGAN_SLOT_PENIS)
			var/new_sheath = tgui_input_list(
				alterer,
				"选择你的阴茎包皮",
				"DNA 改造",
				SHEATH_MODES,
			)
			if(new_sheath)
				alterer.dna.features["penis_sheath"] = new_sheath
				schlong.sheath = new_sheath

		if("阴茎半人马模式")
			alterer.dna.features["penis_taur_mode"] = !alterer.dna.features["penis_taur_mode"]
			alterer.balloon_alert(alterer, "[alterer.dna.features["penis_taur_mode"] ? "使用半人马阴茎" : "不使用半人马阴茎"]")

		if("睾丸大小")
			var/obj/item/organ/genital/testicles/avocados = alterer.get_organ_slot(ORGAN_SLOT_TESTICLES)
			var/new_size = tgui_input_list(
				alterer,
				"选择你角色的睾丸大小：",
				"角色偏好",
				GLOB.preference_balls_sizes,
			)
			if(new_size)
				alterer.dna.features["balls_size"] = avocados.balls_description_to_size(new_size)
				avocados.set_size(alterer.dna.features["balls_size"])

		if("臀部大小")
			var/obj/item/organ/genital/butt/buttocks = alterer.get_organ_slot(ORGAN_SLOT_BUTT)
			var/new_size = tgui_input_number(
				alterer,
				"选择你角色的臀部大小：",
				"角色偏好",
				max_value = BUTT_MAX_SIZE,
				min_value = BUTT_MIN_SIZE,
			)
			if(!new_size)
				return
			alterer.dna.features["butt_size"] = new_size
			buttocks.set_size(alterer.dna.features["butt_size"])

		if("腹部大小")
			var/obj/item/organ/genital/belly/tummy = alterer.get_organ_slot(ORGAN_SLOT_BELLY)
			var/new_size = tgui_input_number(
				alterer,
				"选择你角色的腹部大小：",
				"角色偏好",
				max_value = BELLY_MAX_SIZE,
				min_value = BELLY_MIN_SIZE,
			)
			if(!new_size)
				return
			alterer.dna.features["belly_size"] = new_size
			tummy.set_size(alterer.dna.features["belly_size"])

/**
 * The beginning for character alteration. Handles all the settings and targetting. Leads into [do_char_alteration].
 *
 * Args:
 * * mob/living/carbon/human/alterer: The mob doing the transforming.
 *
 */
/datum/action/innate/alter_form/proc/begin_character_alteration(mob/living/carbon/human/alterer)
	var/list/mob/living/carbon/viable_targets = list()

	to_chat(alterer, span_userdanger("此能力不应用于获取机制上的优势。"))
	to_chat(alterer, span_warning("你使用角色模式的行为将被记录给管理员！不要乱来！"))

	for (var/mob/living/carbon/human/iter_carbon in view(alterer))
		if (!is_valid_char_alteration_target(iter_carbon))
			continue
		viable_targets += iter_carbon

	var/mob/living/carbon/target = tgui_input_list(
		alterer,
		"你想改造谁？",
		"可见生物",
		viable_targets,
		alterer,
		5 SECONDS,
	)
	if (isnull(target) || !is_valid_char_alteration_target(target))
		alterer.balloon_alert(alterer, "选择无效！")
		return

	var/mode = tgui_alert(
		alterer,
		"你想使用你的角色，还是对方的角色？",
		"角色来源",
		list("你的", "对方的", "取消"),
		5 SECONDS,
		FALSE
	)
	var/client/target_client
	var/mob/target_mob
	switch (mode)
		if ("你的")
			target_client = alterer.client
			target_mob = alterer
		if ("对方的")
			target_client = target.client
			target_mob = target
		if ("取消")
			return

	if (isnull(target_client) || isnull(target_mob))
		alterer.balloon_alert(alterer, "选择无效！")
		return

	var/list/prefdata_names = target_client.prefs.create_character_profiles()
	if (isnull(prefdata_names))
		return

	var/target_char_tgui_title = ((mode == "对方的") ? "[alterer] 想把你改造成……哪一个角色？" : "哪一个角色？")
	var/target_char_name = tgui_input_list(
		target_mob,
		target_char_tgui_title,
		"角色",
		prefdata_names,
		timeout = 5 SECONDS
	)
	if (isnull(target_char_name))
		alterer.balloon_alert(alterer, "未选择！")
		return

	if (!is_valid_char_alteration_target(target))
		return

	var/allowed = tgui_alert(
		target,
		"[alterer.get_visible_name()] 想把你改造成 [target_char_name]。你同意吗？",
		"变形",
		list("否", "是"),
		10 SECONDS,
		FALSE
	)

	if (allowed != "是")
		alterer.balloon_alert(alterer, "变形被拒绝")
		return

	var/datum/preferences/prefs = target_client?.prefs
	if (isnull(prefs))
		return

	if (!is_valid_char_alteration_target(target))
		return

	var/old_slot = prefs.savefile.get_entry("default_slot")
	prefs.load_character(prefdata_names.Find(target_char_name))

	do_char_alteration(alterer, target, prefs)

	prefs.load_character(old_slot)

/**
 * The second and final step in character alteration. Actually sets the target to the new character.
 *
 * Args:
 * * mob/living/carbon/human/alterer: The mob doing the transforming.
 * * mob/living/carbon/human/target: The target to be transformed. Must have passed [is_valid_char_alteration_target].
 * * datum/preferences/char_source: The source of the character. Generally either target's or alterer's preference datum.
 */
/datum/action/innate/alter_form/proc/do_char_alteration(mob/living/carbon/human/alterer, mob/living/carbon/human/target, datum/preferences/char_source)
	target.visible_message(
		span_warning("[target.get_visible_name()] 令人不安地抽搐着，身体扭曲起来……最终变成了某种新的模样。"),
		span_warning("你的身体灼痛撕裂，正在变成新的形态！")
	)
	var/original_name = target.dna.real_name

	// Once added this status effect never goes away, and always remembers the !first! original name
	target.apply_status_effect(/datum/status_effect/shapeshift_transformed, original_name)
	char_source.safe_transfer_prefs_to_with_damage(target)
	target.dna.update_dna_identity()
	SSquirks.OverrideQuirks(target, char_source.parent, spawn_items = FALSE)

	var/output = "[key_name(target)] 在 [loc_name(target)] 被 [key_name(alterer)] 使用变形术改造。原名：[original_name]，新名：[target.dna.real_name]。"
	message_admins(output)
	log_game(output)

/datum/status_effect/shapeshift_transformed
	id = "shapeshift_transformed"
	alert_type = null
	var/orig_name

/datum/status_effect/shapeshift_transformed/on_creation(mob/living/new_owner, orig_name)
	. = ..()
	if (!.)
		return

	src.orig_name = orig_name

/datum/status_effect/shapeshift_transformed/get_examine_text()
	var/mob/living/carbon/human/human_owner = owner
	if (!istype(owner))
		return
	var/curr_name = human_owner.dna.real_name
	if (curr_name == orig_name)
		return
	return span_warning("这个角色曾通过变形术改造，原本是 [orig_name]。")

/**
 * Validates if the target can be transformed.
 *
 * Args:
 * * mob/living/carbon/human/target: The check target.
 *
 * Returns:
 * * FALSE if the target has no client or is dead. TRUE otherwise.
 */
/datum/action/innate/alter_form/proc/is_valid_char_alteration_target(mob/living/carbon/target)
	var/client/client = target.client
	if (isnull(client))
		return FALSE
	if (target.stat == DEAD)
		return FALSE

	return TRUE

/datum/species/jelly/on_bloodsucker_gain(mob/living/carbon/human/target)
	humanize_organs(target)

/datum/species/jelly/on_bloodsucker_loss(mob/living/carbon/human/target)
	// regenerate_organs with replace doesn't seem to automatically remove invalid organs unfortunately
	normalize_organs()
