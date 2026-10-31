/datum/supply_pack/security/armory/wt550
	name = "WT-550 自动步枪箱"
	desc = "内含三把已预装弹药的 WT-550 自动步枪。额外弹药另售。"
	cost = CARGO_CRATE_VALUE * 10
	contains = list(/obj/item/gun/ballistic/automatic/wt550 = 3)
	crate_name = "WT-550 自动步枪箱"

/datum/supply_pack/security/armory/wt550_ammo_regular
	name = "WT-550 自动步枪弹药箱（普通）"
	desc = "内含 4 个装填致命普通弹药的 WT-550 弹匣。"
	cost = CARGO_CRATE_VALUE * 4 //these are printable, price can be lowered safely to 800ish
	contains = list(/obj/item/ammo_box/magazine/wt550m9 = 4)
	crate_name = "WT-550 弹匣箱（普通）"

/datum/supply_pack/security/ammo
	contains = list(/obj/item/ammo_box/advanced/s12gauge/bean = 3,
					/obj/item/ammo_box/advanced/s12gauge/rubber = 3,
					/obj/item/ammo_box/speedloader/c38/trac,
					/obj/item/ammo_box/speedloader/c38/hotshot,
					/obj/item/ammo_box/speedloader/c38/iceblox,
				)
//This makes the Security ammo crate use the cool advanced ammo boxes instead of the old ones

/datum/supply_pack/security/secmed_technician
	name = "安保医疗包箱——技术员型"
	crate_name = "安保医疗箱"
	desc = "内含一套医疗技术员套装。"
	access = ACCESS_SECURITY
	cost = CARGO_CRATE_VALUE * 7.125
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked,
	)

/datum/supply_pack/security/secmed_surgical
	name = "安保医疗包箱——外科型"
	crate_name = "安保医疗箱"
	desc = "内含一套急救外科套装。"
	access = ACCESS_SECURITY
	cost = CARGO_CRATE_VALUE * 3.9
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked,
	)

/datum/supply_pack/security/secmed_medical
	name = "安保医疗包箱——医疗型"
	crate_name = "安保医疗箱"
	desc = "内含一个大型医疗挎包。"
	access = ACCESS_SECURITY
	cost = CARGO_CRATE_VALUE * 7.125
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked,
	)

	cost = CARGO_CRATE_VALUE * 10
	access = ACCESS_SECURITY

/datum/supply_pack/security/armory/swat
	desc = "内含两套坚韧、防火的全身套装，由 IS-ERI 与纳米传讯联合\
		设计。每套都包含外衣、头盔、面具、战斗腰带、一把胡椒球枪，\
		以及大猩猩手套。"

/datum/supply_pack/security/armory/swat/New()
	. = ..()
	contains += list(/obj/item/storage/toolbox/guncase/skyrat/pistol/pepperball = 2)

/datum/supply_pack/security/armory/mechthermal
	access = FALSE
	access_any = list(ACCESS_SECURITY, ACCESS_ROBOTICS)
	access_view = FALSE

/datum/supply_pack/security/pepperballguns
	name = "胡椒球枪箱"
	desc = "内含三把胡椒球枪，一种发射装满胡椒的弹丸的非致命武器。"
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/pepperball = 3)
	access = ACCESS_SECURITY

/datum/supply_pack/security/Tasers
	name = "电击枪箱"
	desc = "内含三把混合电击枪，一种发射电击弹的非致命武器，并附带次级失能功能。"
	cost = CARGO_CRATE_VALUE * 5.5
	contains = list(/obj/item/gun/energy/e_gun/advtaser = 3)
	access = ACCESS_SECURITY

/datum/supply_pack/security/laser
	cost = CARGO_CRATE_VALUE * 7

/datum/supply_pack/security/armory/energy
	desc = "内含三把能量枪，既能发射非致命的光弹，也能发射致命\
		光弹。"
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/item/gun/energy/e_gun = 3)

/datum/supply_pack/security/armory/laser_carbine
	cost = CARGO_CRATE_VALUE * 7

/datum/supply_pack/security/combine
	name = "民事保护制服"
	desc = "我们从某个穿蓝西装的怪老头那里弄来的额外补给。内含六套制服、\
		背心、靴子、手套和头盔。"
	cost = 1116
	order_flags = ORDER_CONTRABAND
	contains = list(/obj/item/clothing/head/helmet/metrocophelmet = 6,
		/obj/item/clothing/suit/armor/vest/alt/sec/metrocop = 6,
		/obj/item/clothing/under/rank/security/metrocop = 6,
		/obj/item/clothing/gloves/color/black/security/metrocop = 6,
		/obj/item/clothing/shoes/jackboots/combine = 6,
		/obj/item/trash/can = 3,
			)
	crate_name = "赞助人补给箱"
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/security/ntusp
	name = "NT22-HCS 箱"
	desc = "三个 NT22-HCS“执法者”手枪箱，每箱内含一把武器和一个能量包。"
	cost = CARGO_CRATE_VALUE * 5.5
	access = ACCESS_SECURITY
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/ntusp,
					/obj/item/storage/toolbox/guncase/skyrat/pistol/ntusp,
					/obj/item/storage/toolbox/guncase/skyrat/pistol/ntusp)
	crate_name = "NT22-HCS 箱"

/datum/supply_pack/security/ntmp5
	name = "NT22-HCS-MP 箱"
	desc = "三个 NT22-HCS-MP“枪骑兵”冲锋枪箱，每箱内含一把武器和一个能量包。每把枪都可收起枪托，以便放进背包。"
	cost = CARGO_CRATE_VALUE * 6.5
	access = ACCESS_SECURITY
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5,
					/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5,
					/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5)
	crate_name = "NT22-HCS-MP 箱"

