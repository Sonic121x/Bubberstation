/obj/machinery/rnd/production/protolathe
	name = "原型制造机"
	desc = "将原材料加工成有用物品。"
	icon_state = "protolathe"
	base_icon_state = "protolathe"
	circuit = /obj/item/circuitboard/machine/protolathe
	production_animation = "protolathe_n"
	allowed_buildtypes = PROTOLATHE

/obj/machinery/rnd/production/protolathe/on_deconstruction(disassembled)
	log_game("类型为 [type] 的原型制造机由 [key_name(usr)] 在 [get_area_name(src, TRUE)] [disassembled ? "拆解" : "拆除"]")

	return ..()

/obj/machinery/rnd/production/protolathe/Initialize(mapload)
	if(!mapload)
		log_game("类型为 [type] 的原型制造机由 [key_name(usr)] 在 [get_area_name(src, TRUE)] 建造")

	return ..()

/// Special subtype protolathe for offstation use. Has a more limited available design selection.
/obj/machinery/rnd/production/protolathe/offstation
	name = "古老原型制造机"
	desc = "将原材料加工成有用物品。其古老的构造可能限制它打印所有已知技术的能力。"
	circuit = /obj/item/circuitboard/machine/protolathe/offstation
	allowed_buildtypes = AWAY_LATHE
