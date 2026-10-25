/// Consume things that run into the supermatter from the tram. The tram calls forceMove (doesn't call Bump/ed) and not Move, and I'm afraid changing it will do something chaotic
/obj/machinery/power/supermatter_crystal/proc/tram_contents_consume(datum/source, list/tram_contents)
	SIGNAL_HANDLER

	for(var/atom/thing_to_consume as anything in tram_contents)
		Bumped(thing_to_consume)

/obj/machinery/power/supermatter_crystal/proc/eat_bullets(datum/source, obj/projectile/projectile)
	SIGNAL_HANDLER

	var/turf/local_turf = loc
	if(!istype(local_turf))
		return NONE

	var/kiss_power = 0
	if (istype(projectile, /obj/projectile/kiss/death))
		kiss_power = 20000
	else if (istype(projectile, /obj/projectile/kiss))
		kiss_power = 60


	if(!istype(projectile.firer, /obj/machinery/power/emitter))
		investigate_log("被 [key_name(projectile.firer)] 发射的 [projectile] 击中", INVESTIGATE_ENGINE)
	if(projectile.armor_flag != BULLET || kiss_power)
		if(kiss_power)
			psy_coeff = 1
		log_activation(who = projectile.firer, how = projectile.fired_from)
	else
		external_damage_immediate += projectile.damage * bullet_energy * 0.1
		// Stop taking damage at emergency point, yell to players at danger point.
		// This isn't clean and we are repeating [/obj/machinery/power/supermatter_crystal/proc/calculate_damage], sorry for this.
		var/damage_to_be = damage + external_damage_immediate * clamp((emergency_point - damage) / emergency_point, 0, 1)
		if(damage_to_be > danger_point)
			visible_message(span_notice("[src] 在应力下被压缩，抵御住了后续冲击！"))
		playsound(src, 'sound/effects/supermatter.ogg', 50, TRUE)
	if(istype(projectile, /obj/projectile/beam/emitter/hitscan))
		var/obj/projectile/beam/emitter/hitscan/mahlaser = projectile
		if(mahlaser?.integrity_heal)
			damage = max(0, damage - mahlaser?.integrity_heal)
		if(mahlaser?.energy_reduction)
			internal_energy = max(0, internal_energy - mahlaser?.energy_reduction)
		if(mahlaser?.psi_change)
			psy_coeff = clamp(psy_coeff + mahlaser?.psi_change, 0, 1)
	external_power_immediate += projectile.damage * bullet_energy + kiss_power
	if(istype(projectile, /obj/projectile/beam/emitter/hitscan/magnetic))
		absorption_ratio = clamp(absorption_ratio + 0.05, 0.15, 1)

	qdel(projectile)
	return COMPONENT_BULLET_BLOCKED

/obj/machinery/power/supermatter_crystal/singularity_act()
	var/gain = 100
	investigate_log("被奇点吞噬。", INVESTIGATE_ENGINE)
	message_admins("奇点吞噬了一块超物质碎片，现在可以进入第六阶段。")
	visible_message(span_userdanger("[src] 被奇点吞噬了！"))
	var/turf/sm_turf = get_turf(src)
	for(var/mob/hearing_mob as anything in GLOB.player_list)
		if(!is_valid_z_level(get_turf(hearing_mob), sm_turf))
			continue
		SEND_SOUND(hearing_mob, 'sound/effects/supermatter.ogg') //everyone goan know bout this
		to_chat(hearing_mob, span_bolddanger("一阵可怕的尖啸灌满你的双耳，一股恐惧感席卷而来……"))
	qdel(src)
	return gain

/obj/machinery/power/supermatter_crystal/attack_tk(mob/user)
	if(!iscarbon(user))
		return
	var/mob/living/carbon/jedi = user
	to_chat(jedi, span_userdanger("这主意真是太有分量了。"))
	jedi.investigate_log("用念力触碰 [src]，使 [jedi.p_their()] 的大脑化为灰烬。", INVESTIGATE_DEATHS)
	jedi.ghostize()
	var/obj/item/organ/brain/rip_u = locate(/obj/item/organ/brain) in jedi.organs
	if(rip_u)
		rip_u.Remove(jedi)
		qdel(rip_u)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/power/supermatter_crystal/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/scalpel/supermatter))
		var/obj/item/scalpel/supermatter/scalpel = tool
		to_chat(user, span_notice("你小心翼翼地开始用 \the [scalpel] 刮擦 \the [src]……"))
		if(!scalpel.use_tool(src, user, 60, volume=100))
			return ITEM_INTERACT_BLOCKING
		if (!scalpel.usesLeft)
			to_chat(user, span_warning("你没能从 \the [src] 上取下一块薄片！\The [scalpel] 已经不够锋利了。"))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_danger("你从 \the [src] 上取下一块薄片。\The [src] 开始剧烈反应！"))
		new /obj/item/nuke_core/supermatter_sliver(src.drop_location())
		supermatter_sliver_removed = TRUE
		external_power_trickle += 800
		log_activation(who = user, how = scalpel)
		scalpel.usesLeft--
		if (!scalpel.usesLeft)
			to_chat(user, span_notice("\The [scalpel] 上掉下了一小块，它就此报废了！"))
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/hemostat/supermatter))
		to_chat(user, span_warning("你用 [tool] 的超惰性气体尖端戳了戳 [src]。什么也没有发生。"))
		return ITEM_INTERACT_BLOCKING

	if(istype(tool, /obj/item/destabilizing_crystal))
		var/obj/item/destabilizing_crystal/destabilizing_crystal = tool

		if(!is_main_engine)
			to_chat(user, span_warning("你不能对 \a [name] 使用 \the [destabilizing_crystal]。"))
			return ITEM_INTERACT_BLOCKING

		if(get_integrity_percent() < SUPERMATTER_CASCADE_PERCENT)
			to_chat(user, span_warning("你只能对完整度至少为 [SUPERMATTER_CASCADE_PERCENT]% 的 \a [name] 使用 \the [destabilizing_crystal]。"))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_warning("你开始把 \the [destabilizing_crystal] 安装到 \the [src] 上……"))
		if(!do_after(user, 3 SECONDS, src))
			return ITEM_INTERACT_BLOCKING

		message_admins("[ADMIN_LOOKUPFLW(user)] 在 [ADMIN_VERBOSEJMP(src)] 把 [destabilizing_crystal] 安装到了超物质上。")
		user.log_message("把 [destabilizing_crystal] 安装到了超物质上", LOG_GAME)
		user.investigate_log("把 [destabilizing_crystal] 安装到了一块超物质晶体上。", INVESTIGATE_ENGINE)
		to_chat(user, span_danger("\The [destabilizing_crystal] 啪地吸附到了 \the [src] 上。"))
		set_delam(SM_DELAM_PRIO_IN_GAME, /datum/sm_delam/cascade)
		external_damage_immediate += 10
		external_power_trickle += 500
		log_activation(who = user, how = destabilizing_crystal)
		qdel(destabilizing_crystal)
		return ITEM_INTERACT_SUCCESS

	return NONE

//Do not blow up our internal radio
/obj/machinery/power/supermatter_crystal/contents_explosion(severity, target)
	return

/obj/machinery/power/supermatter_crystal/proc/wrench_act_callback(mob/user, obj/item/tool)
	if(moveable)
		default_unfasten_wrench(user, tool)

/obj/machinery/power/supermatter_crystal/proc/consume_callback(matter_increase, damage_increase)
	external_power_trickle += matter_increase
	external_damage_immediate += damage_increase
