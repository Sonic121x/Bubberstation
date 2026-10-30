// VENTCRAWLING

/mob/living/proc/notify_ventcrawler_on_login()
	var/ventcrawler = HAS_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS) || HAS_TRAIT(src, TRAIT_VENTCRAWLER_NUDE)
	if(!ventcrawler)
		return
	to_chat(src, span_notice("你会钻通风管！对通风口按 Alt+点击，即可快速穿梭于空间站各处。"))

/mob/living/carbon/human/notify_ventcrawler_on_login()
	if(!HAS_TRAIT(src, TRAIT_LESSER_HUMANOID))
		return ..()
	if(!istype(head, /obj/item/clothing/head/helmet/monkey_sentience)) //don't notify them about ventcrawling if they're wearing the sentience helmet, because they can't ventcrawl with it on, and if they take it off they'll no longer be in control of the mob.
		return ..()


/// Checks if the mob is able to enter the vent, and provides feedback if they are unable to.
/mob/living/proc/can_enter_vent(obj/machinery/atmospherics/components/ventcrawl_target, provide_feedback = TRUE)
	// Being able to always ventcrawl trumps being only able to ventcrawl when wearing nothing
	var/required_nudity = HAS_TRAIT(src, TRAIT_VENTCRAWLER_NUDE) && !HAS_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS)
	// Cache the vent_movement bitflag var from atmos machineries
	var/vent_movement = ventcrawl_target.vent_movement

	if(!Adjacent(ventcrawl_target))
		return
	// BUBBER ADDITION START - VENTCRAWLING SIGNAL
	var/signal_result = SEND_SIGNAL(src, COMSIG_CAN_VENTCRAWL, ventcrawl_target, provide_feedback)
	if(!HAS_TRAIT(src, TRAIT_VENTCRAWLER_NUDE) && !HAS_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS) && !signal_result)
		return
	if(IS_UNCONSCIOUS_OR_CRIT(src))
		if(provide_feedback)
			to_chat(src, span_warning("你必须保持清醒才能这么做！"))
		return
	if(HAS_TRAIT(src, TRAIT_IMMOBILIZED))
		if(provide_feedback)
			to_chat(src, span_warning("你现在无法进入通风口！"))
		return
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		if(provide_feedback)
			to_chat(src, span_warning("你需要能使用双手才能钻通风管！"))
		return
	if(has_buckled_mobs())
		if(provide_feedback)
			to_chat(src, span_warning("有其他生物挂在你身上时，你无法钻通风管！"))
		return
	if(buckled)
		if(provide_feedback)
			to_chat(src, span_warning("被绑住时你无法钻通风管！"))
		return
	if(iscarbon(src) && required_nudity && !signal_result) // BUBBER CHANGE - VENTCRAWLING SIGNAL
		if(length(get_equipped_items(INCLUDE_POCKETS|INCLUDE_HELD)))
			if(provide_feedback)
				to_chat(src, span_warning("带着物品时你无法在通风管道中爬行！"))
			return
	if(ventcrawl_target.welded)
		if(provide_feedback)
			// Add cooldown to prevent welded vent message spam during movement
			if(COOLDOWN_FINISHED(src, welded_vent_message_cd))
				to_chat(src, span_warning("焊接密封的通风口无法爬行通过！"))
				COOLDOWN_START(src, welded_vent_message_cd, 2 SECONDS)
		return

	if(!(vent_movement & VENTCRAWL_ENTRANCE_ALLOWED))
		if(provide_feedback)
			to_chat(src, span_warning("你无法进入这个通风口！"))
		return

	return TRUE

