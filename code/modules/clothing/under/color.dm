/obj/item/clothing/under/color
	name = "连体服"
	desc = "标准配发的彩色连体服。丰富多彩才是生活的调味剂！"
	icon = 'icons/map_icons/clothing/under/color.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	inhand_icon_state = "jumpsuit"
	worn_icon_state = "jumpsuit"
	worn_icon = 'icons/mob/clothing/under/color.dmi'
	dying_key = DYE_REGISTRY_UNDER
	greyscale_colors = "#3f3f3f"
	greyscale_config = /datum/greyscale_config/jumpsuit
	greyscale_config_worn = /datum/greyscale_config/jumpsuit/worn
	greyscale_config_inhand_left = /datum/greyscale_config/jumpsuit/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/jumpsuit/inhand_right
	greyscale_config_worn_digi = /datum/greyscale_config/jumpsuit/worn/digi //SKYRAT EDIT ADDITION - DigiGreyscale
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/color/jumpskirt
	icon_state = "/obj/item/clothing/under/color/jumpskirt"
	post_init_icon_state = "jumpskirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	greyscale_config_worn_digi = null //SKYRAT EDIT ADDITION - DigiGreyscale

/// Returns a random, acceptable jumpsuit typepath
/proc/get_random_jumpsuit()
	return pick(
		subtypesof(/obj/item/clothing/under/color) \
			- typesof(/obj/item/clothing/under/color/jumpskirt) \
			- /obj/item/clothing/under/color/random \
			- /obj/item/clothing/under/color/grey/ancient \
			- /obj/item/clothing/under/color/black/ghost \
			- /obj/item/clothing/under/rank/prisoner \
	)

/obj/item/clothing/under/color/random
	icon = 'icons/obj/clothing/under/color.dmi'
	icon_state = "random_jumpsuit"
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/under/color/random/Initialize(mapload)
	..()
	var/obj/item/clothing/under/color/C = get_random_variant() // SKYRAT EDIT CHANGE - use local proc that handles prefs
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.equip_to_slot_or_del(new C(H), ITEM_SLOT_ICLOTHING, initial=TRUE) //or else you end up with naked assistants running around everywhere...
	else
		new C(loc)
	return INITIALIZE_HINT_QDEL

/// Returns a random, acceptable jumpskirt typepath
/proc/get_random_jumpskirt()
	return pick(
		subtypesof(/obj/item/clothing/under/color/jumpskirt) \
			- /obj/item/clothing/under/color/jumpskirt/random \
			- /obj/item/clothing/under/rank/prisoner/skirt \
	)

/obj/item/clothing/under/color/jumpskirt/random
	icon = 'icons/obj/clothing/under/color.dmi'
	icon_state = "random_jumpsuit" //Skirt variant needed
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/under/color/jumpskirt/random/Initialize(mapload)
	..()
	var/obj/item/clothing/under/color/jumpskirt/C = get_random_jumpskirt()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.equip_to_slot_or_del(new C(H), ITEM_SLOT_ICLOTHING, initial=TRUE)
	else
		new C(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/clothing/under/color/black
	name = "黑色连体服"
	resistance_flags = NONE
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/under/color/jumpskirt/black
	name = "黑色连体裙"
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/under/color/black/ghost
	item_flags = DROPDEL

/obj/item/clothing/under/color/black/ghost/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)

/obj/item/clothing/under/color/grey
	name = "灰色连体服"
	desc = "一件很有品味的灰色连体服，让你想起过去的美好时光。"
	icon_state = "/obj/item/clothing/under/color/grey"
	greyscale_colors = "#b3b3b3"

/obj/item/clothing/under/color/jumpskirt/grey
	name = "灰色连体裙"
	desc = "一件很有品味的灰色连体裙，让你想起过去的美好时光。"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/grey"
	greyscale_colors = "#b3b3b3"

/obj/item/clothing/under/color/grey/ancient
	name = "古老连体服"
	desc = "一件破旧不堪、磨损严重的灰色连体服。看起来已经十多年没洗过了。"
	icon = 'icons/obj/clothing/under/color.dmi'
	icon_state = "grey_ancient"
	post_init_icon_state = null
	inhand_icon_state = "gy_suit"
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	can_adjust = FALSE

/obj/item/clothing/under/color/blue
	name = "蓝色连体服"
	icon_state = "/obj/item/clothing/under/color/blue"
	greyscale_colors = "#52aecc"

/obj/item/clothing/under/color/jumpskirt/blue
	name = "蓝色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/blue"
	greyscale_colors = "#52aecc"

/obj/item/clothing/under/color/green
	name = "绿色连体服"
	icon_state = "/obj/item/clothing/under/color/green"
	greyscale_colors = "#9ed63a"

/obj/item/clothing/under/color/jumpskirt/green
	name = "绿色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/green"
	greyscale_colors = "#9ed63a"

