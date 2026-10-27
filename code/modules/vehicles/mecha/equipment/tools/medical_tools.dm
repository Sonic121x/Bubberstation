// Sleeper, Medical Beam, and Syringe gun

/obj/item/mecha_parts/mecha_equipment/medical
	mech_flags = EXOSUIT_MODULE_MEDICAL

/obj/item/mecha_parts/mecha_equipment/medical/attach(obj/vehicle/sealed/mecha/new_mecha)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/detach(atom/moveto)
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/mecha_parts/mecha_equipment/medical/process()
	if(!chassis)
		return PROCESS_KILL

/obj/item/mecha_parts/mecha_equipment/proc/get_reagent_data(list/datum/reagent/reagent_list)
	var/list/contained_reagents = list()
	if(length(reagent_list))
		for(var/datum/reagent/reagent as anything in reagent_list)
			contained_reagents += list(list("name" = reagent.name, "volume" = round(reagent.volume, 0.01))) // list in a list because Byond merges the first list...
	return contained_reagents

//---- Mecha sleeper, medical subtype has the chemical functionality
/obj/item/mecha_parts/mecha_equipment/sleeper
	name = "外挂休眠舱"
	desc = "一台外挂式休眠舱，可稳定患者的状况。"
	icon_state = "mecha_sleeper_miner"
	energy_drain = 20
	range = MECHA_MELEE
	equip_cooldown = 20
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5)
	/// ref to the patient loaded in the sleeper
	var/mob/living/carbon/patient

/obj/item/mecha_parts/mecha_equipment/sleeper/Destroy()
	for(var/atom/movable/content as anything in src)
		content.forceMove(get_turf(src))
	return ..()

/obj/item/mecha_parts/mecha_equipment/sleeper/container_resist_act(mob/living/user)
	go_out()

/obj/item/mecha_parts/mecha_equipment/sleeper/action(mob/source, atom/atomtarget, list/modifiers)
	if(!action_checks(atomtarget))
		return
	if(!iscarbon(atomtarget))
		return
	var/mob/living/carbon/target = atomtarget
	if(!patient_insertion_check(target, source))
		return
	to_chat(source, "[icon2html(src, source)][span_notice("你开始把 [target] 放入 [src]……")]")
	chassis.visible_message(span_warning("[chassis] 开始把 [target] 放入 [src]。"))
	if(!do_after(source, get_equip_cooldown(atomtarget), target, extra_checks=CALLBACK(src, PROC_REF(patient_insertion_check), target, source)))
		return
	if(!chassis || !(get_dir(chassis, target) & chassis.dir))
		return
	target.forceMove(src)
	patient = target
	START_PROCESSING(SSobj, src)
	to_chat(source, "[icon2html(src, source)][span_notice("[target] 已成功装入 [src]。生命维持功能已启用。")]")
	chassis.visible_message(span_warning("[chassis] 把 [target] 装入了 [src]。"))
	log_message("[target] 已装入。生命维持功能已启用。", LOG_MECHA)
	return ..()

/obj/item/mecha_parts/mecha_equipment/sleeper/proc/patient_insertion_check(mob/living/carbon/target, mob/user)
	if(!isnull(target.buckled))
		to_chat(user, "[icon2html(src, user)][span_warning("[target] 无法装入休眠舱，因为其被固定在 [target.buckled] 上！")]")
		return FALSE
	if(target.has_buckled_mobs())
		to_chat(user, "[icon2html(src, user)][span_warning("[target] 无法装入休眠舱，因为身上附着有生物！")]")
		return FALSE
	if(patient)
		to_chat(user, "[icon2html(src, user)][span_warning("休眠舱已被占用！")]")
		return FALSE
	return TRUE

/obj/item/mecha_parts/mecha_equipment/sleeper/proc/go_out()
	if(!patient)
		return
	patient.forceMove(get_turf(src))
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("[patient] 已被排出。生命维持功能已停用。")]")
	log_message("[patient] 已被排出。生命维持功能已停用。", LOG_MECHA)
	STOP_PROCESSING(SSobj, src)
	patient = null