/// Handles the entrance and exit on ventcrawling
/mob/living/proc/handle_ventcrawl(obj/machinery/atmospherics/components/ventcrawl_target)
	if(!can_enter_vent(ventcrawl_target))
		return

	var/has_client = !isnull(client) // clientless mobs can do this too! this is just stored in case the client disconnects while we sleep in do_after.

	//Handle the exit here
	if(HAS_TRAIT(src, TRAIT_MOVE_VENTCRAWLING) && istype(loc, /obj/machinery/atmospherics) && movement_type & VENTCRAWLING)
		// BUBBER ADDITION START - VENTCRAWLING SIGNAL
		var/exit_time = SEND_SIGNAL(src, COMSIG_VENTCRAWL_PRE_EXIT, ventcrawl_target)
		if(!exit_time)
			exit_time = 1 SECONDS
		// BUBBER ADDITION END - VENTCRAWLING SIGNAL
		to_chat(src, span_notice("你开始从通风系统中爬出来……"))
		if(has_client && isnull(client))
			return
		if(!do_after(src, exit_time, target = ventcrawl_target)) // BUBBER CHANGE - VENTCRAWLING SIGNAL
			SEND_SIGNAL(src, COMSIG_VENTCRAWL_PRE_CANCEL, ventcrawl_target) // BUBBER ADDITION - VENTCRAWLING SIGNAL
			return
		if(ventcrawl_target.welded) // in case it got welded during our sleep
			to_chat(src, span_warning("焊接密封的通风口无法爬行通过！"))
			return
		visible_message(span_notice("[src] 从通风管道中手忙脚乱地爬了出来！"), span_notice("你从通风管道中手忙脚乱地爬了出来。"))
		forceMove(ventcrawl_target.loc)
		REMOVE_TRAIT(src, TRAIT_MOVE_VENTCRAWLING, VENTCRAWLING_TRAIT)
		update_pipe_vision()
		SEND_SIGNAL(src, COMSIG_VENTCRAWL_EXIT, ventcrawl_target) // BUBBER ADDITION - VENTCRAWLING SIGNAL

	//Entrance here
	else
		var/datum/pipeline/vent_parent = ventcrawl_target.parents[1]
		if(vent_parent && (vent_parent.members.len || vent_parent.other_atmos_machines))
			// BUBBER ADDITION START - VENTCRAWLING SIGNAL
			var/enter_time = SEND_SIGNAL(src, COMISG_VENTCRAWL_PRE_ENTER, ventcrawl_target)
			if(!enter_time)
				enter_time = 2.5 SECONDS // Default time if the signal doesn't return anything
			// BUBBER ADDITION END - VENTCRAWLING SIGNAL
			ventcrawl_target.flick_overlay_static(image('icons/effects/vent_indicator.dmi', "arrow", ABOVE_MOB_LAYER, dir = get_dir(src.loc, ventcrawl_target.loc)), 2 SECONDS)
			visible_message(span_notice("[src] 开始爬进通风系统……") ,span_notice("你开始爬进通风系统……"))
			if(!do_after(src, enter_time, target = ventcrawl_target, extra_checks = CALLBACK(src, PROC_REF(can_enter_vent), ventcrawl_target))) // BUBBER CHANGE - VENTCRAWLING SIGNAL
				SEND_SIGNAL(src, COMSIG_VENTCRAWL_PRE_CANCEL, ventcrawl_target) // BUBBER ADDITION - VENTCRAWLING SIGNAL
				return
			if(has_client && isnull(client))
				return
			if(ventcrawl_target.welded) // in case it got welded during our sleep
				to_chat(src, span_warning("焊接密封的通风口无法爬行通过！"))
				return
			ventcrawl_target.flick_overlay_static(image('icons/effects/vent_indicator.dmi', "insert", ABOVE_MOB_LAYER), 1 SECONDS)
			visible_message(span_notice("[src] 手忙脚乱地钻进了通风管道！"), span_notice("你爬进了通风管道。"))
			move_into_vent(ventcrawl_target)
			SEND_SIGNAL(src, COMSIG_VENTCRAWL_ENTER, ventcrawl_target) // BUBBER ADDITION - VENTCRAWLING SIGNAL
		else
			to_chat(src, span_warning("这处通风管道没有连接到任何东西！"))

/mob/living/basic/slime/can_enter_vent(obj/machinery/atmospherics/components/ventcrawl_target, provide_feedback = TRUE)
	if(buckled)
		if(provide_feedback)
			to_chat(src, span_warning("进食时你无法钻通风管！"))
		return
	return ..()

/**
 * Moves living mob directly into the vent as a ventcrawler
 *
 * Arguments:
 * * ventcrawl_target - The vent into which we are moving the mob
 */
/mob/living/proc/move_into_vent(obj/machinery/atmospherics/components/ventcrawl_target)
	forceMove(ventcrawl_target)
	ADD_TRAIT(src, TRAIT_MOVE_VENTCRAWLING, VENTCRAWLING_TRAIT)
	update_pipe_vision()

