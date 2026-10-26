/datum/action/cooldown/spell/touch/flesh_to_stone
	name = "化肉为石"
	desc = "该法术为你的手充能，能把受害者变成毫无生气的石像，并持续很长一段时间。"
	button_icon_state = "statue"
	sound = 'sound/effects/magic/fleshtostone.ogg'

	school = SCHOOL_TRANSMUTATION
	cooldown_time = 1 MINUTES
	cooldown_reduction_per_rank = 10 SECONDS

	invocation = "STAUN EI!!"

	hand_path = /obj/item/melee/touch_attack/flesh_to_stone

/datum/action/cooldown/spell/touch/flesh_to_stone/on_antimagic_triggered(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	to_chat(caster, span_warning("法术似乎无法影响 [victim]！"))
	to_chat(victim, span_warning("你感到自己的血肉一瞬化成了石头，随后又变了回来！"))

/datum/action/cooldown/spell/touch/flesh_to_stone/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	var/mob/living/living_victim = victim
	if(living_victim.can_block_magic(antimagic_flags))
		return TRUE

	living_victim.Stun(4 SECONDS)
	living_victim.petrify()
	return TRUE

/obj/item/melee/touch_attack/flesh_to_stone
	name = "\improper 石化之触"
	desc = "这就是定论，因为“化肉为石”说了算！"
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "fleshtostone"
	inhand_icon_state = "fleshtostone"
