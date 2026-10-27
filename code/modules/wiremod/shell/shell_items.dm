/**
 * # Shell Item
 *
 * Printed out by protolathes. Screwdriver to complete the shell.
 */
/obj/item/shell
	name = "装配件"
	desc = "一种可用螺丝刀完成的装配件外壳。"
	icon = 'icons/obj/science/circuits.dmi'
	abstract_type = /obj/item/shell
	var/shell_to_spawn
	var/screw_delay = 3 SECONDS

/obj/item/shell/screwdriver_act(mob/living/user, obj/item/tool)
	user.visible_message(span_notice("[user] 开始组装 [src]。"), span_notice("你开始组装 [src]。"))
	tool.play_tool_sound(src)
	if(!do_after(user, screw_delay, src))
		return
	user.visible_message(span_notice("[user] 完成了 [src]。"), span_notice("你完成了 [src]。"))

	var/turf/drop_loc = drop_location()

	qdel(src)
	if(drop_loc)
		new shell_to_spawn(drop_loc)

	return TRUE

/obj/item/shell/bot
	name = "机器人装配件"
	icon_state = "setup_medium_box-open"
	shell_to_spawn = /obj/structure/bot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT)

/obj/item/shell/money_bot
	name = "信用点机器人装配件"
	icon_state = "setup_large-open"
	shell_to_spawn = /obj/structure/money_bot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/shell/drone
	name = "无人机装配件"
	icon_state = "setup_medium_med-open"
	shell_to_spawn = /mob/living/circuit_drone
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/shell/server
	name = "服务器装配件"
	icon_state = "setup_stationary-open"
	shell_to_spawn = /obj/structure/server
	screw_delay = 10 SECONDS
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.75)

/obj/item/shell/airlock
	name = "电路气闸装配件"
	icon = 'icons/obj/doors/airlocks/station/public.dmi'
	icon_state = "construction"
	shell_to_spawn = /obj/machinery/door/airlock/shell
	screw_delay = 10 SECONDS
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/shell/dispenser
	name = "电路售货机装配件"
	icon_state = "setup_drone_arms-open"
	shell_to_spawn = /obj/structure/dispenser_bot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/shell/bci
	name = "脑机接口装配件"
	icon_state = "bci-open"
	shell_to_spawn = /obj/item/organ/cyberimp/bci
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SHEET_MATERIAL_AMOUNT)

/obj/item/shell/scanner_gate
	name = "扫描门装配件"
	icon = 'icons/obj/machines/scangate.dmi'
	icon_state = "scangate_black_open"
	shell_to_spawn = /obj/structure/scanner_gate_shell
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2)
