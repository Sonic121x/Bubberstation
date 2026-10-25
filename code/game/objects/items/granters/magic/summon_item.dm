/obj/item/book/granter/action/spell/summonitem
	granted_action = /datum/action/cooldown/spell/summonitem
	action_name = "即时召回"
	icon_state ="booksummons"
	desc = "这本书色彩鲜艳花哨，让人很难忽视。"
	remarks = list(
		"我的目光离不开这本书！",
		"文字似乎在书页上四处跳动……",
		"我只需要专注于一件物品……",
		"施法时一定要把它握紧……",
		"慢一点，书。我还没读完这一页……",
		"听起来和其他魔法神器搭配起来会很棒……",
		"魔术师一定喜欢这个。",
	)

/obj/item/book/granter/action/spell/summonitem/recoil(mob/living/user)
	. = ..()
	to_chat(user,span_warning("[src]突然消失了！"))
	qdel(src)
