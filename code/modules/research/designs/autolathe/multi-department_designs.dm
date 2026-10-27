/datum/design/flashlight
	name = "手电筒"
	id = "flashlight"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.2)
	build_path = /obj/item/flashlight
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MISC,
	)

/datum/design/flare
	name = "照明弹"
	id = "flare"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/flashlight/flare
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MISC,
	)

/datum/design/crowbar
	name = "口袋撬棍"
	id = "crowbar"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/crowbar
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/multitool
	name = "多功能工具"
	id = "multitool"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron =SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT * 0.2
		)
	build_path = /obj/item/multitool
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE


/datum/design/tscanner
	name = "T射线扫描仪"
	id = "tscanner"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)
	build_path = /obj/item/t_scanner
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/rwd
	name = "快速布线装置"
	id = "rwd"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5)
	//The cable coils don't count toward the total mats of the item to avoid a possible way to generate more iron and glass.
	transfered_materials = list(
		/obj/item/rwd/loaded = /obj/item/rwd::custom_materials,
	)
	build_path = /obj/item/rwd/loaded
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE
	fixed_cost_efficiency = TRUE // The cable coils can be removed and recycled to generate more material than that spent printing it at higher stock part tiers.

/datum/design/analyzer
	name = "气体分析仪"
	id = "analyzer"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.3, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.2)
	build_path = /obj/item/analyzer
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ATMOSPHERICS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/weldingtool
	name = "焊接工具"
	id = "welding_tool"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.7, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.2)
	build_path = /obj/item/weldingtool/empty
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mini_weldingtool
	name = "应急焊接工具"
	id = "mini_welding_tool"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.3, /datum/material/glass = SMALL_MATERIAL_AMOUNT*0.1)
	build_path = /obj/item/weldingtool/mini/empty
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)

/datum/design/screwdriver
	name = "螺丝刀"
	id = "screwdriver"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.75)
	build_path = /obj/item/screwdriver
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/wirecutters
	name = "剪线钳"
	id = "wirecutters"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.8)
	build_path = /obj/item/wirecutters
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/wrench
	name = "扳手"
	id = "wrench"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5)
	build_path = /obj/item/wrench
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/plunger
	name = "搋子"
	id = "plunger"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5)
	build_path = /obj/item/plunger
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_PLUMBING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE

/datum/design/welding_helmet
	name = "焊接头盔"
	id = "welding_helmet"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT*1.75, /datum/material/glass = SMALL_MATERIAL_AMOUNT*4)
	build_path = /obj/item/clothing/head/utility/welding
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/cable_coil
	name = "电缆（x5）"
	id = "cable_coil"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/stack/cable_coil/five
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/toolbox
	name = "工具箱"
	id = "tool_box"
	build_type = AUTOLATHE
	materials = list(/datum/material_requirement/solid_material = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/storage/toolbox
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)

/datum/design/toolbox/create_result(atom/drop_loc, list/custom_materials, amount)
	var/obj/item/storage/toolbox/toolbox = ..()
	if (length(custom_materials) && !istype(custom_materials[1], /datum/material/iron))
		return toolbox

	// Default and custom material iron toolboxes get a random color assigned rather than being greyscale'd
	var/toolbox_color = pick("blue", "yellow", "red")
	toolbox.icon_state = toolbox_color
	toolbox.inhand_icon_state = "toolbox_[toolbox_color]"
	toolbox.material_flags &= ~MATERIAL_COLOR
	toolbox.remove_atom_colour(FIXED_COLOUR_PRIORITY)
	return toolbox

/datum/design/emergency_oxygen
	name = "应急氧气罐"
	id = "emergency_oxygen"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/tank/internals/emergency_oxygen/empty
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
	)

/datum/design/emergency_oxygen_engi
	name = "扩容应急氧气罐"
	id = "emergency_oxygen_engi"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*7.5)
	build_path = /obj/item/tank/internals/emergency_oxygen/engi/empty
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/plasmaman_tank_belt
	name = "等离子人腰带气罐"
	id = "plasmaman_tank_belt"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*8)
	build_path = /obj/item/tank/internals/plasmaman/belt/empty
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
	)

/datum/design/generic_gas_tank
	name = "气罐"
	id = "generic_tank"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/tank/internals/generic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/boxcutter
	name = "美工刀"
	id = "boxcutter"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/plastic =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/boxcutter
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_CARGO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/foilhat
	name = "锡箔帽"
	id = "tinfoil_hat"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2.5)
	build_path = /obj/item/clothing/head/costume/foilhat
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_JOKE,
	)

