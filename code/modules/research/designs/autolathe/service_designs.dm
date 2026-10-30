/datum/design/bucket
	name = "水桶"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/reagent_containers/cup/bucket
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/wet_floor_sign
	name = "小心地滑标志牌"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/clothing/suit/caution
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/watering_can
	name = "洒水壶"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/reagent_containers/cup/watering_can
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/mop
	name = "拖把"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/mop
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/broom
	name = "推扫帚"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/pushbroom
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/camera
	name = "相机"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/camera
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/camera_film
	name = "胶卷盒"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.1, /datum/material/glass = SMALL_MATERIAL_AMOUNT*0.1)
	build_path = /obj/item/camera_film
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/kitchen_knife
	name = "厨刀"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*6)
	build_path = /obj/item/knife/kitchen
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_knife
	name = "塑料刀"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/knife/plastic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/fork
	name = "叉子"
	build_type =  AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/kitchen/fork
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_fork
	name = "塑料叉"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/kitchen/fork/plastic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/spoon
	name = "勺子"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.2)
	build_path = /obj/item/kitchen/spoon
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_spoon
	name = "塑料勺"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT*1.2)
	build_path = /obj/item/kitchen/spoon/plastic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/tongs
	name = "食品夹"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/kitchen/tongs
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/tray
	name = "上菜托盘"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/storage/bag/tray
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plate
	name = "金属盘"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.5)
	build_path = /obj/item/plate/iron
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/cafeteria_tray
	name = "食堂托盘"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/storage/bag/tray/cafeteria
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/bowl
	name = "碗"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT)
	build_path = /obj/item/reagent_containers/cup/bowl
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/drinking_glass
	name = "玻璃杯"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT)
	build_path = /obj/item/reagent_containers/cup/glass/drinkingglass
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/shot_glass
	name = "小酒杯"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT)
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT)
	build_path = /obj/item/reagent_containers/cup/glass/drinkingglass/shotglass
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/shaker
	name = "摇壶"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT)
	build_path = /obj/item/reagent_containers/cup/glass/shaker
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/cultivator
	name = "松土铲"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/cultivator
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plant_analyzer
	name = "植物分析仪"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.3, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.2)
	build_path = /obj/item/plant_analyzer
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/shovel
	name = "铲子"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/shovel
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO

/datum/design/spade
	name = "小铲子"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/shovel/spade
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/hatchet
	name = "短柄斧"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5)
	build_path = /obj/item/hatchet
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/secateurs
	name = "修枝剪"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2)
	build_path = /obj/item/secateurs
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/radio_headset
	name = "无线电耳机"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.75)
	build_path = /obj/item/radio/headset
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/bounced_radio
	name = "空间站中继无线电"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.75, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.25)
	build_path = /obj/item/radio/off
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/handlabeler
	name = "手持标签机"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT*1.25)
	build_path = /obj/item/hand_labeler
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/pet_carrier
	name = "宠物笼"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*3.75, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/pet_carrier
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toygun
	name = "纸炮手枪"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/toy/gun
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/capbox
	name = "火药帽弹药盒"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/toy/ammo/gun
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toy_balloon
	name = "气球"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 0.6)
	build_path = /obj/item/toy/balloon
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toy_armblade
	name = "泡沫臂刃"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/toy/foamblade
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toy_katana
	name = "仿制武士刀"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/toy/katana
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_tree
	name = "塑料盆栽"
	build_type = AUTOLATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT*4)
	build_path = /obj/item/kirbyplants/random/fullysynthetic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/beads
	name = "塑料珠项链"
	build_type = AUTOLATHE
	materials = list(/datum/material/plastic =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/clothing/neck/beads
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_ring
	name = "易拉罐提环"
	build_type = AUTOLATHE
	materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT*1.2)
	build_path = /obj/item/storage/cans
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_box
	name = "塑料盒"
	build_type = AUTOLATHE
	materials = list(/datum/material/plastic =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/storage/box/plastic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/sticky_tape
	name = "黏性胶带"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/stack/medical/wrap/sticky_tape
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/chisel
	name = "凿子"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.75)
	build_path = /obj/item/chisel
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/paperroll
	name = "手持标签机纸卷"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.25)
	build_path = /obj/item/hand_labeler_refill
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toner
	name = "墨粉盒"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.1, /datum/material/glass = SMALL_MATERIAL_AMOUNT*0.1)
	build_path = /obj/item/toner
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toner/large
	name = "墨粉盒（大容量）"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/toner/large
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/fishing_rod_basic
	name = "钓鱼竿"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/fishing_rod
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/fishing_rod_material
	name = "材料钓鱼竿"
	build_type = AUTOLATHE
	materials = list(/datum/material_requirement/solid_material = SMALL_MATERIAL_AMOUNT * 4)
	build_path = /obj/item/fishing_rod/material
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)

/datum/design/fish_case
	name = "休眠鱼盒"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/storage/fish_case
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/aquarium_kit
	name = "DIY 水族箱建造套件"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/aquarium_kit
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/ticket_machine
	name = "叫号机框架"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*7, /datum/material/glass = SHEET_MATERIAL_AMOUNT*4)
	build_path = /obj/item/wallframe/ticket_machine
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/telescreen_bar
	name = "酒吧监控屏"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
	)
	build_path = /obj/item/wallframe/telescreen/bar
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/telescreen_entertainment
	name = "娱乐显示屏"
	build_type =  AUTOLATHE | PROTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
	)
	build_path = /obj/item/wallframe/telescreen/entertainment
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/telescreen_monastery
	name = "修道院监控屏"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	build_path = /obj/item/wallframe/telescreen/monastery
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/telescreen_monastery/New()
	var/has_monastery = CHECK_MAP_JOB_CHANGE(JOB_CHAPLAIN, "has_monastery")
	if(!has_monastery)
		qdel(src)
	return ..()

/datum/design/entertainment_radio
	name = "娱乐收音机"
	build_type =  AUTOLATHE | PROTOLATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.75,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*0.25
	)
	build_path = /obj/item/radio/entertainment/speakers/physical
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/barcode_scanner
	name = "条码扫描器"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/barcodescanner
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/rdd
	name = "快速装饰装置（RDD）"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 6,
	)
	//Some of the material is "lost" to make up for the fact that the rdd is loaded to the brim
	transfered_materials = list(
		/obj/item/construction/rdd/loaded = /obj/item/construction/rdd::custom_materials,
	)
	build_path = /obj/item/construction/rdd/loaded
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
