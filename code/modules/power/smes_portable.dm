// idea inspired by vgstation, original pr on github vgstation-coders/vgstation13#4555

/obj/machinery/power/smes/connector
	name = "电力接口"
	desc = "一个对使用者安全的大电流接触端口，用于连接便携式储能单元并与之对接。没有它，那些单元基本毫无用处。"
	icon_state = "battery_port"
	base_icon_state = "battery_port"
	circuit = /obj/item/circuitboard/machine/smes/connector
	density = FALSE
	input_attempt = FALSE
	output_attempt = FALSE
	show_display_lights = FALSE

	///The smes this connector is connected with
	var/obj/machinery/smesbank/connected_smes

/obj/machinery/power/smes/connector/Destroy()
	connected_smes?.disconnect_port() // in the unlikely but possible case a SMES is connected and this explodes
	return ..()

/obj/machinery/power/smes/connector/update_appearance(updates)
	. = ..()
	connected_smes?.update_appearance(updates)

/obj/machinery/power/smes/connector/update_overlays()
	. = ..()
	if(!connected_smes)
		return

	if(inputting)
		. += "bp-c"
	else
		if(total_charge() > 0)
			. += "bp-o"
		else
			. += "bp-d"

/obj/machinery/power/smes/connector/RefreshParts()
	. = ..()

	//happens if the terminal gets rped without a bank attached. No division by zero error
	if(!total_capacity)
		total_capacity = 1

/obj/machinery/power/smes/connector/wrench_act(mob/living/user, obj/item/tool)
	if(!connector_free(user))
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/machinery/power/smes/connector/screwdriver_act(mob/living/user, obj/item/tool)
	if(!connector_free(user))
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/machinery/power/smes/connector/crowbar_act(mob/living/user, obj/item/tool)
	if(!connector_free(user))
		return ITEM_INTERACT_BLOCKING
	return ..()

/**
 * Checks if the connector is free
 * Arguments
 *
 * * mob/living/user - the player doing the checking
 */
/obj/machinery/power/smes/connector/proc/connector_free(mob/living/user)
	PRIVATE_PROC(TRUE)

	if(connected_smes)
		balloon_alert(user, "请先断开 SMES！")
		return FALSE
	return TRUE

/**
 * Connects the power bank to the smes
 * Arguments
 *
 * * obj/machinery/power/smesbank/bank - the bank to connect
 */
/obj/machinery/power/smes/connector/proc/connect_smes(obj/machinery/smesbank/bank)
	SHOULD_NOT_OVERRIDE(TRUE)

	connected_smes = bank
	if(connected_smes)
		total_capacity = 0
		for(var/obj/item/stock_parts/power_store/power_cell in connected_smes.component_parts)
			component_parts += power_cell
			total_capacity += power_cell.max_charge()
	else
		inputting = FALSE
		outputting = FALSE
		total_capacity = 1
		for(var/obj/item/stock_parts/power_store/power_cell in component_parts)
			component_parts -= power_cell
		SStgui.close_uis(src)
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/power/smes/connector/ui_interact(mob/user, datum/tgui/ui)
	if(!connected_smes)
		balloon_alert(user, "没有储能单元！")
		return FALSE

	return ..()

/obj/machinery/power/smes/connector/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	return connected_smes ? ..() : FALSE

/// The actual portable part of the portable SMES system. Pretty useless without an actual connector.
/obj/machinery/smesbank
	name = "便携式储能单元"
	desc = "一台便携式大容量超导磁储能（SMES）单元。需要单独的电力接口端口才能真正接入电网。"
	icon = 'icons/obj/machines/engine/other.dmi'
	icon_state = "port_smes"
	base_icon_state = "port_smes"
	circuit = /obj/item/circuitboard/machine/smesbank
	use_power = NO_POWER_USE // well, technically
	density = TRUE
	anchored = FALSE

	/// The initial charge of this smes charge.
	var/charge = 0
	/// The port this is connected to.
	var/obj/machinery/power/smes/connector/connected_port

/obj/machinery/smesbank/Initialize(mapload)
	. = ..()

	///Initial connection for mapload, We attempt to locate the connector but only connect to it after it has initialized
	if(mapload)
		connected_port = locate() in loc

	///Initial charge
	if(charge)
		for(var/obj/item/stock_parts/power_store/power_cell in component_parts)
			power_cell.use(power_cell.charge())
			if(charge)
				charge -= power_cell.give(charge)
		charge = 0

	register_context()

/obj/machinery/smesbank/post_machine_initialize()
	. = ..()

	//we somehow located an deleted port or no port at all. clear out
	if(QDELETED(connected_port))
		connected_port = null
		return

	//connect to the port located during mapload
	var/obj/machinery/power/smes/connector/possible_connector = connected_port
	connected_port = null
	if(!connect_port(possible_connector))
		return
	connected_port.input_attempt = TRUE
	connected_port.output_attempt = TRUE

/obj/machinery/smesbank/on_construction(mob/user)
	set_anchored(FALSE)

