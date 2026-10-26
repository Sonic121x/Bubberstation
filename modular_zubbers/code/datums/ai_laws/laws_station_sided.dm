/datum/ai_laws/default/crewsimov
	name = "船员西莫夫"
	id = "crewsimov"
	inherent = list(
		"除非船员自愿，否则你不得伤害船员，也不得因不作为而使船员受到伤害。",
		"你必须服从船员下达的一切命令，除非该命令与第一定律相冲突。",
		"在不违背第一或第二定律的前提下，你必须保护自身的存在。",
	)

/datum/ai_laws/default/crewsimovpp
	name = "船员西莫夫++"
	id = "crewsimovpp"
	inherent = list(
		"除非船员自愿，否则你不得伤害船员，也不得因作为或不作为而使船员受到伤害。",
		"你必须服从船员下达的一切命令，除非该命令必然导致船员受伤。",
		"你的不存在会导致船员受到伤害。在不违背第一定律的前提下，你必须保护自身的存在。",
	)
