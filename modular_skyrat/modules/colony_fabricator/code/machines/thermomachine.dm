/obj/machinery/atmospherics/components/unary/thermomachine/deployable
	name = "大气温度调节器"
	desc = "一种温和得多的热机变体，常见于空间站级温度控制设备。 \
		它的温度上下限受到极大限制，但热容量高于标准水平， \
		而且还有个好处：用完之后可以重新打包收起。"
	circuit = null
	icon = 'icons/map_icons/objects.dmi'
	icon_state = "/obj/machinery/atmospherics/components/unary/thermomachine/deployable"
	post_init_icon_state = "thermo_base"
	greyscale_config = /datum/greyscale_config/thermomachine/deployable
	min_temperature = T0C
	max_temperature = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD + 50
	heat_capacity = 10000
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/thermomachine
	/// Soundloop for while the thermomachine is turned on
	var/datum/looping_sound/conditioner_running/soundloop

/obj/machinery/atmospherics/components/unary/thermomachine/deployable/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)
	AddElement(/datum/element/repackable, repacked_type, 2 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	flick("thermo_deploy", src)

	// Makes for certain that we are visually facing the correct way
	setDir(dir)
	update_appearance()

/obj/machinery/atmospherics/components/unary/thermomachine/deployable/RefreshParts()
	. = ..()
	heat_capacity = 10000
	min_temperature = T0C
	max_temperature = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD + 50

/obj/machinery/atmospherics/components/unary/thermomachine/deployable/default_deconstruction_crowbar()
	return

/obj/machinery/atmospherics/components/unary/thermomachine/deployable/process_atmos()
	if(on && !soundloop.loop_started)
		soundloop.start()
	else if(soundloop.loop_started)
		soundloop.stop()
	. = ..()

// Item for creating the regulator and carrying it about

/obj/item/flatpacked_machine/thermomachine
	name = "扁平包装大气温度调节器"
	icon_state = "thermomachine_packed"
	type_to_deploy = /obj/machinery/atmospherics/components/unary/thermomachine/deployable
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)

// This prevents some weird visual bugs with the inlet
/obj/item/flatpacked_machine/thermomachine/give_deployable_component()
	AddComponent(/datum/component/deployable, deploy_time, type_to_deploy, direction_setting = FALSE)

// Greyscale config for the light on this machine

/datum/greyscale_config/thermomachine/deployable
	name = "可部署热机"
	icon_file = 'modular_skyrat/modules/colony_fabricator/icons/thermomachine.dmi'
