/**
 * This file contain the eight parts surrounding the main core, those are: fuel input, moderator input, waste output, interface and the corners
 * The file also contain the guicode of the machine
 */
/obj/machinery/atmospherics/components/unary/hypertorus
	icon = 'icons/obj/machines/atmospherics/hypertorus.dmi'
	icon_state = "core"
	base_icon_state = "core"

	name = "温度机"
	desc = "加热或冷却相连管道中的气体。"
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	layer = OBJ_LAYER
	pipe_flags = PIPING_ONE_PER_TURF | PIPING_DEFAULT_LAYER_ONLY
	circuit = /obj/item/circuitboard/machine/thermomachine
	///Check if the machine has been activated
	var/active = FALSE
	///Check if fusion has started
	var/fusion_started = FALSE
	///Check if the machine is cracked open
	var/cracked = FALSE

/obj/machinery/atmospherics/components/unary/hypertorus/Initialize(mapload)
	. = ..()
	initialize_directions = dir

/obj/machinery/atmospherics/components/unary/hypertorus/examine(mob/user)
	. = ..()
	. += span_notice("[src] 可先用螺丝刀打开面板，再对其使用扳手来旋转。")

/obj/machinery/atmospherics/components/unary/hypertorus/screwdriver_act(mob/living/user, obj/item/tool)
	return fusion_started ? NONE : default_deconstruction_screwdriver(user, tool)

/obj/machinery/atmospherics/components/unary/hypertorus/wrench_act(mob/living/user, obj/item/I)
	return default_change_direction_wrench(user, I)

/obj/machinery/atmospherics/components/unary/hypertorus/welder_act(mob/living/user, obj/item/tool)
	if(!cracked)
		return FALSE
	if(user.combat_mode)
		return FALSE
	balloon_alert(user, "修理中……")
	if(tool.use_tool(src, user, 10 SECONDS, volume=30))
		balloon_alert(user, "已修复")
		cracked = FALSE
		update_appearance(UPDATE_ICON)

/obj/machinery/atmospherics/components/unary/hypertorus/crowbar_act(mob/living/user, obj/item/tool)
	return crowbar_deconstruction_act(user, tool)

/obj/machinery/atmospherics/components/unary/hypertorus/update_icon_state()
	if(panel_open)
		icon_state = "[base_icon_state]_open"
		return ..()
	icon_state = base_icon_state
	return ..()

/obj/machinery/atmospherics/components/unary/hypertorus/update_overlays()
	. = ..()
	if(cracked)
		. += image(icon, "crack", dir = src.dir)
	if(active)
		. += "[base_icon_state]_active"
		. += emissive_appearance(icon, "[base_icon_state]_active", src, alpha = src.alpha)

/obj/machinery/atmospherics/components/unary/hypertorus/update_layer()
	return

/obj/machinery/atmospherics/components/unary/hypertorus/fuel_input
	name = "HFR 燃料输入口"
	desc = "超环面聚变反应堆的输入口，用于接收燃料，最佳燃料配比为 50/50。"
	icon_state = "fuel_input"
	base_icon_state = "fuel_input"
	circuit = /obj/item/circuitboard/machine/HFR_fuel_input

/obj/machinery/atmospherics/components/unary/hypertorus/waste_output
	name = "HFR 废气输出口"
	desc = "超环面聚变反应堆的废气口，用于排出机器核心产生的高温废气。"
	icon_state = "waste_output"
	base_icon_state = "waste_output"
	circuit = /obj/item/circuitboard/machine/HFR_waste_output

/obj/machinery/atmospherics/components/unary/hypertorus/moderator_input
	name = "HFR 慢化剂输入口"
	desc = "超环面聚变反应堆的慢化剂口，用于在机器内部输送气体，以冷却并控制反应进程。"
	icon_state = "moderator_input"
	base_icon_state = "moderator_input"
	circuit = /obj/item/circuitboard/machine/HFR_moderator_input

/*
* Interface and corners
*/
/obj/machinery/hypertorus
	name = "超环面核心"
	desc = "超环面核心"
	icon = 'icons/obj/machines/atmospherics/hypertorus.dmi'
	icon_state = "core"
	base_icon_state = "core"
	move_resist = INFINITY
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	power_channel = AREA_USAGE_ENVIRON
	var/active = FALSE
	var/fusion_started = FALSE

