/obj/item/clothing/under/rank/centcom
	icon = 'icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'icons/mob/clothing/under/centcom.dmi'
	abstract_type = /obj/item/clothing/under/rank/centcom

/obj/item/clothing/under/rank/centcom/commander
	name = "\improper 中央指挥部指挥官制服"
	desc = "这是中央指挥部最高阶指挥官所穿的制服。"
	icon_state = "centcom"
	inhand_icon_state = "dg_suit"

/obj/item/clothing/under/rank/centcom/official
	name = "\improper 中央指挥部官员制服"
	desc = "中央指挥部官员所穿的制服，配有银色腰带扣，一眼便能看出其级别。"
	icon_state = "official"
	inhand_icon_state = "dg_suit"

/obj/item/clothing/under/rank/centcom/intern
	name = "\improper 中央指挥部实习生连体服"
	desc = "这是为中央指挥部实习人员所穿的连体服。上衣采用马球衫款式，便于识别。"
	icon_state = "intern"
	inhand_icon_state = "dg_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/centcom/officer
	name = "\improper 中央指挥部高领制服"
	desc = "一件休闲而精致的绿色高领衫，供中央指挥部军官穿着。散发着芦荟的清香。"
	icon_state = "officer"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/centcom/officer/replica
	name = "\improper 中央指挥部高领制服仿品"
	desc = "中央指挥部高领衫的廉价仿制品！衣领上可以看到咚克公司的标志。"

/obj/item/clothing/under/rank/centcom/officer_skirt
	name = "\improper 中央指挥部高领裙装"
	desc = "中央指挥部高领衫的裙装版本，比原版更加稀有，也更受追捧。"
	icon_state = "officer_skirt"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/centcom/officer_skirt/replica
	name = "\improper 中央指挥部高领裙装仿品"
	desc = "中央指挥部高领裙装的廉价仿制品！衣领上可以看到咚克公司的标志。"

/obj/item/clothing/under/rank/centcom/centcom_skirt
	name = "\improper 中央指挥部指挥官裙装制服"
	desc = "这是中央指挥部最高阶指挥官所穿的裙装制服。"
	icon_state = "centcom_skirt"
	inhand_icon_state = "dg_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/centcom/military
	name = "战术战斗制服"
	desc = "中央指挥部征召部队所穿的深色制服。"
	icon_state = "military"
	inhand_icon_state = "bl_suit"
	can_adjust = FALSE
	armor_type = /datum/armor/clothing_under/centcom_military

/datum/armor/clothing_under/centcom_military
	melee = 10
	fire = 50
	acid = 40
	wound = 10

/obj/item/clothing/under/rank/centcom/military/eng
	name = "战术工程制服"
	desc = "中央指挥部正规军事工程师所穿的深色制服。"
	icon_state = "military_eng"
