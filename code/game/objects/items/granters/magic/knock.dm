/obj/item/book/granter/action/spell/knock
	granted_action = /datum/action/cooldown/spell/aoe/knock
	action_name = "敲击术"
	icon_state ="bookknock"
	desc = "这本书很难合严。"
	remarks = list(
		"芝麻开门！",
		"原来这就是魔法口令！",
		"慢一点，书。我还没读完这一页……",
		"这本书动个不停！",
		"我觉得这样会弄坏书脊……",
		"我翻不了下一页，它粘……没事了，它自己翻页了。",
		"对，开门法杖也能干这事。真有意思……",
	)

/obj/item/book/granter/action/spell/knock/recoil(mob/living/user)
	. = ..()
	to_chat(user, span_warning("你被击倒了！"))
	user.Paralyze(4 SECONDS)
