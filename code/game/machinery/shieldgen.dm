/obj/structure/emergency_shield
	name = "应急能量护盾"
	desc = "用于封堵船体破口的能量护盾。"
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield-old"
	integrity_failure = 0.5
	density = TRUE
	move_resist = INFINITY
	opacity = FALSE
	anchored = TRUE
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	max_integrity = 200 //The shield can only take so much beating (prevents perma-prisons)
	can_atmos_pass = ATMOS_PASS_DENSITY

/obj/structure/emergency_shield/Initialize(mapload)
	. = ..()
	setDir(pick(GLOB.cardinals))
	air_update_turf(TRUE, TRUE)

/obj/structure/emergency_shield/Destroy()
	air_update_turf(TRUE, FALSE)
	. = ..()

/obj/structure/emergency_shield/Move()
	var/turf/T = loc
	. = ..()
	move_update_air(T)

/obj/structure/emergency_shield/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			qdel(src)
		if(2)
			take_damage(50, BRUTE, ENERGY, 0)

/obj/structure/emergency_shield/play_attack_sound(damage, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BURN)
			playsound(loc, 'sound/effects/empulse.ogg', 75, TRUE)
		if(BRUTE)
			playsound(loc, 'sound/effects/empulse.ogg', 75, TRUE)

/obj/structure/emergency_shield/take_damage(damage, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(.) //damage was dealt
		new /obj/effect/temp_visual/impact_effect/ion(loc)

/// Subtype of shields that repair over time after sustaining integrity damage
/obj/structure/emergency_shield/regenerating
	name = "能量护盾"
	desc = "允许舰船通过，却能隔绝太空真空的能量护盾。"
	max_integrity = 400
	/// How much integrity is healed per second (per process multiplied by seconds per tick)
	var/heal_rate_per_second = 5

/obj/structure/emergency_shield/regenerating/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_NO_EXAMINE)

/obj/structure/emergency_shield/regenerating/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/emergency_shield/regenerating/take_damage(damage, damage_type, damage_flag, sound_effect, attack_dir)
	. = ..()
	if(.)
		// We took some damage so we'll start processing to heal said damage.
		START_PROCESSING(SSobj, src)

/obj/structure/emergency_shield/regenerating/process(seconds_per_tick)
	var/repaired_amount = repair_damage(heal_rate_per_second * seconds_per_tick)
	if(repaired_amount <= 0)
		// 0 damage repaired means we're at the max integrity, so don't need to process anymore
		STOP_PROCESSING(SSobj, src)

/obj/structure/emergency_shield/cult
	name = "血教屏障"
	desc = "血教徒召唤的护盾，用于阻挡异端。"
	max_integrity = 100
	icon_state = "shield-red"

/obj/structure/emergency_shield/cult/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_NO_EXAMINE)

/obj/structure/emergency_shield/cult/narsie
	name = "鲜血屏障"
	desc = "血教徒召唤的强力护盾，用于保护他们的仪式。"
	max_integrity = 60

/obj/structure/emergency_shield/cult/weak
	name = "咏唱者护盾"
	desc = "血教徒召唤的脆弱护盾，用于在进行精细仪式时保护他们。"
	color = COLOR_RED
	max_integrity = 20
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = ABOVE_MOB_LAYER

/obj/structure/emergency_shield/cult/barrier
	density = FALSE //toggled on right away by the parent rune
	can_atmos_pass = ATMOS_PASS_DENSITY
	///The rune that created the shield itself. Used to delete the rune when the shield is destroyed.
	var/obj/effect/rune/parent_rune

/obj/structure/emergency_shield/cult/barrier/attack_hand(mob/living/user, list/modifiers)
	parent_rune.attack_hand(user, modifiers)

/obj/structure/emergency_shield/cult/barrier/attack_animal(mob/living/simple_animal/user, list/modifiers)
	if(IS_CULTIST(user))
		parent_rune.attack_animal(user)
	else
		..()

/obj/structure/emergency_shield/cult/barrier/Destroy()
	if(parent_rune)
		if(QDELING(parent_rune))
			parent_rune = null
			return ..()
		parent_rune.visible_message(span_danger("随着[src]被摧毁，[parent_rune]消散了！"))
		QDEL_NULL(parent_rune)
	return ..()

