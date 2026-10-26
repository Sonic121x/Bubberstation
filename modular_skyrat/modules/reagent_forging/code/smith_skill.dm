/datum/skill/smithing
	name = "锻造"
	title = "铁匠"
	desc = "追逐锻炉火焰、奋力求索的艺术家。"
	modifiers = list(
		SKILL_SPEED_MODIFIER = list(1, 0.95, 0.9, 0.85, 0.8, 0.75, 0.7),
		SKILL_PROBS_MODIFIER = list(0, 5, 10, 20, 40, 80, 100)
	)
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/smithing

/obj/item/clothing/neck/cloak/skill_reward/smithing
	name = "传奇铁匠披风"
	desc = "只有最熟练的铁匠才能穿上这件传奇披风，唯有彻底掌握锻造技艺才能获得它。\
	这一身份象征代表着曾打造出顶尖武器与护甲的大师。"
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/neck.dmi'
	icon_state = "smithingcloak"
	associated_skill_path = /datum/skill/smithing
