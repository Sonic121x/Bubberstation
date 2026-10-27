/mob/living/carbon/human/can_use_guns(obj/item/G)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_PRONE))
		to_chat(src, span_warning("你爬得太低了，无法使用远程武器！"))
		return FALSE
