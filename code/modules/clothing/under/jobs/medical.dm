/obj/item/clothing/under/rank/medical
	icon = 'icons/obj/clothing/under/medical.dmi'
	worn_icon = 'icons/mob/clothing/under/medical.dmi'
	abstract_type = /obj/item/clothing/under/rank/medical
	armor_type = /datum/armor/clothing_under/rank_medical

/datum/armor/clothing_under/rank_medical
	bio = 50

/obj/item/clothing/under/rank/medical/doctor
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。胸前有一个十字，表明穿戴者是受过训练的医疗人员。"
	name = "医生连体工作服"
	icon_state = "medical"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/doctor/skirt
	name = "医生连体工作裙"
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。胸前有一个十字，表明穿戴者是受过训练的医疗人员。"
	icon_state = "medical_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/medical/chief_medical_officer
	desc = "这是一件连体工作服，由具备“首席医疗官”资历的人穿着。它提供轻微的生物防护。"
	name = "首席医疗官连体工作服"
	icon_state = "cmo"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/chief_medical_officer/skirt
	name = "首席医疗官连体工作裙"
	desc = "这是一件连体工作裙，由具备“首席医疗官”资历的人穿着。它提供轻微的生物防护。"
	icon_state = "cmo_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/medical/chief_medical_officer/scrubs
	name = "首席医疗官洗手服"
	desc = "一套独特的白色与青绿色洗手服，专为追求临床风格的首席医疗官准备。"
	icon_state = "scrubscmo"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/chief_medical_officer/scrubs/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck
	name = "首席医疗官高领衫"
	desc = "一件浅蓝色高领衫配棕褐色卡其裤，献给品味出众的首席医疗官。"
	icon_state = "cmoturtle"
	inhand_icon_state = "b_suit"
	can_adjust = TRUE
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck/skirt
	name = "首席医疗官高领裙"
	desc = "一件浅蓝色高领衫配棕褐色卡其裙，献给品味出众的首席医疗官。"
	icon_state = "cmoturtle_skirt"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/medical/virologist
	desc = "它由一种特殊纤维制成，对生物危害有特殊防护。上面有病毒学家的军衔条纹。"
	name = "病毒学家连体工作服"
	icon_state = "virology"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/virologist/skirt
	name = "病毒学家连体工作裙"
	desc = "它由一种特殊纤维制成，对生物危害有特殊防护。上面有病毒学家的军衔条纹。"
	icon_state = "virologywhite_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/medical/scrubs
	name = "医疗洗手服"

/obj/item/clothing/under/rank/medical/scrubs/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/obj/item/clothing/under/rank/medical/scrubs/blue
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。这套是浅蓝色的。"
	icon_state = "scrubsblue"

/obj/item/clothing/under/rank/medical/scrubs/green
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。这套是深绿色的。"
	icon_state = "scrubsgreen"

/obj/item/clothing/under/rank/medical/scrubs/purple
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。这套是深紫色的。"
	icon_state = "scrubswine"

/obj/item/clothing/under/rank/medical/coroner
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。胸前有一个横向的白色十字，表明穿戴者是受过训练的验尸官。"
	name = "验尸官连体工作服"
	icon_state = "coroner"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/coroner/skirt
	name = "验尸官连体工作裙"
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。胸前有一个横向的白色十字，表明穿戴者是受过训练的验尸官。"
	icon_state = "coroner_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/medical/scrubs/coroner
	name = "验尸官洗手服"
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。这套和情绪摇滚的诗歌一样黑。"
	icon_state = "scrubsblack"

/obj/item/clothing/under/rank/medical/chemist
	desc = "它由一种特殊纤维制成，对生物危害有特殊防护。上面有化学家的军衔条纹。"
	name = "化学家连体工作服"
	icon_state = "chemistry"
	inhand_icon_state = "w_suit"
	armor_type = /datum/armor/clothing_under/medical_chemist

/datum/armor/clothing_under/medical_chemist
	fire = 50
	acid = 65

/obj/item/clothing/under/rank/medical/chemist/skirt
	name = "化学家连体工作裙"
	desc = "它由一种特殊纤维制成，对生物危害有特殊防护。上面有化学家的军衔条纹。"
	icon_state = "chemistrywhite_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/medical/paramedic
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。胸前有一个深蓝色十字，表明穿戴者是受过训练的急救员。"
	name = "急救员连体工作服"
	icon_state = "paramedic"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/paramedic/skirt
	name = "急救员连体工作裙"
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。胸前有一个深蓝色十字，表明穿戴者是受过训练的急救员。"
	icon_state = "paramedic_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/medical/doctor/nurse
	desc = "这是一种医疗部门护理人员常穿的连体工作服。"
	name = "护士服"
	icon_state = "nursesuit"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE
