//	小型枪械

/datum/supply_pack/company_import/crates/ballistics/intern_project/sidearm
	cost = PAYCHECK_COMMAND * 4
/*
/datum/supply_pack/company_import/crates/ballistics/intern_project/sidearm/sofap
	item_type = /obj/item/gun/ballistic/automatic/pistol/sofap
	//restricted = TRUE

/datum/supply_pack/company_import/crates/ballistics/intern_project/sidearm/tac9
	item_type = /obj/item/gun/ballistic/automatic/pistol/tac9
	access = FALSE
	access_view = FALSE

/datum/supply_pack/company_import/crates/ballistics/intern_project/sidearm/nt38
	item_type = /obj/item/gun/ballistic/automatic/pistol/c38
	access = FALSE
	access_view = FALSE
/datum/supply_pack/company_import/crates/ballistics/intern_project/sidearm/bfr500
	item_type = /obj/item/gun/ballistic/revolver/single
	cost = PAYCHECK_COMMAND * 6
	access = FALSE
	access_view = FALSE
*/
//	大型枪械
/datum/supply_pack/company_import/crates/ballistics/intern_project/primary
	cost = PAYCHECK_COMMAND * 6
/*
/datum/supply_pack/company_import/crates/ballistics/intern_project/primary/crossbow
	item_type = /obj/item/gun/ballistic/rifle/rebarxbow/crossbow
	access = FALSE
	access_view = FALSE

/datum/supply_pack/company_import/crates/ballistics/intern_project/primary/ostrza
	item_type = /obj/item/gun/ballistic/automatic/ostrza
	cost = PAYCHECK_COMMAND * 16

/datum/supply_pack/company_import/crates/ballistics/intern_project/primary/aa12
	item_type = /obj/item/gun/ballistic/shotgun/aa12
	cost = PAYCHECK_COMMAND * 16
	//restricted = TRUE

/datum/supply_pack/company_import/crates/ballistics/intern_project/primary/europa
	item_type = /obj/item/gun/ballistic/automatic/europa
	cost = PAYCHECK_COMMAND * 20
	//restricted = TRUE

/datum/supply_pack/company_import/crates/ballistics/intern_project/primary/solstice
	item_type = /obj/item/gun/ballistic/rifle/solstice
	cost = PAYCHECK_COMMAND * 16

/datum/supply_pack/company_import/crates/energy/intern_project/photon_sniper
	item_type = /obj/item/gun/energy/photon_sniper
	cost = PAYCHECK_COMMAND * 8
	//restricted = TRUE
*/
//	弹药
/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project
	cost = PAYCHECK_CREW

/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project/c20nuoli
	item_type = /obj/item/ammo_box/c20nuoli
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project/c20nuoli_smart
	item_type = /obj/item/ammo_box/c20nuoli/smart
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project/c20nuoli_breacher
	item_type = /obj/item/ammo_box/c20nuoli/breacher
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project/bolt
	item_type = /obj/item/ammo_casing/rebar/bolt

/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project/tac9
	item_type = /obj/item/ammo_box/magazine/tac9/starts_empty

/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project/nt38
	item_type = /obj/item/ammo_box/magazine/m38_pistol/starts_empty

/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project/bfr500
	item_type = /obj/item/ammo_box/speedloader/bfr500

/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project/aa12_mag
	item_type = /obj/item/ammo_box/magazine/aa12/starts_empty

/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project/aa12_drum
	item_type = /obj/item/ammo_box/magazine/aa12/drum/starts_empty
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/company_import/crates/mags_and_ammo/intern_project/europa_mag
	item_type = /obj/item/ammo_box/magazine/europa/starts_empty
	cost = PAYCHECK_CREW * 2

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
