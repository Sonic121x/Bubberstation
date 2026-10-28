/// What's the maximum range of the field?
#define SUPERPARTICLE_MAX_RANGE (20)
/// What's the maximum internal power? If its above this value, the field will affect everyone on same Z level
#define SUPERPARTICLE_MAX_POWER (4500)
/// Past this internal power, the machine will stop working
#define SUPERPARTICLE_STOP_POWER (5500)
/// Percentage of CO2 required for effects to apply
#define SUPERPARTICLE_CARBON_GAS_TRESHHOLD (0.2)
/// Percentage of Healium required for effects to apply
#define SUPERPARTICLE_HEALIUM_GAS_TRESHHOLD (0.2)
//Flags for gas treshholds
/// Is Carbon Dioxide treshhold reached?
#define SP_GAS_FLAG_CARBON (1<<0)
/// Is Healium treshhold reached?
#define SP_GAS_FLAG_HEALIUM (1<<1)

/obj/item/paper/guides/jobs/atmos/superparticlegen
	name = "纸张 - '超粒子投射器指南'"
	default_raw_text = "<B>超粒子投射器操作指南</B><BR>\
	-使用随附的机器电路板建造该机器。<BR>\
	-启动投射器，并选择一台你希望与之链接的超物质引擎。<BR>\
	-可以关闭再重新开启机器，以更换所选的引擎。<BR><BR>\
	<B>基本功能：</B><BR>\
	-投射器会展开一层模拟加压环境的粒子防护场。\
	范围内的所有人形生物都不会受到寒冷环境、低气压\
	或耗尽呼吸空气的伤害，确保在空间站外壳破损时船员依然存活。<BR>\
	-力场肉眼不可见，其中心位于投射器本身所在位置，而非所链接的引擎处。\
	你可以随时检视投射器，以确认它能覆盖多远。\
	覆盖半径会随你所链接的超物质引擎的内部功率而增长，\
	内部功率达到 4.5GeV 时半径可达 20 格。\
	一旦内部功率超过 4.5GeV，力场将覆盖整个空间站\
	（站外的投射器需要各自配备引擎），但投射器无法承受超过 5.5GeV 的功率，超过该阈值后将停止工作。<BR><BR>\
	<B>附加效果：</B><BR>\
	投射器会依据所选超物质引擎周围存在的气体种类提供额外增益：<BR>\
	-二氧化碳占比高于 20% - 它会为碳基生物携带的电池以及为半机械人供电的电池充电（每 10 秒为随机一块电池充 10%）<BR>\
	-愈合气占比高于 20% - 力场会缓慢修复船员与半机械人的钝击伤和烧伤\
	（伤害低于 30 时每秒修复 0.2）<BR><BR>\
	超粒子投射器是一款仍在积极开发中的新设备，若上述信息发生变化，本指南将随之更新。\
	若有任何功能运行异常，请务必重读本指南并留意其中的变更。"

/datum/supply_pack/engineering/superparticlegen
	name = "超粒子投射器"
	desc = "一种能生成有益力场、为船员提供增益的发电机，效果取决于超物质引擎的状态。内含机器电路板与一本指南。"
	cost = CARGO_CRATE_VALUE * 50 // 10,000
	contains = list(/obj/item/circuitboard/machine/superparticlegen,
	/obj/item/paper/guides/jobs/atmos/superparticlegen)
	crate_name = "超粒子投射器电路板箱"
	crate_type = /obj/structure/closet/crate/engineering

/obj/item/circuitboard/machine/superparticlegen
	name = "超粒子投射器"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/superparticlegen
	req_components = list(
		/datum/stock_part/capacitor = 2,
		/datum/stock_part/micro_laser = 2,
		/obj/item/stack/sheet/glass = 1)

/obj/machinery/power/superparticlegen
	anchored = TRUE
	density = TRUE
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON
	icon = 'modular_zubbers/icons/obj/machines/superparticle_projector.dmi'
	icon_state = "superparticle_projector"
	base_icon_state = "superparticle_projector"
	name = "超粒子投射器"
	desc = "在自身周围生成力场，使范围内的所有人形生物免疫太空环境。\
	覆盖范围随所选超物质引擎的内部功率变化。\
	在所选超物质引擎中使用特定气体，可获得额外增益"
	max_integrity = 250
	circuit = /obj/item/circuitboard/machine/superparticlegen
	armor_type = /datum/armor/superparticlegen
	interaction_flags_click = ALLOW_SILICON_REACH
	use_power = IDLE_POWER_USE
	/// The cell we spawn with
	var/obj/item/stock_parts/power_store/cell/cell = /obj/item/stock_parts/power_store/cell/high
	/// Is the machine on?
	var/on = FALSE
	/// field range
	var/range = 0
	/// For list of avalible SMs
	var/list/obj/machinery/power/supermatter_crystal/supermatters = list()
	/// For chosen SM
	var/obj/machinery/power/supermatter_crystal/connected_supermatter

	/// Which gasses have met their treshholds in SM?
	var/superparticle_gas_flags = NONE

/datum/armor/superparticlegen
	fire = 100
	melee = 10
	bomb = 40
/obj/machinery/power/superparticlegen/update_overlays()
	. = ..()
	icon_state = panel_open ? "[base_icon_state]-o" : base_icon_state
	if(on)
		. += "superparticle_projector_lights"
		if(superparticle_gas_flags & SP_GAS_FLAG_CARBON)
			. += "superparticle_carbon"
		if(superparticle_gas_flags & SP_GAS_FLAG_HEALIUM)
			. += "superparticle_healium"

