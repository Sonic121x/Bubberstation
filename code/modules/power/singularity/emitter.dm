/obj/machinery/power/emitter
	name = "发射器"
	desc = "一台重型工业激光器，常用于约束力场和发电。"
	icon = 'icons/obj/machines/engine/singularity.dmi' //SKYRAT EDIT CHANGE - ICON OVERRIDDEN IN SKYRAT AESTHETICS - SEE MODULE
	icon_state = "emitter"
	base_icon_state = "emitter"

	anchored = FALSE
	density = TRUE
	req_access = list(ACCESS_ENGINE_EQUIP)
	circuit = /obj/item/circuitboard/machine/emitter

	use_power = NO_POWER_USE
	can_change_cable_layer = TRUE

	/// The icon state used by the emitter when it's on.
	var/icon_state_on = "emitter_+a"
	/// The icon state used by the emitter when it's on and low on power.
	var/icon_state_underpowered = "emitter_+u"
	///Is the machine active?
	var/active = FALSE
	///Does the machine have power?
	var/powered = FALSE
	///Seconds before the next shot
	var/fire_delay = 10 SECONDS
	///Max delay before firing
	var/maximum_fire_delay = 10 SECONDS
	///Min delay before firing
	var/minimum_fire_delay = 2 SECONDS
	///Modifier to the preceeding two numbers
	var/fire_rate_mod = 1
	///Deactivates the "pause every 3 shots" system
	var/no_shot_counter = FALSE
	///When was the last shot
	var/last_shot = 0
	///Number of shots made (gets reset every few shots)
	var/shot_number = 0
	///if it's welded down to the ground or not. the emitter will not fire while unwelded. if set to true, the emitter will start anchored as well.
	var/welded = FALSE
	///Is the emitter id locked?
	var/locked = FALSE
	///Used to stop interactions with the object (mainly in the wabbajack statue)
	var/allow_switch_interact = TRUE
	///What projectile type are we shooting?
	var/projectile_type = /obj/projectile/beam/emitter/hitscan
	///What's the projectile sound?
	var/projectile_sound = 'sound/items/weapons/emitter.ogg'
	///Sparks emitted with every shot
	var/datum/effect_system/basic/spark_spread/sparks
	///Stores the type of gun we are using inside the emitter
	var/obj/item/gun/energy/gun
	///List of all the properties of the inserted gun
	var/list/gun_properties
	//only used to always have the gun properties on non-letal (no other instances found)
	var/mode = FALSE

	// The following 3 vars are mostly for the prototype
	///manual shooting? (basically you hop onto the emitter and choose the shooting direction, is very janky since you can only shoot at the 8 directions and i don't think is ever used since you can't build those)
	var/manual = FALSE
	///Amount of power inside
	var/charge = 0
	///stores the direction and orientation of the last projectile
	var/last_projectile_params
	//the disk in the gun
	var/obj/item/emitter_disk/diskie

/obj/machinery/power/emitter/Initialize(mapload)
	. = ..()
	//Add to the early process queue to prioritize power draw
	SSmachines.processing_early += src
	set_wires(new /datum/wires/emitter(src))
	if(welded)
		if(!anchored)
			set_anchored(TRUE)
		connect_to_network()

	sparks = new(src, 5, TRUE)
	sparks.attach(src)
	AddElement(/datum/element/simple_rotation)
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)
	AddComponent(/datum/component/usb_port, typecacheof(list(/obj/item/circuit_component/emitter), only_root_path = TRUE))

/obj/machinery/power/emitter/welded/Initialize(mapload)
	welded = TRUE
	. = ..()

/obj/machinery/power/emitter/cable_layer_act(mob/living/user, obj/item/tool)
	if(panel_open)
		return NONE
	if(welded)
		balloon_alert(user, "先拆焊！")
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/machinery/power/emitter/set_anchored(anchorvalue)
	. = ..()
	if(!anchored && welded) //make sure they're keep in sync in case it was forcibly unanchored by badmins or by a megafauna.
		welded = FALSE

