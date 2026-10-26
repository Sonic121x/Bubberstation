/datum/uplink_category/spy_unique
	name = "间谍专属"

// This is solely for uplink items that the spy can randomly obtain via bounties.
/datum/uplink_item/spy_unique
	category = /datum/uplink_category/spy_unique
	cant_discount = TRUE
	surplus = FALSE
	purchasable_from = UPLINK_SPY
	// Cost doesn't really matter since it's free, but it determines which loot pool it falls into.
	// By default, these fall into easy-medium spy bounty loot pool
	cost = SPY_LOWER_COST_THRESHOLD
	uplink_item_flags = NONE

/datum/uplink_item/spy_unique/syndie_bowman
	name = "辛迪加弓形耳机"
	desc = "一款供辛迪加成员使用的弓形耳机。并不算太显眼。"
	item = /obj/item/radio/headset/syndicate/alt
	cost = 1
	uplink_item_flags = SYNDIE_ILLEGAL_TECH

/datum/uplink_item/spy_unique/megaphone
	name = "扩音器"
	desc = "一台扩音器。很吵。"
	item = /obj/item/megaphone
	cost = 1

/datum/uplink_item/spy_unique/combat_gloves
	name = "战斗手套"
	desc = "一副战斗手套。是绝缘的！"
	item = /obj/item/clothing/gloves/combat
	cost = 1

/datum/uplink_item/spy_unique/kaza_ruk
	name = "强化战斗手套"
	desc = "一副强化战斗手套。不仅绝缘，还能让你施展武术！"
	item = /obj/item/clothing/gloves/kaza_ruk/combatglovesplus

/datum/uplink_item/spy_unique/tackle_gloves
	name = "游击队手套"
	desc = "一副游击队手套。不仅绝缘，还能让你擒抱摔倒别人！"
	item = /obj/item/clothing/gloves/tackler/combat/insulated

/datum/uplink_item/spy_unique/kudzu
	name = "葛藤"
	desc = "一包葛藤——种下去就不用管，极好的干扰手段。"
	item = /obj/item/seeds/kudzu
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/spy_unique/big_knife
	name = "战斗刀"
	desc = "一把大刀子。很锋利。"
	item = /obj/item/knife/combat

/datum/uplink_item/spy_unique/switchblade
	name = "弹簧刀"
	desc = "一把弹簧刀。在不锋利和锋利之间切换。"
	item = /obj/item/switchblade
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/spy_unique/sechud_implant
	name = "安保 HUD 植入体"
	desc = "一个安保 HUD 植入体。能显示你正在看的人的身份证信息。而且很隐蔽！"
	item = /obj/item/autosurgeon/syndicate/contraband_sechud

/datum/uplink_item/spy_unique/rifle_prime
	name = "栓动步枪"
	desc = "一把带瞄准镜的栓动步枪。而且不会卡壳。"
	item = /obj/item/gun/ballistic/rifle/boltaction/prime
	cost = SPY_UPPER_COST_THRESHOLD
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/spy_unique/cycler_shotgun
	name = "循环霰弹枪"
	desc = "一把循环霰弹枪。就是能在两根枪管之间循环的霰弹枪。"
	item = /obj/item/gun/ballistic/shotgun/automatic/dual_tube/deadly
	cost = SPY_UPPER_COST_THRESHOLD
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND
	relevant_child_items = list(
		/datum/uplink_item/spy_unique/shotgun_ammo,
		/datum/uplink_item/spy_unique/shotgun_ammo/breacher_slug,
		/datum/uplink_item/spy_unique/shotgun_ammo/slugs,
	)

/datum/uplink_item/spy_unique/bulldog_shotgun
	name = "斗牛犬霰弹枪"
	desc = "一把斗牛犬霰弹枪。就是能射出斗牛犬的霰弹枪。"
	item = /obj/item/gun/ballistic/shotgun/bulldog/unrestricted
	cost = SPY_UPPER_COST_THRESHOLD
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/basic/buck,
		/datum/uplink_item/ammo_nuclear/basic/donk,
		/datum/uplink_item/ammo_nuclear/basic/flechette,
		/datum/uplink_item/ammo_nuclear/basic/slug,
		/datum/uplink_item/ammo_nuclear/incendiary/dragon,
		/datum/uplink_item/ammo_nuclear/special/meteor,
		/datum/uplink_item/spy_unique/shotgun_ammo,
		/datum/uplink_item/spy_unique/shotgun_ammo/breacher_slug,
		/datum/uplink_item/spy_unique/shotgun_ammo/slugs,
	)

/datum/uplink_item/spy_unique/ansem_pistol
	name = "安瑟姆手枪"
	desc = "一把非常擅长让人入睡的手枪。"
	item = /obj/item/gun/ballistic/automatic/pistol/clandestine
	cost = SPY_UPPER_COST_THRESHOLD
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/basic/m10mm,
		/datum/uplink_item/ammo_nuclear/ap/m10mm,
		/datum/uplink_item/ammo_nuclear/hp/m10mm,
		/datum/uplink_item/ammo_nuclear/incendiary/m10mm,
	)

/datum/uplink_item/spy_unique/makarov_pistol
	name = "马卡洛夫手枪"
	desc = "一把马卡洛夫手枪——可靠而结实。"
	item = /obj/item/gun/ballistic/automatic/pistol
	cost = SPY_LOWER_COST_THRESHOLD
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND
	relevant_child_items = list(
		/datum/uplink_item/ammo/pistol,
		/datum/uplink_item/ammo/pistolap,
		/datum/uplink_item/ammo/pistolhp,
		/datum/uplink_item/ammo/pistolfire,
	)

