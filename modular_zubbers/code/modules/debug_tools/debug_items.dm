/obj/item/clothing/glasses/debug/architector_glasses
	name = "建筑师眼镜"
	desc = "配备多种特殊功能的高科技眼镜。"
	icon_state = "sun"
	inhand_icon_state = "sunglasses"
	resistance_flags = INDESTRUCTIBLE

	actions_types = list(
		/datum/action/cooldown/fly,
		/datum/action/cooldown/noclip,
		/datum/action/item_action/chameleon/change/glasses/no_preset
	)
