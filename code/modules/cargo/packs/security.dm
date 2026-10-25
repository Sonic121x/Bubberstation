/datum/supply_pack/security
	group = "Security"
	access = ACCESS_SECURITY
	crate_type = /obj/structure/closet/crate/secure/gear

/datum/supply_pack/security/ammo
	name = "弹药板条箱"
	desc = "内含三盒豆袋弹霰弹、三盒橡胶弹霰弹，\
		以及各一枚特制 .38 快速装弹器。"
	cost = CARGO_CRATE_VALUE * 8
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/beanbag = 3,
					/obj/item/storage/box/rubbershot = 3,
					/obj/item/ammo_box/speedloader/c38/trac,
					/obj/item/ammo_box/speedloader/c38/hotshot,
					/obj/item/ammo_box/speedloader/c38/iceblox,
				)
	crate_name = "弹药板条箱"

/datum/supply_pack/security/armor
	name = "护甲板条箱"
	desc = "三件防护全面、防护性尚可的护甲背心。"
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/clothing/suit/armor/vest = 3)
	crate_name = "护甲板条箱"

/datum/supply_pack/security/modsuit_plating
	name = "安保型 MOD 装甲板"
	desc = "一套安保型 MOD 外骨骼装甲板。"
	cost = CARGO_CRATE_VALUE
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/mod/construction/plating/security)
	crate_name = "MOD 装甲板板条箱"

/datum/supply_pack/security/disabler
	name = "瘫痪枪板条箱"
	desc = "三把消耗体力的瘫痪枪。"
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/gun/energy/disabler = 3)
	crate_name = "瘫痪枪板条箱"

/datum/supply_pack/security/forensics
	name = "法证板条箱"
	desc = "用纳米传讯的侦探必备套装™ 紧追罪犯不放。内含法证扫描仪、六个证物袋、\
		相机、专用证物板、录音机、粉笔，\
		当然还有一顶软呢帽。"
	cost = CARGO_CRATE_VALUE * 2.5
	access_view = ACCESS_MORGUE
	contains = list(/obj/item/detective_scanner,
					/obj/item/storage/box/evidence,
					/obj/item/camera,
					/obj/item/taperecorder,
					/obj/item/toy/crayon/white,
					/obj/item/clothing/head/fedora/det_hat,
					/obj/item/wallframe/detectiveboard
				)
	crate_name = "法证板条箱"

/datum/supply_pack/security/helmets
	name = "头盔板条箱"
	desc = "内含三顶标准配发的头盔。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/clothing/head/helmet/sec = 3)
	crate_name = "头盔板条箱"

/datum/supply_pack/security/securitybarriers
	name = "安保屏障手榴弹"
	desc = "用四枚安保屏障手榴弹挡住人潮。"
	access_view = ACCESS_BRIG
	contains = list(/obj/item/grenade/barrier = 4)
	cost = CARGO_CRATE_VALUE * 2
	crate_name = "安保屏障板条箱"

/datum/supply_pack/security/securityclothes
	name = "安保服装板条箱"
	desc = "内含适合空间站私人安保部队的服装。\
		包括典狱长、安保主管和两名安保官的服装。\
		每套服装都配有与其军衔相称的连体服、外套和贝雷帽。"
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/clothing/under/rank/security/officer/formal = 2,
					/obj/item/clothing/suit/jacket/officer/blue = 2,
					/obj/item/clothing/head/beret/sec/navyofficer = 2,
					/obj/item/clothing/under/rank/security/warden/formal,
					/obj/item/clothing/suit/jacket/warden/blue,
					/obj/item/clothing/head/beret/sec/navywarden,
					/obj/item/clothing/under/rank/security/head_of_security/formal,
					/obj/item/clothing/suit/jacket/hos/blue,
					/obj/item/clothing/head/hats/hos/beret/navyhos,
				)
	crate_name = "安保服装板条箱"

/datum/supply_pack/security/stingpack
	name = "刺痛弹包"
	desc = "内含五枚“刺痛弹”，非常适合制止暴乱，\
		以及进行道德上难以想象的恶作剧。"
	cost = CARGO_CRATE_VALUE * 5
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/stingbangs)
	crate_name = "刺痛弹包板条箱"

