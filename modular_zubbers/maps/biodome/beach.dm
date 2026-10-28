/obj/effect/spawner/random/food_or_drink/island_booze
	name = "海岛酒水生成器"
	icon_state = "beer"
	loot = list(
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/agua_fresca = 1,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/bahama_mama = 2,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/cuba_libre = 2,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/iced_tea = 4,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/long_island_iced_tea = 2,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/long_john_silver = 2,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/margarita = 3,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/mauna_loa = 1,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/painkiller = 2,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/pina_colada = 4,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/salt_and_swell = 2,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/sea_breeze = 3,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/tequila_sunrise = 3,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/tropical_storm = 2,
	)

//filled drinks to populate the spawner with (these are here because they aren't used anywhere else)
/obj/item/reagent_containers/cup/glass/drinkingglass/filled/agua_fresca
	name = "阿瓜弗雷斯卡"
	list_reagents = list(/datum/reagent/consumable/agua_fresca = 30)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/bahama_mama
	name = "巴哈马妈妈"
	list_reagents = list(/datum/reagent/consumable/ethanol/bahama_mama = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/cuba_libre
	name = "自由古巴"
	list_reagents = list(/datum/reagent/consumable/ethanol/cuba_libre = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/iced_tea
	name = "冰茶"
	list_reagents = list(/datum/reagent/consumable/icetea = 50)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/long_island_iced_tea
	name = "长岛冰茶"
	list_reagents = list(/datum/reagent/consumable/ethanol/longislandicedtea = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/long_john_silver
	name = "长约翰·西尔弗"
	list_reagents = list(/datum/reagent/consumable/ethanol/long_john_silver = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/margarita
	name = "玛格丽特"
	list_reagents = list(/datum/reagent/consumable/ethanol/margarita = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/mauna_loa
	name = "冒纳罗亚"
	list_reagents = list(/datum/reagent/consumable/ethanol/mauna_loa = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/painkiller
	name = "止痛剂"
	list_reagents = list(/datum/reagent/consumable/ethanol/painkiller = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/pina_colada
	name = "椰林飘香"
	list_reagents = list(/datum/reagent/consumable/ethanol/pina_colada = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/salt_and_swell
	name = "盐与浪"
	list_reagents = list(/datum/reagent/consumable/ethanol/salt_and_swell = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/sea_breeze
	name = "海风"
	list_reagents = list(/datum/reagent/consumable/ethanol/sea_breeze = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/tequila_sunrise
	name = "龙舌兰日出"
	list_reagents = list(/datum/reagent/consumable/ethanol/tequila_sunrise = 25)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/tropical_storm
	name = "热带风暴"
	list_reagents = list(/datum/reagent/consumable/ethanol/tropical_storm = 25)

/obj/effect/spawner/random/clothing/island_time
	name = "海岛时光服装生成器"
	loot = list(
		/obj/item/clothing/suit/costume/hawaiian = 4,
		/obj/item/clothing/glasses/sunglasses/cheap = 3,
		/obj/item/clothing/shoes/sandal = 3,
		/obj/item/clothing/head/costume/scarecrow_hat = 2,
		/obj/item/clothing/under/dress/tango = 1,
		/obj/item/clothing/under/dress/sundress = 1,
		/obj/item/clothing/under/shorts/red = 1,
		/obj/item/clothing/under/shorts/green = 1,
		/obj/item/clothing/under/shorts/blue = 1,
		/obj/item/clothing/under/shorts/black = 1,
		/obj/item/clothing/under/shorts/purple = 1,
	)

//Because sunglasses of all things are a powerful and rare item, here's some cheap ones that don't do anything
/obj/item/clothing/glasses/sunglasses/cheap
	name = "廉价太阳镜"
	desc = "廉价塑料镜片，替你挡住刺眼阳光。但这么脆弱的货色可挡不了闪光。"
	flash_protect = FLASH_PROTECTION_NONE
