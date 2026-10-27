/obj/item/book/granter/action/spell/fireball
	granted_action = /datum/action/cooldown/spell/pointed/projectile/fireball
	action_name = "火球术"
	icon_state ="bookfireball"
	desc = "这本书摸起来暖暖的。"
	remarks = list(
		"瞄准……瞄准啊，笨蛋！",
		"光把他们点着可不够……",
		"还要考虑侧风……认真的？",
		"我好像刚把手烧伤了……",
		"为什么要摆这么蠢的姿势？不就是挥一下手……",
		"欧米……欧尼……呃……",
		"火球术和炎爆术到底有什么区别……",
	)

/obj/item/book/granter/action/spell/fireball/recoil(mob/living/user)
	. = ..()
	explosion(
		user,
		devastation_range = 1,
		light_impact_range = 2,
		flame_range = 2,
		flash_range = 3,
		adminlog = FALSE,
		explosion_cause = src,
	)
	qdel(src)