/datum/supply_pack/security/supplies
	name = "安保补给板条箱"
	desc = "内含七枚闪光弹、七枚催泪瓦斯手榴弹、六支闪光棒和七副手铐。"
	cost = CARGO_CRATE_VALUE * 3.5
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/flashbangs,
					/obj/item/storage/box/teargas,
					/obj/item/storage/box/flashes,
					/obj/item/storage/box/handcuffs,
				)
	crate_name = "安保补给板条箱"

/datum/supply_pack/security/maintenance_kits
	name = "枪械保养套件"
	desc = "三套用于修理和保养枪械的枪械保养套件。"
	access_view = ACCESS_BRIG
	contains = list(/obj/item/gun_maintenance_supplies = 3)
	cost = CARGO_CRATE_VALUE * 2
	crate_name = "枪械保养套件板条箱"

/datum/supply_pack/security/firingpins
	name = "标准击发撞针板条箱"
	desc = "用十枚标准击发撞针升级你的武库。"
	cost = CARGO_CRATE_VALUE * 4
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/firingpins = 2)
	crate_name = "击发撞针板条箱"

/datum/supply_pack/security/firingpins/paywall
	name = "付费墙击发撞针板条箱"
	desc = "内置可配置付费墙的专用击发撞针。"
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/firingpins/paywall = 2)
	crate_name = "付费墙击发撞针板条箱"

/datum/supply_pack/security/justiceinbound
	name = "标准正义执法者板条箱"
	desc = "就是它。无与伦比。出类拔萃。百里挑一。\
		精英中的精英中的精英。纳米传讯的皇冠明珠。\
		安保头饰的阿尔法与欧米伽。保证能让空间站上每一名罪犯心生恐惧。\
		另附一具安保防毒面具。"
	cost = CARGO_CRATE_VALUE * 6 //justice comes at a price. An expensive, noisy price.
	order_flags = ORDER_CONTRABAND
	contains = list(/obj/item/clothing/head/helmet/toggleable/justice,
					/obj/item/clothing/mask/gas/sechailer,
				)
	crate_name = "安保服装板条箱"
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/security/baton
	name = "电击棍板条箱"
	desc = "用三根电击棍武装公民保护部队。含电池。"
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded = 3)
	crate_name = "电击棍板条箱"

/datum/supply_pack/security/wall_flash
	name = "壁挂式闪光灯板条箱"
	desc = "内含四支壁挂式闪光灯。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/storage/box/wall_flash = 4)
	crate_name = "壁挂式闪光灯板条箱"

/datum/supply_pack/security/constable
	name = "传统装备板条箱"
	desc = "在仓库里找到的备用装备。内含一套巡警制服、\
		一只哨子和一套改装套件。"
	cost = CARGO_CRATE_VALUE * 2.2
	order_flags = ORDER_CONTRABAND
	contains = list(/obj/item/clothing/under/rank/security/constable,
					/obj/item/clothing/head/costume/constable,
					/obj/item/clothing/gloves/color/white,
					/obj/item/clothing/mask/whistle,
					/obj/item/conversion_kit,
				)
	crate_name = "传统装备板条箱"
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/// Armory packs

/datum/supply_pack/security/armory
	group = "Armory"
	access = ACCESS_ARMORY
	access_view = ACCESS_ARMORY
	crate_type = /obj/structure/closet/crate/secure/weapon

/datum/supply_pack/security/armory/bulletarmor
	name = "防弹护甲板条箱"
	desc = "内含三套防弹护甲。\
		保证将子弹的停止作用削减一半以上。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/clothing/suit/armor/bulletproof = 3)
	crate_name = "防弹护甲板条箱"

/datum/supply_pack/security/armory/bullethelmets
	name = "防弹头盔板条箱"
	desc = "内含三顶防弹头盔。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/clothing/head/helmet/alt = 3)
	crate_name = "防弹头盔板条箱"

/datum/supply_pack/security/armory/chemimp
	name = "化学植入体板条箱"
	desc = "内含五个远程化学植入体。"
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(/obj/item/storage/box/chemimp)
	crate_name = "化学植入体板条箱"

