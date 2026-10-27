// SynTech ring
/obj/item/clothing/gloves/ring/syntech
	name = "标准化戒指"
	desc = "一枚昂贵而闪耀的戒指，镀有金色纹饰。装备后，它会把使用者的体型“标准化”为经批准的工作条件所规定的身高。里面的人造紫色宝石不祥地闪烁着。"
	icon = 'modular_zubbers/icons/obj/clothing/gloves/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/gloves/gloves.dmi'
	worn_icon_state = "sring"
	icon_state = "ring" // No use in a unique sprite since it's just one pixel
	w_class = WEIGHT_CLASS_TINY
	body_parts_covered = 0
	strip_delay = 40

/obj/item/clothing/gloves/ring/syntech/equipped(mob/living/user, slot)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/human_target = user
		if(slot == ITEM_SLOT_GLOVES)

			if(human_target?.client?.prefs?.read_preference(/datum/preference/numeric/body_size) >= RESIZE_DEFAULT_SIZE)
				normalize_mob_size(human_target)

/obj/item/clothing/gloves/ring/syntech/dropped(mob/living/user, slot)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/human_target = user

		if(human_target.normalized)
			denormalize_mob_size(human_target)

// SynTech Wristband
/obj/item/clothing/gloves/ring/syntech/band
	name = "标准化腕带"
	desc = "一条昂贵的科技腕带，以紫色铸造并点缀着闪耀的金色。装备后，它会把使用者的体型“标准化”为经批准的工作条件所规定的身高。上面有一块嗡嗡闪烁着信息的小屏幕。"
	worn_icon_state = "syntechband"
	icon_state = "wristband"