/datum/supply_pack/security/miecz
	name = "利剑冲锋枪箱"
	crate_name = "利剑冲锋枪箱"
	desc = "内含两把利剑冲锋枪，各附一个备用弹匣。"
	contains = list(/obj/item/gun/ballistic/automatic/miecz = 2,
	/obj/item/ammo_box/magazine/miecz = 2)
	cost = CARGO_CRATE_VALUE * 10
	access = ACCESS_SECURITY

/datum/supply_pack/security/mieczammo
	name = "利剑冲锋枪弹药箱"
	crate_name = "利剑冲锋枪弹药箱"
	desc = "内含 4 个利剑冲锋枪弹匣。"
	contains = list(/obj/item/ammo_box/magazine/miecz = 4)
	cost = CARGO_CRATE_VALUE * 4
	access = ACCESS_SECURITY

/datum/supply_pack/security/armory/archery_kit
	name = "射箭箱"
	desc = "两把能击破护甲的硬光弓，以及一批致命、非致命和低致命性箭矢。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/obj/item/gun/ballistic/bow/security,
		/obj/item/gun/ballistic/bow/security,
		/obj/item/storage/bag/quiver/lesser/security/armory,
		/obj/item/storage/bag/quiver/lesser/security/armory,
	)

/obj/item/storage/bag/quiver/lesser/security/armory

/obj/item/storage/bag/quiver/lesser/security/armory/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_casing/arrow/blunt = 3,
		/obj/item/ammo_casing/arrow = 6,
		/obj/item/ammo_casing/arrow/taser = 1
	)

	generate_items_inside(items_inside, src)

/datum/supply_pack/security/armory/lethal_arrows
	name = "箭矢箱"
	desc = "两个箭袋，各装九支普通箭和一支随机选定的特种箭。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/storage/bag/quiver/lesser/security/lethal,
		/obj/item/storage/bag/quiver/lesser/security/lethal
	)

/obj/item/storage/bag/quiver/lesser/security/lethal

/obj/item/storage/bag/quiver/lesser/security/lethal/PopulateContents()
	var/static/list/static_items = list(
		/obj/item/ammo_casing/arrow = 9
	)
	/// Typepath -> Weight
	var/static/list/bonus_items = list(
		/obj/item/ammo_casing/arrow/sticky = 10,
		/obj/item/ammo_casing/arrow/poison = 10,
		/obj/item/ammo_casing/arrow/plastic = 6,
		/obj/item/ammo_casing/arrow/bronze = 1,
		/obj/item/ammo_casing/arrow/taser = 1,
	)

	var/list/obj/item/ammo_casing/arrow/to_spawn = static_items.Copy()
	to_spawn[pick_weight(bonus_items)] = 1

	generate_items_inside(to_spawn, src)

/datum/supply_pack/security/armory/tacticool_laser_crate
	name = "战术酷炫能量枪箱"
	desc = "三把战术酷炫能量枪，让你在那些千篇一律的能量枪用户中彰显个性！"
	cost = CARGO_CRATE_VALUE * 8
	contains = list(
		/obj/item/gun/energy/e_gun/stun/tacticool = 3,
	)

/datum/supply_pack/security/armory/peacekeepers
	name = "犀牛霰弹枪箱"
	desc = "三把犀牛泵动霰弹枪，用来补充你的军械库。"
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/gun/ballistic/shotgun/riot/sol,
		/obj/item/gun/ballistic/shotgun/riot/sol,
		/obj/item/gun/ballistic/shotgun/riot/sol,
	)

/datum/supply_pack/security/armory/peacekeepers_plus
	name = "Riot Renoster Shotgun Crate"
	desc = "Three less-lethal modified Renoster pump-action shotguns to restock your armories with."
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/gun/ballistic/shotgun/riot/sol/lesslethal,
		/obj/item/gun/ballistic/shotgun/riot/sol/lesslethal,
		/obj/item/gun/ballistic/shotgun/riot/sol/lesslethal,
	)

/datum/supply_pack/security/armory/hoshis
	name = "星辰模块化激光卡宾枪箱"
	desc = "本箱内含 3 把地球军械库最新添置的装备，由……“赛巴萨”制造。这些模块化武器可切换多种射击模式，并搭载机载 AI。"
	cost = CARGO_CRATE_VALUE * 20
	contains = list(
		/obj/item/gun/energy/modular_laser_rifle/carbine,
		/obj/item/gun/energy/modular_laser_rifle/carbine,
		/obj/item/gun/energy/modular_laser_rifle/carbine,
	)

/datum/supply_pack/security/armory/stingballer
	name = "震爆弹步枪箱"
	crate_name = "震爆弹步枪箱"
	desc = "一支专为快速发射震爆弹丸而设计的原型步枪。出厂已装填，额外弹药另售。"
	cost = CARGO_CRATE_VALUE * 22.5
	contains = list(
		/obj/item/gun/ballistic/rifle/stingballer,
	)

/datum/supply_pack/security/armory/kiboko
	name = "河马榴弹发射器箱"
	crate_name = "河马榴弹发射器箱"
	desc = "一支全新、已装填的河马榴弹发射器，专为你准备，以防你不知怎么把配发的那支弄丢了。"
	cost = CARGO_CRATE_VALUE * 37.5
	contains = list(
		/obj/item/gun/ballistic/automatic/sol_grenade_launcher
	)

/datum/supply_pack/security/armory/grenadelauncher
	name = "气动榴弹发射器箱"
	crate_name = "榴弹发射器箱"
	desc = "一件真正邪恶的武器，可快速投放任何标准榴弹。附赠一盒闪光弹。"
	cost = CARGO_CRATE_VALUE * 75
	contains = list(
		/obj/item/gun/grenadelauncher,
		/obj/item/storage/box/flashbangs,
	)
