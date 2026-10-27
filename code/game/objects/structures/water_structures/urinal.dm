/obj/structure/urinal
	name = "小便池"
	desc = "HU-452 型实验性小便池。附带实验性小便池香饼。"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "urinal"
	density = FALSE
	anchored = TRUE
	/// Can you currently put an item inside
	var/exposed = FALSE
	/// What's in the urinal
	var/obj/item/hidden_item

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/urinal, 32)

/obj/structure/urinal/Initialize(mapload)
	. = ..()
	if(mapload)
		hidden_item = new /obj/item/food/urinalcake(src)
		find_and_mount_on_atom()

/obj/structure/urinal/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == hidden_item)
		hidden_item = null

/obj/structure/urinal/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(user.pulling && isliving(user.pulling))
		var/mob/living/grabbed_mob = user.pulling
		if(user.grab_state >= GRAB_AGGRESSIVE)
			if(grabbed_mob.loc != get_turf(src))
				to_chat(user, span_notice("[grabbed_mob.name]需要位于[src]上。"))
				return
			user.changeNext_move(CLICK_CD_MELEE)
			user.visible_message(span_danger("[user]把[grabbed_mob]猛撞在[src]上！"), span_danger("你把[grabbed_mob]猛撞在[src]上！"))
			grabbed_mob.emote("scream")
			grabbed_mob.adjust_brute_loss(8)
		else
			to_chat(user, span_warning("你需要抓得更紧！"))
		return

	if(exposed)
		if(hidden_item)
			to_chat(user, span_notice("你从排水口护罩里捞出了[hidden_item]。"))
			user.put_in_hands(hidden_item)
		else
			to_chat(user, span_warning("排水口护罩里什么也没有！"))
		return
	return ..()

/obj/structure/urinal/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!exposed)
		return NONE

	if(hidden_item)
		to_chat(user, span_warning("排水口护罩里已经有东西了！"))
		return ITEM_INTERACT_BLOCKING

	if(tool.w_class > WEIGHT_CLASS_TINY)
		to_chat(user, span_warning("[tool]对于排水口护罩来说太大了。"))
		return ITEM_INTERACT_BLOCKING

	if(!user.transferItemToLoc(tool, src))
		to_chat(user, span_warning("[tool]粘在你手上，你无法把它放进排水口护罩！"))
		return ITEM_INTERACT_BLOCKING

	hidden_item = tool
	to_chat(user, span_notice("你把[tool]放进了排水口护罩。"))
	return ITEM_INTERACT_SUCCESS

/obj/structure/urinal/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	to_chat(user, span_notice("你开始[exposed ? "把盖子重新拧回原位" : "拧开排水口护罩的盖子"]……"))
	playsound(loc, 'sound/effects/stonedoor_openclose.ogg', 50, TRUE)
	if(I.use_tool(src, user, 20))
		user.visible_message(span_notice("[user][exposed ? "把盖子重新拧回原位" : "拧开了排水口护罩的盖子"]！"),
			span_notice("你[exposed ? "把盖子重新拧回原位" : "拧开了排水口的盖子"]！"),
			span_hear("你听到金属摩擦和挤压的声音。"))
		exposed = !exposed
	return TRUE

/obj/structure/urinal/wrench_act_secondary(mob/living/user, obj/item/tool)
	tool.play_tool_sound(user)
	deconstruct(TRUE)
	balloon_alert(user, "已拆除小便池")
	return ITEM_INTERACT_SUCCESS

/obj/structure/urinal/atom_deconstruct(disassembled = TRUE)
	new /obj/item/wallframe/urinal(loc)
	hidden_item?.forceMove(drop_location())

/obj/item/wallframe/urinal
	name = "小便池框架"
	desc = "未安装的小便池。把它装到墙上即可使用。"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "urinal"
	result_path = /obj/structure/urinal
	pixel_shift = 32

/obj/item/food/urinalcake
	name = "小便池香饼"
	desc = "高贵的小便池香饼，保护空间站的管道免受空间站尿液的侵蚀。请勿食用。"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "urinalcake"
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(
		/datum/reagent/chlorine = 3,
		/datum/reagent/ammonia = 1,
	)
	foodtypes = TOXIC | GROSS
	preserved_food = TRUE

/obj/item/food/urinalcake/attack_self(mob/living/user)
	user.visible_message(span_notice("[user]捏扁了[src]！"), span_notice("你捏扁了[src]。"), "<i>你听到挤压的声音。</i>")
	icon_state = "urinalcake_squish"
	addtimer(VARSET_CALLBACK(src, icon_state, "urinalcake"), 0.8 SECONDS)
