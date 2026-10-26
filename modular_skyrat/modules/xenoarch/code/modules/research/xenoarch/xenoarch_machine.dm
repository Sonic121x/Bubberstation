// Researcher, Scanner, Recoverer, and Digger

/obj/machinery/xenoarch
	icon = 'modular_skyrat/modules/xenoarch/icons/xenoarch_machines.dmi'
	density = TRUE
	layer = BELOW_OBJ_LAYER
	use_power = IDLE_POWER_USE
	idle_power_usage = 100
	pass_flags = PASSTABLE
	/// Xenoarch-related things we're currently storing
	var/list/obj/item/xenoarch_contents = list()
	///how long between each process
	var/process_speed = 10 SECONDS
	COOLDOWN_DECLARE(process_delay)

/obj/machinery/xenoarch/Initialize(mapload)
	. = ..()
	register_context()

/obj/machinery/xenoarch/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!held_item)
		return
	switch(held_item.tool_behaviour)
		if(TOOL_WRENCH)
			context[SCREENTIP_CONTEXT_LMB] = "[src.anchored ? "解除固定" : "固定"]"
			return CONTEXTUAL_SCREENTIP_SET
		if(TOOL_SCREWDRIVER)
			context[SCREENTIP_CONTEXT_LMB] = "[src.panel_open ? "关闭" : "打开"]面板"
			return CONTEXTUAL_SCREENTIP_SET
		if(TOOL_CROWBAR)
			if(panel_open)
				context[SCREENTIP_CONTEXT_LMB] = "拆解机器"
				return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/xenoarch/RefreshParts()
	. = ..()
	var/efficiency = -2 //to allow t1 parts to not change the base speed
	for(var/datum/stock_part/stockpart in component_parts)
		efficiency += stockpart.tier

	process_speed = initial(process_speed) - (efficiency)

/obj/machinery/xenoarch/process()
	if(machine_stat & (NOPOWER|BROKEN) || !anchored)
		COOLDOWN_RESET(src, process_delay) //if you are broken or no power (or not anchored), you aren't allowed to progress!
		return

	if(!COOLDOWN_FINISHED(src, process_delay))
		return

	COOLDOWN_START(src, process_delay, process_speed)
	xenoarch_process()

/obj/machinery/xenoarch/proc/xenoarch_process()
	return

/obj/machinery/xenoarch/wrench_act(mob/living/user, obj/item/tool)
	. = ..()

	if(default_unfasten_wrench(user, tool))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/xenoarch/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()

	toggle_panel_open()
	to_chat(user, span_notice("你[panel_open ? "打开":"关闭"]了[src]的检修面板。"))
	tool.play_tool_sound(src)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/xenoarch/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()

	if(default_deconstruction_crowbar(tool))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/xenoarch/researcher
	name = "异星考古研究仪"
	desc = "将奇异岩石、无用遗物和破损物品凝聚为更大文物的机器。"
	icon_state = "researcher"
	circuit = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_researcher
	/// the amount of research that is currently done
	var/current_research = 0
	/// the max amount of value we can have
	var/max_research = 300
	/// the value of each accepted item
	var/static/list/accepted_types = list(
		/obj/item/xenoarch/strange_rock = 1,
		/obj/item/xenoarch/useless_relic = 5,
		/obj/item/xenoarch/useless_relic/magnified = 10,
		/obj/item/xenoarch/broken_item = 10,
	)

/obj/machinery/xenoarch/researcher/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!held_item)
		context[SCREENTIP_CONTEXT_LMB] = "取出全部物品"
		context[SCREENTIP_CONTEXT_RMB] = "使用研究点数"
		return CONTEXTUAL_SCREENTIP_SET
	if(is_type_in_list(held_item, accepted_types))
		context[SCREENTIP_CONTEXT_LMB] = "放入物品"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/storage/bag/xenoarch))
		context[SCREENTIP_CONTEXT_LMB] = "将袋中物品倒入机器"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/xenoarch/researcher/examine(mob/user)
	. = ..()
	. += span_notice("可用研究点数：[current_research]/[max_research]。")

