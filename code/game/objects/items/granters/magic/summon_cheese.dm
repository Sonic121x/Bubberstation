/obj/item/book/granter/action/spell/summon_cheese
	name = "风流异形女仆第三卷——奶酪烘焙坊"
	desc = "太棒了！该庆祝一下了……人人都有奶酪！"
	icon_state = "bookcheese"
	action_name = "召唤奶酪"
	granted_action = /datum/action/cooldown/spell/conjure/cheese
	remarks = list(
		"永远向前，绝不回头……",
		"这些书页……是奶酪片？……",
		"给毫无戒心的受害者准备的健康零食……",
		"我从不知道奶酪居然有这么多种……",
		"疯狂散发着山羊奶酪的气味……",
		"疯狂尝起来像高达奶酪……",
		"疯狂尝起来像帕尔马奶酪……",
		"时间是人为的概念……",
		"是秩序还是饼干来着？……",
		"献祭奶酪是怎么回事？！……",
		"谁会不喜欢呢？……",
		"那么多东西，偏偏为什么是奶酪？……",
		"为什么每件事都得有理由？……",
	)

/obj/item/book/granter/action/spell/summon_cheese/recoil(mob/living/user)
	to_chat(user, span_warning("[src]变成了一块奶酪！"))
	var/obj/item/food/cheese/wedge/book_cheese = new
	user.temporarilyRemoveItemFromInventory(src, force = TRUE)
	user.put_in_hands(book_cheese)
	qdel(src)
