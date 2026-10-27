/obj/item/clothing/head/chaplain/
	icon = 'icons/obj/clothing/head/chaplain.dmi'
	worn_icon = 'icons/mob/clothing/head/chaplain.dmi'

/obj/item/clothing/head/chaplain/clownmitre
	name = "洪克圣母之帽"
	desc = "当教区居民仰头欣赏你华美的主教冠时，很难注意到地板上的香蕉皮。"
	icon_state = "clownmitre"

/obj/item/clothing/head/chaplain/kippah
	name = "基帕小圆帽"
	desc = "表明你遵循犹太教的哈拉卡。遮住头顶，让灵魂更加正统派。"
	icon_state = "kippah"

/obj/item/clothing/head/chaplain/medievaljewhat
	name = "中世纪犹太帽"
	desc = "一顶看起来傻乎乎的帽子，本意是戴在空间站受压迫的宗教少数群体头上。"
	icon_state = "medievaljewhat"

/obj/item/clothing/head/chaplain/taqiyah/white
	name = "白色塔基亚帽"
	desc = "一种格外值得嘉许的表达对安拉虔诚的方式。"
	icon_state = "taqiyahwhite"

/obj/item/clothing/head/chaplain/taqiyah/white/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/small)

/obj/item/clothing/head/chaplain/taqiyah/red
	name = "红色塔基亚帽"
	desc = "一种格外值得嘉许的表达对安拉虔诚的方式。"
	icon_state = "taqiyahred"

/obj/item/clothing/head/chaplain/taqiyah/red/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/small)
