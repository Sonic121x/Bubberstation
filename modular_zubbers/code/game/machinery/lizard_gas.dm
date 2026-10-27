/// Unique machines intended for Lizard Gas, to provide them with cheap and easy to obtain items that normally they wouldn't be able to obtain,
/// this includes first aid equipment, medicines, certain food items, clothes, and some materials. These essentially act as 'upgraded' versions
/// of the unique biogens that can be ordered. Hopefully gives Lizard Gas more reason to be played and most importantly - enjoyed.
/// Honestly, could be used for other ghost roles to make them a bit more unique or to cover a certain weakness, as long as it makes sense.

/// Colonial Marine Resequencer - essentially combines the organic materials printer and clothing options from the colonial supply core.
/obj/item/circuitboard/machine/biogenerator/lizard_gas_colonial
	name = "殖民陆战队物质重构机"
	build_path = /obj/machinery/biogenerator/lizard_gas_colonial
	icon = 'modular_zubbers/icons/obj/machines/resequencer.dmi'
	icon_state = "circuitboard"
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/machinery/biogenerator/lizard_gas_colonial
	name = "殖民陆战队物质重构机"
	desc = "34 型“殖民补给核心”的衍生型号，俗称“生成箱/CSC”。\
		生成箱本质上是一种物质重构机，属于高度专用的生物制造机，能利用通常来自\
		大规模农作物或废料的有机化合物进行物质转化。这台经过了大幅改装，专门制造服装、配饰\
		以及各种材料，以弥补配送不稳定的问题，代价是无法再制造\
		该设备原本赖以成名的其他物品。"
	icon = 'modular_zubbers/icons/obj/machines/resequencer.dmi'
	circuit = /obj/item/circuitboard/machine/biogenerator/lizard_gas_colonial
	efficiency = 1
	productivity = 1
	max_items = 35
	show_categories = list(
		RND_CATEGORY_CMR_APPAREL,
		RND_CATEGORY_CMR_EQUIPMENT,
		RND_CATEGORY_CMR_MATERIALS,
	)

/// DeForest Brand Bio-Regenerator - just a better version of the Wall Med-Station, and not installed on a wall.
/obj/item/circuitboard/machine/biogenerator/lizard_gas_medvendor
	name = "德福雷斯特牌生物再生机"
	build_path = /obj/machinery/biogenerator/lizard_gas_medvendor
	icon = 'modular_zubbers/icons/obj/machines/bioregenerator.dmi'
	icon_state = "circuitboard"
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/machinery/biogenerator/lizard_gas_medvendor
	name = "德福雷斯特牌生物再生机"
	desc = "边疆前哨和殖民地常见的先进机器，能够将植物有机质转化为\
		各种急救医疗物资及注射器。这是限量销售的较先进型号之一，\
		专为更加严酷危险的边疆环境设计。"
	icon = 'modular_zubbers/icons/obj/machines/bioregenerator.dmi'
	circuit = /obj/item/circuitboard/machine/biogenerator/lizard_gas_medvendor
	efficiency = 1
	productivity = 1
	max_items = 35
	show_categories = list(
		RND_CATEGORY_DFBBR_MEDICAL,
		RND_CATEGORY_DFBBR_MEDICINE,
		RND_CATEGORY_DFBBR_INJECTORS,
		RND_CATEGORY_DEFOREST_BLOOD,
	)

/// SmartFridge Organic Fabricator - Rations printer, but actually more useful than a biogen.
/obj/item/circuitboard/machine/biogenerator/lizard_gas_smartfridge
	name = "智能冰箱有机物制造机"
	build_path = /obj/machinery/biogenerator/lizard_gas_smartfridge
	icon = 'modular_zubbers/icons/obj/machines/smartfridge_fab.dmi'
	icon_state = "circuitboard"
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/machinery/biogenerator/lizard_gas_smartfridge
	name = "智能冰箱有机物制造机"
	desc = "边疆前哨和殖民地常见的先进机器，能够将植物有机质转化为\
		各种食品或食材。在配送不稳定甚至完全没有配送的地方，它是厨师最好的朋友。\
		这台型号经过进一步定制，提供更丰富的食物品种，并扩大了\
		物资和即烹食材的储备，以便随时快速制作大量食物。"
	icon = 'modular_zubbers/icons/obj/machines/smartfridge_fab.dmi'
	circuit = /obj/item/circuitboard/machine/biogenerator/lizard_gas_smartfridge
	efficiency = 1
	productivity = 1
	max_items = 35
	show_categories = list(
		RND_CATEGORY_SFOF_INGREDIENT,
		RND_CATEGORY_SFOF_CONDIMENTS,
		RND_CATEGORY_SFOF_CONSUMABLES,
		RND_CATEGORY_SFOF_LUXURIES,
		RND_CATEGORY_AKHTER_FOODRICATOR_UTENSILS,
	)

// Telescreen, because you can't set custom networks without creating linter errors.
/obj/machinery/computer/security/telescreen/lizgas
	name = "蜥蜴加油站监控屏"
	desc = "连接加油站摄像网络的监控屏幕。"
	network = list("lizardgas")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/security/telescreen/lizgas, 32)
