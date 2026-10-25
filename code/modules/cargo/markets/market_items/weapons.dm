/datum/market_item/weapon
	category = "Weapons"
	abstract_path = /datum/market_item/weapon

/datum/market_item/weapon/bear_trap
	name = "捕熊陷阱"
	desc = "用这套价格实惠的恶作剧套装，以其人之道还治其人之身地对付清洁工。"
	item = /obj/item/restraints/legcuffs/beartrap

	price_min = CARGO_CRATE_VALUE * 1.5
	price_max = CARGO_CRATE_VALUE * 2.75
	stock_max = 3
	availability_prob = 40

/datum/market_item/weapon/shotgun_dart
	name = "XL 霰弹枪飞镖盒"
	desc = "这些方便的飞镖可以装入任何化学物质，并用霰弹枪发射！ \
		想捉弄朋友，就用它把笑气射进他们体内！ \
		不建议用于商业用途。"
	item = /obj/item/storage/box/large_dart

	price_min = CARGO_CRATE_VALUE * 1.375
	price_max = CARGO_CRATE_VALUE * 2.875
	stock_max = 4
	availability_prob = 40

/datum/market_item/weapon/buckshot
	name = "鹿弹弹壳盒"
	desc = "如今鹿弹被课以重税，想弄到可不容易，但我们还是在 \
		某处找到了一批存货。提醒一句，这批货可能有点旧了。"
	stock_max = 7
	availability_prob = 35
	item = /obj/effect/spawner/random/armory/buckshot/sketchy
	price_min = CARGO_CRATE_VALUE * 1
	price_max = CARGO_CRATE_VALUE * 3

/datum/market_item/weapon/strilka
	name = ".310 斯特里尔卡弹药箱"
	desc = "听着，.310 斯特里尔卡并不算稀有，但如果你想让它来自 \
		第三苏维埃死硬派以外的任何渠道，那就只能拿到什么算什么。 \
		有些是好货，有些是剩余物资。我们可不做任何保证，明白吧？"
	stock_max = 7
	availability_prob = 35
	item = /obj/effect/spawner/random/armory/strilka
	price_min = CARGO_CRATE_VALUE
	price_max = CARGO_CRATE_VALUE * 2

/datum/market_item/weapon/sks_kit
	name = "萨赫诺 SKS 半自动步枪"
	desc = "没错宝贝，这就是一套 SKS 零件包！好吧，它不是那种上古原版，但放到 \
		现在也已经够古老了。只要在维修通道的某个角落把它拼起来，你就 \
		拥有一把完整的 SKS 了！而且它根本不会卡壳！说起来，他们到底为什么让第三 \
		苏维埃的士兵去用萨赫诺 M2442 军用型？这东西简直牛爆了！这是夸它。快买！"
	item = /obj/item/weaponcrafting/gunkit/sks
	price_min = CARGO_CRATE_VALUE * 1
	price_max = CARGO_CRATE_VALUE * 3
	stock_max = 5
	availability_prob = 90

/datum/market_item/weapon/bone_spear
	name = "骨质长矛"
	desc = "正宗的部落长矛，用真正的骨头制成！无论什么价格都超值，尤其是如果你是个穴居人的话。"
	item = /obj/item/spear/bonespear

	price_min = CARGO_CRATE_VALUE
	price_max = CARGO_CRATE_VALUE * 1.5
	stock_max = 3
	availability_prob = 60

/datum/market_item/weapon/chainsaw
	name = "电锯"
	desc = "伐木工最好的朋友，非常适合高效地切割树木或肢体。"
	item = /obj/item/chainsaw

	price_min = CARGO_CRATE_VALUE * 1.75
	price_max = CARGO_CRATE_VALUE * 3
	stock_max = 1
	availability_prob = 35

/datum/market_item/weapon/switchblade
	name = "弹簧刀"
	desc = "隧道蛇帮最棒！"
	item = /obj/item/switchblade

	price_min = CARGO_CRATE_VALUE * 1.25
	price_max = CARGO_CRATE_VALUE * 1.75
	stock_max = 3
	availability_prob = 45

/datum/market_item/weapon/carpenter_hammer
	name = "木工锤"
	desc = "当你真的很想看起来像个精神病时……"
	item = /obj/item/carpenter_hammer

	price_min = CARGO_CRATE_VALUE * 1
	price_max = CARGO_CRATE_VALUE * 1.25
	stock_max = 2
	availability_prob = 65

/datum/market_item/weapon/emp_grenade
	name = "EMP 手榴弹"
	desc = "使用这枚手榴弹，收获令人震惊的结果！"
	item = /obj/item/grenade/empgrenade

	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE * 2
	stock_max = 2
	availability_prob = 50

/datum/market_item/weapon/fisher
	name = "SC/FISHER 破坏者手枪"
	desc = "一把可自行充能的紧凑型手枪，能暂时干扰灯光、摄像头、APC、炮塔等设备。也可用于近战。"
	item = /obj/item/gun/energy/recharge/fisher

	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 4
	stock_max = 1
	availability_prob = 75

/datum/market_item/weapon/dimensional_bomb
	name = "多维炸弹核心"
	desc = "一枚独一无二的特殊炸弹核心，专为你的各种‘地球化改造出了岔子’用途而生。"
	item = /obj/item/bombcore/dimensional
	price_min = CARGO_CRATE_VALUE * 40
	price_max = CARGO_CRATE_VALUE * 50
	stock_max = 1
	availability_prob = 15

/datum/market_item/weapon/giant_wrench_parts
	name = "‘大巴掌’零件"
	desc = "廉价非法的‘大巴掌’零件。速度最快、从统计上看也最危险的扳手。"
	item = /obj/item/weaponcrafting/giant_wrench
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 5
	stock_max = 1
	availability_prob = 25

/datum/market_item/weapon/liberator
	name = "非法 3D 打印机设计图"
	desc = "一种极其廉价的 3D 打印枪械的设计图，以在倒霉的助手手中爆炸而闻名。"
	item = /obj/item/disk/design_disk/liberator
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 5
	stock_max = 1
	availability_prob = 35

/datum/market_item/weapon/surplus_esword
	name = "I 型‘居合’能量剑"
	desc = "一把量产型能量剑。性能上不如准军事组织常见的军规能量剑。 \
		但总比没有强。它确实有些供电问题，不过敲打几下就能解决。"
	item = /obj/item/melee/energy/sword/surplus
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 5
	stock_max = 2
	availability_prob = 80

/datum/market_item/weapon/earthcracker
	name = "E-1 裂地器"
	desc = "本区域众多被纳米传讯收购的无名小行星采矿公司之一的剩余采矿设备。\
		虽然它们在开采小行星方面表现尚可，但如今部署后，它们在给空间站级船体留下巨大裂缝方面才真正大放异彩。"
	item = /obj/item/earthcracker/small
	price_min = CARGO_CRATE_VALUE
	price_max = CARGO_CRATE_VALUE * 3
	stock_max = 1
	availability_prob = 30
