///// Bubber added Syndicate Tech /////

///// First we enstate a techweb so we can add the node. /////
/datum/techweb/interdyne
	id = "INTERDYNE"
	organization = "英特戴恩制药公司"
	should_generate_points = TRUE

/datum/techweb/interdyne/New()
	. = ..()
	research_node_id("oldstation_surgery", TRUE, TRUE, FALSE)
	research_node_id(TECHWEB_NODE_INTERDYNE, TRUE, TRUE, FALSE)

//techweb nodes
/datum/techweb_node/interdyne
	id = TECHWEB_NODE_INTERDYNE
	display_name = "辛迪加科技"
	description = "辛迪加使用的工具。"
	required_items_to_unlock = list(
		/obj/item/circuitboard/machine/syndiepad,
		/obj/item/circuitboard/computer/cargo/express/interdyne,
		/obj/item/circuitboard/computer/syndiepad,
		/obj/item/circuitboard/machine/powerator/interdyne

	)
	design_ids = list(
		"cargoconsole_syndicate",
		"bountypad_syndicate",
		"bountyconsole_syndicate",
		"powerator_syndicate",
		"exofab_syndicate",
		"syndicate_firing_pin",
		"syndicate_headset",
		"cybersun_encryption"

	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE

/datum/techweb_node/encryption
	id = TECHWEB_NODE_INTERDYNE_ENCRYPTION
	display_name = "高级辛迪加加密"
	description = "在行动通讯被破解时提供应急用的英特戴恩加密钥匙。"
	required_items_to_unlock = list(
		/obj/item/encryptionkey/headset_syndicate/interdyne
	)
	design_ids = list(
		"interdyne_encryption",
	)
	prereq_ids = list(TECHWEB_NODE_INTERDYNE)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE

//Syndicate Machinery Boards

/obj/machinery/rnd/production/protolathe/interdyne
	name = "英特戴恩牌原型制造机"
	desc = "把原材料转化为有用的物品。经过翻新与升级，摆脱了原本有限的能力。"
	circuit = /obj/item/circuitboard/machine/protolathe/interdyne
	stripe_color = "#d40909"

/obj/item/circuitboard/machine/protolathe/interdyne
	name = "英特戴恩牌原型制造机"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/rnd/production/protolathe/interdyne

//Adding the actual physical Server

/obj/item/circuitboard/machine/rdserver/interdyne
	name = "英特戴恩制药研发服务器"
	build_path = /obj/machinery/rnd/server/interdyne

/obj/machinery/rnd/server/interdyne
	name = "\improper 英特戴恩制药研发服务器"
	circuit = /obj/item/circuitboard/machine/rdserver/interdyne
	req_access = list(ACCESS_RESEARCH)

/obj/machinery/rnd/server/interdyne/Initialize(mapload)
	var/datum/techweb/interdyne_techweb = locate(/datum/techweb/interdyne) in SSresearch.techwebs
	stored_research = interdyne_techweb
	return ..()

/obj/machinery/rnd/server/interdyne/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item && istype(held_item, /obj/item/research_notes))
		context[SCREENTIP_CONTEXT_LMB] = "生成研究点数"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/rnd/server/interdyne/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !isobserver(user))
		return
	. += span_notice("插入[EXAMINE_HINT("研究笔记")]以生成点数。")

/obj/machinery/rnd/server/interdyne/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/research_notes) && stored_research)
		var/obj/item/research_notes/research_notes = attacking_item
		stored_research.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = research_notes.value))
		playsound(src, 'sound/machines/copier.ogg', 50, TRUE)
		qdel(research_notes)
		return
	return ..()