/datum/supply_pack/security/armory/ballistic
	name = "战斗霰弹枪板条箱"
	desc = "适用于必须以铅弹彻底替换敌人的场合。\
		内含三把奥斯克设计的战斗霰弹枪，以及三条霰弹枪弹药带。"
	cost = CARGO_CRATE_VALUE * 17.5
	contains = list(/obj/item/gun/ballistic/shotgun/automatic/combat = 3,
					/obj/item/storage/belt/bandolier = 3)
	crate_name = "战斗霰弹枪板条箱"

/datum/supply_pack/security/armory/dragnet
	name = "DRAGnet 传送霰弹枪板条箱"
	desc = "内含两把“有罪者动态快速抓捕网络”传送霰弹枪，\
		这是执法部门囚犯管理技术的最新突破。附赠一枚 DRAGnet 信标。"
	cost = CARGO_CRATE_VALUE * 18
	contains = list(
		/obj/item/gun/energy/e_gun/dragnet = 2,
		/obj/item/dragnet_beacon = 1
	)
	crate_name = "\improper DRAGnet 板条箱"

/datum/supply_pack/security/armory/energy
	name = "能量枪板条箱"
	desc = "内含三把能量枪，\
		可发射非致命与致命的光束。"
	cost = CARGO_CRATE_VALUE * 18
	contains = list(/obj/item/gun/energy/e_gun = 3)
	crate_name = "能量枪板条箱"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/security/armory/laser
	name = "5 型激光枪板条箱"
	desc = "内含三把由纳米传讯研发的 5 型激光枪。当形势变得艰难时，\
		就用 5 型热能投送系统迎难而上。同样由纳米传讯研发。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/gun/energy/laser = 3)
	crate_name = "\improper 5 型激光枪板条箱"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/security/armory/laser_carbine
	name = "5/R 型激光卡宾枪板条箱"
	desc = "内含三把由纳米传讯研发的 5R 型激光卡宾枪。可快速连发威力略弱的激光弹。"
	cost = CARGO_CRATE_VALUE * 9
	contains = list(/obj/item/gun/energy/laser/carbine = 3)
	crate_name = "\improper 5R 型激光卡宾枪板条箱"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/security/armory/disabler_smg
	name = "瘫痪冲锋枪板条箱"
	desc = "内含三把瘫痪冲锋枪，可快速发射较弱的瘫痪光束。"
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/item/gun/energy/disabler/smg = 3)
	crate_name = "瘫痪冲锋枪板条箱"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/security/armory/battle_rifle
	name = "NT BR-38 板条箱"
	desc = "由纳米传讯研发的实验型能量式弹道战斗步枪。\
		仅供纳米传讯旗下的空间站用于安保目的。\
		严禁转售给外部公司。内含三把 NT BR-38 步枪和六个装填 .38 标准弹的弹匣。"
	cost = CARGO_CRATE_VALUE * 100
	contains = list(
		/obj/item/gun/ballistic/automatic/battle_rifle = 3,
		/obj/item/ammo_box/magazine/m38 = 6,
	)
	crate_name = "战斗步枪板条箱"

/datum/supply_pack/security/armory/br_mag
	name = "NT BR-38 弹匣板条箱"
	desc = "六个 .38 弹匣，可装入 NT BR-38。\
		内含两个标准弹匣、两个热射弹匣和两个冰封弹匣。"
	cost = CARGO_CRATE_VALUE * 7
	contains = list(
		/obj/item/ammo_box/magazine/m38 = 2,
		/obj/item/ammo_box/magazine/m38/hotshot = 2,
		/obj/item/ammo_box/magazine/m38/iceblox =2,
	)
	crate_name = ".38 弹匣板条箱"

/datum/supply_pack/security/armory/exileimp
	name = "放逐植入体板条箱"
	desc = "内含五个放逐植入体。"
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(/obj/item/storage/box/exileimp)
	crate_name = "放逐植入体板条箱"

/datum/supply_pack/security/armory/fire
	name = "燃烧武器板条箱"
	desc = "烧吧，尽情地烧。\
		内含三枚燃烧手榴弹、三个等离子气罐和一把火焰喷射器。"
	cost = CARGO_CRATE_VALUE * 7
	access = ACCESS_COMMAND
	contains = list(/obj/item/flamethrower/full,
					/obj/item/tank/internals/plasma = 3,
					/obj/item/grenade/chem_grenade/incendiary = 3,
				)
	crate_name = "燃烧武器板条箱"
	crate_type = /obj/structure/closet/crate/secure/plasma
	order_flags = ORDER_DANGEROUS

