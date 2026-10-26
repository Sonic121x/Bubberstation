/datum/techweb_node/office_equip
	id = TECHWEB_NODE_OFFICE_EQUIP
	starting_node = TRUE
	display_name = "办公设备"
	description = "纳米传讯最出色的符合人体工学的办公科技，确保空间站行政人员保持高效，并始终遵守公司政策——毕竟即便在太空中，文书工作也从不间断。"
	design_ids = list(
		"fax",
		"sec_pen",
		"handlabel",
		"roll",
		"universal_scanner",
		"desttagger",
		"packagewrap",
		"sticky_tape",
		"toner_large",
		"toner",
		"boxcutter",
		"bounced_radio",
		"radio_headset",
		"earmuffs",
		"recorder",
		"tape",
		"toy_balloon",
		"pet_carrier",
		"chisel",
		"spraycan",
		"camera_film",
		"camera",
		"razor",
		"bucket",
		"mop",
		"wet_floor_sign",
		"pushbroom",
		"normtrash",
		"wirebrush",
		"flashlight",
		"flare",
		"water_balloon",
		"ticket_machine",
		"radio_entertainment",
		"rdd",
		"photocopier",
	)

/datum/techweb_node/sanitation
	id = TECHWEB_NODE_SANITATION
	display_name = "高级清洁技术"
	description = "纳米传讯最新的清洁科技，确保空间站保持一尘不染、没有熊出没。"
	prereq_ids = list(TECHWEB_NODE_OFFICE_EQUIP)
	design_ids = list(
		"advmop",
		"advbroom", // BUBBER EDIT ADDITION - advanced push broom
		"light_replacer",
		"spraybottle",
		"paint_remover",
		"beartrap",
		"buffer",
		"vacuum",
		"washing_machine",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	discount_experiments = list(/datum/experiment/scanning/random/janitor_trash = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SERVICE)

/datum/techweb_node/consoles
	id = TECHWEB_NODE_CONSOLES
	display_name = "民用控制台"
	description = "面向非技术岗位船员的人性化控制台，便于沟通并获取必要的空间站信息。"
	prereq_ids = list(TECHWEB_NODE_OFFICE_EQUIP)
	design_ids = list(
		"comconsole",
		"automated_announcement",
		"cargo",
		"cargorequest",
		"med_data",
		"crewconsole",
		"bankmachine",
		"account_console",
		"idcard",
		"c-reader",
		"libraryconsole",
		"libraryscanner",
		"bookbinder",
		"barcode_scanner",
		"vendor",
		"custom_vendor_refill",
		"bounty_pad_control",
		"bounty_pad",
		"digital_clock_frame",
		"telescreen_research",
		"telescreen_ordnance",
		"telescreen_interrogation",
		"telescreen_prison",
		"telescreen_bar",
		"telescreen_entertainment",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SERVICE)

/datum/techweb_node/consoles/New()
	var/has_monastery = CHECK_MAP_JOB_CHANGE(JOB_CHAPLAIN, "has_monastery")
	if(has_monastery)
		design_ids += "telescreen_monastery"
	return ..()

/datum/techweb_node/gaming
	id = TECHWEB_NODE_GAMING
	display_name = "游戏娱乐"
	description = "给空间站里的偷懒鬼准备的。"
	prereq_ids = list(TECHWEB_NODE_CONSOLES)
	design_ids = list(
		"arcade_battle",
		"arcade_orion",
		"slotmachine",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	discount_experiments = list(/datum/experiment/physical/arcade_winner = TECHWEB_TIER_2_POINTS)

// Kitchen root node
/datum/techweb_node/cafeteria_equip
	id = TECHWEB_NODE_CAFETERIA_EQUIP
	starting_node = TRUE
	display_name = "食堂设备"
	description = "当标准配给的管装食品再也满足不了空间站船员的胃口时……"
	design_ids = list(
		"griddle",
		"microwave",
		"bowl",
		"plate",
		"oven_tray",
		"servingtray",
		"tongs",
		"spoon",
		"fork",
		"kitchen_knife",
		"plastic_spoon",
		"plastic_fork",
		"plastic_knife",
		"shaker",
		"drinking_glass",
		"shot_glass",
		"coffee_cartridge",
		"coffeemaker",
		"coffeepot",
		"syrup_bottle",
		"foodtray",
		"restaurant_portal",
	)

/datum/techweb_node/food_proc
	id = TECHWEB_NODE_FOOD_PROC
	display_name = "食品加工"
	description = "纳米传讯出品的顶级厨房电器，旨在让船员吃得饱、过得好。"
	prereq_ids = list(TECHWEB_NODE_CAFETERIA_EQUIP)
	design_ids = list(
		"deepfryer",
		"oven",
		"stove",
		"range",
		"processor",
		"gibber",
		"monkey_recycler",
		"reagentgrinder",
		"microwave_engineering",
		"smartfridge",
		"dehydrator",
		"sheetifier",
		"fat_sucker",
		"dish_drive",
		"roastingstick",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SERVICE)

// Fishing root node
/datum/techweb_node/fishing_equip
	id = TECHWEB_NODE_FISHING_EQUIP
	starting_node = TRUE
	display_name = "钓鱼装备"
	description = "为空间站环境量身定制的基础钓具，完美适用于地外水上活动。"
	design_ids = list(
		"fishing_portal_generator",
		"fishing_rod",
		"fish_case",
		"aquarium_kit",
	)

/datum/techweb_node/fishing_equip_adv
	id = TECHWEB_NODE_FISHING_EQUIP_ADV
	display_name = "高级钓具"
	description = "钓鱼技术持续进步，为太空垂钓作业引入了尖端功能。只是别拿太空鲤鱼来试……"
	prereq_ids = list(TECHWEB_NODE_FISHING_EQUIP)
	design_ids = list(
		"fishing_rod_tech",
		"fishing_gloves",
		"mod_fishing",
		"stabilized_hook",
		"auto_reel",
		"fish_analyzer",
		"bluespace_fish_case",
		"bluespace_fish_tank_kit",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	required_experiments = list(/datum/experiment/scanning/fish)

/datum/techweb_node/marine_util
	id = TECHWEB_NODE_MARINE_UTIL
	display_name = "水产利用"
	description = "鱼看着是不错，但它们也能派上用场。"
	prereq_ids = list(TECHWEB_NODE_FISHING_EQUIP_ADV)
	design_ids = list(
		"bioelec_gen",
		"bluespace_reel",
		"fish_genegun",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	// only available if you've done the first fishing experiment (thus unlocking fishing tech), but not a strict requirement to get the tech
	discount_experiments = list(/datum/experiment/scanning/fish/second = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/fishing_anomalous
	id = TECHWEB_NODE_FISHING_ANOMALOUS
	display_name = "异常钓鱼"
	description = "对于真正爱冒险的钓客来说，这些实验性工具能以难以预测的方式让你的收获更丰富。"
	prereq_ids = list(TECHWEB_NODE_FISHING_EQUIP_ADV, TECHWEB_NODE_ANOMALY_RESEARCH)
	design_ids = list(
		"anomalous_fishing_hook",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
