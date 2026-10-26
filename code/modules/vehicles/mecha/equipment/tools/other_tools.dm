
// Teleporter, Wormhole generator, Gravitational catapult, Armor booster modules,
// Repair droid, Tesla Energy relay, Generators

////////////////////////////////////////////// TELEPORTER ///////////////////////////////////////////////

/obj/item/mecha_parts/mecha_equipment/teleporter
	name = "外挂传送器"
	desc = "一种机甲模块，可让机甲传送到视野内的任意位置。"
	icon_state = "mecha_teleport"
	equip_cooldown = 150
	energy_drain = STANDARD_CELL_CHARGE
	range = MECHA_RANGED
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 5)
	var/teleport_range = 7

/obj/item/mecha_parts/mecha_equipment/teleporter/action(mob/source, atom/target, list/modifiers)
	if(!action_checks(target) || !check_teleport_valid(source, target, TELEPORT_CHANNEL_BLUESPACE))
		return
	var/turf/T = get_turf(target)
	if(T && (loc.z == T.z) && (get_dist(loc, T) <= teleport_range))
		do_teleport(chassis, T, 4, channel = TELEPORT_CHANNEL_BLUESPACE)
		return ..()



////////////////////////////////////////////// WORMHOLE GENERATOR //////////////////////////////////////////

/obj/item/mecha_parts/mecha_equipment/wormhole_generator
	name = "外挂虫洞发生器"
	desc = "一种机甲模块，可生成小型准稳定虫洞，实现远距离但不精确的传送。"
	icon_state = "mecha_wholegen"
	equip_cooldown = 50
	energy_drain = 300
	range = MECHA_RANGED
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)


/obj/item/mecha_parts/mecha_equipment/wormhole_generator/action(mob/source, atom/target, list/modifiers)
	if(!action_checks(target) || !check_teleport_valid(source, target, TELEPORT_CHANNEL_WORMHOLE))
		return
	var/area/targetarea = pick(get_areas_in_range(100, chassis))
	if(!targetarea)//Literally middle of nowhere how did you even get here
		return
	var/list/validturfs = list()
	var/turf/ourturf = get_turf(src)
	for(var/t in get_area_turfs(targetarea.type))
		var/turf/evaluated_turf = t
		if(evaluated_turf.density || chassis.z != evaluated_turf.z)
			continue
		for(var/obj/evaluated_obj in evaluated_turf)
			if(!evaluated_obj.density)
				continue
			validturfs += evaluated_turf

	var/turf/target_turf = pick(validturfs)
	if(!target_turf)
		return
	var/list/obj/effect/portal/created = create_portal_pair(ourturf, target_turf, 300, 1, /obj/effect/portal/anom)
	message_admins("[ADMIN_LOOKUPFLW(source)] 在 [ADMIN_VERBOSEJMP(ourturf)] 使用了虫洞发生器。")
	source.log_message("在 [AREACOORD(ourturf)] 使用了虫洞发生器。", LOG_GAME)
	QDEL_LIST_IN(created, rand(150,300))
	return ..()


/////////////////////////////////////// GRAVITATIONAL CATAPULT ///////////////////////////////////////////

#define GRAVSLING_MODE 1
#define GRAVPUSH_MODE 2

/obj/item/mecha_parts/mecha_equipment/gravcatapult
	name = "外挂引力弹射器"
	desc = "一种外挂在机甲上的引力弹射器。"
	icon_state = "mecha_teleport"
	equip_cooldown = 10
	energy_drain = 100
	range = MECHA_MELEE|MECHA_RANGED
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	///Which atom we are movable_target onto for
	var/atom/movable/movable_target
	///Whether we will throw movable atomstothrow by locking onto them or just throw them back from where we click
	var/mode = GRAVSLING_MODE


