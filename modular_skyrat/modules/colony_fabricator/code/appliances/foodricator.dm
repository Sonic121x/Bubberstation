/obj/machinery/biogenerator/foodricator
	name = "有机口粮打印机"
	desc = "一种在边疆前哨站与殖民地常见的先进机器，能将有机植物物质转化为\
		各种食物或食材。在物资配送不稳定或干脆不存在的地区，它是厨师最好的朋友。\
		有些吃过它产出的食物的人抱怨味道不佳，不过他们大概不懂得，在殖民地里连一头牲畜都没有的情况下，\
		早餐还能吃上牛排和鸡蛋有多么难得。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/foodricator.dmi'
	circuit = null
	anchored = FALSE
	pass_flags = PASSTABLE
	efficiency = 1
	productivity = 2.5
	anchored_tabletop_offset = 6
	show_categories = list(
		RND_CATEGORY_AKHTER_FOODRICATOR_INGREDIENTS,
		RND_CATEGORY_AKHTER_FOODRICATOR_BAGS,
		RND_CATEGORY_AKHTER_FOODRICATOR_SNACKS,
		RND_CATEGORY_AKHTER_FOODRICATOR_UTENSILS,
		RND_CATEGORY_AKHTER_SEEDS,
	)
	/// What this repacks into
	var/repacked_type = /obj/item/flatpacked_machine/organics_ration_printer

/obj/machinery/biogenerator/foodricator/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	AddElement(/datum/element/repackable, repacked_type, 5 SECONDS)

/obj/machinery/biogenerator/foodricator/RefreshParts()
	. = ..()
	efficiency = 1
	productivity = 3

/obj/machinery/biogenerator/foodricator/default_deconstruction_crowbar()
	return

// Deployable item for cargo for the rations printer

/obj/item/flatpacked_machine/organics_ration_printer
	name = "有机口粮打印机零件包"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/foodricator.dmi'
	icon_state = "biogenerator_parts"
	type_to_deploy = /obj/machinery/biogenerator/foodricator
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