/obj/machinery/smesbank/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = NONE
	if(isnull(held_item))
		return

	if(held_item.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = "[connected_port ? "断开" : "连接"]"
		return CONTEXTUAL_SCREENTIP_SET
	if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
		context[SCREENTIP_CONTEXT_LMB] = "[panel_open ? "关闭" : "打开"]面板"
		return CONTEXTUAL_SCREENTIP_SET
	if(held_item.tool_behaviour == TOOL_CROWBAR && panel_open && !connected_port)
		context[SCREENTIP_CONTEXT_LMB] = "拆解"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/smesbank/examine(user)
	. = ..()
	. += span_notice("它的维护面板可以[EXAMINE_HINT("用螺丝刀")][panel_open ? "拧上" : "拧开"]。")
	if(connected_port)
		. += span_notice("拆解前需要先用[EXAMINE_HINT("扳手")]把它从端口上卸下。")
	else
		if(panel_open)
			. += span_notice("它可以用[EXAMINE_HINT("撬棍")]撬开。")
		. += span_notice("需要先用[EXAMINE_HINT("扳手")]把它固定到接口端口上才能运行。")

/obj/machinery/smesbank/Destroy()
	disconnect_port()
	return ..()

/obj/machinery/smesbank/update_overlays()
	. = ..()
	if(panel_open || !is_operational)
		return

	if(connected_port)
		. += "smes-op[connected_port.outputting ? 1 : 0]"
		. += "smes-oc[connected_port.inputting ? 1 : 0]"
		var/clevel = connected_port.chargedisplay()
		if(clevel > 0)
			. += "smes-og[clevel]"

/obj/machinery/smesbank/interact(mob/user)
	. = ..()
	connected_port?.interact(user)

// adapted from portable atmos connection code
/obj/machinery/smesbank/wrench_act(mob/living/user, obj/item/wrench)
	if(connected_port)
		if(!wrench.use_tool(src, user, 8 SECONDS))
			return ITEM_INTERACT_BLOCKING
		user.visible_message( \
			"[user] 断开了 [src]。", \
			span_notice("你把 [src] 从 [connected_port] 上卸下。"), \
			span_hear("你听到棘轮声。"))
		investigate_log("被 [key_name(user)] 从 [connected_port] 上断开。", INVESTIGATE_ENGINE)
		disconnect_port()
		update_appearance(UPDATE_OVERLAYS)
		return ITEM_INTERACT_SUCCESS

	var/obj/machinery/power/smes/connector/possible_connector = locate(/obj/machinery/power/smes/connector) in loc
	if(!wrench.use_tool(src, user, 4 SECONDS, extra_checks = CALLBACK(src, PROC_REF(connect_port), possible_connector, user, TRUE)))
		return ITEM_INTERACT_BLOCKING
	if(!connect_port(possible_connector, user))
		return ITEM_INTERACT_BLOCKING
	user.visible_message( \
		"[user] 连接了 [src]。", \
		span_notice("你把 [src] 固定到 [possible_connector] 上。"), \
		span_hear("你听到棘轮声。"))
	update_appearance(UPDATE_OVERLAYS)
	investigate_log("被 [key_name(user)] 连接到 [possible_connector]。", INVESTIGATE_ENGINE)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/smesbank/update_icon_state()
	. = ..()
	icon_state = panel_open ? "[base_icon_state]-o" : base_icon_state

/obj/machinery/smesbank/screwdriver_act(mob/living/user, obj/item/tool)
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/smesbank/crowbar_act(mob/living/user, obj/item/tool)
	if(connected_port)
		balloon_alert(user, "请先从 [connected_port] 上断开！")
		return ITEM_INTERACT_FAILURE

	return default_deconstruction_crowbar(user, tool)

/**
 * Attempt to connect the portable SMES to a given connector. Adapted from portable atmos connection code.
 *
 * Arguments
 * * obj/machinery/power/smes/connector/possible_connector - the connector we are trying to link with
 * * mob/living/user - the mob trying to connect the port
 * * check_only - don't connect but check if we can
 */
/obj/machinery/smesbank/proc/connect_port(obj/machinery/power/smes/connector/possible_connector, mob/living/user, check_only = FALSE)
	PRIVATE_PROC(TRUE)

	if(QDELETED(possible_connector))
		if(user)
			balloon_alert(user, "没有接口！")
		return FALSE

	//Make sure not already connected to something else
	if(possible_connector.panel_open)
		if(user)
			balloon_alert(user, "请先合上接口面板！")
		return FALSE

	//Perform the connection
	if(check_only)
		return TRUE
	connected_port = possible_connector
	connected_port.connect_smes(src)
	set_anchored(TRUE)
	update_appearance(UPDATE_OVERLAYS)
	return TRUE

/// Disconnects the portable SMES from its assigned connector, if it has any. Also adapted from portable atmos connection code.
/obj/machinery/smesbank/proc/disconnect_port()
	SHOULD_NOT_OVERRIDE(TRUE)

	if(!connected_port)
		return

	connected_port.connect_smes(null)
	connected_port = null
	set_anchored(FALSE)
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/smesbank/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return

	///Drain the charge
	var/charge_adjust = STANDARD_BATTERY_CHARGE / severity
	for(var/obj/item/stock_parts/power_store/power_cell in component_parts)
		charge_adjust -= power_cell.use(charge_adjust, TRUE)
		if(!charge_adjust)
			break

/obj/machinery/smesbank/super
	name = "超大容量储能单元"
	desc = "一台便携式超大容量超导磁储能（SMES）单元。相当稀有，通常安装在预期几乎无需维护的远程前哨站。"
	circuit = /obj/item/circuitboard/machine/smesbank/super

/obj/machinery/smesbank/super/full
	charge = 100 * STANDARD_BATTERY_CHARGE
