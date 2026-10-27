/datum/species/lizard
	name = "\improper 提兹拉蜥蜴人"
	//renames Lizardpeople to Tizirans for clarity.

/datum/species/lizard/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT

/datum/species/lizard/on_bloodsucker_loss(mob/living/carbon/human/target)
	bodytemp_heat_damage_limit = initial(bodytemp_heat_damage_limit)
	bodytemp_cold_damage_limit = initial(bodytemp_cold_damage_limit)

/datum/species/lizard/get_species_description()
	return list(
	"提兹拉人（在联邦空间被称为蜥蜴人）是一个曾拥有庞大帝国的蜥蜴形种族。",
	"他们主要吃生肉、鱼、蘑菇和坚果。辛辣食物会使他们全身起泡。\
	由于母星干燥干旱，他们是冷血动物，身体无法承受真正的极端温度。",
	)

/datum/species/lizard/get_species_lore()
	return list(
		"提兹拉人的身体覆盖着厚实的鳞片，以强健的体质和耐高温能力著称。\
		他们常有角和褶边，后者的褶边在女性身上通常更宽。\
		他们通常比人类长得更高，平均身高六到七英尺，而且往往先长高再长宽。\
		这意味着年轻的提兹拉人通常比人类同龄人更瘦，并且一生中停止生长的时间更晚。",

		"帝国格言“誓言与鳞片”常被用来强调社群，而他们的社群意识往往决定提兹拉人的行为方式。\
		这使他们与 CIN 中的伙伴特沙利人有着惊人的共同点。提兹拉人常常首先寻求社群。\
		拍胸和拍尾常被用来强调真诚或诚实。他们在愤怒、不满或受到威胁时往往会发出嘶嘶声。\
		提兹拉人喜欢装饰身体，尤其是褶边和角，方式类似人类的纹身与穿孔，\
		以象征重要事件和效忠对象。他们往往重视身体与行动胜过言辞，因此文化上不太看重时尚。",

		"提兹拉人拥有军国主义文化，曾征服大片领土，\
		直到他们的首都扎戈斯凯尔德被联邦等离子舰船化为玻璃峡谷，终结了联盟战争。\
		此后他们的领土缩小，但仍是现代增长较快的经济体之一。\
		曾经的提兹拉要塞世界、殖民地凯萨阿雷什，如今是大多数联邦蜥蜴人投票和出身的所在地。",

		"在现代，许多提兹拉人不得不面对基于其昔日沙文主义的污名与刻板印象，\
		这促成了过去半个世纪提兹拉艺术家、作家和哲学家的文化复兴。",
	)

/datum/species/lizard/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#FFA756")
	lizard.dna.features["mcolor"] = lizard_color
	lizard.dna.features["mcolor2"] = "#DE893A"
	lizard.dna.features["mcolor3"] = "#DE893A"
	lizard.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Light Tiger", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Sharp + Light", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.mutant_bodyparts["horns"] = list(MUTANT_INDEX_NAME = "Drake", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.mutant_bodyparts["frills"] = list(MUTANT_INDEX_NAME = "Neck Frills (New)", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.features["legs"] = "Normal Legs"
	lizard.set_facial_hairstyle("Lizard Tongue Flick")
	regenerate_organs(lizard, src, visual_only = TRUE)
	lizard.update_body(TRUE)
