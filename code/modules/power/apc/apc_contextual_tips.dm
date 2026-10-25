/obj/machinery/power/apc/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(isAI(user) || iscyborg(user))
		context[SCREENTIP_CONTEXT_LMB] = "打开界面"
		context[SCREENTIP_CONTEXT_RMB] = locked ? "解锁" : "上锁"
		context[SCREENTIP_CONTEXT_CTRL_LMB] = operating ? "切断供电" : "恢复供电"
		context[SCREENTIP_CONTEXT_SHIFT_LMB] = lighting ? "关闭照明" : "开启照明"
		context[SCREENTIP_CONTEXT_ALT_LMB] = equipment ? "关闭设备供电" : "开启设备供电"
		context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = environ ? "关闭环境供电" : "开启环境供电"

	else if (isnull(held_item))
		if (opened == APC_COVER_CLOSED)
			context[SCREENTIP_CONTEXT_RMB] = locked ? "解锁" : "上锁"
		else if (opened == APC_COVER_OPENED && cell)
			context[SCREENTIP_CONTEXT_LMB] = "取出电池"

	else if(held_item.tool_behaviour == TOOL_CROWBAR)
		if (opened == APC_COVER_CLOSED)
			context[SCREENTIP_CONTEXT_LMB] = "打开盖板"
		else if ((opened == APC_COVER_OPENED && has_electronics == APC_ELECTRONICS_SECURED) && !(machine_stat & BROKEN))
			context[SCREENTIP_CONTEXT_LMB] = "合上并上锁"
		else if (malfhack || (machine_stat & (BROKEN|EMAGGED)))
			context[SCREENTIP_CONTEXT_LMB] = "取出损坏的电路板"
		else
			context[SCREENTIP_CONTEXT_LMB] = "取出电路板"

	else if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
		if (opened == APC_COVER_CLOSED)
			context[SCREENTIP_CONTEXT_LMB] = panel_open ? "盖住线路" : "露出线路"
		else if (cell && opened == APC_COVER_OPENED)
			context[SCREENTIP_CONTEXT_LMB] = "取出电池"
		else if (has_electronics == APC_ELECTRONICS_INSTALLED)
			context[SCREENTIP_CONTEXT_LMB] = "固定电路板"
		else if (has_electronics == APC_ELECTRONICS_SECURED)
			context[SCREENTIP_CONTEXT_LMB] = "松开电路板"

	else if(held_item.tool_behaviour == TOOL_WIRECUTTER)
		if (terminal && opened == APC_COVER_OPENED)
			context[SCREENTIP_CONTEXT_LMB] = "拆除接线端子"

	else if(held_item.tool_behaviour == TOOL_WELDER)
		if (opened == APC_COVER_OPENED && !has_electronics)
			context[SCREENTIP_CONTEXT_LMB] = "拆解 APC"

	else if(istype(held_item, /obj/item/stock_parts/power_store/battery) && opened == APC_COVER_OPENED)
		context[SCREENTIP_CONTEXT_LMB] = "装入电池"

	else if(istype(held_item, /obj/item/stack/cable_coil) && opened == APC_COVER_OPENED)
		context[SCREENTIP_CONTEXT_LMB] = "制作接线端子"

	else if(istype(held_item, /obj/item/electronics/apc) && opened == APC_COVER_OPENED)
		context[SCREENTIP_CONTEXT_LMB] = "装入电路板"

	else if(istype(held_item, /obj/item/electroadaptive_pseudocircuit) && opened == APC_COVER_OPENED)
		if (!has_electronics)
			context[SCREENTIP_CONTEXT_LMB] = "装入 APC 电路板"
		else if(!cell)
			context[SCREENTIP_CONTEXT_LMB] = "装入电池"

	else if(istype(held_item, /obj/item/wallframe/apc))
		context[SCREENTIP_CONTEXT_LMB] = "更换损坏的框架"

	return CONTEXTUAL_SCREENTIP_SET
