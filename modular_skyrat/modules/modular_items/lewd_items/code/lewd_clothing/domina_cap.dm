/obj/item/clothing/head/domina_cap
	name = "支配者便帽"
	desc = "专为某些特殊类型的检查而准备。"
	icon_state = "dominacap"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_hats.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_hats.dmi'
	supports_variations_flags = NONE

//message when equipping that thing
/obj/item/clothing/head/domina_cap/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(src == user.head)
		to_chat(user, span_purple("你感到自己的决心强了许多。"))

//message when unequipping that thing
/obj/item/clothing/head/domina_cap/dropped(mob/living/carbon/human/user)
	. = ..()
	if(src == user.head)
		to_chat(user, span_purple("BDSM 调教结束了，是吧？"))
