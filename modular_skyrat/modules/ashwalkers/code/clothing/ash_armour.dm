//ASH CLOTHING
/datum/armor/ash_headdress
	melee = 15
	bullet = 25
	laser = 15
	energy = 15
	bomb = 20
	bio = 10

/datum/armor/clothing_under/ash_robes
	melee = 15
	bullet = 25
	laser = 15
	energy = 15
	bomb = 20
	bio = 10

/datum/armor/ash_plates
	melee = 15
	bullet = 25
	laser = 15
	energy = 15
	bomb = 20
	bio = 10

/datum/armor/bone_greaves
	melee = 15
	bullet = 25
	laser = 15
	energy = 15
	bomb = 20
	bio = 50

/obj/item/clothing/head/ash_headdress
	name = "灰烬头饰"
	desc = "一顶彰显灰行者统治地位的头饰。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_mob.dmi'
	icon_state = "headdress"
	supports_variations_flags = NONE
	armor_type = /datum/armor/ash_headdress
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_headdress
	name = "灰烬头饰"
	result = /obj/item/clothing/head/ash_headdress
	category = CAT_CLOTHING
	//recipe given to ashwalkers as part of their spawner/team setting
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/obj/item/clothing/head/ash_headdress/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2, /obj/item/stack/sheet/animalhide/goliath_hide, list(MELEE = 5, BULLET = 2, LASER = 2))

/obj/item/clothing/head/ash_headdress/winged
	name = "带翼灰烬头饰"
	icon_state = "wing_headdress"

/datum/crafting_recipe/ash_recipe/ash_headdress/winged
	name = "带翼灰烬头饰"
	result = /obj/item/clothing/head/ash_headdress/winged
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/obj/item/clothing/under/costume/gladiator/ash_walker/ash_robes
	name = "灰烬长袍"
	desc = "一套手工缝制的长袍。上面的骨头似乎还连着些肌肉。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_mob.dmi'
	icon_state = "robes"
	armor_type = /datum/armor/clothing_under/ash_robes
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_robes
	name = "灰烬长袍"
	result = /obj/item/clothing/under/costume/gladiator/ash_walker/ash_robes
	category = CAT_CLOTHING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/obj/item/clothing/under/costume/gladiator/ash_walker/ash_robes/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2, /obj/item/stack/sheet/animalhide/goliath_hide, list(MELEE = 5, BULLET = 2, LASER = 2))

/obj/item/clothing/under/costume/gladiator/ash_walker/ash_plates
	name = "灰烬战斗护甲片"
	desc = "由骨头与皮革拼接而成，用守望者的肌腱串在一起。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_mob.dmi'
	icon_state = "combat_plates"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/clothing_under/ash_robes
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_plates
	name = "灰烬战斗护甲片"
	result = /obj/item/clothing/under/costume/gladiator/ash_walker/ash_plates
	category = CAT_CLOTHING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/obj/item/clothing/under/costume/gladiator/ash_walker/ash_plates/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2, /obj/item/stack/sheet/animalhide/goliath_hide, list(MELEE = 5, BULLET = 2, LASER = 2))

/obj/item/clothing/under/costume/gladiator/ash_walker/ash_plates/decorated
	name = "装饰过的灰烬战斗护甲片"
	icon_state = "dec_breastplate"

/datum/crafting_recipe/ash_recipe/ash_plates/decorated
	name = "装饰过的灰烬战斗护甲片"
	result = /obj/item/clothing/under/costume/gladiator/ash_walker/ash_plates/decorated
	category = CAT_CLOTHING
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/obj/item/clothing/shoes/bone_greaves
	name = "骨制护胫"
	desc = "适合在预计会踩到尖东西的时候穿。为双脚提供适度的保护。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/shoes.dmi'
	worn_icon = 'modular_skyrat/modules/ashwalkers/icons/feet.dmi'
	worn_icon_digi = 'modular_skyrat/modules/ashwalkers/icons/feet_digi.dmi'
	icon_state = "bone_greaves"

	body_parts_covered = parent_type::body_parts_covered | LEGS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	armor_type = /datum/armor/bone_greaves
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)

/datum/crafting_recipe/ash_recipe/bone_greaves
	name = "骨制护胫"
	result = /obj/item/clothing/shoes/bone_greaves
	reqs = list(
		/obj/item/stack/sheet/bone = 2,
		/obj/item/stack/sheet/sinew = 1,
	)
	category = CAT_CLOTHING
