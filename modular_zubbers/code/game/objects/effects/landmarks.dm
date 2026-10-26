/obj/effect/landmark/start/blacksmith
	name = "Blacksmith"
	icon_state = "Curator"

/obj/effect/landmark/navigate_destination/autoname
	name = "自动命名导航目的地"
	location = null

/obj/effect/landmark/navigate_destination/autoname/Initialize(mapload)
	. = ..()
	location = "[loc.loc.name]" //This looks unsafe. Intentional. This should runtime if there are issues.

/obj/effect/landmark/latejoin_override
	name = "中途加入位置覆写"

/obj/effect/landmark/latejoin_override/Initialize(mapload)
	..()
	SSjob.latejoin_override_trackers += loc
	return INITIALIZE_HINT_QDEL

/datum/controller/subsystem/job/
	var/list/latejoin_override_trackers = list()

/obj/effect/landmark/navigate_destination/cryo
	location = "冷冻休眠舱"

/obj/effect/landmark/navigate_destination/cryo_west
	location = "冷冻休眠舱（西）"

/obj/effect/landmark/navigate_destination/cryo_east
	location = "冷冻休眠舱（东）"

/obj/effect/landmark/navigate_destination/cryo_central
	location = "冷冻休眠舱（中央）"

/obj/effect/landmark/navigate_destination/dockpublicmining
	location = "公共采矿区"

/obj/effect/landmark/navigate_destination/dockaux
	location = "辅助舰船泊位"

/obj/effect/landmark/navigate_destination/docksec
	location = "次级舰船泊位"

/obj/effect/landmark/navigate_destination/sauna
	location = "桑拿房"
