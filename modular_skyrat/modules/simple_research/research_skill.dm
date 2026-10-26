/datum/skill/research
	name = "研究"
	title = "研究者"
	desc = "献给渴望发现宇宙奥秘的人——或是想尝尝石头的人。"
	modifiers = list(
		SKILL_SPEED_MODIFIER = list(1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.25),
		SKILL_PROBS_MODIFIER = list(0, 5, 10, 20, 40, 80, 100)
	)
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/researching

/obj/item/clothing/neck/cloak/skill_reward/researching
	name = "传奇研究者披风"
	desc = "这件传奇披风只授予凭借贡献在科学界引起巨大反响的人。\
	披着它的人奠定了科学的基石，即便从最平凡的事物中，也能洞察宇宙的真理。"
	icon = 'modular_skyrat/modules/simple_research/icons/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/simple_research/icons/neck.dmi'
	icon_state = "researchcloak"
	associated_skill_path = /datum/skill/research