/obj/machinery/power/superparticlegen/examine(mob/user)
	. = ..()
	. += "它处于[on ? "开启" : "关闭"]状态。"
	if(in_range(user, src) || isobserver(user))
		. += span_notice("<b>右键</b>可将其切换为[on ? "关闭" : "开启"]。")
		if(connected_supermatter.internal_energy < SUPERPARTICLE_MAX_POWER)
			. += span_notice("力场当前范围：[range] 格。")
		else
			. += span_notice("超粒子力场的效果已扩展至投射器周围的整个区域！")
		. += span_notice("<b>二氧化碳</b>效果<b>[superparticle_gas_flags & SP_GAS_FLAG_CARBON ? "已生效" : "未生效"]</b>。")
		. += span_notice("<b>愈合气</b>效果<b>[superparticle_gas_flags & SP_GAS_FLAG_HEALIUM ? "已生效" : "未生效"]</b>。")
		if (connected_supermatter.internal_energy >= SUPERPARTICLE_STOP_POWER)
			. += span_warning("所连接的晶体已过载，超粒子力场已停用！")

/obj/machinery/power/superparticlegen/attack_hand_secondary(mob/user, list/modifiers)
	if(!can_interact(user))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	toggle_on(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/power/superparticlegen/proc/display_options(mob/user)
	supermatters = list()
	for(var/obj/machinery/power/supermatter_crystal/sm as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/supermatter_crystal))
		if((loc.z == sm.z) | (is_station_level(loc.z) & is_station_level(sm.z)))
			supermatters += sm
	connected_supermatter = tgui_input_list(user, "你想链接到哪台引擎？", "选择一台引擎！", supermatters)
	turn_on(user)

/obj/machinery/power/superparticlegen/proc/toggle_on(mob/user)
	if(on)
		turn_off(user)
		return
	if(anchored)
		display_options(user)
	else
		balloon_alert(user, "请先固定！")

/obj/machinery/power/superparticlegen/proc/turn_on(mob/user)
	if(!isnull(user))
		balloon_alert(user, "已开启")
	on = TRUE
	START_PROCESSING(SSmachines, src)
	update_appearance()

/obj/machinery/power/superparticlegen/proc/turn_off(mob/user)
	on = FALSE
	if(!isnull(user))
		balloon_alert(user, "已关闭")
	STOP_PROCESSING(SSmachines, src)
	update_appearance()

/obj/machinery/power/superparticlegen/screwdriver_act(mob/living/user, obj/item/tool)
	if(on)
		balloon_alert(user, "请先关闭！")
		return ITEM_INTERACT_SUCCESS
	if(!anchored)
		balloon_alert(user, "请先固定！")
		return ITEM_INTERACT_SUCCESS

	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/power/superparticlegen/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(user, tool)

/obj/machinery/power/superparticlegen/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(on)
		balloon_alert(user, "请先关闭！")
		return
	default_unfasten_wrench(user, tool)
	if(anchored)
		connect_to_network()
	else
		disconnect_from_network()
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/superparticlegen/process(seconds_per_tick)
	if(!on)
		return PROCESS_KILL
	range = round((connected_supermatter.internal_energy) / SUPERPARTICLE_MAX_POWER * SUPERPARTICLE_MAX_RANGE)

	check_gas_concentration(/datum/gas/carbon_dioxide, SP_GAS_FLAG_CARBON, SUPERPARTICLE_CARBON_GAS_TRESHHOLD)
	check_gas_concentration(/datum/gas/healium, SP_GAS_FLAG_HEALIUM, SUPERPARTICLE_HEALIUM_GAS_TRESHHOLD)

	if (connected_supermatter.internal_energy >= SUPERPARTICLE_STOP_POWER)
		return	// we aren't doing anything below anyway

	if(connected_supermatter.internal_energy < SUPERPARTICLE_MAX_POWER)
		for(var/mob/living/carbon/target in range(src, range))
			apply_effect(target)
		for(var/mob/living/silicon/robot/target in range(src, range))
			apply_effect(target)
	else
		for(var/mob/living/carbon/target as anything in GLOB.carbon_list)
			if(target.z == loc.z | (is_station_level(loc.z) & is_station_level(target.z)))
				apply_effect(target)
		for(var/mob/living/silicon/robot/target in GLOB.silicon_mobs)
			if(target.z == loc.z | (is_station_level(loc.z) & is_station_level(target.z)))
				apply_effect(target)

/obj/machinery/power/superparticlegen/proc/check_gas_concentration(datum/gas/gas_to_check, gas_flag, threshold)
	if(connected_supermatter.gas_percentage[gas_to_check.type] > threshold)
		if(superparticle_gas_flags ^ gas_flag)
			superparticle_gas_flags |= gas_flag
			update_appearance()
	else
		if(superparticle_gas_flags & gas_flag)
			superparticle_gas_flags ^= gas_flag
			update_appearance()

/obj/machinery/power/superparticlegen/proc/apply_effect(mob/living/target)
	if (iscarbon(target))	// no point in applying on silicons
		target.apply_status_effect(/datum/status_effect/atmosgenbuff)

	if(superparticle_gas_flags & SP_GAS_FLAG_CARBON)
		target.apply_status_effect(/datum/status_effect/atmosgenbuff_carbon)
	if(superparticle_gas_flags & SP_GAS_FLAG_HEALIUM)
		target.apply_status_effect(/datum/status_effect/atmosgenbuff_healium)

#undef SUPERPARTICLE_MAX_RANGE
#undef SUPERPARTICLE_MAX_POWER
#undef SUPERPARTICLE_STOP_POWER
#undef SUPERPARTICLE_CARBON_GAS_TRESHHOLD
#undef SUPERPARTICLE_HEALIUM_GAS_TRESHHOLD
#undef SP_GAS_FLAG_CARBON
#undef SP_GAS_FLAG_HEALIUM
