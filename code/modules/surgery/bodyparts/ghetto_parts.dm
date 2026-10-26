/obj/item/bodypart/arm/left/ghetto
	name = "木桩左臂"
	desc = "一段粗略削制的木桩取代了原本前臂的位置。它简单而结实，显然是随手用现有材料匆忙做成的。尽管外表粗糙，但它确实管用。"
	icon = 'icons/mob/human/species/ghetto.dmi'
	icon_static = 'icons/mob/human/species/ghetto.dmi'
	limb_id = BODYPART_ID_PEG
	icon_state = "peg_l_arm"
	bodytype = BODYTYPE_PEG
	should_draw_greyscale = FALSE
	attack_verb_simple = list("重击", "劈砍")
	unarmed_damage_low = 3
	unarmed_damage_high = 9
	unarmed_effectiveness = 5
	brute_modifier = 1.2
	burn_modifier = 1.5
	bodypart_traits = list(TRAIT_CHUNKYFINGERS)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = (BIO_WOOD|BIO_JOINTED)
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)
	butcher_replacement = null

/obj/item/bodypart/arm/left/ghetto/Initialize(mapload, ...)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/arm/right/ghetto
	name = "木桩右臂"
	desc = "一段粗略削制的木桩取代了原本前臂的位置。它简单而结实，显然是随手用现有材料匆忙做成的。尽管外表粗糙，但它确实管用。"
	icon = 'icons/mob/human/species/ghetto.dmi'
	icon_static = 'icons/mob/human/species/ghetto.dmi'
	limb_id = BODYPART_ID_PEG
	icon_state = "peg_r_arm"
	bodytype = BODYTYPE_PEG
	should_draw_greyscale = FALSE
	attack_verb_simple = list("重击", "劈砍")
	unarmed_damage_low = 3
	unarmed_damage_high = 9
	unarmed_effectiveness = 5
	brute_modifier = 1.2
	burn_modifier = 1.5
	bodypart_traits = list(TRAIT_CHUNKYFINGERS)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = (BIO_WOOD|BIO_JOINTED)
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)
	butcher_replacement = null

/obj/item/bodypart/arm/right/ghetto/Initialize(mapload, ...)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/leg/left/ghetto
	name = "木桩左腿"
	desc = "这条木桩腿是用一根看着很像桌腿的东西做成的，给“边走边吃”赋予了全新的含义。它有点摇晃，每走一步都会发出不祥的嘎吱声，但至少你可以宣称自己拥有七大洋上最均衡的饮食。"
	icon = 'icons/mob/human/species/ghetto.dmi'
	icon_static = 'icons/mob/human/species/ghetto.dmi'
	limb_id = BODYPART_ID_PEG
	icon_state = "peg_l_leg"
	bodytype = BODYTYPE_PEG
	should_draw_greyscale = FALSE
	unarmed_damage_low = 2
	unarmed_damage_high = 5
	unarmed_effectiveness = 10
	brute_modifier = 1.2
	burn_modifier = 1.5
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = (BIO_WOOD|BIO_JOINTED)
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)
	butcher_replacement = null

/obj/item/bodypart/leg/left/ghetto/Initialize(mapload, ...)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/leg/right/ghetto
	name = "木桩右腿"
	desc = "这条木桩腿是用一根看着很像桌腿的东西做成的，给“边走边吃”赋予了全新的含义。它有点摇晃，每走一步都会发出不祥的嘎吱声，但至少你可以宣称自己拥有七大洋上最均衡的饮食。"
	icon = 'icons/mob/human/species/ghetto.dmi'
	icon_static = 'icons/mob/human/species/ghetto.dmi'
	limb_id = BODYPART_ID_PEG
	icon_state = "peg_r_leg"
	bodytype = BODYTYPE_PEG
	should_draw_greyscale = FALSE
	unarmed_damage_low = 2
	unarmed_damage_high = 5
	unarmed_effectiveness = 10
	brute_modifier = 1.2
	burn_modifier = 1.5
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = (BIO_WOOD|BIO_JOINTED)
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)
	butcher_replacement = null

/obj/item/bodypart/leg/right/ghetto/Initialize(mapload, ...)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)