/datum/supply_pack/security/armory/mindshield
	name = "心智护盾植入体板条箱"
	desc = "用三个心智护盾植入体防范激进思想。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/storage/lockbox/loyalty)
	crate_name = "心智护盾植入体板条箱"

/datum/supply_pack/security/armory/trackingimp
	name = "追踪植入体板条箱"
	desc = "内含四个追踪植入体和三个装填追踪 .38 弹药的追踪快速装弹器。"
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(/obj/item/storage/box/trackimp,
					/obj/item/ammo_box/speedloader/c38/trac = 3,
				)
	crate_name = "追踪植入体板条箱"

/datum/supply_pack/security/armory/laserarmor
	name = "反射护甲背心板条箱"
	desc = "内含两件高反射材料制成的背心。\
		每件护甲都能将激光能量扩散一半以上，\
		还有很高几率将激光完全反射。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/clothing/suit/armor/laserproof = 2)
	crate_name = "反射背心板条箱"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/security/armory/riotarmor
	name = "防暴护甲板条箱"
	desc = "内含三套重型护甲。\
		先进的衬垫可抵御近程武器，\
		让近战攻击对使用者而言威力只有一半。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/clothing/suit/armor/riot = 3)
	crate_name = "防暴护甲板条箱"

/datum/supply_pack/security/armory/riothelmets
	name = "防暴头盔板条箱"
	desc = "内含三顶防暴头盔。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/clothing/head/helmet/toggleable/riot = 3)
	crate_name = "防暴头盔板条箱"

/datum/supply_pack/security/armory/riotshields
	name = "防暴盾牌板条箱"
	desc = "适用于灰潮暴民格外嚣张的时候。内含三面防暴盾牌。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/shield/riot = 3)
	crate_name = "防暴盾牌板条箱"

/datum/supply_pack/security/armory/swat
	name = "特警板条箱"
	desc = "内含两套由 IS-ERI 与纳米传讯联合设计的坚固防火全身服。\
		每套包含外套、头盔、面罩、战斗腰带、\
		和猩猩手套。"
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/item/clothing/head/helmet/swat/nanotrasen = 2,
					/obj/item/clothing/suit/armor/swat = 2,
					/obj/item/clothing/mask/gas/sechailer/swat = 2,
					/obj/item/storage/belt/military/assault = 2,
					/obj/item/clothing/gloves/tackler/combat = 2,
				)
	crate_name = "特警板条箱"

/datum/supply_pack/security/armory/thermal
	name = "热能手枪板条箱"
	desc = "内含一对枪套，每个枪套各配两把实验型热能手枪，\
		以纳米机器人作为弹药基础。摇晃即可重新装填。"
	cost = CARGO_CRATE_VALUE * 10
	contains = list(/obj/item/storage/belt/holster/energy/thermal = 2)
	crate_name = "热能手枪板条箱"

/datum/supply_pack/security/sunglasses
	name = "墨镜板条箱"
	desc = "一副防闪光墨镜。"
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/clothing/glasses/sunglasses = 1)
	crate_name = "墨镜板条箱"

/datum/supply_pack/security/armory/mechthermal
	name = "重型热能炮板条箱"
	desc = "内含两门供机甲使用的实验型热能炮。\
		同时使用时，其过剩功率会用于加热与冷却另一门武器，\
		从而提高装填速度。"
	cost = CARGO_CRATE_VALUE * 25
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/thermal/cryo,
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/thermal/inferno,
	)
	crate_name = "热能炮板条箱"

/datum/supply_pack/security/blood_worm_testers
	name = "血寄生虫检测板条箱"
	desc = "内含四个一次性血寄生虫检测工具。\
		这些设备可准确报告患者体内是否寄宿着血寄生虫，例如臭名昭著的太空血虫。\
		德福雷斯特医疗公司对因不当使用这些设备而对患者造成的任何精神及/或身体创伤概不负责。"
	cost = CARGO_CRATE_VALUE * 50 // These aren't meant to be bought en-masse.
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/blood_worm_tester = 4)
	crate_name = "血寄生虫检测板条箱"
