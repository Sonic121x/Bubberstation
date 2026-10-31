/datum/supply_pack/goody/smg_single
	name = "瘫痪冲锋枪单件装"
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/goody/lasercarbine_single
	name = "激光卡宾枪单件装"
	desc = "内含一把激光卡宾枪，即激光枪的自动型号。适合需要快速连射、且只求致命效果的场合。"
	cost = PAYCHECK_COMMAND * 7
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser/carbine)

/datum/supply_pack/goody/wt550_single
	name = "WT-550 自动步枪单件装"
	desc = "一把军剩级自动步枪，散热出色，且不会给使用者带来任何健康风险。单件装内含一把已上膛的 WT-550。"
	cost = PAYCHECK_COMMAND * 8 //Nvm these are stronger than lasers in most scenarios so let's get them a bit of an edge. Plus gun price variety looks better
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/automatic/wt550)

/datum/supply_pack/goody/wt550_ammo
	name = "WT-550 自动步枪弹匣单件装"
	desc = "单件装弹匣，内装 WT-550 使用的致命普通弹药。"
	cost = PAYCHECK_CREW * 5 //Scale it like all guns
	contains = list(/obj/item/ammo_box/magazine/wt550m9 = 1)

/datum/supply_pack/goody/nt_shotgun
	name = "纳米传讯伍德斯托克霰弹枪"
	desc = "一把经典的霰弹枪，猎人、警察和拓荒者都在用，如今价格实惠。"
	cost = PAYCHECK_COMMAND * 12 //Worse renoster, let's make it a tad cheaper
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/shotgun/riot, /obj/item/storage/pouch/ammo, /obj/item/storage/belt/bandolier, /obj/item/ammo_box/advanced/s12gauge/hunter)

/datum/supply_pack/goody/renoster_shotgun
	name = "犀牛霰弹枪单件装"
	desc = "地球政府警察普遍装备的现代霰弹枪。"
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol, /obj/item/storage/pouch/ammo, /obj/item/storage/belt/bandolier, /obj/item/ammo_box/advanced/s12gauge/rubber)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 14 //I'd say it's at odds with the combat shotgun, sustain vs burst and such, but since ss13 favours burst I'll make it a tad cheaper.

/datum/supply_pack/goody/renoster_shotgun_lesslethal
	name = "Riot Renoster Shotgun Single-Pack"
	desc = "A common modern shotgun used by Terran Government Police, modified to only fire less-lethal rounds."
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol/lesslethal, /obj/item/storage/pouch/ammo, /obj/item/storage/belt/bandolier, /obj/item/ammo_box/advanced/s12gauge/rubber)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 8 //Even cheaper because its only less lethal

/datum/supply_pack/goody/double_barrel
	cost = PAYCHECK_COMMAND * 10 //1400 is too much considering the combat shotgun is 1500 for 1
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/plasma_marksman
	name = "恒星等离子精准射手单件装"
	desc = "内含一把恒星等离子精准射手步枪，以及一块不含额外电量的等离子电池。"
	contains = list(/obj/item/gun/ballistic/automatic/pistol/plasma_marksman = 1,
	/obj/item/ammo_box/magazine/recharge/plasma_battery = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/goody/plasma_marksman_ammo
	name = "等离子电池单件装"
	desc = "内含一块等离子电池。"
	contains = list(/obj/item/ammo_box/magazine/recharge/plasma_battery = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 1

/datum/supply_pack/goody/medkit_surgery
	name = "大容量外科医疗包"
	desc = "一个大容量医疗包，装满医疗用品和基础外科器械。"
	cost = PAYCHECK_CREW * 15
	contains = list(/obj/item/storage/medkit/surgery)

//For @unionheart
/datum/supply_pack/goody/security_maid
	name = "CnC 女仆特工套件"
	desc = "内含一套适用于战斗场合的装甲保洁装备。"
	cost = PAYCHECK_COMMAND * 4
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/clothing/under/rank/security/maid, /obj/item/clothing/suit/armor/vest/maid, /obj/item/clothing/head/security_maid, /obj/item/pushbroom)

/datum/supply_pack/goody/prescription_lenses
	name = "备用处方镜片"
	desc = "一个小工具箱，内装一副备用处方镜片。警告：易碎。"
	cost = PAYCHECK_COMMAND * 2 // glasses are expensive! woah-wee momma!
	contains = list(/obj/item/prescription_lenses)

/datum/supply_pack/goody/space_pet_snack
	name = "太空适应宠物零食"
	desc = "内含一份给你亲爱伙伴的零食，能让它变得适应太空环境。"
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/pet_food/pet_space_treat)

