/datum/quirk/pineapple_liker
	name = "Ananas Affinity"
	desc = "你非常喜爱菠萝属的水果。那份甜美似乎永远都吃不够！"
	icon = FA_ICON_THUMBS_UP
	value = 0
	gain_text = span_notice("你无比渴望吃菠萝。")
	lose_text = span_notice("你对菠萝的态度似乎又变得平淡了。")
	medical_record_text = "患者表现出对菠萝病态的喜爱。"
	mail_goodies = list(/obj/item/food/pizzaslice/pineapple)

/datum/quirk/pineapple_liker/add(client/client_source)
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes |= PINEAPPLE

/datum/quirk/pineapple_liker/remove()
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
