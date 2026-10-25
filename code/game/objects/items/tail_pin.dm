/obj/item/tail_pin
	icon = 'icons/obj/poster.dmi'
	icon_state = "tailpin"
	name = "尾巴别针"
	desc = "官方出品的“给柯基贴尾巴”风格派对用具。不适合用在人身上。"
	force = 0
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 1
	custom_materials = list(/datum/material/iron= HALF_SHEET_MATERIAL_AMOUNT)
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("戳", "刺", "把尾巴贴到")
	attack_verb_simple = list("戳", "刺")
	sharpness = SHARP_POINTY
	max_integrity = 200
	layer = CORGI_ASS_PIN_LAYER
	embed_type = /datum/embedding/corgi_pin

/datum/embedding/corgi_pin
	pain_chance = 0
	jostle_pain_mult = 0
	ignore_throwspeed_threshold = TRUE

/obj/item/poster/tail_board
	name = "派对游戏海报"
	poster_type = /obj/structure/sign/poster/party_game
	icon_state = "rolled_poster"

/obj/structure/sign/poster/party_game
	name = "给柯基贴尾巴"
	desc = "规则很简单：蒙上眼睛，把尾巴贴到柯基身上。你够胆量命中目标吗？"
	icon_state = "pinningposter"
	poster_item_name = "派对游戏海报"
	poster_item_desc = "把它贴在墙上即可开始玩“给柯基贴尾巴”。"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/party_game, 32)

/obj/structure/sign/poster/party_game/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/tail_pin))//We're using the same trick that tables use for placing objects x and y onto the click location.
		return NONE

	var/x_offset = 0
	var/y_offset = 0
	if(LAZYACCESS(modifiers, ICON_X) && LAZYACCESS(modifiers, ICON_Y))
		x_offset = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(ICON_SIZE_X/2), ICON_SIZE_X/2)
		y_offset = clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(ICON_SIZE_Y/2), ICON_SIZE_Y/2)
	if(!user.transfer_item_to_turf(tool, drop_location(), x_offset, y_offset, silent = FALSE))
		return ITEM_INTERACT_BLOCKING
	return ITEM_INTERACT_SUCCESS