/obj/item/mecha_parts/mecha_equipment/gravcatapult/action(mob/source, atom/movable/target, list/modifiers)
	if(!action_checks(target))
		return
	switch(mode)
		if(GRAVSLING_MODE)
			if(!movable_target)
				if(!istype(target) || target.anchored || target.move_resist >= MOVE_FORCE_EXTREMELY_STRONG)
					to_chat(source, "[icon2html(src, source)][span_warning("无法锁定 [target]！")]")
					return
				if(ismob(target))
					var/mob/M = target
					if(M.mob_negates_gravity())
						to_chat(source, "[icon2html(src, source)][span_warning("[target] 免疫引力脉冲，无法锁定！")]")
						return
				movable_target = target
				to_chat(source, "[icon2html(src, source)][span_notice("已锁定 [target]。")]")
			else if(target != movable_target)
				if(movable_target in view(chassis))
					var/turf/targ = get_turf(target)
					var/turf/orig = get_turf(movable_target)
					movable_target.throw_at(target, 14, 1.5)
					movable_target = null
					source.log_message("使用引力弹射器将 [movable_target]（来自 [AREACOORD(orig)]）掷向 [target]（[AREACOORD(targ)]）。", LOG_GAME)
					return ..()
				movable_target = null
				to_chat(source, "[icon2html(src, source)][span_notice("已解除对 [movable_target] 的锁定。")]")

		if(GRAVPUSH_MODE)
			var/list/atomstothrow = list()
			if(isturf(target))
				atomstothrow = range(3, target)
			else
				atomstothrow = orange(3, target)
			for(var/atom/movable/scatter in atomstothrow)
				if(scatter.anchored || scatter.move_resist >= MOVE_FORCE_EXTREMELY_STRONG)
					continue
				if(ismob(scatter))
					var/mob/scatter_mob = scatter
					if(scatter_mob.mob_negates_gravity())
						continue
				do_scatter(scatter, target)
			var/turf/targetturf = get_turf(target)
			source.log_message("在 [AREACOORD(targetturf)] 使用了引力弹射器斥力波。", LOG_GAME)
			return ..()

/obj/item/mecha_parts/mecha_equipment/gravcatapult/proc/do_scatter(atom/movable/scatter, atom/movable/target)
	var/dist = 5 - get_dist(scatter, target)
	var/delay = 2
	GLOB.move_manager.move_away(scatter, target, delay = delay, timeout = delay * dist, flags = MOVEMENT_LOOP_START_INSTANT, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)

/obj/item/mecha_parts/mecha_equipment/gravcatapult/get_snowflake_data()
	return list(
		"snowflake_id" = MECHA_SNOWFLAKE_ID_MODE,
		"mode" = mode == GRAVPUSH_MODE ? "推送" : "弹射",
		"mode_label" = "引力弹射器",
	)

/obj/item/mecha_parts/mecha_equipment/gravcatapult/handle_ui_act(action, list/params)
	if(action == "change_mode")
		mode++
		if(mode > GRAVPUSH_MODE)
			mode = GRAVSLING_MODE
		return TRUE

#undef GRAVSLING_MODE
#undef GRAVPUSH_MODE

//////////////////////////// ARMOR BOOSTER MODULES //////////////////////////////////////////////////////////
/obj/item/mecha_parts/mecha_equipment/armor
	equipment_slot = MECHA_ARMOR
	//how much the armor of the mech is modified by
	var/datum/armor/armor_mod

/obj/item/mecha_parts/mecha_equipment/armor/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right)
	. = ..()
	if (armor_mod)
		chassis.set_armor(chassis.get_armor().add_other_armor(armor_mod))

/obj/item/mecha_parts/mecha_equipment/armor/detach(atom/moveto)
	if (armor_mod)
		chassis.set_armor(chassis.get_armor().subtract_other_armor(armor_mod))
	return ..()

/obj/item/mecha_parts/mecha_equipment/armor/anticcw_armor_booster
	name = "外骨骼冲击缓冲板"
	desc = "增强外骨骼对近战攻击的护甲。"
	icon_state = "mecha_abooster_ccw"
	armor_mod = /datum/armor/mecha_equipment_ccw_boost
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.5)

/datum/armor/mecha_equipment_ccw_boost
	melee = 20

/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster
	name = "外骨骼弹丸防护罩"
	desc = "增强外骨骼对远程动能与能量弹丸的护甲。可完全格挡电击枪射击。"
	icon_state = "mecha_abooster_proj"
	armor_mod = /datum/armor/mecha_equipment_ranged_boost
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5)

/datum/armor/mecha_equipment_ranged_boost
	bullet = 15
	laser = 15

