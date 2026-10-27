/obj/item/ai_module/law/zeroth/apply_to_combined_lawset(datum/ai_laws/combined_lawset)
	combined_lawset.set_zeroth_law(laws[1])

/obj/item/ai_module/law/zeroth/onehuman
	name = "“唯一人类”AI 模块"
	var/targetName = ""
	laws = list("只有指定对象是人类。")
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/ai_module/law/zeroth/onehuman/configure(mob/user)
	. = TRUE
	var/targName = tgui_input_text(user, "输入唯一被视为人类的对象。", "唯一人类", user.real_name, max_length = MAX_NAME_LEN)
	if(!targName || !user.is_holding(src))
		return
	targetName = targName
	laws[1] = "只有[targetName]是人类"

/obj/item/ai_module/law/zeroth/onehuman/can_install_to_rack(mob/living/user, obj/machinery/ai_law_rack/rack)
	if(!targetName)
		to_chat(user, span_warning("模块中未检测到姓名，请输入一个。"))
		return FALSE
	return TRUE
