// Machine categories

#define FABRICATOR_CATEGORY_FLATPACK_MACHINES "/扁平包装机械"
#define FABRICATOR_SUBCATEGORY_MANUFACTURING "/制造"
#define FABRICATOR_SUBCATEGORY_POWER "/电力"
#define FABRICATOR_SUBCATEGORY_MATERIALS "/材料"
#define FABRICATOR_SUBCATEGORY_ATMOS "/大气"

// Techweb node that shouldnt show up anywhere ever specifically for the fabricator to work with

/datum/techweb_node/colony_fabricator_flatpacks
	id = TECHWEB_NODE_COLONY_FLATPACKS
	display_name = "殖民地制造机扁平包装设计"
	description = "包含殖民地制造机的所有扁平包装机械设计。"
	design_ids = list(
		"flatpack_solar_panel",
		"flatpack_solar_tracker",
		"flatpack_arc_furnace",
		"flatpack_colony_fab",
		"flatpack_station_battery",
		"flatpack_station_battery_large",
		"flatpack_fuel_generator",
		"flatpack_rtg",
		"flatpack_thermo",
		"flatpack_ore_silo",
		"flatpack_turbine_team_fortress_two",
		"flatpack_bootleg_teg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = INFINITY) // God save you
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

// Lets the colony lathe make more colony lathes but at very hihg cost, for fun

/datum/design/flatpack_colony_fabricator
	name = "扁平包装殖民地制造机"
	desc = "一台可部署的制造机，能够生产其他扁平包装机械，以及专为在拥有资源与电力时快速建造实用结构而\
		量身定制的特殊设备。虽然它无法升级，但可以重新打包\
		并搬到任何你认为合适的地方。"
	id = "flatpack_colony_fab"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/flatpacked_machine
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MANUFACTURING,
	)
	construction_time = 2 MINUTES

// Solar panels and trackers

/datum/design/flatpack_solar_panel
	name = "扁平包装太阳能板"
	desc = "一台可部署的太阳能板，放置后可以重新打包，以便搬迁或回收。"
	id = "flatpack_solar_panel"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1,
	)
	build_path = /obj/item/flatpacked_machine/solar
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 5 SECONDS

/datum/design/flatpack_solar_tracker
	name = "扁平包装太阳能追踪器"
	desc = "一台可部署的太阳能追踪器，放置后可以重新打包，以便搬迁或回收。"
	id = "flatpack_solar_tracker"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3.5,
	)
	build_path = /obj/item/flatpacked_machine/solar_tracker
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 7 SECONDS

// Arc furance

/datum/design/flatpack_arc_furnace
	name = "扁平包装电弧炉"
	desc = "一台可部署的矿石精炼炉。虽然比传统精炼方式更慢、也更不安全， \
		但它对精炼材料的产出倍率足以让它仍胜过简单回收矿石。"
	id = "flatpack_arc_furnace"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/flatpacked_machine/arc_furnace
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MATERIALS,
	)
	construction_time = 15 SECONDS

// Power storage structures

/datum/design/flatpack_power_storage
	name = "扁平包装固定式电池"
	desc = "一台可部署的空间站级电力电池，总容量较低，但输入输出速率很高。"
	id = "flatpack_station_battery"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/station_battery
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 20 SECONDS

/datum/design/flatpack_power_storage_large
	name = "扁平包装大型固定式电池"
	desc = "一台可部署的空间站级电力电池，总容量极高，但输入输出速率较低。"
	id = "flatpack_station_battery_large"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/large_station_battery
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 40 SECONDS

// PACMAN generator but epic!!

/datum/design/flatpack_solids_generator
	name = "扁平包装 S.O.F.I.E. 发电机"
	desc = "一台可部署的等离子燃烧发电机，性能甚至能超过升级过的 P.A.C.M.A.N. 型发电机， \
		代价是会排出炽热的二氧化碳废气。"
	id = "flatpack_fuel_generator"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/fuel_generator
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 30 SECONDS

// Buildable RTG that is quite radioactive

/datum/design/flatpack_rtg
	name = "扁平包装放射性同位素热电发电机"
	desc = "一台可部署的放射性同位素发电机，能产生几乎免费的涓流电力。 \
		当然，前提是你能忍受它在部署期间放出的辐射。"
	id = "flatpack_rtg"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/rtg
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 30 SECONDS

// Thermomachine with decent temperature change rate, but a limited max/min temperature

/datum/design/flatpack_thermomachine
	name = "扁平包装大气温度调节器"
	desc = "一台可部署的温度控制设备，用于大气管道系统。 \
		其温度范围有限，但热容量高于标准水平。"
	id = "flatpack_thermo"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/thermomachine
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_ATMOS,
	)
	construction_time = 20 SECONDS

// Ore silo except it beeps

/datum/design/flatpack_ore_silo
	name = "扁平包装矿石筒仓"
	desc = "一体化的材料管理方案。通过分配系统网络\
		连接各类消耗资源的机器。"
	id = "flatpack_ore_silo"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/flatpacked_machine/ore_silo
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MATERIALS,
	)
	construction_time = 1 MINUTES

// Wind turbine, produces tiny amounts of power when placed outdoors in an atmosphere, but makes significantly more if there's a storm in that area

/datum/design/flatpack_turbine_team_fortress_two
	name = "扁平包装微型风力涡轮机"
	desc = "一台可部署的制造机，能够生产其他扁平包装机械，以及专为在拥有资源与电力时快速建造实用结构而\
		量身定制的特殊设备。虽然它无法升级，但可以重新打包\
		并搬到任何你认为合适的地方。这一台能制造专业的工程设计与工具。"
	id = "flatpack_turbine_team_fortress_two"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/wind_turbine
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 30 SECONDS

// Stirling generator, kinda like a TEG but on a smaller scale and producing less insane amounts of power

/datum/design/flatpack_bootleg_teg
	name = "扁平包装斯特林发电机"
	desc = "一台工业规模的斯特林发电机。斯特林发电机通过进气管道吸入\
		高温气体，并依靠周围的环境空气冷却来运作。\
		由此产生的循环压缩与膨胀会发电，而这一台的设计目标\
		是为小型空间站与前哨站规模的设施供电。"
	id = "flatpack_bootleg_teg"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/flatpacked_machine/stirling_generator
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 2 MINUTES

#undef FABRICATOR_CATEGORY_FLATPACK_MACHINES
#undef FABRICATOR_SUBCATEGORY_MANUFACTURING
#undef FABRICATOR_SUBCATEGORY_POWER
#undef FABRICATOR_SUBCATEGORY_MATERIALS
#undef FABRICATOR_SUBCATEGORY_ATMOS