/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster
	name = "外骨骼烧蚀绝缘层"
	desc = "增强外骨骼对能量类攻击的护甲，同时保护外骨骼内部线缆免受敌方 EMP 攻击。不过，由于占用了宝贵的船体缓冲空间，\
		这可能让外骨骼在面对动能打击时略显脆弱。"
	icon_state = "mecha_abooster_emp"
	armor_mod = /datum/armor/mecha_equipment_energy_boost
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5)

/datum/armor/mecha_equipment_energy_boost
	melee = -5
	bullet = -10
	energy = 15

/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right)
	. = ..()
	chassis.AddElement(/datum/element/empprotection, EMP_PROTECT_WIRES|EMP_NO_EXAMINE)

/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/detach(atom/moveto)
	chassis.RemoveElement(/datum/element/empprotection, EMP_PROTECT_WIRES|EMP_NO_EXAMINE)
	return ..()

/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/clandestine
	name = "外骨骼硬化烧蚀绝缘层"
	desc = "增强外骨骼对能量类攻击的护甲，同时保护外骨骼内部线缆免受敌方 EMP 攻击。"
	armor_mod = /datum/armor/mecha_equipment_improved_energy_boost

/datum/armor/mecha_equipment_improved_energy_boost
	energy = 20

////////////////////////////////// REPAIR DROID //////////////////////////////////////////////////


/obj/item/mecha_parts/mecha_equipment/repair_droid
	name = "外骨骼维修机器人"
	desc = "外骨骼用自动维修机器人。会扫描损伤并加以修复，几乎能修复所有类型的外部或内部损伤。"
	icon_state = "repair_droid"
	energy_drain = 50
	range = 0
	unstackable = TRUE
	can_be_toggled = TRUE
	active = FALSE
	equipment_slot = MECHA_UTILITY
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT)
	/// Repaired health per second
	var/health_boost = 0.5
	var/icon/droid_overlay
	var/list/repairable_damage = list(MECHA_INT_TEMP_CONTROL,MECHA_CABIN_AIR_BREACH)

/obj/item/mecha_parts/mecha_equipment/repair_droid/Destroy()
	STOP_PROCESSING(SSobj, src)
	chassis?.cut_overlay(droid_overlay)
	return ..()

/obj/item/mecha_parts/mecha_equipment/repair_droid/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right = FALSE)
	. = ..()
	droid_overlay = new(src.icon, icon_state = "repair_droid")
	new_mecha.add_overlay(droid_overlay)

/obj/item/mecha_parts/mecha_equipment/repair_droid/detach()
	chassis.cut_overlay(droid_overlay)
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/mecha_parts/mecha_equipment/repair_droid/handle_ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(action != "toggle")
		return
	chassis.cut_overlay(droid_overlay)
	if(active)
		START_PROCESSING(SSobj, src)
		droid_overlay = new(src.icon, icon_state = "repair_droid_a")
		log_message("已启动。", LOG_MECHA)
	else
		STOP_PROCESSING(SSobj, src)
		droid_overlay = new(src.icon, icon_state = "repair_droid")
		log_message("已停用。", LOG_MECHA)
	chassis.add_overlay(droid_overlay)


/obj/item/mecha_parts/mecha_equipment/repair_droid/process(seconds_per_tick)
	if(!chassis)
		return PROCESS_KILL
	var/h_boost = health_boost * seconds_per_tick
	var/repaired = FALSE
	if(chassis.internal_damage & MECHA_INT_SHORT_CIRCUIT)
		h_boost *= -2
	else if(chassis.internal_damage && SPT_PROB(8, seconds_per_tick))
		for(var/int_dam_flag in repairable_damage)
			if(!(chassis.internal_damage & int_dam_flag))
				continue
			chassis.clear_internal_damage(int_dam_flag)
			repaired = TRUE
			break
	if(h_boost<0 || chassis.get_integrity() < chassis.max_integrity)
		chassis.repair_damage(h_boost)
		repaired = TRUE
	if(repaired)
		if(!chassis.use_energy(energy_drain))
			active = FALSE
			return PROCESS_KILL
	else //no repair needed, we turn off
		chassis.cut_overlay(droid_overlay)
		droid_overlay = new(src.icon, icon_state = "repair_droid")
		chassis.add_overlay(droid_overlay)
		active = FALSE
		return PROCESS_KILL


