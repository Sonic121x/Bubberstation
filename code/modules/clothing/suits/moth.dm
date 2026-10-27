/obj/item/clothing/suit/mothcoat
	name = "蛾族飞行服"
	desc = "这种奇特的实用束带在蛾族舰队的船员中十分常见，它能把翅膀固定在身体上，同时不影响在狭窄舰舱内的活动。它看上去有些粗糙，却出奇地舒适。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/mothcoat"
	post_init_icon_state = "mothcoat"
	greyscale_config = /datum/greyscale_config/mothcoat
	greyscale_config_worn = /datum/greyscale_config/mothcoat/worn
	greyscale_colors = "#eaeaea"
	flags_1 = IS_PLAYER_COLORABLE_1
	flags_inv = HIDEMUTWINGS
	body_parts_covered = CHEST
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/flashlight/lantern) //lamp

/obj/item/clothing/suit/mothcoat/original
	desc = "一件来自蛾族舰队的老式飞行服。它完美体现了蛾族求生与适应的精神，却也苦涩地提醒着人们：随着故乡行星的失去与舰队的建立，他们珍爱的翅膀成了必须背负的负担，注定再也无法飞翔。"
	icon_state = "/obj/item/clothing/suit/mothcoat/original"
	greyscale_colors = "#dfa409"

/obj/item/clothing/suit/mothcoat/original/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -5)
	create_storage(storage_type = /datum/storage/pockets)

/obj/item/clothing/suit/mothcoat/winter
	name = "蛾族短披风"
	desc = "一件厚实的衣物，既保暖，又能保护珍贵的翅膀免受恶劣天气侵袭，节日期间也常有人穿。手感比看上去重得多。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/mothcoat/winter"
	post_init_icon_state = "mothcoat_winter"
	greyscale_config = /datum/greyscale_config/mothcoat_winter
	greyscale_config_worn = /datum/greyscale_config/mothcoat_winter/worn
	greyscale_colors = "#557979#795e55"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|ARMS|LEGS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
