/obj/item/syndie_glue
	name = "强力胶瓶"
	desc = "一种黑市品牌的高强度黏合剂，很少公开出售。切勿食用。"
	icon = 'modular_skyrat/master_files/icons/obj/tools.dmi'
	icon_state	= "glue"
	w_class = WEIGHT_CLASS_SMALL
	var/uses = 1


/obj/item/syndie_glue/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!uses)
		to_chat(user, span_warning("胶水瓶空了！"))
		return NONE

	var/obj/item/interacted = interacting_with
	if(iscarbon(interacting_with))
		if(interacting_with == user)
			return NONE
		var/list/equipment_list = list()
		var/mob/living/carbon/target = interacting_with
		for(var/obj/item/equipped_item as anything in target.get_visible_items())
			var/image/obj_icon = image(icon = initial(equipped_item.icon), icon_state = initial(equipped_item.icon_state))
			equipment_list[equipped_item] = obj_icon
		interacted = show_radial_menu(user, interacting_with, equipment_list, radius = 42)
		if(!isitem(interacted))
			return NONE
		interacting_with.visible_message(span_danger("[user]正试图往[interacting_with]的[interacted.name]上涂强力胶！"), \
			span_userdanger("[user]正试图往你的[interacted.name]上涂强力胶！"))
		if(!do_after(user, 5 SECONDS))
			return NONE
		interacting_with.visible_message(span_danger("[user]往[interacting_with]的[interacted.name]上涂了强力胶！"), \
						span_userdanger("[user]往你的[interacted.name]上涂了强力胶！"))
	else if(!isitem(interacted))
		return NONE

	if(HAS_TRAIT_FROM(interacted, TRAIT_NODROP, TRAIT_GLUED_ITEM))
		to_chat(user, span_warning("[interacted]已经很黏了！"))
		return ITEM_INTERACT_BLOCKING

	uses -= 1
	ADD_TRAIT(interacted, TRAIT_NODROP, TRAIT_GLUED_ITEM)
	interacted.desc += " 它看起来黏糊糊的。"
	to_chat(user, span_notice("你往[interacted.name]上涂了胶水，让它变得极其黏手！"))
	if(uses == 0)
		icon_state = "glue_used"
		name = "空强力胶瓶"
	return ITEM_INTERACT_SUCCESS
