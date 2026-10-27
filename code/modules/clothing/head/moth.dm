/obj/item/clothing/head/mothcap
	name = "蛾族软帽"
	desc = "一顶带护目镜的加垫皮革帽，是蛾族舰队的制式装备。既能保暖，又能让碎屑远离那双大眼睛。"
	icon_state = "mothcap"
	icon = 'icons/obj/clothing/head/moth.dmi'
	worn_icon = 'icons/mob/clothing/head/moth.dmi'
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR|SHOWSPRITEEARS // SKYRAT EDIT CHANGE

/obj/item/clothing/head/mothcap/original
	desc = "一顶正宗的加垫皮革帽，配有放大护目镜，是蛾族舰队的制式装备。既能保暖，又能让碎屑远离那双大眼睛。"

/obj/item/clothing/head/mothcap/original/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.2, zoom_method = ZOOM_METHOD_ITEM_ACTION, item_action_type = /datum/action/item_action/hands_free/moth_googles)
	AddElement(/datum/element/adjust_fishing_difficulty, -4)
