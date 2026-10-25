/obj/machinery/atmospherics/components/binary/temperature_gate
	icon_state = "tgate_map-3"
	name = "温度闸门"
	desc = "一种可启用的闸门，会对比输入温度与界面设定温度，以判断气体能否从输入端流向输出端。"
	can_unwrench = TRUE
	shift_underlay_only = FALSE
	construction_type = /obj/item/pipe/directional
	pipe_state = "tgate"
	///If the temperature of the mix before the gate is lower than this, the gas will flow (if inverted, if the temperature of the mix before the gate is higher than this)
	var/target_temperature = T0C
	///Minimum allowed temperature
	var/minimum_temperature = TCMB
	///Maximum allowed temperature to be set
	var/max_temperature = 4500
	///Check if the sensor should let gas pass if temperature in the mix is less/higher than the target one
	var/inverted = FALSE
	///Check if the gas is moving from one pipenet to the other
	var/is_gas_flowing = FALSE

/obj/machinery/atmospherics/components/binary/temperature_gate/Initialize(mapload)
	. = ..()
	register_context()

/obj/machinery/atmospherics/components/binary/temperature_gate/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_CTRL_LMB] = "切换为[on ? "关闭" : "开启"]"
	context[SCREENTIP_CONTEXT_ALT_LMB] = "将目标温度设为最大"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/atmospherics/components/binary/temperature_gate/click_ctrl(mob/user)
	if(is_operational)
		set_on(!on)
		balloon_alert(user, "已[on ? "开启" : "关闭"]")
		investigate_log("被 [key_name(user)] [on ? "开启" : "关闭"]", INVESTIGATE_ATMOS)
		return CLICK_ACTION_SUCCESS
	return CLICK_ACTION_BLOCKING

/obj/machinery/atmospherics/components/binary/temperature_gate/click_alt(mob/user)
	if(target_temperature == max_temperature)
		return CLICK_ACTION_BLOCKING

	target_temperature = max_temperature
	investigate_log("被 [key_name(user)] 设为 [target_temperature] K", INVESTIGATE_ATMOS)
	balloon_alert(user, "目标温度已设为 [target_temperature] K")
	update_appearance(UPDATE_ICON)
	return CLICK_ACTION_SUCCESS


/obj/machinery/atmospherics/components/binary/temperature_gate/examine(mob/user)
	. = ..()
	. += "当输入气体的温度[inverted ? "高于" : "低于"]界面设定温度时，该设备会允许气体通过。"
	if(inverted)
		. += "使用多功能工具作用于该设备，可恢复设备的设置。"
	else
		. += "使用多功能工具作用于该设备，可更改传感器的设置。"

/obj/machinery/atmospherics/components/binary/temperature_gate/update_icon_nopipes()
	if(on && is_operational && is_gas_flowing)
		icon_state = "tgate_flow-[set_overlay_offset(piping_layer)]"
	else if(on && is_operational && !is_gas_flowing)
		icon_state = "tgate_on-[set_overlay_offset(piping_layer)]"
	else
		icon_state = "tgate_off-[set_overlay_offset(piping_layer)]"


/obj/machinery/atmospherics/components/binary/temperature_gate/process_atmos()
	if(!on || !is_operational)
		return

	var/datum/gas_mixture/input_air = airs[1]
	var/datum/gas_mixture/output_air = airs[2]
	var/datum/gas_mixture/output_pipenet_air = parents[2].air

	if(!inverted)
		if(input_air.temperature < target_temperature)
			if(input_air.release_gas_to(output_air, input_air.return_pressure(), output_pipenet_air = output_pipenet_air))
				update_parents()
				is_gas_flowing = TRUE
		else
			is_gas_flowing = FALSE
	else
		if(input_air.temperature > target_temperature)
			if(input_air.release_gas_to(output_air, input_air.return_pressure(), output_pipenet_air = output_pipenet_air))
				update_parents()
				is_gas_flowing = TRUE
		else
			is_gas_flowing = FALSE
	update_icon_nopipes()

/obj/machinery/atmospherics/components/binary/temperature_gate/relaymove(mob/living/user, direction)
	if(!on || direction != dir)
		return
	. = ..()

/obj/machinery/atmospherics/components/binary/temperature_gate/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AtmosTempGate", name)
		ui.open()

/obj/machinery/atmospherics/components/binary/temperature_gate/ui_data()
	var/data = list()
	data["on"] = on
	data["temperature"] = round(target_temperature)
	data["min_temperature"] = round(minimum_temperature)
	data["max_temperature"] = round(max_temperature)
	return data

/obj/machinery/atmospherics/components/binary/temperature_gate/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("power")
			set_on(!on)
			investigate_log("被 [key_name(usr)] [on ? "开启" : "关闭"]", INVESTIGATE_ATMOS)
			. = TRUE
		if("temperature")
			var/temperature = params["temperature"]
			if(temperature == "max")
				temperature = max_temperature
				. = TRUE
			else if(text2num(temperature) != null)
				temperature = text2num(temperature)
				. = TRUE
			if(.)
				target_temperature = clamp(minimum_temperature, temperature, max_temperature)
				investigate_log("被 [key_name(usr)] 设为 [target_temperature] K", INVESTIGATE_ATMOS)
	update_appearance(UPDATE_ICON)

/obj/machinery/atmospherics/components/binary/temperature_gate/can_unwrench(mob/user)
	. = ..()
	if(. && on && is_operational)
		to_chat(user, span_warning("你无法用扳手拆下 [src]，请先将其关闭！"))
		return FALSE

/obj/machinery/atmospherics/components/binary/temperature_gate/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I))
		inverted = !inverted
		if(inverted)
			to_chat(user, span_notice("你将 [src] 的传感器设置为：当温度高于设定值时释放气体。"))
		else
			to_chat(user, span_notice("你将 [src] 的传感器恢复为默认设置。"))
	return TRUE

//mapping

/obj/machinery/atmospherics/components/binary/temperature_gate/layer2
	piping_layer = 2
	icon_state = "tgate_map-2"

/obj/machinery/atmospherics/components/binary/temperature_gate/layer4
	piping_layer = 4
	icon_state = "tgate_map-4"
