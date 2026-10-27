/obj/item/clothing/under/rank/medical
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/medical_digi.dmi'	// Anything that was in the medical.dmi, should be in the medical_digi.dmi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/medical/doctor/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'


/obj/item/clothing/under/rank/medical/scrubs/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'
	icon_state = "scrubswhite" // Because for some reason TG's scrubs dont have an icon on their basetype
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。这一套似乎是最初的洗手服。"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/medical/chemist/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'

// Add a 'medical/virologist/skyrat' here if you make Virologist uniforms

/obj/item/clothing/under/rank/medical/paramedic/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'

/obj/item/clothing/under/rank/medical/chief_medical_officer/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'

/*
*	DOCTOR
*/

/obj/item/clothing/under/rank/medical/doctor/skyrat/utility
	name = "医疗实用制服"
	desc = "医生穿着的实用制服。"
	icon_state = "util_med"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/medical/doctor/skyrat/utility/syndicate
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/*
*	SCRUBS
*/

/obj/item/clothing/under/rank/medical/scrubs/skyrat/red
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。这一套是深红色的。"
	icon_state = "scrubsred"

/obj/item/clothing/under/rank/medical/scrubs/skyrat/white
	desc = "它由一种特殊纤维制成，能提供轻微的生物危害防护。这一套是奶油白色的。"
	icon_state = "scrubswhite"

/*
*	CHEMIST
*/

/obj/item/clothing/under/rank/medical/chemist/skyrat/formal
	name = "化学家正式连体工作服"
	desc = "一件白色衬衫，纽扣偏左排列，并有一条橙色条纹，内衬可防化学品泼溅。"
	icon_state = "pharmacologist"

/obj/item/clothing/under/rank/medical/chemist/skyrat/formal/skirt
	name = "化学家正式连体工作裙"
	icon_state = "pharmacologist_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/medical/chemist/skirt
	gets_cropped_on_taurs = FALSE

/*
*	PARAMEDIC
*/

/obj/item/clothing/under/rank/medical/paramedic/skyrat/light
	name = "轻便急救员制服"
	desc = "急救员常见制服的亮色变体，由特殊纤维制成，能提供轻微的生物危害防护；这一件去掉了反光条。"
	icon_state = "paramedic_light"

/obj/item/clothing/under/rank/medical/paramedic/skyrat/light/skirt
	name = "轻便急救员短裙"
	desc = "急救员常见制服的亮色变体，由特殊纤维制成，能提供轻微的生物危害防护；这一件把裤腿换成了短裙。"
	icon_state = "paramedic_light_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/*
*	CHIEF MEDICAL OFFICER
*/
