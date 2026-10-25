/datum/supply_pack/science
	group = "Science"
	access_view = ACCESS_RESEARCH
	crate_type = /obj/structure/closet/crate/science

/datum/supply_pack/science/plasma
	name = "等离子组件箱"
	desc = "把东西烧成灰所需的一切，内含三套 \
		等离子组件。每套包含一个等离子气罐、点火器、接近传感器 \
		和计时器！暴露于高温环境将导致保修失效。"
	cost = CARGO_CRATE_VALUE * 2
	access = ACCESS_ORDNANCE
	access_view = ACCESS_ORDNANCE
	contains = list(/obj/item/tank/internals/plasma = 3,
					/obj/item/assembly/igniter = 3,
					/obj/item/assembly/prox_sensor = 3,
					/obj/item/assembly/timer = 3,
				)
	crate_name = "等离子组件箱"
	crate_type = /obj/structure/closet/crate/secure/plasma

// Dummy type used in generating anomaly core supply packs, not actually orderable
/datum/supply_pack/science/raw_anomaly
	cost = CARGO_CRATE_VALUE * 10
	access = ACCESS_ORDNANCE
	access_view = ACCESS_ORDNANCE
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/science/raw_anomaly/generate_supply_packs()
	if(length(contains))
		return null // having contents indicates this is a generated pack so it doesn't need to generate more

	var/list/anomaly_packs = list()
	for(var/obj/item/raw_anomaly_core/raw_core as anything in subtypesof(/obj/item/raw_anomaly_core) - /obj/item/raw_anomaly_core/random)
		var/datum/supply_pack/science/raw_anomaly/pack = new
		pack.name = full_capitalize(raw_core::name)
		pack.id = "[type]/[raw_core]"
		pack.desc = "内含 [raw_core::anomaly_type::anomaly_type::name || "异常"] 的原始核心，可用于内爆压缩成强大的人工制品。"
		pack.contains = list(raw_core)
		pack.crate_name = LOWER_TEXT(pack.name)
		anomaly_packs += pack
	return anomaly_packs

/datum/supply_pack/science/robotics
	name = "机器人技术组件箱"
	desc = "把那些难伺候的人类换成忠实机器人军团所需的工具！ \
		内含四个接近传感器、两个空急救箱、两个健康分析仪、 \
		两顶红色安全帽、两个工具箱和两套清洁机器人组件！"
	cost = CARGO_CRATE_VALUE * 3
	access = ACCESS_ROBOTICS
	access_view = ACCESS_ROBOTICS
	contains = list(/obj/item/assembly/prox_sensor = 4,
					/obj/item/healthanalyzer = 2,
					/obj/item/clothing/head/utility/hardhat/red = 2,
					/obj/item/storage/medkit = 2,
					/obj/item/storage/toolbox = 2,
					/obj/item/bot_assembly/cleanbot = 2)
	crate_name = "机器人技术组件箱"
	crate_type = /obj/structure/closet/crate/secure/science/robo

/datum/supply_pack/science/rped
	name = "RPED 箱"
	desc = "需要重建 ORM，但科研部在一场炸弹测试后被彻底抹平了？ \
		买下它，获得纳米传讯能提供的最先进零件。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/storage/part_replacer/cargo)
	crate_name = "\improper RPED 箱"

/datum/supply_pack/science/shieldwalls
	name = "护盾发生器箱"
	desc = "这些大功率护盾墙发生器保证能把任何不受欢迎的生命体挡在外面， \
		那才是它们该待的地方！内含四台护盾墙发生器。"
	cost = CARGO_CRATE_VALUE * 4
	access = ACCESS_TELEPORTER
	access_view = ACCESS_TELEPORTER
	contains = list(/obj/machinery/power/shieldwallgen = 4)
	crate_name = "护盾发生器箱"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/science/transfer_valves
	name = "气罐传输阀箱"
	desc = "让一大群人迅速暴怒的关键原料。 \
		内含两个气罐传输阀。"
	cost = CARGO_CRATE_VALUE * 12
	access = ACCESS_RD
	contains = list(/obj/item/transfer_valve = 2)
	crate_name = "气罐传输阀箱"
	crate_type = /obj/structure/closet/crate/secure/science
	order_flags = ORDER_DANGEROUS

/datum/supply_pack/science/monkey_helmets
	name = "猴子心智放大头盔箱"
	desc = "有些研究最适合用猴子来做，但有时它们 \
		实在太笨，无法完成更复杂的任务。这两顶头盔应该能帮上忙。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/clothing/head/helmet/monkey_sentience = 2)
	crate_name = "猴子心智放大箱"

/datum/supply_pack/science/cytology
	name = "细胞学用品箱"
	desc = "失控的标本把异种生物学实验室碾成粉末了？这里还有更多 \
		用品用于进一步测试。内含一台显微镜、一件活检工具、两个培养皿， \
		以及一盒拭子。"
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_XENOBIOLOGY
	contains = list(/obj/structure/microscope,
					/obj/item/biopsy_tool,
					/obj/item/storage/box/petridish = 2,
					/obj/item/storage/box/swab,
					/obj/item/circuitboard/machine/vatgrower,
					/obj/item/reagent_containers/condiment/protein,
				)
	crate_name = "细胞学用品箱"

/datum/supply_pack/science/mod_core
	name = "MOD 核心箱"
	desc = "三个核心，适用于任何 MOD 外骨骼的建造！当然是天然采集™的。"
	cost = CARGO_CRATE_VALUE * 3
	access = ACCESS_ROBOTICS
	access_view = ACCESS_ROBOTICS
	contains = list(/obj/item/mod/core/standard = 3)
	crate_name = "\improper MOD 核心箱"
	crate_type = /obj/structure/closet/crate/nakamura

/datum/supply_pack/science/gizmo
	name = "小装置研究箱"
	desc = "三个怪异的科研小装置玩意儿？我们也不知道它们是干什么的。"
	cost = CARGO_CRATE_VALUE * 5
	access = ACCESS_SCIENCE
	access_view = ACCESS_SCIENCE
	contains = list(
		/obj/machinery/gizmo = 1,
		/obj/effect/spawner/random/gizmo = 2,
	)
	crate_name = "\improper 小装置研究箱"
