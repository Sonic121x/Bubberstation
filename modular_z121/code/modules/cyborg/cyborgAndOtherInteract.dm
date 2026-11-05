/mob/living/silicon/robot/attack_ai_secondary(mob/user)
	if(opened && !wiresexposed)
		if(cell)
			cell.update_appearance()
			cell.forceMove(drop_location())
			to_chat(user, span_notice("你弹出了[cell]。"))
			cell = null
			update_icons()
			diag_hud_set_borgcell()
	else if(!opened)
		..()
/*
/obj/machinery/oven/attack_robot(mob/user)
	attack_hand(user)

/obj/machinery/oven/attack_ai_secondary(mob/user)
	attack_hand_secondary(user)

/obj/machinery/oven/AltClick(mob/user)
	if (open)
		used_tray.forceMove(drop_location())
		contents.Cut()
	else
		return ..()

/obj/machinery/oven/AltClick(mob/user)
	if (open)
		used_tray.forceMove(drop_location())
		contents.Cut()
	else
		return ..()

/obj/machinery/stove/attack_robot(mob/user)
	attack_hand(user)

/obj/machinery/stove/attack_ai_secondary(mob/user)
	attack_hand_secondary(user)

/obj/machinery/stove/AltClick(mob/user)
	SIGNAL_HANDLER
	container.forceMove(drop_location())

/obj/machinery/stove/AltClick(mob/user)
	if (open)
		used_tray.forceMove(drop_location())
		contents.Cut()
	else
		return ..()
*/

/obj/item/plate/attack_self(mob/user)
	for(var/g in contents)
		var/atom/movable/AM = g
		AM.forceMove(drop_location())
		contents.Cut()
	to_chat(user, span_notice("你清空了盘子里的东西."))

/*
/obj/machinery/griddle/attack_ai(mob/user)
	attack_hand(user)
*/
/obj/machinery/griddle/attack_robot(mob/user)
	attack_hand(user)

/obj/machinery/griddle/attack_ai_secondary(mob/user)
	for(var/g in griddled_objects)
		var/atom/movable/AM = g
		AM.forceMove(drop_location())
	griddled_objects.Cut()

/obj/machinery/grill/attack_ai(mob/user)
	attack_hand(user)

/obj/machinery/grill/attack_robot(mob/user)
	attack_hand(user)

/obj/machinery/deepfryer/attack_ai(mob/user)
	attack_hand(user)

/obj/machinery/deepfryer/attack_robot(mob/user)
	attack_hand(user)
/*
/obj/structure/tray/attack_ai(mob/user)
	attack_hand(user)

/obj/structure/tray/attack_robot(mob/user)
	attack_hand(user)
*/
/obj/machinery/conveyor_switch/attack_ai(mob/user)
	attack_hand(user)

/obj/machinery/conveyor_switch/attack_robot(mob/user)
	attack_hand(user)

/obj/machinery/power/floodlight/attack_ai(mob/user)
	attack_hand(user)

/obj/machinery/power/floodlight/attack_robot(mob/user)
	attack_hand(user)
/*
/obj/machinery/plumbing/liquid_input_pump/attack_ai_secondary(mob/user)
	if(!anchored)
		return ..()
	var/new_height = input(usr, "Set new height regulation:\n([0]-[LIQUID_HEIGHT_CONSIDER_FULL_TILE]. Use 0 to disable the regulation)\nThe pump will only siphon if environment is above the regulation", "Liquid Pump") as num|null
	if(QDELETED(src))
		return
	if(new_height)
		height_regulator = sanitize_integer(new_height, 0, LIQUID_HEIGHT_CONSIDER_FULL_TILE, 0)
*/
/obj/machinery/plumbing/floor_pump/input/attack_ai(mob/user)
	attack_hand(user)

/obj/machinery/plumbing/floor_pump/input/attack_robot(mob/user)
	attack_hand(user)
/*
/obj/machinery/plumbing/liquid_output_pump/attack_ai_secondary(mob/user)
	if(!anchored)
		return ..()
	var/new_height = input(usr, "Set new height regulation:\n([0]-[LIQUID_HEIGHT_CONSIDER_FULL_TILE]. Use 0 to disable the regulation)\nThe pump will only siphon if environment is below the regulation", "Liquid Pump") as num|null
	if(QDELETED(src))
		return
	if(new_height)
		height_regulator = sanitize_integer(new_height, 0, LIQUID_HEIGHT_CONSIDER_FULL_TILE, 0)
*/
/obj/machinery/plumbing/floor_pump/output/attack_ai(mob/user)
	attack_hand(user)

/obj/machinery/plumbing/floor_pump/output/attack_robot(mob/user)
	attack_hand(user)

/obj/structure/liquid_pump/attack_ai(mob/user)
	attack_hand(user)

/obj/structure/liquid_pump/attack_robot(mob/user)
	attack_hand(user)