/**
 * Everything related to pipe vision on ventcrawling is handled by update_pipe_vision().
 * Called on exit, entrance, and pipenet differences (e.g. moving to a new pipenet).
 * One important thing to note however is that the movement of the client's eye is handled by the relaymove() proc in /obj/machinery/atmospherics.
 * We move first and then call update. Dont flip this around
 */
/mob/living/proc/update_pipe_vision(full_refresh = FALSE)
	if(!isnull(ai_controller) && isnull(client)) // we don't care about pipe vision if we have an AI controller with no client (typically means we are clientless).
		return

	// Take away all the pipe images if we're not doing anything with em
	if(isnull(client) || !HAS_TRAIT(src, TRAIT_MOVE_VENTCRAWLING) || !istype(loc, /obj/machinery/atmospherics) || !(movement_type & VENTCRAWLING))
		for(var/image/current_image in pipes_shown)
			client.images -= current_image
		pipes_shown.len = 0
		pipetracker = null
		for(var/atom/movable/screen/plane_master/lighting as anything in hud_used.get_true_plane_masters(LIGHTING_PLANE))
			lighting.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, "#4d4d4d")
		for(var/atom/movable/screen/plane_master/pipecrawl as anything in hud_used.get_true_plane_masters(PIPECRAWL_IMAGES_PLANE))
			pipecrawl.hide_plane(src)
		return

	// We're gonna color the lighting plane to make it darker while ventcrawling, so things look nicer
	// This is a bit hacky but it makes the background darker, which has a nice effect
	for(var/atom/movable/screen/plane_master/lighting as anything in hud_used.get_true_plane_masters(LIGHTING_PLANE))
		lighting.add_atom_colour("#4d4d4d", TEMPORARY_COLOUR_PRIORITY)

	for(var/atom/movable/screen/plane_master/pipecrawl as anything in hud_used.get_true_plane_masters(PIPECRAWL_IMAGES_PLANE))
		pipecrawl.unhide_plane(src)

	var/obj/machinery/atmospherics/current_location = loc
	var/list/our_pipenets = current_location.return_pipenets()

	// We on occasion want to do a full rebuild. this lets us do that
	if(full_refresh)
		for(var/image/current_image in pipes_shown)
			client.images -= current_image
		pipes_shown.len = 0
		pipetracker = null

	if(!pipetracker)
		pipetracker = new()

	var/turf/our_turf = get_turf(src)
	// We're getting the smallest "range" arg we can pass to the spatial grid and still get all the stuff we need
	// We preload a bit more then we need so movement looks ok
	var/list/view_range = getviewsize(client.view)
	pipetracker.set_bounds(view_range[1] + 1, view_range[2] + 1)

	var/list/entered_exited_pipes = pipetracker.recalculate_type_members(our_turf, SPATIAL_GRID_CONTENTS_TYPE_ATMOS)
	var/list/pipes_gained = entered_exited_pipes[1]
	var/list/pipes_lost = entered_exited_pipes[2]

	for(var/obj/machinery/atmospherics/pipenet_part as anything in pipes_lost)
		if(!pipenet_part.pipe_vision_img)
			continue
		client.images -= pipenet_part.pipe_vision_img
		pipes_shown -= pipenet_part.pipe_vision_img

	for(var/obj/machinery/atmospherics/pipenet_part as anything in pipes_gained)
		// If the machinery is not part of our net or is not meant to be seen, continue
		var/list/thier_pipenets = pipenet_part.return_pipenets()
		if(!length(thier_pipenets & our_pipenets))
			continue
		if(!(pipenet_part.vent_movement & VENTCRAWL_CAN_SEE))
			continue

		if(!pipenet_part.pipe_vision_img)
			var/turf/their_turf = get_turf(pipenet_part)
			pipenet_part.pipe_vision_img = image(pipenet_part, pipenet_part.loc, dir = pipenet_part.dir)
			SET_PLANE(pipenet_part.pipe_vision_img, PIPECRAWL_IMAGES_PLANE, their_turf)
		client.images += pipenet_part.pipe_vision_img
		pipes_shown += pipenet_part.pipe_vision_img
