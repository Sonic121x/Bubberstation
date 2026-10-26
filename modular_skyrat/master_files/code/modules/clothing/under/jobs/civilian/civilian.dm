/obj/item/clothing/under/rank/civilian
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian_digi.dmi' //Anything that was in TG's civilian.dmi, should be in our civilian_digi.dmi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/civilian/lawyer // Lawyers' suits are in TG's suits.dmi
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/suits_digi.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/bluesuit // EXCEPT THIS ONE.
	greyscale_config_worn_digi = /datum/greyscale_config/buttondown_slacks/worn/digi

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE //Just gonna set it to default for ease

//TG's files separate this into Civilian, Clown/Mime, and Curator. We wont have as many, so all Service goes into this file.
//DO NOT ADD A /obj/item/clothing/under/rank/civilian/lawyer/skyrat. USE /obj/item/clothing/under/suit/skyrat FOR MODULAR SUITS (civilian/suits.dm).

/*
*	HEAD OF PERSONNEL
*/

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade
	name = "人事主管男性礼服"
	desc = "一件为人事主管准备的奢华制服，织成深蓝色。翻领上别着一枚柯基犬头形状的小别针。"
	icon_state = "hop_parade_male"

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade/female
	name = "人事主管女性礼服"
	icon_state = "hop_parade_female"

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck
	name = "人事主管高领毛衣"
	desc = "柔软蓝色高领毛衣配黑色卡其裤，由那些更看重舒适而非风格的高管穿着。"
	icon_state = "hopturtle"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck/skirt
	name = "人事主管高领短裙"
	desc = "柔软蓝色高领毛衣配黑色短裙，由那些更看重舒适而非风格的高管穿着。"
	icon_state = "hopturtle_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
