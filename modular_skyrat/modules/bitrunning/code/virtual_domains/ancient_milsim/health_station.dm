/obj/machinery/health_station
	name = "\improper N-URSEI 自动医疗套件"
	desc = "N-URSEI，通常被简称为“护士”，是 CIN 医疗技术领域一款广为人知的产品。其名称来源尚有争议，\
	但一般认为它源自更老旧、更不便携的型号，那些型号被亲切地称为“母熊”，需要用专门的轻型卡车运往战场。\
	这些没那么笨重的型号能够进行诊断、治疗、勉强算得上的预防，以及预后判断；\
	它们还能进行有限的药物合成，用来灌装各种专有且无品牌的医疗笔型号。"
	icon = 'modular_skyrat/modules/bitrunning/icons/health_station.dmi'
	icon_state = "health_station"
	base_icon_state = "health_station"
	light_color = "#79F8E6"
	interaction_flags_machine = INTERACT_MACHINE_REQUIRES_LITERACY
	anchored = TRUE
	///Options, obviously
	var/static/list/radial_options = list("生命体征扫描" = radial_scan, "治愈创伤" = radial_wound, "治疗损伤" = radial_damage)
	///Maximum amount of nondescript healing fluid
	var/max_charge_amount = 100
	///Current amount of nondescript healing fluid available
	var/charge_amount
	///Regeneration rate of nondescript healing fluid
	var/charge_rate = 5 SECONDS
	///Medipens that it can refill and their attached nondescript healing fluid costs
	var/list/refillable_pens = list(
		/obj/item/reagent_containers/hypospray/medipen/glucose = 5, //it's a useless flavor item
		/obj/item/reagent_containers/hypospray/medipen = 10,
		/obj/item/reagent_containers/hypospray/medipen/atropine = 10,
		/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = 10,
		/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin = 10,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lipital = 10,
		/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = 10,
	)
	var/static/radial_scan = image(icon = 'icons/obj/devices/scanner.dmi', icon_state = "health")
	var/static/radial_wound = image(icon = 'icons/obj/medical/surgery_tools.dmi', icon_state = "scalpel")
	var/static/radial_damage = image(icon = 'icons/obj/medical/stack_medical.dmi', icon_state = "suture_3")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/health_station, 32)

/obj/machinery/health_station/Initialize(mapload,ndir,building)
	. = ..()
	if(mapload)
		charge_amount = max_charge_amount
		find_and_mount_on_atom()
	else
		charge_amount = 0
	addtimer(CALLBACK(src, PROC_REF(charge)), charge_rate)

/obj/machinery/health_station/update_appearance(updates = ALL)
	. = ..()
	if(machine_stat & (BROKEN))
		set_light(0)
		return
	set_light(powered() ? MINIMUM_USEFUL_LIGHT_RANGE : 0)

/obj/machinery/health_station/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return FALSE

	if(charge_amount >= 0)
		switch(charge_amount)
			if(60 to 100)
				. += "[base_icon_state]_light1"
			if(30 to 60)
				. += "[base_icon_state]_light2"
			if(15 to 30)
				. += "[base_icon_state]_light3"
			else
				. += "[base_icon_state]_light4"

