
#define FLOODLIGHT_OFF 1
#define FLOODLIGHT_LOW 2
#define FLOODLIGHT_MED 3
#define FLOODLIGHT_HIGH 4

/obj/structure/floodlight_frame
	name = "泛光灯框架"
	desc = "一个金属框架，需要接线并装上灯管才能成为泛光灯。"
	max_integrity = 100
	icon = 'icons/obj/lighting.dmi'
	icon_state = "floodlight_c1"
	density = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	var/state = FLOODLIGHT_NEEDS_WIRES

/obj/structure/floodlight_frame/Initialize(mapload)
	. = ..()
	register_context()

/obj/structure/floodlight_frame/add_context(
	atom/source,
	list/context,
	obj/item/held_item,
	mob/living/user,
)

	if(isnull(held_item))
		return NONE

	var/message = null
	if(state == FLOODLIGHT_NEEDS_WIRES)
		if(istype(held_item, /obj/item/stack/cable_coil))
			message = "添加电缆"
		else if(held_item.tool_behaviour == TOOL_WRENCH)
			message = "拆解框架"

	else if(state == FLOODLIGHT_NEEDS_SECURING)
		if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
			message = "固定电缆"
		else if(held_item.tool_behaviour == TOOL_WIRECUTTER)
			message = "剪断电缆"

	else if(state == FLOODLIGHT_NEEDS_LIGHTS)
		if(istype(held_item, /obj/item/light/tube))
			message = "添加灯管"
		else if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
			message = "拧下电缆"

	if(isnull(message))
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = message
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/floodlight_frame/examine(mob/user)
	. = ..()
	if(state == FLOODLIGHT_NEEDS_WIRES)
		. += span_notice("可以用[EXAMINE_HINT("5 段电缆")]为其接线。")
		. += span_notice("可以用[EXAMINE_HINT("扳手")]拆解这个框架。")
	else if(state == FLOODLIGHT_NEEDS_SECURING)
		. += span_notice("电缆需要[EXAMINE_HINT("拧紧")]到框架上。")
		. += span_notice("悬垂的电缆可以[EXAMINE_HINT("剪断")]。")
	else if(state == FLOODLIGHT_NEEDS_LIGHTS)
		. += span_notice("还需要一根[EXAMINE_HINT("灯管")]才能完成。")
		. += span_notice("电缆可以从框架上[EXAMINE_HINT("拧下")]。")

/obj/structure/floodlight_frame/screwdriver_act(mob/living/user, obj/item/O)
	. = ..()
	if(state == FLOODLIGHT_NEEDS_SECURING)
		icon_state = "floodlight_c3"
		state = FLOODLIGHT_NEEDS_LIGHTS
		return ITEM_INTERACT_SUCCESS
	else if(state == FLOODLIGHT_NEEDS_LIGHTS)
		icon_state = "floodlight_c2"
		state = FLOODLIGHT_NEEDS_SECURING
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/structure/floodlight_frame/wrench_act(mob/living/user, obj/item/tool)
	if(state != FLOODLIGHT_NEEDS_WIRES)
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "正在拆解……")
	if(!tool.use_tool(src, user, 30, volume=50))
		return ITEM_INTERACT_BLOCKING
	new /obj/item/stack/sheet/iron(loc, 5)
	qdel(src)

	return ITEM_INTERACT_SUCCESS

/obj/structure/floodlight_frame/wirecutter_act(mob/living/user, obj/item/tool)
	if(state != FLOODLIGHT_NEEDS_SECURING)
		return ITEM_INTERACT_BLOCKING

	icon_state = "floodlight_c1"
	state = FLOODLIGHT_NEEDS_WIRES
	new /obj/item/stack/cable_coil(loc, 5)

	return ITEM_INTERACT_SUCCESS

