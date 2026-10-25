/obj/item/clothing/head/costume/kitty
	name = "猫耳"
	desc = "一对猫耳。喵！"
	icon_state = "kitty"
	color = "#999999"
	clothing_traits = list(TRAIT_CAT_EMOTES_ALLOWED)
	dog_fashion = /datum/dog_fashion/head/kitty

/obj/item/clothing/head/costume/kitty/visual_equipped(mob/living/carbon/human/user, slot)
	if(ishuman(user) && (slot & ITEM_SLOT_HEAD))
		update_icon(ALL, user)
		user.update_worn_head() //Color might have been changed by update_appearance.
	return ..()

/obj/item/clothing/head/costume/kitty/update_icon(updates=ALL, mob/living/carbon/human/user)
	. = ..()
	if(ishuman(user))
		add_atom_colour(user.hair_color, FIXED_COLOUR_PRIORITY)

/obj/item/clothing/head/costume/kitty/genuine
	desc = "一对猫耳。内侧标签上写着\"纯手工制作，取材真猫。\""

/obj/item/clothing/head/costume/rabbitears
	name = "兔耳"
	desc = "戴上它只会显得你一无是处，除了增添几分媚态。"
	icon_state = "bunny"

	dog_fashion = /datum/dog_fashion/head/rabbit
