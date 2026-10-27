/obj/item/bodypart/arm/left/kinetic
	name = "左动能义肢臂"
	desc = "一款设计简约而优雅的义肢。旨在为用户恢复部分功能并保留有机手臂的外观，但由于缺乏精细运动控制，只能完成简单动作。"
	icon_static = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon_state = "kinetic_l_arm"
	limb_id = BODYPART_ID_KINETIC
	bodytype = BODYTYPE_KINETIC
	should_draw_greyscale = FALSE
	attack_verb_simple = list("猛击", "劈砍")
	unarmed_damage_low = 1
	unarmed_damage_high = 5
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_KINETIC
	bodypart_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_EASYDISMEMBER)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = BIO_INORGANIC

/obj/item/bodypart/arm/left/kinetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/arm/right/kinetic
	name = "右动能义肢臂"
	desc = "一款设计简约而优雅的义肢。旨在为用户恢复部分功能并保留有机手臂的外观，但由于缺乏精细运动控制，只能完成简单动作。"
	icon_static = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon_state = "kinetic_r_arm"
	limb_id = BODYPART_ID_KINETIC
	bodytype = BODYTYPE_KINETIC
	should_draw_greyscale = FALSE
	attack_verb_simple = list("猛击", "劈砍")
	unarmed_damage_low = 1
	unarmed_damage_high = 5
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_KINETIC
	bodypart_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_EASYDISMEMBER)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = BIO_INORGANIC

/obj/item/bodypart/arm/right/kinetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/leg/left/kinetic
	name = "左动能义肢腿"
	desc = "一款设计简约而优雅的义肢。末端不是普通的脚掌，而是装有一只简单的刃式脚，让用户能像平常一样行走。"
	icon_static = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon_state = "kinetic_r_leg"
	limb_id = BODYPART_ID_KINETIC
	bodytype = BODYTYPE_KINETIC
	should_draw_greyscale = FALSE
	unarmed_damage_low = 1
	unarmed_damage_high = 5
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_KINETIC
	bodypart_traits = list(TRAIT_EASYDISMEMBER)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = BIO_INORGANIC

/obj/item/bodypart/leg/left/kinetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/leg/right/kinetic
	name = "右动能义肢腿"
	desc = "一款设计简约而优雅的义肢。末端不是普通的脚掌，而是装有一只简单的刃式脚，让用户能像平常一样行走。"
	icon_static = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon_state = "kinetic_l_leg"
	limb_id = BODYPART_ID_KINETIC
	bodytype = BODYTYPE_KINETIC
	should_draw_greyscale = FALSE
	unarmed_damage_low = 1
	unarmed_damage_high = 5
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_KINETIC
	bodypart_traits = list(TRAIT_EASYDISMEMBER)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = BIO_INORGANIC

/obj/item/bodypart/leg/right/kinetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)
