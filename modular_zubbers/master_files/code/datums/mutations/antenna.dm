/datum/action/cooldown/spell/pointed/mindread/cast(mob/living/cast_on)
	if(HAS_TRAIT(cast_on, TRAIT_PSIONIC_DAMPENER))
		to_chat(owner, span_warning("当你试图深入 [cast_on] 的内心时，\
			你被一道精神屏障挡住了。"))
		return
	return ..()
