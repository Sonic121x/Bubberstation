/obj/machinery/door/poddoor
	name = "防爆门"
	desc = "采用机械方式开启的重型防爆门。"
	icon = 'icons/obj/doors/blastdoor.dmi' //ICON OVERRIDDEN IN SKYRAT AESTHETICS - SEE MODULE
	icon_state = "closed"
	layer = BLASTDOOR_LAYER
	closingLayer = CLOSED_BLASTDOOR_LAYER
	sub_door = TRUE
	explosion_block = 3
	heat_proof = TRUE
	safe = FALSE
	max_integrity = 600
	armor_type = /datum/armor/door_poddoor
	resistance_flags = FIRE_PROOF
	damage_deflection = 70
	can_open_with_hands = FALSE
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 15, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	/// The recipe for this door
	var/datum/crafting_recipe/recipe_type = /datum/crafting_recipe/blast_doors
	/// The current deconstruction step
	var/deconstruction = BLASTDOOR_FINISHED
	/// The door's ID (used for buttons, etc to control the door)
	var/id = null
	/// The sound that plays when the door opens/closes
	var/animation_sound = 'sound/machines/blastdoor.ogg'
	var/show_nav_computer_icon = TRUE
	///The mob who crafted this blastdoor
	var/datum/weakref/owner

/obj/machinery/door/poddoor/Initialize(mapload)
	. = ..()
	if(show_nav_computer_icon)
		AddElement(/datum/element/nav_computer_icon, 'icons/effects/nav_computer_indicators.dmi', "airlock", TRUE)

/obj/machinery/door/poddoor/Destroy()
	owner = null
	return ..()

/datum/armor/door_poddoor
	melee = 50
	bullet = 100
	laser = 100
	energy = 100
	bomb = 50
	fire = 100
	acid = 70

/obj/machinery/door/poddoor/get_save_vars()
	return ..() + NAMEOF(src, id)

/obj/machinery/door/poddoor/examine(mob/user)
	. = ..()
	if(panel_open)
		if(deconstruction == BLASTDOOR_FINISHED)
			. += span_notice("维护面板已打开，可以<b>撬出</b>电子组件。")
			. += span_notice("可以用<b>防爆门控制器</b>将[src]校准为该控制器的 ID。")
		else if(deconstruction == BLASTDOOR_NEEDS_ELECTRONICS)
			. += span_notice("缺少<i>电子组件</i>，有一些<b>电线</b>露在外面。")
		else if(deconstruction == BLASTDOOR_NEEDS_WIRES)
			. += span_notice("<i>电线</i>已拆除，可以将它<b>切开</b>了。")

/obj/machinery/door/poddoor/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		return NONE
	if(deconstruction == BLASTDOOR_NEEDS_WIRES && istype(held_item, /obj/item/stack/cable_coil))
		context[SCREENTIP_CONTEXT_LMB] = "给框架布线"
		return CONTEXTUAL_SCREENTIP_SET
	if(deconstruction == BLASTDOOR_NEEDS_ELECTRONICS && istype(held_item, /obj/item/electronics/airlock))
		context[SCREENTIP_CONTEXT_LMB] = "安装电子组件"
		return CONTEXTUAL_SCREENTIP_SET
	if(deconstruction == BLASTDOOR_FINISHED && istype(held_item, /obj/item/assembly/control/blast_door))
		context[SCREENTIP_CONTEXT_LMB] = "校准 ID"
		return CONTEXTUAL_SCREENTIP_SET
	//we do not check for special effects like if they can actually perform the action because they will be told they can't do it when they try,
	//with feedback on what they have to do in order to do so.
	switch(held_item.tool_behaviour)
		if(TOOL_SCREWDRIVER)
			context[SCREENTIP_CONTEXT_LMB] = "打开面板"
			return CONTEXTUAL_SCREENTIP_SET
		if(TOOL_CROWBAR)
			context[SCREENTIP_CONTEXT_LMB] = "拆除电子组件"
			return CONTEXTUAL_SCREENTIP_SET
		if(TOOL_WIRECUTTER)
			context[SCREENTIP_CONTEXT_LMB] = "拆除电线"
			return CONTEXTUAL_SCREENTIP_SET
		if(TOOL_WELDER)
			context[SCREENTIP_CONTEXT_LMB] = "拆解"
			return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/door/poddoor/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	owner = WEAKREF(crafter)

/obj/machinery/door/poddoor/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(deconstruction == BLASTDOOR_NEEDS_WIRES && istype(tool, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/coil = tool
		var/datum/crafting_recipe/recipe = locate(recipe_type) in GLOB.crafting_recipes
		var/amount_needed = recipe.reqs[/obj/item/stack/cable_coil]
		if(coil.get_amount() < amount_needed)
			balloon_alert(user, "电缆不足！")
			return ITEM_INTERACT_SUCCESS
		balloon_alert(user, "正在安装电缆……")
		if(!do_after(user, 5 SECONDS, src))
			return ITEM_INTERACT_SUCCESS
		coil.use(amount_needed)
		deconstruction = BLASTDOOR_NEEDS_ELECTRONICS
		balloon_alert(user, "电缆已安装")
		return ITEM_INTERACT_SUCCESS

	if(deconstruction == BLASTDOOR_NEEDS_ELECTRONICS && istype(tool, /obj/item/electronics/airlock))
		balloon_alert(user, "正在安装电子组件……")
		if(!do_after(user, 10 SECONDS, src))
			return ITEM_INTERACT_SUCCESS
		qdel(tool)
		balloon_alert(user, "电子组件已安装")
		deconstruction = BLASTDOOR_FINISHED
		return ITEM_INTERACT_SUCCESS

	if(deconstruction == BLASTDOOR_FINISHED && istype(tool, /obj/item/assembly/control/blast_door))
		if(density)
			balloon_alert(user, "请先开门！")
			return ITEM_INTERACT_BLOCKING
		if(!panel_open)
			balloon_alert(user, "请先打开面板！")
			return ITEM_INTERACT_BLOCKING
		var/obj/item/assembly/control/blast_door/controller_item = tool
		if(controller_item.id == -1)
			//collect existing ids
			var/list/door_ids = list()
			for(var/obj/machinery/door/poddoor/M as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/poddoor))
				if(!M.id || (M.id in door_ids))
					continue
				door_ids += "[M.id]"

			//create new id
			var/new_id = 0
			while("[new_id]" in door_ids)
				new_id += 1
			controller_item.id = "[new_id]"
		id = controller_item.id
		owner = WEAKREF(user)
		balloon_alert(user, "ID 已更改为 [id]")
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/door/poddoor/screwdriver_act(mob/living/user, obj/item/tool)
	if (density)
		balloon_alert(user, "请先开门！")
		return ITEM_INTERACT_SUCCESS

	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/door/poddoor/crowbar_act(mob/living/user, obj/item/tool)
	if(machine_stat & NOPOWER)
		open(TRUE)
		return ITEM_INTERACT_SUCCESS
	if (density)
		balloon_alert(user, "请先开门！")
		return ITEM_INTERACT_BLOCKING
	if (!panel_open)
		balloon_alert(user, "请先打开面板！")
		return ITEM_INTERACT_BLOCKING
	if (deconstruction != BLASTDOOR_FINISHED)
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "正在拆除气闸电子组件……")
	if(tool.use_tool(src, user, 10 SECONDS, volume = 50))
		new /obj/item/electronics/airlock(loc)
		id = null
		owner = null
		deconstruction = BLASTDOOR_NEEDS_ELECTRONICS
		balloon_alert(user, "气闸电子组件已拆除")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/door/poddoor/wirecutter_act(mob/living/user, obj/item/tool)
	if (density)
		balloon_alert(user, "请先开门！")
		return ITEM_INTERACT_BLOCKING
	if (!panel_open)
		balloon_alert(user, "请先打开面板！")
		return ITEM_INTERACT_BLOCKING
	if (deconstruction != BLASTDOOR_NEEDS_ELECTRONICS)
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "正在拆除内部电缆……")
	if(tool.use_tool(src, user, 10 SECONDS, volume = 50))
		var/datum/crafting_recipe/recipe = locate(recipe_type) in GLOB.crafting_recipes
		var/amount = recipe.reqs[/obj/item/stack/cable_coil]
		new /obj/item/stack/cable_coil(loc, amount)
		deconstruction = BLASTDOOR_NEEDS_WIRES
		balloon_alert(user, "内部电缆已拆除")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/door/poddoor/welder_act(mob/living/user, obj/item/tool)
	. = ..()
	if (density)
		balloon_alert(user, "请先开门！")
		return ITEM_INTERACT_SUCCESS
	if (!panel_open)
		balloon_alert(user, "请先打开面板！")
		return ITEM_INTERACT_SUCCESS
	if (deconstruction != BLASTDOOR_NEEDS_WIRES)
		return
	balloon_alert(user, "正在拆解……") //You're tearing me apart, Lisa!
	if(tool.use_tool(src, user, 15 SECONDS, volume = 50))
		var/datum/crafting_recipe/recipe = locate(recipe_type) in GLOB.crafting_recipes
		var/amount = recipe.reqs[/obj/item/stack/sheet/plasteel]
		new /obj/item/stack/sheet/plasteel(loc, amount)
		user.balloon_alert(user, "已拆解")
		qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/door/poddoor/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	id = "[port.shuttle_id]_[id]"

