// Given to heretic monsters.
/datum/action/cooldown/spell/shapeshift/eldritch
	name = "变形"
	desc = "一种让你化身为另一种生物并获取其能力的法术。\
		选择之后，你将无法再改为其他形态。"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	invocation = "SH'PE."
	invocation_type = INVOCATION_WHISPER
	spell_requirements = NONE

	possible_shapes = list(
		/mob/living/basic/carp,
		/mob/living/basic/mouse,
		/mob/living/basic/pet/cat,
		/mob/living/basic/pet/dog/corgi,
		/mob/living/basic/pet/fox,
		/mob/living/basic/bot/secbot,
	)
