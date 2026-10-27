/datum/bounty/item/special/vitezstvi
	name = "胜利军械征购单"
	reward = CARGO_CRATE_VALUE * 12

/datum/bounty/item/special/vitezstvi/New()
	switch(rand(1, 3))
		if(1)
			name = "伏特加"
			description = "VARS-7“向导”号士气已跌破临界点。在船员开始拿严格来说不能喝的东西做实验之前，先送八瓶伏特加过来。"
			required_count = 8
			wanted_types = list(/obj/item/reagent_containers/cup/glass/bottle/vodka = TRUE)
		if(2)
			name = "利剑冲锋枪"
			description = "同志，狂欢的时候我们……不小心弄丢了几把冲锋枪。别多问。送三把利剑冲锋枪过来，免得有人发现，明白吗？"
			required_count = 3
			wanted_types = list(/obj/item/gun/ballistic/automatic/miecz = TRUE)
		if(3)
			name = "CIN 剩余护甲背心"
			description = "胜利军械雇的承包商比它备着的护甲还多。送四件 CIN 剩余护甲背心过来，好让实习生们不必再轮流穿。"
			required_count = 4
			wanted_types = list(/obj/item/clothing/suit/armor/vest/cin_surplus_vest = TRUE)
	return ..()

/datum/bounty/item/special/vitezstvi/on_claimed(obj/item/card/id/id_card)
	. = ..()
	if(SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_VITEZSTVI])
		return
	SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_VITEZSTVI] = TRUE
	priority_announce(
		"VARS-7“向导”号呼叫货运部。货物已收到，状态极佳。军需官，你依然是个品质出众的混蛋，也是胜利军械真正的朋友。要是贵站哪天需要支援，我们会飞奔而来——也许快得不太明智。",
		"VARS-7“向导”号",
	)
