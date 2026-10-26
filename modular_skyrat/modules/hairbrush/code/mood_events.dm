/datum/mood_event/brushed
	description = span_nicegreen("最近有人为我梳了头发，感觉太棒了！\n")
	mood_change = 3
	timeout = 4 MINUTES

/datum/mood_event/brushed/add_effects(mob/brusher)
	description = span_nicegreen("[brusher? brusher.name : "我"]最近为我梳了头发，感觉太棒了！\n")

/datum/mood_event/brushed/self
	description = span_nicegreen("我最近自己梳了头发！\n")
	mood_change = 2		// You can't hit all the right spots yourself, or something

/datum/mood_event/brushed/pet/add_effects(mob/brushed_pet)
	description = span_nicegreen("我最近给 [brushed_pet] 梳了毛，它真是太可爱了！\n")
