/obj/structure/closet/secure_closet/interdynefob/welding_supplies
	icon_door = "eng_weld"
	icon_state = "eng"
	name = "焊接用品储物柜"

/obj/structure/closet/secure_closet/interdynefob/welding_supplies/PopulateContents()
	..()

	new /obj/item/weldingtool/largetank(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/clothing/glasses/welding(src)
	new /obj/item/clothing/glasses/welding(src)

/obj/structure/closet/secure_closet/interdynefob/electrical_supplies
	icon_door = "eng_elec"
	icon_state = "eng"
	name = "电气用品储物柜"

/obj/structure/closet/secure_closet/interdynefob/electrical_supplies/PopulateContents()
	..()

	new /obj/item/electronics/airlock(src)
	new /obj/item/electronics/airlock(src)
	new /obj/item/storage/toolbox/electrical(src)
	new /obj/item/electronics/apc(src)
	new /obj/item/electronics/firelock(src)
	new /obj/item/electronics/airalarm(src)
	new /obj/item/stock_parts/power_store/cell/high(src)
	new /obj/item/stock_parts/power_store/cell/high(src)
	new /obj/item/stock_parts/power_store/battery/high(src)
	new /obj/item/stock_parts/power_store/battery/high(src)
	new /obj/item/clothing/glasses/meson/engine(src)

/obj/structure/closet/secure_closet/interdynefob/engie_locker
	icon_door = "eng_secure"
	icon_state = "eng_secure"
	name = "引擎技师装备储物柜"

/obj/item/storage/bag/garment/syndicate_engie
	name = "引擎技师的衣物袋"
	desc = "用于存放备用衣物和鞋子的袋子。这个是引擎技师的。"

/obj/item/storage/bag/garment/syndicate_engie/PopulateContents()
	new /obj/item/clothing/suit/hooded/wintercoat/engineering(src)
	new /obj/item/clothing/head/soft/sec/syndicate(src)
	new /obj/item/clothing/under/syndicate/skyrat/overalls(src)
	new /obj/item/clothing/under/syndicate/skyrat/overalls/skirt(src)
	new /obj/item/clothing/under/rank/engineering/engineer/skyrat/utility/syndicate(src)
	new /obj/item/clothing/suit/jacket/gorlex_harness(src)
	new /obj/item/clothing/suit/hazardvest(src)
	new /obj/item/clothing/accessory/armband/engine/syndicate(src)
	new /obj/item/clothing/accessory/armband/engine/syndicate(src)
	new /obj/item/clothing/glasses/hud/ar/aviator/meson(src)

/obj/item/clothing/accessory/armband/engine/syndicate
	name = "引擎技师臂章"
	desc = "一条臂章，由前进基地的特工佩戴，以显示其所属部门。"

/obj/structure/closet/secure_closet/interdynefob/engie_locker/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/syndicate_engie(src)
	new /obj/item/holosign_creator/atmos(src)
