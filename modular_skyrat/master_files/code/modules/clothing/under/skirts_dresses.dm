/obj/item/clothing/under/dress
	body_parts_covered = CHEST|GROIN	//For reference
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY //For reference - We dont want to cut a random hole in dresses
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON	//For reference - keep in mind some dresses will need adjusted for digi thighs - hence the link below
	worn_icon_digi = SKIRTS_DRESSES_DIGIFILE
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/under/skirts_dresses_teshari.dmi'
	gets_cropped_on_taurs = FALSE
	//God bless the skirt being a subtype of the dress, only need one worn_digi_icon definition

/obj/item/clothing/under/dress/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/skirts_dresses.dmi'
	icon_state = null
	post_init_icon_state = null
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/skirts_dresses.dmi'
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/dress/skirt/skyrat	//Just so they can stay under TG's skirts in case code needs subtypes of them (also SDMM dropdown looks nicer like this)
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/skirts_dresses.dmi'
	icon_state = null
	post_init_icon_state = null
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/skirts_dresses.dmi'
	// TG gave these greyscales but ours don't get them yet
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//TG's icons only have a dress.dmi, but that means its not ABC-sorted to be beside shorts_pants_shirts.dmi. So its skirts_dresses for us.

/*
*	TG DIGI VERSION DRESSES
*/
/obj/item/clothing/under/dress/striped
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/dress/skirt/plaid
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/*
*	Skirts
*/

/obj/item/clothing/under/dress/skirt/skyrat/swept
	name = "斜摆短裙"
	desc = "正式短裙。"
	icon_state = "skirt_swept"
	body_parts_covered = GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/dress/skirt/skyrat/striped_skirt
	name = "条纹短裙"
	desc = "一条带条纹的红色侧开衩短裙！附赠相配的双色胸罩。"
	icon_state = "striped_skirt"
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/dress/skirt/skyrat/red_skirt
	name = "红色短裙"
	desc = "一条吸睛的及膝红裙，带金黄色滚边。附赠相配的双色胸罩。"
	icon_state = "red_skirt"
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/dress/skirt/skyrat/black_skirt
	name = "黑色短裙"
	desc = "一条黑色侧开衩短裙，带金黄色滚边。浑身上下都在喊“有钱哥特”。附赠一件造型古怪的相配胸罩。"
	icon_state = "black_skirt"
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/dress/skirt/skyrat/turtleskirt_knit //Essentially the same as the Turtleneck Skirt but with a different texture
	name = "绞花针织短裙"
	desc = "一条休闲的高领短裙，带有绞花针织花纹。"
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/skirt/skyrat/turtleskirt_knit"
	post_init_icon_state = "turtleskirt_knit"
	custom_price = PAYCHECK_CREW
	greyscale_config = /datum/greyscale_config/turtleskirt_knit
	greyscale_config_worn = /datum/greyscale_config/turtleskirt_knit/worn
	greyscale_colors = "#cc0000#5f5f5f"
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/dress/skirt/skyrat/jean
	name = "牛仔短裙"
	desc = "严格来说，它和牛仔短裤真有那么大区别吗？只不过是一个大洞而不是两个。那这算不算“牛裙”？"
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/skirt/skyrat/jean"
	post_init_icon_state = "jean_skirt"
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_config = /datum/greyscale_config/jean_skirt
	greyscale_config_worn = /datum/greyscale_config/jean_skirt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/jean_skirt/worn/digi
	greyscale_colors = "#787878#723E0E#4D7EAC"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = GROIN