/obj/machinery/xenoarch/researcher/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.combat_mode)
		return ITEM_INTERACT_SKIP_TO_ATTACK

	if(istype(tool, /obj/item/storage/bag/xenoarch))
		for(var/obj/item/strange_rocks in tool.contents)
			if(!is_type_in_list(strange_rocks, accepted_types))
				continue
			strange_rocks.forceMove(src)
			xenoarch_contents += strange_rocks

		balloon_alert(user, "物品已放入！")
		return ITEM_INTERACT_SUCCESS

	if(is_type_in_list(tool, accepted_types))
		tool.forceMove(src)
		xenoarch_contents += tool
		balloon_alert(user, "物品已放入！")
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/xenoarch/researcher/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/choice = tgui_input_list(user, "从[src]中取出岩石？", "取出岩石", list("是", "否"))
	if(choice != "是")
		return

	var/turf/src_turf = get_turf(src)
	for(var/obj/item/removed_item in xenoarch_contents)
		removed_item.forceMove(src_turf)
		xenoarch_contents -= removed_item

	balloon_alert(user, "物品已取出！")

/obj/machinery/xenoarch/researcher/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	var/turf/src_turf = get_turf(src)
	var/choice = tgui_input_list(user, "选择想要的奖励！", "选择奖励", list("熔岩地带宝箱（150）", "异常水晶（150）", "BEPIS 科技（100）"))
	if(!choice)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	switch(choice)
		if("熔岩地带宝箱（150）")
			if(current_research < 150)
				balloon_alert(user, "研究点数不足！")
				return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

			current_research -= 150
			new /obj/structure/closet/crate/necropolis/tendril(src_turf)

		if("异常水晶（150）")
			if(current_research < 150)
				balloon_alert(user, "研究点数不足！")
				return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

			current_research -= 150
			var/list/choices = subtypesof(/obj/machinery/anomalous_crystal)
			var/random_crystal = pick(choices)
			new random_crystal(src_turf)

		if("BEPIS 科技（100）")
			if(current_research < 100)
				balloon_alert(user, "研究点数不足！")
				return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

			current_research -= 100
			new /obj/item/disk/design_disk/bepis/remove_tech(src_turf)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/xenoarch/researcher/xenoarch_process()
	if(length(xenoarch_contents) <= 0)
		return

	if(current_research >= max_research)
		return

	var/obj/item/first_item = xenoarch_contents[1]
	var/reward_attempt = accepted_types[first_item.type]
	current_research = min(current_research + reward_attempt, 300)
	xenoarch_contents -= first_item
	playsound(src, 'sound/machines/ping.ogg', 50, FALSE)
	qdel(first_item)

/obj/machinery/xenoarch/scanner
	name = "异星考古扫描仪"
	desc = "扫描奇异岩石，让提取内部物品更容易的机器。"
	icon_state = "scanner"
	circuit = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_scanner

/obj/machinery/xenoarch/scanner/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(istype(held_item, /obj/item/storage/bag/xenoarch))
		context[SCREENTIP_CONTEXT_LMB] = "扫描袋中物品"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/xenoarch/strange_rock))
		context[SCREENTIP_CONTEXT_LMB] = "扫描物品"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/xenoarch/scanner/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.combat_mode)
		return ITEM_INTERACT_SKIP_TO_ATTACK

	if(istype(tool, /obj/item/storage/bag/xenoarch))
		for(var/obj/item/xenoarch/strange_rock/chosen_rocks in tool.contents)
			chosen_rocks.get_scanned()

		balloon_alert(user, "扫描完成！")
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/xenoarch/strange_rock))
		var/obj/item/xenoarch/strange_rock/chosen_rock = tool
		if(chosen_rock.get_scanned())
			balloon_alert(user, "扫描完成！")
			return ITEM_INTERACT_SUCCESS
		else
			to_chat(user, span_warning("无法扫描[chosen_rock]，也许它已经扫描过了？"))
			return ITEM_INTERACT_BLOCKING

	return ..()

/obj/machinery/xenoarch/recoverer
	name = "异星考古修复器"
	desc = "复原奇异岩石中发现的破损物品的机器。"
	icon_state = "recoverer"
	circuit = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_recoverer
	/// Assoc list of item type to reward pool
	var/static/list/reward_pools = list(
		/obj/item/xenoarch/broken_item/tech = GLOB.tech_reward,
		/obj/item/xenoarch/broken_item/weapon = GLOB.weapon_reward,
		/obj/item/xenoarch/broken_item/illegal = GLOB.illegal_reward,
		/obj/item/xenoarch/broken_item/alien = GLOB.alien_reward,
		/obj/item/xenoarch/broken_item/plant = GLOB.plant_reward,
		/obj/item/xenoarch/broken_item/clothing = GLOB.clothing_reward,
		/obj/item/xenoarch/broken_item/animal = GLOB.animal_reward,
	)

