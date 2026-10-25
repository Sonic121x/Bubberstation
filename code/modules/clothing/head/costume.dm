/obj/item/clothing/head/costume
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	abstract_type = /obj/item/clothing/head/costume

/obj/item/clothing/head/costume/powdered_wig
	name = "扑粉假发"
	desc = "一顶扑了粉的假发。"
	icon_state = "pwig"
	inhand_icon_state = "pwig"

/obj/item/clothing/head/costume/hasturhood
	name = "哈斯塔兜帽"
	desc = "它<i>难以言说地</i>时髦。"
	icon_state = "hasturhood"
	flags_inv = HIDEHAIR
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/syndicatefake
	name = "黑色太空头盔复制品"
	icon = 'icons/obj/clothing/head/spacehelm.dmi'
	worn_icon = 'icons/mob/clothing/head/spacehelm.dmi'
	icon_state = "syndicate-helm-black-red"
	inhand_icon_state = "syndicate-helm-black-red"
	desc = "辛迪加特工太空头盔的塑料复制品。戴上它，你看起来就像一名货真价实的杀人辛迪加特工！这只是玩具，不是为太空使用而设计的！"
	clothing_flags = SNUG_FIT | STACKABLE_HELMET_EXEMPT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/costume/cueball
	name = "白球头盔"
	desc = "一个硕大而毫无特征的白色圆球，理应戴在头上。你到底是怎么从这里面看到外面的？"
	icon_state = "cueball"
	inhand_icon_state = null
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES|HEADCOVERSMOUTH
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/costume/snowman
	name = "雪人头"
	desc = "一颗白色泡沫塑料球。多有节日气氛。"
	icon_state = "snowman_h"
	inhand_icon_state = null
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/costume/witchwig
	name = "女巫戏服假发"
	desc = "咿咿~嘿嘿嘿嘿嘿嘿嘿！"
	icon_state = "witch"
	inhand_icon_state = null
	flags_inv = HIDEHAIR

/obj/item/clothing/head/costume/maid_headband
	name = "女仆头带"
	desc = "就像那些中国动画里的一样！"
	greyscale_colors = "#494955#EEEEEE"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/costume/maid_headband"
	post_init_icon_state = "maid"
	greyscale_config = /datum/greyscale_config/maid_headband
	greyscale_config_worn = /datum/greyscale_config/maid_headband/worn
	greyscale_config_inhand_left = /datum/greyscale_config/maid_headband_inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/maid_headband_inhands_right
	inhand_icon_state = "maid"
	flags_1 = IS_PLAYER_COLORABLE_1
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/head/costume/chicken
	name = "小鸡套装头"
	desc = "咯！"
	icon_state = "chickenhead"
	inhand_icon_state = "chicken_head"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/costume/griffin
	name = "狮鹫头"
	desc = "为什么不叫“鹰头”？谁知道呢。"
	icon_state = "griffinhat"
	inhand_icon_state = null
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/costume/xenos
	name = "异形头盔"
	icon_state = "xenos"
	inhand_icon_state = "xenos_helm"
	desc = "用异形甲壳外皮制成的头盔。"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/head/costume/lobsterhat
	name = "泡沫龙虾头"
	desc = "当一切都变成螃蟹时，保护脑袋就是最好的选择。"
	icon_state = "lobster_hat"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/costume/lobsterhat/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("crustacean_replacement.json", "crustacean"))

/obj/item/clothing/head/costume/drfreezehat
	name = "冰冻博士的假发"
	desc = "给酷家伙戴的酷假发。"
	icon_state = "drfreeze_hat"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/costume/shrine_wig
	name = "巫女假发"
	desc = "时尚地净化！"
	flags_inv = HIDEHAIR //bald
	icon_state = "shrine_wig"
	inhand_icon_state = null
	worn_y_offset = 1

/obj/item/clothing/head/costume/cardborg
	name = "纸板半机械人头盔"
	desc = "用纸箱做的头盔。"
	icon_state = "cardborg_h"
	inhand_icon_state = "cardborg_h"
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	custom_materials = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT)

	dog_fashion = /datum/dog_fashion/head/cardborg

