/obj/item/book/granter/action/spell/blind
	granted_action = /datum/action/cooldown/spell/pointed/blind
	action_name = "致盲术"
	icon_state = "bookblind"
	desc = "无论怎么看，这本书都模糊不清。"
	remarks = list(
		"连这破玩意儿都看不清，我还怎么学！",
		"为什么要在深色背景上用深色字体……",
		"啊，我什么都看不……哦，没事了……",
		"我看不见自己的手了……！",
		"我现在得刻意眨眼了，该死的书……",
		"我看不懂这一页，却莫名觉得从中学到了什么……",
		"嘿，谁把灯关了？",
	)

/obj/item/book/granter/action/spell/blind/recoil(mob/living/user)
	. = ..()
	to_chat(user, span_warning("你失明了！"))
	user.adjust_temp_blindness(20 SECONDS)

/obj/item/book/granter/action/spell/blind/wgw
	name = "胡迪硬起来了"
	pages_to_mastery = 69 // Andy's favorite number
	uses = 0 // it's spent
	desc = "这本书看起来很危险。等待读者的只有痛苦。"
	remarks = list( // Death awaits
		"这、这、这不妙……",
		"这实在太糟了……",
		"我的眼睛好像开始流血了……",
		"求求你，让它停下……",
		"谁来救救我，我为什么要读这个……",
	)
