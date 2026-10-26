// Peacekeeper jumpsuit

/obj/item/clothing/under/sol_peacekeeper
	name = "地球维和部队制服"
	desc = "一套军用级制服，配有军用级的舒适度（完全没有），常见于地球政府的各支维和部队， \
		通常还会搭上一顶蓝色头盔。"
	icon = 'modular_skyrat/modules/goofsec/icons/uniforms.dmi'
	icon_state = "peacekeeper"
	worn_icon = 'modular_skyrat/modules/goofsec/icons/uniforms_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/goofsec/icons/uniforms_worn_digi.dmi'
	worn_icon_state = "peacekeeper"
	armor_type = /datum/armor/clothing_under/rank_security
	inhand_icon_state = null
	has_sensor = SENSOR_COORDS
	random_sensor = FALSE

// EMT jumpsuit

/obj/item/clothing/under/sol_emt
	name = "地球急救医疗制服"
	desc = "地球政府维和部队制服的翻版，重新配色并围绕急救人员重新设计。"
	icon = 'modular_skyrat/modules/goofsec/icons/uniforms.dmi'
	icon_state = "emt"
	worn_icon = 'modular_skyrat/modules/goofsec/icons/uniforms_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/goofsec/icons/uniforms_worn_digi.dmi'
	worn_icon_state = "emt"
	armor_type = /datum/armor/clothing_under/rank_medical
	inhand_icon_state = null
	has_sensor = SENSOR_COORDS
	random_sensor = FALSE

// Terragov flak jacket, for marshals

/obj/item/clothing/suit/armor/vest/det_suit/terra
	name = "“戈尔丁”防弹背心"
	desc = "一件轻型装甲夹克，常见于那些需要护甲、却又觉得整件防弹背心太不实用或没必要的 \
		地球政府人员身上。"
	icon = 'modular_skyrat/modules/goofsec/icons/uniforms.dmi'
	icon_state = "flak"
	worn_icon = 'modular_skyrat/modules/goofsec/icons/uniforms_worn.dmi'
	worn_icon_state = "flak"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
