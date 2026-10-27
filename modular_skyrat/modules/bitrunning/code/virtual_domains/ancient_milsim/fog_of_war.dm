/obj/machinery/button/door/indestructible/ancient_milsim
	name = "SNPC 区域入口控制装置"
	desc = "一个特殊的按钮，按下后会自行删除。希望能借此避免意外或恶意的死锁，并让隐藏于战争迷雾之后的遭遇战更为公平。"
	id = "engagement_control"

/obj/machinery/button/door/indestructible/ancient_milsim/screwdriver_act()
	return

/obj/machinery/button/door/indestructible/ancient_milsim/attackby()
	return

/obj/machinery/button/door/indestructible/ancient_milsim/emag_act()
	return

/obj/machinery/button/door/indestructible/ancient_milsim/attack_hand()
	. = ..()
	if(.)
		return
	qdel(src)

/obj/machinery/door/poddoor/ancient_milsim
	name = "战争迷雾"
	desc = "有史以来“最棒”的游戏机制。至少它确实能保护你，你懂吧？按下按钮后它会自行删除。"
	icon = 'icons/effects/anomalies.dmi'
	icon_state = "pyroclastic"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/door/poddoor/ancient_milsim/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/machinery/door/poddoor/ancient_milsim/screwdriver_act()
	return

/obj/machinery/door/poddoor/ancient_milsim/welder_act()
	return

/obj/machinery/door/poddoor/ancient_milsim/open()
	qdel(src)