/obj/machinery/hypertorus/examine(mob/user)
	. = ..()
	. += span_notice("[src] 可先用螺丝刀打开面板，再对其使用扳手来旋转。")

/obj/machinery/hypertorus/screwdriver_act(mob/living/user, obj/item/tool)
	return fusion_started ? NONE : default_deconstruction_screwdriver(user, tool)

/obj/machinery/hypertorus/wrench_act(mob/living/user, obj/item/tool)
	return default_change_direction_wrench(user, tool)

/obj/machinery/hypertorus/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(user, tool)

/obj/machinery/hypertorus/update_icon_state()
	if(panel_open)
		icon_state = "[base_icon_state]_open"
		return ..()
	icon_state = base_icon_state
	return ..()

/obj/machinery/hypertorus/update_overlays()
	. = ..()
	if(active)
		. += "[base_icon_state]_active"
		. += emissive_appearance(icon, "[base_icon_state]_active", src, alpha = src.alpha)

/obj/machinery/hypertorus/interface
	name = "HFR 接口"
	desc = "HFR 的控制接口，用于调节反应进程。"
	icon_state = "interface"
	base_icon_state = "interface"
	circuit = /obj/item/circuitboard/machine/HFR_interface
	/// Have we been activated at least once?
	var/activated = FALSE
	/// Reference to the core of our machine
	var/obj/machinery/atmospherics/components/unary/hypertorus/core/connected_core

/obj/machinery/hypertorus/interface/Destroy()
	if(connected_core)
		connected_core = null
	return..()

/obj/machinery/hypertorus/interface/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	var/turf/T = get_step(src,REVERSE_DIR(dir))
	var/obj/machinery/atmospherics/components/unary/hypertorus/core/centre = locate() in T

	if(!centre || !centre.check_part_connectivity())
		to_chat(user, span_notice("检查所有部件，然后重试。"))
		return TRUE

	connected_core = centre
	connected_core.activate(user)
	if(!activated)
		new /obj/item/paper/guides/jobs/atmos/hypertorus(loc)
		activated = TRUE

	return TRUE

/obj/machinery/hypertorus/interface/ui_interact(mob/user, datum/tgui/ui)
	if(active)
		ui = SStgui.try_update_ui(user, src, ui)
		if(!ui)
			ui = new(user, src, "Hypertorus", name)
			ui.open()
	else
		to_chat(user, span_notice("请先对接口使用多功能工具以启动机器。"))
		ui.close()

/obj/machinery/hypertorus/interface/proc/gas_list_to_gasid_list(list/gas_list)
	var/list/gasid_list = list()
	for(var/gas_type in gas_list)
		var/datum/gas/gas = gas_type
		gasid_list += initial(gas.id)
	return gasid_list



/obj/machinery/hypertorus/interface/ui_static_data()
	var/data = list()
	data["base_max_temperature"] = FUSION_MAXIMUM_TEMPERATURE
	data["selectable_fuel"] = list(list("name" = "无", "id" = null))
	for(var/path in GLOB.hfr_fuels_list)
		var/datum/hfr_fuel/recipe = GLOB.hfr_fuels_list[path]

		data["selectable_fuel"] += list(list(
			"name" = recipe.name,
			"id" = recipe.id,
			"requirements" = gas_list_to_gasid_list(recipe.requirements),
			"fusion_byproducts" = gas_list_to_gasid_list(recipe.primary_products),
			"product_gases" = gas_list_to_gasid_list(recipe.secondary_products),
			"recipe_cooling_multiplier" = recipe.negative_temperature_multiplier,
			"recipe_heating_multiplier" = recipe.positive_temperature_multiplier,
			"energy_loss_multiplier" = recipe.energy_concentration_multiplier,
			"fuel_consumption_multiplier" = recipe.fuel_consumption_multiplier,
			"gas_production_multiplier" = recipe.gas_production_multiplier,
			"temperature_multiplier" = recipe.temperature_change_multiplier,
		))
	return data

