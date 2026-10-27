/obj/structure/cable/multilayer/multiz //This bridges powernets betwen Z levels
	name = "多层 Z 轴电缆枢纽"
	desc = "一个柔韧的超导绝缘多层 Z 轴枢纽，用于重型跨 Z 轴电力传输。"
	icon = 'icons/obj/pipes_n_cables/structures.dmi'
	icon_state = "cablerelay-on"
	cable_layer = CABLE_LAYER_1|CABLE_LAYER_2|CABLE_LAYER_3

/obj/structure/cable/multilayer/multiz/get_cable_connections(powernetless_only)
	. = ..()
	var/turf/T = get_turf(src)
	. += locate(/obj/structure/cable/multilayer/multiz) in (GET_TURF_BELOW(T))
	. += locate(/obj/structure/cable/multilayer/multiz) in (GET_TURF_ABOVE(T))

/obj/structure/cable/multilayer/multiz/examine(mob/user)
	. = ..()
	var/turf/T = get_turf(src)
	. += span_notice("[locate(/obj/structure/cable/multilayer/multiz) in (GET_TURF_BELOW(T)) ? "已检测到" : "未检测到"]上方的枢纽。")
	. += span_notice("[locate(/obj/structure/cable/multilayer/multiz) in (GET_TURF_ABOVE(T)) ? "已检测到" : "未检测到"]下方的枢纽。")
