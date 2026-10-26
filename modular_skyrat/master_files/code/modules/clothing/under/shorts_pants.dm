/obj/item/clothing/under/pants
	worn_icon_digi = SHORTS_PANTS_SHIRTS_DIGIFILE

/obj/item/clothing/under/shorts
	worn_icon_digi = SHORTS_PANTS_SHIRTS_DIGIFILE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION //That's right, TG, I have icons for ALL of these!! Mwahahaha!!!!

/obj/item/clothing/under/pants/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/shorts_pants_shirts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts.dmi'

/obj/item/clothing/under/shorts/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/shorts_pants_shirts.dmi'
	icon_state = "shorts"
	post_init_icon_state = null
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts.dmi'
	//Need to reset all these so our custom stuff can choose independently to be greyscale or not. TG putting these on the basetype was kinda gross.
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digi = null
	greyscale_colors = null
	flags_1 = NONE

//TG's files separate this into Shorts.dmi and Pants.dmi. We wont have as many, so both go into here.

/*
*	PANTS
*/

/obj/item/clothing/under/pants/skyrat/jeans_ripped
	name = "破洞牛仔裤"
	desc = "一条不起眼的耐磨牛仔裤，上面有好几处破口和撕裂。反叛者和穷人共同的基本裤装选择。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/skyrat/jeans_ripped"
	post_init_icon_state = "jeans_ripped"
	greyscale_config = /datum/greyscale_config/jeans_ripped //These configs are defined in the GAGS module for now; the icons and item will remain in these files.
	greyscale_config_worn = /datum/greyscale_config/jeans_ripped/worn
	greyscale_config_worn_digi = /datum/greyscale_config/jeans_ripped/worn/digi
	greyscale_colors = "#787878#723E0E#4D7EAC"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/pants/skyrat/yoga
	name = "瑜伽裤"
	desc = "透气又有弹性，最适合舒舒服服地锻炼身体！"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/skyrat/yoga"
	post_init_icon_state = "yoga_pants"
	greyscale_config = /datum/greyscale_config/yoga_pants //These configs are defined in the GAGS module for now; the icons and item will remain in these files.
	greyscale_config_worn = /datum/greyscale_config/yoga_pants/worn
	greyscale_config_worn_digi = /datum/greyscale_config/yoga_pants/worn/digi
	greyscale_colors = "#3d3d3d" //Having all the configs for a single color feels wrong. This is wrong.
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/pants/skyrat/chaps
	name = "黑色皮套裤"
	desc = "咿哈！"
	icon_state = "chaps"


/*
*	SHORTS
*/

/obj/item/clothing/under/shorts/skyrat/shorts_ripped
	name = "破洞短裤"
	desc = "一条不起眼的耐磨牛仔短裤，裤脚边缘磨破撕裂。没人会知道这是不是故意的。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/shorts/skyrat/shorts_ripped"
	post_init_icon_state = "shorts_ripped"
	greyscale_config = /datum/greyscale_config/shorts_ripped //These configs are defined in the GAGS module for now; the icons and item will remain in these files.
	greyscale_config_worn = /datum/greyscale_config/shorts_ripped/worn
	greyscale_config_worn_digi = /datum/greyscale_config/shorts_ripped/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/shorts_ripped/worn/teshari
	greyscale_colors = "#787878#723E0E#202020"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/shorts/skyrat/shortershorts
	name = "更短的短裤"
	desc = "穿上这条更短的短裤，把腿露出来吧！"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/shorts/skyrat/shortershorts"
	post_init_icon_state = "shortershorts"
	greyscale_config = /datum/greyscale_config/shortershorts
	greyscale_config_worn = /datum/greyscale_config/shortershorts/worn
	greyscale_config_worn_digi = /datum/greyscale_config/shortershorts/worn/digi
	greyscale_colors = "#787878#723E0E#202020"
	flags_1 = IS_PLAYER_COLORABLE_1

/*
*	MISC (Technically belongs in this file as a shorts/pants/shirt combo)
*	Here's hoping TG gives these their own typepath, but for now this is gonna be under/pants/skyrat. No, it's not all pants, but it's better than a whole new type
*/

/obj/item/clothing/under/pants/skyrat/kilt
	name = "可改色苏格兰短裙"
	desc = "一条苏格兰短裙配纽扣衬衫，还系着一条格纹腰带。它绝不是裙子。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/skyrat/kilt"
	post_init_icon_state = "kilt"
	greyscale_config = /datum/greyscale_config/kilt
	greyscale_config_worn = /datum/greyscale_config/kilt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/kilt/worn/digi
	greyscale_colors = "#FFFFFF#365736#d9e6e5"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/pants/skyrat/vicvest //there's no way I'm typing out a path called double_breasted 10 times over, too complex and everyone will be scared of it
	name = "纽扣衬衫配双排扣马甲"
	desc = "一件讲究的纽扣衬衫配长裤，外面还套着一件带第二排纽扣的马甲。真是过时的时尚宣言。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/skyrat/vicvest"
	post_init_icon_state = "buttondown_vicvest"
	greyscale_config = /datum/greyscale_config/buttondown_vicvest
	greyscale_config_worn = /datum/greyscale_config/buttondown_vicvest/worn
	greyscale_config_worn_digi = /datum/greyscale_config/buttondown_vicvest/worn/digi
	greyscale_colors = "#8b2c2c#222227#222227#fbc056"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
