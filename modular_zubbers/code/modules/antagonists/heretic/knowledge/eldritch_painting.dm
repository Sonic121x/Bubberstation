/datum/heretic_knowledge/painting
	desc = "让你能将画布和另一件物品转化为一幅画作。\
			每幅画都有独特的效果和配方。可制作的画作：\
			《姐妹与落泪者》：需要一对眼球。使你的头脑清醒，并诅咒非异教徒，使其产生幻觉。\
			《欲望之宴》：需要一条断肢。为你提供随机器官，并诅咒非异教徒，使其渴望血肉。\
			《连绵丘陵上的广袤灌木丛》：需要任意植物产物。放置后会蔓延葛藤，并为你提供罂粟和风铃草。\
			《门扉女士》：需要任意一副手套。清除你的基因突变，使非异教徒发生突变并因诅咒而不停抓挠。"
	// rust painting is gone
	drafting_tier = 0 // fully disabled, this thing is fundumentally ass
	unreachable = TRUE

/datum/status_effect/eldritch_painting
	duration = 4 MINUTES
