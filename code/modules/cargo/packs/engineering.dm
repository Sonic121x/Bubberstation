/datum/supply_pack/engineering
	group = "Engineering"
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/engineering/shieldgen
	name = "防破口护盾投射器板条箱"
	desc = "又船体破口了？有了纳米传讯防破口护盾投射器，就不用担心！ \
		它利用力场技术把空气留在里面，把太空挡在外面。内含两台护盾投射器。"
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/machinery/shieldgen = 2)
	crate_name = "防破口护盾投射器板条箱"

/datum/supply_pack/engineering/ripley
	name = "APLU MK-I 板条箱"
	desc = "一套自行组装 ALPU MK-I“雷普利”的套件，专为吊装、 \
		搬运重型设备以及执行其他空间站任务而设计。不含电池。"
	cost = CARGO_CRATE_VALUE * 10
	access_view = ACCESS_ROBOTICS
	contains = list(/obj/item/mecha_parts/chassis/ripley,
					/obj/item/mecha_parts/part/ripley_torso,
					/obj/item/mecha_parts/part/ripley_right_arm,
					/obj/item/mecha_parts/part/ripley_left_arm,
					/obj/item/mecha_parts/part/ripley_right_leg,
					/obj/item/mecha_parts/part/ripley_left_leg,
					/obj/item/stock_parts/capacitor,
					/obj/item/stock_parts/scanning_module,
					/obj/item/stock_parts/servo,
					/obj/item/circuitboard/mecha/ripley/main,
					/obj/item/circuitboard/mecha/ripley/peripherals,
					/obj/item/mecha_parts/mecha_equipment/drill,
					/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp,
				)
	crate_name= "\improper APLU MK-I 套件"
	crate_type = /obj/structure/closet/crate/science/robo

/datum/supply_pack/engineering/conveyor
	name = "传送带组件板条箱"
	desc = "用三十条传送带让生产线持续运转。内含传送带开关。 \
		如有疑问，请查阅随附的说明书。"
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(/obj/item/stack/conveyor/thirty,
					/obj/item/conveyor_switch_construct,
					/obj/item/paper/guides/conveyor,
				)
	crate_name = "传送带组件板条箱"

/datum/supply_pack/engineering/engiequipment
	name = "工程装备板条箱"
	desc = "为你装备三条工具腰带、高可视背心、焊接头盔、安全帽， \
		以及两副介子护目镜！"
	cost = CARGO_CRATE_VALUE * 4
	access_view = ACCESS_ENGINEERING
	contains = list(/obj/item/storage/belt/utility = 3,
					/obj/item/clothing/suit/hazardvest = 3,
					/obj/item/clothing/head/utility/welding = 3,
					/obj/item/clothing/head/utility/hardhat = 3,
					/obj/item/clothing/glasses/meson/engine = 2,
				)
	crate_name = "工程装备板条箱"

/datum/supply_pack/engineering/powergamermitts
	name = "绝缘手套板条箱"
	desc = "现代社会的支柱。几乎从不是为了真正的工程工作而订购。 \
		内含三副绝缘手套。"
	cost = CARGO_CRATE_VALUE * 8 //Made of pure-grade bullshittinium
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/clothing/gloves/color/yellow = 3)
	crate_name = "绝缘手套板条箱"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/inducers
	name = "NT-75 电磁供能感应器板条箱"
	desc = "没有充电器？没问题，有了 NT-75 EPI，你可以随时随地为任何标准 \
		电池设备充电。内含两台感应器。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/inducer/orderable = 2)
	crate_name = "感应器板条箱"
	crate_type = /obj/structure/closet/crate/nakamura

/datum/supply_pack/engineering/pacman
	name = "P.A.C.M.A.N 发电机板条箱"
	desc = "工程师搞不定引擎？只要你拿到这台 P.A.C.M.A.N. 发电机， \
		这就不再是问题！它吸入等离子体，吐出甜美的能量。"
	cost = CARGO_CRATE_VALUE * 5
	access_view = ACCESS_ENGINEERING
	contains = list(/obj/machinery/power/port_gen/pacman)
	crate_name = "\improper P.A.C.M.A.N 发电机板条箱"
	crate_type = /obj/structure/closet/crate/nakamura

