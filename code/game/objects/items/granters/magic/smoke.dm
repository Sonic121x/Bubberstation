/obj/item/book/granter/action/spell/smoke
	granted_action = /datum/action/cooldown/spell/smoke
	action_name = "烟雾术"
	icon_state ="booksmoke"
	desc = "这本书满溢着烟雾缭绕的秘术。"
	remarks = list(
		"烟雾弹！嘿嘿……",
		"烟雾弹也能办到吧……",
		"等等，化学部有台机器也能做同样的事？",
		"这本书闻起来真难闻……",
		"为什么全是大麻笑话？直接告诉我怎么施法就好……",
		"风会毁掉整个法术，幸好我们在太空中……对吧？",
		"原来蜘蛛氏族是这么做到的……",
	)

/obj/item/book/granter/action/spell/smoke/recoil(mob/living/user)
	. = ..()
	to_chat(user,span_warning("你的肚子咕咕作响……"))
	if(user.nutrition)
		user.set_nutrition(200)
		if(user.nutrition <= 0)
			user.set_nutrition(0)

// Chaplain's smoke book
/obj/item/book/granter/action/spell/smoke/lesser
	granted_action = /datum/action/cooldown/spell/smoke/lesser
