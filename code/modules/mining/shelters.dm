///Map templates used for bluespace survival capsules.
/datum/map_template/shelter
	has_ceiling = TRUE
	ceiling_turf = /turf/open/floor/engine/hull
	ceiling_baseturfs = list(/turf/open/floor/plating)
	///The id of the shelter template in the relative list from the mapping subsystem
	var/shelter_id
	///The description of the shelter, shown when examining survival capsule.
	var/description
	///If turf in the affected turfs is in this list, the survival capsule cannot be deployed.
	var/list/blacklisted_turfs
	///Areas where the capsule cannot be deployed.
	var/list/banned_areas
	///If any object in this list is found in the affected turfs, the capsule cannot deploy.
	var/list/banned_objects = list()

/datum/map_template/shelter/New()
	. = ..()
	blacklisted_turfs = typecacheof(/turf/closed)
	banned_areas = typecacheof(list(/area/shuttle, /area/station/holodeck))

/datum/map_template/shelter/proc/check_deploy(turf/deploy_location, obj/item/survivalcapsule/capsule, ignore_flags = NONE)
	var/affected = get_affected_turfs(deploy_location, centered=TRUE)
	for(var/turf/turf in affected)
		var/area/area = get_area(turf)
		if(is_type_in_typecache(area, banned_areas))
			return SHELTER_DEPLOY_BAD_AREA

		if(is_type_in_typecache(turf, blacklisted_turfs))
			return SHELTER_DEPLOY_BAD_TURFS

		for(var/obj/object in turf)
			if(!(ignore_flags & CAPSULE_IGNORE_ANCHORED_OBJECTS) && object.density && object.anchored)
				return SHELTER_DEPLOY_ANCHORED_OBJECTS
			if(!(ignore_flags & CAPSULE_IGNORE_BANNED_OBJECTS) && is_type_in_typecache(object, banned_objects))
				return SHELTER_DEPLOY_BANNED_OBJECTS

	// Check if the shelter sticks out of map borders
	var/shelter_origin_x = deploy_location.x - round(width/2)
	if(shelter_origin_x <= 1 || shelter_origin_x+width > world.maxx)
		return SHELTER_DEPLOY_OUTSIDE_MAP
	var/shelter_origin_y = deploy_location.y - round(height/2)
	if(shelter_origin_y <= 1 || shelter_origin_y+height > world.maxy)
		return SHELTER_DEPLOY_OUTSIDE_MAP

	return SHELTER_DEPLOY_ALLOWED

/datum/map_template/shelter/alpha
	name = "阿尔法避难所"
	shelter_id = "shelter_alpha"
	description = "一座舒适、自成一体的加压避难所，内置导航、娱乐、医疗设施以及\
		睡眠区！现在下单，\
		我们还会额外附赠一台袖珍风扇，\
		完全免费！"
	mappath = "_maps/templates/shelter_1.dmm"

/datum/map_template/shelter/alpha/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/beta
	name = "贝塔避难所"
	shelter_id = "shelter_beta"
	description = "一座极其奢华的避难所，家中所需的一切应有尽有，\
		包括铺着地毯的地面、冷热自来水、\
		一顿三道菜的美食、烹饪设施，\
		以及一位豪华伴侣，让你在灰烬风暴来袭时\
		也不至于感到孤单。"
	mappath = "_maps/templates/shelter_2.dmm"

/datum/map_template/shelter/beta/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/charlie
	name = "查理避难所"
	shelter_id = "shelter_charlie"
	description = "一间豪华高端的酒吧，内有完整的吧台，\
		外加两台自动售货机、桌椅，\
		以及一间配有洗手池的洗手间。\
		这不是生存舱，所以你该料到，\
		若你正流血濒死，它可救不了你。"
	mappath = "_maps/templates/shelter_3.dmm"

/datum/map_template/shelter/charlie/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/toilet
	name = "应急解手避难所"
	shelter_id = "shelter_toilet"
	description = "一处极简的应急避难所，只为那些\
		在离家很远的地方突感内急的倒霉员工\
		提供最基本的便利。"
	mappath = "_maps/templates/shelter_t.dmm"

/datum/map_template/shelter/toilet/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

///Not exactly mining shelters, but they make use of survival capsules code.
/datum/map_template/shelter/fishing
	name = "淡水泉"
	shelter_id = "fishing_default"
	description = "一处可以钓到多种淡水鱼的泉水，包括金鱼、鲶鱼和狗鱼。"
	mappath = "_maps/templates/fishing_freshwater.dmm"
	has_ceiling = FALSE
	///The icon shown in the radial menu
	var/radial_icon = "river"
	/**
	 * If FALSE, the capsule needs to be emagged for this template to be selectable.
	 * its usage will also be logged, and admins warned if used indoors.
	 */
	var/safe = TRUE

/datum/map_template/shelter/fishing/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	blacklisted_turfs += typecacheof(/turf/open/openspace)
	// Stop the capsule from being used around pipes and cables (if not emagged) cuz it'd look bad and a bit disruptive.
	banned_objects = typecacheof(list(
		/obj/structure/disposalpipe,
		/obj/machinery/atmospherics/pipe,
		/obj/structure/cable,
		/obj/structure/transit_tube,
	))

/datum/map_template/shelter/fishing/beach
	name = "咸水泉"
	shelter_id = "fishing_beach"
	mappath = "_maps/templates/fishing_saltwater.dmm"
	description = "一处可以钓到多种咸水鱼的泉水，包括小丑鱼、河豚和魟鱼。"
	radial_icon = "seaboat"

/datum/map_template/shelter/fishing/tizira
	name = "提兹拉泉"
	shelter_id = "fishing_tizira"
	mappath = "_maps/templates/fishing_tizira.dmm"
	description = "一处可以钓到数种蜥蜴人母星提兹拉原生鱼类的泉水。"
	radial_icon = "planet"

/datum/map_template/shelter/fishing/hot_spring
	name = "温泉"
	shelter_id = "fishing_hot_spring"
	mappath = "_maps/templates/fishing_hot_spring.dmm"
	description = "一处温泉。作为钓点用处有限，但至少你能舒舒服服地泡个澡。"
	radial_icon = "onsen"

/datum/map_template/shelter/fishing/ice
	name = "冰钓点"
	shelter_id = "fishing_ice"
	mappath = "_maps/templates/fishing_ice.dmm"
	description = "一个已经凿好的小冰洞，四周是积雪。在这里可以钓到鲑鱼和北极红点鲑。"
	radial_icon = "ice"

/datum/map_template/shelter/fishing/lava
	name = "熔岩钓点"
	shelter_id = "fishing_lava"
	mappath = "_maps/templates/fishing_lava.dmm"
	description = "一小片 2x2 的熔岩水洼，活物请勿靠近。你可以在这里钓到熔岩环鱼，说不定还能钓上一只箱子。"
	radial_icon = "lava"
	safe = FALSE

/datum/map_template/shelter/fishing/plasma
	name = "等离子钓点"
	shelter_id = "fishing_plasma"
	mappath = "_maps/templates/fishing_plasma.dmm"
	description = "一小片 2x2 的等离子水洼，活物请勿靠近。你可以在这里钓到熔岩环鱼和北极蟹。"
	radial_icon = "plasma"
	safe = FALSE

/datum/map_template/shelter/fishing/depths
	name = "深海钓点"
	shelter_id = "fishing_depths"
	mappath = "_maps/templates/fishing_depths.dmm"
	description = "一片 3x3 的深水池，深到蹚过去都会让人累得够呛。你可以在这里钓到海洋鱼类。"
	radial_icon = "depths"
	safe = FALSE
