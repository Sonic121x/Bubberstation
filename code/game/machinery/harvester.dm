/obj/machinery/harvester
	name = "器官摘取机"
	desc = "用于从死者身上摘取器官和肢体的先进机器。"
	density = TRUE
	icon = 'icons/obj/machines/harvester.dmi'
	icon_state = "harvester"
	base_icon_state = "harvester"
	verb_say = "陈述道"
	state_open = FALSE
	circuit = /obj/item/circuitboard/machine/harvester
	light_color = LIGHT_COLOR_BLUE
	var/interval = 20
	var/harvesting = FALSE
	var/warming_up = FALSE
	var/list/operation_order = list() //Order of wich we harvest limbs.
	var/output_dir = SOUTH //Direction to drop the limbs in
	var/allow_clothing = FALSE
	var/allow_living = FALSE

/obj/machinery/harvester/Initialize(mapload)
	. = ..()
	if(prob(1))
		name = "自动尸检机"

/obj/machinery/harvester/RefreshParts()
	. = ..()
	interval = 0
	var/max_time = 40
	for(var/datum/stock_part/micro_laser/micro_laser in component_parts)
		max_time -= micro_laser.tier
	interval = max(max_time,1)

/obj/machinery/harvester/update_icon_state()
	if(panel_open)
		icon_state = "[base_icon_state]-o"
		return ..()
	if(state_open)
		icon_state = "[base_icon_state]-open"
		return ..()
	if(warming_up)
		icon_state = "[base_icon_state]-charging"
		return ..()
	if(harvesting)
		icon_state = "[base_icon_state]-active"
		return ..()
	icon_state = base_icon_state
	return ..()

/obj/machinery/harvester/open_machine(drop = TRUE, density_to_set = FALSE)
	if(panel_open)
		return
	. = ..()
	warming_up = FALSE
	harvesting = FALSE

/obj/machinery/harvester/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(state_open)
		close_machine()
	else if(!harvesting)
		open_machine()

/obj/machinery/harvester/click_alt(mob/user)
	if(panel_open)
		output_dir = turn(output_dir, -90)
		to_chat(user, span_notice("你更改了[src]的输出设置，将输出方向设为[chinese_direction_display(dir2text(output_dir))]。"))
		return CLICK_ACTION_SUCCESS
	if(harvesting || state_open || !can_harvest())
		return CLICK_ACTION_BLOCKING

	start_harvest()
	return CLICK_ACTION_SUCCESS

/obj/machinery/harvester/proc/can_harvest()
	if(!powered() || state_open || !occupant || !iscarbon(occupant))
		return
	var/mob/living/carbon/carbon_occupant = occupant
	if(!allow_clothing)
		for(var/obj/item/abiotic_item in carbon_occupant.held_items + carbon_occupant.get_equipped_items())
			if(!(HAS_TRAIT(abiotic_item, TRAIT_NODROP)))
				say("目标不得携带非生物物品。")
				playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 30, TRUE)
				return
	if(!(carbon_occupant.mob_biotypes & MOB_ORGANIC))
		say("目标不是有机生物。")
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 30, TRUE)
		return
	if(!allow_living && !IS_DEAD_OR_FAKING(carbon_occupant))
		say("目标仍然活着。")
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 30, TRUE)
		return
	return TRUE

/obj/machinery/harvester/proc/start_harvest()
	if(!occupant || !iscarbon(occupant))
		return

	var/mob/living/carbon/carbon_occupant = occupant

	if(carbon_occupant.client && carbon_occupant.stat <= HARD_CRIT)
		notify_ghosts(
			"[carbon_occupant.real_name]即将被故障的器官摘取机绞碎！",
			source = src,
			header = "惨不忍睹！",
		)

	operation_order = reverse_range(carbon_occupant.get_bodyparts())   //Chest and head are first in bodyparts, so we invert it to make them suffer more
	warming_up = TRUE
	harvesting = TRUE
	visible_message(span_notice("[src]开始预热！"))
	say("正在初始化摘取程序。")
	update_appearance()
	addtimer(CALLBACK(src, PROC_REF(harvest)), interval)

