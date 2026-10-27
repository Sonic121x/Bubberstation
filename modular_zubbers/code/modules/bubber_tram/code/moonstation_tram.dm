/obj/effect/landmark/transport/transport_id/moonstation/line_1
	specific_transport_id = MOONSTATION_LINE_1

/obj/effect/landmark/transport/nav_beacon/tram/nav/moonstation/main
	name = MOONSTATION_LINE_1
	specific_transport_id = TRAM_NAV_BEACONS
	dir = WEST

/obj/effect/landmark/transport/nav_beacon/tram/platform/moonstation/terminal
	name = "到达站"
	specific_transport_id = MOONSTATION_LINE_1
	platform_code = MOONSTATION_TERMINAL
	tgui_icons = list("到达站" = "plane-arrival", "低温休眠舱" = "bed-pulse")

/obj/effect/landmark/transport/nav_beacon/tram/platform/moonstation/station
	name = "主站"
	specific_transport_id = MOONSTATION_LINE_1
	platform_code = MOONSTATION_MAIN_STATION
	tgui_icons = list("主站" = "arrow-right-to-city", "出发/撤离" = "plane-departure")

/obj/machinery/transport/tram_controller/moonstation
	name = "月球车控制器"
	desc = "与昔年那辆标志性的月球车不同，我们的电车在此提醒你：即便在太空，平庸也总能找到出路。"
	configured_transport_id = MOONSTATION_LINE_1
	obj_flags = parent_type::obj_flags | NO_DEBRIS_AFTER_DECONSTRUCTION

/obj/machinery/transport/destination_sign/moonstation
	icon = 'modular_zubbers/icons/obj/machines/tram_display.dmi'
	configured_transport_id = MOONSTATION_LINE_1

/obj/machinery/transport/destination_sign/indicator/moonstation
	icon = 'modular_zubbers/icons/obj/machines/tram_indicator.dmi'
	configured_transport_id = MOONSTATION_LINE_1

/obj/machinery/transport/destination_sign/Initialize(mapload)
	. = ..()
	LAZYADD(available_faces, MOONSTATION_LINE_1)

/obj/machinery/computer/tram_controls/moonstation
	name = "月球车控制台"
	desc = "与昔年那辆标志性的月球车不同，我们的电车在此提醒你：即便在太空，平庸也总能找到出路。"
	icon = 'modular_zubbers/icons/obj/machines/tram_controls.dmi'
	base_icon_state = "moon"
	icon_screen = MOONSTATION_LINE_1
	specific_transport_id = MOONSTATION_LINE_1

/obj/machinery/computer/tram_controls/moonstation/directional/north
	dir = SOUTH
	pixel_x = -16
	pixel_y = 32

/obj/machinery/computer/tram_controls/moonstation/directional/south
	dir = NORTH
	pixel_x = 16
	pixel_y = -32

/obj/machinery/door/airlock/tram/moonstation
	name = "月球车门"
	transport_linked_id = MOONSTATION_LINE_1
