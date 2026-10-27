/obj/structure/closet/secure_closet/interdynefob/science_gear
	icon_state = "science"
	name = "科学家装备储物柜"

/obj/item/clothing/accessory/armband/science/syndicate
	name = "研究员臂章"
	desc = "一条臂章，由前进基地的特工佩戴，以显示其所属部门。"

/obj/item/storage/bag/garment/syndicate_scientist
	name = "科学家的衣物袋"
	desc = "用于存放备用衣物和鞋子的袋子。这个是科学家的。"

/obj/item/storage/bag/garment/syndicate_scientist/PopulateContents()
	new /obj/item/clothing/suit/hooded/wintercoat/science(src)
	new /obj/item/clothing/suit/toggle/labcoat/science(src)
	new /obj/item/clothing/glasses/sunglasses/chemical(src)
	new /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate(src)
	new /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate(src)
	new /obj/item/clothing/accessory/armband/science/syndicate(src)
	new /obj/item/clothing/accessory/armband/science/syndicate(src)

/obj/structure/closet/secure_closet/interdynefob/science_gear/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/syndicate_scientist(src)

/obj/structure/closet/secure_closet/interdynefob/robotics
	icon_state = "science"
	name = "机器人专家装备储物柜"

/obj/item/storage/bag/garment/syndicate_roboticist
	name = "机器人专家的衣物袋"
	desc = "用于存放备用衣物和鞋子的袋子。这个是机器人专家的。"

/obj/item/storage/bag/garment/syndicate_roboticist/PopulateContents()
	new /obj/item/clothing/suit/hooded/techpriest(src)
	new /obj/item/clothing/suit/toggle/labcoat/roboticist(src)
	new /obj/item/clothing/under/syndicate/skyrat/overalls/skirt(src)
	new /obj/item/clothing/under/syndicate/skyrat/overalls(src)
	new /obj/item/clothing/glasses/hud/ar/aviator/diagnostic(src)
	new /obj/item/clothing/glasses/hud/diagnostic(src)
	new /obj/item/clothing/suit/hooded/wintercoat/science/robotics(src)

/obj/structure/closet/secure_closet/interdynefob/robotics/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/syndicate_scientist(src)
