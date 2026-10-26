/obj/item/mecha_diagnostic
	name = "机甲全息诊断仪"
	desc = "一张全息数据表，记载了与机甲制造过程相关的独有数据，以及与公开设计之间的任何生产差异，用于持续改进。"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "holosheet"
	w_class = WEIGHT_CLASS_SMALL
	layer = ABOVE_MOB_LAYER
	light_system = OVERLAY_LIGHT
	light_range = 1
	light_power = 2
	light_color = "#79aeeb"
	/// What mech was this diagnostic sheet generated from? Used for applicability in bounties.
	var/obj/vehicle/sealed/mecha/mech_data

/obj/item/mecha_diagnostic/Initialize(mapload)
	. = ..()
	set_light_on(TRUE)

/obj/item/mecha_diagnostic/Destroy(force)
	. = ..()
	mech_data = null

/obj/item/mecha_diagnostic/examine(mob/user)
	. = ..()
	if(mech_data)
		. += "这张全息数据表包含来自 <b>[initial(mech_data.name)]</b> 的数据。"
