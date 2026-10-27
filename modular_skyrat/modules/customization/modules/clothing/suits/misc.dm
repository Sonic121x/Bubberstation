/obj/item/clothing/suit/wornshirt
	name = "旧衬衫"
	desc = "一件磨破（也许只是宽松）、莫名很舒服的 T 恤。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "wornshirt"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/dutchjacketsr
	name = "西部夹克"
	desc = "传闻中，那些尖叫着要芒果的植物学家会穿这件。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "dutchjacket"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE


/obj/item/clothing/suit/toggle/trackjacket
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "运动夹克"
	desc = "一件带蓝色条纹的黑色夹克，适合运动人士。在俄罗斯混混中也很流行。"
	icon_state = "trackjacket"
	toggle_noun = "zipper"

/obj/item/clothing/suit/frenchtrench
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "蓝色风衣"
	icon_state = "frenchtrench"
	desc = "这件外套有一种说不出的永恒感，仿佛它曾被某个浪漫的人穿过，在旅途中饱经沧桑，从追讨不义的阴谋家到旅行者……至于它怎么到了你手里？谁知道呢？"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/victoriantailcoatbutler
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "看护人燕尾服"
	desc = "你一直都是看护人。我应该知道，我一直都在这里。"
	icon_state = "victorian_tailcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/koreacoat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "东方冬季外套"
	desc = "战争让人寒冷，不只是内心，外表也一样……好在这件外套没经历过那样的苦难，实际上相当暖和！"
	icon_state = "chi_korea_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/modernwintercoatthing
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "现代冬季外套"
	desc = "暖和又舒适，内衬的毛皮似乎可以拆下来——但这件不行，有人把它缝死了，还留下了扣子！"
	icon_state = "modern_winter"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/toggle/jacket/cardigan
	name = "开衫"
	desc = "就像，半件夹克。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/cardigan"
	post_init_icon_state = "cardigan"
	greyscale_config = /datum/greyscale_config/cardigan
	greyscale_config_worn = /datum/greyscale_config/cardigan/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/jacket/cardigan/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "cardigan_t")

/obj/item/clothing/suit/discoblazer
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "迪斯科骚气西装外套"
	desc = "看起来像是有人从某种早已灭绝的迪斯科动物身上剥下了这件西装外套。背面和右袖上有一个神秘的白色长方形。"
	icon_state = "jamrock_blazer"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/kimjacket
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "浮空飞行员夹克"
	desc = "一件曾在两百周年纪念革命期间由空军穿着的夹克，内侧有相当多的口袋，大多用来放笔记本和指南针。"
	icon_state = "aerostatic_bomber_jacket"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/blackfurrich
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "昂贵黑色毛皮大衣"
	desc = "有没有想过，“我是个有钱的婊子，但我没有黑手党公主的范儿？”好吧，多亏太空中国那些工资低得可怜的奴隶劳工不知疲倦地工作，你扮成婊子的梦想已经实现了，就像许愿精灵开了家血汗工厂。"
	icon_state = "expensivecoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/brownbattlecoat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "昂贵棕色毛皮大衣"
	desc = "没有什么比这更珍贵、更神圣了，看看这毛皮内衬，多美。当你穿着这玩意穿过死灵之都时，你会在灰行者的温柔乡里陷得不能自拔。"
	icon_state = "battlecoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/brownfurrich
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "货运主管毛皮大衣"
	desc = "货运共和国——如果你是个书呆子，也可以叫货运斯拉夫——为忠诚的货运主管们运来了一件大衣。尽管有人指责它只是染黑的毛皮大衣，但它……不是，我保证！"
	icon_state = "winter_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/suit_brownfurrich

/datum/armor/suit_brownfurrich
	melee = 10
	bullet = 10

/obj/item/clothing/suit/brownfurrich/public
	name = "毛皮大衣"
	desc = "一件奢华舒适的毛皮大衣，由 100% 回收碳制成！"

/obj/item/clothing/suit/brownfurrich/white
	name = "白色毛皮大衣"
	desc = "一件奢华舒适的毛皮大衣，由 100% 回收碳制成！"
	icon_state = "winter_coat_white"

/obj/item/clothing/suit/brownfurrich/cream
	name = "奶油色毛皮大衣"
	desc = "一件奢华舒适的毛皮大衣，由 100% 回收碳制成！"
	icon_state = "winter_coat_cream"

