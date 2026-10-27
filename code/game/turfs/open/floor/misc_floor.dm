// Usage for a bar light is 160, let's do a bit less then that since these tend to be used a lot in one place
#define CIRCUIT_FLOOR_POWERUSE 120
//Circuit flooring, glows a little
/turf/open/floor/circuit
	icon = 'icons/turf/floors.dmi'
	icon_state = "bcircuit"
	base_icon_state = "bcircuit"
	light_color = LIGHT_COLOR_BABY_BLUE
	floor_tile = /obj/item/stack/tile/circuit
	rust_resistance = RUST_RESISTANCE_REINFORCED
	/// If we want to ignore our area's power status and just be always off
	/// Mostly for mappers doing asthetic things, or cases where the floor should be broken
	var/always_off = FALSE
	/// If this floor is powered or not
	/// We don't consume any power, but we do require it
	var/on = -1

/turf/open/floor/circuit/Initialize(mapload)
	SSmapping.nuke_tiles += src
	RegisterSignal(loc, COMSIG_AREA_POWER_CHANGE, PROC_REF(handle_powerchange))
	var/area/cur_area = get_area(src)
	if (!isnull(cur_area))
		handle_powerchange(cur_area, TRUE)
	. = ..()

/turf/open/floor/circuit/Destroy()
	SSmapping.nuke_tiles -= src
	UnregisterSignal(loc, COMSIG_AREA_POWER_CHANGE)
	var/area/cur_area = get_area(src)
	if(on && !isnull(cur_area))
		cur_area.removeStaticPower(CIRCUIT_FLOOR_POWERUSE, AREA_USAGE_STATIC_LIGHT)
	return ..()

/turf/open/floor/circuit/update_appearance(updates)
	. = ..()
	if(!on)
		set_light(0)
		return

	set_light_color(LAZYLEN(SSmapping.nuke_threats) ? LIGHT_COLOR_INTENSE_RED : initial(light_color))
	set_light(2, 1.5)

/turf/open/floor/circuit/update_icon_state()
	icon_state = on ? (LAZYLEN(SSmapping.nuke_threats) ? "rcircuitanim" : initial(icon_state)) : "[base_icon_state]off"
	return ..()

/turf/open/floor/circuit/on_change_area(area/old_area, area/new_area)
	. = ..()
	UnregisterSignal(old_area, COMSIG_AREA_POWER_CHANGE)
	RegisterSignal(new_area, COMSIG_AREA_POWER_CHANGE, PROC_REF(handle_powerchange))
	if(on)
		old_area.removeStaticPower(CIRCUIT_FLOOR_POWERUSE, AREA_USAGE_STATIC_LIGHT)
	handle_powerchange(new_area)

/// Enables/disables our lighting based off our source area
/turf/open/floor/circuit/proc/handle_powerchange(area/source, mapload = FALSE)
	SIGNAL_HANDLER
	var/old_on = on
	if(always_off)
		on = FALSE
	else
		on = source.powered(AREA_USAGE_LIGHT)
	if(on == old_on)
		return

	if(on)
		source.addStaticPower(CIRCUIT_FLOOR_POWERUSE, AREA_USAGE_STATIC_LIGHT)
	else if (!mapload)
		source.removeStaticPower(CIRCUIT_FLOOR_POWERUSE, AREA_USAGE_STATIC_LIGHT)
	update_appearance()

#undef CIRCUIT_FLOOR_POWERUSE

/turf/open/floor/circuit/off
	icon_state = "bcircuitoff"
	always_off = TRUE

/turf/open/floor/circuit/no_light
	always_off = TRUE

/turf/open/floor/circuit/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/circuit/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/circuit/telecomms/mainframe
	name = "主机基座"

/turf/open/floor/circuit/telecomms/server
	name = "服务器基座"

/turf/open/floor/circuit/green
	icon_state = "gcircuit"
	base_icon_state = "gcircuit"
	light_color = LIGHT_COLOR_VIVID_GREEN
	floor_tile = /obj/item/stack/tile/circuit/green

/turf/open/floor/circuit/green/off
	icon_state = "gcircuitoff"
	always_off = TRUE

/turf/open/floor/circuit/green/anim
	icon_state = "gcircuitanim"
	floor_tile = /obj/item/stack/tile/circuit/green/anim

/turf/open/floor/circuit/green/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/circuit/green/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/circuit/green/telecomms/mainframe
	name = "主机基座"

