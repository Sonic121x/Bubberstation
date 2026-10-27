/obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus
	name = "\improper 塔肯黑锈地狱三头犬套件"
	desc = "“塔肯工业黑锈打捞”的“地狱三头犬”炮塔部署套件，可部署一台由所装弹匣供弹的炮塔。\
	此型号配有三个可调弹匣槽，兼容大多数常见弹匣。"
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_toolbox"
	righthand_file = 'modular_skyrat/modules/tarkon/icons/mob/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/tarkon/icons/mob/inhands/lefthand.dmi'
	inhand_icon_state = "cerberus_turretkit"
	worn_icon_state = "cerberus_harness"
	worn_icon = 'modular_skyrat/modules/tarkon/icons/mob/clothing/belt.dmi'
	has_latches = FALSE
	slot_flags = ITEM_SLOT_BELT
	easy_deploy = TRUE
	easy_deploy_timer = 1.5 SECONDS
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/cerberus //To make it more available for subtyping. LET. THEM. COOK.
	mag_slots = 3 //how many magazines can be held.
	mag_types_allowed = list( //This is a whitelist for what is allowed. Nothing else may enter.
		/obj/item/ammo_box/magazine/m9mm,
		/obj/item/ammo_box/magazine/m45, // Near-matching DPS replacement
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
		/obj/item/ammo_box/magazine/miecz,
		/obj/item/ammo_box/magazine/lanca,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite
	name = "\improper 塔肯工业重装步兵套件"
	desc = "“塔肯工业”的“重装步兵”炮塔部署套件，可部署一台由所装弹匣供弹的炮塔。\
	此型号配有两个可调弹匣槽，兼容4.6×30毫米、女皇和特拉比斯特弹匣。"
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "hoplite_toolbox"
	righthand_file = 'modular_skyrat/modules/tarkon/icons/mob/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/tarkon/icons/mob/inhands/lefthand.dmi'
	inhand_icon_state = "hoplite_turretkit"
	worn_icon = 'modular_skyrat/modules/tarkon/icons/mob/clothing/belt.dmi'
	worn_icon_state = "hoplite_harness"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/hoplite
	mag_slots = 2
	slot_flags = ITEM_SLOT_BELT
	easy_deploy = TRUE
	easy_deploy_timer = 1.5 SECONDS
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/wt550m9, //Matching DPS replacement
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
		/obj/item/ammo_box/magazine/miecz,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

/obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

////// Turrets //////
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/cerberus
	name = "\improper 塔肯黑锈“地狱三头犬”守卫炮塔"
	desc = "塔肯工业黑锈打捞部门使用的重型防护炮塔，用于保护危险环境中的工人。"
	integrity_failure = 0
	max_integrity = 200
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_off"
	base_icon_state = "cerberus"
	faction = list(FACTION_TARKON, FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/hoplite
	name = "\improper 塔肯工业“重装步兵”点防御炮塔"
	desc = "塔肯工业用于保护民用设施的防御炮塔。"
	max_integrity = 120
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "hoplite_off"
	base_icon_state = "hoplite"
	shot_delay = 15 //1.5 seconds
	faction = list(FACTION_TARKON, FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite/pre_filled

/obj/item/turret_assembly/cerberus
	name = "地狱三头犬装甲板组件"
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_assembly"
	desc = "弹匣供弹炮塔的组装部件，建造时还需要机匣、伺服机构和传感器。这套用于“地狱三头犬”型号。"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 20,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
	)
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus

/obj/item/turret_assembly/hoplite
	name = "重装步兵装甲板组件"
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "hoplite_assembly"
	desc = "弹匣供弹炮塔的组装部件，建造时还需要机匣、伺服机构和传感器。这套用于“重装步兵”型号。"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
		)
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite
