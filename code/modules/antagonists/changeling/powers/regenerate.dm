/datum/action/changeling/regenerate
	name = "再生"
	desc = "让我们重新长出并恢复缺失的外部肢体和重要内部器官，同时清除弹片、治愈严重伤口并补充血量。消耗 10 点化学物质。"
	helptext = "若有外部肢体再生，会警示附近的船员。昏迷时也可使用。"
	button_icon_state = "regenerate"
	chemical_cost = 10
	dna_cost = CHANGELING_POWER_INNATE
	req_stat = HARD_CRIT

/datum/action/changeling/regenerate/sting_action(mob/living/user)
	if(!iscarbon(user))
		user.balloon_alert(user, "什么都没缺！")
		return FALSE

	..()
	to_chat(user, span_notice("你感到里里外外都在发痒，组织正一层层重新编织起来。"))
	var/mob/living/carbon/carbon_user = user
	var/got_limbs_back = length(carbon_user.get_missing_limbs()) >= 1
	carbon_user.fully_heal(HEAL_BODY)
	// Occurs after fully heal so the ling themselves can hear the sound effects (if deaf prior)
	if(got_limbs_back)
		playsound(user, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
		carbon_user.visible_message(
			span_warning("[user]缺失的肢体重新长出，发出响亮而恶心的声音！"),
			span_userdanger("你的肢体重新长出，发出响亮的碎裂声，让你剧痛难忍！"),
			span_hear("你听到有机质被撕扯、被撕裂的声音！"),
		)
		carbon_user.emote("scream")

	return TRUE