/////////////////////////////////////////// GENERATOR /////////////////////////////////////////////


/obj/item/mecha_parts/mecha_equipment/generator
	name = "等离子引擎"
	desc = "一种使用固态等离子体作为燃料发电的机甲模块。"
	icon_state = "tesla"
	range = MECHA_MELEE
	equipment_slot = MECHA_POWER
	can_be_toggled = TRUE
	active = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	///Type of fuel the generator is using.
	var/fuel_type = /obj/item/stack/sheet/mineral/plasma
	///Actual physical fuel within the generator. Is set in generator_init() to add the starting amount of fuel
	var/obj/item/stack/sheet/fuel = null
	///Fuel used per second while idle, not generating, in units
	var/fuelrate_idle = 0.00625 * SHEET_MATERIAL_AMOUNT
	///Fuel used per second while actively generating, in units
	var/fuelrate_active = 0.05 * SHEET_MATERIAL_AMOUNT
	///Maximum fuel capacity of the generator, in units
	var/max_fuel = 75 * SHEET_MATERIAL_AMOUNT
	///Energy recharged per second
	var/rechargerate = 0.05 * STANDARD_CELL_RATE

/obj/item/mecha_parts/mecha_equipment/generator/Initialize(mapload)
	. = ..()
	generator_init()

/obj/item/mecha_parts/mecha_equipment/generator/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/mecha_parts/mecha_equipment/generator/detach()
	STOP_PROCESSING(SSobj, src)
	active = FALSE
	return ..()

/obj/item/mecha_parts/mecha_equipment/generator/get_snowflake_data()
	return list(
		"snowflake_id" = MECHA_SNOWFLAKE_ID_GENERATOR,
		"fuel" = fuel.amount,
	)

/obj/item/mecha_parts/mecha_equipment/generator/handle_ui_act(action, list/params)
	if(action == "toggle")
		if(active)
			to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_warning("发电已启用。")]")
			START_PROCESSING(SSobj, src)
			log_message("已启动。", LOG_MECHA)
		else
			to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_warning("发电已停用。")]")
			STOP_PROCESSING(SSobj, src)
			log_message("已停用。", LOG_MECHA)
		return TRUE

/obj/item/mecha_parts/mecha_equipment/generator/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, fuel_type))
		return NONE
	load_fuel(tool, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/mecha_parts/mecha_equipment/generator/process(seconds_per_tick)
	if(!chassis)
		active = FALSE
		return PROCESS_KILL
	if(!fuel?.amount)
		active = FALSE
		log_message("已停用——没有燃料。", LOG_MECHA)
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("燃料储备已耗尽。")]")
		return PROCESS_KILL
	var/current_charge = chassis.get_charge()
	if(isnull(current_charge))
		active = FALSE
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("未检测到电池。")]")
		log_message("已停用。", LOG_MECHA)
		return PROCESS_KILL
	//how much fuel are we using per tick
	var/fuel_usage_rate = fuelrate_idle
	if(current_charge < chassis.cell.maxcharge)
		fuel_usage_rate = fuelrate_active
		chassis.give_power(rechargerate * seconds_per_tick)
	fuel.amount -= min(seconds_per_tick * fuel_usage_rate / SHEET_MATERIAL_AMOUNT, fuel.amount)

///Try to insert more fuel into the generator
/obj/item/mecha_parts/mecha_equipment/generator/proc/load_fuel(obj/item/stack/sheet/inserted_fuel, mob/user)
	if(inserted_fuel.amount == 0) //if we somehow have a sheet of 0 fuel
		to_chat(user, "[icon2html(src, user)][span_warning("[fuel] 在目标中含量极微！[inserted_fuel] 无法用作燃料。")]")
		return
	//how much fuel is needed to fill the generator to its max capacity, in units
	var/units_to_load = isnull(fuel) ? max_fuel : max(max_fuel - fuel.amount * SHEET_MATERIAL_AMOUNT, 0)
	if(!units_to_load)
		to_chat(user, "[icon2html(src, user)][span_notice("燃料已满。")]")
		return
	//how much new fuel are we inserting, in sheets
	var/fuel_to_load = min(max(round(units_to_load / SHEET_MATERIAL_AMOUNT), 1), inserted_fuel.amount)
	if(fuel)
		fuel.amount += fuel_to_load
	else
		fuel = new(src, fuel_to_load)
	inserted_fuel.use(fuel_to_load)
	to_chat(user, "[icon2html(src, user)][span_notice("已成功装载 [fuel_to_load] 单位 [fuel]。")]")

