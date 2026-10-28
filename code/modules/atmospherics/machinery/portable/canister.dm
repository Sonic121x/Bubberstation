///The default pressure for releasing air into an holding tank or the turf
#define CAN_DEFAULT_RELEASE_PRESSURE (ONE_ATMOSPHERE)
///The temperature resistance of this canister
#define TEMPERATURE_RESISTANCE (1000 + T0C)

/obj/machinery/portable_atmospherics/canister
	name = "气罐"
	desc = "用于储存气体的气罐。"
	icon = 'icons/map_icons/objects.dmi'
	icon_state = "/obj/machinery/portable_atmospherics/canister"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister
	greyscale_colors = "#6b6b80"
	density = TRUE
	volume = 2000
	armor_type = /datum/armor/portable_atmospherics_canister
	max_integrity = 300
	integrity_failure = 0.4
	pressure_resistance = 7 * ONE_ATMOSPHERE
	req_access = list()
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

	///Is the valve open?
	var/valve_open = FALSE
	///Used to log opening and closing of the valve, available on VV
	var/release_log = ""
	///How much the canister should be filled (recommended from 0 to 1)
	var/filled = 0.5
	///Maximum pressure allowed on initialize inside the canister, multiplied by the filled var
	var/maximum_pressure = 90 * ONE_ATMOSPHERE
	///Stores the path of the gas for mapped canisters
	var/datum/gas/gas_type
	///Player controlled var that set the release pressure of the canister
	var/release_pressure = ONE_ATMOSPHERE
	///Window overlay showing the gas inside the canister
	var/image/window
	///Is shielding turned on/off
	var/shielding_powered = FALSE
	///The powercell used to enable shielding
	var/obj/item/stock_parts/power_store/internal_cell
	///used while processing to update appearance only when its pressure state changes
	var/current_pressure_state

/datum/armor/portable_atmospherics_canister
	melee = 50
	bullet = 50
	laser = 50
	energy = 100
	bomb = 10
	fire = 80
	acid = 50

/obj/machinery/portable_atmospherics/canister/get_save_vars()
	. = ..()
	. += NAMEOF(src, valve_open)
	. += NAMEOF(src, release_pressure)
	return .

/obj/machinery/portable_atmospherics/canister/Initialize(mapload)
	. = ..()

	if(mapload)
		internal_cell = new /obj/item/stock_parts/power_store/cell/high(src)

	if(!initial_gas_mix)
		create_gas()

	if(ispath(gas_type, /datum/gas))
		desc = "[GLOB.meta_gas_info[META_GAS_NAME][gas_type]]. [GLOB.meta_gas_info[META_GAS_DESC][gas_type]]"

	update_window()

	var/random_quality = rand()
	pressure_limit = initial(pressure_limit) * (1 + 0.2 * random_quality)

	update_appearance()
	AddElement(/datum/element/atmos_sensitive, mapload)
	AddElement(/datum/element/volatile_gas_storage)
	AddComponent(/datum/component/gas_leaker, leak_rate=0.01)

/obj/machinery/portable_atmospherics/canister/interact(mob/user)
	. = ..()
	if(!allowed(user))
		to_chat(user, span_alert("错误——未授权用户。"))
		playsound(src, 'sound/machines/compiler/compiler-failure.ogg', 50, TRUE)
		return

