
/**
 * # Power cell
 *
 * Power cells, used primarily for handheld and portable things. Holds a reasonable amount of power.
 */
/obj/item/stock_parts/power_store/cell
	name = "电池"
	desc = "可充电的电化学电池。"
	icon = 'icons/obj/machines/cell_charger.dmi'
	icon_state = "cell"
	inhand_icon_state = "cell"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	force = 5
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	emp_damage_modifier = 1
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*7, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.5)

/obj/item/stock_parts/power_store/cell/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_FISHING_BAIT, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_POISONOUS_BAIT, INNATE_TRAIT) //bro is fishing using lithium...
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/battery_match)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/stock_parts/power_store/cell/grind_results()
	return list(/datum/reagent/lithium = 15, /datum/reagent/iron = 5, /datum/reagent/silicon = 5)

/* Cell variants*/
/obj/item/stock_parts/power_store/cell/empty
	empty = TRUE

/obj/item/stock_parts/power_store/cell/crap
	name = "\improper 纳米传讯牌可充 AA 电池"
	desc = "等离子顶盖，无人能及。" //TOTALLY TRADEMARK INFRINGEMENT
	icon_state = "aa_cell"
	maxcharge = STANDARD_CELL_CHARGE * 0.5
	custom_materials = list(/datum/material/glass=SMALL_MATERIAL_AMOUNT*0.4)

/obj/item/stock_parts/power_store/cell/crap/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/item/stock_parts/power_store/cell/crap/empty
	empty = TRUE

/obj/item/stock_parts/power_store/cell/upgraded
	name = "升级版电池"
	desc = "容量比普通电池略高的电池！"
	icon_state = "9v_cell"
	maxcharge = STANDARD_CELL_CHARGE * 2.5

	custom_materials = list(/datum/material/glass=SMALL_MATERIAL_AMOUNT*0.5)
	chargerate = STANDARD_CELL_RATE * 0.5

/* BUBBER EDIT REMOVAL BEGIN - New icon in modular_skyrat/modules/aesthetics/cells/cell.dm
/obj/item/stock_parts/power_store/cell/upgraded/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()
*/// BUBBER EDIT REMOVAL END

/obj/item/stock_parts/power_store/cell/upgraded/plus
	name = "升级版电池+"
	desc = "容量比基础型号更高的电池！"
	maxcharge = STANDARD_CELL_CHARGE * 5

/obj/item/stock_parts/power_store/cell/secborg
	name = "安保半机械人可充 D 型电池"
	maxcharge = STANDARD_CELL_CHARGE * 0.6
	custom_materials = list(/datum/material/glass=SMALL_MATERIAL_AMOUNT*0.4)

/obj/item/stock_parts/power_store/cell/secborg/empty
	empty = TRUE

/obj/item/stock_parts/power_store/cell/mini_egun
	name = "微型能量枪电池"
	maxcharge = STANDARD_CELL_CHARGE * 0.6

/obj/item/stock_parts/power_store/cell/hos_gun
	name = "X-01 多相能量枪电池"
	maxcharge = STANDARD_CELL_CHARGE * 1.2

/obj/item/stock_parts/power_store/cell/pulse //200 pulse shots
	name = "脉冲步枪电池"
	emp_damage_modifier = 0.5
	maxcharge = STANDARD_CELL_CHARGE * 40
	chargerate = STANDARD_CELL_RATE * 0.75

/obj/item/stock_parts/power_store/cell/pulse/carbine //25 pulse shots
	name = "脉冲卡宾枪电池"
	maxcharge = STANDARD_CELL_CHARGE * 5

/obj/item/stock_parts/power_store/cell/pulse/pistol //10 pulse shots
	name = "脉冲手枪电池"
	maxcharge = STANDARD_CELL_CHARGE * 2

/obj/item/stock_parts/power_store/cell/laser_pistol
	name = "激光手枪电池"
	chargerate = STANDARD_CELL_RATE * 0.15

/obj/item/stock_parts/power_store/cell/ninja
	name = "黑色电池"
	icon_state = "bscell"
	emp_damage_modifier = 3
	maxcharge = STANDARD_CELL_CHARGE * 10
	custom_materials = list(/datum/material/glass=SMALL_MATERIAL_AMOUNT*0.6)
	chargerate = STANDARD_CELL_RATE

/obj/item/stock_parts/power_store/cell/high
	name = "高容量电池"
	icon_state = "hcell"
	emp_damage_modifier = 3
	maxcharge = STANDARD_CELL_CHARGE * 10
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.7, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.6)
	chargerate = STANDARD_CELL_RATE * 0.75


/obj/item/stock_parts/power_store/cell/high/empty
	empty = TRUE

/obj/item/stock_parts/power_store/cell/super
	name = "超大容量电池"
	icon_state = "scell"
	emp_damage_modifier = 5
	maxcharge = STANDARD_CELL_CHARGE * 20
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.7, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.7)
	chargerate = STANDARD_CELL_RATE

/obj/item/stock_parts/power_store/cell/super/empty
	empty = TRUE

