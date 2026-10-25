/obj/item/clothing/suit/hooded/ethereal_raincoat
	name = "以太人雨衣"
	desc = " 旅行者或游客常穿的雨衣，他们不太喜欢斯普劳特的阴雨天气。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	worn_icon = 'icons/mob/clothing/suits/ethereal.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/ethereal_raincoat"
	post_init_icon_state = "eth_raincoat"
	greyscale_config = /datum/greyscale_config/eth_raincoat
	greyscale_config_worn = /datum/greyscale_config/eth_raincoat/worn
	greyscale_colors = "#4e7cc7"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN|ARMS
	hoodtype = /obj/item/clothing/head/hooded/ethereal_rainhood

/obj/item/clothing/suit/hooded/ethereal_raincoat/Initialize(mapload)
	. = ..()
	update_icon(UPDATE_OVERLAYS)
	AddElement(/datum/element/adjust_fishing_difficulty, -5)

/obj/item/clothing/suit/hooded/ethereal_raincoat/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance('icons/mob/clothing/suits/ethereal.dmi', "eth_raincoat_glow_worn", offset_spokesman = src, alpha = src.alpha)

/obj/item/clothing/suit/hooded/ethereal_raincoat/update_overlays()
	. = ..()
	. += emissive_appearance('icons/obj/clothing/suits/ethereal.dmi', "eth_raincoat_glow", offset_spokesman = src, alpha = src.alpha)

/obj/item/clothing/suit/hooded/ethereal_raincoat/trailwarden
	name = "守径者油布外套"
	desc = "一件手工精制的油光外套，据说能在斯普劳特的植被中提供极佳的伪装。你能听到那发光纹路发出微弱的电流嗡鸣声。"
	icon_state = "/obj/item/clothing/suit/hooded/ethereal_raincoat/trailwarden"
	greyscale_colors = "#32a87d"
	hoodtype = /obj/item/clothing/head/hooded/ethereal_rainhood/trailwarden

/obj/item/clothing/suit/hooded/ethereal_raincoat/trailwarden/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -7)

/obj/item/clothing/suit/hooded/ethereal_raincoat/trailwarden/equipped(mob/living/user, slot)
	. = ..()
	if(isethereal(user) && (slot & ITEM_SLOT_OCLOTHING))
		var/mob/living/carbon/human/ethereal = user
		to_chat(ethereal, span_notice("当你穿上 [src] 时，它轻轻颤动了一下。"))
		set_greyscale(ethereal.dna.species.fixed_mut_color)
		ethereal.update_worn_oversuit()

/obj/item/clothing/head/hooded/ethereal_rainhood
	name = "以太人雨帽"
	desc = "可抵御太空雨。"
	icon = 'icons/obj/clothing/head/ethereal.dmi'
	icon_state = "eth_rainhood"
	worn_icon = 'icons/mob/clothing/head/ethereal.dmi'
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR

/obj/item/clothing/head/hooded/ethereal_rainhood/trailwarden

/obj/item/clothing/head/hooded/ethereal_rainhood/trailwarden/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -6)