/obj/item/mecha_parts/mecha_equipment/sleeper/detach()
	if(patient)
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_warning("无法卸下 [src]——装备内仍有乘员！")]")
		return
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/mecha_parts/mecha_equipment/sleeper/get_snowflake_data()
	var/list/data = list("snowflake_id" = MECHA_SNOWFLAKE_ID_SLEEPER)
	if(isnull(patient))
		return data
	var/patient_state
	switch(patient.stat)
		if(STABLE)
			patient_state = "稳定"
		if(DEAD)
			patient_state = "*死亡*"
		if(SOFT_CRIT, HARD_CRIT)
			patient_state = "危重"
		else
			patient_state = "未知"
	var/core_temp = ""
	if(ishuman(patient))
		var/mob/living/carbon/human/humi = patient
		core_temp = humi.bodytemperature-T0C
	data["patient"] = list(
		"patient_name" = patient.name,
		"patient_health" = patient.health/patient.maxHealth,
		"patient_state" = patient_state,
		"core_temp" = core_temp,
		"brute_loss" = patient.get_brute_loss(),
		"burn_loss" = patient.get_fire_loss(),
		"toxin_loss" = patient.get_tox_loss(),
		"oxygen_loss" = patient.get_oxy_loss(),
	)
	data["contained_reagents"] = get_reagent_data(patient.reagents.reagent_list)
	data["has_brain_damage"] = patient.get_organ_loss(ORGAN_SLOT_BRAIN) != 0
	data["has_traumas"] = length(patient.get_traumas()) != 0

	return data

/obj/item/mecha_parts/mecha_equipment/sleeper/handle_ui_act(action, list/params)
	if(action == "eject")
		go_out()
		return TRUE
	return FALSE

/obj/item/mecha_parts/mecha_equipment/sleeper/process(seconds_per_tick)
	if(!chassis.has_charge(energy_drain))
		log_message("已停用。", LOG_MECHA)
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_warning("[src] 已停用——没有电力。")]")
		STOP_PROCESSING(SSobj, src)
		return
	var/mob/living/carbon/ex_patient = patient
	if(!ex_patient)
		return
	if(ex_patient.loc != src)
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("[patient] 已无法检测到。生命维持功能已停用。")]")
		log_message("[patient] 已无法检测到——生命维持功能已停用。", LOG_MECHA)
		STOP_PROCESSING(SSobj, src)
		patient = null
	ex_patient.adjust_oxy_loss(-2 * seconds_per_tick)
	ex_patient.AdjustStun(-4 SECONDS * seconds_per_tick)
	ex_patient.AdjustKnockdown(-4 SECONDS * seconds_per_tick)
	ex_patient.AdjustParalyzed(-4 SECONDS * seconds_per_tick)
	ex_patient.AdjustImmobilized(-4 SECONDS * seconds_per_tick)
	ex_patient.AdjustUnconscious(-4 SECONDS * seconds_per_tick)
	if(ex_patient.reagents.get_reagent_amount(/datum/reagent/medicine/epinephrine) < 5 \
	&& ex_patient.reagents.get_reagent_amount(/datum/reagent/medicine/c2/penthrite) <= 0 \
	&& ex_patient.stat >= SOFT_CRIT)
		ex_patient.reagents.add_reagent(/datum/reagent/medicine/epinephrine, 5)
	if(ex_patient.reagents.get_reagent_amount(/datum/reagent/toxin/formaldehyde) <= 0 && ex_patient.stat == DEAD)
		ex_patient.reagents.add_reagent(/datum/reagent/toxin/formaldehyde, 3)
	chassis.use_energy(energy_drain)

//Medical subtype with the chems
/obj/item/mecha_parts/mecha_equipment/sleeper/medical
	name = "外挂休眠舱"
	desc = "医疗机甲装备。一台外挂式休眠舱，可稳定患者状况，并能从已装备的机甲注射枪中注入试剂。"
	icon_state = "mecha_sleeper"
	mech_flags = EXOSUIT_MODULE_MEDICAL
	/// amount of chems to inject into patient from other hands syringe gun
	var/inject_amount = 10

/obj/item/mecha_parts/mecha_equipment/sleeper/medical/get_snowflake_data()
	var/list/data = ..()
	if(isnull(patient))
		return data
	var/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/shooter = locate(/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun) in chassis
	if(shooter)
		data["injectible_reagents"] = get_reagent_data(shooter.reagents.reagent_list)
	return data

/obj/item/mecha_parts/mecha_equipment/sleeper/medical/handle_ui_act(action, list/params)
	. = ..()
	if(.)
		return TRUE
	var/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/shooter = locate() in chassis
	if(shooter)
		for(var/datum/reagent/medication as anything in shooter.reagents.reagent_list)
			if(action == ("inject_reagent_" + medication.name))
				inject_reagent(medication, shooter)
				break // or maybe return TRUE? i'm not certain

