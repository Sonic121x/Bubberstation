//Disks that let autolathes print upgraded parts!
/obj/item/disk/design_disk/advanced_parts
	name = "高级部件自动车床设计磁盘"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5)

/obj/item/disk/design_disk/advanced_parts/Initialize(mapload)
	. = ..()
	blueprints += new /datum/design/adv_capacitor
	blueprints += new /datum/design/adv_scanning
	blueprints += new /datum/design/nano_servo
	blueprints += new /datum/design/high_micro_laser
	blueprints += new /datum/design/adv_matter_bin
	blueprints += new /datum/design/super_cell
	blueprints += new /datum/design/super_battery
	blueprints += new /datum/design/water_recycler
	blueprints += new /datum/design/card_reader

/datum/design/adv_capacitor
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/adv_scanning
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/nano_servo
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/high_micro_laser
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/adv_matter_bin
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/super_cell
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE | MECHFAB
/datum/design/water_recycler
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/card_reader
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE

/obj/item/disk/design_disk/high_tech_parts
	name = "高科技部件自动车床设计磁盘"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/gold = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT*1.5)

/obj/item/disk/design_disk/high_tech_parts/Initialize(mapload)
	. = ..()
	blueprints += new /datum/design/super_capacitor
	blueprints += new /datum/design/phasic_scanning
	blueprints += new /datum/design/pico_servo
	blueprints += new /datum/design/ultra_micro_laser
	blueprints += new /datum/design/super_matter_bin
	blueprints += new /datum/design/hyper_cell
	blueprints += new /datum/design/hyper_battery

/datum/design/super_capacitor
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/phasic_scanning
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/pico_servo
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/ultra_micro_laser
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/super_matter_bin
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
/datum/design/hyper_cell
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE | MECHFAB
/datum/design/hyper_battery
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE | MECHFAB

/datum/design/adv_part_disk
	name = "高级部件设计磁盘"
	desc = "一张用于自动车床的磁盘，内含高级部件的设计图。"
	id = "adv_part_disk"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5)
	build_path = /obj/item/disk/design_disk/advanced_parts
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_2
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/high_tech_part_disk
	name = "高科技部件设计磁盘"
	desc = "一张用于自动车床的磁盘，内含高科技部件的设计图。"
	id = "high_tech_part_disk"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/gold = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT*1.5)
	build_path = /obj/item/disk/design_disk/high_tech_parts
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_2 + RND_SUBCATEGORY_STOCK_PARTS_3
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/parts_upg/New()
	design_ids += list(
		"adv_part_disk",
	)
	return ..()

/datum/techweb_node/parts_adv/New()
	design_ids += list(
		"high_tech_part_disk",
	)
	return ..()

