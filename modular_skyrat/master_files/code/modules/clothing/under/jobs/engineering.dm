/obj/item/clothing/under/rank/engineering
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering_digi.dmi' // Anything that was in the engineering.dmi, should be in the engineering_digi.dmi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/engineering/engineer/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/engineering.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering.dmi'

/obj/item/clothing/under/rank/engineering/chief_engineer/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/engineering.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering.dmi'

/obj/item/clothing/under/rank/engineering/atmospheric_technician/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/engineering.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering.dmi'

/*
*	ENGINEER
*/

/obj/item/clothing/under/rank/engineering/engineer/skyrat/utility
	name = "工程实用制服"
	desc = "工程部门人员穿着的实用制服。"
	icon_state = "util_eng"
	can_adjust = FALSE

/obj/item/clothing/under/rank/engineering/engineer/skyrat/utility/syndicate
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/engineering/engineer/skyrat/trouser
	name = "工程长裤"
	desc = "一条工程橙的长裤。裤腰上自豪地印着“防辐射”标志，不过只靠一条防辐射长裤究竟有多大用处，仍有争议。"
	icon_state = "workpants_orange"
	body_parts_covered = GROIN|LEGS
	can_adjust = FALSE
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS

/obj/item/clothing/under/rank/engineering/engineer/skyrat/hazard_chem
	name = "化学品危险作业连体服"
	desc = "一件高可视度连体服，对气体和化学品危害有额外防护，代价是防火性能有所降低。"
	icon_state = "hazard_green"
	armor_type = /datum/armor/clothing_under/skyrat_hazard_chem
	resistance_flags = ACID_PROOF
	alt_covers_chest = TRUE

/datum/armor/clothing_under/skyrat_hazard_chem
	fire = 20
	acid = 60

/obj/item/clothing/under/rank/engineering/engineer/skyrat/hazard_chem/emt
	name = "化学品危险作业急救员连体服"
	desc = "急救人员处理涉及气体和/或化学品危害的情况时穿着的急救员连体服。标签上写着：“非为长时间暴露而设计”。"
	icon_state = "hazard_white"
	armor_type = /datum/armor/clothing_under/hazard_chem_emt

/*
*	CHIEF ENGINEER
*/

/datum/armor/clothing_under/hazard_chem_emt
	fire = 10
	acid = 50

/*
*	ATMOS TECH
*/
/datum/armor/clothing_under/atmos_adv
	bio = 40
	fire = 70
	acid = 70

/obj/item/clothing/under/rank/engineering/atmospheric_technician/skyrat/utility/advanced
	name = "高级大气制服"
	desc = "高级大气技术人员穿着的连体服。"
	icon_state = "util_atmos"
	armor_type = /datum/armor/clothing_under/atmos_adv
	icon_state = "util_eng"
	can_adjust = FALSE

/*
*	TELECOMMS SPECIALIST
*/

/obj/item/clothing/under/rank/engineering/engineer/skyrat/utility/telecomm
	desc = "电信专家穿着的连体服。由耐火材料制成。"
	name = "电信连体服"
	icon_state = "telecomm"
	can_adjust = TRUE

/obj/item/clothing/under/rank/engineering/engineer/skyrat/utility/telecomm/skirt
	desc = "电信专家穿着的连体裙。由耐火材料制成。"
	name = "电信连体裙"
	icon_state = "telecomm_skirt"
	can_adjust = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