/obj/machinery/hypertorus/interface/ui_data()
	var/data = list()

	if(connected_core.selected_fuel)
		data["selected"] = connected_core.selected_fuel.id
	else
		data["selected"] = ""

	//Internal Fusion gases
	var/list/fusion_gasdata = list()
	if(connected_core.internal_fusion.total_moles())
		for(var/gas_type in connected_core.internal_fusion.moles)
			var/datum/gas/gas = gas_type
			fusion_gasdata.Add(list(list(
			"id"= initial(gas.id),
			"amount" = round(connected_core.internal_fusion.moles[gas], 0.01),
			)))
	else
		for(var/gas_type in connected_core.internal_fusion.moles)
			var/datum/gas/gas = gas_type
			fusion_gasdata.Add(list(list(
				"id"= initial(gas.id),
				"amount" = 0,
				)))
	//Moderator gases
	var/list/moderator_gasdata = list()
	if(connected_core.moderator_internal.total_moles())
		for(var/gas_type in connected_core.moderator_internal.moles)
			var/datum/gas/gas = gas_type
			moderator_gasdata.Add(list(list(
			"id"= initial(gas.id),
			"amount" = round(connected_core.moderator_internal.moles[gas], 0.01),
			)))
	else
		for(var/gas_type in connected_core.moderator_internal.moles)
			var/datum/gas/gas = gas_type
			moderator_gasdata.Add(list(list(
				"id"= initial(gas.id),
				"amount" = 0,
				)))

	data["fusion_gases"] = fusion_gasdata
	data["moderator_gases"] = moderator_gasdata

	data["energy_level"] = connected_core.energy
	data["heat_limiter_modifier"] = connected_core.heat_limiter_modifier
	data["heat_output_min"] = connected_core.heat_output_min
	data["heat_output_max"] = connected_core.heat_output_max
	data["heat_output"] = connected_core.heat_output
	data["instability"] = connected_core.instability

	data["heating_conductor"] = connected_core.heating_conductor
	data["magnetic_constrictor"] = connected_core.magnetic_constrictor
	data["fuel_injection_rate"] = connected_core.fuel_injection_rate
	data["moderator_injection_rate"] = connected_core.moderator_injection_rate
	data["current_damper"] = connected_core.current_damper

	data["power_level"] = connected_core.power_level
	data["apc_energy"] = connected_core.get_area_cell_percent()
	data["iron_content"] = connected_core.iron_content
	data["integrity"] = connected_core.get_integrity_percent()

	data["start_power"] = connected_core.start_power
	data["start_cooling"] = connected_core.start_cooling
	data["start_fuel"] = connected_core.start_fuel
	data["start_moderator"] = connected_core.start_moderator

	data["internal_fusion_temperature"] = connected_core.fusion_temperature
	data["moderator_internal_temperature"] = connected_core.moderator_temperature
	data["internal_output_temperature"] = connected_core.output_temperature
	data["internal_coolant_temperature"] = connected_core.coolant_temperature

	data["internal_fusion_temperature_archived"] = connected_core.fusion_temperature_archived
	data["moderator_internal_temperature_archived"] = connected_core.moderator_temperature_archived
	data["internal_output_temperature_archived"] = connected_core.output_temperature_archived
	data["internal_coolant_temperature_archived"] = connected_core.coolant_temperature_archived
	data["temperature_period"] = connected_core.temperature_period

	data["waste_remove"] = connected_core.waste_remove
	data["filter_types"] = list()
	var/cached_gas_info = GLOB.meta_gas_info
	for(var/path in cached_gas_info[META_GAS_ID])
		data["filter_types"] += list(list(
			"gas_id" = cached_gas_info[META_GAS_ID][path],
			"gas_name" = cached_gas_info[META_GAS_NAME][path],
			"enabled" = (path in connected_core.moderator_scrubbing)
		))

	data["cooling_volume"] = connected_core.airs[1].volume
	data["mod_filtering_rate"] = connected_core.moderator_filtering_rate

	return data

