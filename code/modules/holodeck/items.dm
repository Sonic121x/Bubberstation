/*
	Items, Structures, Machines
*/


//
// Items
//

/obj/item/melee/energy/sword/holographic
	name = "全息能量剑"
	desc = "愿原力与你同在。差不多吧。"
	damtype = STAMINA
	throw_speed = 2
	block_chance = 0
	throwforce = 0
	embed_type = null
	sword_color_icon = null

	active_throwforce = 0
	active_sharpness = NONE
	active_heat = 0

/obj/item/melee/energy/sword/holographic/Initialize(mapload)
	. = ..()
	if(!sword_color_icon)
		sword_color_icon = pick("red", "blue", "green", "purple")

/obj/item/melee/energy/sword/holographic/green
	sword_color_icon = "green"

/obj/item/melee/energy/sword/holographic/red
	sword_color_icon = "red"

/obj/item/toy/cards/deck/syndicate/holographic
	desc = "一副全息纸牌。"

/obj/item/toy/cards/deck/syndicate/holographic/Initialize(mapload, obj/machinery/computer/holodeck/holodeck)
	src.holodeck = holodeck
	RegisterSignal(src, COMSIG_QDELETING, PROC_REF(handle_card_delete))
	. = ..()

/obj/item/toy/cards/deck/syndicate/holographic/proc/handle_card_delete(datum/source)
	SIGNAL_HANDLER

	//if any REAL cards have been inserted into the deck they are moved outside before destroying it
	for(var/obj/item/toy/singlecard/card in card_atoms)
		if(card.flags_1 & HOLOGRAM_1)
			continue
		card_atoms -= card
		card.forceMove(drop_location())

/obj/item/toy/dodgeball
	name = "躲球"
	icon = 'icons/obj/toys/balls.dmi'
	icon_state = "dodgeball"
	inhand_icon_state = "dodgeball"
	desc = "用于玩那种最暴力、最有失体面的童年游戏。"
	w_class = WEIGHT_CLASS_BULKY //Stops people from hiding it in their bags/pockets

/obj/item/toy/dodgeball/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	if((ishuman(hit_atom)))
		var/mob/living/carbon/M = hit_atom
		playsound(src, 'sound/items/dodgeball.ogg', 50, TRUE)
		M.apply_damage(10, STAMINA)
		if(prob(5))
			M.Paralyze(60)
			visible_message(span_danger("[M] 被直接打翻在地！"))

//
// Machines
//

/obj/machinery/readybutton
	name = "就绪宣告装置"
	desc = "这个装置用于宣告就绪。当一个区域内的所有装置都已就绪，活动就会开始！"
	icon = 'icons/obj/machines/wallmounts.dmi'
	icon_state = "auth_off"
	var/ready = 0
	var/area/currentarea = null
	var/eventstarted = FALSE

	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 0.02
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.006
	power_channel = AREA_USAGE_ENVIRON

/obj/machinery/readybutton/attack_ai(mob/user)
	to_chat(user, span_warning("空间站 AI 不得操作这些装置！"))
	return

/obj/machinery/readybutton/attack_paw(mob/user, list/modifiers)
	to_chat(user, span_warning("你太原始了，用不了这个装置！"))
	return

/obj/machinery/readybutton/attackby(obj/item/W, mob/user, list/modifiers, list/attack_modifiers)
	to_chat(user, span_warning("这个装置就是一个实心按钮，你对它做不了什么的！"))

/obj/machinery/readybutton/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(machine_stat & (NOPOWER|BROKEN))
		to_chat(user, span_warning("这个装置没有供电！"))
		return

	currentarea = get_area(src)
	if(isnull(currentarea))
		qdel(src)
		return

	if(eventstarted)
		to_chat(usr, span_warning("活动已经开始了！"))
		return

	ready = !ready

	update_appearance()

	var/numbuttons = 0
	var/numready = 0
	for (var/list/zlevel_turfs as anything in currentarea.get_zlevel_turf_lists())
		for (var/turf/area_turf as anything in zlevel_turfs)
			for(var/obj/machinery/readybutton/button in area_turf)
				numbuttons++
				if(button.ready)
					numready++

	if(numbuttons == numready)
		begin_event()

/obj/machinery/readybutton/update_overlays()
	. = ..()
	if(ready && is_operational)
		. += mutable_appearance(icon, "auth_on")
		. += emissive_appearance(icon, "auth_on", src, alpha = src.alpha)


/obj/machinery/readybutton/proc/begin_event()

	eventstarted = TRUE

	for (var/list/zlevel_turfs as anything in currentarea.get_zlevel_turf_lists())
		for(var/turf/area_turf as anything in zlevel_turfs)
			for(var/obj/structure/window/barrier in area_turf)
				if(barrier.flags_1 & HOLOGRAM_1)// Just in case: only holo-windows
					qdel(barrier)

			for(var/mob/contestant in area_turf)
				to_chat(contestant, span_userdanger("开打！"))

/obj/machinery/conveyor/holodeck

/obj/machinery/conveyor/holodeck/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!user.transferItemToLoc(tool, drop_location()))
		return ..()

	return ITEM_INTERACT_SUCCESS

/obj/item/paper/fluff/holodeck/trek_diploma
	name = "纸张——星际舰队学院毕业证书"
	default_raw_text = {"<h2>星际舰队学院</h2></br><p>正式毕业证书</p></br>"}

/obj/item/paper/fluff/holodeck/disclaimer
	name = "全息甲板免责声明"
	default_raw_text = "在全息甲板上受的淤伤，只要睡一觉就能痊愈。"

/obj/vehicle/ridden/scooter/skateboard/pro/holodeck
	name = "全息滑板"
	desc = "EightO 品牌专业滑板的全息复制品。"
	instability = 6

/obj/vehicle/ridden/scooter/skateboard/pro/holodeck/pick_up_board() //picking up normal skateboards spawned in the holodeck gets rid of the holo flag, now you cant pick them up.
	return
