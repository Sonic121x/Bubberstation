/obj/item/clothing/head/costume/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/costume.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	dog_fashion = null

/obj/item/clothing/head/costume/skyrat/maid
	name = "女仆发带"
	desc = "中国制造的女仆。"
	icon_state = "maid"

/obj/item/clothing/head/costume/skyrat/papakha
	name = "帕帕哈帽"
	desc = "一大团毛茸茸的毛皮，专门设计用来戴在头上。"
	icon_state = "papakha"
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/costume/skyrat/papakha/white
	icon_state = "papakha_white"

/obj/item/clothing/head/costume/skyrat/flowerpin
	name = "花朵别针"
	desc = "一枚小巧可染色的花朵别针。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/costume/skyrat/flowerpin"
	post_init_icon_state = "flowerpin"
	greyscale_config = /datum/greyscale_config/flowerpin
	greyscale_config_worn = /datum/greyscale_config/flowerpin/worn
	greyscale_colors = "#FF0000"
	flags_1 = IS_PLAYER_COLORABLE_1
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/head/costume/skyrat/en //One of the two parts of E-N's butchering
	name = "E-N 套装头套"
	icon_state = "enhead"
	supports_variations_flags = NONE

//Ushankas
//These have to be subtypes of TG's ushanka to inherit the toggleability
/obj/item/clothing/head/costume/ushanka/sec/blue
	icon_state = "/obj/item/clothing/head/costume/ushanka/sec/blue"
	greyscale_colors = "#C7B08B#3F6E9E"

//Pelts
//Not made into a subtype of /costume but stored in the same file
/obj/item/clothing/head/pelt
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/costume.dmi'
	name = "熊皮"
	desc = "一张奢华的熊皮，冬天保暖效果极佳，也可以裹着它一觉睡过整个冬天。"
	icon_state = "bearpelt_brown"
	inhand_icon_state = "cowboy_hat_brown"
	cold_protection = CHEST|HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/pelt/black
	icon_state = "bearpelt_black"
	inhand_icon_state = "cowboy_hat_black"

/obj/item/clothing/head/pelt/white
	icon_state = "bearpelt_white"
	inhand_icon_state = "cowboy_hat_white"

/obj/item/clothing/head/pelt/tiger
	name = "光亮虎皮"
	desc = "一张色彩鲜艳的虎皮，格外华丽。"
	icon_state = "tigerpelt_shiny"
	inhand_icon_state = "cowboy_hat_grey"

/obj/item/clothing/head/pelt/snow_tiger
	name = "雪虎皮"
	desc = "一张色彩不那么鲜艳的虎皮，但相当保暖。"
	icon_state = "tigerpelt_snow"
	inhand_icon_state = "cowboy_hat_white"

/obj/item/clothing/head/pelt/pink_tiger
	name = "粉虎皮"
	desc = "一张格外鲜艳的虎皮，适合想在派对上成为最耀眼之人的人。"
	icon_state = "tigerpelt_pink"
	inhand_icon_state = "cowboy_hat_red"

/obj/item/clothing/head/pelt/wolf
	name = "狼皮"
	desc = "一张毛茸茸的狼皮，作为猎人的战利品理应受到尊敬……前提是它不是买来的——那样就只有荣耀，没有功劳。"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/pelt_big.dmi'
	icon_state = "wolfpelt_brown"

/obj/item/clothing/head/pelt/wolf/black
	icon_state = "wolfpelt_gray"
	inhand_icon_state = "cowboy_hat_grey"

/obj/item/clothing/head/pelt/wolf/white
	icon_state = "wolfpelt_white"
	inhand_icon_state = "cowboy_hat_white"
//End Pelts

/obj/item/clothing/head/maid_headband
	name = "女仆发带"
	desc = "就像那些中国动画里的一样！"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/maid_headband"
	post_init_icon_state = "maid_headband"
	greyscale_config = /datum/greyscale_config/bubber_maid_headband
	greyscale_config_worn = /datum/greyscale_config/bubber_maid_headband/worn
	greyscale_colors = "#edf9ff"
	flags_1 = IS_PLAYER_COLORABLE_1
