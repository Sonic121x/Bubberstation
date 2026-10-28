/datum/storyteller/extended
	name = "延长（不抽取事件/反派）"
	desc = "延长模式意味着没有故事讲述者。它不会生成任何种类的事件，也不会运行任何反派。最适合人口低到连和平的故事讲述者都嫌太高的回合。"
	welcome_text = "宿舍怎么已经满员了？轮班甚至还没开始呢。"
	disable_distribution = TRUE
	population_max = 40
	antag_divisor = 32
	storyteller_type = STORYTELLER_TYPE_CALM
	votable = FALSE
