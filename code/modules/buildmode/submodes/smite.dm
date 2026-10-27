/datum/buildmode_mode/smite
	key = "smite"
	var/datum/smite/selected_smite

/datum/buildmode_mode/smite/Destroy()
	selected_smite = null
	return ..()

/datum/buildmode_mode/smite/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("选择要使用的神罚")] -> 在建造模式按钮上单击右键\n\
		[span_bold("对该生物降下神罚")] -> 在 mob/living 上单击左键"))
	)

/datum/buildmode_mode/smite/change_settings(client/user)
	var/punishment = input(user, "选择一种惩罚", "神之惩罚") as null|anything in GLOB.smites
	var/smite_path = GLOB.smites[punishment]
	var/datum/smite/picking_smite = new smite_path
	var/configuration_success = picking_smite.configure(user)
	if (configuration_success == FALSE)
		return
	selected_smite = picking_smite

/datum/buildmode_mode/smite/handle_click(client/user, params, object)
	var/list/modifiers = params2list(params)

	if (!check_rights(R_ADMIN | R_FUN))
		return

	if (!LAZYACCESS(modifiers, LEFT_CLICK))
		return

	if (!isliving(object))
		return

	if (selected_smite == null)
		to_chat(user, span_notice("未选择神罚。"))
		return

	selected_smite.do_effect(user, object)
