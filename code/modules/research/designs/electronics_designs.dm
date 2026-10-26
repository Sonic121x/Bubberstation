
///////////////////////////////////
/////Non-Board Computer Stuff//////
///////////////////////////////////

/datum/design/intellicard
	name = "智能卡 AI 运输系统"
	desc = "可用于建造一张智能卡。"
	id = "intellicard"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/aicard
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/paicard
	name = "个人人工智能卡"
	desc = "可用于建造一张个人 AI 卡。"
	id = "paicard"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/iron =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/pai_card
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE

/datum/design/ai_cam_upgrade
	name = "AI 监控软件更新"
	desc = "一个软件包，可让人工智能通过读唇从摄像头中“听到”声音。"
	id = "ai_cam_upgrade"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/ai_module/upgrade/surveillance
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_UPGRADES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/ai_power_transfer
	name = "AI 电力传输更新"
	desc = "一个升级包，可让 AI 远程为区域电力控制器充电。"
	id = "ai_power_upgrade"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	build_path = /obj/item/ai_module/upgrade/power_transfer
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_UPGRADES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

////////////////////////////////////////
//////////Disk Construction Disks///////
////////////////////////////////////////
/datum/design/tech_disk
	name = "技术数据存储磁盘"
	desc = "制造用于存储技术数据的额外磁盘。"
	id = "tech_disk"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/disk/tech_disk
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/manipulator_task_disk
	name = "机械臂任务磁盘"
	desc = "制造用于存储机械臂任务的额外磁盘。"
	id = "manipulator_task_disk"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/disk/manipulator
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
