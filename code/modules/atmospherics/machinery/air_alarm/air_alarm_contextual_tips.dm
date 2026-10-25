/obj/machinery/airalarm/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		return 

	if(held_item.tool_behaviour == TOOL_CROWBAR)
		if(buildstage == AIR_ALARM_BUILD_NO_WIRES)
			context[SCREENTIP_CONTEXT_LMB] = "撬出电子元件"

	else if(held_item.tool_behaviour == TOOL_SCREWDRIVER && buildstage == AIR_ALARM_BUILD_COMPLETE)
		context[SCREENTIP_CONTEXT_LMB] = panel_open ? "露出电线" : "遮住电线"

	else if(held_item.tool_behaviour == TOOL_WIRECUTTER)
		if (panel_open)
			context[SCREENTIP_CONTEXT_LMB] = "操作电线"

	else if(held_item.tool_behaviour == TOOL_WRENCH)
		if(buildstage == AIR_ALARM_BUILD_NO_CIRCUIT)
			context[SCREENTIP_CONTEXT_LMB] = "拆下警报器"
	return CONTEXTUAL_SCREENTIP_SET
