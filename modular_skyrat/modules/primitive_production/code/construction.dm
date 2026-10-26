/datum/skill/construction
	name = "Construction"
	title = "建造师"
	desc = "成为建造师，就是享受文明的奠基与建设。"
	modifiers = list(
		SKILL_SPEED_MODIFIER = list(1, 0.95, 0.9, 0.85, 0.75, 0.6, 0.5),
		SKILL_PROBS_MODIFIER = list(0, 5, 10, 20, 40, 80, 100)
	)
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/construction

/obj/item/clothing/neck/cloak/skill_reward/construction
	name = "传奇建造师斗篷"
	desc = "穿戴这件斗篷的人具备奠定文明根基所需的知识与见识。\
	传说中，有人能在短短几分钟内建起或摧毁村庄、城镇乃至都市。"
	icon = 'modular_skyrat/modules/primitive_production/icons/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/neck.dmi'
	icon_state = "buildercloak"
	associated_skill_path = /datum/skill/construction
