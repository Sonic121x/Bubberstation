/obj/item/clothing/suit/costume/wellworn_shirt
	name = "破旧 T 恤"
	desc = "一件磨损严重、却出奇舒适的 T 恤。你不会说穿上它感觉像被拥抱，但也差不多。很适合穿着睡觉。"
	inhand_icon_state = null
	icon = 'icons/map_icons/clothing/suit/costume.dmi'
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt"
	post_init_icon_state = "wellworn_shirt"
	greyscale_config = /datum/greyscale_config/wellworn_shirt
	greyscale_config_worn = /datum/greyscale_config/wellworn_shirt/worn
	greyscale_colors = COLOR_WHITE
	species_exception = list(/datum/species/golem)
	flags_1 = IS_PLAYER_COLORABLE_1
	///How many times has this shirt been washed? (In an ideal world this is just the determinant of the transform matrix.)
	var/wash_count = 0

/obj/item/clothing/suit/costume/wellworn_shirt/machine_wash(obj/machinery/washing_machine/washer)
	. = ..()
	if(wash_count <= 5)
		transform *= TRANSFORM_USING_VARIABLE(0.8, 1)
		washer.visible_message("[src] 洗过之后似乎缩水了。")
		wash_count += 1
	else
		washer.visible_message("[src] 因反复洗涤而爆裂了。")
		qdel(src)

/obj/item/clothing/suit/costume/wellworn_shirt/skub
	name = "挺斯库布 T 恤"
	desc = "一件磨损严重、却出奇舒适的 T 恤，宣告你支持斯库布的立场。去他妈的反斯库布派。"
	greyscale_colors = "#FFFF4D"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/skub"
	post_init_icon_state = "wellworn_shirt_pro_skub"
	greyscale_config = /datum/greyscale_config/wellworn_shirt_skub
	greyscale_config_worn = /datum/greyscale_config/wellworn_shirt_skub/worn

/obj/item/clothing/suit/costume/wellworn_shirt/skub/anti
	name = "反斯库布 T 恤"
	desc = "一件磨损严重、却出奇舒适的 T 恤，宣告你反对斯库布的立场。去他妈的挺斯库布派。"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/skub/anti"
	post_init_icon_state = "wellworn_shirt_anti_skub"

/obj/item/clothing/suit/costume/wellworn_shirt/graphic
	name = "破旧图案 T 恤"
	desc = "一件磨损严重、却出奇舒适的 T 恤，正面印着《鼬鼠法尼克》中的角色。它给它自己和穿着者都添了几分魅力，也让你回想起这部系列剧还很好看的时候——远在 2500 年。"
	greyscale_colors = "#FFFFFF#46B45B"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/graphic"
	post_init_icon_state = "wellworn_shirt_gamer"
	greyscale_config = /datum/greyscale_config/wellworn_shirt_graphic
	greyscale_config_worn = /datum/greyscale_config/wellworn_shirt_graphic/worn

/obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian
	name = "破旧伊恩 T 恤"
	desc = "一件磨损严重、却出奇舒适的 T 恤，印着柯基犬伊恩的图案。你不会说穿上它感觉像被拥抱，但也差不多。很适合穿着睡觉。"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian"
	post_init_icon_state = "wellworn_shirt_ian"
	greyscale_colors = "#FFFFFF#E1B26C"

/obj/item/clothing/suit/costume/wellworn_shirt/wornout
	name = "穿旧的 T 恤"
	desc = "一件相当脏兮兮、但依然舒适的 T 恤。你穿着它睡觉的时间有点太长了。"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/wornout"
	post_init_icon_state = "wornout_shirt"

/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic
	name = "穿旧的图案 T 恤"
	desc = "一件相当脏兮兮、但依然舒适的 T 恤，正面印着《鼬鼠法尼克》中的角色。略显破破烂烂的样子让人想起那部把他变成吸血鬼的糟糕作品。你连着穿它睡了这么多天，真该给你个成就。"
	greyscale_colors = "#FFFFFF#46B45B"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic"
	post_init_icon_state = "wornout_shirt_gamer"
	greyscale_config = /datum/greyscale_config/wornout_shirt_graphic
	greyscale_config_worn = /datum/greyscale_config/wornout_shirt_graphic/worn

/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian
	name = "穿旧的伊恩 T 恤"
	desc = "一件相当脏兮兮、但依然舒适的 T 恤，印着柯基犬伊恩的照片。它已经超越了“有点旧”，变成了“备受珍爱”；非常适合当睡衣。"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian"
	post_init_icon_state = "wornout_shirt_ian"
	greyscale_colors = "#FFFFFF#E1B26C"

/obj/item/clothing/suit/costume/wellworn_shirt/messy
	name = "脏乱的旧 T 恤"
	desc = "这件穿旧却不知怎么还很舒适的 T 恤，对污垢有了更深刻的理解；也许它一直没洗过这一点，正好能当作某种迷彩？"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/messy"
	post_init_icon_state = "messyworn_shirt"

/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic
	name = "脏乱的图案 T 恤"
	desc = "这件穿旧却不知怎么还很舒适的 T 恤，对污垢有了更深刻的理解。普通人永远不会明白这是一件收藏品，而且你的时尚品味绝对碾压他们。法尼克永存。"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic"
	post_init_icon_state = "messyworn_shirt_gamer"
	greyscale_config = /datum/greyscale_config/messyworn_shirt_graphic
	greyscale_config_worn = /datum/greyscale_config/messyworn_shirt_graphic/worn
	greyscale_colors = "#FFFFFF#46B45B"

/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian
	name = "脏乱的伊恩 T 恤"
	desc = "这件穿旧却不知怎么还很舒适的 T 恤，对污垢有了更深刻的理解。你感觉自己理解了当流浪狗是什么滋味，但伊恩的脸依然能给你安慰。"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian"
	post_init_icon_state = "messyworn_shirt_ian"
	greyscale_colors = "#FFFFFF#E1B26C"

/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/gamer
	name = "玩家 T 恤"
	desc = "一件宽松、被穿了极多次的 T 恤，胸口过分张扬地印着复古游戏角色鼬鼠法尼克。你的大脑根本承受不住回忆那些你见过的法尼克同人图的冲击；更别提这件上衣的臭味了。"
