/obj/item/clothing/under/suit
	icon = 'icons/obj/clothing/under/suits.dmi'
	worn_icon = 'icons/mob/clothing/under/suits.dmi'
	can_adjust = FALSE
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS
	inhand_icon_state = null

/obj/item/clothing/under/suit/red //Also used by the Curator's suit, /obj/item/clothing/under/rank/civilian/curator
	name = "红色西装"
	desc = "一套红色西装和蓝色领带。略显正式。"
	icon_state = "red_suit"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/suit/charcoal
	name = "炭灰色西装"
	desc = "一套炭灰色西装和红色领带。非常专业。"
	icon_state = "charcoal_suit"

/obj/item/clothing/under/suit/navy
	name = "藏青色西装"
	desc = "一套藏青色西装和红色领带，专为站上最优秀的人准备。"
	icon_state = "navy_suit"

/obj/item/clothing/under/suit/burgundy
	name = "酒红色西装"
	desc = "一套酒红色西装和黑色领带。略显正式。"
	icon_state = "burgundy_suit"

/obj/item/clothing/under/suit/checkered
	name = "格子西装"
	desc = "你那身西装真不错。要是它出了什么事，那可真可惜，对吧？"
	icon_state = "checkered_suit"

/obj/item/clothing/under/suit/beige
	name = "米色西装"
	desc = "一件出色的浅色西装，该领域的专家强调，切勿将其与次一等的棕褐色西装混淆。"
	icon_state = "beige_suit"

/obj/item/clothing/under/suit/black
	name = "黑色两件套西装"
	desc = "一套黑色西装，配炭灰色长裤和红色领带。非常正式。"
	icon_state = "black_suit"

/obj/item/clothing/under/suit/black/skirt
	name = "黑色两件套西装"
	desc = "一套黑色西装，配炭灰色短裙和红色领带。非常正式。"
	icon_state = "black_suit_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/suit/white
	name = "白色西装"
	desc = "一套白色西装和外套，配蓝色衬衫。你想来硬的？好啊！"
	icon_state = "white_suit"
	inhand_icon_state = "white_suit"

/obj/item/clothing/under/suit/white/skirt
	name = "白色西装裙"
	desc = "一条白色西装裙，适合出色的主持人。"
	icon_state = "white_suit_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/suit/tan
	name = "棕褐色西装"
	desc = "一套棕褐色西装。利落而休闲。"
	icon_state = "tan_suit"
	inhand_icon_state = "tan_suit"

/obj/item/clothing/under/suit/waiter
	name = "服务员制服"
	desc = "一套非常利落的制服，带有一个专门放小费的口袋。"
	icon_state = "waiter"
	inhand_icon_state = "waiter"

/obj/item/clothing/under/suit/black_really
	name = "高管西装"
	desc = "一套正式的黑色西装，专为站上最优秀的人准备。"
	icon_state = "really_black_suit"
	inhand_icon_state = null

/obj/item/clothing/under/suit/black_really/skirt
	name = "高管西装裙"
	desc = "一条正式的黑色西装裙，专为站上最优秀的人准备。"
	icon_state = "really_black_suit_skirt"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/suit/tuxedo
	name = "燕尾服"
	desc = "一套正式的黑色燕尾服。尽显格调。"
	icon_state = "tuxedo"
	inhand_icon_state = null

/obj/item/clothing/under/suit/tuxedo/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 4) //You aren't going to fish with this are you?

/obj/item/clothing/under/suit/carpskin
	name = "鲤鱼皮西装"
	desc = "一套只用最上等鳞片制成的奢华西装，非常适合进行见不得光的交易。"
	icon_state = "carpskin_suit"
	inhand_icon_state = null
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/under/suit/carpskin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -4)
