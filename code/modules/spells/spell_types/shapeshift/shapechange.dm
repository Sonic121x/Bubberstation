/datum/action/cooldown/spell/shapeshift/wizard
	name = "野性变形"
	desc = "在一段时间内化身为另一种生物，借用它们的\
		天生能力。一旦做出选择，就无法再更改。"

	cooldown_time = 20 SECONDS
	cooldown_reduction_per_rank = 8 SECONDS
	spell_max_level = 3

	invocation = "RAC'WA NO!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

	possible_shapes = list(
		/mob/living/basic/carp/magic/chaos,
		/mob/living/basic/construct/juggernaut/mystic,
		/mob/living/basic/mouse,
		/mob/living/basic/pet/dog/corgi,
		/mob/living/basic/spider/giant/viper/wizard,
		/mob/living/basic/bot/secbot/ed209,
	)
