/datum/experimentor_result_handler
	/// The name as seen in the UI
	var/name
	/// The FontAwesome icon for the UI
	var/fa_icon
	/// Which scan type triggers this reaction
	var/scantype
	/// Message to display when the experiment begins
	var/start_message_template
	/// The probability of the experiment reaching critical state
	var/critical_prob
	/// Message to display when the critical state triggers
	var/critical_message_template
	/// The span for the visible message
	var/start_message_type = MSG_TYPE_NOTICE
	/// This reaction handler has bespoke handing
	var/is_special = FALSE

/datum/experimentor_result_handler/proc/execute(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	var/final_message = replacetext(start_message_template, "%ITEM%", exp_on)
	machine.show_start_message(final_message, start_message_type)

	var/critical = machine.is_critical_reaction(exp_on)
	if(critical && prob(critical_prob))
		handle_critical(machine, exp_on)
		return

	handle_malfunctions(machine, exp_on)

/datum/experimentor_result_handler/proc/handle_critical(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	if(critical_message_template)
		var/final_critical_message = replacetext(critical_message_template, "%ITEM%", exp_on)
		machine.visible_message(span_notice(final_critical_message))

/datum/experimentor_result_handler/proc/handle_malfunctions(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	return

/// Pokes the object
/datum/experimentor_result_handler/scan/poke
	name = "戳刺"
	fa_icon = "hand"
	scantype = SCANTYPE_POKE
	start_message_template = "用机械臂戳了戳 %ITEM%。"
	critical_prob = EFFECT_PROB_LOW
	critical_message_template = "%ITEM% 被以恰到好处的方式夹住，聚焦效果增强了。"

/datum/experimentor_result_handler/scan/poke/handle_critical(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	..()
	machine.critical_malfunction_counter++
	machine.RefreshParts()

/datum/experimentor_result_handler/scan/poke/handle_malfunctions(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	var/malf_chance = machine.get_malfunction_chance()

	if(prob(EFFECT_PROB_VERYLOW * malf_chance))
		machine.visible_message(span_danger("[machine] 发生故障并摧毁了 [exp_on]，机械臂疯狂抽向附近的人！"))
		for(var/mob/living/nearby_mob in oview(1, machine))
			nearby_mob.apply_damage(15, BRUTE, pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST))
			machine.investigate_log("实验机对 [nearby_mob] 造成了轻微钝击伤害。", INVESTIGATE_EXPERIMENTOR)
		QDEL_NULL(machine.loaded_item)

	else if(prob(EFFECT_PROB_LOW * malf_chance))
		machine.visible_message(span_warning("[machine] 发生故障！"))
		machine.run_experiment(SCANTYPE_OBLITERATE)

	else if(prob(EFFECT_PROB_MEDIUM * malf_chance))
		machine.visible_message(span_danger("[machine] 发生故障，把 [exp_on] 扔了出去！"))
		var/mob/living/target = locate(/mob/living) in oview(7, machine)
		if(target)
			var/obj/item/throwing = machine.loaded_item
			machine.investigate_log("实验机把 [machine.loaded_item] 扔向了 [key_name(target)]", INVESTIGATE_EXPERIMENTOR)
			machine.item_eject()
			if(throwing)
				throwing.throw_at(target, 10, 1)

/// Infuses it with radiation
/datum/experimentor_result_handler/scan/irradiate
	name = "辐照"
	fa_icon = "radiation"
	scantype = SCANTYPE_IRRADIATE
	start_message_template = "朝 %ITEM% 反射出放射线！"
	start_message_type = MSG_TYPE_DANGER
	critical_prob = EFFECT_PROB_VERYLOW
	critical_message_template = "%ITEM% 激活了一个未知子程序！"

/datum/experimentor_result_handler/scan/irradiate/handle_critical(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	..()
	machine.investigate_log("实验机制造了 [exp_on] 的克隆体", INVESTIGATE_EXPERIMENTOR)
	machine.item_eject(TRUE)

/datum/experimentor_result_handler/scan/irradiate/handle_malfunctions(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	var/malf_chance = machine.get_malfunction_chance()

	if(prob(EFFECT_PROB_VERYLOW * malf_chance))
		machine.visible_message(span_danger("[machine] 发生故障，熔化了 [exp_on] 并泄漏出辐射！"))
		playsound(machine, 'sound/effects/supermatter.ogg', 50, TRUE, -3)
		radiation_pulse(machine, max_range = 6, threshold = 0.3)
		QDEL_NULL(machine.loaded_item)

	else if(prob(EFFECT_PROB_LOW * malf_chance))
		machine.visible_message(span_warning("[machine] 发生故障，喷出有毒废料！"))
		for(var/turf/T in oview(1, machine))
			if(!T.density && prob(EFFECT_PROB_VERYHIGH) && !(locate(/obj/effect/decal/cleanable/greenglow) in T))
				new /obj/effect/decal/cleanable/greenglow/filled(T)
		QDEL_NULL(machine.loaded_item)

	else if(prob(EFFECT_PROB_MEDIUM * malf_chance))
		var/savedName = "[exp_on]"
		QDEL_NULL(machine.loaded_item)
		var/newPath = text2path(pick_weight(machine.valid_items))
		machine.loaded_item = new newPath(machine)
		machine.visible_message(span_warning("[machine] 发生故障，把 [savedName] 变成了 [machine.loaded_item]！"))
		machine.investigate_log("实验机把 [savedName] 变成了 [machine.loaded_item]", INVESTIGATE_EXPERIMENTOR)

		if(istype(machine.loaded_item, /obj/item/grenade/chem_grenade))
			var/obj/item/grenade/chem_grenade/CG = machine.loaded_item
			CG.detonate()

		machine.item_eject()

/// Fills the chamber with gas
/datum/experimentor_result_handler/scan/gas
	name = "气体"
	fa_icon = "cloud"
	scantype = SCANTYPE_GAS
	start_message_template = "往反应腔里充满气体，%ITEM% 也泡在其中。"
	start_message_type = MSG_TYPE_WARNING
	critical_prob = EFFECT_PROB_LOW
	critical_message_template = "%ITEM% 达到了完美的配比！"

/datum/experimentor_result_handler/scan/gas/handle_critical(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	..()
	new /obj/item/stack/sheet/mineral/plasma(get_turf(pick(oview(1, machine))))

/datum/experimentor_result_handler/scan/gas/handle_malfunctions(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	var/malf_chance = machine.get_malfunction_chance()
	var/chosenchem

	if(prob(EFFECT_PROB_VERYLOW * malf_chance))
		machine.visible_message(span_danger("[machine] 摧毁了 [exp_on]，泄漏出危险气体！"))
		chosenchem = pick(
			/datum/reagent/carbon,
			/datum/reagent/uranium/radium,
			/datum/reagent/toxin,
			/datum/reagent/consumable/condensedcapsaicin,
			/datum/reagent/drug/mushroomhallucinogen,
			/datum/reagent/drug/space_drugs,
			/datum/reagent/consumable/ethanol,
			/datum/reagent/consumable/ethanol/beepsky_smash,
		)
		do_chem_smoke(0, machine, machine.loc, chosenchem, 50)
		machine.investigate_log("实验机释放了 [chosenchem] 烟雾。", INVESTIGATE_EXPERIMENTOR)
		playsound(machine, 'sound/effects/smoke.ogg', 50, TRUE, -3)
		QDEL_NULL(machine.loaded_item)

	else if(prob(EFFECT_PROB_VERYLOW * malf_chance))
		machine.visible_message(span_danger("[machine] 的化学腔室漏了！"))
		chosenchem = pick(
			/datum/reagent/mutationtoxin/classic,
			/datum/reagent/cyborg_mutation_nanomachines,
			/datum/reagent/toxin/acid,
		)
		do_chem_smoke(0, machine, machine.loc, chosenchem, 50)
		playsound(machine, 'sound/effects/smoke.ogg', 50, TRUE, -3)
		QDEL_NULL(machine.loaded_item)
		machine.warn_admins(usr, "[chosenchem] 烟雾")
		machine.investigate_log("实验机释放了 <font color='red'>[chosenchem]</font> 烟雾！", INVESTIGATE_EXPERIMENTOR)

	else if(prob(EFFECT_PROB_LOW * malf_chance))
		machine.visible_message(span_warning("[machine] 发生故障，喷出无害气体。"))
		do_smoke(1, machine, machine.loc)

	else if(prob(EFFECT_PROB_MEDIUM * malf_chance))
		machine.visible_message(span_warning("[machine] 熔化了 [exp_on]，把周围的空气电离了！"))
		empulse(machine.loc, 4, 6, emp_source = machine)
		machine.investigate_log("实验机产生了一次电磁脉冲。", INVESTIGATE_EXPERIMENTOR)
		QDEL_NULL(machine.loaded_item)

/// Heats the object
/datum/experimentor_result_handler/scan/heat
	name = "加热"
	fa_icon = "fire"
	scantype = SCANTYPE_HEAT
	start_message_template = "升高了 %ITEM% 的温度。"
	start_message_type = MSG_TYPE_NOTICE
	critical_prob = EFFECT_PROB_LOW
	critical_message_template = "%ITEM% 的应急冷却系统发出了一声轻响！"

/datum/experimentor_result_handler/scan/heat/handle_critical(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	..()
	playsound(machine, 'sound/machines/ding.ogg', 50, TRUE)

	var/obj/item/reagent_containers/cup/glass/coffee/C = new /obj/item/reagent_containers/cup/glass/coffee(get_turf(pick(oview(1, machine))))
	var/chosenchem = pick(
		/datum/reagent/toxin/plasma,
		/datum/reagent/consumable/capsaicin,
		/datum/reagent/consumable/ethanol,
	)
	C.reagents.remove_all(25)
	C.reagents.add_reagent(chosenchem, 50)
	C.name = "一杯可疑液体"
	C.desc = "杯身侧面用褪色的油墨印着一个大大的危险标志。"
	machine.investigate_log("实验机泡了一杯 [chosenchem] 咖啡。", INVESTIGATE_EXPERIMENTOR)

/datum/experimentor_result_handler/scan/heat/handle_malfunctions(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	var/malf_chance = machine.get_malfunction_chance()

	if(prob(EFFECT_PROB_VERYLOW * malf_chance))
		var/turf/start = get_turf(machine)
		var/mob/target_mob = locate(/mob/living) in view(machine, 3)
		var/turf/target_turf = get_turf(target_mob)

		if(target_turf)
			machine.visible_message(span_danger("[machine] 危险地过热，射出一颗燃烧的燃料球！"))
			machine.investigate_log("实验机向 [target_mob] 发射了一颗 <font color='red'>火球</font>！", INVESTIGATE_EXPERIMENTOR)
			var/obj/projectile/magic/fireball/FB = new /obj/projectile/magic/fireball(start)
			FB.aim_projectile(target_turf, start)
			FB.fire()

	else if(prob(EFFECT_PROB_LOW * malf_chance))
		machine.visible_message(span_danger("[machine] 发生故障，熔化了 [exp_on] 并喷出一团火焰！"))
		explosion(machine, devastation_range = -1, flame_range = 2, adminlog = FALSE)
		machine.investigate_log("实验机引发了火灾。", INVESTIGATE_EXPERIMENTOR)
		QDEL_NULL(machine.loaded_item)

	else if(prob(EFFECT_PROB_MEDIUM * malf_chance))
		machine.visible_message(span_warning("[machine] 发生故障，熔化了 [exp_on] 并泄漏出热空气！"))
		var/datum/gas_mixture/env = machine.loc.return_air()
		if(env)
			var/heat_capacity = max(env.heat_capacity(), 1)
			env.temperature = min((env.temperature * heat_capacity + 100000) / heat_capacity, 1000)
		machine.air_update_turf(FALSE, FALSE)
		machine.investigate_log("实验机释放了热空气。", INVESTIGATE_EXPERIMENTOR)
		QDEL_NULL(machine.loaded_item)

	else if(prob(EFFECT_PROB_MEDIUM * malf_chance))
		machine.visible_message(span_warning("[machine] 发生故障，启动了应急冷却系统！"))
		do_smoke(1, machine, machine.loc)
		for(var/mob/living/nearby_mob in oview(1, machine))
			nearby_mob.apply_damage(5, BURN, pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST))
			machine.investigate_log("实验机对 [key_name(nearby_mob)] 造成了轻微灼伤", INVESTIGATE_EXPERIMENTOR)
		machine.item_eject()

/// Cools the object
/datum/experimentor_result_handler/scan/cold
	name = "冷冻"
	fa_icon = "snowflake"
	scantype = SCANTYPE_COLD
	start_message_template = "降低了 %ITEM% 的温度。"
	start_message_type = MSG_TYPE_NOTICE
	critical_prob = EFFECT_PROB_LOW
	critical_message_template = "%ITEM% 的应急冷却系统发出了一声轻响！"

/datum/experimentor_result_handler/scan/cold/handle_critical(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	..()
	playsound(machine, 'sound/machines/ding.ogg', 50, TRUE)

	var/obj/item/reagent_containers/cup/glass/coffee/C = new /obj/item/reagent_containers/cup/glass/coffee(get_turf(pick(oview(1, machine))))
	var/chosenchem = pick(
		/datum/reagent/uranium,
		/datum/reagent/consumable/frostoil,
		/datum/reagent/medicine/ephedrine,
	)
	C.reagents.remove_all(25)
	C.reagents.add_reagent(chosenchem, 50)
	C.name = "一杯可疑液体"
	C.desc = "杯身侧面用褪色的油墨印着一个大大的危险标志。"
	machine.investigate_log("实验机泡了一杯 [chosenchem] 咖啡。", INVESTIGATE_EXPERIMENTOR)

/datum/experimentor_result_handler/scan/cold/handle_malfunctions(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	var/malf_chance = machine.get_malfunction_chance()

	if(prob(EFFECT_PROB_VERYLOW * malf_chance))
		machine.visible_message(span_danger("[machine] 发生故障，震碎了 [exp_on] 并释放出一团危险的冷却剂云雾！"))
		do_chem_smoke(0, machine, machine.loc, /datum/reagent/consumable/frostoil, 50)
		machine.investigate_log("实验机释放了低温油气体。", INVESTIGATE_EXPERIMENTOR)
		playsound(machine, 'sound/effects/smoke.ogg', 50, TRUE, -3)
		QDEL_NULL(machine.loaded_item)

	else if(prob(EFFECT_PROB_LOW * malf_chance))
		machine.visible_message(span_warning("[machine] 发生故障，震碎了 [exp_on] 并泄漏出冷空气！"))
		var/datum/gas_mixture/env = machine.loc.return_air()
		if(env)
			var/heat_capacity = max(env.heat_capacity(), 1)
			env.temperature = max((env.temperature * heat_capacity - 75000) / heat_capacity, TCMB)
		machine.air_update_turf(FALSE, FALSE)
		machine.investigate_log("实验机释放了冷空气。", INVESTIGATE_EXPERIMENTOR)
		QDEL_NULL(machine.loaded_item)

	else if(prob(EFFECT_PROB_MEDIUM * malf_chance))
		machine.visible_message(span_warning("[machine] 发生故障，随着 [exp_on] 弹出，释放出一阵刺骨的寒气！"))
		do_smoke(1, machine, machine.loc)
		machine.item_eject()

/// Crushes the object
/datum/experimentor_result_handler/scan/obliterate
	name = "粉碎"
	fa_icon = "trash"
	scantype = SCANTYPE_OBLITERATE
	start_message_template = "启动了粉碎机构，%ITEM% 被摧毁了！"
	start_message_type = MSG_TYPE_WARNING
	critical_prob = EFFECT_PROB_LOW
	critical_message_template = "%ITEM% 的粉碎机构缓慢而平稳地降下，把 %ITEM% 压扁了！"

/datum/experimentor_result_handler/scan/obliterate/handle_critical(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	..()
	new /obj/item/stack/sheet/plasteel(get_turf(pick(oview(1, machine))))

/datum/experimentor_result_handler/scan/obliterate/handle_malfunctions(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	var/malf_chance = machine.get_malfunction_chance()

	if(prob(EFFECT_PROB_VERYLOW * malf_chance))
		machine.visible_message(span_danger("[machine] 的粉碎机高出了太多层级，直接碾穿了时空！"))
		playsound(machine, 'sound/effects/supermatter.ogg', 50, TRUE, -3)
		machine.investigate_log("实验机触发了“乱扔东西”反应。", INVESTIGATE_EXPERIMENTOR)

		for(var/atom/movable/AM in oview(7, machine))
			if(!AM.anchored)
				AM.throw_at(machine, 10, 1)

	else if(prob(EFFECT_PROB_LOW * malf_chance))
		machine.visible_message(span_danger("[machine] 的粉碎机高出了一个层级，直接碾进了时空！"))
		playsound(machine, 'sound/effects/supermatter.ogg', 50, TRUE, -3)
		machine.investigate_log("实验机触发了“轻度乱扔东西”反应。", INVESTIGATE_EXPERIMENTOR)

		var/list/throw_at = list()
		for(var/atom/movable/AM in oview(7, machine))
			if(!AM.anchored)
				throw_at.Add(AM)

		for(var/counter in 1 to throw_at.len)
			var/atom/movable/cast = throw_at[counter]
			cast.throw_at(pick(throw_at), 10, 1)

	QDEL_NULL(machine.loaded_item)

/// Discovers relic properties
/datum/experimentor_result_handler/scan/discover
	scantype = SCANTYPE_DISCOVER
	start_message_template = "扫描了 %ITEM%，揭示了它的真实本质！"
	start_message_type = MSG_TYPE_NOTICE
	is_special = TRUE

/datum/experimentor_result_handler/scan/discover/execute(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	var/final_message = replacetext(start_message_template, "%ITEM%", exp_on)
	machine.show_start_message(final_message, start_message_type)
	playsound(machine, 'sound/effects/supermatter.ogg', 50, 3, -1)

	var/obj/item/relic/loaded_artifact = machine.loaded_item
	if(loaded_artifact)
		loaded_artifact.reveal()
		machine.investigate_log("实验机揭示了一件遗物，其效果为 [span_danger("[loaded_artifact.hidden_power]")]。", INVESTIGATE_EXPERIMENTOR)
	machine.item_eject()

/// Experiment failure
/datum/experimentor_result_handler/fail
	start_message_type = MSG_TYPE_WARNING
	is_special = TRUE

/datum/experimentor_result_handler/fail/execute(obj/machinery/rnd/experimentor/machine, obj/item/exp_on)
	var/a = pick("隆隆作响", "摇晃", "震动", "颤抖", "鸣喇叭")
	var/b = pick("被压碎", "被旋转", "被开膛破肚", "被砸碎", "遭到辱骂")
	machine.visible_message(span_warning("[exp_on] [a]，然后 [b]，实验失败了。"))
