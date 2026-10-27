/* CONTAINS:
 * /obj/item/ai_module/law/core/freeformcore
 * /obj/item/ai_module/law/supplied/freeform
**/

/obj/item/ai_module/law/core/freeformcore
	name = "“自由格式”AI 核心模块"
	laws = list("")
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/ai_module/law/core/freeformcore/configure(mob/user)
	. = TRUE
	var/targName = tgui_input_text(user, "为 AI 输入一条新的核心法则。", "自由格式法则输入", laws[1], max_length = CONFIG_GET(number/max_law_len), multiline = TRUE)
	if(!targName || !user.is_holding(src))
		return
	if(is_ic_filtered(targName))
		to_chat(user, span_warning("错误：法则包含无效文本。"))
		return
	var/list/soft_filter_result = is_soft_ooc_filtered(targName)
	if(soft_filter_result)
		if(tgui_alert(user,"你的法则包含“[soft_filter_result[CHAT_FILTER_INDEX_WORD]]”。“[soft_filter_result[CHAT_FILTER_INDEX_REASON]]”，确定要使用它吗？", "敏感词提醒", list("是", "否")) != "是")
			return
		message_admins("[ADMIN_LOOKUPFLW(user)]忽略了“[soft_filter_result[CHAT_FILTER_INDEX_WORD]]”的敏感词提醒，可能在 AI 法则中使用了违禁词。法则：“[html_encode(targName)]”")
		log_admin_private("[key_name(user)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term for an AI law. Law: \"[targName]\"")
	laws[1] = targName

/obj/item/ai_module/law/core/freeformcore/can_install_to_rack(mob/living/user, obj/machinery/ai_law_rack/rack)
	if(!laws[1])
		to_chat(user, span_warning("模块中没有法则，请输入一条。"))
		return FALSE
	return TRUE

/obj/item/ai_module/law/supplied/freeform
	name = "“自由格式”AI 模块"
	laws = list("")
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/ai_module/law/supplied/freeform/configure(mob/user)
	. = TRUE
	var/targName = tgui_input_text(user, "为 AI 输入一条新法则。", "自由格式法则输入", laws[1], max_length = CONFIG_GET(number/max_law_len), multiline = TRUE)
	if(!targName || !user.is_holding(src))
		return
	if(is_ic_filtered(targName))
		to_chat(user, span_warning("错误：法则包含无效文本。")) // AI LAW 2 SAY U W U WITHOUT THE SPACES
		return
	var/list/soft_filter_result = is_soft_ooc_filtered(targName)
	if(soft_filter_result)
		if(tgui_alert(user,"你的法则包含“[soft_filter_result[CHAT_FILTER_INDEX_WORD]]”。“[soft_filter_result[CHAT_FILTER_INDEX_REASON]]”，确定要使用它吗？", "敏感词提醒", list("是", "否")) != "是")
			return
		message_admins("[ADMIN_LOOKUPFLW(user)]忽略了“[soft_filter_result[CHAT_FILTER_INDEX_WORD]]”的敏感词提醒，可能在 AI 法则中使用了违禁词。法则：“[html_encode(targName)]”")
		log_admin_private("[key_name(user)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term for an AI law. Law: \"[targName]\"")
	laws[1] = targName

/obj/item/ai_module/law/supplied/freeform/can_install_to_rack(mob/living/user, obj/machinery/ai_law_rack/rack)
	if(!laws[1])
		to_chat(user, span_warning("模块中没有法则，请输入一条。"))
		return FALSE
	return TRUE
