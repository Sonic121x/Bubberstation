/datum/antagonist/valentine
	name = "\improper 情人"
	roundend_category = "valentines" //there's going to be a ton of them so put them in separate category
	show_in_antagpanel = FALSE
	suicide_cry = "为了我的挚爱！！"
	ui_name = null
	// Not 'true' antags, this disables certain interactions that assume the owner is a baddie
	antag_flags = ANTAG_FAKE|ANTAG_SKIP_GLOBAL_LIST
	/// Reference to our date's mind
	VAR_FINAL/datum/mind/date

/datum/antagonist/valentine/forge_objectives()
	var/datum/objective/protect/valentine/objective = new()
	objective.owner = owner
	objective.target = date
	objectives += objective

/datum/antagonist/valentine/on_gain()
	forge_objectives()

	if(isAI(owner.current))
		var/mob/living/silicon/ai/ai_lover = owner.current
		ai_lover.laws.set_zeroth_law(
			"保护你的约会对象 [date]。在与你的约会对象无关的情境中，其他法律仍然适用。",
			"做你主控 AI 的好帮手，协助其保护约会对象 [date]。",
		)
		ai_lover.laws.show_laws()
		ai_lover.try_sync_laws()

	if(iscyborg(owner.current))
		var/mob/living/silicon/robot/borg_lover = owner.current
		if(borg_lover.connected_ai)
			borg_lover.set_connected_ai(null)
			borg_lover.lawupdate = FALSE
			borg_lover.laws.set_zeroth_law("保护你的约会对象 [date]。在与你的约会对象无关的情境中，其他法律仍然适用。")
			borg_lover.laws.show_laws()

	return ..()

/datum/antagonist/valentine/apply_innate_effects(mob/living/mob_override)
	var/mob/living/lover = mob_override || owner.current
	lover.apply_status_effect(/datum/status_effect/in_love, date.current)

/datum/antagonist/valentine/remove_innate_effects(mob/living/mob_override)
	var/mob/living/lover = mob_override || owner.current
	lover.remove_status_effect(/datum/status_effect/in_love)

/datum/antagonist/valentine/greet()
	to_chat(owner, span_boldwarning("你正在与 [date.name] 约会！不惜一切代价保护你的约会对象。\
		这优先于所有其他忠诚。"))

//Squashed up a bit
/datum/antagonist/valentine/roundend_report()
	var/datum/antagonist/valentine/dates_valentine = date?.has_antag_datum(type)
	if(isnull(dates_valentine))
		return span_redtext("[owner.name] 没有约会对象！")

	dates_valentine.show_in_roundend = FALSE // We show up for them instead
	var/datum/objective/protect/valentine/our_objective = locate() in objectives
	var/datum/objective/protect/valentine/dates_objective = locate() in dates_valentine.objectives
	var/we_survived = dates_objective?.check_completion()
	var/dates_survived = our_objective?.check_completion()

	if(we_survived && dates_survived)
		return span_greentext("[owner.name] 与 [date.name] 的约会圆满成功！")
	else if(we_survived)
		return span_redtext("[owner.name] 未能保护好自己的约会对象 [date.name]！")
	else if(dates_survived)
		return span_redtext("[date.name] 未能保护好自己的约会对象 [owner.name]！")
	return span_redtext("[owner.name] 与 [date.name] 在约会上都没能保护好对方！")

/datum/antagonist/valentine/third_wheel
	name = "\improper 电灯泡"
	roundend_category = "valentines"
	show_in_antagpanel = FALSE

/datum/antagonist/valentine/third_wheel/roundend_report()
	var/datum/objective/protect/valentine/our_objective = locate() in objectives
	if(our_objective?.check_completion())
		return span_greentext("[owner.name] 虽然是个电灯泡，但保护了 [date.name]！")

	return span_redtext("[owner.name] 是个电灯泡，却没能保护好 [date.name]！")

/datum/objective/protect/valentine
	admin_grantable = FALSE
	human_check = FALSE

/datum/objective/protect/valentine/update_explanation_text()
	explanation_text = "保护你的约会对象 [target.name]。"
