/obj/structure/closet/secure_closet/interdynefob/medical
	icon_state = "med_secure"
	name = "医疗装备储物柜"

/obj/item/storage/bag/garment/syndicate_medical
	name = "医疗部衣物袋"
	desc = "用于存放备用衣物和鞋子的袋子。这个是医疗部的。"

/obj/item/storage/bag/garment/syndicate_medical/PopulateContents()
	new /obj/item/clothing/gloves/latex/nitrile/ntrauma(src)
	new /obj/item/clothing/suit/toggle/labcoat/interdyne(src)
	new /obj/item/clothing/suit/toggle/labcoat/interdyne(src)
	new /obj/item/clothing/glasses/hud/ar/aviator/health(src)
	new /obj/item/clothing/glasses/hud/ar/aviator/health(src)

/obj/structure/closet/secure_closet/interdynefob/medical/PopulateContents()
	..()

	new /obj/item/storage/belt/medbandolier(src)
	new /obj/item/storage/belt/medbandolier(src)
	new /obj/item/storage/bag/garment/syndicate_medical(src)
