#define DISCONNECTED 0
#define CLAMPED_OFF 1
#define OPERATING 2

#define FRACTION_TO_RELEASE 25
#define ALERT 90
#define MINIMUM_HEAT 20000

// Powersink - used to drain station power

/obj/item/powersink
	name = "电力虹吸器"
	desc = "从供电系统吸取能量并将其转化为热量的装置。用于高能系统时，务必短时运转并留出充分的冷却时间。"
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "powersink0"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NO_PIXEL_RANDOM_DROP
	throwforce = 5
	throw_speed = 1
	throw_range = 2
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT* 7.5)
	var/max_heat = 100 * STANDARD_BATTERY_CHARGE // Maximum contained heat before exploding. Not actual temperature.
	var/internal_heat = 0 // Contained heat, goes down every tick.
	var/mode = DISCONNECTED // DISCONNECTED, CLAMPED_OFF, OPERATING
	var/warning_given = FALSE //! Stop warning spam, only warn the admins/deadchat once that we are about to boom.

	var/obj/structure/cable/attached

/obj/item/powersink/update_icon_state()
	icon_state = "powersink[mode == OPERATING]"
	return ..()

/obj/item/powersink/examine(mob/user)
	. = ..()
	if(mode)
		. += "[src]用螺栓固定在地板上。"
	if((in_range(user, src) || isobserver(user)) && internal_heat > max_heat * 0.5)
		. += span_danger("[src]上方的空气都扭曲了。它一定非常烫。")

/obj/item/powersink/set_anchored(anchorvalue)
	. = ..()
	set_density(anchorvalue)

/obj/item/powersink/proc/set_mode(value)
	if(value == mode)
		return
	switch(value)
		if(DISCONNECTED)
			attached = null
			if(mode == OPERATING && internal_heat < MINIMUM_HEAT)
				STOP_PROCESSING(SSobj, src)
				internal_heat = 0
			set_anchored(FALSE)

		if(CLAMPED_OFF)
			if(!attached)
				return
			if(mode == OPERATING && internal_heat < MINIMUM_HEAT)
				STOP_PROCESSING(SSobj, src)
				internal_heat = 0
			set_anchored(TRUE)

		if(OPERATING)
			if(!attached)
				return
			START_PROCESSING(SSobj, src)
			set_anchored(TRUE)

	mode = value
	update_appearance()
	set_light(0)

/obj/item/powersink/wrench_act(mob/living/user, obj/item/tool)
	. = TRUE
	if(mode == DISCONNECTED)
		var/turf/T = loc
		if(isturf(T) && T.underfloor_accessibility >= UNDERFLOOR_INTERACTABLE)
			attached = locate() in T
			if(!attached)
				to_chat(user, span_warning("必须把[src]放在裸露且通电的电缆节点上！"))
			else
				set_mode(CLAMPED_OFF)
				user.visible_message( \
					"[user]把[src]接到了电缆上。", \
					span_notice("你把[src]固定在地板上，并接上电缆。"),
					span_hear("你听到有人在连接电线。"))
		else
			to_chat(user, span_warning("必须把[src]放在裸露且通电的电缆节点上！"))
	else
		set_mode(DISCONNECTED)
		user.visible_message( \
			"[user]断开了[src]与电缆的连接。", \
			span_notice("你松开[src]与地板连接的螺栓，并拔掉电缆。"),
			span_hear("你听到有人在断开电线连接。"))

/obj/item/powersink/screwdriver_act(mob/living/user, obj/item/tool)
	user.visible_message( \
		"[user]摆弄了一会儿[src]。", \
		span_notice("螺丝刀拧不动[src]的螺栓！试试扳手。"))
	return TRUE

/obj/item/powersink/attack_paw(mob/user, list/modifiers)
	return

/obj/item/powersink/attack_ai()
	return

/obj/item/powersink/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	switch(mode)
		if(DISCONNECTED)
			..()

		if(CLAMPED_OFF)
			user.visible_message( \
				"[user]启动了[src]！", \
				span_notice("你启动了[src]。"),
				span_hear("你听到咔哒一声。"))
			message_admins("[ADMIN_LOOKUPFLW(user)]在[ADMIN_VERBOSEJMP(src)]启动了电力虹吸器")
			user.log_message("activated a powersink", LOG_GAME)
			notify_ghosts(
				"[user.real_name]启动了电力虹吸器！",
				source = src,
				header = "电力惊报！",
			)
			set_mode(OPERATING)

		if(OPERATING)
			user.visible_message( \
				"[user]关闭了[src]！", \
				span_notice("你关闭了[src]。"),
				span_hear("你听到咔哒一声。"))
			user.log_message("deactivated the powersink", LOG_GAME)
			set_mode(CLAMPED_OFF)

/// Removes internal heat and shares it with the atmosphere.
/obj/item/powersink/proc/release_heat()
	var/turf/our_turf = get_turf(src)
	var/temp_to_give = internal_heat / FRACTION_TO_RELEASE
	internal_heat -= temp_to_give
	var/datum/gas_mixture/environment = our_turf.return_air()
	var/delta_temperature = temp_to_give / environment.heat_capacity()
	if(delta_temperature)
		environment.temperature += delta_temperature
		air_update_turf(FALSE, FALSE)
	if(warning_given && internal_heat < max_heat * 0.75)
		warning_given = FALSE
		message_admins("位于([x],[y],[z] - <A href='byond://?_src_=holder;[HrefToken()];adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>跳转</a>)的电力虹吸器已冷却，不会爆炸。")
	if(mode != OPERATING && internal_heat < MINIMUM_HEAT)
		internal_heat = 0
		STOP_PROCESSING(SSobj, src)

/// Drains power from the connected powernet, if any.
/obj/item/powersink/proc/drain_power()
	var/datum/powernet/powernet = attached.powernet
	var/drained = 0
	set_light(5)

	// Drain as much as we can from the powernet.
	drained = attached.newavail()
	attached.add_delayedload(drained)

	// If tried to drain more than available on powernet, now look for APCs and drain their cells
	for(var/obj/machinery/power/terminal/terminal in powernet.nodes)
		if(istype(terminal.master, /obj/machinery/power/apc))
			var/obj/machinery/power/apc/apc = terminal.master
			if(apc.operating && apc.cell)
				drained += 0.001 * apc.cell.use(0.1 * STANDARD_BATTERY_CHARGE, force = TRUE)
	internal_heat += drained

/obj/item/powersink/process()
	if(!attached)
		set_mode(DISCONNECTED)

	release_heat()

	if(mode != OPERATING)
		return

	drain_power()

	if(internal_heat > max_heat * ALERT / 100)
		if (!warning_given)
			warning_given = TRUE
			message_admins("位于([x],[y],[z] - <A href='byond://?_src_=holder;[HrefToken()];adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>跳转</a>)的电力虹吸器已达到最大热容量的[ALERT]%。即将爆炸。")
			notify_ghosts(
				"[src]即将达到临界热容量！",
				source = src,
				header = "电力虹吸",
			)
		playsound(src, 'sound/effects/screech.ogg', 100, TRUE, TRUE)

	if(internal_heat >= max_heat)
		STOP_PROCESSING(SSobj, src)
		explosion(src, devastation_range = 4, heavy_impact_range = 8, light_impact_range = 16, flash_range = 32)
		qdel(src)

#undef DISCONNECTED
#undef CLAMPED_OFF
#undef OPERATING
#undef FRACTION_TO_RELEASE
#undef ALERT
#undef MINIMUM_HEAT