/datum/supply_pack/goody/rope_implant
	name = "攀爬钩植入体"
	desc = "一款特制的攀爬钩植入体，专为身高不足的人准备。"
	cost = PAYCHECK_CREW * 12
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/rope)

/datum/supply_pack/goody/offstation_deathrattle
	name = "站外临终警报套件"
	desc = "要远离空间站的舒适去冒险？不确定自己能不能完好无损地回来？卡赫拉曼重工与纳米传讯联合推出站外临终警报植入体！这枚连接你生命体征的小芯片会在你不幸早逝时自动发出求救信号。它只在空间站区域之外生效。因掉进坑洞或跳入熔岩、等离子体湖泊而死亡时，保修失效。"
	cost = PAYCHECK_COMMAND * 5
	contains = list(/obj/item/storage/box/offstation_deathrattle)

/datum/supply_pack/goody/ntusp_single
	name = "NT22-HCS“执法者”单件装"
	desc = "内含一个 NT22-HCS“执法者”手枪箱，这是一种发射硬光失能弹药的非致命武器。附两个能量弹匣。"
	cost = PAYCHECK_CREW * 12
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/ntusp)

/datum/supply_pack/goody/ntmp5_single
	name = "NT22-HCS-MP“枪骑兵”单件装"
	desc = "内含一把 NT22-HCS-MP“枪骑兵”冲锋枪，这是一种高速发射硬光失能弹药的非致命武器。配有可伸缩枪托。附两个能量弹匣。"
	cost = PAYCHECK_COMMAND * 8
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5)

/datum/supply_pack/goody/pepperball_gun
	name = "胡椒球枪单件装"
	desc = "内含一把胡椒球枪，一种发射装满胡椒的弹丸的非致命武器。"
	cost = PAYCHECK_CREW * 9
	access = ACCESS_SECURITY
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/pepperball)

/datum/supply_pack/goody/taser
	name = "电击枪单件装"
	desc = "内含一把混合电击枪，一种发射电击弹的非致命武器，并附带次级失能功能。"
	cost = PAYCHECK_CREW * 12
	access = ACCESS_SECURITY
	contains = list(/obj/item/gun/energy/e_gun/advtaser)

/datum/supply_pack/goody/shotgun_revolver
	name = "海狸 12 号口径左轮单件装"
	desc = "内含 1 把海狸左轮，采用 12 号口径。适合你就是想把霰弹枪的威力握在掌心的时候。附一盒豆袋弹。"
	contains = list(/obj/item/gun/ballistic/revolver/shotgun_revolver = 1,
	/obj/item/ammo_box/advanced/s12gauge/bean = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 20

/datum/supply_pack/goody/plasma_projector
	name = "烈日等离子喷射器单件装"
	desc = "内含一台烈日等离子喷射器。只要还有电，它就会从磁力枪管里喷出一道灼热却不太准的等离子流。"
	contains = list(/obj/item/gun/ballistic/automatic/pistol/plasma_thrower = 1,
	/obj/item/ammo_box/magazine/recharge/plasma_battery = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/goody/standard_mod_core
	name = "MOD 标准核心"
	desc = "所有 MOD 外骨骼的基础核心模块。提供必要的功能和兼容性。"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/standard)

/datum/supply_pack/goody/plasma_mod_core
	name = "MOD 等离子核心"
	desc = "纳米传讯试图把自家等离子研究变现的产物。这些等离子核心通过等离子燃料补充，让其采矿小队能持续轻松使用。"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/plasma)

/datum/supply_pack/goody/ethereal_mod_core
	name = "MOD 以太核心"
	desc = "经逆向工程得到的模块化外骨骼核心。它使用以太人与生俱来的液态电，无需借助外部能源来转换电荷。由于这类外骨骼本就靠液态电充能，此核心让整体效率大幅提升，运行所有软件、硬件和湿件时的能耗可降至几分之一。"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/ethereal)

/datum/supply_pack/goody/cosmohonk
	name = "MOD 宇宙洪克外壳"
	desc ="洪克有限公司出品的外骨骼。可抵御幽默感匮乏的环境。大部分技术都用在了降低能耗上。"
	cost = PAYCHECK_COMMAND * 2
	contains = list(/obj/item/mod/construction/plating/cosmohonk)
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/goody/magnetic_deployable
	name = "MOD 磁力展开模块"
	desc = "一套现代化得多的弹簧锁系统。这个模块利用磁铁加快 MOD 外骨骼的展开与收纳速度。与过时的弹簧锁模块不同，它受潮时不会出现与弹簧相关的意外问题。"
	cost = PAYCHECK_COMMAND * 5
	contains = list(/obj/item/mod/module/springlock/contractor)