//"BLAST" doors are obviously stronger than regular doors when it comes to BLASTS.
/obj/machinery/door/poddoor/ex_act(severity, target)
	if(severity <= EXPLODE_LIGHT)
		return FALSE
	return ..()

/obj/machinery/door/poddoor/update_icon_state()
	. = ..()
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			icon_state = "opening"
		if(DOOR_CLOSING_ANIMATION)
			icon_state = "closing"
		if(DOOR_DENY_ANIMATION)
			icon_state = "deny"
		else
			icon_state = density ? "closed" : "open"

/obj/machinery/door/poddoor/animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 1.1 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 1.1 SECONDS

/obj/machinery/door/poddoor/animation_segment_delay(animation)
	switch(animation)
		if(DOOR_OPENING_PASSABLE)
			return 0.5 SECONDS
		if(DOOR_OPENING_FINISHED)
			return 1.1 SECONDS
		if(DOOR_CLOSING_UNPASSABLE)
			return 0.2 SECONDS
		if(DOOR_CLOSING_FINISHED)
			return 1.1 SECONDS

/obj/machinery/door/poddoor/animation_effects(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			playsound(src, animation_sound, 50, TRUE)
		if(DOOR_CLOSING_ANIMATION)
			playsound(src, animation_sound, 50, TRUE)

/obj/machinery/door/poddoor/attack_alien(mob/living/carbon/alien/adult/user, list/modifiers)
	if(density & !(resistance_flags & INDESTRUCTIBLE))
		add_fingerprint(user)
		user.visible_message(span_warning("[user]开始撬开[src]。"),\
					span_noticealien("你开始使出全力，将利爪嵌入[src]！"),\
					span_warning("你听见金属扭曲的呻吟声……"))
		playsound(src, 'sound/machines/airlock/airlock_alien_prying.ogg', 100, TRUE)

		var/time_to_open = 5 SECONDS
		if(hasPower())
			time_to_open = 15 SECONDS

		if(do_after(user, time_to_open, src))
			if(density && !open(TRUE)) //The airlock is still closed, but something prevented it opening. (Another player noticed and bolted/welded the airlock in time!)
				to_chat(user, span_warning("尽管你竭尽全力，[src]仍然没有被打开！"))

	else
		return ..()

/obj/machinery/door/poddoor/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/ert
	name = "强化防爆门"
	desc = "只在极端紧急情况下开启的重型防爆门。"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

//special poddoors that open when emergency shuttle docks at centcom
/obj/machinery/door/poddoor/shuttledock
	var/checkdir = 4 //door won't open if turf in this dir is `turftype`
	var/turftype = /turf/open/space

/obj/machinery/door/poddoor/shuttledock/proc/check()
	var/turf/turf = get_step(src, checkdir)
	if(!istype(turf, turftype))
		INVOKE_ASYNC(src, PROC_REF(open))
	else
		INVOKE_ASYNC(src, PROC_REF(close))

/obj/machinery/door/poddoor/incinerator_ordmix
	name = "燃烧室通风口"
	id = INCINERATOR_ORDMIX_VENT

/obj/machinery/door/poddoor/incinerator_atmos_main
	name = "涡轮机通风口"
	id = INCINERATOR_ATMOS_MAINVENT

/obj/machinery/door/poddoor/incinerator_atmos_aux
	name = "燃烧室通风口"
	id = INCINERATOR_ATMOS_AUXVENT

/obj/machinery/door/poddoor/atmos_test_room_mainvent_1
	name = "一号测试室通风口"
	id = TEST_ROOM_ATMOS_MAINVENT_1

/obj/machinery/door/poddoor/atmos_test_room_mainvent_2
	name = "二号测试室通风口"
	id = TEST_ROOM_ATMOS_MAINVENT_2

/obj/machinery/door/poddoor/incinerator_syndicatelava_main
	name = "涡轮机通风口"
	id = INCINERATOR_SYNDICATELAVA_MAINVENT

/obj/machinery/door/poddoor/incinerator_syndicatelava_aux
	name = "燃烧室通风口"
	id = INCINERATOR_SYNDICATELAVA_AUXVENT

/obj/machinery/door/poddoor/massdriver_ordnance
	name = "军械发射舱门"
	id = MASSDRIVER_ORDNANCE

/obj/machinery/door/poddoor/massdriver_chapel
	name = "教堂发射舱门"
	id = MASSDRIVER_CHAPEL

/obj/machinery/door/poddoor/massdriver_trash
	name = "废物处理发射舱门"
	id = MASSDRIVER_DISPOSALS
