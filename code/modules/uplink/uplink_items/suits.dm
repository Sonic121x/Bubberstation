// File ordered by progression

/datum/uplink_category/suits
	name = "太空服"
	weight = 3

/datum/uplink_item/suits
	category = /datum/uplink_category/suits
	surplus = 40

//---- SUITS

/datum/uplink_item/suits/infiltrator_bundle
	name = "渗透者 MOD 外骨骼"
	desc = "由玫瑰银河演员公会与戈尔莱克斯掠夺者合作开发，用于城市作战的实用型套装， \
			事实证明它比标准配发的 MOD 外骨骼更便宜，而且没有公司所用太空服的那些行动限制。 \
			不过，这种更高的机动性是有代价的，这套外骨骼在太空中无法有效保护使用者免受真空伤害。 \
			该套装预装了一个特殊的心灵发射隐形模块，使他人无法辨认使用者， \
			同时还会在纳米传讯船员中造成严重的士气低落。"
	item = /obj/item/mod/control/pre_equipped/infiltrator
	cost = 6
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/suits/space_suit
	name = "辛迪加太空服"
	desc = "这套红黑配色的辛迪加太空服比纳米传讯的款式更轻便， \
			可以装进包里，还带有一个武器槽。不过，纳米传讯船员都受过训练， \
			一旦看到红色太空服就要上报。"
	item = /obj/item/storage/box/syndie_kit/space
	cost = 4

/datum/uplink_item/suits/modsuit
	name = "辛迪加 MOD 外骨骼"
	desc = "辛迪加特工令人畏惧的 MOD 外骨骼。具备装甲和一整套内置模块。"
	item = /obj/item/mod/control/pre_equipped/traitor
	cost = 8
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS //you can't buy it in nuke, because the elite modsuit costs the same while being better

//---- MODULES

/datum/uplink_item/suits/thermal
	name = "MOD 外骨骼热成像护目镜模块"
	desc = "一种用于 MOD 外骨骼的护目镜。能让你隔着墙壁看到活物。"
	item = /obj/item/mod/module/visor/thermal
	cost = 2

/datum/uplink_item/suits/chameleon
	name = "MOD 外骨骼变色龙模块"
	desc = "一种能让外骨骼伪装成其他物体的 MOD 外骨骼模块。"
	item = /obj/item/mod/module/chameleon
	cost = 1

/datum/uplink_item/suits/plate_compression
	name = "MOD 外骨骼板材压缩模块"
	desc = "一种能让外骨骼压缩成更小体积的 MOD 外骨骼模块。与储物模块和渗透者 MOD 外骨骼不兼容。"
	item = /obj/item/mod/module/plate_compression
	cost = 1

/datum/uplink_item/suits/noslip
	name = "MOD 外骨骼防滑模块"
	desc = "一种可防止使用者在水上滑倒的 MOD 外骨骼模块。"
	item = /obj/item/mod/module/noslip
	cost = 1

/datum/uplink_item/suits/shock_absorber
	name = "MOD 外骨骼电击吸收模块"
	desc = "一种可防止使用者被警棍击倒的 MOD 外骨骼模块。"
	item = /obj/item/mod/module/shock_absorber
	cost = 1

/datum/uplink_item/suits/modsuit/wraith
	name = "MOD 外骨骼怨灵隐形模块"
	desc = "一种赋予使用者光学伪装、并能通过过载光源来为套装充能的 MOD 外骨骼模块。 \
		与有装甲的 MOD 外骨骼不兼容。"
	item = /obj/item/mod/module/stealth/wraith
	cost = 2