/obj/machinery/portable_atmospherics/canister/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(holding)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "取出气瓶"
	if(!held_item)
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/stock_parts/power_store/cell))
		context[SCREENTIP_CONTEXT_LMB] = "装入电池"
	switch(held_item.tool_behaviour)
		if(TOOL_SCREWDRIVER)
			context[SCREENTIP_CONTEXT_LMB] = "[panel_open ? "关闭" : "打开"]舱盖"
		if(TOOL_CROWBAR)
			if(panel_open && internal_cell)
				context[SCREENTIP_CONTEXT_LMB] = "取出电池"
		if(TOOL_WELDER)
			context[SCREENTIP_CONTEXT_LMB] = "修理"
			context[SCREENTIP_CONTEXT_RMB] = "拆解"

	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/portable_atmospherics/canister/examine(user)
	. = ..()
	if(atom_integrity < max_integrity)
		. += span_notice("结构完整性受损，请用焊接工具修复外壳。")
	. += span_notice("侧面贴着一张标签：<b>最大安全压力：[siunit_pressure(initial(pressure_limit), 0)]；最大安全温度：[siunit(temp_limit, "K", 0)]</b>。")
	. += span_notice("外壳已被<b>焊接</b>在一起，可以切开。")
	if(internal_cell)
		. += span_notice("内置电池剩余总电量的 [internal_cell.percent()]%。")
	else
		. += span_notice("警告：未安装电池，请用螺丝刀打开舱盖并装入电池。")
	if(panel_open)
		. += span_notice("舱盖已打开，请用螺丝刀关闭。")

// Please keep the canister types sorted
// Basic canister per gas below here

/obj/machinery/portable_atmospherics/canister/air
	name = "\improper 空气储罐"
	desc = "预先混合好的空气。"
	icon_state = "/obj/machinery/portable_atmospherics/canister/air"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister
	greyscale_colors = "#c6c0b5"

/obj/machinery/portable_atmospherics/canister/antinoblium
	name = "\improper 反惰性气体储罐"
	gas_type = /datum/gas/antinoblium
	filled = 1
	icon_state = "/obj/machinery/portable_atmospherics/canister/antinoblium"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#333333#fefb30"

/obj/machinery/portable_atmospherics/canister/bz
	name = "\improper BZ 储罐"
	gas_type = /datum/gas/bz
	icon_state = "/obj/machinery/portable_atmospherics/canister/bz"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#9b5d7f#d0d2a0"

/obj/machinery/portable_atmospherics/canister/carbon_dioxide
	name = "\improper 二氧化碳储罐"
	gas_type = /datum/gas/carbon_dioxide
	icon_state = "/obj/machinery/portable_atmospherics/canister/carbon_dioxide"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#4e4c48#eaeaea"

/obj/machinery/portable_atmospherics/canister/freon
	name = "\improper 氟利昂储罐"
	gas_type = /datum/gas/freon
	filled = 1
	icon_state = "/obj/machinery/portable_atmospherics/canister/freon"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#6696ee#fefb30"

/obj/machinery/portable_atmospherics/canister/halon
	name = "\improper 哈龙储罐"
	gas_type = /datum/gas/halon
	filled = 1
	icon_state = "/obj/machinery/portable_atmospherics/canister/halon"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#9b5d7f#368bff"

/obj/machinery/portable_atmospherics/canister/healium
	name = "\improper 愈合气储罐"
	gas_type = /datum/gas/healium
	filled = 1
	icon_state = "/obj/machinery/portable_atmospherics/canister/healium"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#009823#ff0e00"

/obj/machinery/portable_atmospherics/canister/helium
	name = "\improper 氦气储罐"
	gas_type = /datum/gas/helium
	filled = 1
	icon_state = "/obj/machinery/portable_atmospherics/canister/helium"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#9b5d7f#368bff"

/obj/machinery/portable_atmospherics/canister/hydrogen
	name = "\improper 氢气储罐"
	gas_type = /datum/gas/hydrogen
	filled = 1
	icon_state = "/obj/machinery/portable_atmospherics/canister/hydrogen"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#eaeaea#be3455"

/obj/machinery/portable_atmospherics/canister/miasma
	name = "\improper 瘴气储罐"
	gas_type = /datum/gas/miasma
	filled = 1
	icon_state = "/obj/machinery/portable_atmospherics/canister/miasma"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#009823#f7d5d3"

/obj/machinery/portable_atmospherics/canister/nitrogen
	name = "\improper 氮气储罐"
	gas_type = /datum/gas/nitrogen
	icon_state = "/obj/machinery/portable_atmospherics/canister/nitrogen"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#e9ff5c#f4fce8"

/obj/machinery/portable_atmospherics/canister/nitrous_oxide
	name = "\improper 一氧化二氮储罐"
	gas_type = /datum/gas/nitrous_oxide
	icon_state = "/obj/machinery/portable_atmospherics/canister/nitrous_oxide"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#c63e3b#f7d5d3"

