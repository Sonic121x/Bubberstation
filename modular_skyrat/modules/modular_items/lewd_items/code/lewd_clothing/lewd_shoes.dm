//heels item
/obj/item/clothing/shoes/latex_heels
	parent_type = /obj/item/clothing/shoes/jackboots //Inherits from the Jackboots
	name = "乳胶高跟鞋"
	desc = "使用前请系好鞋带。穿这种鞋走路相当困难。"
	icon_state = "latexheels"
	inhand_icon_state = null
	// We really need to find a way to condense there.
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/shoes/latex_heels/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/effects/footstep/highheel1.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel2.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel3.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel4.ogg' = 1), 70)

/obj/item/clothing/shoes/latex_heels/domina_heels
	name = "支配者高跟鞋"
	desc = "一双赏心悦目的高跟鞋。"
	icon_state = "dominaheels"

/*
*	LATEX SOCKS
*/

/obj/item/clothing/shoes/latex_socks
	name = "乳胶袜"
	desc = "一双闪闪发亮的分趾袜，由某种奇怪的材料制成。"
	icon_state = "latexsocks"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'

// Ballet Heels
/obj/item/clothing/shoes/latex_heels/ballet_heels
	name = "芭蕾高跟鞋"
	desc = "一双芭蕾舞高跟鞋。"
	icon_state = "balletheels"
