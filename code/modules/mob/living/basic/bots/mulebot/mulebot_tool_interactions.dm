/mob/living/basic/bot/mulebot/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	update_appearance()

/mob/living/basic/bot/mulebot/crowbar_act(mob/living/user, obj/item/tool)
	if(!(bot_access_flags & BOT_COVER_MAINTS_OPEN) || user.combat_mode)
		return
	if(!cell)
		to_chat(user, span_warning("[src] 里没有电池！"))
		return ITEM_INTERACT_BLOCKING
	cell.add_fingerprint(user)
	user.visible_message(
		span_notice("[user] 用撬棍把 [cell] 从 [src] 里撬了出来。"),
		span_notice("你把 [cell] 从 [src] 里撬了出来。"),
	)
	if(Adjacent(user) && !issilicon(user))
		user.put_in_hands(cell)
	else
		cell.forceMove(drop_location())
	return ITEM_INTERACT_SUCCESS

/mob/living/basic/bot/mulebot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stock_parts/power_store/cell) && (bot_access_flags & BOT_COVER_MAINTS_OPEN))
		if(cell)
			to_chat(user, span_warning("[src] 里已经装有电池了！"))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(
			span_notice("[user] 将 \a [cell] 插入了 [src]。"),
			span_notice("你将 [cell] 插入 [src]。"),
		)
		return ITEM_INTERACT_SUCCESS
	if(is_wire_tool(tool) && (bot_access_flags & BOT_COVER_MAINTS_OPEN))
		attack_hand(user)
		return ITEM_INTERACT_SUCCESS
	return ..()


/mob/living/basic/bot/mulebot/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(!(bot_access_flags & BOT_COVER_EMAGGED))
		return
	flick("[base_icon_state]-emagged", src)
	playsound(src, SFX_SPARKS, 100, FALSE, SHORT_RANGE_SOUND_EXTRARANGE)
	return TRUE
