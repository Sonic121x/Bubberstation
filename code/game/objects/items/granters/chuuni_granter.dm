/// Turns the user into a chuunibyou.
/obj/item/book/granter/chuunibyou
	starting_title = "我在图书馆找到一本教我如何成为中二病的神秘书籍，结果竟然是能解放我隐藏力量的魔导书！"
	starting_author = "匿名"
	name = "我在图书馆找到一本教我如何成为中二病的神秘书籍，结果竟然是能解放我隐藏力量的魔导书！"
	desc = "说实话，我宁愿被人撞见手里拿着辛迪加左轮手枪。"
	icon_state ="chuuni_manga"
	remarks = list(
		"怎么会有人相信这些东西？",
		"……我为什么要在这上面浪费时间？",
		"随时编出咒语还真是门本事……",
		"我应该找个医用眼罩，把这身行头配齐……",
		"按这本漫画的说法，念咒可以让我的力量提升5000%……",
		"这个\"黑暗领主\"是谁？为什么所有力量都是他赐予的？",
	)

/obj/item/book/granter/chuunibyou/can_learn(mob/living/user)
	if (!isliving(user))
		return
	if (user.GetComponent(/datum/component/chuunibyou))
		to_chat(user, span_warning("你已经是个中二病了！"))
		return
	return TRUE

/obj/item/book/granter/chuunibyou/recoil(mob/living/user)
	to_chat(user, span_warning("你实在没法逼自己读下去……不值得尴尬成这样……"))

/obj/item/book/granter/chuunibyou/on_reading_finished(mob/living/user)
	..()
	to_chat(user, span_notice("你学会了用更中二的风格施放法术！"))
	user.AddComponent(/datum/component/chuunibyou/no_healing)
