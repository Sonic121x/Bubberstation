/obj/item/clothing/shoes
	/// If TRUE, wearing these shoes will not override the wearer's natural barefoot/claw footstep sounds
	var/preserve_natural_footsteps = FALSE

/obj/item/clothing/shoes/wraps
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	name = "镀金绑腿"
	desc = "脚踝护具。这一副带有金色花纹。"
	icon_state = "gildedcuffs"
	preserve_natural_footsteps = TRUE

/obj/item/clothing/shoes/wraps/silver
	name = "银色绑腿"
	desc = "脚踝护具。并非真正的银制成。"
	icon_state = "silvergildedcuffs"

/obj/item/clothing/shoes/wraps/red
	name = "红色绑腿"
	desc = "脚踝护具。用这副闪亮的红色绑腿展现你的风格！"
	icon_state = "redcuffs"

/obj/item/clothing/shoes/wraps/blue
	name = "蓝色绑腿"
	desc = "脚踝护具。兄弟，稳住。"
	icon_state = "bluecuffs"

/obj/item/clothing/shoes/wraps/clear
	name = "透明绑腿"
	desc = "一种简单低调的鞋子替代品。"
	icon_state = "clearcuffs"

/obj/item/clothing/shoes/cowboyboots
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	name = "牛仔靴"
	desc = "一双标准的棕色牛仔靴。"
	icon_state = "cowboyboots"

/obj/item/clothing/shoes/cowboyboots/black
	name = "黑色牛仔靴"
	desc = "一双黑色牛仔靴，很容易刮花。"
	icon_state = "cowboyboots_black"

/obj/item/clothing/shoes/high_heels
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	name = "高跟鞋"
	desc = "一双精致的高跟鞋。并不能弥补你低于平均的身高。"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/high_heels"
	post_init_icon_state = "heels"
	greyscale_config = /datum/greyscale_config/heels
	greyscale_config_worn = /datum/greyscale_config/heels/worn
	greyscale_config_worn_digi = /datum/greyscale_config/heels/worn/digi
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/high_heels/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/effects/footstep/highheel1.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel2.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel3.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel4.ogg' = 1), 70)

/obj/item/clothing/shoes/fancy_heels
	name = "精致高跟鞋"
	desc = "一双精致的高跟鞋，穿在你脚上要小得多。"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/fancy_heels"
	post_init_icon_state = "fancyheels"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	greyscale_colors = "#FFFFFF"
	greyscale_config = /datum/greyscale_config/fancyheels
	greyscale_config_worn = /datum/greyscale_config/fancyheels/worn
	greyscale_config_worn_digi = /datum/greyscale_config/fancyheels/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/discoshoes
	name = "绿色蛇皮皮鞋"
	desc = "这些绿色鳄鱼皮鞋也许随着岁月流逝失去了一些光泽，但穿在你脚上非常合脚。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "lizardskin_shoes"

/obj/item/clothing/shoes/kimshoes
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	name = "浮空靴"
	desc = "一双棕色靴子，端正得体，随时可以出发去把尸体从树上弄下来。"
	icon_state = "aerostatic_boots"


/obj/item/clothing/shoes/jungleboots
	name = "丛林靴"
	desc = "带我去你的天堂，我想看看丛林。一双棕色的靴子。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "jungle"
	inhand_icon_state = "jackboots"
	strip_delay = 30
	equip_delay_other = 50
	resistance_flags = NONE

/obj/item/clothing/shoes/jungleboots/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/shoes)

/obj/item/clothing/shoes/jackboots/black
	name = "深色长筒靴"
	desc = "纳米传讯配发的安保战斗靴，适用于战斗场景或战斗状况。全是战斗，时刻不停。这双是全黑的。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "blackjack"

