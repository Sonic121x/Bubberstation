/obj/item/book/granter/action/spell/forcewall
	granted_action = /datum/action/cooldown/spell/forcewall
	action_name = "力场墙"
	icon_state ="bookforcewall"
	desc = "这本书的封面内侧写着献给所有默剧演员的献词。"
	remarks = list(
		"我能穿过这堵墙！真棒。",
		"为什么这么多地方都在提默剧演员……？",
		"在走廊里用这个会惹出不少麻烦……",
		"造出一堵谁都穿不过去的墙，这魔法强得出人意料……",
		"为什么要摆这么蠢的姿势？不就是挥一下手……",
		"书页怎么这么难翻，这真的是纸吗？",
		"我动不……哦，没事了……",
	)

/obj/item/book/granter/action/spell/forcewall/recoil(mob/living/user)
	. = ..()
	to_chat(user, span_warning("你突然觉得自己变得无比坚硬！"))
	user.Stun(4 SECONDS, ignore_canstun = TRUE)
	user.petrify(6 SECONDS)
