// Picture frames

/obj/item/wallframe/picture
	name = "相框"
	desc = "用来展示你最爱的死亡陷阱回忆的完美展架。"
	icon = 'icons/obj/signs.dmi'
	custom_materials = list(/datum/material/wood =SHEET_MATERIAL_AMOUNT)
	resistance_flags = FLAMMABLE
	flags_1 = 0
	icon_state = "frame-overlay"
	result_path = /obj/structure/sign/picture_frame
	var/obj/item/photo/displayed
	pixel_shift = 30

/obj/item/wallframe/picture/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/photo))
		return NONE
	if(displayed)
		to_chat(user, span_warning("\The [src] 里已经有一张照片了。"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	displayed = tool
	update_appearance()
	return ITEM_INTERACT_SUCCESS

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/wallframe/picture/attack_hand(mob/user, list/modifiers)
	if(user.get_inactive_held_item() != src)
		..()
		return
	if(contents.len)
		var/obj/item/I = pick(contents)
		user.put_in_hands(I)
		to_chat(user, span_notice("你小心地把照片从 \the [src] 里取了出来。"))
		displayed = null
		update_appearance()
	return ..()

/obj/item/wallframe/picture/attack_self(mob/user)
	user.examinate(src)

/obj/item/wallframe/picture/examine(mob/user)
	if(user.is_holding(src) && displayed)
		displayed.show(user)
		return list()
	else
		return ..()

/obj/item/wallframe/picture/update_overlays()
	. = ..()
	if(displayed)
		. += displayed

/obj/item/wallframe/picture/after_attach(obj/O)
	..()
	var/obj/structure/sign/picture_frame/PF = O
	PF.copy_overlays(src)
	if(displayed)
		PF.set_and_save_framed(displayed)
	if(contents.len)
		var/obj/item/I = pick(contents)
		I.forceMove(PF)

/obj/structure/sign/picture_frame
	name = "相框"
	desc = "每次看到它都会让你发笑。"
	icon = 'icons/obj/signs.dmi'
	icon_state = "frame-overlay"
	custom_materials = list(/datum/material/wood =SHEET_MATERIAL_AMOUNT)
	resistance_flags = FLAMMABLE
	var/obj/item/photo/framed
	var/persistence_id
	var/art_value = OK_ART
	var/can_decon = TRUE

/obj/structure/sign/picture_frame/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/art, art_value)
	if (!SSpersistence.initialized)
		LAZYADD(SSpersistence.queued_photo_frames, src)

/obj/structure/sign/picture_frame/Destroy()
	LAZYREMOVE(SSpersistence.queued_photo_frames, src)
	return ..()

/obj/structure/sign/picture_frame/proc/get_photo_id()
	if(istype(framed) && istype(framed.picture))
		return framed.picture.id

//Manual loading, DO NOT USE FOR HARDCODED/MAPPED IN ALBUMS. This is for if an album needs to be loaded mid-round from an ID.
/obj/structure/sign/picture_frame/proc/persistence_load()
	var/list/data = SSpersistence.photo_frames_database.get_key(persistence_id)
	if(!isnull(data))
		load_from_id(data)

/obj/structure/sign/picture_frame/proc/load_from_id(id)
	var/obj/item/photo/old/P = load_photo_from_disk(id)
	if(istype(P))
		if(istype(framed))
			framed.forceMove(drop_location())
		else
			qdel(framed)
		framed = P
		update_appearance()

/// Given a photo (or null), will change the contained picture, and queue a persistent save.
/obj/structure/sign/picture_frame/proc/set_and_save_framed(obj/item/photo/photo)
	framed = photo

	if (isnull(persistence_id))
		return

	SSpersistence.photo_frames_database.set_key(persistence_id, photo?.picture?.id)

/obj/structure/sign/picture_frame/examine(mob/user)
	. = ..()
	if(in_range(src, user))
		framed?.show(user)

/// Internal proc
/obj/structure/sign/picture_frame/proc/try_deconstruct(mob/living/user, obj/item/tool)
	if(!can_decon)
		return FALSE
	to_chat(user, span_notice("你开始松开 [name] 的固定……"))
	if(tool.use_tool(src, user, 3 SECONDS, volume=50))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		to_chat(user, span_notice("你松开了 [name] 的固定。"))
		deconstruct()
	return TRUE

/obj/structure/sign/picture_frame/screwdriver_act(mob/living/user, obj/item/tool)
	return try_deconstruct(user, tool)

/obj/structure/sign/picture_frame/wrench_act(mob/living/user, obj/item/tool)
	return try_deconstruct(user, tool)

/obj/structure/sign/picture_frame/wirecutter_act(mob/living/user, obj/item/tool)
	if (!framed)
		return FALSE
	tool.play_tool_sound(src)
	framed.forceMove(drop_location())
	user.visible_message(span_warning("[user] 把 [framed] 从 [src] 上割了下来！"))
	set_and_save_framed(null)
	update_appearance()
	return ITEM_INTERACT_SUCCESS


/obj/structure/sign/picture_frame/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/photo))
		return NONE
	if(framed)
		to_chat(user, span_warning("\The [src] 里已经有一张照片了。"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	set_and_save_framed(tool)
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/sign/picture_frame/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(framed)
		framed.show(user)

/obj/structure/sign/picture_frame/update_overlays()
	. = ..()
	if(framed)
		. += framed

/obj/structure/sign/picture_frame/atom_deconstruct(disassembled = TRUE)
	var/obj/item/wallframe/picture/showcase = new /obj/item/wallframe/picture(loc)
	if(framed)
		showcase.displayed = framed
		set_and_save_framed(null)
	if(contents.len)
		var/obj/item/I = pick(contents)
		I.forceMove(showcase)
	showcase.update_appearance()

/obj/structure/sign/picture_frame/showroom
	name = "杰出船员展示框"
	desc = "用来纪念在执行公务中表现杰出的船员的相框。警告：未经许可擅自改动者将受到严厉惩处。"
	can_decon = FALSE

/// This used to be a plaque portrait of a monkey. Now it's been revamped into something more.
/obj/structure/sign/picture_frame/portrait
	icon_state = "frame-monkey"
	can_decon = FALSE
	art_value = GOOD_ART
	var/portrait_name
	var/portrait_state
	var/portrait_desc

/obj/structure/sign/picture_frame/portrait/Initialize(mapload)
	. = ..()
	switch(rand(1,4))
		if(1) // Deempisi
			name = "\improper 迪姆皮西先生肖像"
			icon_state = "frame-monkey"
			desc = "肖像下方的铭牌上写着：“绞肉机也许没能放过你，但别担心。你身上没有一处被浪费……你很好吃。”"
		if(2) // A fruit
			name = "水果画像"
			icon_state = "frame-fruit"
			desc = "<i>这不是一颗橙子。</i>"
		if(3) // Rat
			name = "\improper 汤姆肖像"
			desc = "杰瑞猫依然兴致寥寥。"
			icon_state = "frame-rat"
		if(4) // Ratvar
			name = "被囚之神的肖像"
			desc = "肖像下方的铭牌上写着：“深切缅怀拉特瓦，古老而强大的存在，纳尔西的宿敌，\
				最终在 17 号前哨站船员的手中，被纳米传讯的蓝空间火炮击倒。愿它安息于锈蚀之中。”" // common core lore.
			icon_state = "frame-ratvar"
	portrait_name = name
	portrait_state = icon_state
	portrait_desc = desc

/obj/structure/sign/picture_frame/portrait/update_name(updates)
	if(framed)
		name = initial(name)
	else
		name = portrait_name
	return ..()

/obj/structure/sign/picture_frame/portrait/update_icon_state(updates)
	. = ..()
	if(framed)
		icon_state = "frame-overlay"
	else
		icon_state = portrait_state

/obj/structure/sign/picture_frame/portrait/update_desc(updates)
	. = ..()
	if(framed)
		desc = "每次看到它都会让你发笑。"
	else
		desc = portrait_desc

/obj/structure/sign/picture_frame/portrait/examine_more(mob/user)
	. = ..()
	if(!framed)
		. += span_notice("相框和画片被粘在了一起，不过你觉得也许还能把一张照片塞进两者之间。")

//persistent frames, make sure the same ID doesn't appear more than once per map
/obj/structure/sign/picture_frame/showroom/one
	persistence_id = "frame_showroom1"

/obj/structure/sign/picture_frame/showroom/two
	persistence_id = "frame_showroom2"

/obj/structure/sign/picture_frame/showroom/three
	persistence_id = "frame_showroom3"

/obj/structure/sign/picture_frame/showroom/four
	persistence_id = "frame_showroom4"

// for the hall of fame escape shuttle
/obj/structure/sign/picture_frame/hall_of_fame/one
	persistence_id = "frame_hall_of_fame_1"

/obj/structure/sign/picture_frame/hall_of_fame/two
	persistence_id = "frame_hall_of_fame_2"

/obj/structure/sign/picture_frame/hall_of_fame/three
	persistence_id = "frame_hall_of_fame_3"

/obj/structure/sign/picture_frame/hall_of_fame/four
	persistence_id = "frame_hall_of_fame_4"

/obj/structure/sign/picture_frame/portrait/bar
	persistence_id = "frame_bar"

///Generates a persistence id unique to the current map. Every bar should feel a little bit different after all.
/obj/structure/sign/picture_frame/portrait/bar/Initialize(mapload)
	if(SSmapping.current_map.map_path != CUSTOM_MAP_PATH) //skip adminloaded custom maps.
		persistence_id = "frame_bar_[SSmapping.current_map.map_name]"
	return ..()
