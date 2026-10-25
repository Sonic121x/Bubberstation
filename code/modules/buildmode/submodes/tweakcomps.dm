/datum/buildmode_mode/tweakcomps
	key = "tweakcomps"
	/// This variable is responsible for the rating of the components themselves. Literally tiers of components, where 1 is standard, 4 is bluespace.
	var/rating = null

/datum/buildmode_mode/tweakcomps/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("选择元件等级")] -> 在建造模式按钮上按鼠标右键\n\
		[span_bold("将所选元件等级设置到机器上")] -> 在机器上按鼠标左键"))
	)

/datum/buildmode_mode/tweakcomps/change_settings(client/target_client)
	var/rating_to_choose = input(target_client, "输入等级数值", "数值", "1")
	rating_to_choose = text2num(rating_to_choose)
	if(!isnum(rating_to_choose))
		tgui_alert(target_client, "请输入一个数字。")
		return

	rating = rating_to_choose

/datum/buildmode_mode/tweakcomps/handle_click(client/target_client, params, obj/machinery/object)
	if(!ismachinery(object))
		to_chat(target_client, span_warning("这不是机器！"))
		return

	if(!object.component_parts)
		to_chat(target_client, span_warning("这台机器没有元件！"))
		return

	for(var/obj/item/stock_parts/P in object.component_parts)
		P.rating = rating
	object.RefreshParts()

	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Machine Upgrade", "[rating]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!
