/// APC-based area navigator. Displays all station areas with APCs and points an arrow toward the selected one.
/datum/computer_file/program/radar/navsec
	filename = "plexagonnavsec"
	filedesc = "Plexagon 导航安保"
	extended_desc = "再也不会迷路。Plexagon 导航安保会为空间站上的每个区域建立索引，并为你直指目的地，无论区域名称多么生僻、布局多么陌生。非常适合新船员，以及任何被调到从未踏足过的空间站的人。"
	program_flags = PROGRAM_ON_NTNET_STORE | PROGRAM_REQUIRES_NTNET
	program_icon = "location-arrow"
	size = 2

/datum/computer_file/program/radar/navsec/find_atom()
	return ..() || (locate(selected) in SSmachines.processing_apcs)

/datum/computer_file/program/radar/navsec/scan()
	objects = list()
	var/list/name_to_apc = list()
	for(var/obj/machinery/power/apc/station_apc as anything in SSmachines.processing_apcs)
		var/area/apc_area = station_apc.area
		if(!istype(apc_area, /area/station))
			continue
		if(!trackable(station_apc))
			continue
		name_to_apc[apc_area.name] = station_apc
	sortTim(name_to_apc, /proc/cmp_text_asc)
	for(var/area_name in name_to_apc)
		var/obj/machinery/power/apc/station_apc = name_to_apc[area_name]
		var/list/apc_info = list(
			ref = REF(station_apc),
			name = area_name,
		)
		objects += list(apc_info)

/obj/item/modular_computer/pda/assistant/install_default_programs()
	. = ..()
	store_file(new /datum/computer_file/program/radar/navsec)