/obj/structure/floodlight_frame/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stack/cable_coil) && state == FLOODLIGHT_NEEDS_WIRES)
		var/obj/item/stack/coil = tool
		if(!coil.use(5))
			balloon_alert(user, "需要 5 段电缆！")
			return ITEM_INTERACT_BLOCKING

		icon_state = "floodlight_c2"
		state = FLOODLIGHT_NEEDS_SECURING
		return ITEM_INTERACT_SUCCESS


	if(istype(tool, /obj/item/light/tube))
		if(state != FLOODLIGHT_NEEDS_LIGHTS)
			balloon_alert(user, "建造尚未完成！")
			return ITEM_INTERACT_BLOCKING

		if(astype(tool, /obj/item/light/tube).status == LIGHT_BROKEN) // light tube broken.
			balloon_alert(user, "灯管已破损！")
			return ITEM_INTERACT_BLOCKING

		new /obj/machinery/power/floodlight(loc)
		qdel(src)
		qdel(tool)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/floodlight_frame/completed
	name = "泛光灯框架"
	desc = "一个看起来像泛光灯的裸露金属框架。还需要一根灯管才能完成。"
	icon_state = "floodlight_c3"
	state = FLOODLIGHT_NEEDS_LIGHTS

/obj/machinery/power/floodlight
	name = "泛光灯"
	desc = "一根装有强力灯具的立柱。由于耗电量很大，必须直接连接到电缆节点供电。"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "floodlight"
	density = TRUE
	max_integrity = 100
	integrity_failure = 0.8
	idle_power_usage = 0
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION
	anchored = FALSE
	light_power = 1.75
	can_change_cable_layer = TRUE

	/// List of power usage multipliers
	var/list/light_setting_list = list(0, 5, 10, 15)
	/// Constant coeff. for power usage
	var/light_power_coefficient = 200
	/// Intensity of the floodlight.
	var/setting = FLOODLIGHT_OFF

/obj/machinery/power/floodlight/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_OBJ_PAINTED, TYPE_PROC_REF(/obj/machinery/power/floodlight, on_color_change))  //update light color when color changes
	register_context()
	if(mapload)
		set_anchored(TRUE)
		connect_to_network()

/obj/machinery/power/floodlight/proc/on_color_change(obj/machinery/power/flood_light, mob/user, obj/item/toy/crayon/spraycan/spraycan, is_dark_color)
	SIGNAL_HANDLER
	if(!spraycan.actually_paints)
		return

	if(setting > FLOODLIGHT_OFF)
		update_light_state()

/obj/machinery/power/floodlight/Destroy()
	UnregisterSignal(src, COMSIG_OBJ_PAINTED)
	. = ..()

/// change light color during operation
/obj/machinery/power/floodlight/proc/update_light_state()
	var/light_color =  NONSENSICAL_VALUE
	if(!isnull(color))
		light_color = color
	if (cached_color_filter)
		light_color = apply_matrix_to_color(COLOR_WHITE, cached_color_filter["color"], cached_color_filter["space"] || COLORSPACE_RGB)
	set_light(light_setting_list[setting], light_power, light_color)

/obj/machinery/power/floodlight/add_context(
	atom/source,
	list/context,
	obj/item/held_item,
	mob/living/user,
)

	if(isnull(held_item))
		if(panel_open)
			context[SCREENTIP_CONTEXT_LMB] = "取下灯管"
			return CONTEXTUAL_SCREENTIP_SET
		return NONE

	var/message = null
	if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
		message = "打开面板"
	else if(held_item.tool_behaviour == TOOL_WRENCH)
		message = anchored ? "松开灯具" : "固定灯具"

	if(isnull(message))
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = message
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/power/floodlight/examine(mob/user)
	. = ..()
	if(!anchored)
		. += span_notice("需要用扳手固定在电缆上方。")
	else
		. += span_notice("当前亮度等级为 [setting]。")
	if(panel_open)
		. += span_notice("维护舱盖已打开，可以[EXAMINE_HINT("拧紧")]合上。")
		. += span_notice("可以[EXAMINE_HINT("徒手")]取下灯管。")
	else
		. += span_notice("维护舱盖可以[EXAMINE_HINT("拧开")]。")

