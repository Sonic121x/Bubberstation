/datum/map_template/shelter/plap
	name = "便携式监听哨"
	shelter_id = "shelter_plap"
	description = "一座舒适的自给式监听哨，内置\
		摄像头、医疗记录、PDA 服务器监听以及一台\
		传真机！现在就订购，我们还附赠一台\
		复印机，完全免费！"
	mappath = "_maps/bubber/pods/listeningbasics.dmm"

/datum/map_template/shelter/sauna
	name = "豪华热水浴缸与桑拿生存舱"
	shelter_id = "shelter_s"
	description = "当熔岩地带的高温、灰烬与死亡令人难以忍受时，这就是一座温暖舒适、便于部署的豪华桑拿。\
		内置个人储物柜空间与更衣室，可存放你的装备。\
		需要 10x10 的空地，且不得有障碍物。<span class ='red'><b>警告：部署过程迅速且具有爆炸性！</b></span>"
	mappath = "_maps/bubber/pods/shelter_s.dmm"

/datum/map_template/shelter/sauna/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/delta
	name = "德尔塔避难所"
	shelter_id = "shelter_delta"
	description = "一座应急医疗舱，配有停滞床与手术套间。\
		部署它，以防死亡。"
	mappath = "_maps/bubber/pods/shelter_4.dmm"

/datum/map_template/shelter/delta/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/echo
	name = "回声避难所"
	shelter_id = "shelter_echo"
	description = "用于采集间歇泉的舱体"
	mappath = "_maps/bubber/pods/shelter_5.dmm"

/datum/map_template/shelter/echo/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)