/obj/machinery/power/emitter/RefreshParts()
	. = ..()
	var/max_fire_delay = 12 SECONDS
	var/fire_shoot_delay = 12 SECONDS
	var/min_fire_delay = 2.4 SECONDS
	var/power_usage = 350
	for(var/datum/stock_part/micro_laser/laser in component_parts)
		max_fire_delay -= 2 SECONDS * laser.tier
		min_fire_delay -= 0.4 SECONDS * laser.tier
		fire_shoot_delay -= 2 SECONDS * laser.tier
	maximum_fire_delay = max_fire_delay
	minimum_fire_delay = min_fire_delay
	fire_delay = fire_shoot_delay
	for(var/datum/stock_part/servo/servo in component_parts)
		power_usage -= 50 * servo.tier
	update_mode_power_usage(ACTIVE_POWER_USE, power_usage)

/obj/machinery/power/emitter/examine(mob/user)
	. = ..()
	if(welded)
		. += span_info("它被牢牢固定在地板上。你可以用<b>焊接工具</b>解开它的固定。")
	else if(anchored)
		. += span_info("它目前固定在地板上。你可以用<b>焊接工具</b>加固它的固定，或用<b>扳手</b>将它拆除。")
	else
		. += span_info("它没有固定在地板上。你可以用<b>扳手</b>把它固定到位。")

	if(!in_range(user, src) && !isobserver(user))
		return

	if(!active)
		. += span_notice("它的状态显示屏目前是关闭的。")
	else if(!powered)
		. += span_notice("它的状态显示屏幽幽发亮。")
	else
		. += span_notice("状态显示屏显示：每隔 <b>[DisplayTimeText(minimum_fire_delay * fire_rate_mod)]</b> 至 <b>[DisplayTimeText(maximum_fire_delay * fire_rate_mod)]</b> 发射一道光束。")
		. += span_notice("功耗为 <b>[display_power(active_power_usage, convert = FALSE)]</b>。")

/obj/machinery/power/emitter/should_have_node()
	return welded

/obj/machinery/power/emitter/Destroy()
	if(SSticker.IsRoundInProgress())
		var/turf/T = get_turf(src)
		message_admins("[src] 已删除，位置 [ADMIN_VERBOSEJMP(T)]。")
		log_game("[src] 已删除，位置 [AREACOORD(T)]。")
		investigate_log("已在 [AREACOORD(T)] 被删除。", INVESTIGATE_ENGINE)
	QDEL_NULL(sparks)
	return ..()

/obj/machinery/power/emitter/update_overlays()
	. = ..()
	if(!active)
		return
	var/laser_color = COLOR_VIBRANT_LIME
	if (!powered)
		laser_color = COLOR_ORANGE //stank low power orange
	else if (diskie)
		laser_color = diskie.laser_color
	var/mutable_appearance/overlay = mutable_appearance(icon, "emitter_overlay")
	overlay.color = laser_color
	. += overlay
	. += emissive_appearance(icon, "emitter_overlay", src, alpha = src.alpha)

/obj/machinery/power/emitter/update_icon_state()
	if(panel_open)
		icon_state = "[base_icon_state]_open"
	else
		icon_state = base_icon_state
	return ..()

/obj/machinery/power/emitter/interact(mob/user)
	add_fingerprint(user)
	if(!welded)
		to_chat(user, span_warning("[src] 需要先牢牢固定在地板上！"))
		return FALSE
	if(!powernet)
		to_chat(user, span_warning("\The [src] 没有连接到电线！"))
		return FALSE
	if(locked || !allow_switch_interact)
		to_chat(user, span_warning("控制装置已锁定！"))
		return FALSE

	if(active)
		active = FALSE
	else
		active = TRUE
		shot_number = 0
		fire_delay = maximum_fire_delay

	to_chat(user, span_notice("你[active ? "打开" : "关闭"]了 [src]。"))
	message_admins("[src] 于 [ADMIN_VERBOSEJMP(src)] 被 [ADMIN_LOOKUPFLW(user)] [active ? "开启" : "关闭"]")
	log_game("[src] 于 [AREACOORD(src)] 被 [key_name(user)] [active ? "开启" : "关闭"]")
	investigate_log("于 [AREACOORD(src)] 被 [key_name(user)] [active ? "开启" : "关闭"]", INVESTIGATE_ENGINE)
	update_appearance()
	SEND_SIGNAL(src, COMSIG_EMITTER_MACHINE_SET_ON, active ? TRUE : FALSE)

