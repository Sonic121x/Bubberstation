// Power Tools Belt Overlays
/obj/item/crowbar/power/get_belt_overlay()
	if(tool_behaviour != TOOL_WIRECUTTER)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "jaws")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "jaws_on")

/obj/item/crowbar/power/science/get_belt_overlay()
	if(tool_behaviour != TOOL_WIRECUTTER)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_jaws")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_jaws_on")

/obj/item/screwdriver/power/get_belt_overlay()
	if(tool_behaviour != TOOL_WRENCH)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "drill")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "drill_on")

/obj/item/screwdriver/power/science/get_belt_overlay()
	if(tool_behaviour != TOOL_WRENCH)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_drill")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_drill_on")


// Proto Nitrate Tools
/obj/item/crowbar/power/protonitrate
	name = "原硝气液压救援钳"
	desc = "结合原硝气晶体以提升效率的液压工具。"
	icon = 'modular_zubbers/icons/obj/equipment/equipment.dmi'
	icon_state = "pn_jaws"
	toolspeed = 0.5

/obj/item/crowbar/power/protonitrate/Initialize(mapload)
	. = ..()
	UnregisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform_toolspeed))

/obj/item/crowbar/power/protonitrate/proc/on_transform_toolspeed(obj/item/source, mob/user, active) //Toolspeed affects how fast you can force open doors, this is so ONLY the prying mode has speed 0.5 while cutting mode is 0.25
	SIGNAL_HANDLER

	tool_behaviour = (active ? second_tool_behavior : first_tool_behavior)
	if(user)
		balloon_alert(user, "已装上[tool_behaviour == first_tool_behavior ? inactive_text : active_text]")
	playsound(src, 'sound/items/tools/change_jaws.ogg', 50, TRUE)
	if(tool_behaviour != TOOL_WIRECUTTER)
		RemoveElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
		toolspeed = 0.5
	else
		AddElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
		toolspeed = 0.25
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/crowbar/power/protonitrate/get_belt_overlay()
	if(tool_behaviour != TOOL_WIRECUTTER)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_jaws")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_jaws_on")

/obj/item/crowbar/power/protonitrate/science
	name = "原硝气复合剪钳" // hybrid between crowbar and wirecutters
	desc = "结合原硝气晶体以提升效率的复合剪钳，但缺乏撬开门所需的液压力。"
	icon_state = "pn_jaws_sci"
	inhand_icon_state = "jaws_sci"
	force_opens = FALSE

/obj/item/crowbar/power/protonitrate/science/get_belt_overlay()
	if(tool_behaviour != TOOL_WIRECUTTER)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_sci_jaws")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_sci_jaws_on")

/obj/item/screwdriver/power/protonitrate
	name = "原硝气手钻"
	desc = "结合原硝气晶体以提升效率的手钻。"
	icon = 'modular_zubbers/icons/obj/equipment/equipment.dmi'
	icon_state = "pn_drill"
	toolspeed = 0.25

/obj/item/screwdriver/power/protonitrate/get_belt_overlay()
	if(tool_behaviour != TOOL_WRENCH)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_drill")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_drill_on")

/obj/item/screwdriver/power/protonitrate/science
	icon_state = "pn_drill_sci"

/obj/item/screwdriver/power/protonitrate/science/get_belt_overlay()
	if(tool_behaviour != TOOL_WRENCH)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_sci_drill")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_sci_drill_on")

/obj/item/weldingtool/experimental/protonitrate
	name = "原硝气焊接工具"
	desc = "结合原硝气晶体进一步强化的实验型焊接工具。"
	icon = 'modular_zubbers/icons/obj/equipment/equipment.dmi'
	icon_state = "pn_welder"
	toolspeed = 0.25

/obj/item/analyzer/ranged
	w_class = WEIGHT_CLASS_SMALL
