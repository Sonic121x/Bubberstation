///// First we enstate a techweb so we can add the node. /////
/datum/techweb/tarkon
	id = "TARKON"
	organization = "塔肯工业"
	should_generate_points = TRUE

/datum/techweb/tarkon/New()
	. = ..()
	research_node(/datum/techweb_node/oldstation_surgery, TRUE, TRUE, FALSE)
	research_node(/datum/techweb_node/tarkon, TRUE, TRUE, FALSE)
	research_node(/datum/techweb_node/tarkon_borgs, TRUE, TRUE, FALSE)
	research_node(/datum/techweb_node/tarkonturret, TRUE, TRUE, FALSE) // not ideal, but will have to do for now

/datum/techweb_node/tarkon
	display_name = "塔肯工业技术"
	description = "塔肯工业使用的工具。"
	required_items_to_unlock = list(
		/obj/item/mod/construction/plating/tarkon,
		/obj/item/construction/rcd/arcd/tarkon,
		/obj/item/gun/energy/recharge/resonant_system,
	)
	unlocked_designs = list(
		/datum/design/mod_plating/tarkon,
		/datum/design/arcs,
		/datum/design/tarkonrcd,
		/datum/design/tarkonpowerator,
		/datum/design/tarkonexpressconsole,
		/datum/design/bountypad,
		/datum/design/bountypadconsole,
		/datum/design/tarkonhackc,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	node_flags = TECHWEB_NODE_WIKI | TECHWEB_NODE_HIDDEN

/datum/techweb_node/tarkonturret
	display_name = "塔肯工业防御技术"
	description = "塔肯工业黑锈打捞部门的防御设计。"
	prerequisite_nodes = list(/datum/techweb_node/tarkon, /datum/techweb_node/basic_arms, /datum/techweb_node/ai)
	required_items_to_unlock = list(
		/obj/item/mod/construction/plating/tarkon,
		/obj/item/construction/rcd/arcd/tarkon,
		/obj/item/gun/energy/recharge/resonant_system,
	)
	unlocked_designs = list(
		/datum/design/hoplite_assembly,
		/datum/design/cerberus_assembly,
		/datum/design/target_designator,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	node_flags = TECHWEB_NODE_WIKI | TECHWEB_NODE_HIDDEN

/datum/techweb_node/tarkon_borgs //Nor this, suprisingly
	display_name = "塔肯工业机器人技术"
	description = "塔肯工业实验性半机械人原型，禁止公众使用。"
	prerequisite_nodes = list(/datum/techweb_node/tarkon, /datum/techweb_node/borg_engi, /datum/techweb_node/ai, /datum/techweb_node/borg_utility) // Should hold it back long enough
	required_items_to_unlock = list(
		/obj/item/mod/construction/plating/tarkon,
		/obj/item/construction/rcd/arcd/tarkon,
		/obj/item/gun/energy/recharge/resonant_system,
	)
	unlocked_designs = list(
		/datum/design/borg_upgrade_tarkon_medical,
		/datum/design/borg_upgrade_tarkon_engineering,
		/datum/design/borg_upgrade_tarkon_security,
		/datum/design/borg_upgrade_tarkon_cargo,
		/datum/design/borg_upgrade_tarkon_research,
		/datum/design/borg_upgrade_tarkon_service,
		/datum/design/borg_upgrade_tarkon_janitor,
		/datum/design/borg_upgrade_tarkon_main
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS) // They will likely have all other borg tech by now, no need to gate it further
	node_flags = TECHWEB_NODE_WIKI | TECHWEB_NODE_HIDDEN

/datum/design/hoplite_assembly
	name = "重装步兵炮塔组件"
	desc = "用于基础设施防御的可部署炮塔套件，可组装成“重装步兵”型号。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
		)
	build_path = /obj/item/turret_assembly/hoplite
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_WEAPONS_KITS
	)

/datum/design/cerberus_assembly
	name = "地狱三头犬炮塔组件"
	desc = "用于基础设施防御的可部署炮塔套件，可组装成“地狱三头犬”型号。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 20,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/turret_assembly/cerberus
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_WEAPONS_KITS,
	)

/datum/design/target_designator
	name = "炮塔目标指示器"
	desc = "用于控制弹匣供弹炮塔的基础目标指示器。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/target_designator
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_WEAPONS_KITS,
	)

/datum/design/mod_plating/tarkon
	name = "MOD塔肯装甲板"
	build_path = /obj/item/mod/construction/plating/tarkon
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	research_icon_state = "tarkon-plating"
	research_icon = 'modular_skyrat/modules/tarkon/icons/obj/mod_construct.dmi'

/datum/design/arcs
	name = "A.R.C.S共振器"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/gun/energy/recharge/resonant_system
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/tarkonrcd
	name = "塔肯快速建造装置"
	desc = "塔肯工业制造的快速建造装置，能够进行远程建造。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 3
		)
	transfered_materials = list(
		/obj/item/construction/rcd/arcd/tarkon/loaded = /obj/item/construction/rcd/arcd/tarkon::custom_materials
	)
	build_path = /obj/item/construction/rcd/arcd/tarkon/loaded
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/tarkonhackc
	name = "塔肯Hack-C信号器"
	desc = "向Hack-C无人机发送信号、让其维修专用机器的小型装置。"
	build_path = /obj/item/hackc
	category = list(
		RND_CATEGORY_TOOLS
	)
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

///// Now we make the physical server /////

/obj/item/circuitboard/machine/rdserver/tarkon
	name = "塔肯工业研发服务器"
	build_path = /obj/machinery/rnd/server/tarkon

/obj/machinery/rnd/server/tarkon
	name = "\improper 塔肯工业研发服务器"
	circuit = /obj/item/circuitboard/machine/rdserver/tarkon
	req_access = list(ACCESS_AWAY_SCIENCE)

/obj/machinery/rnd/server/tarkon/Initialize(mapload)
	var/datum/techweb/tarkon_techweb = locate(/datum/techweb/tarkon) in SSresearch.techwebs
	stored_research = tarkon_techweb
	return ..()

/obj/machinery/rnd/server/tarkon/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item && istype(held_item, /obj/item/research_notes))
		context[SCREENTIP_CONTEXT_LMB] = "生成研究点数"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/rnd/server/tarkon/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !isobserver(user))
		return
	. += span_notice("插入[EXAMINE_HINT("研究笔记")]以生成点数。")

/obj/machinery/rnd/server/tarkon/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/research_notes) && stored_research)
		var/obj/item/research_notes/research_notes = attacking_item
		stored_research.adjust_multiple_points(list(TECHWEB_POINT_TYPE_GENERIC = research_notes.value))
		playsound(src, 'sound/machines/copier.ogg', 50, TRUE)
		qdel(research_notes)
		return
	return ..()

/obj/machinery/rnd/production/protolathe/tarkon
	name = "塔肯工业原型制造机"
	desc = "将原材料转化为实用物品的机器，经过翻新升级，突破了原先有限的能力。"
	circuit = /obj/item/circuitboard/machine/protolathe/tarkon
	stripe_color = "#350f04"

/obj/item/circuitboard/machine/protolathe/tarkon
	name = "塔肯工业原型制造机"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/rnd/production/protolathe/tarkon
