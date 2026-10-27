//Normal supercat spell
/datum/action/cooldown/spell/shapeshift/kitty
	name = "猫咪之力！！"
	desc = "化身为猫咪！获得它们的力量，但会损失生命活力。"

	cooldown_time = 60 SECONDS
	invocation = "喵呜 喵呜呜！！"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS

	possible_shapes = list(
		/mob/living/basic/pet/cat/super,
		/mob/living/basic/pet/cat/super/tux,
		/mob/living/basic/pet/cat/super/pancake,
		/mob/living/basic/pet/cat/super/original,
		/mob/living/basic/pet/cat/cak/super,
	)
	keep_name = TRUE

//Traitor's Super cat spell
/datum/action/cooldown/spell/shapeshift/kitty/syndie
	name = "辛迪加猫咪之力！！"
	desc = "化身为身披血红护甲的猫咪！获得它们的力量，但会损失生命活力。"
	possible_shapes = list(/mob/living/basic/pet/cat/syndicat/super)
