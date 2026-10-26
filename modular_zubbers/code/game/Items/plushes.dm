/obj/item/toy/plush/attack_self(mob/user)
	. = ..()
	if(stuffed)
		if(HAS_TRAIT(user, TRAIT_MONOPHOBIA))
			to_chat(user, span_notice("你心头一暖……不再那么孤独了。"))

	else
		if(HAS_TRAIT(user, TRAIT_MONOPHOBIA))
			to_chat(user, span_warning("你想起，即便是缝制的伙伴，也无法阻止孤独在心中积聚……"))
