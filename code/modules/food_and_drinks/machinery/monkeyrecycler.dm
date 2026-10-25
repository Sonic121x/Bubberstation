GLOBAL_LIST_EMPTY(monkey_recyclers)

/obj/machinery/monkey_recycler
	name = "猴子回收机"
	desc = "一台用于把死猴子回收成猴子方块的机器。"
	icon = 'icons/obj/machines/kitchen.dmi'
	icon_state = "grinder"
	base_icon_state = "grinder"
	layer = BELOW_OBJ_LAYER
	interaction_flags_mouse_drop = NEED_DEXTERITY
	density = TRUE
	circuit = /obj/item/circuitboard/machine/monkey_recycler

	var/stored_matter = 0
	var/cube_production = 0.2

/obj/machinery/monkey_recycler/Initialize(mapload)
	. = ..()
	if (mapload)
		GLOB.monkey_recyclers += src
	add_overlay("grinder_monkey")

/obj/machinery/monkey_recycler/Destroy()
	GLOB.monkey_recyclers -= src
	return ..()

/obj/machinery/monkey_recycler/RefreshParts() //Ranges from 0.2 to 0.8 per monkey recycled
	. = ..()
	cube_production = 0
	for(var/datum/stock_part/servo/servo in component_parts)
		cube_production += servo.tier * 0.125 // SKYRAT EDIT CHANGE - buffs to allow 1 cubes per monkey at T4 - ORIGINAL: cube_production += manipulator.tier * 0.1
	for(var/datum/stock_part/matter_bin/matter_bin in component_parts)
		cube_production += matter_bin.tier * 0.125 // SKYRAT EDIT CHANGE - buffs to allow 1 cubes per monkey at T4 - ORIGINAL: cube_production += matter_bin.tier * 0.1

/obj/machinery/monkey_recycler/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("状态显示屏上写着：每投入一只猴子可产出 <b>[cube_production]</b> 个方块。")

/obj/machinery/monkey_recycler/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(default_unfasten_wrench(user, tool))
		power_change()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/monkey_recycler/screwdriver_act(mob/living/user, obj/item/tool)
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/monkey_recycler/crowbar_act(mob/living/user, obj/item/tool)
	return default_pry_open(user, tool, close_after_pry = TRUE, deconstruct_on_fail = TRUE)

/obj/machinery/monkey_recycler/update_icon_state()
	. = ..()
	icon_state = panel_open ? "[base_icon_state]_open" : base_icon_state

/obj/machinery/monkey_recycler/mouse_drop_receive(mob/living/target, mob/living/user, params)
	if(!istype(target))
		return
	if(ismonkey(target))
		stuff_monkey_in(target, user)

/obj/machinery/monkey_recycler/proc/stuff_monkey_in(mob/living/carbon/human/target, mob/living/user)
	if(!istype(target))
		return
	if(!IS_UNCONSCIOUS_OR_CRIT(target))
		to_chat(user, span_warning("这只猴子挣扎得太厉害，没法塞进回收机。"))
		return
	if(target.buckled || target.has_buckled_mobs())
		to_chat(user, span_warning("这只猴子被什么东西固定住了。"))
		return
	qdel(target)
	to_chat(user, span_notice("你把猴子塞进了机器里。"))
	playsound(src.loc, 'sound/machines/juicer.ogg', 50, TRUE)
	var/offset = prob(50) ? -2 : 2
	animate(src, pixel_x = pixel_x + offset, time = 0.2, loop = 200) //start shaking
	use_energy(active_power_usage)
	stored_matter += cube_production
	addtimer(VARSET_CALLBACK(src, pixel_x, base_pixel_x))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), user, span_notice("机器现在储存了相当于 [stored_matter] 只猴子的材料。")))

/obj/machinery/monkey_recycler/interact(mob/user)
	if(stored_matter >= 1)
		to_chat(user, span_notice("机器在压缩绞碎的猴肉时大声嘶鸣。片刻之后，它吐出一个全新的猴子方块。"))
		playsound(src.loc, 'sound/machines/hiss.ogg', 50, TRUE)
		for(var/i in 1 to floor(stored_matter))
			new /obj/item/food/monkeycube(src.loc)
			stored_matter--
		to_chat(user, span_notice("机器的显示屏闪烁，提示还剩相当于 [stored_matter] 只猴子的材料。"))
	else
		to_chat(user, span_danger("机器至少需要相当于 1 只猴子的材料才能产出猴子方块。它目前有 [stored_matter]。"))

/obj/machinery/monkey_recycler/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if(istype(I))
		I.set_buffer(src)
		balloon_alert(user, "已保存到多用工具缓冲区")
		return TRUE