/datum/supply_pack/engineering/power
	name = "电池板条箱"
	desc = "想要压倒性的电力？不用再找了。内含三块高压电池。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/stock_parts/power_store/cell/high = 3)
	crate_name = "电池板条箱"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/shuttle_engine
	name = "穿梭机引擎板条箱"
	desc = "凭借先进的蓝空间奇技，我们的工程师成功把一整台 \
		穿梭机引擎塞进了一个小小的盒子里。"
	cost = CARGO_CRATE_VALUE * 6
	access = ACCESS_ENGINEERING
	access_view = ACCESS_ENGINEERING
	contains = list(/obj/item/flatpack/shuttle_engine)
	crate_name = "穿梭机引擎板条箱"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/engineering/tools
	name = "工具箱板条箱"
	desc = "任何强劲的太空人身边都少不了一个可靠的工具箱。内含三个电气 \
		工具箱和三个机械工具箱。"
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/storage/toolbox/electrical = 3,
					/obj/item/storage/toolbox/mechanical = 3,
				)
	cost = CARGO_CRATE_VALUE * 5
	crate_name = "工具箱板条箱"

/datum/supply_pack/engineering/portapump
	name = "便携式空气泵板条箱"
	desc = "又有人把穿梭机的空气放跑了？交给我们吧。 \
		内含两台便携式空气泵。"
	cost = CARGO_CRATE_VALUE * 4.5
	access_view = ACCESS_ATMOSPHERICS
	contains = list(/obj/machinery/portable_atmospherics/pump = 2)
	crate_name = "便携式空气泵板条箱"
	crate_type = /obj/structure/closet/crate/secure/engineering/atmos

/datum/supply_pack/engineering/portascrubber
	name = "便携式气体净化器板条箱"
	desc = "用你自己的两台便携式净化器清理那烦人的等离子体泄漏。"
	cost = CARGO_CRATE_VALUE * 4.5
	access_view = ACCESS_ATMOSPHERICS
	contains = list(/obj/machinery/portable_atmospherics/scrubber = 2)
	crate_name = "便携式气体净化器板条箱"
	crate_type = /obj/structure/closet/crate/secure/engineering/atmos

/datum/supply_pack/engineering/hugescrubber
	name = "大型便携式气体净化器板条箱"
	desc = "一台大型便携式净化器，专治大型大气失误。"
	cost = CARGO_CRATE_VALUE * 7.5
	access_view = ACCESS_ATMOSPHERICS
	contains = list(/obj/machinery/portable_atmospherics/scrubber/huge/movable/cargo)
	crate_name = "大型便携式气体净化器板条箱"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/engineering/space_heater
	name = "太空加热器板条箱"
	desc = "一台两用加热/制冷机，应对太冷或太热的天气。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/machinery/space_heater)
	crate_name = "太空加热器板条箱"
	crate_type = /obj/structure/closet/crate/secure/engineering/atmos

/datum/supply_pack/engineering/bsa
	name = "蓝空间火炮部件"
	desc = "纳米传讯海军指挥部的骄傲。传说级的蓝空间火炮是人类工程学的 \
		毁灭性壮举，也是战时决心的证明。 \
		正确建造需要极高级别的研究。"
	cost = CARGO_CRATE_VALUE * 30
	order_flags = ORDER_SPECIAL
	access_view = ACCESS_COMMAND
	contains = list(/obj/item/paper/guides/jobs/engineering/bsa,
					/obj/item/circuitboard/machine/bsa/front,
					/obj/item/circuitboard/machine/bsa/middle,
					/obj/item/circuitboard/machine/bsa/back,
					/obj/item/circuitboard/computer/bsa_control,
				)
	crate_name= "蓝空间火炮部件板条箱"

