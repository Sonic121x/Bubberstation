/datum/action/changeling/mimicvoice
	name = "模拟声音"
	desc = "我们重塑声腺，让自己听起来像想要的声音。维持这份能力会减缓化学物质生成。"
	button_icon_state = "mimic_voice"
	helptext = "会将我们的声音变成我们输入的名字。我们必须不断消耗化学物质才能维持这样的形态。"
	category = "stealth"
	chemical_cost = 0//constant chemical drain hardcoded
	dna_cost = 1
	req_human = TRUE

// Fake Voice
/datum/action/changeling/mimicvoice/sting_action(mob/living/carbon/human/user)
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(user.override_voice)
		changeling.chem_recharge_slowdown -= 0.25
		user.override_voice = ""
		to_chat(user, span_notice("我们让声腺恢复原位。"))
		return

	var/mimic_voice = sanitize_name(tgui_input_text(user, "输入要模仿的名字", "模拟声音", max_length = MAX_NAME_LEN))
	if(!mimic_voice)
		return
	..()
	changeling.chem_recharge_slowdown += 0.25
	user.override_voice = mimic_voice
	to_chat(user, span_notice("我们重塑声腺，模仿<b>[mimic_voice]</b>的声音；激活期间会减缓化学物质再生。"))
	to_chat(user, span_notice("再次使用此能力可恢复原本的声音，并让化学物质产量回到正常水平。"))
	return TRUE

/datum/action/changeling/mimicvoice/Remove(mob/living/carbon/human/user)
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(user.override_voice)
		changeling?.chem_recharge_slowdown = max(0, changeling.chem_recharge_slowdown - 0.25)
		user.override_voice = ""
		to_chat(user, span_notice("我们的声腺恢复原位。"))
	. = ..()
