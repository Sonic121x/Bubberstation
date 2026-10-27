/datum/quirk/criminal_underworlder
	name = "Criminal Underworlder"
	desc = "你有案可查的犯罪人脉，以及与执法部门“打交道”的经验，让你擅长利用他人。"
	value = 0
	medical_record_text = "观察表明，患者有触犯法律的倾向。"
	security_record_text = "此人曾与犯罪分子有联系。严禁向其提供枪械或武器！"
	icon = FA_ICON_PEOPLE_ROBBERY

/datum/quirk/criminal_underworlder/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.mind?.has_exploitables_override = TRUE
	human_holder.mind.handle_exploitables()

/datum/quirk/criminal_underworlder/post_add()
	var/criminal_underworlder_policy = get_policy("[type]") || "请注意，即便你具有[chinese_quirk_display(name)]特征，也不代表你有额外权限去攻击他人或制造混乱。"
	// We shouldn't need this, but it prevents people using it as a dumb excuse in ahelps.
	to_chat(quirk_holder, span_big(span_info(criminal_underworlder_policy)))
