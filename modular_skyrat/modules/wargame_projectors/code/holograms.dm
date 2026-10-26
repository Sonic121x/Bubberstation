/obj/structure/wargame_hologram
	name = "损坏的兵棋全息标记"
	desc = "你觉得它原本应该表示什么东西，但全息影像肯定坏掉了。"
	icon = 'modular_skyrat/modules/wargame_projectors/icons/projectors_and_holograms.dmi'
	icon_state = "broke"
	anchored = TRUE
	density = FALSE
	max_integrity = 1
	obj_flags = UNIQUE_RENAME
	/// What object created this projection? Can be null as a projector isn't required for this to exist
	var/obj/item/wargame_projector/projector

/obj/structure/wargame_hologram/Initialize(mapload, source_projector)
	. = ..()
	if(source_projector)
		projector = source_projector
		LAZYADD(projector.projections, src)

/obj/structure/wargame_hologram/Destroy()
	if(projector)
		LAZYREMOVE(projector.projections, src)
		projector = null
	return ..()

/obj/structure/wargame_hologram/update_overlays()
	. = ..()
	. += emissive_appearance(icon, icon_state, src)

/*
Projections for 'moving vessels' in order from smallest to largest representation
*/

/obj/structure/wargame_hologram/strike_craft
	name = "攻击机标记"
	desc = "纳米传讯兵棋中代表单架攻击机的标准标记。"
	icon_state = "strikesingle"

/obj/structure/wargame_hologram/strike_craft/wing
	name = "攻击机联队标记"
	desc = "纳米传讯兵棋中代表攻击机联队的标准标记。"
	icon_state = "strikewing"

/obj/structure/wargame_hologram/ship_marker
	name = "小型舰船标记"
	desc = "纳米传讯兵棋中代表小型舰船的标准标记，通常用于轻护卫舰大小的舰船。"
	icon_state = "smallship"

/obj/structure/wargame_hologram/ship_marker/medium
	name = "中型舰船标记"
	desc = "纳米传讯兵棋中代表中型舰船的标准标记，通常用于驱逐舰大小的舰船。"
	icon_state = "mediumship"

/obj/structure/wargame_hologram/ship_marker/large
	name = "大型舰船标记"
	desc = "纳米传讯兵棋中代表大型舰船的标准标记，通常用于巡洋舰大小的舰船。"
	icon_state = "bigship"

/obj/structure/wargame_hologram/ship_marker/large/alternate
	name = "备用大型舰船标记"
	desc = "纳米传讯兵棋中代表大型舰船的另一款标记，通常用于航母等特殊舰船。"
	icon_state = "bigship_alternate"

/obj/structure/wargame_hologram/unidentified
	name = "不明目标标记"
	desc = "纳米传讯兵棋中代表尚未识别目标的标准标记。"
	icon_state = "unidentified"

/*
Projections for misc stuff, like stations, scout probes, or incoming missiles
*/

/obj/structure/wargame_hologram/missile_warning
	name = "飞行中导弹标记"
	desc = "纳米传讯兵棋中代表正在飞向目标的导弹或鱼雷的标准标记。"
	icon_state = "missile"

/obj/structure/wargame_hologram/probe
	name = "探测器标记"
	desc = "纳米传讯兵棋中代表探测器大小舰船或设施的标准标记。"
	icon_state = "probe"

/obj/structure/wargame_hologram/stationary_structure
	name = "空间站标记"
	desc = "纳米传讯兵棋中代表各类大小空间站的标准标记。"
	icon_state = "station"

/obj/structure/wargame_hologram/stationary_structure/platform
	name = "平台标记"
	desc = "纳米传讯兵棋中代表各种大小、武装或非武装平台的标准标记。"
	icon_state = "platform"

/*
Projections for space 'terrain' like asteroids and dust clouds
*/

/obj/structure/wargame_hologram/dust
	name = "尘埃云标记"
	desc = "纳米传讯兵棋中代表大型星际尘埃云的标准标记。"
	icon_state = "dustcloud"

/obj/structure/wargame_hologram/asteroid
	name = "小型小行星标记"
	desc = "纳米传讯兵棋中代表中小型小行星的标准标记。"
	icon_state = "asteroidsmall"

/obj/structure/wargame_hologram/asteroid/large
	name = "大型小行星标记"
	desc = "纳米传讯兵棋中代表中大型小行星的标准标记。"
	icon_state = "asteroidlarge"

/obj/structure/wargame_hologram/asteroid/cluster
	name = "小行星群标记"
	desc = "纳米传讯兵棋中代表一群较小小行星的标准标记。"
	icon_state = "asteroidcluster"

/obj/structure/wargame_hologram/planet
	name = "行星标记"
	desc = "纳米传讯兵棋中代表各种大小行星天体的标准标记。"
	icon_state = "planet"