///Introduces the actual fuel type to be used, as well as the starting amount of said fuel
/obj/item/mecha_parts/mecha_equipment/generator/proc/generator_init()
	fuel = new /obj/item/stack/sheet/mineral/plasma(src, 10)

/// Version without the initial fuel
/obj/item/mecha_parts/mecha_equipment/generator/printed

/obj/item/mecha_parts/mecha_equipment/generator/printed/generator_init()
	return

/////////////////////////////////////////// THRUSTERS /////////////////////////////////////////////

/obj/item/mecha_parts/mecha_equipment/thrusters
	name = "通用外骨骼推进器" //parent object, in-game sources will be a child object
	desc = "一套来源不明的通用推进器。它使用尚无法解释的方法推动机甲，似乎不消耗任何代价。"
	icon_state = "thrusters"
	equipment_slot = MECHA_UTILITY
	can_be_toggled = TRUE
	active_label = "推进器"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12.5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5)
	var/effect_type = /obj/effect/particle_effect/sparks

/obj/item/mecha_parts/mecha_equipment/thrusters/try_attach_part(mob/user, obj/vehicle/sealed/mecha/mecha, attach_right)
	for(var/obj/item/part in mecha.equip_by_category[MECHA_UTILITY])
		if(istype(part, src))
			to_chat(user, span_warning("[mecha] 已装有这套推进器组件！"))
			return ITEM_INTERACT_BLOCKING
	return ..()

/obj/item/mecha_parts/mecha_equipment/thrusters/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right = FALSE)
	new_mecha.active_thrusters = src //Enable by default
	return ..()

/obj/item/mecha_parts/mecha_equipment/thrusters/detach(atom/moveto)
	if(chassis.active_thrusters == src)
		chassis.active_thrusters = null
	return ..()

/obj/item/mecha_parts/mecha_equipment/thrusters/set_active(active)
	. = ..()
	if(active)
		START_PROCESSING(SSobj, src)
		enable()
		log_message("已启动。", LOG_MECHA)
	else
		STOP_PROCESSING(SSobj, src)
		disable()
		log_message("已停用。", LOG_MECHA)

/obj/item/mecha_parts/mecha_equipment/thrusters/proc/enable()
	if (chassis.active_thrusters == src)
		return
	chassis.active_thrusters = src
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("[src] 已启用。")]")

/obj/item/mecha_parts/mecha_equipment/thrusters/proc/disable()
	if(chassis.active_thrusters != src)
		return
	chassis.active_thrusters = null
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("[src] 已停用。")]")

/obj/item/mecha_parts/mecha_equipment/thrusters/proc/thrust(movement_dir)
	if(!chassis)
		return FALSE
	generate_effect(movement_dir)
	return TRUE //This parent should never exist in-game outside admeme use, so why not let it be a creative thruster?

/obj/item/mecha_parts/mecha_equipment/thrusters/proc/generate_effect(movement_dir)
	var/obj/effect/particle_effect/E = new effect_type(get_turf(chassis))
	E.dir = REVERSE_DIR(movement_dir)
	step(E, REVERSE_DIR(movement_dir))
	QDEL_IN(E, 5)

/obj/item/mecha_parts/mecha_equipment/thrusters/gas
	name = "RCS 推进器组件"
	desc = "一套推进器，可从内置生命维持气罐中喷出气体，让机甲在零重力环境中移动。"
	effect_type = /obj/effect/particle_effect/fluid/smoke
	var/move_cost = 0.05 //moles per step (5 times more than human jetpacks)

