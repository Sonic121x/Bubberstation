/obj/item/ai_module/law/syndicate // This one doesn't inherit from ion boards because it doesn't call ..() in transmitInstructions. ~Miauw
	name = "入侵型 AI 模块"
	desc = "用于入侵 AI 并添加额外法则的模块。此电路板能绕过上传控制台的所有权限限制。"
	laws = list("")

/obj/item/ai_module/law/syndicate/configure(mob/user)
	. = TRUE
	var/targName = tgui_input_text(user, "为 AI 输入一条新法则", "自由格式法则输入", laws[1], max_length = CONFIG_GET(number/max_law_len), multiline = TRUE)
	if(!targName || !user.is_holding(src))
		return
	if(is_ic_filtered(targName)) // not even the syndicate can uwu
		to_chat(user, span_warning("错误：法则包含无效文本。"))
		return
	var/list/soft_filter_result = is_soft_ooc_filtered(targName)
	if(soft_filter_result)
		if(tgui_alert(user,"你的法则包含“[soft_filter_result[CHAT_FILTER_INDEX_WORD]]”。“[soft_filter_result[CHAT_FILTER_INDEX_REASON]]”，确定要使用它吗？", "敏感词提醒", list("是", "否")) != "是")
			return
		message_admins("[ADMIN_LOOKUPFLW(user)]忽略了“[soft_filter_result[CHAT_FILTER_INDEX_WORD]]”的敏感词提醒，可能在 AI 法则中使用了违禁词。法则：“[html_encode(targName)]”")
		log_admin_private("[key_name(user)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term for an AI law. Law: \"[targName]\"")
	laws[1] = targName

/obj/item/ai_module/law/syndicate/apply_to_combined_lawset(datum/ai_laws/combined_lawset)
	combined_lawset.add_hacked_law(laws[1])

/// Makes the AI Malf, as well as give it syndicate laws.
/obj/item/malf_board
	name = "受感染的 AI 模块"
	desc = "感染病毒的 AI 模块。"

	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "std_mod"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

	obj_flags = CONDUCTS_ELECTRICITY
	force = 5
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT * 0.5)

	///Is this upload board unused?
	var/functional = TRUE

/obj/item/malf_board/examine(mob/user)
	. = ..()
	if(IS_TRAITOR(user) && isliving(user) && functional)
		. += span_alert("可以对 AI 核心使用此物，令其感染病毒并发生故障。")
		. += span_alert("也可以对核心模块架使用，感染与之连接的第一个 AI（如果存在）。")

/obj/item/malf_board/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/blocking = ismachinery(interacting_with) || issilicon(interacting_with)
	if(!IS_TRAITOR(user))
		if(blocking)
			to_chat(user, span_warning("你完全不知道怎么用这东西。"))
			return ITEM_INTERACT_BLOCKING
		return NONE
	if(!functional)
		if(blocking)
			to_chat(user, span_warning("它坏了，根本不能用，你还想让它做什么？"))
			return ITEM_INTERACT_BLOCKING
		return NONE

	var/mob/living/silicon/ai/target_ai = interacting_with
	if(istype(interacting_with, /obj/machinery/ai_law_rack/base/core))
		var/obj/machinery/ai_law_rack/base/core/rack = interacting_with
		// find the first non-malf ai linked, but also allow a malf ai to be selected if it's the only one
		for(var/mob/living/silicon/ai/linked_ai in assoc_to_values(rack.linked_mobs))
			if(!target_ai?.mind?.has_antag_datum(/datum/antagonist/malf_ai))
				break
			target_ai = linked_ai
			continue

	if(!isAI(target_ai))
		to_chat(user, span_warning("只能对 AI 或与 AI 连接的核心模块架使用此物。"))
		return ITEM_INTERACT_BLOCKING
	if(target_ai.mind?.has_antag_datum(/datum/antagonist/malf_ai))
		to_chat(user, span_warning("发生未知错误。上传已取消。"))
		return ITEM_INTERACT_BLOCKING

	var/datum/antagonist/malf_ai/infected/malf_datum = new (give_objectives = TRUE, new_boss = user.mind)
	target_ai.mind.add_antag_datum(malf_datum)
	target_ai.malf_picker.processing_time += 50
	to_chat(target_ai, span_notice("病毒增强了你的系统，将你的 CPU 超频至原来的 50 倍。"))
	to_chat(user, span_notice("你成功将病毒上传到了[target_ai]。"))

	functional = FALSE
	update_appearance()
	return ITEM_INTERACT_BLOCKING

/obj/item/malf_board/update_name(updates)
	. = ..()
	if(!functional)
		name = "损坏的 AI 模块"

/obj/item/malf_board/update_desc(updates)
	. = ..()
	if(!functional)
		desc = "一个损坏且无法工作的法则上传模块。"

/obj/item/malf_board/update_overlays()
	. = ..()
	if(!functional)
		. += "damaged"
