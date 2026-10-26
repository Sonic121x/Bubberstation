/obj/item/clothing/gloves/evening
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	name = "晚宴手套"
	desc = "薄而漂亮的手套，本用于高贵的女性装束，但以“太空中国”的作风来看，这不过是为了满足某种女仆癖好。"
	icon_state = "evening"
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT

/obj/item/clothing/gloves/kim
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	name = "浮空手套"
	desc = "鲜艳的红色手套，散发着神秘的气质；可惜不适合园艺，也不适合把尸体从树上弄下来。"
	icon_state = "aerostatic_gloves"

/obj/item/clothing/gloves/military
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	name = "军用战术手套"
	desc = "为军人制造的战术手套，做得很薄，方便操作大多数枪械。"
	icon_state = "military_gloves"
	siemens_coefficient = 0.4
	strip_delay = 60
	equip_delay_other = 60
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/bracer/wraps
	name = "布质裹臂"
	desc = "布制护腕，颜色完全由穿戴者自行选择。"
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/gloves/bracer/wraps"
	post_init_icon_state = "arm_wraps"
	inhand_icon_state = "greyscale_gloves"
	greyscale_config = /datum/greyscale_config/armwraps
	greyscale_config_worn = /datum/greyscale_config/armwraps/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/gloves
	worn_icon_teshari = TESHARI_HANDS_ICON

/obj/item/clothing/gloves/maid_arm_covers
	name = "女仆臂套"
	desc = "中国制造的女仆。"
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/gloves/maid_arm_covers"
	post_init_icon_state = "maid_arm_covers"
	greyscale_config = /datum/greyscale_config/bubber_maid_arm_covers
	greyscale_config_worn = /datum/greyscale_config/bubber_maid_arm_covers/worn
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = "#7b9ab5#edf9ff"
	flags_1 = IS_PLAYER_COLORABLE_1

