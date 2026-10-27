/datum/action/cooldown/spell/shapeshift/polar_bear
	name = "北极熊形态"
	desc = "化身为一只北极熊。"
	invocation = span_danger("<b>%CASTER</b> 发出一声威猛的咆哮！")
	invocation_self_message = span_danger("你发出一声威猛的咆哮！")
	invocation_type = INVOCATION_EMOTE
	spell_requirements = NONE

	possible_shapes = list(/mob/living/basic/mining/polarbear/lesser)