/obj/machinery/hypertorus/interface/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("start_power")
			connected_core.start_power = !connected_core.start_power
			connected_core.update_use_power(connected_core.start_power ? ACTIVE_POWER_USE : IDLE_POWER_USE)
			. = TRUE
		if("start_cooling")
			connected_core.start_cooling = !connected_core.start_cooling
			. = TRUE
		if("start_fuel")
			connected_core.start_fuel = !connected_core.start_fuel
			. = TRUE
		if("start_moderator")
			connected_core.start_moderator = !connected_core.start_moderator
			. = TRUE
		if("heating_conductor")
			var/heating_conductor = text2num(params["heating_conductor"])
			if(heating_conductor != null)
				connected_core.heating_conductor = clamp(heating_conductor, 50, 500)
				. = TRUE
		if("magnetic_constrictor")
			var/magnetic_constrictor = text2num(params["magnetic_constrictor"])
			if(magnetic_constrictor != null)
				connected_core.magnetic_constrictor = clamp(magnetic_constrictor, 50, 1000)
				. = TRUE
		if("fuel_injection_rate")
			var/fuel_injection_rate = text2num(params["fuel_injection_rate"])
			if(fuel_injection_rate != null)
				connected_core.fuel_injection_rate = clamp(fuel_injection_rate, 0.5, 150)
				. = TRUE
		if("moderator_injection_rate")
			var/moderator_injection_rate = text2num(params["moderator_injection_rate"])
			if(moderator_injection_rate != null)
				connected_core.moderator_injection_rate = clamp(moderator_injection_rate, 0.5, 150)
				. = TRUE
		if("current_damper")
			var/current_damper = text2num(params["current_damper"])
			if(current_damper != null)
				connected_core.current_damper = clamp(current_damper, 0, 1000)
				. = TRUE
		if("waste_remove")
			connected_core.waste_remove = !connected_core.waste_remove
			. = TRUE
		if("filter")
			connected_core.moderator_scrubbing ^= gas_id2path(params["mode"])
			. = TRUE
		if("mod_filtering_rate")
			var/mod_filtering_rate = text2num(params["mod_filtering_rate"])
			if(mod_filtering_rate != null)
				connected_core.moderator_filtering_rate = clamp(mod_filtering_rate, 5, 200)
				. = TRUE
		if("fuel")
			connected_core.selected_fuel = null
			var/fuel_mix = "nothing"
			var/datum/hfr_fuel/fuel = null
			if(params["mode"] != "")
				fuel = GLOB.hfr_fuels_list[params["mode"]]
			if(fuel)
				connected_core.selected_fuel = fuel
				fuel_mix = fuel.name
			if(connected_core.internal_fusion.total_moles())
				connected_core.dump_gases()
			connected_core.update_parents() //prevent the machine from stopping because of the recipe change and the pipenet not updating
			connected_core.linked_input.update_parents()
			connected_core.linked_output.update_parents()
			connected_core.linked_moderator.update_parents()
			investigate_log("被 [key_name(usr)] 设置为配方 [fuel_mix ? fuel_mix : "null"]", INVESTIGATE_ATMOS)
			. = TRUE
		if("cooling_volume")
			var/cooling_volume = text2num(params["cooling_volume"])
			if(cooling_volume != null)
				connected_core.airs[1].volume = clamp(cooling_volume, 50, 2000)
				. = TRUE

/obj/machinery/hypertorus/corner
	name = "HFR 角落部件"
	desc = "机器的结构部件。"
	icon_state = "corner"
	base_icon_state = "corner"
	circuit = /obj/item/circuitboard/machine/HFR_corner

/obj/item/paper/guides/jobs/atmos/hypertorus
	name = "纸张-‘HFR 安全操作速查指南’"
	default_raw_text = "<B>如何安全（大概）地操作超环面反应堆</B><BR>\
	-按照主指南所示建造该机器。<BR>\
	-配制氚与氢各占一半、总量约 2000 摩尔的气体混合物。<BR>\
	-启动机器，用等离子体/超惰性气体充满冷却回路，并利用太空或冷冻机为其降温。<BR>\
	-将燃料混合物接入燃料注入口，只允许约 1000 摩尔进入机器，以便顺利启动反应<BR>\
	-启动反应时将导热器设为 500，当功率等级高于 1 后调回 100<BR>\
	-若发生熔毁，将导热器调到最大、电流阻尼器调到最大，燃料注入调到最小。\
	如果热输出没有变为负值，尝试调整磁收缩器，直到热输出变为负值。\
	加强冷却，在慢化剂中注入高热容气体（超惰性气体有助于应对该问题）<BR><BR>\
	<B>警告：</B><BR>\
	-功率等级高于 0 时无法拆解该机器<BR>\
	-功率等级高于 0 时无法关闭该机器<BR>\
	-功率等级高于 5 时无法排放废气<BR>\
	-若聚变混合物中的气体不是氦和反惰性气体，则无法将其抽出<BR>\
	-超惰性气体会大幅降低混合物的功率<BR>\
	-反惰性气体则会大幅提高混合物的功率<BR>\
	-高热容气体更难加热/冷却<BR>\
	-低热容气体更易加热/冷却<BR>\
	-机器每级功率消耗 50 KW，功率等级 6 时达到 350 KW，请据此准备超物质<BR>\
	-若出现电力短缺，聚变反应会继续，但冷却会停止<BR><BR>\
	本速查指南的作者不对因使用本指南而导致的误操作与熔毁负责，\
	请使用更高级的指南来了解各种气体作为慢化剂的作用。"