/turf/open/floor/circuit/red
	icon_state = "rcircuit"
	base_icon_state = "rcircuit"
	light_color = LIGHT_COLOR_INTENSE_RED
	floor_tile = /obj/item/stack/tile/circuit/red

/turf/open/floor/circuit/red/off
	icon_state = "rcircuitoff"
	always_off = TRUE

/turf/open/floor/circuit/red/no_power
	always_off = TRUE

/turf/open/floor/circuit/red/anim
	icon_state = "rcircuitanim"
	floor_tile = /obj/item/stack/tile/circuit/red/anim

/turf/open/floor/circuit/red/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/circuit/red/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/noslip
	name = "高摩擦地板"
	icon_state = "noslip"
	floor_tile = /obj/item/stack/tile/noslip
	slowdown = -0.3

/turf/open/floor/noslip/broken_states()
	return list("noslip-damaged1","noslip-damaged2","noslip-damaged3")

/turf/open/floor/noslip/burnt_states()
	return list("noslip-scorched1","noslip-scorched2")

/turf/open/floor/noslip/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/noslip/tram/Initialize(mapload)
	. = ..()
	var/current_holiday_color = request_decoration_colors(src, PATTERN_VERTICAL_STRIPE)
	if(current_holiday_color)
		color = current_holiday_color
	else
		color = "#EFB341"

/turf/open/floor/oldshuttle
	icon = 'icons/turf/shuttleold.dmi'
	icon_state = "floor"
	floor_tile = /obj/item/stack/tile/iron/base

/turf/open/floor/bluespace
	slowdown = -1
	icon_state = "bluespace"
	desc = "通过一系列微型传送，这些地砖能让人以惊人的速度移动。"
	floor_tile = /obj/item/stack/tile/bluespace


/turf/open/floor/sepia
	slowdown = 2
	icon_state = "sepia"
	desc = "在这片地砖周围，时间似乎流动得非常缓慢。"
	floor_tile = /obj/item/stack/tile/sepia


/turf/open/floor/bronze
	name = "青铜地板"
	desc = "一些沉重的青铜地砖。"
	icon_state = "clockwork_floor"
	floor_tile = /obj/item/stack/tile/bronze

/turf/open/floor/bronze/flat
	icon_state = "reebe"
	floor_tile = /obj/item/stack/tile/bronze/flat

/turf/open/floor/bronze/filled
	icon_state = "clockwork_floor_filled"
	floor_tile = /obj/item/stack/tile/bronze/filled

/turf/open/floor/bronze/filled/lavaland
	planetary_atmos = TRUE
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/open/floor/bronze/filled/icemoon
	planetary_atmos = TRUE
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/floor/white
	name = "白色地板"
	desc = "一块纯白色的地砖。"
	icon_state = "pure_white"

/turf/open/floor/black
	name = "黑色地板"
	icon_state = "black"

/turf/open/floor/greenscreen
	name = "绿幕"
	icon_state = "green"

/turf/open/floor/plastic
	name = "塑料地板"
	desc = "廉价而轻便的地板。很容易熔化。"
	icon_state = "plastic"
	thermal_conductivity = 0.1
	heat_capacity = 900
	custom_materials = list(/datum/material/plastic=SMALL_MATERIAL_AMOUNT*5)
	floor_tile = /obj/item/stack/tile/plastic

/turf/open/floor/plastic/broken_states()
	return list("plastic-damaged1","plastic-damaged2")

/turf/open/floor/eighties
	name = "复古地板"
	desc = "这一款能把你带回过去。"
	icon_state = "eighties"
	floor_tile = /obj/item/stack/tile/eighties
	rust_resistance = RUST_RESISTANCE_BASIC

/turf/open/floor/eighties/broken_states()
	return list("eighties_damaged")

/turf/open/floor/eighties/red
	name = "红色复古地板"
	desc = "简直红到爆！"
	icon_state = "eightiesred"
	floor_tile = /obj/item/stack/tile/eighties/red

/turf/open/floor/eighties/red/broken_states()
	return list("eightiesred_damaged")

/turf/open/floor/plating/rust
	//SDMM supports colors, this is simply for easier mapping
	//and should be removed on initialize
	color = COLOR_BROWN

/turf/open/floor/plating/rust/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/rust)
	color = null

/turf/open/floor/plating/rust/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/heretic_rust
	color = COLOR_GREEN_GRAY

/turf/open/floor/plating/heretic_rust/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/rust/heretic)
	color = null

