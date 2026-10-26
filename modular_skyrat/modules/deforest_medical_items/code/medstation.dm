/obj/machinery/biogenerator/medstation
	name = "壁挂医疗站"
	desc = "一种在前沿前哨站和殖民地常见的先进机器，能把有机植物物质转换成 \
		各种应急医疗物资和注射器。几乎任何前沿设施的医疗区都能 \
		找到一台。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/medstation.dmi'
	circuit = null
	anchored = TRUE
	density = FALSE
	efficiency = 1
	productivity = 1
	show_categories = list(
		RND_CATEGORY_DEFOREST_MEDICAL,
		RND_CATEGORY_DEFOREST_BLOOD,
	)
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/wallframe/frontier_medstation

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/biogenerator/medstation, 29)

/obj/machinery/biogenerator/medstation/RefreshParts()
	. = ..()
	efficiency = 1
	productivity = 1

/obj/machinery/biogenerator/medstation/default_unfasten_wrench(mob/user, obj/item/wrench/tool, time)
	user.balloon_alert(user, "正在拆卸……")
	tool.play_tool_sound(src)
	if(tool.use_tool(src, user, 1 SECONDS))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct(TRUE)
		return

/obj/machinery/biogenerator/medstation/on_deconstruction(disassembled)
	if(disassembled)
		new repacked_type(drop_location())

/obj/machinery/biogenerator/medstation/default_deconstruction_crowbar()
	return

// Deployable item for cargo for the medstation

/obj/item/wallframe/frontier_medstation
	name = "未安装的壁挂医疗站"
	desc = "采用生物生成器打印医疗物资的创新技术，但可以整齐地安装在墙上，不挡路。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/medstation.dmi'
	icon_state = "biogenerator_parts"
	w_class = WEIGHT_CLASS_NORMAL
	result_path = /obj/machinery/biogenerator/medstation
	pixel_shift = 29
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
	)