/obj/machinery/portable_atmospherics/canister/nitrium
	name = "\improper 氮素气储罐"
	gas_type = /datum/gas/nitrium
	icon_state = "/obj/machinery/portable_atmospherics/canister/nitrium"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister
	greyscale_colors = "#7b4732"

/obj/machinery/portable_atmospherics/canister/nob
	name = "\improper 超惰性气体储罐"
	gas_type = /datum/gas/hypernoblium
	icon_state = "/obj/machinery/portable_atmospherics/canister/nob"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#6399fc#b2b2b2"

/obj/machinery/portable_atmospherics/canister/oxygen
	name = "\improper 氧气储罐"
	gas_type = /datum/gas/oxygen
	icon_state = "/obj/machinery/portable_atmospherics/canister/oxygen"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/stripe
	greyscale_colors = "#2786e5#e8fefe"

/obj/machinery/portable_atmospherics/canister/pluoxium
	name = "\improper 富氧气储罐"
	gas_type = /datum/gas/pluoxium
	icon_state = "/obj/machinery/portable_atmospherics/canister/pluoxium"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister
	greyscale_colors = "#2786e5"

/obj/machinery/portable_atmospherics/canister/proto_nitrate
	name = "\improper 原硝气储罐"
	gas_type = /datum/gas/proto_nitrate
	filled = 1
	icon_state = "/obj/machinery/portable_atmospherics/canister/proto_nitrate"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#008200#33cc33"

/obj/machinery/portable_atmospherics/canister/plasma
	name = "\improper 等离子体储罐"
	gas_type = /datum/gas/plasma
	icon_state = "/obj/machinery/portable_atmospherics/canister/plasma"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/hazard
	greyscale_colors = "#f62800#000000"

/obj/machinery/portable_atmospherics/canister/tritium
	name = "\improper 氚气储罐"
	gas_type = /datum/gas/tritium
	icon_state = "/obj/machinery/portable_atmospherics/canister/tritium"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/hazard
	greyscale_colors = "#3fcd40#000000"

/obj/machinery/portable_atmospherics/canister/water_vapor
	name = "\improper 水蒸气储罐"
	gas_type = /datum/gas/water_vapor
	filled = 1
	icon_state = "/obj/machinery/portable_atmospherics/canister/water_vapor"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#4c4e4d#f7d5d3"

/obj/machinery/portable_atmospherics/canister/zauker
	name = "\improper 灼蚀气储罐"
	gas_type = /datum/gas/zauker
	filled = 1
	icon_state = "/obj/machinery/portable_atmospherics/canister/zauker"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#009a00#006600"

// Special canisters below here

/obj/machinery/portable_atmospherics/canister/fusion_test
	name = "聚变测试气罐"
	desc = "别做坏管理员。"
	temp_limit = 1e12
	pressure_limit = 1e14

/obj/machinery/portable_atmospherics/canister/fusion_test/create_gas()
	air_contents.adjust_gas(/datum/gas/hydrogen, 300)
	air_contents.adjust_gas(/datum/gas/tritium, 300)
	air_contents.temperature = 10000
	SSair.start_processing_machine(src)

/obj/machinery/portable_atmospherics/canister/anesthetic_mix
	name = "麻醉混合气"
	desc = "一氧化二氮与氧气的混合气。"
	icon_state = "/obj/machinery/portable_atmospherics/canister/anesthetic_mix"
	post_init_icon_state = ""
	greyscale_config = /datum/greyscale_config/canister/double_stripe
	greyscale_colors = "#9fba6c#3d4680"

/obj/machinery/portable_atmospherics/canister/anesthetic_mix/create_gas()
	air_contents.adjust_gas(/datum/gas/oxygen, (O2_ANESTHETIC * maximum_pressure * filled) * air_contents.volume / (R_IDEAL_GAS_EQUATION * air_contents.temperature))
	air_contents.adjust_gas(/datum/gas/nitrous_oxide, (N2O_ANESTHETIC * maximum_pressure * filled) * air_contents.volume / (R_IDEAL_GAS_EQUATION * air_contents.temperature))
	SSair.start_processing_machine(src)

