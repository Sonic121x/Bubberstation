/obj/structure/closet/secure_closet/interdynefob/sa_locker
	icon_door = "cap"
	icon_state = "cap"
	name = "\proper 空间站上将的储物柜"

/obj/item/clothing/accessory/medal/gold/admiral
	name = "上将勋章"
	desc = "一枚金质勋章，仅授予晋升至舰长军衔的人。\
		它象征着一名上将对索斯兰辛迪加所负的成文职责，以及对其船员的无可争议的权威。"

/obj/item/storage/bag/garment/station_admiral
	name = "空间站上将的衣物袋"
	desc = "用于存放备用衣物和鞋子的袋子。这个是空间站上将的。"

/obj/item/storage/bag/garment/station_admiral/PopulateContents()
	new /obj/item/clothing/head/hats/hos/cap/syndicate(src)
	new /obj/item/clothing/suit/armor/vest/capcarapace/syndicate(src)
	new /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate(src)
	new /obj/item/clothing/suit/armor/vest/capcarapace/syndicate/winter(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/accessory/medal/gold/admiral(src)

/obj/structure/closet/secure_closet/interdynefob/sa_locker/PopulateContents()
	..()

	new /obj/item/storage/toolbox/guncase/skyrat/pistol/aps(src)
	new /obj/item/storage/bag/garment/station_admiral(src)
	new /obj/item/radio/headset/syndicateciv/command(src)

/obj/structure/closet/secure_closet/interdynefob/maa_locker
	icon_door = "warden"
	icon_state = "warden"
	name = "纠察长储物柜"
	req_access = list("syndicate_leader")

/obj/item/clothing/accessory/medal/silver/maa_medal
	name = "军事卓越勋章"
	desc = "索斯兰辛迪加的词典将卓越定义为“把纳米传讯的渣滓踩在靴底的能力”。\
		这枚勋章授予那些少数符合该定义的干员。"

/obj/item/clothing/suit/armor/hos/maa_greatcoat
	name = "纠察长装甲大衣"
	desc = "一件用特殊合金强化过的大衣，能为那些因为不待在禁闭室里而很可能被欺负的人添上额外的防护与风度。"

/obj/item/clothing/suit/armor/hos/trenchcoat/maa_greatcoat
	name = "纠察长装甲风衣"
	desc = "一件用特殊轻质凯夫拉强化过的风衣。肩章上缝着小号的辛迪加标志，正下方还绣着字母“MAA”。"

/obj/item/storage/bag/garment/master_arms
	name = "纠察长的衣物袋"
	desc = "用于存放备用衣物和鞋子的袋子。这个是纠察长的。"

/obj/item/storage/bag/garment/master_arms/PopulateContents()
	new /obj/item/clothing/accessory/medal/silver/maa_medal(src)
	new /obj/item/clothing/suit/armor/vest/warden/syndicate(src)
	new /obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate(src)
	new /obj/item/clothing/under/suit/skyrat/helltaker(src)
	new /obj/item/clothing/suit/armor/hos/maa_greatcoat(src)
	new /obj/item/clothing/head/beret/sec/navywarden/syndicate(src)
	new /obj/item/clothing/head/hats/hos/beret/syndicate(src)

/obj/structure/closet/secure_closet/interdynefob/maa_locker/PopulateContents()
	..()

	new /obj/item/storage/belt/security/full(src)
	new /obj/item/watertank/pepperspray(src)
	new /obj/item/storage/bag/garment/master_arms(src)
	new /obj/item/radio/headset/syndicateciv/staff(src)
	new /obj/item/storage/toolbox/guncase/skyrat/c20r(src)

/obj/structure/closet/secure_closet/interdynefob/maa_locker/populate_contents_immediate()
	. = ..()

	new /obj/item/gun/energy/disabler(src)

/obj/structure/closet/secure_closet/interdynefob/cl_locker
	icon_door = "hop"
	icon_state = "hop"
	name = "\proper 企业联络官的储物柜"
	req_access = list("syndicate_leader")

/obj/item/clothing/neck/chaplain/black/cl_cloak
	name = "企业联络官的披风"
	desc = "一件独特的披风，上面企业联络官的徽记隐隐闪烁。"

/obj/item/storage/bag/garment/corprate_liaison
	name = "企业联络官的衣物袋"
	desc = "用于存放备用衣物和鞋子的袋子。这个是企业联络官的。"

/obj/item/storage/bag/garment/corprate_liaison/PopulateContents()
	new /obj/item/clothing/under/syndicate/skyrat/baseball(src)
	new /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate(src)
	new /obj/item/clothing/under/suit/skyrat/helltaker(src)
	new /obj/item/clothing/neck/chaplain/black/cl_cloak(src)
	new /obj/item/clothing/head/hats/hos/beret/syndicate(src)
	new /obj/item/clothing/glasses/sunglasses(src)

/obj/structure/closet/secure_closet/interdynefob/cl_locker/PopulateContents()
	..()

	new /obj/item/card/id/advanced/chameleon/black(src)
	new /obj/item/card/id/advanced/chameleon/black(src)
	new /obj/item/card/id/advanced/chameleon/black(src)
	new /obj/item/encryptionkey/headset_syndicate/interdyne(src)
	new /obj/item/encryptionkey/headset_syndicate/interdyne(src)
	new /obj/item/encryptionkey/headset_syndicate/interdyne(src)
	new /obj/item/language_manual/codespeak_manual/unlimited(src)
	new /obj/item/storage/bag/garment/corprate_liaison(src)
	new /obj/item/radio/headset/syndicateciv/command(src)
