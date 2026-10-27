/datum/quirk/death_consequences
	name = DEATH_CONSEQUENCES_QUIRK_NAME
	desc = "你每次死亡都会对身体造成难以修复的长期损伤。"
	medical_record_text = DEATH_CONSEQUENCES_QUIRK_DESC
	icon = FA_ICON_DNA
	value = 0 // due to its high customization, you can make it really inconsequential

/datum/quirk_constant_data/death_consequences
	associated_typepath = /datum/quirk/death_consequences

/datum/quirk_constant_data/death_consequences/New()
	customization_options = (subtypesof(/datum/preference/numeric/death_consequences) + subtypesof(/datum/preference/toggle/death_consequences))

	return ..()

/datum/quirk/death_consequences/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.gain_trauma(/datum/brain_trauma/severe/death_consequences, TRAUMA_RESILIENCE_ABSOLUTE)
	var/datum/brain_trauma/severe/death_consequences/added_trauma = human_holder.get_death_consequences_trauma()
	if (!isnull(added_trauma))
		added_trauma.update_variables(client_source)

	to_chat(human_holder, span_danger("你受到[chinese_quirk_display(name)]的影响。默认情况下，\
		你每次死亡都会加重衰退，活着时则会十分缓慢地恢复。休息、睡觉、固定在舒适的\
		物体上或使用雷扎酮可以加快恢复。\n\
		衰退越严重，耐力损伤和重伤阈值恶化等负面效果也会越严重。\n\
		你可以通过“调整死亡衰退”指令随时调整衰退程度，并通过“刷新死亡后遗症设置”指令更新设置。"))

/datum/quirk/death_consequences/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.cure_trauma_type(/datum/brain_trauma/severe/death_consequences, TRAUMA_RESILIENCE_ABSOLUTE)

/// Adjusts the mob's linked death consequences trauma (see get_death_consequences_trauma())'s degradation by increment.
//GAME_VERB(/mob, adjust_degradation, "Adjust death degradation", "IC", increment as num)
GAME_VERB(/mob, adjust_degradation, "调整死亡衰退", "IC")
	VERB_ARG(increment, VERB_ARG_TYPE_NUM, VERB_ARG_SOURCE_INPUT)
	if (isnull(mind))
		to_chat(usr, span_warning("你没有心智！"))
		return

	var/datum/brain_trauma/severe/death_consequences/linked_trauma = get_death_consequences_trauma()
	var/mob/living/carbon/trauma_holder = linked_trauma?.owner
	if (isnull(linked_trauma) || isnull(trauma_holder) || trauma_holder != mind.current) // sanity
		to_chat(usr, span_warning("你的身体没有死亡后遗症！"))
		return

	if (!isnum(increment))
		to_chat(usr, span_warning("你可以用这个指令手动调整当前的死亡衰退程度。\
		这样可以实现自定义设置无法造成的衰退。<b>使用此指令时必须输入一个数字。</b>"))
		return

	if (linked_trauma.permakill_if_at_max_degradation && ((linked_trauma.current_degradation + increment) >= linked_trauma.max_degradation))
		if (tgui_alert(usr, "这会使你达到或超过最大衰退阈值，导致永久死亡！！！你确定要这么做吗？", "警告", list("是", "否"), timeout = 7 SECONDS) != "是")
			return

	linked_trauma.adjust_degradation(increment)
	to_chat(usr, span_notice("衰退程度已调整！"))

/// Calls update_variables() on this mob's linked death consequences trauma. See that proc for further info.
//GAME_VERB(/mob, refresh_death_consequences, "Refresh death consequence variables", "IC")
GAME_VERB(/mob, refresh_death_consequences, "刷新死亡后遗症设置", "IC")
	if (isnull(mind))
		to_chat(usr, span_warning("你没有心智！"))
		return

	var/datum/brain_trauma/severe/death_consequences/linked_trauma = get_death_consequences_trauma()
	var/mob/living/carbon/trauma_holder = linked_trauma?.owner
	if (isnull(linked_trauma) || isnull(trauma_holder) || trauma_holder != mind.current) // sanity
		to_chat(usr, span_warning("你的身体没有死亡后遗症！"))
		return

	linked_trauma.update_variables(client)
	to_chat(usr, span_notice("设置已更新！"))

/// Searches mind.current for a death_consequences trauma. Allows this proc to be used on both ghosts and living beings to find their linked trauma.
/mob/proc/get_death_consequences_trauma()
	RETURN_TYPE(/datum/brain_trauma/severe/death_consequences)

	if (isnull(mind))
		return

	if (iscarbon(mind.current))
		var/mob/living/carbon/carbon_body = mind.current
		for (var/datum/brain_trauma/trauma as anything in carbon_body.get_traumas())
			if (istype(trauma, /datum/brain_trauma/severe/death_consequences))
				return trauma
	// else, return null