/obj/machinery/power/floodlight/process()
	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = locate() in T
	if(!C && powernet)
		disconnect_from_network()
	if(setting > FLOODLIGHT_OFF) //If on
		if(avail(active_power_usage))
			add_load(active_power_usage)
		else
			change_setting(FLOODLIGHT_OFF)
	else if(avail(idle_power_usage))
		add_load(idle_power_usage)

/obj/machinery/power/floodlight/proc/change_setting(newval, mob/user)
	if((newval < FLOODLIGHT_OFF) || (newval > light_setting_list.len))
		return

	setting = newval
	active_power_usage = light_setting_list[setting] * light_power_coefficient
	if(!avail(active_power_usage) && setting > FLOODLIGHT_OFF)
		return change_setting(setting - 1)
	update_light_state()
	var/setting_text = ""
	if(setting > FLOODLIGHT_OFF)
		icon_state = "[initial(icon_state)]_on"
	else
		icon_state = initial(icon_state)
	switch(setting)
		if(FLOODLIGHT_OFF)
			setting_text = "关闭"
		if(FLOODLIGHT_LOW)
			setting_text = "低功率"
		if(FLOODLIGHT_MED)
			setting_text = "标准照明"
		if(FLOODLIGHT_HIGH)
			setting_text = "高功率"
	if(user)
		to_chat(user, span_notice("你把 [src] 设为[setting_text]。"))

/obj/machinery/power/floodlight/cable_layer_act(mob/living/user, obj/item/tool)
	if(anchored)
		balloon_alert(user, "请先解除固定！")
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/machinery/power/floodlight/wrench_act(mob/living/user, obj/item/tool)
	default_unfasten_wrench(user, tool)
	change_setting(FLOODLIGHT_OFF)
	if(anchored)
		connect_to_network()
	else
		disconnect_from_network()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/floodlight/screwdriver_act(mob/living/user, obj/item/tool)
	if(panel_open)
		panel_open = FALSE
		balloon_alert(user, "已合上面板")
		return ITEM_INTERACT_SUCCESS
	change_setting(FLOODLIGHT_OFF)
	panel_open = TRUE
	balloon_alert(user, "已打开面板")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/floodlight/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(panel_open)
		var/obj/structure/floodlight_frame/floodlight_frame = new(loc)
		floodlight_frame.state = FLOODLIGHT_NEEDS_LIGHTS

		var/obj/item/light/tube/light_tube = new(loc)
		user.put_in_active_hand(light_tube)

		qdel(src)

	var/current = setting
	if(current == FLOODLIGHT_OFF)
		current = light_setting_list.len
	else
		current--
	change_setting(current, user)

/obj/machinery/power/floodlight/attack_robot(mob/user)
	return attack_hand(user)

/obj/machinery/power/floodlight/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/power/floodlight/on_saboteur(datum/source, disrupt_duration)
	. = ..()
	atom_break(ENERGY) // technically,
	return TRUE

/obj/machinery/power/floodlight/atom_break(damage_flag)
	. = ..()
	if(!.)
		return
	playsound(loc, 'sound/effects/glass/glassbr3.ogg', 100, TRUE)

	var/obj/structure/floodlight_frame/floodlight_frame = new(loc)
	floodlight_frame.state = FLOODLIGHT_NEEDS_LIGHTS
	var/obj/item/light/tube/our_light = new(loc)
	our_light.shatter()

	qdel(src)

/obj/machinery/power/floodlight/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	playsound(src, 'sound/effects/glass/glasshit.ogg', 75, TRUE)

#undef FLOODLIGHT_OFF
#undef FLOODLIGHT_LOW
#undef FLOODLIGHT_MED
#undef FLOODLIGHT_HIGH