/datum/supply_pack/engineering/dna_vault
	name = "DNA 库部件"
	desc = "在这座庞大的科学知识库中确保人类当前状态的延续， \
		它能赋予超人的力量与能力。 \
		正确建造需要极高级别的研究。另含五支 DNA 探针。"
	cost = CARGO_CRATE_VALUE * 24
	order_flags = ORDER_SPECIAL
	access_view = ACCESS_COMMAND
	contains = list(/obj/item/circuitboard/machine/dna_vault,
					/obj/item/dna_probe = 5,
				)
	crate_name= "DNA 库部件板条箱"

/datum/supply_pack/engineering/dna_probes
	name = "DNA 库采样器"
	desc = "内含五支用于 DNA 库的 DNA 探针。"
	cost = CARGO_CRATE_VALUE * 6
	order_flags = ORDER_SPECIAL
	access_view = ACCESS_COMMAND
	contains = list(/obj/item/dna_probe = 5)
	crate_name= "DNA 采样器板条箱"


/datum/supply_pack/engineering/shield_sat
	name = "护盾发生器卫星"
	desc = "用这些反陨石防御保护这座空间站的存在。 \
		内含三颗护盾发生器卫星。"
	cost = CARGO_CRATE_VALUE * 6
	access_view = ACCESS_COMMAND
	contains = list(/obj/machinery/satellite/meteor_shield = 3)
	crate_name= "护盾卫星板条箱"


/datum/supply_pack/engineering/shield_sat_control
	name = "护盾系统控制板"
	desc = "护盾发生器卫星系统的控制系统。"
	cost = CARGO_CRATE_VALUE * 10
	access_view = ACCESS_COMMAND
	contains = list(/obj/item/circuitboard/computer/sat_control)
	crate_name= "护盾控制板板条箱"

/datum/supply_pack/engineering/ceturtlenecks
	name = "总工程师高领衫"
	desc = "内含总工程师的高领衫和高领裙。"
	cost = CARGO_CRATE_VALUE * 2
	access = ACCESS_CE
	contains = list(/obj/item/clothing/under/rank/engineering/chief_engineer/turtleneck,
					/obj/item/clothing/under/rank/engineering/chief_engineer/turtleneck/skirt,
				)

/// Engine Construction

/datum/supply_pack/engine
	group = "Engine Construction"
	access_view = ACCESS_ENGINEERING
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/engine/emitter
	name = "发射器板条箱"
	desc = "既能给力场发生器供电，也能摧毁上锁的板条箱 \
		和入侵者。内含两台高功率能量发射器。"
	cost = CARGO_CRATE_VALUE * 7
	access = ACCESS_CE
	contains = list(/obj/machinery/power/emitter = 2)
	crate_name = "发射器板条箱"
	crate_type = /obj/structure/closet/crate/secure/engineering
	order_flags = ORDER_DANGEROUS

/datum/supply_pack/engine/field_gen
	name = "力场发生器板条箱"
	desc = "通常是空间站与惨烈死亡之间唯一的屏障。 \
		由发射器供能。内含两台力场发生器。"
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/machinery/field/generator = 2)
	crate_name = "力场发生器板条箱"

