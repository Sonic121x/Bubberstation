/datum/skill/gaming
	name = "电玩"
	title = "游戏玩家"
	desc = "我的游戏水平。这能让我轻松击败首领，在猎户座之路里追求最强玩法，也让我想猛灌些玩家燃料饮料。"
	modifiers = list(SKILL_PROBS_MODIFIER = list(0, 5, 10, 15, 15, 20, 25),
				SKILL_RANDS_MODIFIER = list(0, 1, 2, 3, 4, 5, 7))
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/gaming

/datum/skill/gaming/New()
	. = ..()
	levelUpMessages[1] = span_nicegreen("我开始掌握这些游戏的操作了……")
	levelUpMessages[4] = span_nicegreen("我开始摸清这些街机游戏的主流打法了。如果我把最优策略发挥到极致，再围绕成熟技巧调整自己的风格……")
	levelUpMessages[6] = span_nicegreen("凭借非凡的决心与努力，我的[name]能力已登峰造极。我还要怎样才能更强呢……也许玩家燃料真的能让我玩得更好……？")
