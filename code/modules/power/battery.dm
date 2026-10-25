/obj/item/stock_parts/power_store/battery
	name = "电池组"
	desc = "由多节可充电的电化学电池串联而成，能比标准电池储存多得多的电量。"
	icon = 'icons/obj/machines/cell_charger.dmi'
	icon_state = "cellbig"
	cell_size_prefix = "cellbig"
	inhand_icon_state = "cell"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	throwforce = 5
	throw_speed = 2
	throw_range = 2
	custom_materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/glass=SMALL_MATERIAL_AMOUNT*2)
	rating_base = STANDARD_BATTERY_CHARGE
	maxcharge = STANDARD_BATTERY_CHARGE
	chargerate = STANDARD_BATTERY_RATE

/obj/item/stock_parts/power_store/battery/grind_results()
	return list(/datum/reagent/lithium = 60, /datum/reagent/iron = 10, /datum/reagent/silicon = 10)

/obj/item/stock_parts/power_store/battery/empty
	empty = TRUE

/obj/item/stock_parts/power_store/battery/upgraded
	name = "升级版电池组"
	desc = "容量比普通电池组略高的电池组！"
	maxcharge = STANDARD_BATTERY_CHARGE * 2.5
	chargerate = STANDARD_BATTERY_RATE * 0.5

/obj/item/stock_parts/power_store/battery/high
	name = "高容量电池组"
	icon_state = "hcellbig"
	maxcharge = STANDARD_BATTERY_CHARGE * 10
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3)
	chargerate = STANDARD_BATTERY_RATE * 0.75

/obj/item/stock_parts/power_store/battery/high/empty
	empty = TRUE

/obj/item/stock_parts/power_store/battery/super
	name = "超大容量电池组"
	icon_state = "scellbig"
	maxcharge = STANDARD_BATTERY_CHARGE * 20
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4)
	chargerate = STANDARD_BATTERY_RATE

/obj/item/stock_parts/power_store/battery/super/empty
	empty = TRUE

/obj/item/stock_parts/power_store/battery/hyper
	name = "超高容量电池组"
	icon_state = "hpcellbig"
	maxcharge = STANDARD_BATTERY_CHARGE * 30
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 1.5)
	chargerate = STANDARD_BATTERY_RATE * 1.5

/obj/item/stock_parts/power_store/battery/hyper/empty
	empty = TRUE

/obj/item/stock_parts/power_store/battery/bluespace
	name = "蓝空间电池组"
	desc = "可充电的跨次元电池组。"
	icon_state = "bscellbig"
	maxcharge = STANDARD_BATTERY_CHARGE * 40
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 1.6,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 1.2,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT,
	)
	chargerate = STANDARD_BATTERY_RATE * 2

/obj/item/stock_parts/power_store/battery/bluespace/empty
	empty = TRUE

/obj/item/stock_parts/power_store/battery/crap
	name = "\improper 纳米传讯牌可充 AA 电池组"
	desc = "等离子顶盖，无人能及。" //TOTALLY TRADEMARK INFRINGEMENT
	maxcharge = STANDARD_BATTERY_CHARGE * 0.5

/obj/item/stock_parts/power_store/battery/crap/empty
	empty = TRUE

/obj/item/stock_parts/power_store/battery/infinite
	name = "无限容量电池组"
	desc = "容量取之不尽的跨次元电池组。"
	icon_state = "icellbig"
	maxcharge = INFINITY
	chargerate = INFINITY
	ratingdesc = FALSE

/obj/item/stock_parts/power_store/battery/infinite/use(used, force = FALSE)
	return used
