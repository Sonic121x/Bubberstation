/obj/item/book/granter/action/spell/charge
	granted_action = /datum/action/cooldown/spell/charge
	action_name = "充能术"
	icon_state ="bookcharge"
	desc = "这本书由100%的消费后回收巫师制成。"
	remarks = list(
		"我感觉自己活过来了！",
		"我能尝到魔力的味道！",
		"太刺激了！",
		"我读得简直飞快！",
		"这位天才就要成功了！",
		"这本书充满了激情！",
		"他做到了！",
		"冲啊——！",
	)

/obj/item/book/granter/action/spell/charge/recoil(mob/living/user)
	. = ..()
	to_chat(user,span_warning("[src]突然变得滚烫！"))
	empulse(src, 1, 1, emp_source = src)

