// STANDARD JOB TRAIT HANDLING
/datum/station_trait/job/on_lobby_button_click(mob/dead/new_player/user)
	if(SSticker.HasRoundStarted())
		to_chat(user, span_redtext("回合已经开始！"))
		return
	if (LAZYFIND(lobby_candidates, user))
		LAZYREMOVE(lobby_candidates, user)
		to_chat(user, span_redtext("你已从[chinese_batch_ten_station_trait_display(name)]候选名单中移除。"))
	else
		LAZYADD(lobby_candidates, user)
		to_chat(user, span_greentext("你已加入[chinese_batch_ten_station_trait_display(name)]候选名单。"))

// SKUB TRAIT HANDLING
#define PRO_SKUB "pro-skub"
#define ANTI_SKUB "anti-skub"
#define SKUB_IDFC "i don't frikkin' care"

/datum/station_trait/skub/on_lobby_button_click(mob/dead/new_player/user)
	var/skub_stance = chinese_skyrat_systems_choice(user, "选择你对斯库布的立场", "斯库布立场", list(ANTI_SKUB, SKUB_IDFC, PRO_SKUB))
	skubbers[user.ckey] = skub_stance
	to_chat(user, span_greentext("你选择了[chinese_skyrat_systems_display(skub_stance)]！"))

#undef PRO_SKUB
#undef ANTI_SKUB
#undef SKUB_IDFC
