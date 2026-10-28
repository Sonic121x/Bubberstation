/obj/item/clothing/under/rank/lace
	name = "丁香紫连衣裙"
	desc = "一件高品质蕾丝连衣裙，点缀着白色与丁香紫，拿在手里让你觉得自己不配拥有它。"
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "lilacdress"
	inhand_icon_state = "lilacdress"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	can_adjust = FALSE

/obj/item/clothing/shoes/heels/drag/lace
	name = "优雅高跟鞋"
	desc = "一双优质高跟鞋，在光线下泛着精致的光泽，穿上它能为你平添几分女性魅力。"
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "lilacheels"
	inhand_icon_state = "lilacheels"

/obj/item/clothing/shoes/heels/drag/lace/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/effects/footstep/highheel1.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel2.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel3.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel4.ogg' = 1), 70)

/obj/item/clothing/gloves/evening/lace
	name = "蕾丝手套"
	desc = "一副蕾丝手套，精致的织物向下延伸，恰好覆住手背。"
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "lacygloves"
	inhand_icon_state = "lacygloves"

/obj/item/clothing/neck/lace_collar
	name = "心形颈环"
	desc = "一条精致的颈环，正面缀着一颗银色心形饰物。"
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "heartchoker"
	inhand_icon_state = "heartchoker"

/obj/item/clothing/glasses/trickblindfold/lace
	name = "丝绸眼罩"
	desc = "一条用黑色丝绸制成的眼罩，触感十分舒适。"
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "fold"
	inhand_icon_state = "fold"

/obj/item/clothing/head/costume/hairbow
	name = "蝴蝶结发饰"
	desc = "一枚精巧的蝴蝶结发饰，轻巧地别在发间。它微微倾斜，只为把可爱值拉满。"
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "whitebow"
	inhand_icon_state = "whitebow"

/obj/item/clothing/suit/cloak/shawl
	name = "丝绸披肩"
	desc = "一条精致的丝绸披肩，本该搭在手肘上，面料柔软得令人愉悦。"
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "shawl"
	inhand_icon_state = "shawl"
	body_parts_covered = CHEST|ARMS
	supports_variations_flags = NONE
