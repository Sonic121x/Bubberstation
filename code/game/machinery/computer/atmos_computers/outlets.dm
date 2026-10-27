/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored
	on = TRUE
	icon_state = "vent_map_siphon_on-3"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/Initialize(mapload)
	. = ..()
	//we dont want people messing with these special vents using the air alarm interface
	disconnect_from_area()

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/plasma_output
	name = "等离子体储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/oxygen_output
	name = "氧气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/nitrogen_output
	name = "氮气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/mix_output
	name = "混气罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/nitrous_output
	name = "一氧化二氮储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/carbon_output
	name = "二氧化碳储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/bz_output
	name = "BZ储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/freon_output
	name = "氟利昂储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/halon_output
	name = "哈龙储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/healium_output
	name = "愈合气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/hydrogen_output
	name = "氢气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/hypernoblium_output
	name = "超惰性气体储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/miasma_output
	name = "瘴气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/nitrium_output
	name = "氮素气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/pluoxium_output
	name = "富氧气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/proto_nitrate_output
	name = "原硝气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/tritium_output
	name = "氚气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/water_vapor_output
	name = "水蒸气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/zauker_output
	name = "灼蚀气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/helium_output
	name = "氦气储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/antinoblium_output
	name = "反惰性气体储罐输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/incinerator_output
	name = "焚烧室输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/ordnance_burn_chamber_output
	name = "军械燃烧室输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/ordnance_freezer_chamber_output
	name = "军械冷冻室输出抽气口"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/monitored
	on = TRUE
	icon_state = "vent_map_siphon_on-3"

// Same as the rest, but bigger volume.
/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/monitored/Initialize(mapload)
	. = ..()
	//we dont want people messing with these special vents using the air alarm interface
	disconnect_from_area()

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/monitored/air_output
	name = "混合空气储罐输出抽气口"
