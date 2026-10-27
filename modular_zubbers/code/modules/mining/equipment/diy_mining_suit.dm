/obj/item/miningsuitupgradekit
	name = "自制探险服套件"
	desc = "一套套件，包含把你自选的帽子和夹克改造成采矿服所需的部件。注意：未覆盖的肢体会保持无保护状态"
	icon = 'icons/obj/mining.dmi'
	icon_state = "retool_kit"
	var/helmet_uses = 1
	var/exosuit_uses = 1
	var/seva_kit = FALSE

/obj/item/miningsuitupgradekit/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/item/clothing/upgraded_item = interacting_with

	if(!istype(upgraded_item))
		return ITEM_INTERACT_BLOCKING
	if(!istype(upgraded_item, /obj/item/clothing/suit) && !istype(upgraded_item, /obj/item/clothing/head))
		to_chat(user, span_warning("这套工具只能用于头部和套装栏的衣物！"))
		return ITEM_INTERACT_BLOCKING
	if(istype(upgraded_item, /obj/item/clothing/suit) && exosuit_uses <= 0)
		to_chat(user, span_warning("套装部件已经用掉了！"))
		return ITEM_INTERACT_BLOCKING
	if(istype(upgraded_item, /obj/item/clothing/head) && helmet_uses <= 0)
		to_chat(user, span_warning("头盔部件已经用掉了！"))
		return ITEM_INTERACT_BLOCKING
	if(upgraded_item.get_armor_rating(MELEE) > 0)
		to_chat(user, span_warning("这件衣物已有护甲，无法改造！"))
		return ITEM_INTERACT_BLOCKING

	if(istype(upgraded_item, /obj/item/clothing/suit))
		var/obj/item/clothing/suit/upgraded_suit = upgraded_item
		upgraded_suit.allowed = GLOB.mining_suit_allowed
		upgraded_suit.flags_inv = NONE
		exosuit_uses--

	if(istype(upgraded_item, /obj/item/clothing/head))
		helmet_uses--

	if(!seva_kit)
		upgraded_item.AddComponent(/datum/component/armor_plate)

	if(seva_kit)
		upgraded_item.clothing_traits = list(TRAIT_ASHSTORM_IMMUNE)

	upgraded_item.set_armor(seva_kit ? /datum/armor/hooded_seva : /datum/armor/hooded_explorer)
	upgraded_item.min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	upgraded_item.max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	upgraded_item.resistance_flags |= FIRE_PROOF

	upgraded_item.name = "[seva_kit ? "SEVA " : "加固型"][upgraded_item.name]"

	balloon_alert(user, "[initial(upgraded_item.name)]已升级！")

	if(helmet_uses <= 0 && exosuit_uses <= 0)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/miningsuitupgradekit/click_alt(mob/user)
	if(!exosuit_uses || !helmet_uses)
		return CLICK_ACTION_BLOCKING
	seva_kit = !seva_kit
	name = "自制[seva_kit ? " SEVA " : "探险服"]套件"
	balloon_alert(user, "模式已切换！")
	return CLICK_ACTION_SUCCESS

/obj/item/miningsuitupgradekit/examine(mob/user)
	. = ..()
	if(helmet_uses)
		. += "还可用于改造 [helmet_uses] 顶帽子"
	if(exosuit_uses)
		. += "还可用于改造 [exosuit_uses] 件套装"
	if(exosuit_uses && helmet_uses)
		. += "按住 Alt 点击这套工具，可将本套件切换为[(seva_kit) ? "探险服套件" : "SEVA 套件"]"