/obj/item/clothing/head/costume/cardborg/equipped(mob/living/user, slot)
	..()
	if(ishuman(user) && (slot & ITEM_SLOT_HEAD))
		var/mob/living/carbon/human/human_user = user
		if(istype(human_user.wear_suit, /obj/item/clothing/suit/costume/cardborg))
			var/obj/item/clothing/suit/costume/cardborg/suit = human_user.wear_suit
			suit.disguise(user, src)

/obj/item/clothing/head/costume/bronze
	name = "青铜帽"
	desc = "用青铜板打造的粗糙头盔。它的防护能力非常有限。"
	icon_state = "clockwork_helmet_old"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEEARS|HIDEHAIR
	armor_type = /datum/armor/costume_bronze
	custom_materials = list(/datum/material/bronze = SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/head/costume/fancy
	name = "华丽帽子"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/costume/fancy"
	post_init_icon_state = "fancy_hat"
	greyscale_config = /datum/greyscale_config/fancy_hat
	greyscale_config_worn = /datum/greyscale_config/fancy_hat/worn
	greyscale_colors = "#E3C937#782A81"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/costume/football_helmet
	name = "橄榄球头盔"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/costume/football_helmet"
	post_init_icon_state = "football_helmet"
	greyscale_config = /datum/greyscale_config/football_helmet
	greyscale_config_worn = /datum/greyscale_config/football_helmet/worn
	greyscale_colors = "#D74722"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/costume/tv_head
	name = "电视头盔"
	desc = "一件神秘头饰，由挖空的状况显示屏残骸制成。你可真是复古复古未来主义。"
	icon_state = "IPC_helmet"
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi' //Grandfathered in from the wallframe for status displays.
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES|HEADCOVERSMOUTH
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7)

/datum/armor/costume_bronze
	melee = 5
	laser = -5
	energy = -15
	bomb = 10
	fire = 20
	acid = 20

/obj/item/clothing/head/costume/irs
	name = "国税局帽子"
	desc = "即使在太空，你也躲不掉收税人。"
	icon_state = "irs_hat"
	inhand_icon_state = null

/obj/item/clothing/head/costume/tmc
	name = "失落 M.C. 头巾"
	desc = "一条系得很细的红色小头巾。"
	icon_state = "tmc_hat"
	inhand_icon_state = null

/obj/item/clothing/head/costume/deckers
	name = "德克耳机"
	desc = "一副霓虹蓝色耳机。看起来充满新未来主义风格。"
	icon_state = "decker_hat"
	inhand_icon_state = null
	equip_sound = SFX_HEADSET_EQUIP
	pickup_sound = SFX_HEADSET_PICKUP
	drop_sound = 'sound/items/handling/headset/headset_drop1.ogg'

/obj/item/clothing/head/costume/yuri
	name = "尤里信徒头盔"
	desc = "一顶奇怪的发白头盔，上面有 3 个眼孔。"
	icon_state = "yuri_helmet"
	inhand_icon_state = null
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/costume/allies
	name = "盟军头盔"
	desc = "一顶古老军盔，曾由最勇敢的战士佩戴。\
	这只是复制品，大概什么都保护不了你。"
	icon_state = "allies_helmet"
	inhand_icon_state = null

/obj/item/clothing/head/costume/hairpin
	name = "华丽发簪"
	desc = "一枚精致的发簪，通常搭配传统服饰。"
	icon_state = "hairpin_fancy"
	inhand_icon_state = "hairpin_fancy"
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/head/costume/snakeeater
	name = "奇怪的方巾"
	desc = "一条方巾。内侧似乎绣着一条小鲤鱼，还有汉字“魚”。"
	icon_state = "snake_eater"
	inhand_icon_state = null
	clothing_traits = list(TRAIT_FISH_EATER)
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/head/costume/knight
	name = "假的中世纪头盔"
	desc = "一顶经典金属头盔。只不过这一顶明显是假的……"
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	icon_state = "knight_green"
	inhand_icon_state = "knight_helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	dog_fashion = null