/datum/uplink_item/spy_unique/toy_pistol
	name = "咚克软防暴手枪"
	desc = "一把咚克软防暴手枪——能以高于正常速度发射泡沫飞镖的玩具手枪。"
	item = /obj/item/gun/ballistic/automatic/pistol/toy/riot/clandestine
	cost = SPY_LOWER_COST_THRESHOLD
	cost = SPY_LOWER_COST_THRESHOLD
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND
	relevant_child_items = list(
		/datum/uplink_item/ammo/toydarts,
	)

/datum/uplink_item/spy_unique/rocket_launcher
	name = "火箭筒"
	desc = "一把火箭筒。我建议不要带着它跳跃。"
	item = /obj/item/gun/ballistic/rocketlauncher
	cost = SPY_UPPER_COST_THRESHOLD - 1 // It's a meme item
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/ap/rocket,
		/datum/uplink_item/ammo_nuclear/basic/rocket,
	)

/datum/uplink_item/spy_unique/shotgun_ammo
	name = "鹿弹盒"
	desc = "一盒霰弹枪用鹿弹。适合你不想打偏的时候。"
	item = /obj/item/storage/box/lethalshot
	cost = 1

/datum/uplink_item/spy_unique/shotgun_ammo/breacher_slug
	name = "破门独头弹盒"
	desc = "一盒霰弹枪用破门独头弹。适合留下良好的第一印象。"
	item = /obj/item/storage/box/breacherslug

/datum/uplink_item/spy_unique/shotgun_ammo/slugs
	name = "独头弹盒"
	desc = "一盒霰弹枪用独头弹。适合猎捕大型猎物。"
	item = /obj/item/storage/box/slugs

/datum/uplink_item/spy_unique/stealth_belt
	name = "潜行腰带"
	desc = "一条能让你潜入敌后的潜行腰带。"
	item = /obj/item/shadowcloak/weaker
	cost = SPY_UPPER_COST_THRESHOLD
	uplink_item_flags = SYNDIE_ILLEGAL_TECH

/datum/uplink_item/spy_unique/katana
	name = "武士刀"
	desc = "一把极其锋利的武士刀。我提过它很锋利吗？"
	item = /obj/item/storage/belt/sheath/katana
	cost = /datum/uplink_item/dangerous/doublesword::cost // Puts it in the same pool as Desword
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/spy_unique/medkit_lite
	name = "辛迪加初级军医包"
	desc = "一个辛迪加战术战斗医疗包，但只配了够做基础急救的物资。"
	item = /obj/item/storage/medkit/tactical_lite
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/spy_unique/antistun
	name = /datum/uplink_item/implants/nuclear/antistun::name
	desc = /datum/uplink_item/implants/nuclear/antistun::desc
	item = /obj/item/autosurgeon/syndicate/anti_stun/single_use

/datum/uplink_item/spy_unique/reviver
	name = /datum/uplink_item/implants/nuclear/reviver::name
	desc = /datum/uplink_item/implants/nuclear/reviver::desc
	item = /obj/item/autosurgeon/syndicate/reviver/single_use

/datum/uplink_item/spy_unique/thermals
	name = /datum/uplink_item/implants/nuclear/thermals::name
	desc = /datum/uplink_item/implants/nuclear/thermals::desc
	item = /obj/item/autosurgeon/syndicate/thermal_eyes/single_use

/datum/uplink_item/spy_unique/nunchaku
	name = "辛迪加健身双节棍"
	desc = "重型钛合金双节棍，能迅速把对手打倒在地，然后同样轻松地把对手砸烂。"
	item = /obj/item/melee/baton/nunchaku
	cost = SPY_UPPER_COST_THRESHOLD
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/spy_unique/penbang
	name = "钢笔闪光弹"
	desc = "一枚伪装成普通钢笔的闪光弹——按下再扔出去！激活时没有任何其他警告。 \
		引信时长取决于笔帽拧开多远。"
	item = /obj/item/pen/penbang
	cost = 1

/datum/uplink_item/spy_unique/cameraflash
	name = "照相闪光灯"
	desc = "一台装有强力闪光灯的相机。贴近目标时，可以当作普通闪光灯使用。"
	item = /obj/item/camera/flash
	cost = 1

/datum/uplink_item/spy_unique/daggerboot
	name = "靴刃"
	desc = "一双鞋底嵌有匕首的靴子。用它们踢击会刺伤目标，可能造成流血。"
	item = /obj/item/clothing/shoes/jackboots/dagger
	cost = 1

/datum/uplink_item/spy_unique/monster_cube_box
	name = "随机怪物方块盒"
	desc = "一盒随机的怪物方块。加水，看看你会得到什么！"
	item = /obj/item/storage/box/monkeycubes/random
	cost = SPY_LOWER_COST_THRESHOLD // There's some really bad stuff in here but also some really mild stuff

/datum/uplink_item/spy_unique/sleeping_carp
	name = "睡鲤拳技法"
	desc = "一卷教你睡鲤拳武术基础的卷轴。"
	item = /datum/uplink_item/stealthy_weapons/martialarts::item
	cost = /datum/uplink_item/stealthy_weapons/martialarts::cost

/datum/uplink_item/spy_unique/spider_bite
	name = "蛛咬拳技法"
	desc = "一卷教你蛛咬拳武术基础的卷轴。"
	item = /obj/item/book/granter/martial/spider_bite
	cost = SPY_UPPER_COST_THRESHOLD // While SCarp is firmly in the upper threshold, Spider Bite can be in either middle or upper.