/obj/machinery/power/emitter/attack_animal(mob/living/simple_animal/user, list/modifiers)
	if(ismegafauna(user) && anchored)
		set_anchored(FALSE)
		user.visible_message(span_warning("[user] 把 [src] 从固定处硬生生拽了下来！"))
	else
		. = ..()
	if(. && !anchored)
		step(src, get_dir(user, src))

/obj/machinery/power/emitter/attack_ai_secondary(mob/user, list/modifiers)
	togglelock(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/power/emitter/process_early(seconds_per_tick)
	var/power_usage = active_power_usage * seconds_per_tick
	if(machine_stat & (BROKEN))
		return
	if(!welded || (!powernet && power_usage))
		active = FALSE
		update_appearance()
		return
	if(!active)
		return
	if(power_usage && surplus() < power_usage)
		if(powered)
			powered = FALSE
			update_appearance()
			investigate_log("于 [AREACOORD(src)] 失去电力并关闭", INVESTIGATE_ENGINE)
			log_game("[src] 在 [AREACOORD(src)] 失去电力")
		return

	add_load(power_usage)
	if(!powered)
		powered = TRUE
		update_appearance()
		investigate_log("于 [AREACOORD(src)] 恢复供电并开启", INVESTIGATE_ENGINE)
	if(charge <= 80)
		charge += 2.5 * seconds_per_tick
	if(!check_delay() || manual == TRUE)
		return FALSE
	fire_beam()

/obj/machinery/power/emitter/proc/check_delay()
	if((last_shot + fire_delay) <= world.time)
		return TRUE
	return FALSE

/obj/machinery/power/emitter/proc/fire_beam_pulse()
	if(!check_delay())
		return FALSE
	if(!welded)
		return FALSE
	if(surplus() >= active_power_usage)
		add_load(active_power_usage)
		fire_beam()

/obj/machinery/power/emitter/proc/fire_beam(mob/user)
	var/obj/projectile/projectile = new projectile_type(get_turf(src))
	playsound(src, projectile_sound, 50, TRUE)
	if(prob(35))
		sparks.start()
	projectile.firer = user ? user : src
	projectile.fired_from = src
	if(last_projectile_params)
		projectile.p_x = last_projectile_params[2]
		projectile.p_y = last_projectile_params[3]
		projectile.fire(last_projectile_params[1])
	else
		projectile.fire(dir2angle(dir))
	if(!manual)
		last_shot = world.time
		if(shot_number < 3 || no_shot_counter)
			fire_delay = 20 * fire_rate_mod
			shot_number ++
		else
			fire_delay = rand(minimum_fire_delay,maximum_fire_delay) * fire_rate_mod
			shot_number = 0
	SEND_SIGNAL(src, COMSIG_EMITTER_MACHINE_ON_FIRE)
	return projectile

/obj/machinery/power/emitter/can_be_unfasten_wrench(mob/user, silent)
	if(active)
		if(!silent)
			to_chat(user, span_warning("请先关闭 \the [src]！"))
		return FAILED_UNFASTEN

	else if(welded)
		if(!silent)
			to_chat(user, span_warning("[src] 已被焊接在地板上！"))
		return FAILED_UNFASTEN

	return ..()

/obj/machinery/power/emitter/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/emitter/welder_act(mob/living/user, obj/item/item)
	..()
	if(active)
		to_chat(user, span_warning("请先关闭 [src]！"))
		return TRUE

	if(welded)
		if(!item.tool_start_check(user, amount=1))
			return TRUE
		user.visible_message(span_notice("[user.name] 开始把 \the [src] 从地板上切割下来。"), \
			span_notice("你开始把 [src] 从地板上切割下来……"), \
			span_hear("你听到焊接声。"))
		if(!item.use_tool(src, user, 20, 1, 50))
			return FALSE
		welded = FALSE
		to_chat(user, span_notice("你把 [src] 从地板上切割了下来。"))
		disconnect_from_network()
		update_cable_icons_on_turf(get_turf(src))
		return TRUE

	if(!anchored)
		to_chat(user, span_warning("[src] 需要先用扳手固定到地板上！"))
		return TRUE
	if(!item.tool_start_check(user, amount=1))
		return TRUE
	user.visible_message(span_notice("[user.name] 开始把 \the [src] 焊接到地板上。"), \
		span_notice("你开始把 [src] 焊接到地板上……"), \
		span_hear("你听到焊接声。"))
	if(!item.use_tool(src, user, 20, 1, 50))
		return FALSE
	welded = TRUE
	to_chat(user, span_notice("你把 [src] 焊接到地板上。"))
	connect_to_network()
	update_cable_icons_on_turf(get_turf(src))
	return TRUE

/obj/machinery/power/emitter/crowbar_act(mob/living/user, obj/item/item)
	if(panel_open && gun)
		return remove_gun(user)
	if(panel_open && diskie)
		return remove_disk(user)
	return default_deconstruction_crowbar(user, item)

/obj/machinery/power/emitter/screwdriver_act(mob/living/user, obj/item/item)
	return default_deconstruction_screwdriver(user, item)

/// Attempt to toggle the controls lock of the emitter
/obj/machinery/power/emitter/proc/togglelock(mob/user)
	if(obj_flags & EMAGGED)
		to_chat(user, span_warning("锁似乎已经损坏了！"))
		return
	if(!allowed(user))
		to_chat(user, span_danger("拒绝访问。"))
		return
	if(!active)
		to_chat(user, span_warning("只有在 \the [src] 在线时才能锁定控制装置！"))
		return
	locked = !locked
	to_chat(user, span_notice("你[src.locked ? "锁定" : "解锁"]了控制装置。"))

/obj/machinery/power/emitter/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(tool.GetID())
		togglelock(user)
		return ITEM_INTERACT_SUCCESS

	if(!panel_open)
		return NONE

	if(is_wire_tool(tool))
		wires.interact(user)
		return ITEM_INTERACT_SUCCESS

	if(gun)
		return NONE

	if(istype(tool, /obj/item/gun/energy))
		if(diskie)
			to_chat(user, span_warning("插入枪械前请先取出二极管磁盘。"))
			return ITEM_INTERACT_BLOCKING
		if(!integrate(tool,user))
			return ITEM_INTERACT_BLOCKING
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/emitter_disk))
		var/obj/item/emitter_disk/config_disk = tool
		if(!user.transferItemToLoc(config_disk, src))
			balloon_alert(user, "卡在手里了！")
			return ITEM_INTERACT_BLOCKING
		if(diskie)
			user.put_in_hands(diskie)
			balloon_alert(user, "磁盘已交换！")
		else
			balloon_alert(user, "磁盘已插入")
		diskie = config_disk
		projectile_type = diskie.stored_proj
		projectile_sound = diskie.stored_sound
		fire_rate_mod = diskie.fire_rate_mod
		no_shot_counter = diskie.no_shot_counter
		playsound(src, 'sound/machines/card_slide.ogg', 50)
		to_chat(user, span_notice("你用 [config_disk] 更新了 [src] 的二极管配置。"))
		update_appearance()
		if(diskie.consumable)
			qdel(diskie)
		return ITEM_INTERACT_SUCCESS

	return NONE