/datum/design/beaker
	name = "烧杯"
	id = "beaker"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY,
	)
	build_path = /obj/item/reagent_containers/cup/beaker
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/large_beaker
	name = "大烧杯"
	id = "large_beaker"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT*2.5)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY,
	)
	build_path = /obj/item/reagent_containers/cup/beaker/large
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/jerrycan
	name = "塑料油桶"
	id = "jerrycan"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SHEET_MATERIAL_AMOUNT * 2)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY,
	)
	build_path = /obj/item/reagent_containers/cup/jerrycan
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/igniter
	name = "点火器"
	id = "igniter"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/assembly/igniter
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ASSEMBLIES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/condenser
	name = "冷凝器"
	id = "condenser"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*2.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/assembly/igniter/condenser
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ASSEMBLIES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/signaler
	name = "远程信号装置"
	id = "signaler"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*4, /datum/material/glass = SMALL_MATERIAL_AMOUNT*1.2)
	build_path = /obj/item/assembly/signaler
	category = list(
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ASSEMBLIES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/infrared_emitter
	name = "红外发射器"
	id = "infrared_emitter"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/assembly/infra
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ASSEMBLIES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/health_sensor
	name = "健康传感器"
	id = "health_sensor"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*8, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/assembly/health
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ASSEMBLIES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/timer
	name = "定时器"
	id = "timer"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/assembly/timer
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ASSEMBLIES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/voice_analyzer
	name = "声音分析仪"
	id = "voice_analyzer"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/assembly/voice
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ASSEMBLIES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/light_tube
	name = "灯管"
	id = "light_tube"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/light/tube
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_LIGHTING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/light_bulb
	name = "灯泡"
	id = "light_bulb"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/light/bulb
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_LIGHTING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/prox_sensor
	name = "接近传感器"
	id = "prox_sensor"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*8, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/assembly/prox_sensor
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ASSEMBLIES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/cleaver
	name = "屠夫砍刀"
	id = "cleaver"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*9)
	build_path = /obj/item/knife/butcher
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)

/datum/design/spraycan
	name = "喷漆罐"
	id = "spraycan"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/toy/crayon/spraycan
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/desttagger
	name = "目的地标签器"
	id = "desttagger"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*2.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT*1.5)
	build_path = /obj/item/dest_tagger
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_CARGO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE

/datum/design/ducts
	name = "流体管道"
	id = "fluid_ducts"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/stack/ducts
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_PLUMBING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE

/datum/design/digital_clock_frame
	name = "数字时钟框架"
	id = "digital_clock_frame"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*7, /datum/material/glass = SHEET_MATERIAL_AMOUNT*4)
	build_path = /obj/item/wallframe/digital_clock
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SERVICE

/datum/design/razor
	name = "电动剃须刀"
	id = "razor"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.75)
	build_path = /obj/item/razor
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SECURITY

/datum/design/package_wrap
	name = "打包纸"
	id = "packagewrap"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/stack/package_wrap
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO

/datum/design/holodisk
	name = "全息录像盘"
	id = "holodisk"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/disk/holodisk
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ASSEMBLIES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/suit_sensor
	name = "服装传感器"
	id = "suit_sensor"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/suit_sensor
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ASSEMBLIES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SECURITY

/datum/design/conveyor_belt
	name = "传送带组件"
	id = "conveyor_belt"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/stack/conveyor
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MACHINERY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/conveyor_switch
	name = "传送带开关组件"
	id = "conveyor_switch"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*4.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT*2)
	build_path = /obj/item/conveyor_switch_construct
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MACHINERY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/laptop
	name = "笔记本框架"
	id = "laptop"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	transfered_materials = list(
		/obj/item/modular_computer/laptop/buildable = /obj/item/modular_computer/laptop::custom_materials,
		/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell::custom_materials,
	)
	build_path = /obj/item/modular_computer/laptop/buildable
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_MODULAR_COMPUTERS + RND_SUBCATEGORY_MODULAR_COMPUTERS_FRAMES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/universal_scanner
	name = "通用扫描仪"
	desc = "一台用于对照纳米传讯出口数据库检查物品、贴上价签，或为自定义自动售货机准备商品的设备。"
	id = "universal_scanner"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/universal_scanner
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_CARGO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/paper_biscuit
	name = "饼干卡"
	desc = "一种可以把文件密封在里面的纸质饼干卡。密封之后，唯一打开的方式就是掰开它；掰开不可逆，并会让它永久敞开。它其实并不是饼干。"
	id = "biscuit"
	build_type = AUTOLATHE
	materials = list(/datum/material/plastic =SMALL_MATERIAL_AMOUNT*0.2)
	build_path = /obj/item/folder/biscuit/unsealed
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO

/datum/design/paper_biscuit_confidential
	name = "机密饼干卡"
	desc = "一种可以把文件密封在里面的纸质饼干卡，这一款用于存放纳米传讯的机密文件。密封之后，唯一打开的方式就是掰开它；掰开不可逆，并会让它永久敞开。它其实并不是饼干。"
	id = "confidential_biscuit"
	build_type = AUTOLATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT*0.3)
	build_path = /obj/item/folder/biscuit/unsealed/confidential
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO

