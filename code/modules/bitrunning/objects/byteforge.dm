/obj/machinery/byteforge
	name = "字节锻造机"

	circuit = /obj/item/circuitboard/machine/byteforge
	desc = "一台由量子服务器使用的机器。量子代码在此汇聚，从虚拟深渊中实体化出解密后的资产。"
	icon = 'icons/obj/machines/bitrunning.dmi'
	icon_state = "byteforge"
	base_icon_state = "byteforge"
	obj_flags = BLOCKS_CONSTRUCTION | CAN_BE_HIT
	/// Idle particles
	var/mutable_appearance/byteforge_particles

/obj/machinery/byteforge/Initialize(mapload)
	. = ..()

	register_context()

/obj/machinery/byteforge/post_machine_initialize()
	. = ..()

	setup_particles()

/obj/machinery/byteforge/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = NONE
	if(isnull(held_item))
		return

	if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
		context[SCREENTIP_CONTEXT_LMB] = "[panel_open ? "关闭" : "打开"]面板"
		return CONTEXTUAL_SCREENTIP_SET
	else if(held_item.tool_behaviour == TOOL_CROWBAR && panel_open)
		context[SCREENTIP_CONTEXT_LMB] = "拆解"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/byteforge/examine(mob/user)
	. = ..()

	. += span_notice("必须位于量子服务器 4 格范围内。")

	. += span_notice("其维护面板可被 [EXAMINE_HINT("用螺丝刀")] [panel_open ? "关闭" : "打开"]。")
	if(panel_open)
		. += span_notice("可以用 [EXAMINE_HINT("撬棍")] 将其拆开。")

/obj/machinery/byteforge/update_appearance(updates)
	. = ..()

	setup_particles()

/obj/machinery/byteforge/screwdriver_act(mob/living/user, obj/item/screwdriver)
	return default_deconstruction_screwdriver(user, screwdriver)

/obj/machinery/byteforge/crowbar_act(mob/living/user, obj/item/crowbar)
	return default_deconstruction_crowbar(user, crowbar)

/obj/machinery/byteforge/update_icon_state()
	. = ..()
	icon_state = panel_open ? "[base_icon_state]_panel" : base_icon_state

/// Does some sparks after it's done
/obj/machinery/byteforge/proc/flash(atom/movable/thing)
	playsound(src, 'sound/effects/magic/blink.ogg', 50, TRUE)

	do_sparks(5, TRUE, loc, spark_type = /datum/effect_system/basic/spark_spread/quantum)
	set_light(l_on = FALSE)

/// Forge begins to process
/obj/machinery/byteforge/proc/flicker(angry = FALSE)
	var/mutable_appearance/lighting = mutable_appearance(initial(icon), "on_overlay[angry ? "_angry" : ""]")
	flick_overlay_view(lighting, 1 SECONDS)

	set_light(l_range = 2, l_power = 1.5, l_color = angry ? LIGHT_COLOR_BUBBLEGUM : LIGHT_COLOR_BABY_BLUE, l_on = TRUE)

/// Adds the particle overlays to the byteforge
/obj/machinery/byteforge/proc/setup_particles(angry = FALSE)
	cut_overlay(byteforge_particles)

	byteforge_particles = mutable_appearance(initial(icon), "on_particles[angry ? "_angry" : ""]", ABOVE_MOB_LAYER)

	if(is_operational)
		add_overlay(byteforge_particles)

/// Forge is done processing
/obj/machinery/byteforge/proc/spawn_cache(obj/cache)
	if(QDELETED(cache))
		return

	flash()

	cache.forceMove(loc)

/// Timed flash
/obj/machinery/byteforge/proc/start_to_spawn(obj/cache)
	flicker()

	addtimer(CALLBACK(src, PROC_REF(spawn_cache), cache), 1 SECONDS)
