/obj/structure/closet/crate/large/smithing
	name = "锻造设备箱"
	desc = "一个装满锻造设备的沉重木箱。需要撬棍才能打开。"

/obj/structure/closet/crate/large/smithing/PopulateContents()
	new /obj/structure/reagent_anvil(src)
	new /obj/structure/reagent_crafting_bench(src)
	new /obj/structure/reagent_dispensers/reagent_smithing_basin(src)
	new /obj/structure/reagent_forge(src)
	new /obj/item/reagent_containers/cup/jerrycan/smithing_oil(src)
	new /obj/item/reagent_containers/cup/jerrycan/smithing_oil(src)
	new /obj/item/wallframe/wall_heater(src)
	new /obj/item/wrench

/obj/structure/closet/crate/wooden/blacksmith
	name = "铁匠设备箱"

/obj/structure/closet/crate/wooden/blacksmith/PopulateContents()
	new /obj/item/forging/tongs(src)
	new /obj/item/forging/hammer(src)
	new /obj/item/forging/billow(src)
	var/obj/item/stack/sheet/tempstack = new /obj/item/stack/sheet/mineral/wood(src)
	tempstack.add(9)
	new /obj/item/stack/sheet/mineral/coal/five(src)
	tempstack = new /obj/item/stack/sheet/glass(src)
	tempstack.add(9)
	new /obj/item/stack/sheet/iron/ten(src)
	new /obj/item/stack/sheet/leather/five(src)
	new /obj/item/stack/sheet/cloth/five(src)

/obj/item/survivalcapsule/debug_smithing_pod
	name = "可部署调试锻造舱"
	desc = "你大概不应该看到这个。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "debug_smithing"
	used = FALSE

/datum/map_template/shelter/debug_smithing
	name = "调试锻造舱部署器"
	shelter_id = "debug_smithing"
	description = "每次都要重新搭建锻造设施，我已经受够了"
	mappath = "_maps/bubber/pods/debug_smithing.dmm"
