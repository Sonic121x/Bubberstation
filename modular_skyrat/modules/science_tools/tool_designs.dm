/datum/design/jawsoflife/science
	name = "混合剪钳"
	desc = "救生钳的衍生产品，缺少强行开门的动力。"
	build_path = /obj/item/crowbar/power/science
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/handdrill/science
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/rcd_loaded/robotics_rcd
	name = "机器人维修快速建造装置"
	desc = "经过改装的快速建造装置，比普通纳米传讯型号的容量更小、建造选项更少，也失去了拆解能力，换来了更便捷的合成人维修功能。可用金属、玻璃或塑钢补充材料。"
	build_type = PROTOLATHE | AWAY_LATHE
	transfered_materials = list(
		/obj/item/construction/rcd/robotics_rcd = /obj/item/construction/rcd/robotics_rcd::custom_materials, //The RCD has less materials than what's used, as some is converted to charge/matter
	)
	build_path = /obj/item/construction/rcd/robotics_rcd
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/handdrill/science/New()
	name = ("科研型" + name)
	desc += "，采用科研部门涂装。"

	return ..()
