//	小型枪械
/datum/supply_pack/company_import/crates/ballistics/intern_project/sidearm
	cost = PAYCHECK_COMMAND * 4

//	大型枪械
/datum/supply_pack/company_import/crates/ballistics/intern_project/primary
	cost = PAYCHECK_COMMAND * 6

//	弹药
/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project
	cost = PAYCHECK_CREW

//	医疗用品
/datum/supply_pack/company_import/crates/medical/intern_project
	cost = PAYCHECK_CREW

/datum/supply_pack/company_import/crates/medical/intern_project/beacon
	item_type = /obj/item/deployable_healer
	cost = PAYCHECK_CREW * 20

/datum/supply_pack/company_import/crates/medical/intern_project/paramedic_jaws_kit
	item_type = /obj/item/crafting_conversion_kit/paramedic_jaws
	cost = PAYCHECK_CREW

//  模块
/datum/supply_pack/company_import/crates/modsuits/mods/intern_project
	cost = PAYCHECK_CREW

/datum/supply_pack/company_import/crates/modsuits/mods/intern_project/popcorndispenser
	item_type = /obj/item/mod/module/dispenser/popcorn
	cost = PAYCHECK_CREW * 5
// BUBBER EDIT START - Company import crate catalog
/datum/supply_pack/company_import/crates
	subcategory = "Crates"
// BUBBER EDIT END


/datum/supply_pack/company_import/crates/general/donk/liverpocket
	item_type = /obj/item/storage/box/donkpockets/donkpocketliver
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/company_import/crates/general/donk/ratpocket
	item_type = /obj/item/storage/box/donkpockets/donkpocketrat
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/company_import/crates/general/donk/slimepocket
	item_type = /obj/item/storage/box/donkpockets/donkpocketslime
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/company_import/crates/general/donk/mimepocket
	item_type = /obj/item/storage/box/donkpockets/donkpocketmime
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/company_import/crates/general/donk/caramel_medipen
	item_type = /obj/item/storage/box/caramel_medipen
	cost = PAYCHECK_CREW * 2

//	载具
/datum/supply_pack/service/sedan
	name = "轿车套件"
	desc = "一辆属于你自己的汽车，驶向太空！驶向新生活！"
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/vehicle/sealed/car/sedan = 1,
		/obj/item/key/car = 1,
	)
	crate_name = "轿车套件"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/service/car_key
	name = "备用车钥匙"
	desc = "如果你弄丢了你的车钥匙，你可以买一个新的，保证和原来的一模一样！但是，请不要用它来启动不属于你自己的车，可以吗？"
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/key/car)

//	杂项
/datum/supply_pack/company_import/crates/apparel/intern_project/pouch
	//subcategory = "杂项"
	cost = PAYCHECK_CREW * 6

/datum/supply_pack/company_import/crates/apparel/intern_project/pouch/generic_pouch
	item_type = /obj/item/storage/pouch/generic_pouch

/datum/supply_pack/company_import/crates/apparel/intern_project/pouch/expanded_pouch
	item_type = /obj/item/storage/pouch/expanded_pouch
	cost = PAYCHECK_CREW * 6 * 1.5

/datum/supply_pack/company_import/crates/apparel/intern_project/pouch/carrying_pouch
	item_type = /obj/item/storage/pouch/carrying_pouch
	cost = PAYCHECK_CREW * 6 * 1.5

/datum/supply_pack/company_import/crates/apparel/intern_project/pouch/plush_ghastling
	item_type = /obj/item/toy/plush/ghastling
	cost = PAYCHECK_CREW * 4
