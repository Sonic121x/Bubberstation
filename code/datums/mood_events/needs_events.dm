//nutrition
/datum/mood_event/fat
	description = "<B>我好胖啊……</B>" //muh fatshaming
	mood_change = -6

/datum/mood_event/too_wellfed
	description = "我想我吃得太多了。"
	mood_change = 0

/datum/mood_event/wellfed
	description = "我吃撑了！"
	mood_change = 8

/datum/mood_event/fed
	description = "我刚吃过东西。"
	mood_change = 5

/datum/mood_event/hungry
	description = "我开始有点饿了。"
	mood_change = -3

/datum/mood_event/hungry_very
	description = "我饿了！"
	mood_change = -6

/datum/mood_event/starving
	description = "我快饿死了！"
	mood_change = -10

//charge
/datum/mood_event/supercharged
	description = "我快储存不下这些能量了，得赶紧释放一些！"
	mood_change = -10

/datum/mood_event/overcharged
	description = "我感觉电量过载得很危险，也许该释放一些能量。"
	mood_change = -4

/datum/mood_event/charged
	description = "我能感到能量在血管中流淌！"
	mood_change = 6

/datum/mood_event/lowpower
	description = "我的电量不足了，应该找个地方充电。"
	mood_change = -6

/datum/mood_event/decharged
	description = "我急需补充电力！"
	mood_change = -10

//Disgust
/datum/mood_event/gross
	description = "我看到了恶心的东西。"
	mood_change = -4

/datum/mood_event/verygross
	description = "我觉得我要吐了……"
	mood_change = -6

/datum/mood_event/disgusted
	description = "天哪，真恶心……"
	mood_change = -8

/datum/mood_event/disgust/bad_smell
	description = "我能闻到这个房间里有东西严重腐烂了。"
	mood_change = -6

/datum/mood_event/disgust/nauseating_stench
	description = "腐尸的恶臭令人无法忍受！"
	mood_change = -12

/datum/mood_event/disgust/dirty_food
	description = "那东西太脏了，根本不该吃……"
	mood_change = -6
	timeout = 4 MINUTES

/datum/mood_event/disgust/dirty_food/add_effects(...)
	if(HAS_PERSONALITY(owner, /datum/personality/ascetic))
		mood_change *= 0.25
		description = "那食物虽然脏，但还能吃。"
	if(HAS_PERSONALITY(owner, /datum/personality/gourmand))
		mood_change *= 1.5
		description = "那食物脏透了，是在垃圾箱里做的吗？！"

//Generic needs events
/datum/mood_event/shower
	description = "我刚舒舒服服地洗了个澡。"
	mood_change = 4
	timeout = 5 MINUTES

/datum/mood_event/shower/add_effects(shower_reagent)
	if(istype(shower_reagent, /datum/reagent/blood))
		if(HAS_TRAIT(owner, TRAIT_MORBID) || HAS_TRAIT(owner, TRAIT_EVIL) || (owner.mob_biotypes & MOB_UNDEAD))
			description = "美妙的鲜血淋浴真让人舒服。"
			mood_change = 6 // you sicko
		else
			description = "我刚洗了一场可怕的血雨淋浴！"
			mood_change = -4
			timeout = 3 MINUTES
	else if(istype(shower_reagent, /datum/reagent/water))
		if(HAS_TRAIT(owner, TRAIT_WATER_HATER) && !HAS_TRAIT(owner, TRAIT_WATER_ADAPTATION))
			description = "我讨厌浑身湿漉漉的！"
			mood_change = -2
			timeout = 3 MINUTES
		else
			return // just normal clean shower
	else // it's dirty ass water
		description = "我刚洗了一场脏兮兮的澡！"
		mood_change = -3
		timeout = 3 MINUTES

/datum/mood_event/hot_spring
	description = "泡在热气腾腾的水里真让人放松……"
	mood_change = 5

/datum/mood_event/hot_spring_hater
	description = "不，不，不，不，我不想洗澡！"
	mood_change = -2

/datum/mood_event/hot_spring_left
	description = "刚才的澡洗得真舒服。"
	mood_change = 4
	timeout = 4 MINUTES

/datum/mood_event/hot_spring_hater_left
	description = "我讨厌洗澡！更讨厌一出来就冷得要命！"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/fresh_laundry
	description = "没什么比穿上刚洗好的连身服更舒服了。"
	mood_change = 2
	timeout = 10 MINUTES

/datum/mood_event/surrounded_by_silicon
	description = "我被完美的生命体包围了！！"
	mood_change = 8

/datum/mood_event/around_many_silicon
	description = "我身边有好多硅基生命！"
	mood_change = 4

/datum/mood_event/around_silicon
	description = "我身边的硅基生命简直完美无缺。"
	mood_change = 2

/datum/mood_event/around_organic
	description = "我身边的有机生命让我想起了血肉的低劣。"
	mood_change = -2

/datum/mood_event/around_many_organic
	description = "好多恶心的有机生命！"
	mood_change = -4

/datum/mood_event/surrounded_by_organic
	description = "我被恶心的有机生命包围了！！"
	mood_change = -8

/datum/mood_event/completely_robotic
	description = "我抛弃了孱弱的血肉，我的形态完美无缺！！"
	mood_change = 8

/datum/mood_event/very_robotic
	description = "我的身体里机械比血肉还多！"
	mood_change = 4

/datum/mood_event/balanced_robotic
	description = "我的身体一部分是机械，一部分是血肉。"
	mood_change = 0

/datum/mood_event/very_organic
	description = "我讨厌这孱弱无力的血肉！"
	mood_change = -4

/datum/mood_event/completely_organic
	description = "我完全由血肉组成，真是悲惨！！"
	mood_change = -8
