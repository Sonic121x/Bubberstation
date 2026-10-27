
/obj/machinery/power/rbmk2/multitool_act(mob/living/user, obj/item/multitool/tool)

	if(!panel_open)
		balloon_alert(user, "先打开面板！")
		return ITEM_INTERACT_FAILURE

	wires.interact(user)
	return TRUE

/obj/machinery/power/rbmk2/wirecutter_act(mob/living/user, obj/item/tool)

	if(!panel_open)
		balloon_alert(user, "先打开面板！")
		return ITEM_INTERACT_FAILURE

	wires.interact(user)
	return ITEM_INTERACT_SUCCESS

//Deconstruct.
/obj/machinery/power/rbmk2/crowbar_act(mob/living/user, obj/item/attack_item)
	if(jammed)
		force_unjam(attack_item,user,25)
		return ITEM_INTERACT_SUCCESS
	if(stored_rod)
		balloon_alert(user, "先取出反应堆棒！")
		return ITEM_INTERACT_FAILURE
	if(!meltdown && default_deconstruction_crowbar(attack_item))
		if(user)
			var/turf/T = get_turf(user)
			message_admins("[ADMIN_LOOKUPFLW(user)]在[ADMIN_VERBOSEJMP(T)]拆除了[src]。")
			user.log_message("deconstructed [src]", LOG_GAME)
			investigate_log("was deconstructed by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
	return ITEM_INTERACT_SUCCESS

//Open the panel.
/obj/machinery/power/rbmk2/screwdriver_act(mob/living/user, obj/item/attack_item)
	return default_deconstruction_screwdriver(user, attack_item)

//Toggle the reactor on/off.
/obj/machinery/power/rbmk2/wrench_act(mob/living/user, obj/item/attack_item)

	if(jammed)
		balloon_alert(user, "纹丝不动！")
		return ITEM_INTERACT_FAILURE

	toggle_active(user)

	return ITEM_INTERACT_SUCCESS


/obj/machinery/power/rbmk2/welder_act(mob/living/user, obj/item/attack_item)

	if(atom_integrity >= max_integrity)
		balloon_alert(user, "已经修好了！")
		return ITEM_INTERACT_FAILURE
	if (machine_stat & BROKEN)
		balloon_alert(user, "损坏太重，无法修复！")
		return ITEM_INTERACT_FAILURE
	if(!attack_item.tool_start_check(user, amount=1))
		return ITEM_INTERACT_FAILURE

	balloon_alert(user, "正在维修……")
	if(attack_item.use_tool(src, user, 4 SECONDS, volume = 50))
		update_integrity(min(atom_integrity + 50,max_integrity))
		if(atom_integrity >= max_integrity)
			balloon_alert(user, "已完全修复！")
		else
			balloon_alert(user, "已部分修复！")

	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/rbmk2/plunger_act(obj/item/plunger/attacking_plunger, mob/living/user, reinforced)

	if(jammed && force_unjam(attacking_plunger,user,25))
		return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_FAILURE

/obj/machinery/power/rbmk2/emp_act(severity)

	. = ..()

	if(. & EMP_PROTECT_SELF)
		return

	var/chance = 50

	//Order from least dangerous to most dangerous.

	if(prob(chance))
		toggle_active()
		chance -= 10

	if(prob(chance))
		toggle_vents()
		chance -= 10

	if(prob(chance))
		remove_rod(do_throw=prob(50))
		chance -= 10

	if(prob(chance))
		overclocked = rand(0,1)
		chance -= 10

	if(prob(chance))
		cooling_limiter = rand(1,src.cooling_limiter_max/10)*10
		chance -= 10

	if(prob(chance))
		safety = rand(0,1)
		chance -= 10

/obj/machinery/power/rbmk2/emag_act(mob/user, obj/item/card/emag/emag_card)

	if(obj_flags & EMAGGED)
		return FALSE

	playsound(src, SFX_SPARKS, 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	safety = FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "已启用超载！")

	if(user)
		var/turf/T = get_turf(src)
		message_admins("[ADMIN_LOOKUPFLW(user)]在[ADMIN_VERBOSEJMP(T)]用电磁卡使[src]进入超载模式。")
		user.log_message("activated overdrive (emag) for [src]", LOG_GAME)
		investigate_log("was put into overdrive (emag) by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)

	return TRUE

/obj/machinery/power/rbmk2/ex_act(severity, target)
	. = ..()
	if(!.)
		return .
	if(!QDELETED(src))
		jam(null,TRUE)
