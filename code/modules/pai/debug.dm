ADMIN_VERB(makepAI, R_FUN, "生成个人 AI", "指定一个位置生成个人 AI 设备，然后指定一个 key 来扮演该个人 AI", ADMIN_CATEGORY_FUN)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_TURF, VERB_ARG_SOURCE_VIEW, /turf)

	var/list/available = list()
	for(var/mob/player as anything in GLOB.player_list)
		if(player.client && player.key)
			available.Add(player)
	var/mob/choice = tgui_input_list(user, "选择一名玩家来扮演个人 AI", "生成个人 AI", sort_names(available))
	if(isnull(choice))
		return

	var/chosen_name = input(choice, "输入你的个人 AI 名称：", "个人 AI 名称", "个人 AI") as text|null
	if (isnull(chosen_name))
		return

	if(!isobserver(choice))
		var/confirm = tgui_alert(user, "[choice.key] 目前并未处于幽灵状态。确定要将其从身体中拉出并放入这个个人 AI 吗？", "生成个人 AI 确认", list("是", "否"))
		if(confirm != "是")
			return
	var/obj/item/pai_card/card = new(target)
	var/mob/living/silicon/pai/pai = new(card)

	pai.name = chosen_name
	pai.real_name = pai.name
	pai.PossessByPlayer(choice.key)
	card.set_personality(pai)
	if(SSpai.candidates[user.key])
		SSpai.candidates -= user.key
	BLACKBOX_LOG_ADMIN_VERB("Make pAI")

/**
 * Creates a new pAI.
 *
 * @param {boolean} delete_old - If TRUE, deletes the old pAI.
 */
/mob/proc/make_pai(delete_old)
	var/obj/item/pai_card/card = new(src)
	var/mob/living/silicon/pai/pai = new(card)
	pai.PossessByPlayer(key)
	pai.name = name
	card.set_personality(pai)
	if(delete_old)
		qdel(src)
