/obj/item/clothing/head/beret/sec/nri
	name = "指挥官贝雷帽"
	desc = "为了祖国！！"
	armor_type = /datum/armor/sec_nri

/datum/armor/sec_nri
	melee = 40
	bullet = 35
	laser = 30
	energy = 40
	bomb = 25
	fire = 20
	acid = 50
	wound = 20

/obj/item/clothing/head/helmet/space/hev_suit/nri
	name = "\improper 旭日动力战斗装甲头盔"
	desc = "一顶石墨烯与塑钢复合头盔，内衬防弹尼龙，配有可展开的气密聚碳酸酯面罩和呼吸系统。后方印着“新俄罗斯帝国——国防委员会”。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/head_muzzled.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/head.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	obj_flags = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION
	resistance_flags = FIRE_PROOF|UNACIDABLE|ACID_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE|SNUG_FIT|BLOCK_GAS_SMOKE_EFFECT
	clothing_traits = null
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	flash_protect = FLASH_PROTECTION_WELDER
	visor_flags_inv = HIDEMASK|HIDEEYES|HIDEFACE|HIDEFACIALHAIR
	visor_flags = STOPSPRESSUREDAMAGE
	slowdown = 1

/obj/item/clothing/head/helmet/space/hev_suit/nri/captain
	name = "\improper 旭日-2动力战斗装甲头盔"
	desc = "一顶黑色石墨烯与塑钛复合头盔，带聚脲涂层和耐久纤维内衬，配有可展开的气密染色等离子玻璃面罩和凯夫拉衬里的呼吸系统。后方印着“新俄罗斯帝国——国防委员会”。"
	icon_state = "nri_captain"

/obj/item/clothing/head/helmet/space/hev_suit/nri/medic
	name = "\improper 旭日-KH动力战斗装甲头盔"
	desc = "战地医护兵使用的石墨烯与钛复合头盔，内衬可抵御生物危害，配有可展开的气密聚碳酸酯面罩和优化的呼吸系统。后方印着“新俄罗斯帝国——国防委员会”。"
	icon_state = "nri_medic"

/obj/item/clothing/head/helmet/space/hev_suit/nri/engineer
	name = "\improper 旭日-IN动力战斗装甲头盔"
	desc = "一顶钨与塑钢复合头盔，带有铅衬层的防弹尼龙内衬，配有可展开的气密聚碳酸酯面罩和呼吸系统。后方印着“新俄罗斯帝国——国防委员会”。"
	icon_state = "nri_engineer"


