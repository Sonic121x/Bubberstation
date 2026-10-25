/datum/quirk/pineapple_hater
	name = "Ananas Aversion"
	desc = "你极度厌恶菠萝属的水果。说真的，怎么会有人觉得这东西好吃？又是哪个疯子竟敢把它放在披萨上！？"
	icon = FA_ICON_THUMBS_DOWN
	value = 0
	gain_text = span_notice("你开始琢磨，到底是什么样的傻子会喜欢吃菠萝……")
	lose_text = span_notice("你对菠萝的态度似乎又变得平淡了。")
	medical_record_text = "患者认为菠萝很恶心，这是正确的。"
	mail_goodies = list( // basic pizza slices
		/obj/item/food/pizzaslice/margherita,
		/obj/item/food/pizzaslice/meat,
		/obj/item/food/pizzaslice/mushroom,
		/obj/item/food/pizzaslice/vegetable,
		/obj/item/food/pizzaslice/sassysage,
	)

/datum/quirk/pineapple_hater/add(client/client_source)
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.disliked_foodtypes |= PINEAPPLE

/datum/quirk/pineapple_hater/remove()
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)
