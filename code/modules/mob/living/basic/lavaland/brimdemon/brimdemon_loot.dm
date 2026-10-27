/// Reagent pool left by dying brimdemon
/obj/effect/decal/cleanable/brimdust
	name = "硫磺尘"
	desc = "硫磺恶魔留下的尘土。因其促进植物生长的功效而被视为珍品。"
	icon_state = "brimdust"
	icon = 'icons/obj/mining.dmi'
	plane = GAME_PLANE
	layer = CLEANABLE_OBJECT_LAYER
	mergeable_decal = FALSE
	decal_reagent = /datum/reagent/brimdust
	reagent_amount = 15

/// Ashwalker ore sensor crafted from brimdemon ash
/obj/item/ore_sensor
	name = "矿物探测器"
	desc = "这件耳挂式工具借助恶魔频率探测附近地形中的矿石。"
	icon_state = "oresensor"
	icon = 'icons/obj/mining.dmi'
	slot_flags = ITEM_SLOT_EARS
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)
	var/range = 5
	var/cooldown = 4 SECONDS //between the standard and the advanced ore scanner in strength
	COOLDOWN_DECLARE(ore_sensing_cooldown)

/obj/item/ore_sensor/equipped(mob/user, slot, initial)
	. = ..()
	if(slot & ITEM_SLOT_EARS)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/ore_sensor/dropped(mob/user, silent)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/ore_sensor/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, ore_sensing_cooldown))
		return
	COOLDOWN_START(src, ore_sensing_cooldown, cooldown)
	mineral_scan_pulse(get_turf(src), range, src)
