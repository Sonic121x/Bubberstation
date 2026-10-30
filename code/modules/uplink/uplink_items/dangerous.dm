//All bundles and telecrystals
/datum/uplink_category/dangerous
	name = "显眼武器"
	weight = 9

/datum/uplink_item/dangerous
	category = /datum/uplink_category/dangerous

/datum/uplink_item/dangerous/foampistol
	name = "咚克软防暴手枪箱"
	desc = "一个箱子，内含一把看似无害的玩具手枪，能以高于正常的速度发射泡沫飞镖。 \
		随附装有防暴级飞镖的弹匣——足以让目标失去行动能力，另有两个备用弹匣和一盒散装 \
		防暴飞镖。非常适合远程非致命制服目标，也方便撇清关系。虽然套件中不含，但 \
		这把手枪可以安装消音器，可另行购买。"
	item = /obj/item/storage/toolbox/guncase/traitor/donksoft
	cost = 6
	surplus = 10
	purchasable_from = ~(UPLINK_SERIOUS_OPS | UPLINK_SPY)
	relevant_child_items = list(
		/datum/uplink_item/ammo/toydarts,
	)

/datum/uplink_item/dangerous/pistol
	name = "马卡洛夫手枪箱"
	desc = "一个武器箱，内含一把来路不明的马卡洛夫手枪变体，外加两个备用弹匣和一盒散装 9 毫米弹药。 \
		使用 9 毫米口径。非常适合与安保频繁交火，也能确保你的火力足以耗过竞争对手。 \
		虽然套件中不含，但这把手枪可以安装消音器，可另行购买。"
	item = /obj/item/storage/toolbox/guncase/traitor
	cost = 7
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)
	relevant_child_items = list(
		/datum/uplink_item/ammo/pistol,
		/datum/uplink_item/ammo/pistolap,
		/datum/uplink_item/ammo/pistolhp,
		/datum/uplink_item/ammo/pistolfire,
	)

/datum/uplink_item/dangerous/throwingweapons
	name = "一盒投掷武器"
	desc = "一盒来自古代地球武术的手里剑和强化流星锤。它们是极为有效的 \
			投掷武器。流星锤能把目标绊倒，手里剑则会嵌入四肢。"
	item = /obj/item/storage/box/syndie_kit/throwing_weapons
	cost = 3
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/dangerous/sword
	name = "能量剑"
	desc = "能量剑是一种刀身为纯粹能量的刃类武器。这把剑体积小巧，未激活时可以 \
			放进口袋。激活时会发出响亮而独特的声响。"
	item = /obj/item/melee/energy/sword/saber
	cost = 6
	purchasable_from = ~UPLINK_CLOWN_OPS

/datum/uplink_item/dangerous/powerfist
	name = "动力拳套"
	desc = "动力拳套是一只金属护手，内置由外部气瓶供能的活塞撞锤。\
			击中目标时，活塞撞锤会向前伸出，造成可观的伤害。 \
			对活塞阀使用扳手，可以调整每次出拳的气体用量，从而 \
			造成额外伤害并打到更远的目标。用螺丝刀可以取出已安装的气瓶。"
	item = /obj/item/melee/powerfist
	cost = 6
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/dangerous/rapid
	name = "北斗神拳手套"
	desc = "戴上这双手套，使用者就能以极快的速度连续出拳。不会提升武器攻击速度，也不会增强绿巨人的强壮拳头。"
	item = /obj/item/clothing/gloves/rapid
	cost = 8

/datum/uplink_item/dangerous/doublesword
	name = "双刃能量剑"
	desc = "双刃能量剑的伤害略高于标准能量剑，并且能偏转它挡下的 \
			能量射弹，但需要双手持握。它也难以帮你抵御擒抱。"
	population_minimum = TRAITOR_POPULATION_LOWPOP
	item = /obj/item/dualsaber

	cost = 13
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS //nukies get their own version

/datum/uplink_item/dangerous/doublesword/get_discount_value(discount_type)
	switch(discount_type)
		if(TRAITOR_DISCOUNT_BIG)
			return 0.5
		if(TRAITOR_DISCOUNT_AVERAGE)
			return 0.35
		else
			return 0.2

/datum/uplink_item/dangerous/guardian
	name = "全息寄生体"
	desc = "虽然能通过硬光全息影像和纳米机器实现近乎巫术的壮举，但它们需要一个 \
			有机宿主作为基地和燃料来源。全息寄生体有多种类型，并与宿主分担伤害。"
	item = /obj/item/guardian_creator/tech
	cost = 18
	surplus = 0
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/dangerous/revolver
	name = "辛迪加左轮手枪"
	desc = "一把构造极其简朴的辛迪加左轮手枪，发射 .357 马格南子弹，弹巢容量 7 发。"
	item = /obj/item/gun/ballistic/revolver
	cost = 13
	surplus = 50
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS //only traitors get the original revolver
	relevant_child_items = list(
		/datum/uplink_item/ammo/revolver,
		/datum/uplink_item/ammo_nuclear/basic/revolver,
		/datum/uplink_item/ammo_nuclear/special/revolver/phasic,
		/datum/uplink_item/ammo_nuclear/special/revolver/heartseeker,
	)