/obj/item/clothing/under/color/orange
	name = "橙色连体服"
	desc = "别在多疑的安保人员附近穿这个。"
	icon_state = "/obj/item/clothing/under/color/orange"
	greyscale_colors = "#ff8c19"

/obj/item/clothing/under/color/jumpskirt/orange
	name = "橙色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/orange"
	greyscale_colors = "#ff8c19"

/obj/item/clothing/under/color/pink
	name = "粉色连体服"
	desc = "光是看着它，就让你觉得自己<i>美极了</i>。"
	icon_state = "/obj/item/clothing/under/color/pink"
	greyscale_colors = "#ffa69b"

/obj/item/clothing/under/color/jumpskirt/pink
	name = "粉色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/pink"
	greyscale_colors = "#ffa69b"

/obj/item/clothing/under/color/red
	name = "红色连体服"
	icon_state = "/obj/item/clothing/under/color/red"
	greyscale_colors = "#eb0c07"

/obj/item/clothing/under/color/jumpskirt/red
	name = "红色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/red"
	greyscale_colors = "#eb0c07"

/obj/item/clothing/under/color/white
	name = "白色连体服"
	icon_state = "/obj/item/clothing/under/color/white"
	greyscale_colors = "#ffffff"

/obj/item/clothing/under/color/jumpskirt/white
	name = "白色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/white"
	greyscale_colors = "#ffffff"

/obj/item/clothing/under/color/yellow
	name = "黄色连体服"
	icon_state = "/obj/item/clothing/under/color/yellow"
	greyscale_colors = "#ffe14d"

/obj/item/clothing/under/color/jumpskirt/yellow
	name = "黄色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/yellow"
	greyscale_colors = "#ffe14d"

/obj/item/clothing/under/color/darkblue
	name = "深蓝色连体服"
	icon_state = "/obj/item/clothing/under/color/darkblue"
	greyscale_colors = "#3285ba"

/obj/item/clothing/under/color/jumpskirt/darkblue
	name = "深蓝色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/darkblue"
	greyscale_colors = "#3285ba"

/obj/item/clothing/under/color/teal
	name = "青绿色连体服"
	icon_state = "/obj/item/clothing/under/color/teal"
	greyscale_colors = "#77f3b7"

/obj/item/clothing/under/color/jumpskirt/teal
	name = "青绿色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/teal"
	greyscale_colors = "#77f3b7"

/obj/item/clothing/under/color/lightpurple
	name = "浅紫色连体服"
	icon_state = "/obj/item/clothing/under/color/lightpurple"
	greyscale_colors = "#9f70cc"

/obj/item/clothing/under/color/jumpskirt/lightpurple
	name = "浅紫色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/lightpurple"
	greyscale_colors = "#9f70cc"

/obj/item/clothing/under/color/darkgreen
	name = "深绿色连体服"
	icon_state = "/obj/item/clothing/under/color/darkgreen"
	greyscale_colors = "#6fbc22"

/obj/item/clothing/under/color/jumpskirt/darkgreen
	name = "深绿色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/darkgreen"
	greyscale_colors = "#6fbc22"

/obj/item/clothing/under/color/lightbrown
	name = "浅棕色连体服"
	icon_state = "/obj/item/clothing/under/color/lightbrown"
	greyscale_colors = "#c59431"

/obj/item/clothing/under/color/jumpskirt/lightbrown
	name = "浅棕色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/lightbrown"
	greyscale_colors = "#c59431"

/obj/item/clothing/under/color/brown
	name = "棕色连体服"
	icon_state = "/obj/item/clothing/under/color/brown"
	greyscale_colors = "#a17229"

/obj/item/clothing/under/color/jumpskirt/brown
	name = "棕色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/brown"
	greyscale_colors = "#a17229"

/obj/item/clothing/under/color/maroon
	name = "褐红色连体服"
	icon_state = "/obj/item/clothing/under/color/maroon"
	greyscale_colors = "#cc295f"

/obj/item/clothing/under/color/jumpskirt/maroon
	name = "褐红色连体裙"
	icon_state = "/obj/item/clothing/under/color/jumpskirt/maroon"
	greyscale_colors = "#cc295f"

/obj/item/clothing/under/color/rainbow
	name = "彩虹连体服"
	desc = "一件多彩的连体服！"
	icon = 'icons/obj/clothing/under/color.dmi'
	icon_state = "rainbow"
	post_init_icon_state = null
	inhand_icon_state = "rainbow"
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	can_adjust = FALSE
	flags_1 = NONE

/obj/item/clothing/under/color/rainbow/get_general_color(icon/base_icon)
	return "#3f3f3f"

/obj/item/clothing/under/color/jumpskirt/rainbow
	name = "彩虹连体裙"
	desc = "一件多彩的连体裙！"
	icon = 'icons/obj/clothing/under/color.dmi'
	icon_state = "rainbow_skirt"
	post_init_icon_state = null
	inhand_icon_state = "rainbow"
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	can_adjust = FALSE
	flags_1 = NONE