/datum/supply_pack/goody/storage_large_capacity
	name = "MOD 扩容存储模块"
	desc = "为 MOD 外骨骼准备的大容量存储模块，可更高效地携带物品。"
	cost = PAYCHECK_COMMAND
	contains = list(/obj/item/mod/module/storage/large_capacity)

/datum/supply_pack/goody/crew_monitor
	name = "手持船员监控仪单件装"
	desc = "一台微型设备，可追踪全站的服装传感器信号。"
	cost = PAYCHECK_COMMAND * 4.5
	contains = list(/obj/item/sensor_device)

/datum/supply_pack/goody/soap
	name = "肥皂单件装"
	desc = "适用于紧急自我清洁、阴阳怪气的现场示范，或提醒别人卫生确实是工作的一部分。"
	cost = PAYCHECK_LOWER * 3
	contains = list(/obj/item/soap/deluxe)

/datum/supply_pack/goody/tacticool_laser
	name = "战术酷炫能量枪单件装"
	desc = "内含一把战术酷炫能量枪，满足你作为特工的一切需求。"
	cost = PAYCHECK_COMMAND * 6
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/e_gun/stun/tacticool)

/datum/supply_pack/goody/seclite_implant
	name = "安保手电筒植入体"
	desc = "内含一个安保手电筒植入体，用来照亮黑暗的维护隧道。"
	cost = PAYCHECK_CREW * 7
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/seclite)

/datum/supply_pack/goody/penfour_implant
	name = "指尖四色笔植入体"
	desc = "一支植入式四色笔，取代一根指尖。你还想要什么？"
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/penfour)

/datum/supply_pack/goody/tape_recorder_implant
	name = "通用录音机植入体"
	desc = "一个装在前臂内的录音装置，藏在一块隐蔽面板下。兼容标准抗电磁脉冲磁带。附备用磁带。"
	cost = PAYCHECK_CREW * 6
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/tape_recorder, /obj/item/tape/random)

/datum/supply_pack/goody/foamforce_implant
	name = "弹出式咚克软玩具枪植入体"
	desc = "咚克软的弹出式玩具枪用来烦同事再好不过。包装内含一个植入体和一小盒备用飞镖。"
	cost = PAYCHECK_CREW * 8
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/foamforce_implant, /obj/item/ammo_box/foambox/mini)

/datum/supply_pack/goody/defender_revolver
	name = "“防卫者”左轮单件装"
	desc = "内含一把“防卫者”左轮。价格便宜，偶尔会哑火。发射 .38 弹药。"
	cost = PAYCHECK_COMMAND * 3
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/revolver/defender_revolver)

/datum/supply_pack/goody/miecz
	name = "利剑冲锋枪单件装"
	desc = "内含一把利剑冲锋枪，是 PSC 最新推出的枪械之一。由于进口关税和整体稀缺，这东西可不便宜。另附两个弹匣。"
	cost = PAYCHECK_COMMAND * 10*1.25
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/automatic/miecz, /obj/item/ammo_box/magazine/miecz, /obj/item/ammo_box/magazine/miecz)

/datum/supply_pack/goody/mieczmag
	name = "利剑冲锋枪弹匣优惠包"
	desc = "内含一个利剑冲锋枪弹匣。"
	cost = PAYCHECK_COMMAND * 1.5
	contains = list(/obj/item/ammo_box/magazine/miecz)

/datum/supply_pack/goody/security_bow
	name = "硬光弓单件装"
	desc = "内含一把能击破护甲的硬光弓，以及一个装着失能箭的箭袋。想要致命箭矢就去找你的铁匠。"
	cost = PAYCHECK_COMMAND * 5
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/bow/security, /obj/item/storage/bag/quiver/lesser/security)

/datum/supply_pack/goody/russianammo
	name = ".310 弹药盒单件装"
	desc = "内含一包 .310 弹药。"
	cost = PAYCHECK_COMMAND * 2.5
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/ammo_box/c310_cargo_box)

/datum/supply_pack/goody/lancamag
	name = "骑枪弹匣单件装"
	desc = "内含一个骑枪步枪弹匣"
	cost = PAYCHECK_COMMAND * 1.5
	contains = list(/obj/item/ammo_box/magazine/lanca)
	order_flags = ORDER_CONTRABAND