/obj/item/clothing/suit/fallsparka
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "瀑布派克大衣"
	desc = "一件浅棕色外套，领口带有一圈浅色毛皮镶边。"
	icon_state = "fallsparka"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/modern_winter
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "现代冬季外套"
	desc = "一件舒适的现代冬季外套。"
	icon_state = "modern_winter"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/woolcoat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "羊毛大衣"
	desc = "一件由上等羊毛制成的精致大衣。"
	icon_state = "woolcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS


/obj/item/clothing/suit/gautumn
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "新美国将领外套"
	desc = "与内衬衣形成鲜明对比，这件宽大的装甲外套洁白如雪，正适合沾染血迹。"
	icon_state = "soldier"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/suit_gautumn

/datum/armor/suit_gautumn
	melee = 10
	bullet = 10
	laser = 20
	energy = 20

/obj/item/clothing/suit/autumn
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "新美国军官外套"
	desc = "与内衬衣形成鲜明对比，这件外套呈绿白色，带有些许防弹和防近战武器的保护。"
	icon_state = "autumn"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/suit_autumn

/datum/armor/suit_autumn
	melee = 10
	bullet = 10

/obj/item/clothing/suit/texas
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "白色西装外套"
	desc = "一件白色西装外套，最适合肥头大耳的石油大亨。"
	icon_state = "texas"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/cossack
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "乌克兰大衣"
	desc = "跨上你的马，戴上你那顶毛茸茸的帽子，把这件外套披到背上。"
	icon_state = "kuban_cossak"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/corgisuit/en
	name = "\improper 超级英雄 E-N 套装"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "ensuit"
	supports_variations_flags = NONE

/obj/item/clothing/suit/corgisuit/en/New()
	..()
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/corgisuit/en/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/suit/corgisuit/en/process()
	if(prob(2))
		for(var/obj/object in orange(2,src))
			if(!object.anchored && (object.obj_flags & CONDUCTS_ELECTRICITY))
				step_towards(object,src)
		for(var/mob/living/silicon/S in orange(2,src))
			if(istype(S, /mob/living/silicon/ai)) continue
			step_towards(S,src)
		for(var/datum/species/synthetic/R in orange(2,src))
			step_towards(R,src)

/obj/item/clothing/suit/trenchbrown
	name = "棕色风衣"
	desc = "一件黑色电影风格的棕色外套。如果你没在里面套一件宽松 T 恤，效果最佳。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "brtrenchcoat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/trenchblack
	name = "黑色风衣"
	desc = "一件哑光黑外套。最适合太空意大利人，或者黑白片里的警察。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "bltrenchcoat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/apron/chef/colorable_apron
	name = "围裙"
	desc = "一条基础围裙。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/apron/chef/colorable_apron"
	post_init_icon_state = "apron"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/suit/suit.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/suit/suit_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	greyscale_colors = "#ffffff"
	greyscale_config = /datum/greyscale_config/apron
	greyscale_config_worn = /datum/greyscale_config/apron/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/apron/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/apron/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/apron/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/apron/overalls
	greyscale_config_worn_digi = /datum/greyscale_config/overalls/worn/digi
	greyscale_config_worn_better_vox = /datum/greyscale_config/overalls/worn/better_vox
	greyscale_config_worn_vox = /datum/greyscale_config/overalls/worn/vox

/obj/item/clothing/suit/apron/overalls/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/flashlight,
		/obj/item/lighter,
		/obj/item/modular_computer/pda,
		/obj/item/radio,
		/obj/item/storage/bag/books,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
		/obj/item/analyzer,
		/obj/item/construction/rcd,
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag/construction,
		/obj/item/t_scanner,
	)

/obj/item/clothing/suit/warm_sweater
	name = "保暖毛衣"
	desc = "一件舒适、看起来很暖和的毛衣。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/warm_sweater"
	post_init_icon_state = "warm_sweater"
	greyscale_config = /datum/greyscale_config/warm_sweater
	greyscale_config_worn = /datum/greyscale_config/warm_sweater/worn
	greyscale_colors = "#867361"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/heart_sweater
	name = "心形毛衣"
	desc = "一件舒适、看起来很暖和的毛衣。上面还织着爱心图案，真可爱。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/heart_sweater"
	post_init_icon_state = "heart_sweater"
	greyscale_config = /datum/greyscale_config/heart_sweater
	greyscale_config_worn = /datum/greyscale_config/heart_sweater/worn
	greyscale_colors = "#867361#8f3a3a"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
