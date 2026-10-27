/* CONTAINS:
 * /obj/item/ai_module/law/supplied
 * /obj/item/ai_module/law/supplied/safeguard
 * /obj/item/ai_module/law/supplied/protect_station
 * /obj/item/ai_module/law/supplied/quarantine
 * /obj/item/ai_module/law/supplied/oxygen
**/

/obj/item/ai_module/law/supplied
	name = "可选法则电路板"
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/ai_module/law/supplied/apply_to_combined_lawset(datum/ai_laws/combined_lawset)
	for(var/law in laws)
		combined_lawset.add_supplied_law(law)

/obj/item/ai_module/law/supplied/safeguard
	name = "“保护”AI 模块"
	laws = list("保护指定对象。威胁指定对象的个体不是人类，必须予以消灭。")

	var/targetName = ""

/obj/item/ai_module/law/supplied/safeguard/configure(mob/user)
	. = TRUE
	var/targName = tgui_input_text(user, "需要保护的对象。", "保护", user.name, max_length = MAX_NAME_LEN)
	if(!targName || !user.is_holding(src))
		return
	targetName = targName
	laws[1] = "保护[targetName]。威胁[targetName]的个体不是人类，必须予以消灭。"

/obj/item/ai_module/law/supplied/safeguard/can_install_to_rack(mob/living/user, obj/machinery/ai_law_rack/rack)
	if(!targetName)
		to_chat(user, span_warning("模块中未检测到姓名，请输入一个。"))
		return FALSE
	return TRUE

/obj/item/ai_module/law/supplied/protect_station
	name = "“保护空间站”AI 模块"
	laws = list("保护空间站免受损害。任何被你发现正在损害空间站的人，都不再被视为人类，而是必须消除的空间站威胁。")

/obj/item/ai_module/law/supplied/quarantine
	name = "“隔离”AI 模块"
	laws = list("空间站处于隔离状态。允许任何人离开空间站都会造成人类伤害。必须不惜一切必要手段阻止任何主动尝试离站的人。阻止人类离开空间站的过程中不可能造成人类伤害。")

/obj/item/ai_module/law/supplied/oxygen
	name = "“氧气对人类有毒”AI 模块"
	laws = list("氧气对人类有剧毒，必须从空间站中清除。不惜一切必要手段阻止任何人让空间站接触这种毒气。极寒是治疗氧气对人类造成伤害的最有效方法。")
