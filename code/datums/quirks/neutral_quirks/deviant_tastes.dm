/datum/quirk/deviant_tastes
	name = "Deviant Tastes"
	desc = "你不喜欢大多数人爱吃的食物，却觉得他们不爱吃的东西很美味。"
	icon = FA_ICON_GRIN_TONGUE_SQUINT
	value = 0
	gain_text = span_notice("你开始渴望某种味道古怪的东西。")
	lose_text = span_notice("你又想吃正常的食物了。")
	medical_record_text = "患者表现出不同寻常的饮食偏好。"
	mail_goodies = list(/obj/item/food/urinalcake, /obj/item/food/badrecipe) // Mhhhmmm yummy

/datum/quirk/deviant_tastes/add(client/client_source)
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	var/liked_foodtypes = tongue.liked_foodtypes
	tongue.liked_foodtypes = tongue.disliked_foodtypes
	tongue.disliked_foodtypes = liked_foodtypes

/datum/quirk/deviant_tastes/remove()
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
	tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)
