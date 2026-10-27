/obj/item/book/granter/martial/cqc
	martial = /datum/martial_art/cqc
	name = "旧手册"
	martial_name = "近身格斗术"
	desc = "一本小巧的黑色手册，里面绘有战术徒手格斗的教学图示。"
	greet = span_bolddanger("你掌握了近身格斗术的基础。")
	icon_state = "cqcmanual"
	remarks = list(
		"踢击……摔击……",
		"擒拿……踢击……",
		"攻击腹部、颈部和背部，造成致命打击……",
		"摔击……擒拿……",
		"也许能把它与其他武术结合起来！……等等，那不合规。",
		"杀人的言语……",
		"最后的那一刻属于你……",
	)

/obj/item/book/granter/martial/cqc/on_reading_finished(mob/living/carbon/user)
	. = ..()
	if(uses <= 0)
		to_chat(user, span_warning("[src]发出不祥的哔哔声……"))

/obj/item/book/granter/martial/cqc/recoil(mob/living/user)
	to_chat(user, span_warning("[src]爆炸了！"))
	playsound(src,'sound/effects/explosion/explosion1.ogg',40,TRUE)
	user.flash_act(1, 1)
	user.adjust_brute_loss(6)
	user.adjust_fire_loss(6)
	qdel(src)
