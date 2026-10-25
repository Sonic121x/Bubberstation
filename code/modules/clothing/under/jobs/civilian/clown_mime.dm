
/obj/item/clothing/under/rank/civilian/mime
	name = "默剧演员服装"
	desc = "颜色不太鲜艳。"
	icon_state = "mime"
	inhand_icon_state = null

/obj/item/clothing/under/rank/civilian/mime/skirt
	name = "默剧演员短裙"
	desc = "颜色不太鲜艳。"
	icon_state = "mime_skirt"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/civilian/mime/sexy
	name = "性感默剧演员服装"
	desc = "对马戏团来说相当不合适。"
	icon_state = "sexymime"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/clown
	name = "小丑服"
	desc = "<i>‘HONK！’</i>"
	icon_state = "clown"
	inhand_icon_state = "clown"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/civilian/clown/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/items/bikehorn.ogg'=1), 50, falloff_exponent = 20) //die off quick please
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 0)

/obj/item/clothing/under/rank/civilian/clown/blue
	name = "蓝色小丑服"
	desc = "<i>‘蓝色 HONK！’</i>"
	icon_state = "blueclown"
	inhand_icon_state = "blueclown"

/obj/item/clothing/under/rank/civilian/clown/green
	name = "绿色小丑服"
	desc = "<i>‘绿色 HONK！’</i>"
	icon_state = "greenclown"
	inhand_icon_state = "greenclown"

/obj/item/clothing/under/rank/civilian/clown/yellow
	name = "黄色小丑服"
	desc = "<i>‘黄色 HONK！’</i>"
	icon_state = "yellowclown"
	inhand_icon_state = "yellowclown"

/obj/item/clothing/under/rank/civilian/clown/purple
	name = "紫色小丑服"
	desc = "<i>‘紫色 HONK！’</i>"
	icon_state = "purpleclown"
	inhand_icon_state = "purpleclown"

/obj/item/clothing/under/rank/civilian/clown/orange
	name = "橙色小丑服"
	desc = "<i>‘橙色 HONK！’</i>"
	icon_state = "orangeclown"
	inhand_icon_state = "orangeclown"

/obj/item/clothing/under/rank/civilian/clown/rainbow
	name = "彩虹小丑服"
	desc = "<i>‘彩 虹 HONK！’</i>"
	icon_state = "rainbowclown"
	inhand_icon_state = "rainbowclown"

/obj/item/clothing/under/rank/civilian/clown/jester
	name = "弄臣服"
	desc = "一件欢快的衣服，很适合用来取悦你的主人，舅父大人。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/civilian/clown/jester"
	post_init_icon_state = "jester_map"
	greyscale_config = /datum/greyscale_config/jester_suit
	greyscale_config_worn = /datum/greyscale_config/jester_suit/worn
	greyscale_colors = "#00ff00#ff0000"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/rank/civilian/clown/jesteralt
	name = "弄臣服"
	desc = "一件欢快的衣服，很适合用来取悦你的主人，舅父大人。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/civilian/clown/jesteralt"
	post_init_icon_state = "jester_alt"
	greyscale_config = /datum/greyscale_config/jester_suit_alt
	greyscale_config_worn = /datum/greyscale_config/jester_suit_alt/worn
	greyscale_colors = "#E10000#E1E100"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/rank/civilian/clown/sexy
	name = "性感小丑服"
	desc = "它让你看起来 HONK 得诱人！"
	icon_state = "sexyclown"
	inhand_icon_state = null