/turf/open/floor/plating/plasma
	initial_gas_mix = ATMOS_TANK_PLASMA

/turf/open/floor/plating/plasma/rust/Initialize(mapload)
	. = ..()
	// Because this is a fluff turf explicitly for KiloStation it doesn't make sense to ChangeTurf like usual
	// Especially since it looks like we don't even change the default icon/iconstate???
	AddElement(/datum/element/rust)

/turf/open/floor/stone
	name = "石砖地板"
	desc = "说真的，挺奇怪的：它看起来和铁墙一模一样，却是石头而不是铁。那么，这究竟是在抱怨\
		墙太有铁味还是地板太有石头味，就完全由你判断了。可你真的见过那么暗淡的铁吗？我是说，\
		空间站有暗淡的金属墙还算合理，但我们说的是一堵简陋铁墙该有的样子。中世纪的人甚至根本不用铁\
		墙，铁墙其实根本不存在，因为铁是一种昂贵又不怎么适合用来造墙的东西。它只在太空环境\
		下才有意义，因为你要把冰冷的真空挡在外面。有人跟上我的思路了吗？\
		所谓“简陋的”铁墙这个概念根本说不通！我说的这些到底有哪一句是真的？得有人去核实一下！"
	icon_state = "stone_floor"

/turf/open/floor/stone/lavaland
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/open/floor/stone/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	name = "石砖地板"
	desc = "说真的，挺奇怪的：它看起来和铁墙一模一样，却是石头而不是铁。那么，这究竟是在抱怨\
		墙太有铁味还是地板太有石头味，就完全由你判断了。可你真的见过那么暗淡的铁吗？我是说，\
		空间站有暗淡的金属墙还算合理，但我们说的是一堵简陋铁墙该有的样子。中世纪的人甚至根本不用铁\
		墙，铁墙其实根本不存在，因为铁是一种昂贵又不怎么适合用来造墙的东西。它只在太空环境\
		下才有意义，因为你要把冰冷的真空挡在外面。有人跟上我的思路了吗？\
		所谓“简陋的”铁墙这个概念根本说不通！我说的这些到底有哪一句是真的？得有人去核实一下！"
	icon_state = "stone_floor"

/turf/open/floor/vault
	name = "奇怪的地板"
	desc = "看着它，你感到一种奇怪的怀旧感……"
	icon_state = "rockvault"
	base_icon_state = "rockvault"

/turf/open/floor/vault/rock
	name = "岩石地板"

/turf/open/floor/vault/alien
	name = "异形地板"
	icon_state = "alienvault"
	base_icon_state = "alienvault"

/turf/open/floor/vault/sandstone
	name = "砂岩地板"
	icon_state = "sandstonevault"
	base_icon_state = "sandstonevault"

/turf/open/floor/cult
	name = "铭刻地板"
	icon_state = "cult"
	base_icon_state = "cult"
	floor_tile = /obj/item/stack/tile/cult

/turf/open/floor/cult/broken_states()
	return list("cultdamage","cultdamage2","cultdamage3","cultdamage4","cultdamage5","cultdamage6","cultdamage7")

/turf/open/floor/cult/narsie_act()
	return

/turf/open/floor/cult/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/material/meat
	name = "活体地板"
	icon_state = "grey"
	baseturfs = /turf/open/misc/asteroid
	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/turf/open/floor/material/meat/Initialize(mapload)
	. = ..()
	set_custom_materials(list(SSmaterials.get_material(/datum/material/meat) = SHEET_MATERIAL_AMOUNT))

/turf/open/floor/material/meat/airless
	initial_gas_mix = AIRLESS_ATMOS
	baseturfs = /turf/open/misc/asteroid/airless

/turf/open/floor/iron/tgmcemblem
	name = "TGMC 徽记"
	desc = "地球政府的标志。"
	icon_state = "tgmc_emblem"

/turf/open/floor/iron/tgmcemblem/center
	icon_state = "tgmc_center"

/turf/open/floor/asphalt
	name = "沥青"
	desc = "熔化后的石油沥青在某些情况下可用于铺设路面。"
	icon_state = "asphalt"

/turf/open/floor/asphalt/outdoors
	planetary_atmos = TRUE

/turf/open/floor/asphalt/lavaland
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	baseturfs = /turf/open/misc/asteroid/basalt

/turf/open/floor/asphalt/lavaland/outdoors
	planetary_atmos = TRUE
