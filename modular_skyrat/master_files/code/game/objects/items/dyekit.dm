#define DYE_OPTION_HAIR_COLOR "更改发色"
#define DYE_OPTION_GRADIENT "应用渐变"

/**
 * Applies a gradient and a gradient color to a mob OR changes their hair color, depending on what they choose.
 *
 * Arguments:
 * * target - The mob who we will apply the hair color / gradient and gradient color to.
 * * user - The mob that is applying the hair color / gradient and gradient color.
 */

/obj/item/dyespray
	desc = "用于染发并能任意添加渐变的喷雾。"
	var/uses = 40

/obj/item/dyespray/proc/dye(mob/target, mob/user)
	if(!ishuman(target))
		return

	if(!uses) // Can be set to -1 for infinite uses, basically.
		balloon_alert(user, "它空了！")
		return

	var/mob/living/carbon/human/human_target = target
	var/static/list/dye_options = list(DYE_OPTION_HAIR_COLOR, DYE_OPTION_GRADIENT)
	var/gradient_or_hair = tgui_alert(user, "你想做什么？", "染发喷雾", dye_options, autofocus = TRUE)
	if(!gradient_or_hair || !user.can_perform_action(src, NEED_DEXTERITY))
		return

	var/dyeing_themselves = target == user
	if(gradient_or_hair == DYE_OPTION_HAIR_COLOR)
		var/new_color = tgui_color_picker(user, "选择发色：", "角色偏好", "#" + human_target.hair_color)

		if(!new_color || !user.can_perform_action(src, NEED_DEXTERITY))
			return

		human_target.visible_message(span_notice("[user] 开始给 [dyeing_themselves ? "自己" : "[human_target]"] 的头发染发……"), span_notice("[dyeing_themselves ? "你开始" : "[user] 开始"] 给 [dyeing_themselves ? "你自己" : "你"] 的头发染发……"), ignored_mobs = user)
		if(!dyeing_themselves)
			balloon_alert(user, "染色中……")
		if(!do_after(user, 3 SECONDS, target))
			return

		human_target.set_haircolor(sanitize_hexcolor(new_color), update = TRUE)

	else
		var/beard_or_hair = tgui_input_list(user, "你想染什么？", "角色偏好", list("头发", "面部毛发"))
		if(!beard_or_hair || !user.can_perform_action(src, NEED_DEXTERITY))
			return

		var/list/choices = beard_or_hair == "头发" ? SSaccessories.hair_gradients_list : SSaccessories.facial_hair_gradients_list
		var/new_grad_style = chinese_accessory_choice(user, "选择渐变图案：", "染发喷雾", choices)
		if(!new_grad_style || !user.can_perform_action(src, NEED_DEXTERITY))
			return

		var/hair_key = beard_or_hair == "头发" ? GRADIENT_HAIR_KEY : GRADIENT_FACIAL_HAIR_KEY
		var/new_grad_color = tgui_color_picker(user, "选择次发色：", "染发喷雾", human_target.get_hair_gradient_color(hair_key))
		if(!new_grad_color || !user.can_perform_action(src, NEED_DEXTERITY))
			return

		human_target.visible_message(span_notice("[user] 开始给 [dyeing_themselves ? "自己" : "[human_target]"] 的头发染发……"), span_notice("[dyeing_themselves ? "你开始" : "[user] 开始"] 给 [dyeing_themselves ? "你自己" : "你"] 的头发染发……"), ignored_mobs = user)
		if(!dyeing_themselves)
			balloon_alert(user, "染色中……")
		if(!do_after(user, 3 SECONDS, target))
			return

		if(beard_or_hair == "头发")
			human_target.set_hair_gradient_color(sanitize_hexcolor(new_grad_color), update = FALSE)
			human_target.set_hair_gradient_style(new_grad_style, update = TRUE)
		else
			human_target.set_facial_hair_gradient_color(sanitize_hexcolor(new_grad_color), update = FALSE)
			human_target.set_facial_hair_gradient_style(new_grad_style, update = TRUE)

	playsound(src, 'sound/effects/spray.ogg', 10, vary = TRUE)

	human_target.visible_message(
		span_notice("[user] 给 [dyeing_themselves ? "自己" : "[human_target]"] 的头发染完了色，改变了它的颜色！"),
		span_notice("[dyeing_themselves ? "你" : "[user]"] 给 [dyeing_themselves ? "你自己" : "你"] 的头发染完了色，改变了它的颜色！"), ignored_mobs = user)
	if(!dyeing_themselves)
		balloon_alert(user, "染色完成！")

	uses--

/obj/item/dyespray/examine(mob/user)
	. = ..()
	. += "还剩 [uses] 次使用次数。"

#undef DYE_OPTION_HAIR_COLOR
#undef DYE_OPTION_GRADIENT
