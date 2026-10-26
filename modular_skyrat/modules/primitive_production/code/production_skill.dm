/datum/skill/production
	name = "Production"
	title = "工艺师"
	desc = "运用多种材料表达创造力的艺术家。"
	modifiers = list(
		SKILL_SPEED_MODIFIER = list(1, 0.95, 0.9, 0.85, 0.75, 0.6, 0.5),
		SKILL_PROBS_MODIFIER = list(10, 15, 20, 25, 30, 35, 40)
	)
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/production

/obj/item/clothing/neck/cloak/skill_reward/production
	name = "传奇工艺师斗篷"
	desc = "这件传奇斗篷属于技艺最高超的工艺师，只有懂得制作最优质成品的人才能获得。\
	这一身份象征代表着曾创作出顶尖玻璃与陶瓷作品的人。"
	icon = 'modular_skyrat/modules/primitive_production/icons/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/neck.dmi'
	icon_state = "productioncloak"
	associated_skill_path = /datum/skill/production
