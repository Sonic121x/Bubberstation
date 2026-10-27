//Cargo
/datum/export/weapon/sec_glock
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/sec_glock)
	cost = CARGO_CRATE_VALUE * 1.25
	unit_name = "“墨菲”勤务手枪"

/datum/supply_pack/security/armory/sec_glock
	name = "“墨菲”勤务手枪板条箱"
	desc = "内含三把已装填致命弹药的“墨菲”勤务手枪。额外弹药另行出售。纳米传讯提醒您：其他武器是给朋友用的，不是用来双持扫射的。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sec_glock = 3)
	crate_name = "“墨菲”勤务手枪板条箱"
	access_view = ACCESS_WEAPONS

/datum/supply_pack/security/armory/sec_glock_ammo
	name = "“墨菲”勤务手枪弹药板条箱"
	desc = "内含 4 个装填致命弹药的“墨菲”勤务手枪弹匣。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/ammo_box/magazine/security = 4)
	crate_name = "“墨菲”勤务手枪弹药板条箱"
	access_view = ACCESS_WEAPONS

/datum/supply_pack/security/armory/alert_level_firing_pin
	name = "警报等级击针板条箱"
	desc = "内含四个特殊击针，仅允许在蓝色警报或更高等级时开火。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/firing_pin/alert_level = 4)
	crate_name = "警报等级击针板条箱"
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/murphy_single
	name = "“墨菲”勤务手枪单件装"
	desc = "一把坚固的执法级勤务手枪，曾以只卖一美元而闻名。单件装内含一把随时可用的“墨菲”手枪。"
	cost = PAYCHECK_COMMAND * 5
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sec_glock = 1)
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/murphy_ammo
	name = "“墨菲”勤务手枪弹匣单件装"
	desc = "装满弹药的弹匣，配有格外坚固的退壳弹簧。适用于墨菲勤务手枪。"
	cost = PAYCHECK_COMMAND * 2
	contains = list(/obj/item/ammo_box/magazine/security = 1)
	access_view = ACCESS_WEAPONS

/datum/supply_pack/security/armory/protector_revolver
	name = "“保护者”勤务左轮手枪板条箱"
	desc = "内含三把已装填致命弹药的“保护者”勤务左轮手枪。额外弹药另行出售。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/gun/ballistic/revolver/protector_revolver = 3)
	crate_name = "“保护者”勤务左轮手枪板条箱"
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/protector_revolver_single
	name = "“保护者”勤务左轮手枪单件装"
	desc = "一把“保护者”左轮手枪。使用“墨菲”弹药，弹药另行出售"
	cost = PAYCHECK_COMMAND * 6
	contains = list(/obj/item/gun/ballistic/revolver/protector_revolver = 1)
	access_view = ACCESS_WEAPONS
