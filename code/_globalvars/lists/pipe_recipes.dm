GLOBAL_LIST_INIT(atmos_pipe_recipes, list(
	"Pipes" = list(
		new /datum/pipe_info/pipe("管道", /obj/machinery/atmospherics/pipe/smart, TRUE),
		new /datum/pipe_info/pipe("管层转接器", /obj/machinery/atmospherics/pipe/layer_manifold, TRUE),
		new /datum/pipe_info/pipe("颜色转接器", /obj/machinery/atmospherics/pipe/color_adapter, TRUE),
		new /datum/pipe_info/pipe("跨接管", /obj/machinery/atmospherics/pipe/bridge_pipe, TRUE),
		new /datum/pipe_info/pipe("跨甲板转接器", /obj/machinery/atmospherics/pipe/multiz, FALSE),
	),
	"Binary" = list(
		new /datum/pipe_info/pipe("手动阀门", /obj/machinery/atmospherics/components/binary/valve, TRUE),
		new /datum/pipe_info/pipe("数字阀门", /obj/machinery/atmospherics/components/binary/valve/digital, TRUE),
		new /datum/pipe_info/pipe("气泵", /obj/machinery/atmospherics/components/binary/pump, TRUE),
		new /datum/pipe_info/pipe("容积泵", /obj/machinery/atmospherics/components/binary/volume_pump, TRUE),
		new /datum/pipe_info/pipe("被动阀门", /obj/machinery/atmospherics/components/binary/passive_gate, TRUE),
		new /datum/pipe_info/pipe("压力阀", /obj/machinery/atmospherics/components/binary/pressure_valve, TRUE),
		new /datum/pipe_info/pipe("温控阀", /obj/machinery/atmospherics/components/binary/temperature_gate, TRUE),
		new /datum/pipe_info/pipe("温控泵", /obj/machinery/atmospherics/components/binary/temperature_pump, TRUE),
	),
	"Devices" = list(
		new /datum/pipe_info/pipe("气体过滤器", /obj/machinery/atmospherics/components/trinary/filter, TRUE),
		new /datum/pipe_info/pipe("气体混合器", /obj/machinery/atmospherics/components/trinary/mixer, TRUE),
		new /datum/pipe_info/pipe("连接口", /obj/machinery/atmospherics/components/unary/portables_connector, TRUE),
		new /datum/pipe_info/pipe("注气口", /obj/machinery/atmospherics/components/unary/outlet_injector, TRUE),
		new /datum/pipe_info/pipe("洗气口", /obj/machinery/atmospherics/components/unary/vent_scrubber, TRUE),
		new /datum/pipe_info/pipe("单接口通风口", /obj/machinery/atmospherics/components/unary/vent_pump, TRUE),
		new /datum/pipe_info/pipe("被动通风口", /obj/machinery/atmospherics/components/unary/passive_vent, TRUE),
		new /datum/pipe_info/meter("气体仪表"),
	),
	"Heat Exchange" = list(
		new /datum/pipe_info/pipe("管道", /obj/machinery/atmospherics/pipe/heat_exchanging/simple, FALSE),
		new /datum/pipe_info/pipe("分流管", /obj/machinery/atmospherics/pipe/heat_exchanging/manifold, FALSE),
		new /datum/pipe_info/pipe("四通分流管", /obj/machinery/atmospherics/pipe/heat_exchanging/manifold4w, FALSE),
		new /datum/pipe_info/pipe("接头", /obj/machinery/atmospherics/pipe/heat_exchanging/junction, FALSE),
		new /datum/pipe_info/pipe("热交换器", /obj/machinery/atmospherics/components/unary/heat_exchanger, FALSE),
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
