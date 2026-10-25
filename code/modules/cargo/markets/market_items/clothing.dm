/datum/market_item/clothing
	category = "Clothing"
	abstract_path = /datum/market_item/clothing

/datum/market_item/clothing/ninja_mask
	name = "太空忍者面罩"
	desc = "除了防酸、防熔岩、防火以及难以从别人脸上取下之外，它本身并没有什么特别之处。"
	item = /obj/item/clothing/mask/gas/ninja

	price_min = CARGO_CRATE_VALUE
	price_max = CARGO_CRATE_VALUE * 2.5
	stock_max = 3
	availability_prob = 40

/datum/market_item/clothing/durathread_vest
	name = "耐久纤维背心"
	desc = "别听他们说什么这东西“像石棉”或者“因安全顾虑被下架”。它可能就是挨揍与反杀之间的区别。"
	item = /obj/item/clothing/suit/armor/vest/durathread

	price_min = CARGO_CRATE_VALUE
	price_max = CARGO_CRATE_VALUE * 2
	stock_max = 4
	availability_prob = 50

/datum/market_item/clothing/durathread_helmet
	name = "耐久纤维头盔"
	desc = "顾客总问，既然只是用装甲布料做的，为什么叫头盔？我每次都回答同一句话：概不退款。"
	item = /obj/item/clothing/head/helmet/durathread

	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE
	stock_max = 4
	availability_prob = 50

/datum/market_item/tool/medsechud
	name = "医疗安保 HUD"
	desc = "一款基本已停产的安保与健康扫描 HUD 二合一产品。现在没人再生产它们了。"
	item = /obj/item/clothing/glasses/hud/medsechud

	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3.5
	stock_max = 3
	availability_prob = 50

/datum/market_item/clothing/full_spacesuit_set
	name = "\improper 纳米传讯品牌宇航服箱"
	desc = "几箱“老款式”宇航服从一辆太空卡车的车尾掉了下来。"
	item = /obj/item/storage/box

	price_min = CARGO_CRATE_VALUE * 1.875
	price_max = CARGO_CRATE_VALUE * 4
	stock_max = 3
	availability_prob = 30

/datum/market_item/clothing/full_spacesuit_set/spawn_item(loc)
	var/obj/item/storage/box/B = ..()
	B.name = "宇航服箱"
	B.desc = "上面印着 NT 的标志。"
	new /obj/item/clothing/suit/space(B)
	new /obj/item/clothing/head/helmet/space(B)
	return B

/datum/market_item/clothing/chameleon_hat
	name = "变色龙头饰"
	desc = "用这个便利的小玩意，随心所欲挑选任何帽子。未经质量测试。"
	item = /obj/item/clothing/head/chameleon/broken

	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE
	stock_max = 2
	availability_prob = 70

/datum/market_item/clothing/rocket_boots
	name = "火箭靴"
	desc = "我们找到了一双跳跃靴，然后把它超频到了极点。对涉及或针对身体的严重伤害不承担任何责任。"
	item = /obj/item/clothing/shoes/bhop/rocket

	price_min = CARGO_CRATE_VALUE * 5
	price_max = CARGO_CRATE_VALUE * 10
	stock_max = 1
	availability_prob = 40

/datum/market_item/clothing/anti_sec_pin
	name = "颠覆徽章"
	desc = "限量发行的独特时尚红色徽章，用于宣称你对纳米传讯公司之敌的效忠。\
		内含一枚 RFID 芯片，可干扰常见的扫描设备，以确保他们知道你是认真的。和朋友们分享吧！"
	item = /obj/item/clothing/accessory/anti_sec_pin

	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE * 1.5
	stock_max = 5
	availability_prob = 70

/datum/market_item/clothing/floortileset
	name = "地板砖迷彩制服"
	desc = "嘿，想给谁一个惊喜吗？当间谍？偷东西？那你走运了，来看看我们最新的 \
		地板砖“NT 渣滓”风格迷彩作战服。这是最顶尖特工使用的终极 \
		间谍制服。我们最新的迷彩科技布料提供最佳的 \
		柔韧性。完美适用于 \
		危险的间谍走廊行动。享受我们的产品吧！"
	item = /obj/item/storage/box/floor_camo
	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE
	stock_max = 3
	availability_prob = 40

/datum/market_item/clothing/collar_bomb
	name = "项圈炸弹套装"
	desc = "一套未申请专利、道德上存疑的套装，包含一个低当量爆炸项圈以及一个引爆遥控器。"
	item = /obj/item/storage/box/collar_bomb
	price_min = CARGO_CRATE_VALUE * 3.5
	price_max = CARGO_CRATE_VALUE * 4.5
	stock_max = 3
	availability_prob = 60

/datum/market_item/clothing/totally_normal_pet_collar
	name = "奇怪的宠物项圈"
	desc = "我们在一艘开往新大阪的军用穿梭机后舱里发现了这些东西。到底谁会 \
		用装甲飞船运送宠物项圈？管他呢，既然赛博太阳工业不想让你拿到它们，那它们肯定特别得很！ \
		所以我们才要多收你的钱。"
	item = /obj/item/clothing/neck/petcollar/wearable/cyber
	price_min = CARGO_CRATE_VALUE * 5
	price_max = CARGO_CRATE_VALUE * 10
	stock_max = 5
	availability_prob = 20
