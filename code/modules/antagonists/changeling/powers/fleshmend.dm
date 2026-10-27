/datum/action/changeling/fleshmend
	name = "血肉修复"
	desc = "我们的血肉迅速再生，治愈烧伤、瘀伤与气促，并隐藏所有疤痕。消耗 20 单位化学物质。"
	helptext = "如果我们身上着火，治疗效果将不会生效。不会再生肢体或恢复失去的血液。昏迷状态下仍可使用。"
	button_icon_state = "fleshmend"
	category = "combat"
	chemical_cost = 20
	dna_cost = 2
	req_stat = HARD_CRIT

//Starts healing you every second for 10 seconds.
//Can be used whilst unconscious.
/datum/action/changeling/fleshmend/sting_action(mob/living/user)
	if(user.has_status_effect(/datum/status_effect/fleshmend))
		user.balloon_alert(user, "已在修复血肉！")
		return
	..()
	to_chat(user, span_notice("我们开始迅速愈合。"))
	user.apply_status_effect(/datum/status_effect/fleshmend)
	return TRUE

//Check buffs.dm for the fleshmend status effect code
