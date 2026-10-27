/// Gives the target fake scars
/datum/smite/scarify
	name = "疤痕化"

/datum/smite/scarify/effect(client/user, mob/living/target)
	. = ..()
	if(!iscarbon(target))
		to_chat(user, span_warning("此惩罚只能施加于碳基生物。"), confidential = TRUE)
		return
	var/mob/living/carbon/dude = target
	dude.generate_fake_scars(rand(1, 4))
	to_chat(dude, span_warning("你感到自己的身体变得疲惫而破碎……"))