/datum/supply_pack/engine/grounding_rods
	name = "接地棒板条箱"
	desc = "四根接地棒，保证能让任何不听话的特斯拉线圈的闪电乖乖受控。"
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/machinery/power/energy_accumulator/grounding_rod = 4)
	crate_name = "接地棒板条箱"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engine/solar
	name = "太阳能板板条箱"
	desc = "用这套自行组装的高级太阳能阵列实现环保。内含二十一个太阳能组件、 \
		一块太阳能控制电路板和一个追踪器。如有疑问， \
		请查阅随附的说明书。"
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/item/solar_assembly = 21,
					/obj/item/circuitboard/computer/solar_control,
					/obj/item/electronics/tracker,
					/obj/item/paper/guides/jobs/engi/solars,
				)
	crate_name = "太阳能板板条箱"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engine/supermatter_shard
	name = "超物质碎片板条箱"
	desc = "将天空之力凝聚于单一晶体之中。"
	cost = CARGO_CRATE_VALUE * 20
	access = ACCESS_CE
	contains = list(/obj/machinery/power/supermatter_crystal/shard)
	crate_name = "超物质碎片板条箱"
	crate_type = /obj/structure/closet/crate/secure/radiation
	order_flags = ORDER_DANGEROUS
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/engine/tesla_coils
	name = "特斯拉线圈板条箱"
	desc = "无论是高压处决、产出研究点数，还是单纯把助手电焦的老把戏： \
		这组四个特斯拉线圈样样都能干！"
	cost = CARGO_CRATE_VALUE * 10
	contains = list(/obj/machinery/power/energy_accumulator/tesla_coil = 4)
	crate_name = "特斯拉线圈板条箱"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engine/hypertorus_fusion_reactor
	name = "HFR 板条箱"
	desc = "全新改进型聚变反应堆。"
	cost = CARGO_CRATE_VALUE * 23
	access = ACCESS_CE
	contains = list(/obj/item/hfr_box/corner = 4,
					/obj/item/hfr_box/body/fuel_input,
					/obj/item/hfr_box/body/moderator_input,
					/obj/item/hfr_box/body/waste_output,
					/obj/item/hfr_box/body/interface,
					/obj/item/hfr_box/core,
				)
	crate_name = "HFR 板条箱"
	crate_type = /obj/structure/closet/crate/secure/engineering/atmos
	order_flags = ORDER_DANGEROUS

/datum/supply_pack/engineering/rad_protection_modules
	name = "辐射防护模块"
	desc = "内含多个用于 MOD 外骨骼的辐射防护模块。"
	order_flags = ORDER_INVISIBLE
	contains = list(/obj/item/mod/module/rad_protection = 3)
	crate_name = "MOD 外骨骼辐射模块"
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/engineering/rad_nebula_shielding_kit
	name = "放射性星云屏蔽"
	desc = "内含用于建造放射性星云屏蔽的电路板和辐射模块。"
	cost = CARGO_CRATE_VALUE * 2

	order_flags = ORDER_SPECIAL
	contains = list(
		/obj/item/mod/module/rad_protection = 5,
		/obj/item/circuitboard/machine/radioactive_nebula_shielding = 5,
		/obj/item/paper/fluff/radiation_nebula = 1,
	)
	crate_name = "放射性星云屏蔽（重要）"
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/engineering/portagrav
	name = "便携式重力装置板条箱"
	desc = "内含一台便携式重力装置，可以让小丑飘到天花板上。"
	cost = CARGO_CRATE_VALUE * 4
	access_view = ACCESS_ENGINEERING
	contains = list(/obj/machinery/power/portagrav = 1)
	crate_name = "便携式重力装置板条箱"
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/engineering/golfcart
	name = "高尔夫球车部件套件板条箱"
	desc = "内含用于组装一辆运送重型机械和货物穿越空间站的小车的部件。 \
		纳米传讯对将小车当作“派对马车”驾驶的行为不承担任何责任。"
	cost = CARGO_CRATE_VALUE * 11
	access_view = ACCESS_ENGINEERING
	contains = list(/obj/item/golfcart_kit = 1, /obj/item/key/golfcart = 2, /obj/item/stock_parts/power_store/cell/lead = 1)
	crate_name = "高尔夫球车部件套件"
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/engineering/concrete_mix
	name = "混凝土混合料"
	desc = "懒得动手？又急需一座建筑？使用近乎瞬间凝固的混凝土混合料！只需加水。"
	cost = CARGO_CRATE_VALUE * 5
	access_view = ACCESS_ENGINEERING
	contains = list(
		/obj/item/reagent_containers/cup/jerrycan/concrete_mix = 2,
		/obj/item/reagent_containers/cup/bucket = 1,
	)
	crate_name = "混凝土混合料板条箱"
	crate_type = /obj/structure/closet/crate/engineering
