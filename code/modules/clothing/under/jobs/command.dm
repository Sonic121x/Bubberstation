/obj/item/clothing/under/rank/captain
	desc = "一件蓝色连体服，上面的金色标记代表“舰长”军衔。"
	name = "舰长连体服"
	icon_state = "captain"
	inhand_icon_state = "b_suit"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	icon = 'icons/obj/clothing/under/captain.dmi'
	worn_icon = 'icons/mob/clothing/under/captain.dmi'
	armor_type = /datum/armor/clothing_under/rank_captain

/datum/armor/clothing_under/rank_captain
	wound = 15

/obj/item/clothing/under/rank/captain/skirt
	name = "舰长连体裙"
	desc = "一件蓝色连体裙，上面的金色标记代表“舰长”军衔。"
	icon_state = "captain_skirt"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/captain/parade
	name = "舰长礼服"
	desc = "舰长的奢华礼服，适合特殊场合穿着。"
	icon_state = "captain_parade"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/rank/captain/royal
	name = "舰长皇家制服"
	desc = "一件舰长皇家制服。适合在核袭击之中指挥你的军官们。"
	icon_state = "caproyal"
