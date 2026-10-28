/datum/round_event_control/stray_cargo/changeling_zombie
	typepath = /datum/round_event/stray_cargo/changeling_zombie

	name = "漂流变形怪僵尸病毒舱"
	description = "生成一个货舱，内含一种传染性极强的变形怪僵尸病毒试剂。"
	category = EVENT_CATEGORY_INVASION

	weight = 3
	max_occurrences = 1
	earliest_start = 60 MINUTES

	min_players = 50

	admin_setup = list(/datum/event_admin_setup/set_location/stray_cargo)

	alert_observers = TRUE

/datum/round_event/stray_cargo/changeling_zombie
	possible_pack_types = list(/datum/supply_pack/misc/changeling_zombie)
	fakeable = FALSE

//The virus.
/datum/supply_pack/misc/changeling_zombie
	name = "NT-CZV-1 药瓶"
	desc = "内含一瓶 NT-CZV 试剂。高度机密。"
	order_flags = ORDER_SPECIAL // Can only be sent by admins
	contains = list() //We don't put contents in this to do snowflake content in populate_contents
	crate_type = /obj/structure/closet/crate/changeling_zombie

/obj/structure/closet/crate/changeling_zombie/PopulateContents()
	new /obj/item/reagent_containers/cup/glass/changeling_zombie_virus(src)
	var/obj/item/reagent_containers/cup/glass/changeling_zombie_virus/empty/broken_one = new(src)
	broken_one.smash(src.loc, null, null, TRUE)

//The cure.
/obj/item/paper/fluff/shuttles/changeling_zombie_instructions/Initialize(mapload, ...)
	. = ..()
	default_raw_text = "<h1>NT-CZV-1 治愈说明</h1><br>要治愈尚未转化的感染船员，让他们累积至少 [CHANGELING_ZOMBIE_TOXINS_THRESHOLD_TO_CURE] 点毒素伤害，然后迅速清除全部毒素。<br>要治愈已经转化的船员，请用霰弹枪反复射击其头部。"

/obj/structure/closet/crate/medical/changeling_zombie_cure/PopulateContents()
	new /obj/item/paper/fluff/shuttles/changeling_zombie_instructions(src)
	new /obj/item/ammo_box/advanced/s12gauge/buckshot(src)
	new /obj/item/ammo_box/advanced/s12gauge/buckshot(src)

/obj/structure/closet/crate/medical/changeling_zombie_cure/populate_contents_immediate() //This has no reason to exist other than to satisfy linters.
	new /obj/item/gun/ballistic/shotgun/lethal(src)
