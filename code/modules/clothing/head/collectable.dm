
//Hat Station 13

/obj/item/clothing/head/collectable
	name = "收藏帽"
	desc = "一顶稀有的收藏帽。"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = null
	abstract_type = /obj/item/clothing/head/collectable

/obj/item/clothing/head/collectable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/series, /obj/item/clothing/head/collectable, "超级无敌收藏帽系列")

/obj/item/clothing/head/collectable/petehat
	name = "超稀有皮特帽！"
	desc = "闻起来有淡淡的等离子体味。"
	icon_state = "petehat"

/obj/item/clothing/head/collectable/xenom
	name = "收藏版异形头盔！"
	desc = "嘶嘶嘶！"
	clothing_flags = SNUG_FIT
	icon_state = "xenom"

/obj/item/clothing/head/collectable/chef
	name = "收藏版厨师帽"
	desc = "一顶专为帽子收藏家准备的稀有厨师帽！"
	icon = 'icons/obj/clothing/head/utility.dmi'
	worn_icon = 'icons/mob/clothing/head/utility.dmi'
	icon_state = "chef"
	inhand_icon_state = "chefhat"
	dog_fashion = /datum/dog_fashion/head/chef

/obj/item/clothing/head/collectable/paper
	name = "收藏版纸帽"
	desc = "这顶看似普通的纸帽其实是稀有珍贵的收藏版纸帽。请远离水、火和馆长。"
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "paper"
	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/head/collectable/tophat
	name = "收藏版大礼帽"
	desc = "只有最有名望的帽子收藏家才会戴的大礼帽。"
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	icon_state = "tophat"
	inhand_icon_state = "that"

/obj/item/clothing/head/collectable/captain
	name = "收藏版船长帽"
	desc = "这顶收藏帽会让你看起来活像个真正的草包船长！"
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	icon_state = "captain"
	inhand_icon_state = null
	dog_fashion = /datum/dog_fashion/head/captain

/obj/item/clothing/head/collectable/police
	name = "收藏版警帽"
	desc = "一顶收藏版警帽。这顶帽子彰显出——你就是法律。"
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	icon_state = "policehelm"
	dog_fashion = /datum/dog_fashion/head/warden

/obj/item/clothing/head/collectable/beret
	name = "收藏版贝雷帽"
	desc = "一顶收藏版红色贝雷帽。闻起来有淡淡的大蒜味。"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret"
	post_init_icon_state = "beret"
	greyscale_config = /datum/greyscale_config/beret
	greyscale_config_worn = /datum/greyscale_config/beret/worn
	greyscale_colors = "#972A2A"
	dog_fashion = /datum/dog_fashion/head/beret
	hair_mask = /datum/hair_mask/standard_hat_middle
	flags_1 = NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/head/collectable/welding
	name = "收藏版焊接头盔"
	desc = "一顶收藏版焊接头盔。现在含铅量减少了 80%！不能用于实际焊接。戴此头盔进行焊接的一切风险由物主自行承担！"
	icon = 'icons/obj/clothing/head/utility.dmi'
	worn_icon = 'icons/mob/clothing/head/utility.dmi'
	icon_state = "welding"
	inhand_icon_state = "welding"
	lefthand_file = 'icons/mob/inhands/clothing/masks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/masks_righthand.dmi'
	clothing_flags = SNUG_FIT

/obj/item/clothing/head/collectable/slime
	name = "收藏版史莱姆帽"
	desc = "就像真正的脑蛞蝓一样！"
	icon_state = "headslime"
	inhand_icon_state = null
	clothing_flags = SNUG_FIT

/obj/item/clothing/head/collectable/flatcap
	name = "收藏版鸭舌帽"
	desc = "一顶收藏版农夫鸭舌帽！"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/flatcap"
	post_init_icon_state = "beret_flat"
	greyscale_config = /datum/greyscale_config/beret
	greyscale_config_worn = /datum/greyscale_config/beret/worn
	greyscale_colors = "#8F7654"
	inhand_icon_state = null
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/head/collectable/pirate
	name = "收藏版海盗帽"
	desc = "你会成为一位了不起的恐怖辛迪·罗伯茨！"
	icon_state = "pirate"
	inhand_icon_state = null
	dog_fashion = /datum/dog_fashion/head/pirate

/obj/item/clothing/head/collectable/pirate/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -4)

/obj/item/clothing/head/collectable/kitty
	name = "收藏版猫耳"
	desc = "这毛皮摸起来……有点太真实了。"
	icon_state = "kitty"
	inhand_icon_state = null
	dog_fashion = /datum/dog_fashion/head/kitty

/obj/item/clothing/head/collectable/rabbitears
	name = "收藏版兔耳"
	desc = "可没有兔脚那么幸运！"
	icon_state = "bunny"
	inhand_icon_state = null
	dog_fashion = /datum/dog_fashion/head/rabbit

/obj/item/clothing/head/collectable/wizard
	name = "收藏版巫师帽"
	desc = "注意：戴此帽获得的任何魔法力量纯属巧合。"
	icon = 'icons/obj/clothing/head/wizard.dmi'
	worn_icon = 'icons/mob/clothing/head/wizard.dmi'
	icon_state = "wizard"
	dog_fashion = /datum/dog_fashion/head/blue_wizard

/obj/item/clothing/head/collectable/wizard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -2)

/obj/item/clothing/head/collectable/hardhat
	name = "收藏版安全帽"
	desc = "警告！它不提供任何真正的防护，也不会发光，但它真是太漂亮了！"
	icon = 'icons/obj/clothing/head/utility.dmi'
	worn_icon = 'icons/mob/clothing/head/utility.dmi'
	clothing_flags = SNUG_FIT
	icon_state = "hardhat0_yellow"
	inhand_icon_state = null
	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/head/collectable/hos
	name = "收藏版安保主管帽"
	desc = "现在你也可以殴打囚犯、胡乱判刑、毫无理由地逮捕人了！"
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	icon_state = "hoscap"

/obj/item/clothing/head/collectable/hop
	name = "收藏版人事主管帽"
	desc = "轮到你索要成堆的文书、签名和印章，并多雇几个小丑了！请出示文件！"
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	icon_state = "hopcap"
	dog_fashion = /datum/dog_fashion/head/hop

/obj/item/clothing/head/collectable/thunderdome
	name = "收藏版雷霆竞技场头盔"
	desc = "红队加油！我是说绿队！我是说红队！不对，绿队！"
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	icon_state = "thunderdome"
	inhand_icon_state = "thunderdome_helmet"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEHAIR|HIDEHAIR

/obj/item/clothing/head/collectable/swat
	name = "收藏版特警头盔"
	desc = "那不是真血，是红漆。" //Reference to the actual description
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	icon_state = "swatsyndie"
	inhand_icon_state = "swatsyndie_helmet"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEHAIR

/obj/item/clothing/head/collectable/swat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 2)