/**
 * Called on Initialize(), fill the canister with the gas_type specified up to the filled level (half if 0.5, full if 1)
 * Used for canisters spawned in maps and by admins
 */
/obj/machinery/portable_atmospherics/canister/proc/create_gas()
	if(!gas_type)
		return
	air_contents.adjust_gas(gas_type, (maximum_pressure * filled) * air_contents.volume / (R_IDEAL_GAS_EQUATION * air_contents.temperature))
	SSair.start_processing_machine(src)

/obj/machinery/portable_atmospherics/canister/air/create_gas()
	air_contents.adjust_gas(/datum/gas/oxygen, (O2STANDARD * maximum_pressure * filled) * air_contents.volume / (R_IDEAL_GAS_EQUATION * air_contents.temperature))
	air_contents.adjust_gas(/datum/gas/nitrogen, (N2STANDARD * maximum_pressure * filled) * air_contents.volume / (R_IDEAL_GAS_EQUATION * air_contents.temperature))
	SSair.start_processing_machine(src)

/obj/machinery/portable_atmospherics/canister/update_icon_state()
	if(machine_stat & BROKEN)
		icon_state = "[base_icon_state]-1"
	return ..()

/obj/machinery/portable_atmospherics/canister/update_overlays()
	. = ..()

	if(shielding_powered)
		. += mutable_appearance('icons/obj/pipes_n_cables/canisters.dmi', "shielding")
		. += emissive_appearance('icons/obj/pipes_n_cables/canisters.dmi', "shielding", src)

	if(panel_open)
		. += mutable_appearance('icons/obj/pipes_n_cables/canisters.dmi', "cell_hatch")

	///Function is used to actually set the overlays
	if(machine_stat & BROKEN)
		. += mutable_appearance('icons/obj/pipes_n_cables/canisters.dmi', "broken")
	if(holding)
		. += mutable_appearance('icons/obj/pipes_n_cables/canisters.dmi', "can-open")
	if(connected_port)
		. += mutable_appearance('icons/obj/pipes_n_cables/canisters.dmi', "can-connector")

	var/light_state = get_pressure_state()
	if(light_state) //happens when pressure is below 10kpa which means no light
		. += mutable_appearance('icons/obj/pipes_n_cables/canisters.dmi', light_state)
		. += emissive_appearance('icons/obj/pipes_n_cables/canisters.dmi', "[light_state]-light", src, alpha = src.alpha)

	update_window()

/obj/machinery/portable_atmospherics/canister/update_greyscale()
	. = ..()
	update_window()

///Updates the overlays of this canister based on its air contents
/obj/machinery/portable_atmospherics/canister/proc/update_window()
	if(!air_contents)
		return

	var/static/alpha_filter
	if(!alpha_filter) // Gotta do this separate since the icon may not be correct at world init
		alpha_filter = filter(type="alpha", icon = icon('icons/obj/pipes_n_cables/canisters.dmi', "window-base"))

	cut_overlay(window)
	window = image('icons/obj/pipes_n_cables/canisters.dmi', icon_state = "window-base", layer = FLOAT_LAYER)
	var/list/window_overlays = list()
	for(var/visual in air_contents.return_visuals(get_turf(src)))
		var/image/new_visual = image(visual, layer = FLOAT_LAYER)
		new_visual.filters = alpha_filter
		window_overlays += new_visual
	window.overlays = window_overlays
	add_overlay(window)

// Both of these procs handle the external temperature damage.
/obj/machinery/portable_atmospherics/canister/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return (exposed_temperature > TEMPERATURE_RESISTANCE && !shielding_powered)

/obj/machinery/portable_atmospherics/canister/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	take_damage(5, BURN, 0)

/obj/machinery/portable_atmospherics/canister/on_deconstruction(disassembled = TRUE)
	if(!(machine_stat & BROKEN))
		canister_break()
	if(!disassembled)
		new /obj/item/stack/sheet/iron (drop_location(), 5)
		qdel(src)
		return
	new /obj/item/stack/sheet/iron (drop_location(), 10)
	if(internal_cell)
		internal_cell.forceMove(drop_location())

