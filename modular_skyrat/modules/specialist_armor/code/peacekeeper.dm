// The peacekeeper armors and helmets will be less effective at stopping bullet damage than bulletproof vests, but stronger against wounds especially, and some other damage types
/datum/armor/armor_sf_peacekeeper
	melee = ARMOR_LEVEL_WEAK
	bullet = ARMOR_LEVEL_MID
	laser = ARMOR_LEVEL_TINY
	energy = ARMOR_LEVEL_TINY
	bomb = ARMOR_LEVEL_WEAK
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/suit/armor/sf_peacekeeper
	name = "“图武”维和护甲背心"
	desc = "亮蓝色背心，前后醒目地印着白色“地球政府警察”字样。致密织物搭配薄层轧制金属，\
		最擅长抵御子弹，也能抵挡少量钝击及其造成的伤口。激光则几乎会直接烧穿它。"
	icon = 'modular_skyrat/modules/specialist_armor/icons/armor.dmi'
	icon_state = "soft_peacekeeper"
	worn_icon = 'modular_skyrat/modules/specialist_armor/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_sf_peacekeeper
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/sf_peacekeeper/examine_more(mob/user)
	. = ..()

	. += "地球政府设计的常见护甲背心，服务于一个共同目标：别让内脏跑到外面来。\
		虽然更重型的护甲确实存在，但就所提供的防护而言，“图武”相当便宜，\
		银河各地的许多士兵和警员都能告诉你，软质为主的护甲有多方便。\
		这不在于防护力，而在于相对舒适，尤其是在不太需要考虑\
		能否用胸口挡下反器材弹的地区。也许正因如此，\
		它经常出现在银河各地的地球政府维和人员身上，也常被其他异类和公司恶棍\
		穿着。"

	return .

/obj/item/clothing/suit/armor/sf_peacekeeper/debranded
	name = "“图武”软质护甲背心"
	desc = "亮白色背心，明显没有“地球政府警察”标识。能减轻子弹、钝击及其造成的伤口，但激光几乎会直接烧穿它。"
	icon_state = "soft_civilian"

/obj/item/clothing/head/helmet/sf_peacekeeper
	name = "“炖锅”维和头盔"
	desc = "一顶尺寸很大、几乎总不合头的亮蓝色头盔，两侧醒目地印着地球政府徽章。\
		它最擅长抵御子弹，也能提供少量钝击防护，但面对激光就很吃力。"
	icon = 'modular_skyrat/modules/specialist_armor/icons/armor.dmi'
	icon_state = "helmet_peacekeeper"
	worn_icon = 'modular_skyrat/modules/specialist_armor/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_sf_peacekeeper
	dog_fashion = null
	flags_inv = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/helmet/sf_peacekeeper/examine_more(mob/user)
	. = ..()

	. += "地球政府设计的常见防弹头盔，服务于一个共同目标：让大脑留在脑袋里。\
		虽然更重型的头盔确实存在，但就所提供的防护而言，“炖锅”相当便宜，\
		许多士兵也不介意它的宽大尺寸，因为这反而规避了不少\
		更先进、保护力更强的头盔可能存在的适配问题。\
		尤其是在不太需要考虑\
		能否用额头挡下反器材弹的地区，它完全能够胜任。\
		也许正因如此，\
		它经常出现在银河各地的地球政府维和人员身上，也常被其他异类和公司恶棍\
		佩戴。"

	return .

/obj/item/clothing/head/helmet/sf_peacekeeper/debranded
	name = "“炖锅”防弹头盔"
	desc = "一顶尺寸很大、几乎总不合头的暗灰色头盔，没有什么特殊标记。\
		它最擅长抵御子弹，也能提供少量钝击防护，但面对激光就很吃力。"
	icon_state = "helmet_grey"
