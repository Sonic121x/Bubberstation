#define COLOR_MODE_SPECIFIC "Specific Marking"
#define COLOR_MODE_GENERAL "General Color"

/obj/item/fur_dyer
	name = "电动毛发染色器"
	desc = "能够为毛发重新染色的染色器，效果基本是永久的。"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "fur_sprayer"
	w_class = WEIGHT_CLASS_TINY

	var/mode = COLOR_MODE_SPECIFIC

/obj/item/fur_dyer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cell)

/obj/item/fur_dyer/attack_self(mob/user, modifiers)
	. = ..()
	if(mode == COLOR_MODE_SPECIFIC)
		mode = COLOR_MODE_GENERAL
	else
		mode = COLOR_MODE_SPECIFIC

	balloon_alert(user, "已设为[mode == COLOR_MODE_SPECIFIC ? "指定斑纹" : "整体颜色"]！")

/obj/item/fur_dyer/attack(mob/living/M, mob/living/user, params)
	if(!ishuman(M))
		return ..()

	var/mob/living/carbon/human/target_human = M

	switch(mode)
		if(COLOR_MODE_SPECIFIC)
			dye_marking(target_human, user)
		if(COLOR_MODE_GENERAL)
			dye_general(target_human, user)

/obj/item/fur_dyer/proc/dye_general(mob/living/carbon/human/target_human, mob/living/user)
	var/selected_mutant_color = tgui_alert(user, "请选择要修改的变异体颜色", "选择颜色", list("第一色", "第二色", "第三色"))

	if(!selected_mutant_color)
		return

	if(!(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
		to_chat(user, span_danger("红灯闪烁！"))
		return

	// BUBBERSTATION EDIT START: TGUI COLOR PICKER
	var/selected_color = tgui_color_picker(
			user,
			"选择斑纹颜色",
			null,
			COLOR_WHITE,
		)
	// BUBBERSTATION EDIT END: TGUI COLOR PICKER

	if(!selected_color)
		return

	selected_color = sanitize_hexcolor(selected_color)

	visible_message(span_notice("[user]开始熟练地为[target_human]染色！"))

	if(do_after(user, 20 SECONDS, target_human))
		switch(selected_mutant_color)
			if("第一色")
				target_human.dna.features[FEATURE_MUTANT_COLOR] = selected_color
			if("第二色")
				target_human.dna.features[FEATURE_MUTANT_COLOR_TWO] = selected_color
			if("第三色")
				target_human.dna.features[FEATURE_MUTANT_COLOR_THREE] = selected_color

		target_human.regenerate_icons()
		item_use_power(power_use_amount, user)

		visible_message(span_notice("[user]完成了对[target_human]的染色！"))

		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)


/obj/item/fur_dyer/proc/dye_marking(mob/living/carbon/human/target_human, mob/living/user)

	var/list/list/current_markings = target_human.dna.body_markings.Copy()

	if(!current_markings.len)
		to_chat(user, span_danger("[target_human]没有斑纹！"))
		return

	if(!(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
		to_chat(user, span_danger("红灯闪烁！"))
		return

	var/selected_marking_area = user.zone_selected

	if(!current_markings[selected_marking_area])
		to_chat(user, span_danger("[target_human]的这个肢体上没有斑纹！"))
		return

	var/selected_marking_id = chinese_accessory_choice(user, "请选择要染色的斑纹！", "选择斑纹", current_markings[selected_marking_area])

	if(!selected_marking_id)
		return

	// BUBBERSTATION EDIT START: TGUI COLOR PICKER
	var/selected_color = tgui_color_picker(
			user,
			"选择斑纹颜色",
			null,
			COLOR_WHITE,
		)
	// BUBBERSTATION EDIT END: TGUI COLOR PICKER

	if(!selected_color)
		return

	selected_color = sanitize_hexcolor(selected_color)

	visible_message(span_notice("[user]开始熟练地为[target_human]染色！"))

	if(do_after(user, 20 SECONDS, target_human))
		current_markings[selected_marking_area][selected_marking_id] = selected_color

		target_human.dna.body_markings = current_markings.Copy()

		target_human.regenerate_icons()

		item_use_power(power_use_amount, user)

		visible_message(span_notice("[user]完成了对[target_human]的染色！"))

		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)

#undef COLOR_MODE_SPECIFIC
#undef COLOR_MODE_GENERAL