/obj/machinery/harvester/proc/harvest()
	warming_up = FALSE
	update_appearance()
	if(!harvesting || state_open || !powered() || !occupant || !iscarbon(occupant))
		end_harvesting(success = FALSE)
		return
	playsound(src, 'sound/machines/juicer.ogg', 20, TRUE)
	var/mob/living/carbon/carbon_occupant = occupant
	if(!LAZYLEN(operation_order)) //The list is empty, so we're done here
		end_harvesting(success = TRUE)
		return
	var/turf/target = get_step(src, output_dir)
	for(var/obj/item/bodypart/limb_to_remove as anything in operation_order) //first we do non-essential limbs
		limb_to_remove.drop_limb()
		carbon_occupant.emote("scream")
		if(limb_to_remove.body_zone != "chest")
			limb_to_remove.forceMove(target)    //Move the limbs right next to it, except chest, that's a weird one
			limb_to_remove.drop_organs()
		else
			for(var/obj/item/organ/organ_to_remove in limb_to_remove.dismember())
				organ_to_remove.forceMove(target) //Some organs, like chest ones, are different so we need to manually move them
		operation_order.Remove(limb_to_remove)
		break
	use_energy(active_power_usage)
	addtimer(CALLBACK(src, PROC_REF(harvest)), interval)

/obj/machinery/harvester/proc/end_harvesting(success = TRUE)
	warming_up = FALSE
	harvesting = FALSE
	open_machine()
	if (!success)
		say("程序已中断。正在终止摘取。")
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 30, TRUE)
	else
		say("已成功完成目标的器官摘取。")
		playsound(src, 'sound/machines/microwave/microwave-end.ogg', 100, FALSE)

/obj/machinery/harvester/screwdriver_act(mob/living/user, obj/item/tool)
	if(occupant)
		to_chat(user, span_warning("[src]目前有人占用！"))
		return ITEM_INTERACT_BLOCKING
	if(state_open)
		to_chat(user, span_warning("必须先关闭[src]才能[panel_open ? "关闭" : "打开"]维护舱盖！"))
		return ITEM_INTERACT_BLOCKING
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/harvester/crowbar_act(mob/living/user, obj/item/tool)
	return default_pry_open(user, tool, deconstruct_on_fail = TRUE)

/obj/machinery/harvester/can_crowbar_pry_open()
	return !state_open && !panel_open

/obj/machinery/harvester/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	allow_living = TRUE
	allow_clothing = TRUE
	balloon_alert(user, "生命体征扫描仪已过载")
	return TRUE

/obj/machinery/harvester/container_resist_act(mob/living/user)
	if(!harvesting)
		visible_message(span_notice("[occupant]从[src]中出来了！"),
			span_notice("你从[src]中爬了出来！"))
		open_machine()
	else
		to_chat(user,span_warning("[src]正在运行，无法打开！")) //rip

/obj/machinery/harvester/Exited(atom/movable/gone, direction)
	if (!state_open && gone == occupant)
		container_resist_act(gone)
	return ..()

/obj/machinery/harvester/relaymove(mob/living/user, direction)
	if (!state_open)
		container_resist_act(user)

/obj/machinery/harvester/examine(mob/user)
	. = ..()
	if(machine_stat & BROKEN)
		return
	if(state_open)
		. += span_notice("摘取前必须先关闭[src]。")
	else if(!harvesting)
		. += span_notice("按住 Alt 点击[src]可开始摘取。")
	if(in_range(user, src) || isobserver(user))
		. += span_notice("状态显示屏显示：每个器官摘取耗时 <b>[interval*0.1]</b> 秒。输出方向为<b>[chinese_direction_display(dir2text(output_dir))]</b>。")