/obj/machinery/portable_atmospherics/canister/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/cell))
		return ..()

	var/obj/item/stock_parts/power_store/cell/active_cell = tool
	if(!panel_open)
		balloon_alert(user, "先打开舱盖！")
		return ITEM_INTERACT_BLOCKING

	if(!user.transferItemToLoc(active_cell, src))
		return ITEM_INTERACT_BLOCKING

	if(internal_cell)
		user.put_in_hands(internal_cell)
		balloon_alert(user, "你更换了电池")
	else
		balloon_alert(user, "你装入了电池")
	internal_cell = active_cell
	return ITEM_INTERACT_SUCCESS

/obj/machinery/portable_atmospherics/canister/screwdriver_act(mob/living/user, obj/item/screwdriver)
	return default_deconstruction_screwdriver(user, screwdriver)

/obj/machinery/portable_atmospherics/canister/crowbar_act(mob/living/user, obj/item/tool)
	if(!panel_open || !internal_cell)
		return ITEM_INTERACT_BLOCKING

	internal_cell.forceMove(drop_location())
	balloon_alert(user, "电池已取出")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/portable_atmospherics/canister/welder_act_secondary(mob/living/user, obj/item/I)
	if(!I.tool_start_check(user, amount=1, heat_required = HIGH_TEMPERATURE_REQUIRED))
		return ITEM_INTERACT_BLOCKING

	var/pressure = air_contents.return_pressure()
	if(pressure > 300)
		to_chat(user, span_alert("[src] 上的压力表显示内部压力很高……也许你该重新考虑一下？"))
		message_admins("[src] 被 [ADMIN_LOOKUPFLW(user)] 拆解")
		user.log_message("用焊接工具拆解了 [src]。", LOG_GAME)
	to_chat(user, span_notice("你开始切开 [src]……"))
	if(I.use_tool(src, user, 3 SECONDS, volume=50))
		to_chat(user, span_notice("你把 [src] 切开了。"))
		deconstruct(TRUE)

	return ITEM_INTERACT_SUCCESS

/obj/machinery/portable_atmospherics/canister/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == internal_cell)
		internal_cell = null

/obj/machinery/portable_atmospherics/canister/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	. = ..()
	if(!. || QDELETED(src))
		return
	SSair.start_processing_machine(src)

/obj/machinery/portable_atmospherics/canister/atom_break(damage_flag)
	. = ..()
	if(!.)
		return
	canister_break()

///Handle canisters disassemble, releases the gas content in the turf
/obj/machinery/portable_atmospherics/canister/proc/canister_break()
	disconnect()
	var/datum/gas_mixture/expelled_gas = air_contents.remove(air_contents.total_moles())
	var/turf/T = get_turf(src)
	T.assume_air(expelled_gas)

	atom_break()

	set_density(FALSE)
	playsound(src.loc, 'sound/effects/spray.ogg', 10, TRUE, -3)
	investigate_log("被摧毁。", INVESTIGATE_ATMOS)

	if(holding)
		holding.forceMove(T)
		holding = null

	animate(src, 0.5 SECONDS, transform=turn(transform, rand(-179, 180)), easing=BOUNCE_EASING)

/obj/machinery/portable_atmospherics/canister/replace_tank(mob/living/user, close_valve)
	. = ..()
	if(!.)
		return

	if(close_valve)
		valve_open = FALSE
		update_appearance()
		investigate_log("阀门被 [key_name(user)] <b>关闭</b>。", INVESTIGATE_ATMOS)
	else if(valve_open && holding)
		user.investigate_log("开始向 [holding] 传输。", INVESTIGATE_ATMOS)

