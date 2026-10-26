/datum/uplink_category/stealthy
	name = "潜行武器"
	weight = 8

/datum/uplink_item/stealthy_weapons
	category = /datum/uplink_category/stealthy
	uplink_item_flags = SYNDIE_ILLEGAL_TECH


/datum/uplink_item/stealthy_weapons/dart_pistol
	name = "飞镖手枪"
	desc = "一把普通注射枪的微型化版本。开火时非常安静，而且能塞进任何 \
			能放下小型物品的空间。"
	item = /obj/item/gun/syringe/syndicate
	cost = 4
	surplus = 50
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/stealthy_weapons/dehy_carp
	name = "脱水太空鲤鱼"
	desc = "看起来像个鲤鱼毛绒玩具，但只要加点水，它就会变成真正的太空鲤鱼！使用前先在 \
			手中激活它，它就知道不该杀你。"
	item = /obj/item/toy/plush/carpplushie/dehy_carp
	cost = 1

/datum/uplink_item/stealthy_weapons/edagger
	name = "能量匕首"
	desc = "一把由能量制成的匕首，未激活时外观和功能都像一支钢笔。"
	item = /obj/item/pen/edagger
	cost = 2

/datum/uplink_item/stealthy_weapons/slipstick
	name = "辛迪加口红"
	desc = "一管技术极为先进的口红，这里就不费口舌解释原理了： \
		把口红涂到自己嘴上后，你吹出的每一个飞吻都会变成激光飞吻！（用飞吻表情即可发射激光飞吻。） \
		激光飞吻可无限次吹出！用飞吻送人上路，很时髦吧，辛迪加小亲亲？"
	item = /obj/item/lipstick/syndie
	cost = 6

/datum/uplink_item/stealthy_weapons/traitor_chem_bottle
	name = "毒药套件"
	desc = "一批致命化学品，装在一个小巧的盒子里。附一支注射器，便于更精确地施用。"
	item = /obj/item/storage/box/syndie_kit/chemical
	cost = 6
	surplus = 50

/datum/uplink_item/stealthy_weapons/carnivorous_blood
	name = "肉食血液"
	desc = "一瓶肉食血液，这是英特戴恩的一种生物武器，一旦与潜在受害者的血液混合并注入其血流， \
		就会迅速消耗受害者体内可用的血液。喂它高蛋白肉类即可让它繁殖。"
	item = /obj/item/storage/box/syndie_kit/carnivorous_blood
	cost = 3
	surplus = 50

/datum/uplink_item/stealthy_weapons/suppressor
	name = "消音器"
	desc = "这款消音器能消除其所安装武器的枪声，以便更好地潜行和伏击。它兼容许多小型弹道枪械，包括马卡洛夫、斯捷奇金 APS 和 C-20r，但不适用于左轮手枪或能量枪。"
	item = /obj/item/suppressor
	cost = 1
	surplus = 10
	purchasable_from = ~UPLINK_CLOWN_OPS

/datum/uplink_item/stealthy_weapons/holster
	name = "辛迪加枪套"
	desc = "一个小巧实用的装置，利用变色龙技术让你能不起眼地携带枪械。还能让你耍帅转枪。"
	item = /obj/item/storage/belt/holster/chameleon
	cost = 1

/datum/uplink_item/stealthy_weapons/sleepy_pen
	name = "安眠钢笔"
	desc = "一支伪装成正常钢笔的注射器，里面装满了强效混合药剂，包括一种 \
			强效麻醉剂和一种能让目标无法说话的化学品。 \
			这支笔只能装一剂混合液，但可以重新灌入任何化学品。请注意，在目标 \
			睡着之前，他们仍然能够移动和行动。"
	item = /obj/item/pen/sleepy
	cost = 4
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)


/datum/uplink_item/stealthy_weapons/origami_kit
	name = "盒装折纸套件"
	desc = "这个盒子内含一本教你如何折出大师级折纸作品的指南，让你能把普通纸张变成 \
			完美的空气动力学（而且可能致命）纸飞机。"
	item = /obj/item/storage/box/syndie_kit/origami_bundle
	cost = 4
	surplus = 0
	purchasable_from = ~UPLINK_SERIOUS_OPS //clown ops intentionally left in, because that seems like some s-tier shenanigans.


/datum/uplink_item/stealthy_weapons/martialarts
	name = "武术卷轴与武术服装"
	desc = "这卷卷轴记载了一门古老武术的秘诀。你将精通徒手格斗， \
			并获得把空中的子弹拍飞的能力；若穿着正确的服装，还能规避攻击。但你也将 \
			拒绝使用不光彩的远程武器，而穿着有护甲的衣物会让你更难躲避攻击。 \
			预先打包附赠一整套武术服装！"
	item = /obj/item/storage/box/syndicate/sleeping_carp
	progression_minimum = 30 MINUTES
	population_minimum = TRAITOR_POPULATION_LOWPOP
	cost = 17
	surplus = 0
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS|UPLINK_SPY)

/datum/uplink_item/stealthy_weapons/crossbow
	name = "迷你能量弩"
	desc = "一张微型化的短弓，横装在弩杆上。 \
	小到可以塞进口袋或悄悄滑进包里。 \
	它能自动合成并发射带有致弱毒素的弩矢， \
	对目标造成伤害并使其失去方向感，说话 \
	像喝醉了一样含糊不清。它可以无限次 \
	生成弩矢，但每次射击后都需要时间自动充能。"
	item = /obj/item/gun/energy/recharge/ebow
	cost = 10
	surplus = 50
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/stealthy_weapons/contrabaton
	name = "承包商警棍"
	desc = "一根配发给辛迪加承包商的紧凑专用警棍。能对目标施加轻微电击。 \
	这些电击也能影响大多数机器人的内部电路，造成短暂眩晕。 \
	还有个额外好处：它能影响受害者的声带，让他们说话像喝醉了一样含糊不清。"
	item = /obj/item/melee/baton/telescopic/contractor_baton
	cost = 7
	surplus = 50
	limited_stock = 1
	purchasable_from = UPLINK_TRAITORS | UPLINK_SPY
