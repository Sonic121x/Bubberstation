/obj/item/clothing/accessory/syntech
	name = "标准化安全别针"
	desc = "一枚出奇沉重的别针，由银金色金属铸成，镶着一颗小小的宝石。将它别在衣物上后，它会把佩戴者的体型“标准化”为经批准的工作条件所规定的身高，同时让你意识到它是为了你身边的人……以及家具的安全而设计的。"
	icon = 'modular_zubbers/icons/obj/clothing/accessories.dmi'
	icon_state = "normalizer"
	worn_icon = "modular_zubbers/icons/mob/clothing/accessories.dmi"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF
	attachment_slot = NONE

/obj/item/clothing/accessory/syntech/accessory_equipped(obj/item/clothing/under/clothes, mob/living/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_target = user
	if(human_target.client?.prefs?.read_preference(/datum/preference/numeric/body_size) >= RESIZE_DEFAULT_SIZE)
		normalize_mob_size(human_target)

/obj/item/clothing/accessory/syntech/accessory_dropped(obj/item/clothing/under/clothes, mob/living/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_target = user
	if(human_target.normalized)
		denormalize_mob_size(human_target)