/**
*Turns the shield on and off.
*
*The shield has 2 states: on and off. When on, it will block movement,projectiles, items, etc. and be clearly visible, and block atmospheric gases.
*When off, the rune no longer blocks anything and turns invisible.
*The barrier itself is not intended to interact with the conceal runes cult spell for balance purposes.
*/
/obj/structure/emergency_shield/cult/barrier/proc/Toggle()
	set_density(!density)
	air_update_turf(TRUE, !density)
	if(!density)
		SetInvisibility(INVISIBILITY_OBSERVER, id=type)
	else
		RemoveInvisibility(type)

/obj/machinery/shieldgen
	name = "破口封堵护盾投射器"
	desc = "用于封堵小型船体破口。"
	icon = 'icons/obj/machines/shield_generator.dmi'
	icon_state = "shieldoff"
	density = TRUE
	opacity = FALSE
	anchored = FALSE
	pressure_resistance = 2*ONE_ATMOSPHERE
	req_access = list(ACCESS_ENGINEERING)
	max_integrity = 100
	var/active = FALSE
	var/list/deployed_shields
	var/locked = FALSE
	var/shield_range = 4

/obj/machinery/shieldgen/Initialize(mapload)
	. = ..()
	deployed_shields = list()
	if(mapload && active && anchored)
		shields_up()

/obj/machinery/shieldgen/Destroy()
	QDEL_LIST(deployed_shields)
	return ..()


/obj/machinery/shieldgen/proc/shields_up()
	active = TRUE
	update_appearance()
	move_resist = INFINITY

	for(var/turf/target_tile as anything in RANGE_TURFS(shield_range, src))
		if(isspaceturf(target_tile) && !(locate(/obj/structure/emergency_shield) in target_tile))
			if(!(machine_stat & BROKEN) || prob(33))
				deployed_shields += new /obj/structure/emergency_shield(target_tile)

/obj/machinery/shieldgen/proc/shields_down()
	active = FALSE
	move_resist = initial(move_resist)
	update_appearance()
	QDEL_LIST(deployed_shields)

/obj/machinery/shieldgen/process(seconds_per_tick)
	if((machine_stat & BROKEN) && active)
		if(deployed_shields.len && SPT_PROB(2.5, seconds_per_tick))
			qdel(pick(deployed_shields))

/obj/machinery/shieldgen/interact(mob/user)
	. = ..()
	if(.)
		return
	if(locked && !HAS_SILICON_ACCESS(user))
		to_chat(user, span_warning("机器已锁定，你无法使用！"))
		return
	if(panel_open)
		to_chat(user, span_warning("必须关上面板才能操作机器！"))
		return

	if (active)
		user.visible_message(span_notice("[user]关闭了[src]。"), \
			span_notice("你关闭了[src]。"), \
			span_hear("你听见低沉的嗡鸣声渐渐消失。"))
		shields_down()
	else
		if(anchored)
			user.visible_message(span_notice("[user]启动了[src]。"), \
				span_notice("你启动了[src]。"), \
				span_hear("你听见低沉的嗡鸣声。"))
			shields_up()
		else
			to_chat(user, span_warning("必须先将设备固定在地板上！"))
	return

/obj/machinery/shieldgen/screwdriver_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src, 100)
	toggle_panel_open()
	if(panel_open)
		to_chat(user, span_notice("你打开面板，露出线路。"))
	else
		to_chat(user, span_notice("你关上了面板。"))
	return TRUE

/obj/machinery/shieldgen/wrench_act(mob/living/user, obj/item/tool)
	. = TRUE
	if(locked)
		to_chat(user, span_warning("螺栓被护盖挡住了！解锁后护盖就会缩回。"))
		return
	if(!anchored && !isinspace())
		tool.play_tool_sound(src, 100)
		balloon_alert(user, "已固定")
		set_anchored(TRUE)
	else if(anchored)
		tool.play_tool_sound(src, 100)
		balloon_alert(user, "已解除固定")
		if(active)
			to_chat(user, span_notice("[src]关闭了！"))
			shields_down()
		set_anchored(FALSE)


