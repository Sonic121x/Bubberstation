/datum/action/cooldown/spell/conjure/creature
	name = "召唤生物群"
	desc = "此法术撕开现实的帷幕，让可怖的恶魔倾泻而出。"
	sound = 'sound/effects/magic/summonitems_generic.ogg'

	school = SCHOOL_CONJURATION
	cooldown_time = 2 MINUTES

	invocation = "IA IA!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE

	summon_radius = 3
	summon_type = list(/mob/living/basic/creature)
	summon_amount = 10
