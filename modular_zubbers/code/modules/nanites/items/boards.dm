/obj/item/circuitboard/machine/nanite_chamber
	name = "纳米机器人舱（机器电路板）"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/nanite_chamber
	req_components = list(
		/obj/item/stock_parts/scanning_module = 2,
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/servo = 1
	)

/obj/item/circuitboard/machine/nanite_program_hub
	name = "纳米机器人程序中枢（机器电路板）"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/nanite_program_hub
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/servo = 1)

/obj/item/circuitboard/machine/nanite_programmer
	name = "纳米机器人编程器（机器电路板）"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/nanite_programmer
	req_components = list(
		/obj/item/stock_parts/servo = 2,
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/scanning_module = 1
	)

/obj/item/circuitboard/machine/public_nanite_chamber
	name = "公共纳米机器人舱（机器电路板）"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/public_nanite_chamber
	req_components = list(
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/servo = 1
	)
	var/cloud_id = 1

/obj/item/circuitboard/machine/public_nanite_chamber/multitool_act(mob/living/user)
	. = ..()
	var/new_cloud = tgui_input_number(user, "设置公共纳米机器人舱的云 ID（[NANITE_MIN_CLOUD_ID+1]-[NANITE_MAX_CLOUD_ID]）。", "云 ID", cloud_id, NANITE_MAX_CLOUD_ID, NANITE_MIN_CLOUD_ID+1, 0,)
	if(!isnum(new_cloud))
		return
	cloud_id = clamp(round(new_cloud, 1), NANITE_MIN_CLOUD_ID+1, NANITE_MAX_CLOUD_ID)

/obj/item/circuitboard/machine/public_nanite_chamber/examine(mob/user)
	. = ..()
	. += "云 ID 当前设置为 [cloud_id]。"

/obj/item/circuitboard/computer/nanite_chamber_control
	name = "纳米机器人舱控制台（电脑电路板）"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/nanite_chamber_control

/obj/item/circuitboard/computer/nanite_cloud_controller
	name = "纳米机器人云控制台（电脑电路板）"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/nanite_cloud_controller
