/obj/item/clothing/head/mush_helmet
	name = "蘑菇帽"
	desc = "一顶蘑菇伞盖，它还能当雨伞用！"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/mush_helmet"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/costume.dmi'
	post_init_icon_state = "mush_cap"
	worn_icon_state = "mush_cap"
	greyscale_config = /datum/greyscale_config/mushcap
	greyscale_config_worn = /datum/greyscale_config/mushcap/worn
	greyscale_colors = "#eb0c07"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/mush
	name = "蘑菇套装"
	desc = "一套蘑菇套装，偶尔能在那些较为真菌化的家伙身上看到。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "mush_male"
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	slowdown = 1
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/mush/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/mush_suit)

/datum/atom_skin/mush_suit
	abstract_type = /datum/atom_skin/mush_suit
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'

/datum/atom_skin/mush_suit/male
	preview_name = "雄性蘑菇"
	new_icon_state = "mush_male"

/datum/atom_skin/mush_suit/female
	preview_name = "雌性蘑菇"
	new_icon_state = "mush_female"

/obj/item/storage/box/hero/mushperson
	name = "蘑菇人穆希——2305 年。"
	desc = "你还记得吗？"

/obj/item/storage/box/hero/mushperson/PopulateContents()
	new /obj/item/clothing/suit/mush(src)
	new /obj/item/clothing/head/mush_helmet(src)
	new /obj/item/mushpunch(src)
