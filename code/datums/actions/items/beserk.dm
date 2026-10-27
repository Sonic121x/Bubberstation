/datum/action/item_action/berserk_mode
	name = "狂暴"
	desc = "短时间内提高移动速度、近战攻击速度和近战防护。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "berserk_mode"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

/datum/action/item_action/berserk_mode/do_effect(trigger_flags)
	var/obj/item/clothing/head/hooded/berserker/berserk = target
	berserk.berserk_mode(owner)
	return TRUE

/datum/action/item_action/berserk_mode/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(!istype(target, /obj/item/clothing/head/hooded/berserker))
		return FALSE

	var/obj/item/clothing/head/hooded/berserker/berserk = target
	if(berserk.berserk_active)
		if(feedback)
			to_chat(owner, span_warning("你已经处于狂暴状态！"))
		return FALSE
	if(berserk.berserk_charge < 100)
		if(feedback)
			to_chat(owner, span_warning("尚未充能完毕。"))
		return FALSE
	return TRUE
