/obj/item/clothing/under/colonial/nri_police
	name = "帝国警察制服"
	desc = "漂亮的蓝色耐久纤维衬衫与棉混纺长裤，配有黑色合成皮革腰带。这种久经考验的设计最初由联邦警察的\
	前身——边缘世界殖民民兵采用，如今沿用以示纪念。"
	icon_state = "under_police"
	armor_type = /datum/armor/clothing_under/rank_security
	strip_delay = 5 SECONDS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	can_adjust = FALSE

/obj/item/clothing/neck/cloak/colonial/nri_police
	name = "帝国警察披风"
	desc = "一件厚帆布披风，其设计几乎能完全防风防水。背部印着联邦警察标志性的白色长方形。"
	icon_state = "cloak_police"

// Just some extra police equipment
/obj/item/clothing/neck/cloak/colonial/nri_police/Initialize(mapload)
	allowed += list(
		/obj/item/restraints/handcuffs,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
	)
	return ..()

/obj/item/clothing/head/hats/colonial/nri_police
	name = "帝国警察帽"
	desc = "一顶以帆布制成、外覆织物的蓬松帽子。坚固舒适，而且似乎很能保持形状。<br>\
		帽檐正上方绣着银色的联邦警察徽章。"
	icon_state = "cap_police"
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/mask/gas/nri_police
	name = "帝国警察面罩"
	desc = "一副贴合面部的战术面罩。"
	icon = 'modular_skyrat/modules/novaya_ert/icons/mask.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/wornmask.dmi'
	worn_icon_digi = 'modular_skyrat/modules/novaya_ert/icons/wornmask_digi.dmi'
	icon_state = "nri_police"
	inhand_icon_state = "swat"
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	visor_flags_inv = 0
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF

/obj/item/clothing/head/helmet/nri_police
	name = "帝国警察头盔"
	desc = "一顶用成形塑钢制成的厚实战术头盔。深蓝色外观与帝国警察常用的型号相似。"
	icon_state = "police_helmet"
	icon = 'modular_skyrat/modules/novaya_ert/icons/armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/wornarmor.dmi'

/obj/item/clothing/suit/armor/vest/nri_police
	name = "帝国警察插板背心"
	desc = "一件由多块致密护板组成的防弹背心，颇有分量却很舒适。呈深蓝色，前后各有一道反光条。"
	icon_state = "police_vest"
	icon = 'modular_skyrat/modules/novaya_ert/icons/armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/wornarmor.dmi'
