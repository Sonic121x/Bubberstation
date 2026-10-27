/datum/heretic_knowledge/spell/opening_blast
	drafting_cost = 3

/datum/action/cooldown/spell/aoe/wave_of_desperation
	cooldown_time = 10 MINUTES
	focusless_inhibitable = TRUE

/datum/action/cooldown/spell/aoe/wave_of_desperation/cast(atom/cast_on)
	. = ..()

	owner.visible_message(span_boldwarning("你觉得[owner]短时间内无法再次使用这个法术。快再次将其抓住！"))
	owner.visible_message(span_boldnotice("口枷或拘束衣能阻止继续使用这项能力。"))
