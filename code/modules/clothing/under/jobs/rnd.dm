/obj/item/clothing/under/rank/rnd
	icon = 'icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'icons/mob/clothing/under/rnd.dmi'
	abstract_type = /obj/item/clothing/under/rank/rnd

/datum/armor/clothing_under/science
	bomb = 10
	bio = 40

/obj/item/clothing/under/rank/rnd/research_director
	desc = "这是那些有本事爬上“科研主管”之位的人所穿的套装。其面料能提供轻微的生化污染物防护。"
	name = "科研主管马甲套装"
	icon_state = "director"
	inhand_icon_state = "lb_suit"
	armor_type = /datum/armor/clothing_under/rnd_research_director
	can_adjust = FALSE

/datum/armor/clothing_under/rnd_research_director
	bomb = 10
	bio = 50
	acid = 35

/obj/item/clothing/under/rank/rnd/research_director/doctor_hilbert
	desc = "一件属于已故伟大的希尔伯特博士的科研主管连体服。由于希尔伯特旅馆的压力，这件衣服的传感器早已失灵。"
	has_sensor = NO_SENSORS
	random_sensor = FALSE

/obj/item/clothing/under/rank/rnd/research_director/skirt
	name = "科研主管马甲裙装"
	desc = "这是那些有本事爬上“科研主管”之位的人所穿的裙装。其面料能提供轻微的生化污染物防护。"
	icon_state = "director_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/rnd/research_director/alt
	name = "科研主管棕褐套装"
	desc = "也许有一天你也能造出自己的一半人一半猪生物。其面料能提供轻微的生化污染物防护。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	worn_icon = 'icons/mob/clothing/under/shorts_pants_shirts.dmi'
	icon_state = "/obj/item/clothing/under/rank/rnd/research_director/alt"
	post_init_icon_state = "buttondown_slacks"
	greyscale_config = /datum/greyscale_config/buttondown_slacks
	greyscale_config_worn = /datum/greyscale_config/buttondown_slacks/worn
	greyscale_colors = "#ffeeb6#c2d3da#402912#615233"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/research_director/alt/skirt
	name = "科研主管棕褐裙装"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/rnd/research_director/alt/skirt"
	post_init_icon_state = "buttondown_skirt"
	greyscale_config = /datum/greyscale_config/buttondown_skirt
	greyscale_config_worn = /datum/greyscale_config/buttondown_skirt/worn
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/rnd/research_director/turtleneck
	desc = "纳米传讯紫色的高领毛衣配黑色牛仔裤，献给品味出众的主管。"
	name = "科研主管高领毛衣"
	icon_state = "rdturtle"
	inhand_icon_state = "p_suit"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/research_director/turtleneck/skirt
	name = "科研主管高领毛衣裙"
	desc = "纳米传讯紫色的高领毛衣配黑色短裙，献给品味出众的主管。"
	icon_state = "rdturtle_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/rnd/scientist
	name = "科学家连体服"
	desc = "它由一种特殊纤维制成，能提供轻微的爆炸防护。上面的标识表明穿着者是科学家。"
	icon_state = "science"
	inhand_icon_state = "w_suit"
	armor_type = /datum/armor/clothing_under/science

/obj/item/clothing/under/rank/rnd/scientist/skirt
	name = "科学家连体裙"
	icon_state = "science_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/rnd/roboticist
	desc = "修身黑色，缝线加固；非常适合工业作业。"
	name = "机器人学家连体服"
	icon_state = "robotics"
	inhand_icon_state = null
	resistance_flags = NONE

/obj/item/clothing/under/rank/rnd/roboticist/skirt
	name = "机器人学家连体裙"
	desc = "修身黑色，缝线加固；非常适合工业作业。"
	icon_state = "robotics_skirt"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/rnd/geneticist
	name = "遗传学家连体服"
	desc = "它由一种特殊纤维制成，能提供特殊的生物危害防护。上面带有遗传学级别的条纹。"
	icon_state = "genetics"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/rnd/geneticist/skirt
	name = "遗传学家连体裙"
	icon_state = "genetics_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