/obj/machinery/xenoarch/recoverer/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!held_item)
		context[SCREENTIP_CONTEXT_LMB] = "取出全部物品"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/xenoarch/broken_item))
		context[SCREENTIP_CONTEXT_LMB] = "放入物品"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/storage/bag/xenoarch))
		context[SCREENTIP_CONTEXT_LMB] = "将袋中物品倒入机器"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/xenoarch/recoverer/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.combat_mode)
		return ITEM_INTERACT_SKIP_TO_ATTACK

	if(istype(tool, /obj/item/storage/bag/xenoarch))
		for(var/obj/item/xenoarch/broken_item/current_item in tool.contents)
			current_item.forceMove(src)
			xenoarch_contents += current_item

		balloon_alert(user, "物品已放入！")
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/xenoarch/broken_item))
		tool.forceMove(src)
		xenoarch_contents += tool
		balloon_alert(user, "物品已放入！")
		return ITEM_INTERACT_SUCCESS

	return ..()

/obj/machinery/xenoarch/recoverer/attack_hand(mob/living/user, list/modifiers)
	var/choice = tgui_input_list(user, "从[src]中取出破损物品？", "取出物品", list("是", "否"))
	if(choice != "是")
		return

	var/turf/src_turf = get_turf(src)
	for(var/obj/item/removed_item in xenoarch_contents)
		removed_item.forceMove(src_turf)
		xenoarch_contents -= removed_item

	balloon_alert(user, "物品已取出！")

/obj/machinery/xenoarch/recoverer/xenoarch_process()
	var/turf/src_turf = get_turf(src)
	if(length(xenoarch_contents) <= 0)
		return

	var/obj/item/content_obj = xenoarch_contents[1]
	if(!istype(content_obj, /obj/item/xenoarch/broken_item))
		xenoarch_contents -= content_obj
		qdel(content_obj)
		return

	var/spawn_item = pick_weight(reward_pools[content_obj.type])
	if(istype(content_obj, /obj/item/xenoarch/broken_item/animal))
		for(var/looptime in 1 to rand(1,4))
			spawn_item = pick_weight(reward_pools[content_obj.type])
			new spawn_item(src_turf)

	recover_item(spawn_item, content_obj)

/obj/machinery/xenoarch/recoverer/proc/recover_item(obj/insert_obj, obj/delete_obj)
	var/src_turf = get_turf(src)
	new insert_obj(src_turf)
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	xenoarch_contents -= delete_obj
	qdel(delete_obj)

/obj/machinery/xenoarch/digger
	name = "异星考古挖掘机"
	desc = "缓慢发掘奇异岩石内物品的机器。"
	icon_state = "digger"
	circuit = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_digger

/obj/machinery/xenoarch/digger/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!held_item)
		context[SCREENTIP_CONTEXT_LMB] = "取出全部物品"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/storage/bag/xenoarch))
		context[SCREENTIP_CONTEXT_LMB] = "将袋中物品倒入机器"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/xenoarch/strange_rock))
		context[SCREENTIP_CONTEXT_LMB] = "放入物品"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/xenoarch/digger/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.combat_mode)
		return ITEM_INTERACT_SKIP_TO_ATTACK

	if(istype(tool, /obj/item/storage/bag/xenoarch))
		for(var/obj/item/xenoarch/strange_rock/strange_rocks in tool.contents)
			strange_rocks.forceMove(src)
			xenoarch_contents += strange_rocks

		balloon_alert(user, "岩石已放入！")
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/xenoarch/strange_rock))
		tool.forceMove(src)
		xenoarch_contents += tool
		balloon_alert(user, "岩石已放入！")
		return ITEM_INTERACT_SUCCESS

	return ..()

/obj/machinery/xenoarch/digger/attack_hand(mob/living/user, list/modifiers)
	var/choice = tgui_input_list(user, "从[src]中取出岩石？", "取出岩石", list("是", "否"))
	if(choice != "是")
		return

	var/turf/src_turf = get_turf(src)
	for(var/obj/item/removed_item in xenoarch_contents)
		removed_item.forceMove(src_turf)
		xenoarch_contents -= removed_item

	balloon_alert(user, "物品已取出！")

/obj/machinery/xenoarch/digger/xenoarch_process()
	var/turf/src_turf = get_turf(src)
	if(length(xenoarch_contents) <= 0)
		return

	var/obj/item/xenoarch/strange_rock/first_item = xenoarch_contents[1]
	new first_item.hidden_item(src_turf)
	xenoarch_contents -= first_item
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	qdel(first_item)