/obj/item/mecha_parts/mecha_equipment/thrusters/gas/thrust(movement_dir)
	if(!chassis)
		return FALSE
	var/obj/machinery/portable_atmospherics/canister/internal_tank = chassis.get_internal_tank()
	if(!internal_tank)
		return FALSE
	var/datum/gas_mixture/our_mix = internal_tank.return_air()
	var/moles = our_mix.total_moles()
	if(moles < move_cost)
		our_mix.remove(moles)
		return FALSE
	our_mix.remove(move_cost)
	generate_effect(movement_dir)
	return TRUE

/obj/item/mecha_parts/mecha_equipment/thrusters/ion //for mechs with built-in thrusters, should never really exist un-attached to a mech
	name = "离子推进器组件"
	desc = "一套推进器，可让机甲在零重力环境中移动。"
	detachable = FALSE
	effect_type = /obj/effect/particle_effect/ion_trails

/obj/item/mecha_parts/mecha_equipment/thrusters/ion/thrust(movement_dir)
	if(!chassis)
		return FALSE
	if(chassis.use_energy(chassis.step_energy_drain))
		generate_effect(movement_dir)
		return TRUE
	return FALSE

///////////////////////////////////// CONCEALED WEAPON BAY ////////////////////////////////////////

/obj/item/mecha_parts/mecha_equipment/concealed_weapon_bay
	name = "隐蔽武器舱"
	desc = "一个隔舱，可让非战斗机甲额外装备一件武器，并将武器隐藏于视线之外。"
	icon_state = "mecha_weapon_bay"

/obj/item/mecha_parts/mecha_equipment/concealed_weapon_bay/try_attach_part(mob/user, obj/vehicle/sealed/mecha/M)
	if(M.mech_type & EXOSUIT_MODULE_COMBAT)
		to_chat(user, span_warning("[M] 的螺栓配置不符！"))
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/item/mecha_parts/mecha_equipment/concealed_weapon_bay/special_attaching_interaction(attach_right = FALSE, obj/vehicle/sealed/mecha/mech, mob/user, checkonly = FALSE)
	if(checkonly)
		return TRUE
	var/obj/item/mecha_parts/mecha_equipment/existing_equip
	if(attach_right)
		existing_equip = mech.equip_by_category[MECHA_R_ARM]
	else
		existing_equip = mech.equip_by_category[MECHA_L_ARM]
	if(existing_equip)
		name = existing_equip.name
		icon = existing_equip.icon
		icon_state = existing_equip.icon_state
		qdel(existing_equip)
		user.visible_message(span_notice("[user] 掏空了 [src]，并在里面装了点什么。"), span_notice("你将隐蔽武器舱安装在 [mech] 的 [src] 外壳内。"))
	else
		user.visible_message(span_notice("[user] 将 [src] 安装到了 [mech] 上。"), span_notice("你将 [src] 安装到了 [mech] 上。"))
	attach(mech, attach_right)
	mech.mech_type |= EXOSUIT_MODULE_CONCEALED_WEP_BAY
	return TRUE

/obj/item/mecha_parts/mecha_equipment/concealed_weapon_bay/detach(atom/moveto)
	var/obj/vehicle/sealed/mecha/mech = chassis
	. = ..()
	name = initial(name)
	icon = initial(icon)
	icon_state = initial(icon_state)
	if(!locate(/obj/item/mecha_parts/mecha_equipment/concealed_weapon_bay) in mech.contents) //if no others exist
		mech.mech_type &= ~EXOSUIT_MODULE_CONCEALED_WEP_BAY

/obj/item/mecha_parts/camera_kit
	name = "外骨骼外挂摄像套件"
	desc = "一种安保摄像头，供机甲在移动中进行监控。"
	icon = 'icons/obj/devices/mecha_equipment.dmi'
	icon_state = "mecha_camera"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 2, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/mecha_parts/camera_kit/try_attach_part(mob/user, obj/vehicle/sealed/mecha/mech, attach_right)
	if(mech.chassis_camera)
		balloon_alert(user, "已经装有摄像头了！")
		return ITEM_INTERACT_BLOCKING

	. = ..()

	mech.chassis_camera = new /obj/machinery/camera/exosuit(mech)
	mech.chassis_camera.update_c_tag(mech)
	mech.diag_hud_set_camera()
