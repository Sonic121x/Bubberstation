
/obj/item/gps
	name = "全球定位系统"
	desc = "自 2016 年起，帮助迷路的宇航员在各个星球上找到方向。"
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "gps-c"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	obj_flags = UNIQUE_RENAME
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	var/gpstag
	var/tracking_on = TRUE
	var/debug_mode = FALSE
	var/overlay_icon = "working"

/obj/item/gps/Initialize(mapload)
	. = ..()
	add_gps_component()

/// Adds the GPS component to this item.
/obj/item/gps/proc/add_gps_component()
	AddComponent(/datum/component/gps/item, gpstag, tracking_on, overlay_state = overlay_icon, debug = debug_mode)

/obj/item/gps/spaceruin
	gpstag = SPACE_SIGNAL_GPSTAG

/obj/item/gps/science
	icon_state = "gps-s"
	gpstag = "SCI0"

/obj/item/gps/engineering
	icon_state = "gps-e"
	gpstag = "ENG0"

/obj/item/gps/mining
	icon_state = "gps-m"
	gpstag = "MINE0"
	desc = "有助于救援受困或受伤矿工的定位系统。采矿时始终随身携带一个，可能会救你一命。"

/obj/item/gps/cyborg
	icon_state = "gps-b"
	gpstag = "BORG0"
	desc = "矿业半机械人的内置定位系统，可用作受损半机械人的回收信标，或采矿队的协作工具。"

/obj/item/gps/mining/internal
	icon_state = "gps-m"
	gpstag = "MINER"
	desc = "有助于救援受困或受伤矿工的定位系统。采矿时始终随身携带一个，可能会救你一命。"

/*
 * GPS for pAIS, which only allows access if it's contained within the user.
 */
/obj/item/gps/pai
	gpstag = "PAI0"

/obj/item/gps/pai/add_gps_component()
	AddComponent(/datum/component/gps/item, gpstag, state = GLOB.inventory_state)

/obj/item/gps/visible_debug
	name = "坐标显示 GPS"
	gpstag = "ADMIN"
	desc = "这台由管理员生成的 GPS 装置在地板上拖动时，会在经过的地块上\
		显示坐标。尤其适合\
		标记过渡边界周围的区域。"
	tracking_on = FALSE
	debug_mode = TRUE
	overlay_icon = FALSE
