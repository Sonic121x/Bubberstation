/obj/machinery/biogenerator/organic_printer
	name = "有机材料打印机"
	desc = "一种见于边疆前哨站与殖民地的先进机器，能把有机植物物质转化为\
		试剂以及制造机通常无法生产的实用物品。这类机器的具体设计因\
		地点和设计者而异，但这一台至少应该能为你提供\
		一些衣物、基本食物补给，以及你可能需要的其他东西。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/biogenerator.dmi'
	circuit = null
	anchored = FALSE
	efficiency = 1
	productivity = 2
	max_items = 35
	show_categories = list(
		RND_CATEGORY_AKHTER_CLOTHING,
		RND_CATEGORY_AKHTER_EQUIPMENT,
		RND_CATEGORY_AKHTER_RESOURCES,
	)

/obj/machinery/biogenerator/organic_printer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

/obj/machinery/biogenerator/organic_printer/RefreshParts()
	. = ..()
	efficiency = 1
	productivity = 2
	max_items = 35

/obj/machinery/biogenerator/organic_printer/default_deconstruction_crowbar()
	return

// Deployable item for cargo for the organics printer
/obj/item/flatpacked_machine/organics_printer
	name = "有机材料打印机零件套件"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/biogenerator.dmi'
	icon_state = "biogenerator_parts"
	type_to_deploy = /obj/machinery/biogenerator/organic_printer

/obj/item/flatpacked_machine/organics_printer/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)
