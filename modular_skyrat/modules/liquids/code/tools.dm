ADMIN_VERB(spawn_liquid, R_ADMIN, "生成液体", "在你当前所在位置生成指定数量的液体。", ADMIN_CATEGORY_FUN)
	var/choice
	var/valid_id
	while(!valid_id)
		choice = tgui_input_text(user, "输入要添加的试剂 ID。", "搜索试剂")
		if(isnull(choice)) //Get me out of here!
			break
		if (!ispath(text2path(choice)))
			choice = pick_closest_path(choice, make_types_fancy(subtypesof(/datum/reagent)))
			if (ispath(choice))
				valid_id = TRUE
		else
			valid_id = TRUE
		if(!valid_id)
			to_chat(user, span_warning("该 ID 对应的试剂不存在！"))
	if(!choice)
		return
	var/volume = tgui_input_number(user, "体积：", "选择体积")
	if(!volume)
		return
	var/turf/epicenter = get_turf(user.mob)
	epicenter.add_liquid(choice, volume)
	message_admins("[ADMIN_LOOKUPFLW(user)] 在 [epicenter.loc] 生成了液体（[choice] - [volume]）。")
	log_admin("[key_name(user)] 在 [epicenter.loc] 生成了液体（[choice] - [volume]）。")

ADMIN_VERB_AND_CONTEXT_MENU(remove_liquid, R_ADMIN, "移除液体", "移除指定半径内的所有液体。", ADMIN_CATEGORY_GAME, /turf/open)
	VERB_ARG_TYPED(locale, VERB_ARG_TYPE_TURF, VERB_ARG_SOURCE_WORLD, /turf/open)
	VERB_ARG(range, VERB_ARG_TYPE_NUM, VERB_ARG_SOURCE_INPUT)

	message_admins("[key_name_admin(user)] 移除了区域 [locale.loc.name] 内范围为 [range] 的液体")
	user.mob.log_message("移除了区域 [locale.loc.name] 内范围为 [range] 的液体", LOG_ADMIN)

	for(var/obj/effect/abstract/liquid_turf/liquid in range(range, locale))
		qdel(liquid, TRUE)

