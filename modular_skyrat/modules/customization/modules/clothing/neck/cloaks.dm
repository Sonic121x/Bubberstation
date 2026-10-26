/obj/item/clothing/neck/chaplain
	name = "主教披风"
	desc = "成为太空教宗吧。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "bishopcloak"

/obj/item/clothing/neck/chaplain/black
	name = "黑色主教披风"
	icon_state = "blackbishopcloak"

/obj/item/clothing/neck/cloak/qm/syndie
	name = "甲板军官披风"
	desc = "一件象征永恒货运斯拉夫的披风。布料里织入了小小的莫辛-纳甘步枪徽记。"

/obj/item/clothing/neck/cowboylea
	name = "绿色牛仔披风"
	desc = "一件覆满沙尘的披风，内侧似乎绣着一个小小的鹿头，还带着鹿角。"
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cowboy_poncho"
	heat_protection = CHEST

/obj/item/clothing/neck/cowboylea/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "cowboy_poncho_t")

//This one is greyscale :)
/obj/item/clothing/neck/ranger_poncho
	name = "游侠披风"
	desc = "瞄准心脏，拉蒙。"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/ranger_poncho"
	post_init_icon_state = "ranger_poncho"
	greyscale_config = /datum/greyscale_config/ranger_poncho
	greyscale_config_worn = /datum/greyscale_config/ranger_poncho/worn
	greyscale_colors = "#917A57#858585"	//Roughly the same color as the original non-greyscale item was
	flags_1 = IS_PLAYER_COLORABLE_1
	heat_protection = CHEST

/obj/item/clothing/neck/ranger_poncho/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "ranger_poncho_t")

/obj/item/clothing/neck/robe_cape
	name = "长袍披风"
	desc = "一件舒适的北方风格披风，垂在背后，用胸针固定在颈间。让你想起某种长袍。"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/robe_cape"
	post_init_icon_state = "robe_cape"
	greyscale_config = /datum/greyscale_config/robe_cape
	greyscale_config_worn = /datum/greyscale_config/robe_cape/worn
	greyscale_colors = "#867361"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/long_cape
	name = "长披风"
	desc = "一件优雅的披风，将你的身体周全地包裹起来。"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/long_cape"
	post_init_icon_state = "long_cape"
	greyscale_config = /datum/greyscale_config/long_cape
	greyscale_config_worn = /datum/greyscale_config/long_cape/worn
	greyscale_colors = "#867361#4d433d#b2a69c#b2a69c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/long_cape/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "long_cape_t")

/obj/item/clothing/neck/wide_cape
	name = "宽披风"
	desc = "一件气派、肩部宽阔的披风，可以用来守护你背后的荣誉。"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/wide_cape"
	post_init_icon_state = "wide_cape"
	greyscale_config = /datum/greyscale_config/wide_cape
	greyscale_config_worn = /datum/greyscale_config/wide_cape/worn
	greyscale_colors = "#867361#4d433d#b2a69c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS
