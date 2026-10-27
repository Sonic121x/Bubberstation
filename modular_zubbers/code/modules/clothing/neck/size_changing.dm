// Syntech Pendant
/obj/item/clothing/neck/syntech
	name = "标准化吊坠"
	desc = "一颗镶嵌在银金色金属中的鲜艳紫罗兰宝石。装备后，它会把使用者的体型“标准化”为经批准的工作条件所规定的身高。里面的人造紫色宝石不祥地闪烁着。"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	worn_icon_state = "pendant"
	icon_state = "pendant"

/obj/item/clothing/neck/syntech/equipped(mob/living/user, slot)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/human_target = user
		if(slot == ITEM_SLOT_NECK)

			if(human_target?.client?.prefs?.read_preference(/datum/preference/numeric/body_size) >= RESIZE_DEFAULT_SIZE)
				normalize_mob_size(human_target)

/obj/item/clothing/neck/syntech/dropped(mob/living/user, slot)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/human_target = user

		if(human_target.normalized)
			denormalize_mob_size(human_target)

// Syntech Choker
/obj/item/clothing/neck/syntech/choker
	name = "标准化颈环"
	desc = "一条光滑贴身的颈环，由银色渐变至金色。装备后，它会把使用者的体型“标准化”为经批准的工作条件所规定的身高。上面有一块嗡嗡闪烁着信息的小屏幕。"
	worn_icon_state = "collar"
	icon_state = "choker"

// Syntech Collar
/obj/item/clothing/neck/syntech/collar
	name = "标准化项圈"
	desc = "一条可爱的宠物项圈，采用鲜艳的紫色与光滑的银色进行科技化设计。装备后，它会把使用者的体型“标准化”为经批准的工作条件所规定的身高。里面的人造紫色宝石不祥地闪烁着。"
	worn_icon_state = "collar"
	icon_state = "collar"