/obj/machinery/power/emitter/proc/integrate(obj/item/gun/energy/energy_gun, mob/user)
	if(!istype(energy_gun, /obj/item/gun/energy))
		return
	if(istype(energy_gun, /obj/item/gun/energy/cell_loaded))//SKYRAT EDIT MEDIGUNS
		return
	if(!user.transferItemToLoc(energy_gun, src))
		return
	if(energy_gun.gun_flags & TURRET_INCOMPATIBLE)
		user.balloon_alert(user, "[energy_gun] 装不进去！")
		return
	gun = energy_gun
	gun_properties = gun.get_turret_properties()
	set_projectile()
	return TRUE

/obj/machinery/power/emitter/proc/remove_gun(mob/user)
	if(!gun)
		return
	user.put_in_hands(gun)
	gun = null
	playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
	gun_properties = list()
	set_projectile()
	return TRUE

/obj/machinery/power/emitter/proc/remove_disk(mob/user)
	if(!diskie)
		return
	if(diskie.consumed_on_removal)
		qdel(diskie)
	else
		user.put_in_hands(diskie)
	diskie = null
	playsound(src, 'sound/machines/card_slide.ogg', 50, TRUE)
	update_appearance()
	set_projectile()
	return TRUE


/obj/machinery/power/emitter/proc/set_projectile()
	if(LAZYLEN(gun_properties))
		if(mode || !gun_properties["lethal_projectile"])
			projectile_type = gun_properties["stun_projectile"]
			projectile_sound = gun_properties["stun_projectile_sound"]
		else
			projectile_type = gun_properties["lethal_projectile"]
			projectile_sound = gun_properties["lethal_projectile_sound"]
		return
	projectile_type = initial(projectile_type)
	projectile_sound = initial(projectile_sound)
	fire_rate_mod = initial(fire_rate_mod)
	no_shot_counter = initial(no_shot_counter)