/obj/item/stock_parts/power_store/cell/hyper
	name = "超高容量电池"
	icon_state = "hpcell"
	emp_damage_modifier = 5
	maxcharge = STANDARD_CELL_CHARGE * 30
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.7, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.8)
	chargerate = STANDARD_CELL_RATE * 1.5

/obj/item/stock_parts/power_store/cell/hyper/empty
	empty = TRUE

/obj/item/stock_parts/power_store/cell/bluespace
	name = "蓝空间电池"
	desc = "可充电的跨次元电池。"
	icon_state = "bscell"
	emp_damage_modifier = 5
	maxcharge = STANDARD_CELL_CHARGE * 40
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.8,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.6,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 1.6,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 1.2,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT,
	)
	chargerate = STANDARD_CELL_RATE * 2

/obj/item/stock_parts/power_store/cell/bluespace/empty
	empty = TRUE

/obj/item/stock_parts/power_store/cell/infinite
	name = "无限容量电池"
	icon_state = "icell"
	emp_damage_modifier = 0
	maxcharge = INFINITY //little disappointing if you examine it and it's not huge
	custom_materials = list(/datum/material/glass=HALF_SHEET_MATERIAL_AMOUNT)
	chargerate = INFINITY
	ratingdesc = FALSE

/obj/item/stock_parts/power_store/cell/infinite/use(used, force = FALSE)
	return used

/obj/item/stock_parts/power_store/cell/infinite/abductor
	name = "虚空核心"
	desc = "一种似乎能凭空产生能量的外星电池。"
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "cell"
	maxcharge = STANDARD_CELL_CHARGE * 50
	ratingdesc = FALSE

/obj/item/stock_parts/power_store/cell/infinite/abductor/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/item/stock_parts/power_store/cell/potato
	name = "土豆电池"
	desc = "可充电的淀粉基电池。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "potato"
	maxcharge = STANDARD_CELL_CHARGE * 0.3
	emp_damage_modifier = 0.5 //It's biological, so
	charge_light_type = null
	connector_type = null
	custom_materials = null
	grown_battery = TRUE //it has the overlays for wires
	custom_premium_price = PAYCHECK_CREW

/obj/item/stock_parts/power_store/cell/potato/Initialize(mapload, override_maxcharge)
	charge = maxcharge * 0.3
	. = ..()

/obj/item/stock_parts/power_store/cell/emproof
	name = "\improper 防电磁脉冲电池"
	desc = "一块防电磁脉冲的电池。"
	emp_damage_modifier = 0
	maxcharge = STANDARD_CELL_CHARGE * 0.5

/obj/item/stock_parts/power_store/cell/emproof/Initialize(mapload)
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF)
	return ..()

/obj/item/stock_parts/power_store/cell/emproof/empty
	empty = TRUE

/obj/item/stock_parts/power_store/cell/emproof/corrupt()
	return

/obj/item/stock_parts/power_store/cell/emproof/slime
	name = "防电磁脉冲史莱姆核心"
	desc = "注入等离子体的黄色史莱姆核心。其有机特质使它不受电磁脉冲影响。"
	icon = 'icons/mob/simple/slimes.dmi'
	icon_state = "yellow-core"
	custom_materials = null
	maxcharge = STANDARD_CELL_CHARGE * 5
	charge_light_type = null
	connector_type = "slimecore"

/obj/item/stock_parts/power_store/cell/emergency_light
	name = "微型电池"
	desc = "一块容量极小的微型电池。装在灯具中，在停电时为其供电。"
	maxcharge = STANDARD_CELL_CHARGE * 0.12 //Emergency lights use 0.2 W per tick, meaning ~10 minutes of emergency power from a cell
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT*0.2)
	w_class = WEIGHT_CLASS_TINY

/obj/item/stock_parts/power_store/cell/emergency_light/Initialize(mapload)
	. = ..()
	var/area/area = get_area(src)
	if(area)
		if(!area.lightswitch || !area.light_power)
			charge = 0 //For naturally depowered areas, we start with no power

/obj/item/stock_parts/power_store/cell/crystal_cell
	name = "水晶电池"
	desc = "由结晶等离子体制成的高功率电池。"
	icon_state = "crystal_cell"
	maxcharge = STANDARD_CELL_CHARGE * 50
	chargerate = 0
	charge_light_type = null
	connector_type = "crystal"
	custom_materials = null

/obj/item/stock_parts/power_store/cell/crystal_cell/grind_results()
	return null

/obj/item/stock_parts/power_store/cell/ethereal
	name = "请上报管理员"
	desc = "你不应该看到这个"
	maxcharge = ETHEREAL_CHARGE_DANGEROUS
	charge = ETHEREAL_CHARGE_FULL
	icon_state = null
	charge_light_type = null
	connector_type = null
	custom_materials = null
	emp_damage_modifier = 0

/obj/item/stock_parts/power_store/cell/ethereal/grind_results()
	return null

/obj/item/stock_parts/power_store/cell/ethereal/examine(mob/user)
	. = ..()
	CRASH("[src.type] got examined by [user]")
