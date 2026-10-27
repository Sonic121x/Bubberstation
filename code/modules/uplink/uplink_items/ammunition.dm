/datum/uplink_category/ammo
	name = "弹药"
	weight = 7

/datum/uplink_item/ammo
	category = /datum/uplink_category/ammo
	surplus = 40

/datum/uplink_item/ammo/toydarts
	name = "咚克软防暴手枪弹药箱"
	desc = "一个装有三只咚克软防暴手枪备用弹匣的箱子，另附一盒散装防暴飞镖。"
	item = /obj/item/storage/toolbox/guncase/traitor/ammunition/donksoft
	cost = 2
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	purchasable_from = ~UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/pistol
	name = "9 毫米弹匣箱"
	desc = "一个箱子，内含三个 8 发装 9 毫米备用弹匣，适用于马卡洛夫手枪，另有 \
		一盒散装 9 毫米弹药。"
	item = /obj/item/storage/toolbox/guncase/traitor/ammunition
	cost = 2
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/ammo/pistolap
	name = "9 毫米穿甲弹匣"
	desc = "一个 8 发装 9 毫米备用弹匣，适用于马卡洛夫手枪。 \
			这些子弹对目标的杀伤效果较差，但能穿透防护装备。"
	item = /obj/item/ammo_box/magazine/m9mm/ap
	cost = 2
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/ammo/pistolhp
	name = "9 毫米空尖弹匣"
	desc = "一个 8 发装 9 毫米备用弹匣，适用于马卡洛夫手枪。 \
			这些子弹杀伤力更强，但对护甲无效。"
	item = /obj/item/ammo_box/magazine/m9mm/hp
	cost = 3
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/ammo/pistolfire
	name = "9 毫米燃烧弹匣"
	desc = "一个 8 发装 9 毫米备用弹匣，适用于马卡洛夫手枪。 \
			装有燃烧弹，造成的伤害较低，但会点燃目标。"
	item = /obj/item/ammo_box/magazine/m9mm/fire
	cost = 2
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/ammo/revolver
	name = ".357 速装器"
	desc = "一个装有七发 .357 马格南子弹的速装器，可用于辛迪加左轮手枪。 \
			适用于你确实需要让很多东西死掉的时候。"
	item = /obj/item/ammo_box/speedloader/c357
	cost = 4
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY) //nukies get their own version
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
