/obj/item/pressure_plate
	name = "压力板"
	desc = "踩上去便会触发的电子装置。"
	desc_controls = "按住Ctrl点击可开关压力板。"
	icon = 'icons/obj/fluff/puzzle_small.dmi'
	inhand_icon_state = "flashtool"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	icon_state = "pressureplate"
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.7)
	var/trigger_mob = TRUE
	var/trigger_item = FALSE
	var/specific_item = null
	var/trigger_silent = FALSE
	var/sound/trigger_sound = 'sound/effects/pressureplate.ogg'
	var/obj/item/assembly/assembly = null
	var/roundstart_signaller = FALSE
	var/roundstart_signaller_freq = FREQ_PRESSURE_PLATE
	var/roundstart_signaller_code = 30
	var/roundstart_hide = FALSE
	var/removable_assembly = TRUE
	var/active = FALSE
	var/image/tile_overlay = null
	var/can_trigger = TRUE
	var/trigger_delay = 10
	var/protected = FALSE
	var/undertile_pressureplate = TRUE

/obj/item/pressure_plate/Initialize(mapload)
	. = ..()
	tile_overlay = image(icon = 'icons/turf/floors.dmi', icon_state = "pp_overlay")
	if(roundstart_signaller)
		var/obj/item/assembly/signaler/signaller = new(src)
		signaller.code = roundstart_signaller_code
		signaller.set_frequency(roundstart_signaller_freq)
		assembly = signaller

	if(undertile_pressureplate)
		AddElement(/datum/element/undertile, tile_overlay = tile_overlay, use_anchor = TRUE)
	RegisterSignal(src, COMSIG_OBJ_HIDE, PROC_REF(ToggleActive))
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/pressure_plate/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!can_trigger || !active)
		return
	if(trigger_item && !istype(AM, specific_item))
		return
	if(trigger_mob && isliving(AM))
		var/mob/living/L = AM
		to_chat(L, span_warning("你感觉脚下有什么东西咔哒响了一声！"))
	else if(!trigger_item)
		return
	can_trigger = FALSE
	addtimer(CALLBACK(src, PROC_REF(trigger)), trigger_delay)

/obj/item/pressure_plate/proc/trigger()
	can_trigger = TRUE
	if(istype(assembly))
		assembly.activate()

/obj/item/pressure_plate/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!isassembly(tool) || assembly || !removable_assembly)
		return NONE
	var/obj/item/assembly/new_assembly = tool
	if(!(new_assembly.assembly_behavior & ASSEMBLY_FUNCTIONAL_OUTPUT))
		to_chat(user, span_warning("把[tool]装进[src]里似乎起不到什么作用……"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	assembly = tool
	SEND_SIGNAL(tool, COMSIG_ASSEMBLY_ADDED_TO_PRESSURE_PLATE, src, user)
	to_chat(user, span_notice("你把[tool]装到了[src]上！"))
	return ITEM_INTERACT_SUCCESS

/obj/item/pressure_plate/attack_self(mob/living/L)
	if(removable_assembly && istype(assembly))
		to_chat(L, span_notice("你从[src]上拆下了[assembly]。"))
		SEND_SIGNAL(assembly, COMSIG_ASSEMBLY_REMOVED_FROM_PRESSURE_PLATE, src, L)
		if(!L.put_in_hands(assembly))
			assembly.forceMove(get_turf(src))
		assembly = null
	return ..()

/obj/item/pressure_plate/item_ctrl_click(mob/user)
	if(protected)
		to_chat(user, span_warning("你似乎无法关闭这块压力板……"))
		return CLICK_ACTION_BLOCKING
	active = !active
	if (active)
		to_chat(user, span_notice("你开启了[src]。"))
	else
		to_chat(user, span_notice("你关闭了[src]。"))
	return CLICK_ACTION_SUCCESS

///Called from COMSIG_OBJ_HIDE to toggle the active part, because yeah im not making a special exception on the element to support it
/obj/item/pressure_plate/proc/ToggleActive(datum/source, underfloor_accessibility)
	SIGNAL_HANDLER

	active = underfloor_accessibility < UNDERFLOOR_VISIBLE

/obj/item/pressure_plate/puzzle
	protected = TRUE
	anchored = TRUE //this prevents us from being picked up
	active = TRUE
	removable_assembly = FALSE
	/// puzzle id we send if stepped on
	var/puzzle_id
	/// queue size must match
	var/queue_size = 2

/obj/item/pressure_plate/puzzle/Initialize(mapload)
	. = ..()
	if(!isnull(puzzle_id))
		SSqueuelinks.add_to_queue(src, puzzle_id, queue_size)

/obj/item/pressure_plate/puzzle/trigger()
	can_trigger = FALSE
	SEND_SIGNAL(src, COMSIG_PUZZLE_COMPLETED)