/obj/item/hfr_box
	name = "HFR 箱体"
	desc = "如果你看到这个，快报警。"
	icon = 'icons/obj/machines/atmospherics/hypertorus.dmi'
	icon_state = "error"
	///What kind of box are we handling?
	var/box_type = "impossible"
	///What's the path of the machine we making
	var/part_path

/obj/item/hfr_box/corner
	name = "HFR 角落箱体"
	desc = "将其放置为 3x3 多方块聚变反应堆的角落"
	icon_state = "box_corner"
	box_type = "corner"
	part_path = /obj/machinery/hypertorus/corner

/obj/item/hfr_box/body
	name = "HFR 主体箱体"
	desc = "将其放置在 3x3 多方块聚变反应堆核心箱体的侧面"
	box_type = "body"
	icon_state = "box_body"

/obj/item/hfr_box/body/fuel_input
	name = "HFR 箱体燃料输入"
	icon_state = "box_fuel"
	part_path = /obj/machinery/atmospherics/components/unary/hypertorus/fuel_input

/obj/item/hfr_box/body/moderator_input
	name = "HFR 箱体慢化剂输入"
	icon_state = "box_moderator"
	part_path = /obj/machinery/atmospherics/components/unary/hypertorus/moderator_input

/obj/item/hfr_box/body/waste_output
	name = "HFR 箱体废气输出"
	icon_state = "box_waste"
	part_path = /obj/machinery/atmospherics/components/unary/hypertorus/waste_output

/obj/item/hfr_box/body/interface
	name = "HFR 箱体接口"
	part_path = /obj/machinery/hypertorus/interface

/obj/item/hfr_box/core
	name = "HFR 箱体核心"
	desc = "布置好其他箱体后，用多功能工具激活此物以展开完整机器"
	icon_state = "box_core"
	box_type = "core"
	part_path = /obj/machinery/atmospherics/components/unary/hypertorus/core

/obj/item/hfr_box/core/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	var/list/parts = list()
	for(var/obj/item/hfr_box/box in orange(1,src))
		var/direction = get_dir(src, box)
		if(box.box_type == "corner")
			if(ISDIAGONALDIR(direction))
				switch(direction)
					if(NORTHEAST)
						direction = EAST
					if(SOUTHEAST)
						direction = SOUTH
					if(SOUTHWEST)
						direction = WEST
					if(NORTHWEST)
						direction = NORTH
				box.dir = direction
				parts |= box
			continue
		if(box.box_type == "body")
			if(direction in GLOB.cardinals)
				box.dir = direction
				parts |= box
			continue
	if(parts.len == 8)
		build_reactor(parts)
	return

/obj/item/hfr_box/core/proc/build_reactor(list/parts)
	for(var/obj/item/hfr_box/box in parts)
		if(box.box_type == "corner")
			var/obj/machinery/hypertorus/corner/corner = new box.part_path(box.loc)
			corner.dir = box.dir
			qdel(box)
			continue
		if(box.box_type == "body")
			var/location = get_turf(box)
			if(box.part_path != /obj/machinery/hypertorus/interface)
				var/obj/machinery/atmospherics/components/unary/hypertorus/part = new box.part_path(location, TRUE, box.dir)
				part.dir = box.dir
			else
				var/obj/machinery/hypertorus/interface/part = new box.part_path(location)
				part.dir = box.dir
			qdel(box)
			continue

	new/obj/machinery/atmospherics/components/unary/hypertorus/core(loc, TRUE)
	qdel(src)