/obj/machinery/portable_atmospherics/canister/process(seconds_per_tick)
	if(!shielding_powered)
		return

	var/our_pressure = air_contents.return_pressure()
	var/our_temperature = air_contents.return_temperature()
	var/energy_factor = round(log(10, max(our_pressure - pressure_limit, 1)) + log(10, max(our_temperature - temp_limit, 1)))
	var/energy_consumed = energy_factor * 250 * seconds_per_tick

	if(!energy_consumed)
		return

	if(powered(AREA_USAGE_EQUIP, ignore_use_power = TRUE))
		use_energy(energy_consumed, channel = AREA_USAGE_EQUIP)
	else if(!internal_cell?.use(energy_consumed * 0.025))
		shielding_powered = FALSE
		SSair.start_processing_machine(src)
		investigate_log("因断电，护盾已关闭")
		update_appearance()

///return the icon_state component for the canister's indicator light based on its current pressure reading
/obj/machinery/portable_atmospherics/canister/proc/get_pressure_state()
	var/air_pressure = air_contents.return_pressure()
	switch(air_pressure)
		if((40 * ONE_ATMOSPHERE) to INFINITY)
			return "can-3"
		if((10 * ONE_ATMOSPHERE) to (40 * ONE_ATMOSPHERE))
			return "can-2"
		if((5 * ONE_ATMOSPHERE) to (10 * ONE_ATMOSPHERE))
			return "can-1"
		if((10) to (5 * ONE_ATMOSPHERE))
			return "can-0"
		else
			return null

/obj/machinery/portable_atmospherics/canister/process_atmos()
	if(machine_stat & BROKEN)
		return PROCESS_KILL

	// Handle gas transfer.
	if(valve_open)
		var/turf/location = get_turf(src)
		var/datum/gas_mixture/target_air = holding?.return_air() || location.return_air()
		excited = TRUE

		if(air_contents.release_gas_to(target_air, release_pressure))
			if(!holding)
				air_update_turf(FALSE, FALSE)

	// A bit different than other atmos devices. Wont stop if currently taking damage.
	if(take_atmos_damage())
		update_appearance()
		excited = TRUE
		return ..() //we have already updated appearance so dont need to update again below

	var/new_pressure_state = get_pressure_state()
	if(current_pressure_state != new_pressure_state) //update apperance only when its pressure changes significantly from its current value
		update_appearance()
		current_pressure_state = new_pressure_state

	return ..()

/obj/machinery/portable_atmospherics/canister/ui_state(mob/user)
	return GLOB.physical_state

/obj/machinery/portable_atmospherics/canister/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Canister", name)
		ui.open()

/obj/machinery/portable_atmospherics/canister/ui_static_data(mob/user)
	return list(
		"defaultReleasePressure" = round(CAN_DEFAULT_RELEASE_PRESSURE),
		"minReleasePressure" = round(CAN_MIN_RELEASE_PRESSURE),
		"maxReleasePressure" = round(CAN_MAX_RELEASE_PRESSURE),
		"pressureLimit" = round(pressure_limit),
		"holdingTankLeakPressure" = round(TANK_LEAK_PRESSURE),
		"holdingTankFragPressure" = round(TANK_FRAGMENT_PRESSURE)
	)

/obj/machinery/portable_atmospherics/canister/ui_data()
	. = list(
		"portConnected" = !!connected_port,
		"tankPressure" = round(air_contents.return_pressure()),
		"releasePressure" = round(release_pressure),
		"valveOpen" = !!valve_open,
		"hasHoldingTank" = !!holding,
		"hasHypernobCrystal" = !!nob_crystal_inserted,
		"reactionSuppressionEnabled" = !!suppress_reactions
	)

	if (holding)
		var/datum/gas_mixture/holding_mix = holding.return_air()
		.["holdingTank"] = list(
			"name" = holding.name,
			"tankPressure" = round(holding_mix.return_pressure())
		)
	else
		.["holdingTank"] = null

	. += list(
		"shielding" = shielding_powered,
		"cellCharge" = internal_cell ? internal_cell.percent() : 0
	)

