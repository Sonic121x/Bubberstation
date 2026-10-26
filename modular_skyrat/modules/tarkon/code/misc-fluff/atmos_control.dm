// Port Tarkon Atmos Control

/obj/machinery/computer/atmos_control/tarkon
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon
	reconnecting = FALSE // this is hardwired to main station chambers

/obj/item/circuitboard/computer/atmos_control/tarkon
	name = "塔肯大气控制"
	build_path = /obj/machinery/computer/atmos_control/tarkon

/obj/machinery/air_sensor/tarkon

/obj/machinery/computer/atmos_control/tarkon/oxygen_tank
	name = "塔肯氧气供应控制"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/oxygen_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_O2 = "氧气供应")

/obj/item/circuitboard/computer/atmos_control/tarkon/oxygen_tank
	name = "塔肯氧气供应控制"
	build_path = /obj/machinery/computer/atmos_control/tarkon/oxygen_tank

/obj/machinery/air_sensor/tarkon/oxygen_tank
	name = "氧气罐气体传感器"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_O2

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/oxygen_input/tarkon


/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/oxygen_output/tarkon


/obj/machinery/computer/atmos_control/tarkon/plasma_tank
	name = "塔肯等离子气体供应控制"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/plasma_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_PLAS = "等离子气体供应")

/obj/item/circuitboard/computer/atmos_control/tarkon/plasma_tank
	name = "塔肯等离子气体供应控制"
	build_path = /obj/machinery/computer/atmos_control/tarkon/plasma_tank

/obj/machinery/air_sensor/tarkon/plasma_tank
	name = "等离子气体罐传感器"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_PLAS

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/plasma_input/tarkon

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/plasma_output/tarkon

/obj/machinery/computer/atmos_control/tarkon/mix_tank
	name = "塔肯混气室控制"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/mix_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_MIX = "混气室")

/obj/item/circuitboard/computer/atmos_control/tarkon/mix_tank
	name = "塔肯混合气体供应控制"
	build_path = /obj/machinery/computer/atmos_control/tarkon/mix_tank

/obj/machinery/air_sensor/tarkon/mix_tank
	name = "混气罐气体传感器"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_MIX

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/air_input/tarkon

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/monitored/air_output/tarkon

/obj/machinery/computer/atmos_control/tarkon/nitrogen_tank
	name = "塔肯氮气供应控制"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/nitrogen_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_N2 = "氮气供应")

/obj/item/circuitboard/computer/atmos_control/tarkon/nitrogen_tank
	name = "塔肯氮气供应控制"
	build_path = /obj/machinery/computer/atmos_control/tarkon/nitrogen_tank

/obj/machinery/air_sensor/tarkon/nitrogen_tank
	name = "氮气罐气体传感器"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_N2

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/nitrogen_input/tarkon

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/nitrogen_output/tarkon

/obj/machinery/computer/atmos_control/tarkon/nitrous_tank
	name = "塔肯氧化亚氮供应控制"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/nitrous_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_N2O = "氧化亚氮供应")

/obj/item/circuitboard/computer/atmos_control/tarkon/nitrous_tank
	name = "塔肯氧化亚氮供应控制"
	build_path = /obj/machinery/computer/atmos_control/tarkon/nitrous_tank

/obj/machinery/air_sensor/tarkon/nitrous_tank
	name = "氧化亚氮罐气体传感器"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_N2O

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/nitrous_input/tarkon

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/nitrous_output/tarkon

/obj/machinery/computer/atmos_control/tarkon/carbon_tank
	name = "塔肯二氧化碳供应控制"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/carbon_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_CO2 = "二氧化碳供应")

/obj/item/circuitboard/computer/atmos_control/tarkon/carbon_tank
	name = "塔肯二氧化碳供应控制"
	build_path = /obj/machinery/computer/atmos_control/tarkon/carbon_tank

/obj/machinery/air_sensor/tarkon/carbon_tank
	name = "二氧化碳罐气体传感器"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_CO2

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/carbon_input/tarkon

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/carbon_output/tarkon

/obj/machinery/computer/atmos_control/tarkon/incinerator
	name = "塔肯焚烧室控制"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/incinerator
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_INCINERATOR = "焚烧室")

/obj/item/circuitboard/computer/atmos_control/tarkon/incinerator
	name = "塔肯焚烧室控制"
	build_path = /obj/machinery/computer/atmos_control/tarkon/incinerator

/obj/machinery/air_sensor/tarkon/incinerator_tank
	name = "焚烧室气体传感器"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_INCINERATOR

/obj/machinery/airlock_sensor/incinerator_tarkon
	id_tag = INCINERATOR_TARKON_AIRLOCK_SENSOR
	master_tag = INCINERATOR_TARKON_AIRLOCK_CONTROLLER

/obj/machinery/door/airlock/public/glass/incinerator/tarkon_interior
	name = "涡轮机内侧气闸"
	id_tag = INCINERATOR_TARKON_AIRLOCK_INTERIOR

/obj/machinery/door/airlock/public/glass/incinerator/tarkon_exterior
	name = "涡轮机外侧气闸"
	id_tag = INCINERATOR_TARKON_AIRLOCK_EXTERIOR

/obj/machinery/airlock_controller/incinerator_tarkon
	name = "焚烧室门禁控制台"
	airpump_tag = INCINERATOR_TARKON_DP_VENTPUMP
	exterior_door_tag = INCINERATOR_TARKON_AIRLOCK_EXTERIOR
	id_tag = INCINERATOR_TARKON_AIRLOCK_CONTROLLER
	interior_door_tag = INCINERATOR_TARKON_AIRLOCK_INTERIOR
	sanitize_external = TRUE
	sensor_tag = INCINERATOR_TARKON_AIRLOCK_SENSOR

/obj/machinery/atmospherics/components/binary/dp_vent_pump/high_volume/incinerator_tarkon
	id_tag = INCINERATOR_TARKON_DP_VENTPUMP

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/incinerator_input/tarkon

/obj/machinery/igniter/incinerator_tarkon
	id = INCINERATOR_TARKON_IGNITER

/obj/machinery/button/ignition/incinerator/tarkon
	id = INCINERATOR_TARKON_IGNITER