/obj/item/clothing/under/dress/skirt/skyrat/lone_skirt
	name = "短裙"
	desc = "就是一条短裙！希望你有一件背心可以搭配。"
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/skirt/skyrat/lone_skirt"
	post_init_icon_state = "lone_skirt"
	body_parts_covered = GROIN
	greyscale_config = /datum/greyscale_config/lone_skirt
	greyscale_config_worn = /datum/greyscale_config/lone_skirt/worn
	greyscale_colors = "#5f534a"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/skirt/skyrat/medium
	name = "中长裙"
	desc = "一条迷人的中长裙。不含上衣。"
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/skirt/skyrat/medium"
	post_init_icon_state = "medium_skirt"
	body_parts_covered = GROIN
	greyscale_config = /datum/greyscale_config/medium_skirt
	greyscale_config_worn = /datum/greyscale_config/medium_skirt/worn
	greyscale_colors = "#3a3c45"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/skirt/skyrat/long
	name = "长裙"
	desc = "一条迷人的长裙。到了这个长度，它算不算连衣裙了？"
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/skirt/skyrat/long"
	post_init_icon_state = "long_skirt"
	body_parts_covered = GROIN|LEGS
	greyscale_config = /datum/greyscale_config/long_skirt
	greyscale_config_worn = /datum/greyscale_config/long_skirt/worn
	greyscale_colors = "#3a3c45"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	alternate_worn_layer = ABOVE_SHOES_LAYER
	flags_1 = IS_PLAYER_COLORABLE_1

/*
*	Dresses
*/

/obj/item/clothing/under/dress/skyrat/short_dress
	name = "短连衣裙"
	desc = "一条极短的连衣裙，配有可爱的腰带和花朵——只适合自信心十足的人。"
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/skyrat/short_dress"
	post_init_icon_state = "short_dress"
	greyscale_config = /datum/greyscale_config/short_dress
	greyscale_config_worn = /datum/greyscale_config/short_dress/worn
	greyscale_config_worn_digi = /datum/greyscale_config/short_dress/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/short_dress/worn/teshari
	greyscale_colors = "#ff3636#363030"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/dress/skyrat/pinktutu
	name = "粉色芭蕾舞裙"
	desc = "一条蓬松的粉色芭蕾舞裙。"
	icon_state = "pinktutu"

/obj/item/clothing/under/dress/skyrat/flower
	name = "花朵连衣裙"
	desc = "漂亮的连衣裙。染成秋叶一般的颜色。"
	icon_state = "flower_dress"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/under/dress/skyrat/redformal
	name = "红色礼服"
	desc = "不算太宽大飘逸，但足够醒目，能给人留下印象。"
	icon_state = "formal_red"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESHOES

/obj/item/clothing/under/dress/skyrat/countess
	name = "伯爵夫人礼服"
	desc = "一条宽大飘逸、适合伯爵夫人的礼服；走过时可能会被东西挂住。"
	icon_state = "countess"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESHOES

/obj/item/clothing/under/dress/skyrat/strapless
	name = "无肩带连衣裙"
	desc = "典型的无肩带正装，改用腰部系带固定。大概需要时不时调整一下。"
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/skyrat/strapless"
	post_init_icon_state = "dress_strapless"
	body_parts_covered = CHEST|GROIN|LEGS
	greyscale_config = /datum/greyscale_config/strapless_dress
	greyscale_config_worn = /datum/greyscale_config/strapless_dress/worn
	greyscale_colors = "#cc0000#5f5f5f"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/skyrat/pentagram
	name = "五芒星系带连衣裙"
	desc = "一条柔软的连衣裙，系带被设计成五芒星的形状。这不是违反了纳米传讯那套“宗教授权”的规定吗？"
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/skyrat/pentagram"
	post_init_icon_state = "dress_pentagram"
	body_parts_covered = CHEST|GROIN|LEGS
	greyscale_config = /datum/greyscale_config/pentagram_dress
	greyscale_config_worn = /datum/greyscale_config/pentagram_dress/worn
	greyscale_colors = "#403c46"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/skyrat/jute
	name = "雅加达连衣裙"
	desc = "一条厚实的连衣裙，外层粗糙结实，内衬是柔软透气的薄层。版型宽松，里面还有一个标签写着“雅加达制造”。"
	icon_state = "jute"
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
