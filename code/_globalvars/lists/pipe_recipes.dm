GLOBAL_LIST_INIT(atmos_pipe_recipes, list(
	"Pipes" = list(
		new /datum/pipe_info/pipe("管道", /obj/machinery/atmospherics/pipe/smart, TRUE),
		new /datum/pipe_info/pipe("管层转接器", /obj/machinery/atmospherics/pipe/layer_manifold, TRUE),
		new /datum/pipe_info/pipe("颜色转接器", /obj/machinery/atmospherics/pipe/color_adapter, TRUE),
		new /datum/pipe_info/pipe/bridge_pipe,
		new /datum/pipe_info/pipe/multiz_connector,
	),
	"Binary" = list(
		new /datum/pipe_info/pipe/manual_valve,
		new /datum/pipe_info/pipe/digital_valve,
		new /datum/pipe_info/pipe/gas_pump,
		new /datum/pipe_info/pipe/volume_pump,
		new /datum/pipe_info/pipe/passive_gate,
		new /datum/pipe_info/pipe/pressure_valve,
		new /datum/pipe_info/pipe/temperature_gate,
		new /datum/pipe_info/pipe/temperature_pump,
	),
	"Devices" = list(
		new /datum/pipe_info/pipe("气体过滤器", /obj/machinery/atmospherics/components/trinary/filter, TRUE),
		new /datum/pipe_info/pipe("气体混合器", /obj/machinery/atmospherics/components/trinary/mixer, TRUE),
		new /datum/pipe_info/pipe("连接口", /obj/machinery/atmospherics/components/unary/portables_connector, TRUE),
		new /datum/pipe_info/pipe("注气口", /obj/machinery/atmospherics/components/unary/outlet_injector, TRUE),
		new /datum/pipe_info/pipe("洗气口", /obj/machinery/atmospherics/components/unary/vent_scrubber, TRUE),
		new /datum/pipe_info/pipe/vent,
		new /datum/pipe_info/pipe/passive_vent,
		new /datum/pipe_info/meter,
	),
	"Heat Exchange" = list(
		new /datum/pipe_info/pipe("管道", /obj/machinery/atmospherics/pipe/heat_exchanging/simple, FALSE),
		new /datum/pipe_info/pipe("分流管", /obj/machinery/atmospherics/pipe/heat_exchanging/manifold, FALSE),
		new /datum/pipe_info/pipe("四通分流管", /obj/machinery/atmospherics/pipe/heat_exchanging/manifold4w, FALSE),
		new /datum/pipe_info/pipe("接头", /obj/machinery/atmospherics/pipe/heat_exchanging/junction, FALSE),
		new /datum/pipe_info/pipe/heat_exchanger,
	)
))

GLOBAL_LIST_INIT(disposal_pipe_recipes, list(
	"Disposal Pipes" = list(
		new /datum/pipe_info/disposal("管道", /obj/structure/disposalpipe/segment, PIPE_BENDABLE),
		new /datum/pipe_info/disposal("接头", /obj/structure/disposalpipe/junction, PIPE_TRIN_M),
		new /datum/pipe_info/disposal("Y 形接头", /obj/structure/disposalpipe/junction/yjunction),
		new /datum/pipe_info/disposal("分拣接头", /obj/structure/disposalpipe/sorting/mail, PIPE_TRIN_M),
		new /datum/pipe_info/disposal("转向器", /obj/structure/disposalpipe/rotator, PIPE_ONEDIR_FLIPPABLE),
		new /datum/pipe_info/disposal("竖直管口", /obj/structure/disposalpipe/trunk),
		new /datum/pipe_info/disposal("下弯管", /obj/structure/disposalpipe/trunk/multiz/down),
		new /datum/pipe_info/disposal("上弯管", /obj/structure/disposalpipe/trunk/multiz),
		new /datum/pipe_info/disposal("垃圾桶", /obj/machinery/disposal/bin, PIPE_ONEDIR),
		new /datum/pipe_info/disposal("排出口", /obj/structure/disposaloutlet),
		new /datum/pipe_info/disposal("投递口", /obj/machinery/disposal/delivery_chute),
	)
))

GLOBAL_LIST_INIT(transit_tube_recipes, list(
	"Transit Tubes" = list(
		new /datum/pipe_info/transit("直管", /obj/structure/c_transit_tube, PIPE_STRAIGHT),
		new /datum/pipe_info/transit("交叉直管", /obj/structure/c_transit_tube/crossing, PIPE_STRAIGHT),
		new /datum/pipe_info/transit("弯管", /obj/structure/c_transit_tube/curved, PIPE_UNARY_FLIPPABLE),
		new /datum/pipe_info/transit("斜管", /obj/structure/c_transit_tube/diagonal, PIPE_STRAIGHT),
		new /datum/pipe_info/transit("交叉斜管", /obj/structure/c_transit_tube/diagonal/crossing, PIPE_STRAIGHT),
		new /datum/pipe_info/transit("接头", /obj/structure/c_transit_tube/junction, PIPE_UNARY_FLIPPABLE),
	),
	"Station Equipment" = list(
		new /datum/pipe_info/transit("贯通式管道站", /obj/structure/c_transit_tube/station, PIPE_STRAIGHT),
		new /datum/pipe_info/transit("终点式管道站", /obj/structure/c_transit_tube/station/reverse, PIPE_UNARY_FLIPPABLE),
		new /datum/pipe_info/transit("贯通式座舱发放站", /obj/structure/c_transit_tube/station/dispenser, PIPE_STRAIGHT),
		new /datum/pipe_info/transit("终点式座舱发放站", /obj/structure/c_transit_tube/station/dispenser/reverse, PIPE_UNARY_FLIPPABLE),
		new /datum/pipe_info/transit("运输管道座舱", /obj/structure/c_transit_tube_pod, PIPE_ONEDIR),
	)
))