/obj/item/mecha_parts/mecha_equipment/sleeper/medical/proc/inject_reagent(datum/reagent/reagent_to_inject, obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/SG)
	if(!reagent_to_inject || !patient || !SG || !(SG in chassis.flat_equipment))
		return
	var/to_inject = min(reagent_to_inject.volume, inject_amount)
	if(to_inject && patient.reagents.get_reagent_amount(reagent_to_inject.type) + to_inject <= inject_amount*2)
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("正在向 [patient] 注入 [to_inject] 单位 [reagent_to_inject.name]。")]")
		log_message("正在向 [patient] 注入 [to_inject] 单位 [reagent_to_inject.name]。", LOG_MECHA)
		for(var/driver in chassis.return_drivers())
			log_combat(driver, patient, "injected", "[name] ([reagent_to_inject] - [to_inject] units)")
		SG.reagents.trans_to(patient, to_inject, target_id = reagent_to_inject.type)

///////////////////////////////// Syringe Gun ///////////////////////////////////////////////////////////////

#define FIRE_SYRINGE_MODE 0
#define ANALYZE_SYRINGE_MODE 1

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun
	name = "外骨骼注射枪"
	desc = "医疗机甲装备。带注射枪的化学合成器。内部试剂处于停滞状态，因此不会发生反应。"
	icon_state = "mecha_syringegun"
	range = MECHA_MELEE|MECHA_RANGED
	equip_cooldown = 10
	energy_drain = 10
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	///Lazylist of syringes that we've picked up
	var/list/syringes
	///List of all scanned reagents, starts with epinephrine and multiver
	var/list/datum/reagent/known_reagents
	///List of reagents we want to be creating this processing tick
	var/list/processed_reagents
	///Maximu amount of syringes we can hold
	var/max_syringes = 10
	///Maximum volume of reagents we can hold
	var/max_volume = 75
	///Reagent amount in units we produce per two seconds
	var/synth_speed = 2.5
	///Chooses what kind of action we should perform when clicking
	var/mode = FIRE_SYRINGE_MODE // fire syringe or analyze reagents.

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/Initialize(mapload)
	. = ..()
	create_reagents(max_volume, NO_REACT)
	known_reagents = list(/datum/reagent/medicine/epinephrine="肾上腺素",/datum/reagent/medicine/c2/multiver="穆尔提弗")

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/detach()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/get_snowflake_data()
	var/list/analyzed_reagents = list() // we need to make this list because .tsk wont map over an indexed array
	for(var/i=1 to known_reagents.len)
		var/enabled = FALSE
		if(known_reagents[i] in processed_reagents)
			enabled = TRUE
		analyzed_reagents += list((list("name" = known_reagents[i].name, "enabled" = enabled)))
	var/list/data = list(
		"snowflake_id" = MECHA_SNOWFLAKE_ID_SYRINGE,
		"mode" = mode == FIRE_SYRINGE_MODE ? "发射" : "分析",
		"mode_label" = "操作",
		"syringe" = LAZYLEN(syringes),
		"max_syringe" = max_syringes,
		"reagents" = reagents.total_volume,
		"total_reagents" = reagents.maximum_volume,
		"analyzed_reagents" = analyzed_reagents,
	)
	data["contained_reagents"] = get_reagent_data(reagents.reagent_list)
	return data

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/handle_ui_act(action, list/params)
	if(action == "change_mode")
		mode = !mode
		return TRUE
	else if(action == "purge_all")
		reagents.clear_reagents()
	else
		for(var/i=1 to known_reagents.len)
			var/reagent_id = known_reagents[i]
			if(action == ("purge_reagent_" + known_reagents[i].name))
				reagents.del_reagent(reagent_id)
			else if(action == ("toggle_reagent_" + known_reagents[i].name))
				synthesize(reagent_id)

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/proc/synthesize(reagent)
	if(reagent in processed_reagents)
		LAZYREMOVE(processed_reagents, reagent)
		return
	var/message = "[known_reagents[reagent]]"
	LAZYADD(processed_reagents, reagent)
	if(!LAZYLEN(processed_reagents))
		return

	message += " 已加入生产列表"
	START_PROCESSING(SSobj, src)
	to_chat(usr, message)
	to_chat(usr, "[icon2html(src, usr)][span_notice("试剂处理已开始。")]")
	log_message("试剂处理已开始。", LOG_MECHA)

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/action(mob/source, atom/target, list/modifiers)
	if(!action_checks(target))
		return
	if(istype(target, /obj/item/reagent_containers/syringe))
		return load_syringe(target)
	if(istype(target, /obj/item/storage))//Loads syringes from boxes
		for(var/obj/item/reagent_containers/syringe/S in target.contents)
			load_syringe(S, source)
		return
	if(mode == ANALYZE_SYRINGE_MODE)
		return analyze_reagents(target, source)
	//we're in syringe mode so lets do syringe stuff
	if(!LAZYLEN(syringes))
		to_chat(source, "[icon2html(src, source)]<span class='alert'>未装填注射器。</span>")
		return
	if(reagents.total_volume <= 0)
		to_chat(source, "[icon2html(src, source)]<span class='alert'>没有可用于装填注射器的试剂。</span>")
		return
	if(HAS_TRAIT(source, TRAIT_PACIFISM))
		to_chat(source, span_alert("[src] 内可能装有致命药剂！你不想冒险伤害任何人……"))
		return
	var/obj/item/ammo_casing/syringegun/chambered = new /obj/item/ammo_casing/syringegun(src)
	log_message("已由 [source] 从 [src] 向 [target] 发射了 [chambered]。", LOG_MECHA)
	chambered.fire_casing(target, source, null, 0, 0, null, 0, src)
	return ..()

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/proc/load_syringe(obj/item/reagent_containers/syringe/S, mob/user)
	if(LAZYLEN(syringes) >= max_syringes)
		to_chat(user, "[icon2html(src, user)][span_warning("[src] 的注射器仓已满！")]")
		return FALSE
	if(!chassis.Adjacent(S))
		to_chat(user, "[icon2html(src, user)][span_warning("无法装填注射器！")]")
		return FALSE
	S.reagents.trans_to(src, S.reagents.total_volume, transferred_by = user)
	S.forceMove(src)
	LAZYADD(syringes,S)
	to_chat(user, "[icon2html(src, user)][span_notice("注射器已装填。")]")
	return TRUE

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/proc/analyze_reagents(atom/A, mob/user)
	if(get_dist(src,A) >= 4)
		to_chat(user, "[icon2html(src, user)][span_notice("目标太远了！")]")
		return FALSE
	if(!A.reagents || ismob(A))
		to_chat(user, "[icon2html(src, user)][span_warning("未能从 [A] 获取试剂信息。")]")
		return FALSE
	to_chat(user, "[icon2html(src, user)][span_notice("正在分析试剂……")]")
	for(var/datum/reagent/R in A.reagents.reagent_list)
		if((R.chemical_flags & REAGENT_CAN_BE_SYNTHESIZED) && add_known_reagent(R.type,R.name))
			to_chat(user, "[icon2html(src, user)][span_notice("试剂分析完成，鉴定为 [R.name]，已加入数据库。")]")
	to_chat(user, "[icon2html(src, user)][span_notice("分析完成。")]")
	return TRUE

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/proc/add_known_reagent(r_id,r_name)
	if(r_id in known_reagents)
		return FALSE
	known_reagents += r_id
	known_reagents[r_id] = r_name
	return TRUE

/obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/process(seconds_per_tick)
	. = ..()
	if(.)
		return
	if(!LAZYLEN(processed_reagents) || reagents.total_volume >= reagents.maximum_volume || !chassis.has_charge(energy_drain))
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_alert("试剂处理已停止。")]")
		log_message("试剂处理已停止。", LOG_MECHA)
		return PROCESS_KILL
	var/amount = seconds_per_tick * synth_speed / LAZYLEN(processed_reagents)
	for(var/reagent in processed_reagents)
		reagents.add_reagent(reagent,amount)
		chassis.use_energy(energy_drain)

#undef FIRE_SYRINGE_MODE
#undef ANALYZE_SYRINGE_MODE

///////////////////////////////// Medical Beam ///////////////////////////////////////////////////////////////

/obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam
	name = "外骨骼医疗光束枪"
	desc = "医疗机甲装备。生成一束聚焦的医疗纳米机器人光束。"
	icon_state = "mecha_medigun"
	energy_drain = 10
	range = MECHA_MELEE|MECHA_RANGED
	equip_cooldown = 0
	///The medical gun doing the actual healing. yes its wierd but its better than copypasting the entire thing
	var/obj/item/gun/medbeam/mech/medigun
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*4, /datum/material/plasma = SHEET_MATERIAL_AMOUNT*1.5, /datum/material/gold = SHEET_MATERIAL_AMOUNT*4, /datum/material/diamond =SHEET_MATERIAL_AMOUNT)

/obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/Initialize(mapload)
	. = ..()
	medigun = new(src)

/obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/Destroy()
	QDEL_NULL(medigun)
	return ..()

/obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/process(deltatime)
	. = ..()
	if(. || !length(chassis.occupants))
		return
	if(chassis.weapons_safety)
		medigun.LoseTarget()
	medigun.process(SSOBJ_DT)

/obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/action(mob/source, atom/movable/target, list/modifiers)
	medigun.process_fire(target, loc)

/obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/detach()
	STOP_PROCESSING(SSobj, src)
	medigun.LoseTarget()
	return ..()
