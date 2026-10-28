/datum/species/xeno
	mutant_organs = list()
	heatmod = 1
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
		TRAIT_NIGHT_VISION
	)
	species_language_holder = /datum/language_holder/xeno_hybrid

/datum/species/xeno/get_species_description()
	return list(
		"“异形混合体”是一个宽泛的称呼，用于指代各种以异形特征为主的生物，而非一个独立的具体物种。异形本身是\
		由许多不同“宿主”物种寄生杂交而来的，因此普通异形与混合体之间的主要区别在于\
		更接近人形的体型与身材，带有外星特征、失活或有缺陷的蜂巢\
		器官，以及不那么嗜杀的性情。这些并非仅有的已记录差异，\
		但确实是最常见的。",

		"他们的诞生方式同样千差万别，从实验室培育的实验体到纯异形蜂巢中\
		罕见的基因畸变都有。遗憾的是，这一切最终导致其他种族因其寄生起源而\
		对他们怀有一定程度的偏见与恐惧，无论该混合体是否真的有能力寄生于其他生物。",
	)

/datum/species/xeno/get_species_lore()
	return list(
		"异形混合体是一类与异形基因杂交的生物，最常使用人类基因，但越来越多的其他种族也接受了这种处理。\
		他们的身高往往超过原物种，寿命明显更长，并且无论原物种是否拥有，都长有锋利的爪子。\
		他们没有真正有组织的社会，大多以少量个体融入原物种会居住的空间。有些混合体能蒙混过关，另一些则不能，因而更受歧视。\
		他们往往缺乏社交技巧，比银河系中的同类更为沉默，并且由于感官极其敏锐而容易受到过度刺激，\
		但凭借经验，大多数混合体都能轻松克服这一问题，很好地融入他们所处的社交环境。只要你能忍受那口牙。",

		"混合体最早是在纳米传讯一项关于异形基因组的研究项目中被记录的，该项目最初\
		旨在制造超级士兵。相关努力热情十足，但成效并不特别显著。\
		另一项产生混合体的计划是“奇美拉行动”，这是太阳情报局\
		一项有趣而绝望的计划，试图利用异形与他人结合的能力\
		将一种生物武器转化为一个可控的物种。解决问题的时限十分紧迫，\
		因为异形侵染已经开始接管翁布鲁克斯星区的多个独立世界，威胁到内陆地区，\
		而……它并没有真正成功。话虽如此，由于有效的轨道轰炸，侵染已被遏制。",


		"如今，异形混合体处境尴尬，既被社会排斥，也被创造他们的物种排斥。\
		纳米传讯的异形科学部门为这些被放逐者提供了一项适应计划，\
		标志着融合的开端。在这场缓慢争取接纳的进程中，他们从共同的蜂巢中寻得慰藉。",
	)

/datum/species/xeno/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "eye",
		SPECIES_PERK_NAME = "黑暗视觉",
		SPECIES_PERK_DESC = "异形混合体从纯异形那里继承了在黑暗中视物的能力，只是程度较弱。"
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "biohazard",
		SPECIES_PERK_NAME = "锋利利爪",
		SPECIES_PERK_DESC = "异形混合体拥有锋利的爪子和趾甲。"
	))

	return to_add
