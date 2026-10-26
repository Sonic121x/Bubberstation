#define TIGHT_SLOWDOWN 2

/obj/item/clothing/suit/corset
	name = "束腰"
	desc = "一件紧身乳胶束腰。怎么可能有人穿得进这种东西？"
	icon_state = "corset"
	inhand_icon_state = null
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_suits.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-hoof.dmi'
	body_parts_covered = CHEST
	slowdown = 1 // You can't run with that thing literally squeezing your chest

	/// Has it been laced tightly?
	var/laced_tight = FALSE

/obj/item/clothing/suit/corset/click_alt(mob/user)
	laced_tight = !laced_tight
	to_chat(user, span_notice("你[laced_tight ? "收紧" : "放松"]了束腰，呼吸因此变得[laced_tight ? "困难" : "轻松"]多了。"))
	conditional_pref_sound(user, laced_tight ? get_sfx(SFX_CLOTH_PICKUP) : get_sfx(SFX_CLOTH_DROP), 40, TRUE)
	. = CLICK_ACTION_SUCCESS
	if(laced_tight)
		slowdown = TIGHT_SLOWDOWN
		return
	slowdown = initial(slowdown)

/obj/item/clothing/suit/corset/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(laced_tight && src == user.wear_suit)
		to_chat(user, span_purple("束腰紧紧勒住你的肋骨！呼吸一下子变得困难了许多。"))

/obj/item/clothing/suit/corset/dropped(mob/living/carbon/human/user)
	. = ..()
	if(laced_tight && src == user.wear_suit)
		to_chat(user, span_purple("呼。现在你可以正常呼吸了。"))

#undef TIGHT_SLOWDOWN
