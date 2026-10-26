/obj/item/reagent_containers/cup/primitive_centrifuge
	name = "原始离心机"
	desc = "一个小杯子，能让人慢慢把不需要的液体甩出来。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/misc_tools.dmi'
	icon_state = "primitive_centrifuge"
	volume = 100
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR

/obj/item/reagent_containers/cup/primitive_centrifuge/examine()
	. = ..()
	. += span_notice("<b>Ctrl + 点击</b>以选择要移除的化学物质。")
	. += span_notice("<b>Ctrl + Shift + 点击</b>以选择要保留的化学物质，其余全部移除。")

/obj/item/reagent_containers/cup/primitive_centrifuge/item_ctrl_click(mob/user)
	if(!length(reagents.reagent_list))
		return

	var/datum/user_input = tgui_input_list(user, "选择要移除的化学物质。", "移除选择", reagents.reagent_list)

	if(!user_input)
		balloon_alert(user, "未选择")
		return

	user.balloon_alert_to_viewers("正在旋转 [src]……")
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
	if(!do_after(user, 5 SECONDS * skill_modifier, target = src))
		user.balloon_alert_to_viewers("停止旋转 [src]")
		return

	reagents.del_reagent(user_input.type)
	user.mind?.adjust_experience(/datum/skill/primitive, 5)
	balloon_alert(user, "已从 [src] 中移除试剂")

/obj/item/reagent_containers/cup/primitive_centrifuge/click_ctrl_shift(mob/user)
	if(!length(reagents.reagent_list))
		return

	var/datum/user_input = tgui_input_list(user, "选择要保留的化学物质，其余全部移除。", "保留选择", reagents.reagent_list)

	if(!user_input)
		balloon_alert(user, "未选择")
		return

	user.balloon_alert_to_viewers("正在旋转 [src]……")
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
	if(!do_after(user, 5 SECONDS * skill_modifier, target = src))
		user.balloon_alert_to_viewers("停止旋转 [src]")
		return

	for(var/datum/reagent/remove_reagent in reagents.reagent_list)
		if(!istype(remove_reagent, user_input.type))
			reagents.del_reagent(remove_reagent.type)

	user.mind?.adjust_experience(/datum/skill/primitive, 5)
	balloon_alert(user, "已从 [src] 中移除试剂")
