/obj/item/taster
	name = "品尝器"
	desc = "替你品尝东西，这样你就不必亲自尝了！"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "tongue"

	w_class = WEIGHT_CLASS_TINY

	var/taste_sensitivity = 15

/obj/item/taster/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!interacting_with.reagents)
		to_chat(user, span_notice("[src]无法品尝[interacting_with]，因为它不含任何试剂。"))
	else if(interacting_with.reagents.total_volume == 0)
		to_chat(user, span_notice("[src]无法品尝[interacting_with]，因为它是空的。"))
	else
		var/message = interacting_with.reagents.generate_taste_message(user, taste_sensitivity)
		to_chat(user, span_notice("[src]在[interacting_with]中尝到了<i>[message]</i>。"))
	return user.combat_mode ? NONE : ITEM_INTERACT_SUCCESS
