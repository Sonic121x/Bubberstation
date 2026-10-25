/obj/item/clothing/under/ethereal_tunic
	name = "以太人束腰外衣"
	desc = "一件穿在贴身衣外的简约无袖外衣，在黑暗中会发光！"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	worn_icon = 'icons/mob/clothing/under/ethereal.dmi'
	icon_state = "/obj/item/clothing/under/ethereal_tunic"
	post_init_icon_state = "eth_tunic"
	greyscale_colors = "#4e7cc7"
	greyscale_config = /datum/greyscale_config/eth_tunic
	greyscale_config_worn = /datum/greyscale_config/eth_tunic/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = FALSE

/obj/item/clothing/under/ethereal_tunic/Initialize(mapload)
	. = ..()
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/ethereal_tunic/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance('icons/mob/clothing/under/ethereal.dmi', "eth_tunic_emissive", offset_spokesman = src, alpha = src.alpha)

/obj/item/clothing/under/ethereal_tunic/update_overlays()
	. = ..()
	. += emissive_appearance('icons/obj/clothing/under/ethereal.dmi', "eth_tunic_emissive", offset_spokesman = src, alpha = src.alpha)

/obj/item/clothing/under/ethereal_tunic/trailwarden
	name = "守径者外衣"
	desc = "农夫与朝圣者常会发现，多年涉行于斯普劳特的泥泞与发光植物之间，衣物会被永久染色；久而久之，特意将衣物染成这种效果便成了习俗。"
	icon_state = "/obj/item/clothing/under/ethereal_tunic/trailwarden"
	greyscale_colors = "#32a87d"

/obj/item/clothing/under/ethereal_tunic/trailwarden/equipped(mob/living/user, slot)
	. = ..()
	if(isethereal(user) && (slot & ITEM_SLOT_ICLOTHING))
		var/mob/living/carbon/human/ethereal = user
		to_chat(ethereal, span_notice("[src] 在你穿上时轻轻颤动了一下。"))
		set_greyscale(ethereal.dna.species.fixed_mut_color)
		ethereal.update_worn_undersuit()
