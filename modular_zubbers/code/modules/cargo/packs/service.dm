/datum/supply_pack/service/jukebox
	name = "点唱机箱"
	desc = "这一班太无聊了？放点音乐，用点唱机活跃一下气氛吧！"
	cost = CARGO_CRATE_VALUE * 50
	contains = list(/obj/machinery/jukebox/no_access)
	crate_type = /obj/structure/closet/crate/large
	access_view = ACCESS_BAR

/datum/supply_pack/organic/exoticseeds/New()
	. = ..()
	contains += /obj/item/seeds/vaporsac
