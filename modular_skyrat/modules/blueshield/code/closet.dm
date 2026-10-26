/obj/item/storage/bag/garment/blueshield
	name = "蓝盾的衣物袋"
	desc = "用于存放备用衣物和鞋子的袋子。这个是蓝盾的。"

/obj/item/storage/bag/garment/blueshield/PopulateContents()
	new /obj/item/clothing/suit/hooded/wintercoat/skyrat/blueshield(src)
	new /obj/item/clothing/head/beret/blueshield(src)
	new /obj/item/clothing/head/beret/blueshield/navy(src)
	new /obj/item/clothing/under/rank/blueshield(src)
	new /obj/item/clothing/under/rank/blueshield/skirt(src)
	new /obj/item/clothing/under/rank/blueshield/turtleneck(src)
	new /obj/item/clothing/under/rank/blueshield/turtleneck/skirt(src)
	new /obj/item/clothing/suit/armor/vest/blueshield(src)
	new /obj/item/clothing/suit/armor/vest/blueshield/jacket(src)
	new /obj/item/clothing/neck/mantle/bsmantle(src)

/obj/item/storage/box/glasseskit
	name = "墨镜套装"
	desc = "内含不同类型的墨镜，以应对蓝盾的各种需求。"

/obj/item/storage/box/glasseskit/PopulateContents() //paradise stuff
	new /obj/item/clothing/glasses/hud/diagnostic/sunglasses(src)
	new /obj/item/clothing/glasses/hud/health/sunglasses(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/clothing/glasses/sunglasses/chemical(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/guard/customs(src)

/obj/structure/closet/secure_closet/blueshield
	name = "蓝盾的储物柜"
	icon_state = "bs"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/secure_closet/blueshield/New()
	..()
	new /obj/item/storage/briefcase/secure(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/guard/blueshield(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
//	new /obj/item/storage/medkit/tactical/blueshield(src)
//	new /obj/item/gun/energy/e_gun(src)
	new /obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5/blueshield(src)
	new /obj/item/storage/bag/garment/blueshield(src)
//	new /obj/item/mod/control/pre_equipped/blueshield(src)
	new /obj/item/storage/box/glasseskit(src)
//	new /obj/item/storage/medkit/brute(src)
