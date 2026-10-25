/datum/bounty/item/engineering/emitter
	name = "发射器"
	description = "考虑到你们星区似乎出现了那么多起解体事故，我们认为贵站的发射器设计可能存在缺陷。请给我们运一台你们自己的来。"
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/machinery/power/emitter = TRUE)

/datum/bounty/item/engineering/hydro_tray
	name = "水培槽"
	description = "实验室的技术员们正试图弄清如何降低水培槽的耗电量，但我们把上一台烧坏了。能帮我们造一台吗？"
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/machinery/hydroponics/constructable = TRUE)

/datum/bounty/item/engineering/cyborg_charger
	name = "充电站"
	description = "我们没有足够的充电器来给所有的 MOD 模块化外骨骼充电。请给我们运一台你们自己的来。"
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/machinery/recharge_station = TRUE)

/datum/bounty/item/engineering/smes_unit
	name = "储能单元"
	description = "我们需要储存更多电力。给我们来一台 SMES 单元。"
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/machinery/power/smes = TRUE)

/datum/bounty/item/engineering/pacman
	name = "P.A.C.M.A.N. 发电机"
	description = "我们的备用发电机烧断了保险丝，急需一台新的。"
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/machinery/power/port_gen/pacman = TRUE)

/datum/bounty/item/engineering/field_gen
	name = "力场发生器"
	description = "我们的一台防护力场发生器的保修已经到期了，需要一台新的来替换它。"
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/machinery/field/generator = TRUE)

/datum/bounty/item/engineering/tesla_coil
	name = "特斯拉线圈"
	description = "我们的电费太高了，给我们来一个特斯拉线圈抵一抵。"
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/machinery/power/energy_accumulator/tesla_coil = TRUE)

/datum/bounty/item/engineering/welding_tank
	name = "焊接燃料罐"
	description = "工程团队需要更多焊接燃料，给我们运一罐来。"
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/structure/reagent_dispensers/fueltank = TRUE)

/datum/bounty/item/engineering/reflector
	name = "反射镜"
	description = "我们想让发射器走更长的路线，给我们来一个反射镜来实现这一点。"
	reward = CARGO_CRATE_VALUE * 7
	wanted_types = list(/obj/structure/reflector = TRUE)
