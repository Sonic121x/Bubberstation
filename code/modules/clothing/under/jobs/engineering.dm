//Contains: Engineering department jumpsuits

/obj/item/clothing/under/rank/engineering
	icon = 'icons/obj/clothing/under/engineering.dmi'
	worn_icon = 'icons/mob/clothing/under/engineering.dmi'
	abstract_type = /obj/item/clothing/under/rank/engineering
	armor_type = /datum/armor/clothing_under/rank_engineering
	resistance_flags = NONE

/datum/armor/clothing_under/rank_engineering
	fire = 60
	acid = 20

/obj/item/clothing/under/rank/engineering/chief_engineer
	desc = "这是发给那些疯狂到能坐上“总工程师”职位的工程师的高可视度连体服。由耐火材料制成。"
	name = "总工程师连体服"
	icon_state = "chiefengineer"
	inhand_icon_state = "gy_suit"
	armor_type = /datum/armor/clothing_under/engineering_chief_engineer

/datum/armor/clothing_under/engineering_chief_engineer
	fire = 80
	acid = 40

/obj/item/clothing/under/rank/engineering/chief_engineer/skirt
	name = "总工程师连体裙"
	desc = "这是发给那些疯狂到能坐上“总工程师”职位的工程师的高可视度连体裙。由耐火材料制成。"
	icon_state = "chief_skirt"
	inhand_icon_state = "gy_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/engineering/chief_engineer/turtleneck
	name = "总工程师高领衫"
	desc = "一件黄色高领衫配白色卡其裤，献给品味出众的总工程师。"
	icon_state = "ceturtle"
	inhand_icon_state = "y_suit"
	can_adjust = TRUE
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/engineering/chief_engineer/turtleneck/skirt
	name = "总工程师高领衫裙"
	desc = "一件黄色高领衫配白色卡其短裙，献给品味出众的总工程师。"
	icon_state = "ceturtle_skirt"
	inhand_icon_state = "y_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/engineering/atmospheric_technician
	desc = "大气技术员穿的连体服。由耐火材料制成。"
	name = "大气技术员连体服"
	icon_state = "atmos"
	inhand_icon_state = "atmos_suit"

/obj/item/clothing/under/rank/engineering/atmospheric_technician/skirt
	name = "大气技术员连体裙"
	desc = "大气技术员穿的连体裙。由耐火材料制成。"
	icon_state = "atmos_skirt"
	inhand_icon_state = "atmos_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/engineering/engineer
	desc = "工程师穿的橙色高可视度连体服。由耐火材料制成。"
	name = "工程师连体服"
	icon_state = "engine"
	inhand_icon_state = "engi_suit"

/obj/item/clothing/under/rank/engineering/engineer/hazard
	name = "工程师危险作业连体服"
	desc = "一件高可视度连体服。由耐火材料制成。"
	icon_state = "hazard"
	inhand_icon_state = "syndicate-orange"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/engineering/engineer/skirt
	name = "工程师连体裙"
	desc = "工程师穿的橙色高可视度连体裙。由耐火材料制成。"
	icon_state = "engine_skirt"
	inhand_icon_state = "engi_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