/obj/machinery/portable_atmospherics/canister/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("relabel")
			var/label = tgui_input_list(usr, "新的储罐标签", "储罐", GLOB.gas_id_to_canister)
			if(isnull(label))
				return
			var/newtype = GLOB.gas_id_to_canister[label]
			if(isnull(newtype))
				return
			var/obj/machinery/portable_atmospherics/canister/replacement = newtype
			investigate_log("被 [key_name(usr)] 重新标记为 [initial(replacement.name)]。", INVESTIGATE_ATMOS)
			name = initial(replacement.name)
			desc = initial(replacement.desc)
			icon_state = initial(replacement.icon_state)
			base_icon_state = icon_state
			set_greyscale(initial(replacement.greyscale_colors), initial(replacement.greyscale_config))

		if("pressure")
			var/pressure = params["pressure"]
			if(pressure == "reset")
				pressure = CAN_DEFAULT_RELEASE_PRESSURE
				. = TRUE
			else if(pressure == "min")
				pressure = CAN_MIN_RELEASE_PRESSURE
				. = TRUE
			else if(pressure == "max")
				pressure = CAN_MAX_RELEASE_PRESSURE
				. = TRUE
			else if(pressure == "input")
				pressure = tgui_input_number(usr, message = "新的释放压力", title = "储罐压力", default = release_pressure, max_value = CAN_MAX_RELEASE_PRESSURE, min_value = CAN_MIN_RELEASE_PRESSURE, round_value = FALSE)
				if(!isnull(pressure))
					. = TRUE
			else if(text2num(pressure) != null)
				pressure = text2num(pressure)
				. = TRUE
			if(.)
				release_pressure = clamp(pressure, CAN_MIN_RELEASE_PRESSURE, CAN_MAX_RELEASE_PRESSURE)
				investigate_log("被 [key_name(usr)] 设置为 [release_pressure] kPa。", INVESTIGATE_ATMOS)

		if("valve")
			toggle_valve(usr)
			. = TRUE

		if("eject")
			if(eject_tank(usr))
				. = TRUE

		if("shielding")
			toggle_shielding(usr)
			. = TRUE

		if("reaction_suppression")
			toggle_reaction_suppression(usr)
			. = TRUE

		if("recolor")
			var/initial_config = initial(greyscale_config)
			if(isnull(initial_config))
				return FALSE

			var/datum/greyscale_modify_menu/menu = new(
				src, usr, list("[initial_config]"), CALLBACK(src, PROC_REF(recolor)),
				starting_icon_state = initial(post_init_icon_state) || initial(icon_state),
				starting_config = initial_config,
				starting_colors = initial(greyscale_colors)
			)
			menu.ui_interact(usr)
			. = TRUE

	update_appearance()

/// Opens/closes the canister valve
/obj/machinery/portable_atmospherics/canister/proc/toggle_valve(mob/user, wire_pulsed = FALSE)
	valve_open = !valve_open
	playsound(src, 'sound/effects/valve_opening.ogg', 50, TRUE)
	if(!valve_open)
		var/logmsg = "阀门被 [key_name(user)] [wire_pulsed ? "通过脉冲" : ""] <b>关闭</b>，停止向 [holding || "空气"] 传输。<br>"
		investigate_log(logmsg, INVESTIGATE_ATMOS)
		release_log += logmsg
		return

	SSair.start_processing_machine(src)
	if(holding)
		var/logmsg = "阀门被 [key_name(user)] [wire_pulsed ? "通过脉冲" : ""] <b>打开</b>，开始向 [holding || "空气"] 传输。<br>"
		investigate_log(logmsg, INVESTIGATE_ATMOS)
		release_log += logmsg
		return

	// Go over the gases in canister, pull all their info and mark the spooky ones
	var/list/output = list()
	output += "[key_name(user)] [wire_pulsed ? "通过脉冲" : ""] <b>打开了</b>一个气罐，其内容如下："
	var/list/admin_output = list()
	admin_output += "[ADMIN_LOOKUPFLW(user)] [wire_pulsed ? "通过脉冲" : ""] <b>打开了</b>一个气罐，其内容如下，位置 [ADMIN_VERBOSEJMP(src)]："
	var/list/cached_moles = air_contents.moles
	var/list/cached_gas_name = GAS_META[META_GAS_NAME]
	var/list/cached_gas_danger = GAS_META[META_GAS_DANGER]
	var/list/cached_gas_visible = GAS_META[META_GAS_MOLES_VISIBLE]
	var/danger = FALSE
	for(var/gas_index in 1 to length(cached_moles))
		var/gas_id = cached_moles[gas_index]
		var/name = cached_gas_name[gas_id]
		var/moles = cached_moles[gas_id]

		output += "[name]：[moles] 摩尔。"
		if(gas_index <= 5) //the first five gases added
			admin_output += "[name]：[moles] 摩尔。"
		else if(gas_index == 6) // anddd the warning
			admin_output += "气体种类过多，无法全部记录。请查看调查日志。"
		//if moles_visible is undefined, default to default visibility
		if(cached_gas_danger[gas_id] && moles > (cached_gas_visible[gas_id] || MOLES_GAS_VISIBLE))
			danger = TRUE

	if(danger) //sent to admin's chat if contains dangerous gases
		message_admins(admin_output.Join("\n"))
	var/logmsg = output.Join("\n")
	investigate_log(logmsg, INVESTIGATE_ATMOS)
	release_log += logmsg

/// Turns canister shielding on or off
/obj/machinery/portable_atmospherics/canister/proc/toggle_shielding(mob/user, wire_pulsed = FALSE)
	shielding_powered = !shielding_powered
	SSair.start_processing_machine(src)
	message_admins("[ADMIN_LOOKUPFLW(user)] 将 [src] 的供能护盾[shielding_powered ? "开启" : "关闭"]了[wire_pulsed ? "（通过脉冲）" : ""]。")
	user.investigate_log("将 [src] 的供能护盾[shielding_powered ? "开启" : "关闭"]了[wire_pulsed ? "（通过脉冲）" : ""]。", INVESTIGATE_ATMOS)
	update_appearance()

/// Ejects tank from canister, if any
/obj/machinery/portable_atmospherics/canister/proc/eject_tank(mob/user, wire_pulsed = FALSE)
	if(!holding)
		return FALSE
	if(valve_open)
		message_admins("[ADMIN_LOOKUPFLW(user)] 在阀门仍然打开的情况下从 [src] 取出了 [holding] [wire_pulsed ? "（通过脉冲）" : ""]，位置 [ADMIN_VERBOSEJMP(src)]，内容物正释放到 [span_bolddanger("空气")] 中。")
		user.investigate_log("取出了 [holding] [wire_pulsed ? "（通过脉冲）" : ""]，阀门保持打开，内容物正传输到 [span_bolddanger("空气")] 中。", INVESTIGATE_ATMOS)
	replace_tank(user, FALSE)
	return TRUE

/// Turns hyper-noblium crystal reaction suppression in the canister on or off
/obj/machinery/portable_atmospherics/canister/proc/toggle_reaction_suppression(mob/user, wire_pulsed = FALSE)
	if(!nob_crystal_inserted)
		if(!wire_pulsed)
			stack_trace("[user] tried to toggle reaction suppression on a canister without a noblium crystal inside and without pulsing wires, possible href exploit attempt.")
		return
	suppress_reactions = !suppress_reactions
	SSair.start_processing_machine(src)
	message_admins("[ADMIN_LOOKUPFLW(user)] 将 [src] 的反应抑制[suppress_reactions ? "开启" : "关闭"]了[wire_pulsed ? "（通过脉冲）" : ""]。")
	user.investigate_log("将 [src] 的反应抑制[suppress_reactions ? "开启" : "关闭"]了[wire_pulsed ? "（通过脉冲）" : ""]。", INVESTIGATE_ATMOS)

/obj/machinery/portable_atmospherics/canister/proc/recolor(datum/greyscale_modify_menu/menu)
	set_greyscale(menu.split_colors, menu.config.type)

/obj/machinery/portable_atmospherics/canister/unregister_holding()
	valve_open = FALSE
	return ..()

/obj/machinery/portable_atmospherics/canister/take_atmos_damage()
	return shielding_powered ? FALSE : ..()

#undef CAN_DEFAULT_RELEASE_PRESSURE
#undef TEMPERATURE_RESISTANCE
