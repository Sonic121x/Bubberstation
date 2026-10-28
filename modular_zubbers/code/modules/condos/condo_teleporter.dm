/// Essentially a rewritten version of Hilbert's Hotel that supports multiple map templates; and a reference to GMTower's beautiful condo system. You should play it's successor... :3
/obj/machinery/cafe_condo_teleporter
	name = "矩阵传送单元"
	desc = "一套分区的稳定传送系统，配有看不见的中央处理枢纽。"
	icon = /obj/machinery/teleport/hub::icon
	icon_state = /obj/machinery/teleport/hub::icon_state
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/cafe_condo_teleporter/examine(mob/user)
	. = ..()
	. += span_notice("你可以用它退居到一间私人房间。")
	. += span_warning("注意：一旦所有住户离开房间，它就会重置。")

/obj/machinery/cafe_condo_teleporter/attack_robot(mob/user)
	if(user.Adjacent(src))
		prompt_and_check_in(user, user)
	return TRUE

/obj/machinery/cafe_condo_teleporter/attack_hand(mob/living/user, list/modifiers)
	prompt_and_check_in(user, user)
	return TRUE

/obj/machinery/cafe_condo_teleporter/attack_tk(mob/user)
	to_chat(user, span_notice("\The [src] 主动排斥你的心智，环绕其周围的蓝空间能量干扰了你的念力。"))
	return COMPONENT_CANCEL_ATTACK_CHAIN

/// They're adjacent - ask them for their desired room number and, if it's new; what archetype they want.
/obj/machinery/cafe_condo_teleporter/proc/prompt_and_check_in(mob/user, mob/target)
	var/requested_condo = tgui_input_number(target, "你要入住几号房间？", "房间号", 1, min_value = 1)
	if(!requested_condo)
		return
	if(requested_condo > SHORT_REAL_LIMIT)
		to_chat(target, span_warning("该网络只接入了 [SHORT_REAL_LIMIT] 个房间！"))
		return
	if((requested_condo < 1) || (requested_condo != round(requested_condo)))
		to_chat(target, span_warning("这不是有效的房间号！"))
		return
	if(!check_target_eligibility(target))
		return

	if(SScondos.active_condos["[requested_condo]"])
		SScondos.enter_active_room(requested_condo, target)

	else
		var/datum/map_template/chosen_condo
		var/map = tgui_input_list(user, "你要入住哪种公寓？","公寓类型", sort_list(SScondos.condo_templates))
		if(!map || !check_target_eligibility(target))
			return
		// Possible the room became active after we opened this UI - just enter it with a warning.
		if(SScondos.active_condos["[requested_condo]"])
			to_chat(target, span_warning("你选择的房间号在你挑选期间已被占用！正在把你送往那间已被占用的公寓……"))
			SScondos.enter_active_room(requested_condo, target)
			return
		chosen_condo = SScondos.condo_templates[map]
		SScondos.create_and_enter_condo(requested_condo, chosen_condo, user, src)

/// Sanitycheck to prevent exploitation
/obj/machinery/cafe_condo_teleporter/proc/check_target_eligibility(mob/to_be_checked)
	if(!Adjacent(to_be_checked))
		to_chat(to_be_checked, span_warning("你离 \the [src] 太远，无法进入！"))
		return FALSE
	if(to_be_checked.incapacitated)
		to_chat(to_be_checked, span_warning("你已经无法激活 \the [src] 了！"))
		return FALSE
	return TRUE
