/proc/chinese_suit_storage_menu(mob/user, atom/anchor, list/choices, datum/callback/custom_check, require_near = TRUE, autopick_single_option = FALSE)
	var/list/labels = list("unlock" = "解锁", "close" = "关闭", "open" = "打开", "disinfect" = "消毒", "lock" = "锁定", "suit" = "服装", "helmet" = "头盔", "mask" = "面罩", "mod" = "MOD 模块化外骨骼", "storage" = "辅助储物")
	var/list/display_choices = list()
	var/list/original_choices = list()
	for(var/key in choices)
		var/label = labels[key] || key
		display_choices[label] = choices[key]
		original_choices[label] = key
	var/choice = show_radial_menu(user, anchor, display_choices, custom_check = custom_check, require_near = require_near, autopick_single_option = autopick_single_option)
	return isnull(choice) ? null : original_choices[choice]

/proc/chinese_circuit_report(obj/item/circuit_component/component, port_name, value)
	var/list/labels = list("Status Updated" = "状态已更新", "Patient Changed" = "患者已更换", "Patient" = "患者", "Defib Status" = "除颤状态", "Overall Health" = "总体健康", "Brute Damage" = "物理伤害", "Burn Damage" = "灼伤", "Suffocation Damage" = "窒息伤害", "Toxin Damage" = "毒素伤害", "Brain Damage" = "脑损伤", "Blood Level" = "血液量")
	if(istype(component, /obj/item/circuit_component/vitals_monitor) && port_name == "Defib Status")
		var/list/status_names = list("Possible" = "可行", "Impossible" = "不可行", "Husked" = "焦尸化", "Damaged" = "损伤过重", "Heart Failure" = "心脏衰竭", "Brain Failure" = "脑功能衰竭")
		if(status_names[value])
			value = "[status_names[value]]（[value]）"
	return "[labels[port_name] || chinese_batch_five_circuit_port_display(port_name)]的值：[value]"