/obj/machinery/shieldgen/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stack/cable_coil) && (machine_stat & BROKEN) && panel_open)
		var/obj/item/stack/cable_coil/coil = tool
		if (coil.get_amount() < 1)
			to_chat(user, span_warning("修理[src]需要一段电缆！"))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你开始更换线路……"))
		if(!do_after(user, 3 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING
		if(coil.get_amount() < 1)
			return ITEM_INTERACT_BLOCKING
		coil.use(1)
		atom_integrity = max_integrity
		set_machine_stat(machine_stat & ~BROKEN)
		to_chat(user, span_notice("你修好了[src]。"))
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(tool.GetID())
		if(obj_flags & EMAGGED)
			to_chat(user, span_danger("错误，权限控制器已损坏！"))
			return ITEM_INTERACT_BLOCKING
		if(!allowed(user))
			to_chat(user, span_danger("拒绝访问。"))
			return ITEM_INTERACT_BLOCKING
		locked = !locked
		to_chat(user, span_notice("你[locked ? "锁定" : "解锁"]了控制面板。"))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/shieldgen/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		to_chat(user, span_warning("权限控制器已损坏！"))
		return FALSE
	obj_flags |= EMAGGED
	locked = FALSE
	playsound(src, SFX_SPARKS, 100, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	balloon_alert(user, "权限控制器已短路")
	return TRUE

/obj/machinery/shieldgen/update_icon_state()
	icon_state = "shield[active ? "on" : "off"][(machine_stat & BROKEN) ? "br" : null]"
	return ..()

#define ACTIVE_SETUPFIELDS 1
#define ACTIVE_HASFIELDS 2
/obj/machinery/power/shieldwallgen
	name = "护盾墙发生器"
	desc = "一台护盾发生器。"
	icon = 'icons/obj/machines/shield_generator.dmi'
	icon_state = "shield_wall_gen"
	base_icon_state = "shield_wall_gen"
	light_on = FALSE
	light_range = 2.5
	light_power = 2
	light_color = LIGHT_COLOR_BLUE
	anchored = FALSE
	density = TRUE
	req_access = list(ACCESS_TELEPORTER)
	obj_flags = CONDUCTS_ELECTRICITY
	use_power = NO_POWER_USE
	active_power_usage = 150
	circuit = /obj/item/circuitboard/machine/shieldwallgen
	max_integrity = 300
	/// whether the shield generator is active, ACTIVE_SETUPFIELDS will make it search for generators on process, and if that is successful, is set to ACTIVE_HASFIELDS
	var/active = FALSE
	/// are we locked?
	var/locked = TRUE
	/// how far do we seek another generator in our cardinal directions
	var/shield_range = 8
	/// the attached cable under us
	var/obj/structure/cable/attached

/obj/machinery/power/shieldwallgen/xenobiologyaccess //use in xenobiology containment
	name = "异种生物学护盾墙发生器"
	desc = "专为异种生物学研究设计的护盾发生器。"
	req_access = list(ACCESS_XENOBIOLOGY)

/obj/machinery/power/shieldwallgen/anchored
	anchored = TRUE

/obj/machinery/power/shieldwallgen/unlocked //for use in ruins, etc
	locked = FALSE
	req_access = null

/obj/machinery/power/shieldwallgen/unlocked/anchored
	anchored = TRUE

/obj/machinery/power/shieldwallgen/Initialize(mapload)
	. = ..()
	//Add to the early process queue to prioritize power draw
	SSmachines.processing_early += src
	if(anchored)
		connect_to_network()
	RegisterSignal(src, COMSIG_ATOM_SINGULARITY_TRY_MOVE, PROC_REF(block_singularity_if_active))
	set_wires(new /datum/wires/shieldwallgen(src))

/obj/machinery/power/shieldwallgen/update_appearance(updates)
	. = ..()
	set_light(l_on = !!active)

/obj/machinery/power/shieldwallgen/update_icon_state()
	icon_state = "[base_icon_state][active ? "_on" : ""]"
	return ..()

/obj/machinery/power/shieldwallgen/update_overlays()
	. = ..()
	if(!panel_open)
		return
	. += "shieldgen_wires"

/obj/machinery/power/shieldwallgen/Destroy()
	for(var/d in GLOB.cardinals)
		cleanup_field(d)
	return ..()

/obj/machinery/power/shieldwallgen/should_have_node()
	return anchored

/obj/machinery/power/shieldwallgen/connect_to_network()
	if(!anchored)
		return FALSE
	. = ..()

/obj/machinery/power/shieldwallgen/process_early()
	if(active)
		if(active == ACTIVE_SETUPFIELDS)
			var/fields = 0
			for(var/d in GLOB.cardinals)
				if(setup_field(d))
					fields++
			if(fields)
				active = ACTIVE_HASFIELDS
			update_appearance()
		if(!active_power_usage || surplus() >= active_power_usage)
			add_load(active_power_usage)
		else
			visible_message(span_danger("[src]因电力不足而关闭！"), \
				"如果你看到了这条消息，说明出了问题。",
				span_hear("你听见低沉的嗡鸣声渐渐消失。"))
			deactivate()
			log_game("[src] deactivated due to lack of power at [AREACOORD(src)]")
	else
		update_appearance()
		for(var/d in GLOB.cardinals)
			cleanup_field(d)

/// Constructs the actual field walls in the specified direction, cleans up old/stuck shields before doing so
/obj/machinery/power/shieldwallgen/proc/setup_field(direction)
	if(!direction)
		return

	var/turf/T = loc
	var/obj/machinery/power/shieldwallgen/G
	var/steps = 0
	var/opposite_direction = REVERSE_DIR(direction)

	for(var/i in 1 to shield_range) //checks out to 8 tiles away for another generator
		T = get_step(T, direction)
		G = locate(/obj/machinery/power/shieldwallgen) in T
		if(G)
			if(!G.active)
				return
			G.cleanup_field(opposite_direction)
			break
		else
			steps++

	if(!G || !steps) //no shield gen or no tiles between us and the gen
		return

	for(var/i in 1 to steps) //creates each field tile
		T = get_step(T, opposite_direction)
		new/obj/machinery/shieldwall(T, src, G)
	return TRUE

/// cleans up fields in the specified direction if they belong to this generator
/obj/machinery/power/shieldwallgen/proc/cleanup_field(direction)
	var/obj/machinery/shieldwall/F
	var/obj/machinery/power/shieldwallgen/G
	var/turf/T = loc

	for(var/i in 1 to shield_range)
		T = get_step(T, direction)

		G = (locate(/obj/machinery/power/shieldwallgen) in T)
		if(G && !G.active)
			break

		F = (locate(/obj/machinery/shieldwall) in T)
		if(F && (F.gen_primary == src || F.gen_secondary == src)) //it's ours, kill it.
			qdel(F)

/obj/machinery/power/shieldwallgen/proc/block_singularity_if_active()
	SIGNAL_HANDLER

	if (active)
		return SINGULARITY_TRY_MOVE_BLOCK

/obj/machinery/power/shieldwallgen/can_be_unfasten_wrench(mob/user, silent)
	if(active)
		if(!silent)
			to_chat(user, span_warning("请先关闭护盾发生器！"))
		return FAILED_UNFASTEN
	return ..()


/obj/machinery/power/shieldwallgen/wrench_act(mob/living/user, obj/item/tool)
	var/unfasten_result = default_unfasten_wrench(user, tool, time = 0)
	update_cable_icons_on_turf(get_turf(src))
	if(unfasten_result == SUCCESSFUL_UNFASTEN && anchored)
		connect_to_network()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/shieldwallgen/screwdriver_act(mob/user, obj/item/tool)
	if(!panel_open && locked)
		balloon_alert(user, "请先解锁！")
		return ITEM_INTERACT_BLOCKING

	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/power/shieldwallgen/crowbar_act(mob/user, obj/item/tool)
	if(active)
		return ITEM_INTERACT_BLOCKING

	return default_deconstruction_crowbar(user, tool)

/obj/machinery/power/shieldwallgen/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(tool.GetID())
		if(obj_flags & EMAGGED)
			balloon_alert(user, "发生故障！")
			return ITEM_INTERACT_BLOCKING
		if(!allowed(user))
			balloon_alert(user, "没有权限！")
			return ITEM_INTERACT_BLOCKING
		locked = !locked
		balloon_alert(user, "[locked ? "已锁定！" : "已解锁"]")
		return ITEM_INTERACT_SUCCESS

	add_fingerprint(user)
	if(is_wire_tool(tool) && panel_open)
		wires.interact(user)
		return ITEM_INTERACT_SUCCESS

	return NONE


/obj/machinery/power/shieldwallgen/interact(mob/user)
	. = ..()
	if(.)
		return
	if(!anchored)
		balloon_alert(user, "尚未固定！")
		return
	if(locked && !HAS_SILICON_ACCESS(user))
		balloon_alert(user, "已锁定！")
		return
	if(!powernet)
		balloon_alert(user, "需要电缆供电！")
		return
	if(panel_open)
		balloon_alert(user, "面板未关闭！")
		return

	if(active)
		user.visible_message(span_notice("[user]关闭了[src]。"), \
			span_notice("你关闭了[src]。"), \
			span_hear("你听见低沉的嗡鸣声渐渐消失。"))
		deactivate()
		user.log_message("deactivated [src].", LOG_GAME)
	else
		user.visible_message(span_notice("[user]启动了[src]。"), \
			span_notice("你启动了[src]。"), \
			span_hear("你听见低沉的嗡鸣声。"))
		activate()
		user.log_message("activated [src].", LOG_GAME)
	add_fingerprint(user)

/obj/machinery/power/shieldwallgen/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		to_chat(user, span_warning("权限控制器已损坏！"))
		return FALSE
	obj_flags |= EMAGGED
	locked = FALSE
	playsound(src, SFX_SPARKS, 100, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	balloon_alert(user, "权限控制器已短路")
	return TRUE

/// Turn the machine on with side effects
/obj/machinery/power/shieldwallgen/proc/activate()
	active = ACTIVE_SETUPFIELDS
	AddElement(/datum/element/give_turf_traits, string_list(list(TRAIT_CONTAINMENT_FIELD)))

/// Turn the machine off with side effects
/obj/machinery/power/shieldwallgen/proc/deactivate()
	active = FALSE
	for(var/d in GLOB.cardinals)
		cleanup_field(d)
	update_appearance()
	RemoveElement(/datum/element/give_turf_traits, string_list(list(TRAIT_CONTAINMENT_FIELD)))

//////////////Containment Field START
/obj/machinery/shieldwall
	name = "护盾墙"
	desc = "一道能量护盾。"
	icon = 'icons/effects/effects.dmi'
	icon_state = "shieldwall"
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	light_range = 2.5
	light_power = 0.7
	light_color = LIGHT_COLOR_BLUE
	var/primary_direction = NONE
	var/needs_power = FALSE
	var/obj/machinery/power/shieldwallgen/gen_primary
	var/obj/machinery/power/shieldwallgen/gen_secondary

/obj/machinery/shieldwall/Initialize(mapload, obj/machinery/power/shieldwallgen/first_gen, obj/machinery/power/shieldwallgen/second_gen)
	. = ..()
	gen_primary = first_gen
	gen_secondary = second_gen
	if(gen_primary && gen_secondary)
		needs_power = TRUE
		setDir(get_dir(gen_primary, gen_secondary))
	for(var/mob/living/L in get_turf(src))
		visible_message(span_danger("[src]突然出现在[L]所在的位置！"))
		L.investigate_log("has been gibbed by [src].", INVESTIGATE_DEATHS)
		L.gib(DROP_ALL_REMAINS)
	RegisterSignal(src, COMSIG_ATOM_SINGULARITY_TRY_MOVE, PROC_REF(block_singularity))
	AddElement(/datum/element/give_turf_traits, string_list(list(TRAIT_CONTAINMENT_FIELD)))

/obj/machinery/shieldwall/Destroy()
	gen_primary = null
	gen_secondary = null
	return ..()

/obj/machinery/shieldwall/update_overlays()
	. = ..()
	. += emissive_appearance(icon, icon_state, src, alpha = 200)

/obj/machinery/shieldwall/process()
	if(needs_power)
		if(!gen_primary || !gen_primary.active || !gen_secondary || !gen_secondary.active)
			qdel(src)
			return

		drain_power(10)

/obj/machinery/shieldwall/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BURN)
			playsound(loc, 'sound/effects/empulse.ogg', 75, TRUE)
		if(BRUTE)
			playsound(loc, 'sound/effects/empulse.ogg', 75, TRUE)

//the shield wall is immune to damage but it drains the stored power of the generators.
/obj/machinery/shieldwall/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(damage_type == BRUTE || damage_type == BURN)
		drain_power(damage_amount)

/// succs power from the connected shield wall generator
/obj/machinery/shieldwall/proc/drain_power(drain_amount)
	if(needs_power && gen_primary)
		gen_primary.add_load(drain_amount * 0.5)
		if(gen_secondary) //using power may cause us to be destroyed
			gen_secondary.add_load(drain_amount * 0.5)

/obj/machinery/shieldwall/proc/block_singularity()
	SIGNAL_HANDLER

	return SINGULARITY_TRY_MOVE_BLOCK

/obj/machinery/shieldwall/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(istype(mover) && (mover.pass_flags & PASSGLASS))
		return prob(20)
	else
		if(isprojectile(mover))
			return prob(10)

#undef ACTIVE_SETUPFIELDS
#undef ACTIVE_HASFIELDS