/obj/machinery/health_station/examine(mob/living/carbon/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("状态显示屏显示：生物质百分比为 [charge_amount]%。")

/obj/machinery/health_station/attack_ghost(mob/user)
	examine(user)

/obj/machinery/health_station/ui_interact(mob/living/carbon/user)
	. = ..()
	open_options_menu(user)

/obj/machinery/health_station/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(refill_pen(attacking_item, user))
		return COMPONENT_NO_AFTERATTACK
	return NONE

/obj/machinery/health_station/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	deconstruct()

/obj/machinery/health_station/on_deconstruction()
	new /obj/item/wallframe/health_station(loc)
	qdel(src)

/obj/machinery/health_station/proc/open_options_menu(mob/living/carbon/user)
	if(!ishuman(user) && (machine_stat & NOPOWER))
		return

	var/choice = show_radial_menu(user, src, radial_options, require_near = !issilicon(user), tooltips = TRUE)

	switch(choice)
		if("生命体征扫描")
			healthscan(user, user, scanpower = SCANPOWER_ADVANCED)
			chemscan(user, user)
			balloon_alert(user, "正在分析生命体征")
			playsound(user.loc, 'sound/items/healthanalyzer.ogg', 40, TRUE)
		if("治愈创伤")
			playsound(user.loc, 'sound/machines/ping.ogg', 40, TRUE)
			heal_wound(user)
		if("治疗损伤")
			playsound(user.loc, 'sound/machines/ping.ogg', 40, TRUE)
			heal_damage(user)

/obj/machinery/health_station/proc/charge()
	charge_amount = clamp(charge_amount + 10, 0, max_charge_amount)
	update_appearance()
	addtimer(CALLBACK(src, PROC_REF(charge)), charge_rate)

/obj/machinery/health_station/proc/refill_pen(attacking_item, mob/living/carbon/user)
	if(istype(attacking_item, /obj/item/reagent_containers/hypospray/medipen))
		var/obj/item/reagent_containers/hypospray/medipen/medipen = attacking_item
		if(!(LAZYFIND(refillable_pens, medipen.type)))
			balloon_alert(user, "医疗笔不兼容！")
			return
		if(medipen.reagents?.reagent_list.len)
			balloon_alert(user, "医疗笔已满！")
			return
		var/charge_taken = is_type_in_list(medipen, refillable_pens, zebra = TRUE)
		if(charge_amount < charge_taken)
			balloon_alert(user, "生物质不足！")
			return
		if(do_after(user, 2 SECONDS, src))
			medipen.used_up = FALSE
			medipen.add_initial_reagents()
			charge_amount -= charge_taken
		balloon_alert(user, "医疗笔已补充！")
		playsound(src, 'sound/items/hypospray.ogg', 40, TRUE)
		update_appearance()
	return TRUE

/obj/machinery/health_station/proc/heal_wound(mob/living/carbon/user)
	if(charge_amount < 20)
		balloon_alert(user, "生物质不足！")
		return FALSE

	if(!user.all_wounds)
		balloon_alert(user, "没有创伤！")
		return FALSE

	if(do_after(user, 5 SECONDS, src))
		var/datum/wound/wound2fix = user.all_wounds[1]
		wound2fix.remove_wound()
		balloon_alert(user, "创伤已处理")
		charge_amount -= 20
		playsound(src, 'sound/items/handling/surgery/saw.ogg', 40, TRUE)
		update_appearance()
	return TRUE

/obj/machinery/health_station/proc/heal_damage(mob/living/carbon/user)
	var/overall_damage = (user.get_tox_loss() + user.get_oxy_loss() + user.get_fire_loss() + user.get_brute_loss())
	if(charge_amount < 15)
		balloon_alert(user, "生物质不足！")
		return FALSE

	if(overall_damage)
		if(do_after(user, 2.5 SECONDS, src))
			var/need_mob_update
			need_mob_update += user.heal_overall_damage(overall_damage/2, overall_damage/2, updating_health = FALSE) //gee i wish overall damage included all types of damage instead of just brute and burn
			need_mob_update += user.adjust_tox_loss(-overall_damage/2, updating_health = FALSE)
			need_mob_update += user.adjust_oxy_loss(-overall_damage/2, updating_health = FALSE)
			if(need_mob_update)
				user.updatehealth()
			balloon_alert(user, "损伤已治疗")
			charge_amount -= 15
			playsound(src, 'sound/items/handling/surgery/retractor1.ogg', 40, TRUE)
			update_appearance()
	else
		balloon_alert(user, "没有损伤！")
		return FALSE

	return TRUE

/obj/item/wallframe/health_station
	name = "拆下的 N-URSEI 套件"
	desc = "一台未安装的医疗站。把它装到墙上即可使用。"
	icon = 'modular_skyrat/modules/bitrunning/icons/health_station.dmi'
	icon_state = "health_station_item"
	w_class = WEIGHT_CLASS_HUGE
	result_path = /obj/machinery/health_station
	wall_external = TRUE
	pixel_shift = 32
