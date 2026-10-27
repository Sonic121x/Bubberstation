/mob/living/basic/pet/syndifox/mini
	name = "辛迪狐"
	desc = "这是一台赛博太阳 MiniVix 机器人型号，穿着微型辛迪加 MOD 模块化外骨骼，戴着一顶可爱的小帽子。相当漂亮。这一只看起来更迷你一些。"
	initial_size = 0.8
	faction = list(FACTION_NEUTRAL)

/mob/living/basic/pet/syndifox/mini/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/simple_access, ACCESS_SYNDICATE)