/obj/machinery/power/emitter/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	locked = FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "ID 锁已短路")
	return TRUE


/obj/machinery/power/emitter/prototype
	name = "原型发射器"
	icon = 'icons/obj/weapons/turrets.dmi'
	icon_state = "protoemitter"
	base_icon_state = "protoemitter"
	icon_state_on = "protoemitter_+a"
	icon_state_underpowered = "protoemitter_+u"
	can_buckle = TRUE
	buckle_lying = 0
	///Sets the view size for the user
	var/view_range = 4.5
	///Grants the buckled mob the action button
	var/datum/action/innate/proto_emitter/firing/auto

//BUCKLE HOOKS

/obj/machinery/power/emitter/prototype/unbuckle_mob(mob/living/buckled_mob, force = FALSE, can_fall = TRUE)
	playsound(src,'sound/vehicles/mecha/mechmove01.ogg', 50, TRUE)
	manual = FALSE
	for(var/obj/item/item in buckled_mob.held_items)
		if(istype(item, /obj/item/turret_control))
			qdel(item)
	if(istype(buckled_mob))
		buckled_mob.pixel_x = buckled_mob.base_pixel_x
		buckled_mob.pixel_y = buckled_mob.base_pixel_y
		if(buckled_mob.client)
			buckled_mob.client.view_size.resetToDefault()
	auto.Remove(buckled_mob)
	. = ..()

/obj/machinery/power/emitter/prototype/user_buckle_mob(mob/living/buckled_mob, mob/user, check_loc = TRUE)
	if(user.incapacitated || !istype(user))
		return
	for(var/atom/movable/atom in get_turf(src))
		if(atom.density && (atom != src && atom != buckled_mob))
			return
	buckled_mob.forceMove(get_turf(src))
	..()
	playsound(src, 'sound/vehicles/mecha/mechmove01.ogg', 50, TRUE)
	buckled_mob.pixel_y = 14
	layer = 4.1
	if(buckled_mob.client)
		buckled_mob.client.view_size.setTo(view_range)
	if(!auto)
		auto = new()
	auto.Grant(buckled_mob, src)

