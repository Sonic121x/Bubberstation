/obj/item/organ/heart/gland/ventcrawling
	abductor_hint = "柔韧软骨激活器。被绑架者可以毫无阻碍地爬行穿过通风管道。"
	cooldown_low = 1800
	cooldown_high = 2400
	uses = 1
	icon_state = "vent"
	mind_control_uses = 4
	mind_control_duration = 1800

/obj/item/organ/heart/gland/ventcrawling/activate()
	to_chat(owner, span_notice("你感觉自己非常柔韧。"))
	ADD_TRAIT(owner, TRAIT_VENTCRAWLER_ALWAYS, type)
