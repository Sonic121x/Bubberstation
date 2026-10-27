/obj/item/custom_kit
	name = "改装套件"
	desc = "一盒用于改装特定物品的零件。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/kits.dmi'
	icon_state = "partskit"
	/// The base object to be converted.
	var/obj/item/from_obj
	/// The object to turn it into.
	var/obj/item/to_obj

/obj/item/custom_kit/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(isturf(interacting_with)) //This shouldn't be needed, but apparently it throws runtimes otherwise.
		return NONE
	if(interacting_with.type != from_obj) //Checks whether the item is eligible to be converted
		to_chat(user, span_warning("看来这套改装件对 [interacting_with] 无效……"))
		return ITEM_INTERACT_BLOCKING
	if(!pre_convert_check(interacting_with, user))
		return ITEM_INTERACT_BLOCKING
	var/obj/item/converted_item = new to_obj
	user.visible_message(span_notice("[user] 把 [interacting_with] 改装成了 [converted_item]。"), span_notice("你把 [interacting_with] 改装成了 [converted_item]。"))
	qdel(interacting_with)
	qdel(src)
	user.put_in_hands(converted_item)
	return ITEM_INTERACT_SUCCESS

/// Override this if you have some condition you want fulfilled before allowing the conversion. Return TRUE to allow it to convert, return FALSE to prevent it.
/obj/item/custom_kit/proc/pre_convert_check(obj/target_obj, mob/user)
	return TRUE