/datum/action/innate/proto_emitter
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	///Stores the emitter the user is currently buckled on
	var/obj/machinery/power/emitter/prototype/proto_emitter
	///Stores the mob instance that is buckled to the emitter
	var/mob/living/carbon/buckled_mob

/datum/action/innate/proto_emitter/Destroy()
	proto_emitter = null
	buckled_mob = null
	return ..()

/datum/action/innate/proto_emitter/Grant(mob/living/carbon/user, obj/machinery/power/emitter/prototype/proto)
	proto_emitter = proto
	buckled_mob = user
	. = ..()

/datum/action/innate/proto_emitter/firing
	name = "切换为手动射击"
	desc = "发射器只会按你的指令、朝你指定的目标射击"
	button_icon_state = "mech_zoom_on"

/datum/action/innate/proto_emitter/firing/Activate()
	if(proto_emitter.manual)
		playsound(proto_emitter,'sound/vehicles/mecha/mechmove01.ogg', 50, TRUE)
		proto_emitter.manual = FALSE
		name = "切换为手动射击"
		desc = "发射器只会按你的指令、朝你指定的目标射击"
		button_icon_state = "mech_zoom_on"
		for(var/obj/item/item in buckled_mob.held_items)
			if(istype(item, /obj/item/turret_control))
				qdel(item)
		build_all_button_icons()
		return
	playsound(proto_emitter,'sound/vehicles/mecha/mechmove01.ogg', 50, TRUE)
	name = "切换为自动射击"
	desc = "发射器将转为朝你最后的目标周期性射击"
	button_icon_state = "mech_zoom_off"
	proto_emitter.manual = TRUE
	for(var/things in buckled_mob.held_items)
		var/obj/item/item = things
		if(istype(item))
			if(!buckled_mob.dropItemToGround(item))
				continue
			var/obj/item/turret_control/turret_control = new /obj/item/turret_control()
			buckled_mob.put_in_hands(turret_control)
		else //Entries in the list should only ever be items or null, so if it's not an item, we can assume it's an empty hand
			var/obj/item/turret_control/turret_control = new /obj/item/turret_control()
			buckled_mob.put_in_hands(turret_control)
	build_all_button_icons()


/obj/item/turret_control
	name = "炮塔控制装置"
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "offhand"
	w_class = WEIGHT_CLASS_HUGE
	item_flags = ABSTRACT | NOBLUDGEON
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	///Ticks before being able to shoot
	var/delay = 0

