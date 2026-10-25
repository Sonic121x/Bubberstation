/obj/item/pipe_painter
	name = "管道喷漆器"
	desc = "顾名思义，用来给管道上色。"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "labeler1"
	inhand_icon_state = null
	item_flags = NOBLUDGEON
	var/paint_color = "grey"

	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT)

/obj/item/pipe_painter/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/machinery/atmospherics))
		var/obj/machinery/atmospherics/target_pipe = interacting_with
		target_pipe.paint(GLOB.pipe_paint_colors[paint_color])
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		balloon_alert(user, "已涂成[chinese_color_display(paint_color)]")
		return ITEM_INTERACT_SUCCESS

	if(istype(interacting_with, /obj/item/pipe))
		var/obj/item/pipe/target_pipe = interacting_with
		var/color = GLOB.pipe_paint_colors[paint_color]
		target_pipe.pipe_color = color
		target_pipe.add_atom_colour(color, FIXED_COLOUR_PRIORITY)
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		balloon_alert(user, "已涂成[chinese_color_display(paint_color)]")
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/pipe_painter/attack_self(mob/user)
	paint_color = chinese_pipe_paint_choice(user)

/obj/item/pipe_painter/examine(mob/user)
	. = ..()
	. += span_notice("当前设置为[chinese_color_display(paint_color)]。")