/obj/item/clothing/shoes/wraps/cloth
	name = "布质裹脚"
	desc = "像木乃伊一样缠起来的拳击胶带或绷带，如何缠绕全由穿戴者决定。"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/wraps/cloth"
	post_init_icon_state = "clothwrap"
	greyscale_config = /datum/greyscale_config/clothwraps
	greyscale_config_worn = /datum/greyscale_config/clothwraps/worn
	greyscale_config_worn_digi = /datum/greyscale_config/clothwraps/worn/digi
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/wraps/colourable
	name = "可染色裹脚"
	desc = "脚踝护具。这一副可以自定义颜色图案。"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/wraps/colourable"
	post_init_icon_state = "legwrap"
	greyscale_config = /datum/greyscale_config/legwraps
	greyscale_config_worn = /datum/greyscale_config/legwraps/worn
	greyscale_config_worn_digi = /datum/greyscale_config/legwraps/worn/digi
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/sports
	name = "运动鞋"
	desc = "为爱运动的人准备的鞋。查尔顿的巨人们迎战伊普斯维奇的泰坦们——这让双方看起来都像正常体型了。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "sportshoe"

/obj/item/clothing/shoes/jackboots/knee
	name = "及膝靴"
	desc = "一双及膝的黑色皮靴。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "kneeboots"

/obj/item/clothing/shoes/jackboots/timbs
	name = "时尚靴子"
	desc = "来自月球的新款，说唱歌手穿绝对带劲。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "timbs"

/obj/item/clothing/shoes/winterboots/christmas
	name = "红色圣诞靴"
	desc = "一双毛茸茸的红色圣诞靴！"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/winterboots/christmas"
	post_init_icon_state = "christmas_boots"
	greyscale_colors = "#cc0f0f#c4c2c2"
	greyscale_config = /datum/greyscale_config/boots/christmasboots
	greyscale_config_worn = /datum/greyscale_config/boots/christmasboots/worn
	greyscale_config_worn_digi = /datum/greyscale_config/boots/christmasboots/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/boots/christmasboots/worn/teshari
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/winterboots/christmas/green
	name = "绿色圣诞靴"
	desc = "一双毛茸茸的绿色圣诞靴！"
	icon_state = "/obj/item/clothing/shoes/winterboots/christmas/green"
	greyscale_colors = "#1a991a#c4c2c2"

/obj/item/clothing/shoes/clown_shoes/pink
	name = "粉色小丑鞋"
	desc = "一双格外粉嫩的滑稽鞋。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "pink_clown_shoes"

//Modular overide to give jackboots laces
/obj/item/clothing/shoes/jackboots
	fastening_type = SHOES_LACED

/obj/item/clothing/shoes/colorable_laceups
	name = "系带鞋"
	desc = "这些鞋似乎出厂时没有抛光，真令人伤心。"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/colorable_laceups"
	post_init_icon_state = "laceups"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/shoes/shoes.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/shoes/shoes_teshari.dmi'
	greyscale_colors = "#383631"
	greyscale_config = /datum/greyscale_config/laceup
	greyscale_config_worn = /datum/greyscale_config/laceup/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/laceup/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/laceup/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/laceup/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/colorable_sandals
	name = "凉鞋"
	desc = "有传言说，穿这双鞋配袜子会让你在好几个星区被列入禁止入内名单。"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/colorable_sandals"
	post_init_icon_state = "sandals"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/shoes/shoes.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/shoes/shoes_teshari.dmi'
	greyscale_colors = "#383631"
	greyscale_config = /datum/greyscale_config/sandals
	greyscale_config_worn = /datum/greyscale_config/sandals/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sandals/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/sandals/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/sandals/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/sandals/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/jackboots/recolorable
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/jackboots/recolorable"
	post_init_icon_state = "boots"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/shoes/shoes.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/shoes/shoes_teshari.dmi'
	greyscale_colors = "#383631"
	greyscale_config = /datum/greyscale_config/boots
	greyscale_config_worn = /datum/greyscale_config/boots/worn
	greyscale_config_worn_digi = /datum/greyscale_config/boots/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/boots/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/boots/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/boots/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1
