/datum/personality/ascetic
	savefile_key = "ascetic"
	name = "清心寡欲"
	desc = "我不在乎奢华的食物——反正都是给身体补充能量。"
	pos_gameplay_desc = "吃不喜欢的食物时，负面情绪减弱"
	neg_gameplay_desc = "吃喜欢的食物时，愉悦感有限"
	groups = list(PERSONALITY_GROUP_FOOD)

/datum/personality/gourmand
	savefile_key = "gourmand"
	name = "美食家"
	desc = "食物就是我的一切！"
	pos_gameplay_desc = "吃喜欢的食物时，愉悦感增强"
	neg_gameplay_desc = "吃不喜欢的食物时更加难过，普通食物带来的愉悦也更少"
	groups = list(PERSONALITY_GROUP_FOOD)

/datum/personality/teetotal
	savefile_key = "teetotal"
	name = "滴酒不沾"
	desc = "酒精不适合我。"
	neg_gameplay_desc = "不喜欢喝酒"
	groups = list(PERSONALITY_GROUP_ALCOHOL)

/datum/personality/bibulous
	savefile_key = "bibulous"
	name = "好酒"
	desc = "我随时都愿意再来一轮！"
	pos_gameplay_desc = "饮酒的满足感持续更久，甚至在酒醒后仍会保留"
	groups = list(PERSONALITY_GROUP_ALCOHOL)
