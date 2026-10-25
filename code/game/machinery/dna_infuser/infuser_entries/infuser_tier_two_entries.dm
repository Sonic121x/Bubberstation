/*
 * Tier two entries are unlocked after infusing someone/being infused and achieving a bonus, and are for dna mutants that are:
 * - harder to acquire (gondolas) but not *necessarily* requiring job help
 * - have a bonus for getting past a threshold
 *
 * todos for the future:
 * - tier threes, requires xenobio cooperation, unlocked after getting a tier two entity bonus
 * - when completing a tier, add the bonus to an xp system for unlocking new tiers. so instead of getting/giving a tier 1 bonus and unlocking tier 2, tier 1 would add "1" to a total. when you have a total of say, 3, you get the next tier
*/
/datum/infuser_entry/gondola
	name = "贡多拉"
	infuse_mob_name = "贡多拉类生物"
	desc = "贡多拉是一种稀有生物，选择只观察而不行动，它有许多有趣的特性可供利用。你懂的，禅意、平静、幸福……还有若无其事地穿过熊熊等离子体烈焰……"
	threshold_desc = "你能无视大多数环境条件！"
	qualities = list(
		"用拥抱使人平和",
		"进入幸福的禅定状态",
		"虚弱到拿不起比笔更大的东西",
		"不再关心温度……气压、空气……乃至大多数事物……",
	)
	input_obj_or_mob = list(
		/obj/item/food/meat/slab/gondola,
	)
	output_organs = list(
		/obj/item/organ/heart/gondola,
		/obj/item/organ/tongue/gondola,
		/obj/item/organ/liver/gondola,
	)
	infusion_desc = "善于观察"
	tier = DNA_MUTANT_TIER_TWO
	status_effect_type = /datum/status_effect/organ_set_bonus/gondola
