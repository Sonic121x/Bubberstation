/obj/item/prescription_lenses
	name = "备用镜片套件"
	desc = "装有备用矫正镜片的小工具箱，备齐了更换眼镜旧镜片所需的工具。"
	icon = 'modular_zubbers/icons/obj/items_and_weapons.dmi'
	icon_state = "prescriptionkit"

/obj/item/prescription_lenses/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/item/clothing/glasses))
		to_chat(user, span_warning("这不是眼镜！"))
		return ITEM_INTERACT_SKIP_TO_ATTACK

	var/obj/item/clothing/glasses = interacting_with
	if(TRAIT_NEARSIGHTED_CORRECTED in glasses.clothing_traits)
		to_chat(user, span_warning("这副眼镜已经装有矫正镜片！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你更换了[interacting_with]的镜片。"))
	glasses.attach_clothing_traits(TRAIT_NEARSIGHTED_CORRECTED)
	glasses.name = "矫正型[glasses.name]"
	glasses.desc += " 这副眼镜似乎装有矫正镜片。"
	qdel(src)
	return ITEM_INTERACT_SUCCESS
