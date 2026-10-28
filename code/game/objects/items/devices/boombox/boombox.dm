/obj/item/boombox
	name = "\proper 纳米音乐手提音响"
	desc = "带上这台轰鸣的音响，让喧闹永不停歇。"
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "boombox"
	inhand_icon_state = "boombox"
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'
	custom_premium_price = PAYCHECK_COMMAND * 7
	interaction_flags_item = parent_type::interaction_flags_item & ~INTERACT_ITEM_ATTACK_HAND_PICKUP
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	/// Is the boombox actively playing anything?
	var/active = FALSE
	/// Is the boombox being worn on the holder's shoulder?
	var/swag_mode = FALSE
	/// Reference to the tapedeck that's inserted into the boombox.
	var/obj/item/music_tape/tapedeck = null
	/// Soundloop that's managing our boombox.
	var/datum/looping_sound/boombox_audio = null
	/// A list of all available boombox actions
	var/list/boombox_acts = list()
	/// Icon file for radial objects
	var/radial_icon_file = 'icons/hud/radial_taperecorder.dmi'
	/// Particle holder for music note effect.
	var/obj/effect/abstract/particle_holder/music_particles

/obj/item/boombox/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/drag_pickup)
	update_available_icons()
	register_context()

/obj/item/boombox/handle_deconstruct(disassembled)
	if(tapedeck)
		tapedeck.forceMove(drop_location())

/obj/item/boombox/Destroy(force)
	QDEL_NULL(boombox_audio)
	return ..()

/obj/item/boombox/examine(mob/user)
	. = ..()
	. += span_notice("手提音响既能提在手里，也能扛在肩上。按住 Alt 右键点击以切换。")
	if(tapedeck)
		. += "里面装着[span_bold("[tapedeck]")]。"
	else
		. += "里面没有磁带。"

/obj/item/boombox/click_alt_secondary(mob/user)
	swag_mode = !swag_mode
	balloon_alert(user, "[swag_mode ? "扛在肩上" : "提在手中"]")
	if(loc == user)
		playsound(user, pickup_sound, 30)
	update_appearance()
	user.update_held_items()
	return CLICK_ACTION_SUCCESS

/obj/item/boombox/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/music_tape))
		if(tapedeck)
			balloon_alert(user, "请先弹出磁带！")
			return ITEM_INTERACT_BLOCKING
		var/obj/item/music_tape/tunes = tool
		user.transferItemToLoc(tunes, src)
		tapedeck = tunes
		balloon_alert(user, "已插入磁带")
		playsound(src, 'sound/items/taperecorder/taperecorder_close.ogg', 50, FALSE)
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/tape))
		balloon_alert(user, "放不进去！")
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/item/boombox/attack_hand(mob/user, list/modifiers)
	. = ..()
	update_available_icons()
	if(!check_menu(user))
		return
	display_radial_menu(user)

/obj/item/boombox/attack_self(mob/user, modifiers)
	. = ..()
	update_available_icons()
	if(!check_menu(user))
		return
	display_radial_menu(user)

/obj/item/boombox/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_RMB] = "操作手提音响"
	context[SCREENTIP_CONTEXT_LMB] = "拾起（拖动）"
	context[SCREENTIP_CONTEXT_ALT_RMB] = "切换携带姿势"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/boombox/update_icon_state()
	inhand_icon_state = swag_mode ? "boombox_swag" : "boombox"
	return ..()

/obj/item/boombox/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	. = ..()
	update_appearance() //Update appearance when dragged for shoulder icon state.

/**
 * Handles the radial menu of the boombox and it's active effects when selected.
 */
/obj/item/boombox/proc/display_radial_menu(mob/living/user)
	if(!user)
		return FALSE
	var/choice = chinese_boombox_radial(user, src, boombox_acts)
	if(!choice)
		return FALSE
	switch(choice)
		if("Play")
			if(!tapedeck)
				balloon_alert(user, "没有磁带！")
				return
			boombox_audio = tapedeck.song_inside
			music_particles = new (src, /particles/musical_notes, PARTICLE_ATTACH_MOB)
			boombox_audio.start()
			icon_state = "boombox_on"
			update_appearance()
			active = TRUE

		if("Stop")
			if(!boombox_audio)
				balloon_alert(user, "没有正在播放的音乐！")
				return
			stop_music(user)
			active = FALSE

		if("Eject")
			stop_music(user)
			user.transferItemToLoc(tapedeck, drop_location())
			tapedeck = null
			update_available_icons()
			active = FALSE

	playsound(src, 'sound/machines/click.ogg', 40, TRUE)

/// Updates the list of boombox_acts for the radial menu.
/obj/item/boombox/proc/update_available_icons()
	boombox_acts = list()
	if(!active)
		boombox_acts += list("Play" = image(radial_icon_file, "play"))
	else
		boombox_acts += list("Stop" = image(radial_icon_file, "stop"))
	if(tapedeck)
		boombox_acts += list("Eject" = image(radial_icon_file, "eject"))

/// Do we meet the requirements to interact with the boombox?
/obj/item/boombox/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/// Stops looping audio, handles particles
/obj/item/boombox/proc/stop_music(mob/user)
	if(!boombox_audio)
		return
	boombox_audio.stop()
	boombox_audio = null

	if(music_particles)
		QDEL_NULL(music_particles)
	icon_state = "boombox"
	update_appearance()