/obj/structure/liquid_pump/attack_ai_secondary(mob/user)
	to_chat(user, span_notice("你[spewing_mode ? "关闭" : "开启"]了[src]的喷洒模式。"))
	spewing_mode = !spewing_mode
	update_icon()
/*
//griddle test
/obj/machinery/griddle/verb/toggle()
	set category = "Object"
	set name = "Toggle On/Off"
	set src in view(1)

	if(!isliving(usr))
		to_chat(usr, "<span class='warning'>You can't do that!</span>")
		return
	if (!usr.canUseTopic())
		return
	if(usr.incapacitated())
		return

	. = ..()
	on = !on
	if(on)
		begin_processing()
	else
		end_processing()
	update_appearance()
	update_grill_audio()

/obj/machinery/grill/verb/eject()
	set category = "Object"
	set name = "Eject Content"
	set src in view(1)

	if(grilled_item)
		to_chat(usr, "<span class='notice'>You take out [grilled_item] from [src].</span>")
		grilled_item.forceMove(drop_location())
		update_appearance()
		return
	return ..()

/obj/machinery/deepfryer/verb/eject()
	set category = "Object"
	set name = "Eject Content"
	set src in view(1)

	if(frying)
		if(frying.loc == src)
			to_chat(usr, "<span class='notice'>You eject [frying] from [src].</span>")
			frying.fry(cook_time)
			icon_state = "fryer_off"
			frying.forceMove(drop_location())
			frying = null
			cook_time = 0
			frying_fried = FALSE
			frying_burnt = FALSE
			fry_loop.stop()
			return

/obj/structure/tray/verb/Retract()
	set category = "Object"
	set name = "Retract"
	set src in view(1)

	if (src.connected)
		connected.close()
		add_fingerprint(usr)
	else
		to_chat(usr, "<span class='warning'>That's not connected to anything!</span>")

/obj/structure/closet/AltClick(mob/user)
	..()
	if(!user.canUseTopic(src, be_close = TRUE) || !isturf(loc))
		return
	if(opened || !secure)
		return
	else
		togglelock(user)

//conveyor belt switch
/obj/machinery/conveyor_switch/verb/Switch()
	set category = "Object"
	set name = "PullSwitch"
	set src in view(1)

	add_fingerprint(usr)
	update_position()
	update_appearance()
	update_linked_conveyors()
	update_linked_switches()

/obj/machinery/iv_drip/attack_robot(mob/user)
	. = ..()
	if(.)
		return
	if(attached)
		visible_message(span_notice("[attached] is detached from [src]."))
		detach_iv()
		return
	else if(reagent_container)
		eject_beaker(user)
	else
		toggle_mode()

/obj/machinery/iv_drip/AltClick(mob/living/user)
	if(!user.canUseTopic(src, be_close=TRUE))
		return
	if(dripfeed)
		dripfeed = FALSE
		to_chat(usr, "<span class='notice'>You loosen the valve to speed up the [src].</span>")
	else
		dripfeed = TRUE
		to_chat(usr, "<span class='notice'>You tighten the valve to slowly drip-feed the contents of [src].</span>")

/obj/structure/etherealball/attack_ai(mob/user)
	. = ..()
	if(TurnedOn)
		TurnOff()
		to_chat(user, span_notice("You turn the disco ball off!"))
	else
		TurnOn()
		to_chat(user, span_notice("You turn the disco ball on!"))

/obj/structure/etherealball/attack_robot(mob/user)
	. = ..()
	if(TurnedOn)
		TurnOff()
		to_chat(user, span_notice("You turn the disco ball off!"))
	else
		TurnOn()
		to_chat(user, span_notice("You turn the disco ball on!"))
*/

/obj/structure/etherealball/attack_ai_secondary(mob/user)
	. = ..()
	set_anchored(!anchored)
	to_chat(user, span_notice("你[anchored ? "固定了" : "松开了"]迪斯科球。"))

/obj/machinery/hydroponics/attack_robot(mob/user)
	. = ..()
	if(.)
		return
	if(plant_status == HYDROTRAY_PLANT_HARVESTABLE)
		return myseed.harvest(user)

	else if(plant_status == HYDROTRAY_PLANT_DEAD)
		to_chat(user, span_notice("你从[src]中移除了枯死的植物。"))
		set_seed(null)
	else
		if(user)
			user.examinate(src)

/obj/machinery/plumbing/growing_vat/attack_robot(mob/user)
	attack_hand(user)

/obj/structure/microscope/attack_robot(mob/user)
	if(Adjacent(user))
		ui_interact(user)

/obj/machinery/cell_charger/attack_robot(mob/user)
	attack_hand(user)

/obj/machinery/cell_charger_multi/attack_robot(mob/user)
	attack_hand(user)

/obj/structure/reagent_crafting_bench/attack_robot(mob/living/user)
	attack_hand(user)
