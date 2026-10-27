/obj/machinery/ore_silo/colony_lathe
	name = "殖民矿石筒仓"
	desc = "一体化的材料管理方案。通过分配系统网络\
		连接各类消耗资源的机器。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/ore_silo.dmi'
	circuit = null
	/// What this packs into
	var/packed_type = /obj/item/flatpacked_machine/ore_silo

/obj/machinery/ore_silo/colony_lathe/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, packed_type, 10 SECONDS)

/obj/machinery/ore_silo/colony_lathe/silo_log(obj/machinery/machinery_in_question, action, amount, noun, list/mats)
	. = ..()
	playsound(src, 'sound/machines/beep/beep.ogg', 30, TRUE)

/obj/machinery/ore_silo/colony_lathe/default_deconstruction_crowbar()
	return

// Item for deploying ore silos
/obj/item/flatpacked_machine/ore_silo
	name = "扁平包装矿石筒仓"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/ore_silo.dmi'
	icon_state = "ore_silo"
	type_to_deploy = /obj/machinery/ore_silo/colony_lathe
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
	)
