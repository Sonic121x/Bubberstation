/obj/item/clothing/suit/straight_jacket/latex_straight_jacket
	name = "乳胶拘束衣"
	desc = "一件实际上无法真正拘束任何人的玩具。穿起来还是很有趣！"
	inhand_icon_state = "latex_straight_jacket"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_suits.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-hoof.dmi'
	icon_state = "latex_straight_jacket"
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	body_parts_covered = CHEST | GROIN | LEGS | ARMS | HANDS
	flags_inv = HIDEGLOVES | HIDESHOES | HIDEJUMPSUIT | HIDETAIL
	equip_delay_self = NONE
	strip_delay = 12 SECONDS
	breakouttime = 1 SECONDS

/obj/item/clothing/suit/straight_jacket/latex_straight_jacket/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_DANGEROUS_EQUIP, INNATE_TRAIT)

/obj/item/clothing/suit/straight_jacket/latex_straight_jacket/attackby(obj/item/attacking_item, mob/user, params) //That part allows reinforcing this item with normal straightjacket
	if(!istype(attacking_item, /obj/item/clothing/suit/straight_jacket))
		return ..()
	var/obj/item/clothing/suit/straight_jacket/latex_straight_jacket/reinforced/reinforced_jacket = new()
	remove_item_from_storage(user)
	user.put_in_hands(reinforced_jacket)
	to_chat(user, span_notice("你用 [attacking_item] 加固了 [src] 上的束带。"))
	qdel(attacking_item)
	qdel(src)

/obj/item/clothing/suit/straight_jacket/latex_straight_jacket/reinforced
	name = "乳胶拘束衣"
	desc = "一件能完全拘束穿戴者的服装——而且相当令人性奋。"
	icon_state = "latex_straight_jacket"
	inhand_icon_state = "latex_straight_jacket"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_suits.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-hoof.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	body_parts_covered = CHEST | GROIN | LEGS | ARMS | HANDS
	flags_inv = HIDEGLOVES | HIDESHOES | HIDEJUMPSUIT | HIDETAIL
	equip_delay_self = NONE
	strip_delay = 12 SECONDS
	breakouttime = 300 SECONDS