/obj/item/turret_control/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/turret_control/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(HAS_TRAIT(interacting_with, TRAIT_COMBAT_MODE_SKIP_INTERACTION))
		return NONE
	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/turret_control/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/machinery/power/emitter/emitter = user.buckled
	emitter.setDir(get_dir(emitter, interacting_with))
	user.setDir(emitter.dir)
	switch(emitter.dir)
		if(NORTH)
			emitter.layer = 3.9
			user.pixel_x = 0
			user.pixel_y = -14
		if(NORTHEAST)
			emitter.layer = 3.9
			user.pixel_x = -8
			user.pixel_y = -12
		if(EAST)
			emitter.layer = 4.1
			user.pixel_x = -14
			user.pixel_y = 0
		if(SOUTHEAST)
			emitter.layer = 3.9
			user.pixel_x = -8
			user.pixel_y = 12
		if(SOUTH)
			emitter.layer = 4.1
			user.pixel_x = 0
			user.pixel_y = 14
		if(SOUTHWEST)
			emitter.layer = 3.9
			user.pixel_x = 8
			user.pixel_y = 12
		if(WEST)
			emitter.layer = 4.1
			user.pixel_x = 14
			user.pixel_y = 0
		if(NORTHWEST)
			emitter.layer = 3.9
			user.pixel_x = 8
			user.pixel_y = -12

	emitter.last_projectile_params = calculate_projectile_angle_and_pixel_offsets(user, null, modifiers)

	if(emitter.charge >= 10 && world.time > delay)
		emitter.charge -= 10
		emitter.fire_beam(user)
		delay = world.time + 10
	else if (emitter.charge < 10)
		playsound(src,'sound/machines/buzz/buzz-sigh.ogg', 50, TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/emitter/ctf
	name = "能量炮"
	active = TRUE
	active_power_usage = 0
	idle_power_usage = 0
	locked = TRUE
	req_access = list("science")
	welded = TRUE
	use_power = NO_POWER_USE

/obj/item/emitter_disk
	name = "\improper 二极管磁盘：调试器"
	desc = "将这张磁盘用于面板打开的发射器，可重置其发射物。除非这是管理员交给你的，否则你应该在 github 上报告此事。"
	icon = 'icons/obj/devices/floppy_disks.dmi'
	icon_state = "datadisk6"
	var/laser_color = COLOR_VIBRANT_LIME
	var/stored_proj = /obj/projectile/beam/emitter/hitscan
	var/stored_sound = 'sound/items/weapons/emitter.ogg'
	var/consumed_on_removal = TRUE
	var/consumable = TRUE
	var/fire_rate_mod = 1
	var/no_shot_counter = FALSE

/obj/item/emitter_disk/stamina
	name = "\improper 二极管磁盘：电击瓦解型"
	desc = "将这张磁盘用于面板打开的发射器，可使其发射的激光提升超物质晶体的完整度，并让活体生物精疲力竭。使用过程中磁盘会被消耗。"
	stored_proj = /obj/projectile/beam/emitter/hitscan/bluelens
	consumed_on_removal = FALSE
	consumable = FALSE
	laser_color = COLOR_TRUE_BLUE
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/emitter_disk/healing
	name = "\improper 二极管磁盘：生物再生型"
	desc = "将这张磁盘安装到面板打开的发射器中，可使其发射的激光治疗活体生物的身体损伤。"
	stored_proj = /obj/projectile/beam/emitter/hitscan/bioregen
	consumed_on_removal = FALSE
	consumable = FALSE
	laser_color = COLOR_YELLOW
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/silver = SMALL_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/emitter_disk/incendiary
	name = "\improper 二极管磁盘：燃烧型"
	desc = "将这张磁盘用于面板打开的发射器，可使其发射的激光点燃活体生物。"
	stored_proj = /obj/projectile/beam/emitter/hitscan/incend
	consumed_on_removal = FALSE
	consumable = FALSE
	laser_color = COLOR_RED_LIGHT
	custom_materials = list(/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/emitter_disk/sanity
	name = "\improper 二极管磁盘：心灵虹吸型"
	desc = "将这张磁盘用于面板打开的发射器，可使其发射的激光令活体生物情绪低落，并让超物质晶体平静下来。"
	stored_proj = /obj/projectile/beam/emitter/hitscan/psy
	consumed_on_removal = FALSE
	consumable = FALSE
	laser_color = COLOR_TONGUE_PINK
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/emitter_disk/magnetic
	name = "\improper 二极管磁盘：磁力生成型"
	desc = "将这张磁盘用于面板打开的发射器，可使其发射的激光吸引附近的物体。"
	stored_proj = /obj/projectile/beam/emitter/hitscan/magnetic
	consumed_on_removal = FALSE
	consumable = FALSE
	laser_color = COLOR_SILVER
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/emitter_disk/blast
	name = "\improper 二极管磁盘：超震荡型"
	desc = "这张磁盘载有辛迪加的专有固件，将其用于面板打开的发射器，可使其发射出会造成小型爆炸的震荡光束。"
	stored_proj = /obj/projectile/beam/emitter/hitscan/blast
	consumed_on_removal = FALSE
	consumable = FALSE
	laser_color = COLOR_SYNDIE_RED //magnetic is already grey
	fire_rate_mod = 2
