/proc/chinese_grenade_fuse_choice(mob/user, list/fuse_times)
	var/list/labels = list()
	for(var/value in fuse_times)
		labels[value == "Instant" ? "立即引爆" : "[value]秒"] = value
	var/choice = tgui_input_list(user, "请选择新的引爆延迟", "引爆计时器", labels)
	return isnull(choice) ? null : labels[choice]

/proc/chinese_batch_four_action_storage_name(value, action_type)
	if(value == "折纸" && ispath(action_type, /datum/action/innate/origami))
		return "Origami Folding"
	if(value == "反击" && ispath(action_type, /datum/action/innate/blade_counter))
		return "Counterattack"
	if(value == "动力反击" && ispath(action_type, /datum/action/innate/blade_counter/gunpowered))
		return "Powered Counterattack"
	if(value == "接入船员监视器" && ispath(action_type, /datum/action/item_action/crew_monitor))
		return "Interface With Crew Monitor"
	return chinese_batch_five_action_storage_name(chinese_batch_four_antag_action_storage(chinese_batch_four_admin_action_storage(chinese_batch_four_items_action_storage(value, action_type), action_type), action_type), action_type)
