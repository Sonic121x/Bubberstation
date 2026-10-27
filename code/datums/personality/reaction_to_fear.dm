/datum/personality/brave
	savefile_key = "brave"
	name = "勇敢"
	desc = "想吓到我，光这么点血可不够。"
	pos_gameplay_desc = "恐惧积累更慢，与恐惧有关的情绪影响更弱"
	groups = list(PERSONALITY_GROUP_GENERAL_FEAR, PERSONALITY_GROUP_PEOPLE_FEAR)

/datum/personality/cowardly
	savefile_key = "cowardly"
	name = "怯懦"
	desc = "这里什么东西都危险！连空气也是！"
	neg_gameplay_desc = "恐惧积累更快，与恐惧有关的情绪影响更强"
	groups = list(PERSONALITY_GROUP_GENERAL_FEAR)
