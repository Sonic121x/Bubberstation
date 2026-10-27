/obj/item/clothing/under/syndicate
	name = "战术高领衫"
	desc = "一件毫不起眼、又略显可疑的高领衫，配数码迷彩工装裤。"
	icon_state = "syndicate"
	inhand_icon_state = "bl_suit"
	has_sensor = NO_SENSORS
	armor_type = /datum/armor/clothing_under/syndicate
	alt_covers_chest = TRUE
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'icons/mob/clothing/under/syndicate.dmi'

/datum/armor/clothing_under/syndicate
	melee = 10
	fire = 50
	acid = 40
	wound = 10

/obj/item/clothing/under/syndicate/skirt
	name = "战术高领短裙"
	desc = "一件毫不起眼、又略显可疑的高领短裙。"
	icon_state = "syndicate_skirt"
	inhand_icon_state = "bl_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/syndicate/bloodred
	name = "血红色潜行服"
	desc = "只要没有目击者，那依然算潜行。"
	icon_state = "bloodred_pajamas"
	inhand_icon_state = "bl_suit"
	armor_type = /datum/armor/clothing_under/syndicate_bloodred
	resistance_flags = FIRE_PROOF | ACID_PROOF
	can_adjust = FALSE
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/syndicate/bloodred/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -4) //extra-tactical

/datum/armor/clothing_under/syndicate_bloodred
	melee = 10
	bullet = 10
	laser = 10
	energy = 10
	fire = 50
	acid = 40
	wound = 10

/obj/item/clothing/under/syndicate/bloodred/sleepytime
	name = "血红色睡衣"
	desc = "特工会梦见核绵羊吗？"
	icon_state = "bloodred_pajamas"
	inhand_icon_state = "bl_suit"
	armor_type = /datum/armor/clothing_under/bloodred_sleepytime

/datum/armor/clothing_under/bloodred_sleepytime
	fire = 50
	acid = 40

/obj/item/clothing/under/syndicate/tacticool
	name = "战术潮高领衫"
	desc = "光是看着它，你就想买一把 SKS，钻进树林里——展开行动——。"
	icon_state = "tactifool"
	inhand_icon_state = "bl_suit"
	has_sensor = HAS_SENSORS
	armor_type = /datum/armor/clothing_under/syndicate_tacticool
	stubborn_stains = TRUE

/datum/armor/clothing_under/syndicate_tacticool
	fire = 50
	acid = 40

/obj/item/clothing/under/syndicate/tacticool/examine(mob/user)
	. = ..()
	. += "它有个标签，上面写着：若使用“污垢解放者”传送舱晶体以外的清洁剂清洗这件“正牌”华夫公司产品，将使保修失效。"
	. += "到底什么是<font color='red'>传送</font>舱<font color='red'>晶体</font>？"

/obj/item/clothing/under/syndicate/tacticool/dye_item(dye_color, dye_key_override)
	if(dye_color == DYE_SYNDICATE)
		if(dying_key == DYE_REGISTRY_JUMPSKIRT)
			special_wash(/obj/item/clothing/under/syndicate/skirt)
		else
			special_wash(/obj/item/clothing/under/syndicate)
		qdel(src)
		return
	return ..()

/obj/item/clothing/under/syndicate/tacticool/proc/special_wash(obj/item/clothing/under/syndicate/our_jumpsuit)
	new our_jumpsuit(loc)

/obj/item/clothing/under/syndicate/tacticool/skirt
	name = "战术潮高领短裙"
	desc = "光是看着它，你就想买一把 SKS，钻进树林里——展开行动——。"
	icon_state = "tactifool_skirt"
	inhand_icon_state = "bl_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/syndicate/sniper
	name = "战术高领套装"
	desc = "一件双缝线战术高领衫，伪装成民用级丝绸西装。专为最讲究礼仪的特工打造。衣领真的很锋利。"
	icon_state = "tactical_suit"
	inhand_icon_state = "bl_suit"
	can_adjust = FALSE
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/syndicate/camo
	name = "迷彩作战服"
	desc = "一套绿色军用迷彩制服。"
	icon_state = "camogreen"
	inhand_icon_state = "g_suit"
	can_adjust = FALSE
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/syndicate/cybersun
	name = "\improper Cybersun 商务装"
	desc = "这套黑橙配色的商务装似乎由某种轻质防护材料制成。 \
		非常适合恶意收购和预算会议。"
	icon_state = "cybersun_suit"
	inhand_icon_state = "bl_suit"
	can_adjust = FALSE
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/syndicate/floortilecamo
	name = "地板砖迷彩作战服"
	desc = "用于走廊战的最新款地板砖迷彩作战服。 \
		最佳透气性、灵活性与舒适度。由 Camo-J's 设计。"
	icon_state = "camofloortile"
	inhand_icon_state = "gy_suit"
	can_adjust = FALSE
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/syndicate/floortilecamo/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -5) //tacticool

/obj/item/clothing/under/syndicate/soviet
	name = "拉特尼克 5 号运动服"
	desc = "翻译糟糕的标签让你用伏特加清洗它。非常适合蹲着。"
	icon_state = "trackpants"
	can_adjust = FALSE
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE
	armor_type = /datum/armor/clothing_under/syndicate_soviet
	resistance_flags = NONE

/datum/armor/clothing_under/syndicate_soviet
	melee = 10

/obj/item/clothing/under/syndicate/combat
	name = "作战制服"
	desc = "配有这么多口袋的制服，你已经准备好展开行动了。"
	icon_state = "syndicate_combat"
	can_adjust = FALSE
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/syndicate/rus_army
	name = "高级军用运动服"
	desc = "军用级运动服，专为前线蹲姿而生。"
	icon_state = "rus_under"
	can_adjust = FALSE
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE
	armor_type = /datum/armor/clothing_under/syndicate_rus_army
	resistance_flags = NONE

/datum/armor/clothing_under/syndicate_rus_army
	melee = 5

/obj/item/clothing/under/syndicate/scrubs
	name = "战术手术服"
	desc = "一套深酒红色手术服，出于战术原因而战术化制作。"
	icon = 'icons/obj/clothing/under/medical.dmi'
	worn_icon = 'icons/mob/clothing/under/medical.dmi'
	icon_state = "scrubswine"
	can_adjust = FALSE
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE
	armor_type = /datum/armor/clothing_under/syndicate_scrubs

/obj/item/clothing/under/syndicate/scrubs/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/datum/armor/clothing_under/syndicate_scrubs
	melee = 10
	bio = 50
	fire = 50
	acid = 40

/obj/item/clothing/under/plasmaman/syndicate
	name = "战术潮环境服"
	desc = "一件看起来阴森的环境服，为最骨感的特工打造。"
	icon_state = "syndie_envirosuit"
	has_sensor = NO_SENSORS
	resistance_flags = FIRE_PROOF
	inhand_icon_state = null
