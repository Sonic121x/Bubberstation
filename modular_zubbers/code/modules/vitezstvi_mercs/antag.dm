/datum/antagonist/ert/vitezstvi
	name = "胜利军械承包商"
	role = "承包商"
	outfit = /datum/outfit/vitezstvi_merc
	// the bunk spawner already equips and names them, and re-equipping would undo it
	equip_ert = FALSE
	random_names = FALSE

/datum/antagonist/ert/vitezstvi/forge_objectives()
	var/static/list/orders = list(
		"保护 VARS-7“向导”号，并确保其保持运转。",
		"寻找幸存的空间站人员，尽可能多地把他们接上船。",
		"不要丢下鲍里斯。他是资深员工。",
	)
	for(var/order in orders)
		var/datum/objective/contract = new()
		contract.owner = owner
		contract.explanation_text = order
		// vague standing orders, so they pass unless an admin says otherwise
		contract.completed = TRUE
		objectives += contract

/datum/antagonist/ert/vitezstvi/greet()
	var/list/orders = list()
	orders += span_boldbig("胜利军械紧急撤离命令")
	var/count = 1
	for(var/datum/objective/contract in objectives)
		orders += span_notice("<b>目标 #[count]</b>：[contract.explanation_text]")
		count++
	orders += span_warning("交战规则：空间站人员是客户，也是同志。只有当撤离行动、船员或穿梭机面临明确威胁时，才可使用致命武力。")
	to_chat(owner.current, jointext(orders, "\n"))
