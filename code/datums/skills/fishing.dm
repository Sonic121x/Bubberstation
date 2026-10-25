/**
 * skill associated with the fishing feature. It modifies the fishing minigame difficulty
 * and is gained each time one is completed.
 */
/datum/skill/fishing
	name = "钓鱼"
	title = "钓鱼人"
	desc = "在这荒芜的大地上，你是多么空虚而孤独。"
	modifiers = list(SKILL_VALUE_MODIFIER = list(1, 0, -1, -3, -5, -7, -10))
	skill_item_path = /obj/item/clothing/head/soft/fishing_hat

/datum/skill/fishing/New()
	. = ..()
	levelUpMessages[SKILL_LEVEL_NOVICE] = span_nicegreen("我开始理解[name]究竟是什么了！我现在能一眼估算出鱼的大小和重量。")
	levelUpMessages[SKILL_LEVEL_APPRENTICE] = span_nicegreen("我的[name]水平有所进步！我能判断鱼是否饥饿、濒死，以及其他状况。")
	levelUpMessages[SKILL_LEVEL_JOURNEYMAN] = span_nicegreen("我觉得自己已经相当精通[name]了！我能判断各个钓点能钓到哪些鱼。")
	levelUpMessages[SKILL_LEVEL_MASTER] = span_nicegreen("我开始真正理解[name]的深奥。身为大师级[title]，我现在能猜出自己将钓到什么了！")

/datum/skill/fishing/level_gained(datum/mind/mind, new_level, old_level, silent)
	. = ..()
	if(new_level >= SKILL_LEVEL_NOVICE && old_level < SKILL_LEVEL_NOVICE)
		ADD_TRAIT(mind, TRAIT_EXAMINE_FISH, SKILL_TRAIT)
	if(new_level >= SKILL_LEVEL_APPRENTICE && old_level < SKILL_LEVEL_APPRENTICE)
		ADD_TRAIT(mind, TRAIT_EXAMINE_DEEPER_FISH, SKILL_TRAIT)
	if(new_level >= SKILL_LEVEL_JOURNEYMAN && old_level < SKILL_LEVEL_JOURNEYMAN)
		ADD_TRAIT(mind, TRAIT_EXAMINE_FISHING_SPOT, SKILL_TRAIT)
	if(new_level >= SKILL_LEVEL_MASTER && old_level < SKILL_LEVEL_MASTER)
		ADD_TRAIT(mind, TRAIT_REVEAL_FISH, SKILL_TRAIT)

/datum/skill/fishing/level_lost(datum/mind/mind, new_level, old_level, silent)
	. = ..()
	if(old_level >= SKILL_LEVEL_MASTER && new_level < SKILL_LEVEL_MASTER)
		REMOVE_TRAIT(mind, TRAIT_REVEAL_FISH, SKILL_TRAIT)
	if(old_level >= SKILL_LEVEL_JOURNEYMAN && new_level < SKILL_LEVEL_JOURNEYMAN)
		REMOVE_TRAIT(mind, TRAIT_EXAMINE_FISHING_SPOT, SKILL_TRAIT)
	if(old_level >= SKILL_LEVEL_APPRENTICE && new_level < SKILL_LEVEL_APPRENTICE)
		REMOVE_TRAIT(mind, TRAIT_EXAMINE_DEEPER_FISH, SKILL_TRAIT)
	if(old_level >= SKILL_LEVEL_NOVICE && new_level < SKILL_LEVEL_NOVICE)
		REMOVE_TRAIT(mind, TRAIT_EXAMINE_FISH, SKILL_TRAIT)
