/datum/mood_event/hug
	description = "拥抱真好。"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/hug/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/aloof))
		mood_change = -1
		description = "我还是不希望别人碰我。"
		return
	if(HAS_PERSONALITY(owner, /datum/personality/callous))
		mood_change = 0
		description = "我讨厌拥抱。"
		return

/datum/mood_event/bear_hug
	description = "我被抱得很紧，不过感觉还挺好。"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/bear_hug/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/aloof) \
		|| HAS_PERSONALITY(owner, /datum/personality/callous) \
	)
		mood_change = -2
		description = "他们抱得太紧了！"
		return

/datum/mood_event/betterhug
	description = "有人对我特别好。"
	mood_change = 3
	timeout = 4 MINUTES

/datum/mood_event/betterhug/add_effects(mob/friend)
	if(HAS_PERSONALITY(owner, /datum/personality/aloof))
		mood_change = 1
		description = "[friend.name]人很好，但我希望别再碰我了。"
		return
	if(HAS_PERSONALITY(owner, /datum/personality/callous))
		mood_change = 0
		description = "[friend.name]好得让这座空间站都配不上。"
		return

	description = "[friend.name]对我特别好。"

/datum/mood_event/besthug
	description = "和那个人待在一起真好，让我开心极了！"
	mood_change = 5
	timeout = 4 MINUTES

/datum/mood_event/besthug/add_effects(mob/friend)
	if(HAS_PERSONALITY(owner, /datum/personality/aloof))
		mood_change = 2
		description = "和[friend.name]待在一起很愉快，但我希望别再碰我了。"
		return
	if(HAS_PERSONALITY(owner, /datum/personality/callous))
		mood_change = 0
		description = "[friend.name]好得让这座空间站都配不上。"
		return

	description = "和[friend.name]待在一起真好，让我开心极了！"

/datum/mood_event/warmhug
	description = "温暖舒服的拥抱最棒了！"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/warmhug/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/aloof))
		mood_change = 0
		description = "我还是不希望别人碰我，不过暖暖的感觉真不错……"
		return
	if(HAS_PERSONALITY(owner, /datum/personality/callous))
		mood_change = 0
		description = "我讨厌拥抱。我可以自己取暖。"
		return

/datum/mood_event/tailpulled
	description = "我喜欢别人拉我的尾巴！"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/tailpulled/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/aloof) \
		|| HAS_PERSONALITY(owner, /datum/personality/callous) \
	)
		mood_change = -2
		description = "到底是谁在碰我的尾巴？"

/datum/mood_event/arcade
	description = "我打通了街机游戏！"
	mood_change = 3
	timeout = 8 MINUTES
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/arcade/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/industrious) || HAS_PERSONALITY(owner, /datum/personality/slacking/diligent))
		mood_change = -1
		description = "哇，游戏通关了。这些时间本来可以拿来做点有用的事。"

/datum/mood_event/blessing
	description = "我受到了祝福。"
	mood_change = 1
	timeout = 8 MINUTES
	event_flags = MOOD_EVENT_SPIRITUAL

/datum/mood_event/maintenance_adaptation
	mood_change = 8

/datum/mood_event/maintenance_adaptation/add_effects()
	description = "[GLOB.deity]帮助我适应了维护通道！"

/datum/mood_event/book_nerd
	description = "我最近读了一本书。"
	mood_change = 1
	timeout = 5 MINUTES

/datum/mood_event/book_nerd/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/erudite))
		mood_change = 2
		description = "我喜欢读书！"
	if(HAS_PERSONALITY(owner, /datum/personality/uneducated))
		mood_change = -1
		description = "谁在乎书啊？"

/datum/mood_event/exercise
	description = "锻炼释放内啡肽，让人心情舒畅！"
	mood_change = 1

/datum/mood_event/exercise/add_effects(fitness_level)
	mood_change = fitness_level // the more fit you are, the more you like to work out
	if(HAS_PERSONALITY(owner, /datum/personality/slacking/lazy))
		mood_change *= -0.5
		description = "锻炼真是件苦差事！"
	else if(!HAS_PERSONALITY(owner, /datum/personality/athletic))
		mood_change *= 0.5
		description = "锻炼虽然有点累人，但还挺有成就感。"

/datum/mood_event/pet_animal
	description = "动物太可爱了！我忍不住一直摸它们！"
	timeout = 5 MINUTES
	/// Tracks the typepath of animal we last petted
	var/animal_type

/datum/mood_event/pet_animal/add_effects(mob/animal)
	animal_type = animal?.type

	if(HAS_PERSONALITY(owner, /datum/personality/animal_disliker))
		mood_change = -1
		description = "咦，[animal]真脏！我不想碰它！"
		return

	var/dog_fan = HAS_PERSONALITY(owner, /datum/personality/dog_fan)
	var/isdog = istype(animal, /mob/living/basic/pet/dog)
	var/cat_fan = HAS_PERSONALITY(owner, /datum/personality/cat_fan)
	var/iscat = istype(animal, /mob/living/basic/pet/cat)
	if((dog_fan && isdog) || (cat_fan && iscat) || HAS_PERSONALITY(owner, /datum/personality/animal_friend))
		mood_change = 3
		description = "我太喜欢[animal]了，真是可爱极了！我忍不住一直摸！"
		return
	if(dog_fan && iscat)
		mood_change = -1
		description = "我不喜欢[animal]！我更喜欢狗！"
		return
	if(cat_fan && isdog)
		mood_change = -1
		description = "我不喜欢[animal]！我更喜欢猫！"
		return

	mood_change = 1
	description = "[animal]真可爱！"

// Change the moodlet if we get refreshed (we may have pet another type of animal)
/datum/mood_event/pet_animal/be_refreshed(datum/mood/home, mob/animal)
	. = ..()
	if(animal_type == animal?.type)
		return
	add_effects(animal)

/datum/mood_event/honk
	description = "我的鼻子被按得嗷了一声！"
	mood_change = 2
	timeout = 4 MINUTES
	special_screen_obj = "honked_nose"
	special_screen_replace = FALSE
	event_flags = MOOD_EVENT_WHIMSY

/datum/mood_event/saved_life
	description = "救人一命的感觉真好。"
	mood_change = 6
	timeout = 8 MINUTES

/datum/mood_event/saved_life/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/callous))
		mood_change = 0
		description = "我不怎么在乎救人。"
	if(HAS_PERSONALITY(owner, /datum/personality/misanthropic))
		mood_change = -1
		description = "救人是在浪费时间。"

/datum/mood_event/oblivious
	description = "多么美好的一天。"
	mood_change = 3

/datum/mood_event/jolly
	description = "我莫名其妙地感到开心。"
	mood_change = 6
	timeout = 2 MINUTES

/datum/mood_event/focused
	description = "我有一个目标，无论付出什么代价都要实现！" //Used for syndies, nukeops etc so they can focus on their goals
	mood_change = 8
	hidden = TRUE

/datum/mood_event/badass_antag
	description = "我他妈就是个狠角色，周围所有人都知道。看看他们，光想到我就在附近，就全都吓得发抖。"
	mood_change = 8
	hidden = TRUE
	special_screen_obj = "badass_sun"
	special_screen_replace = FALSE

/datum/mood_event/ling
	description = "我们有一个目标，无论付出什么代价都要实现！"
	mood_change = 12
	hidden = TRUE

/datum/mood_event/creeping
	description = "那些声音终于放过了我的心智！我又自由了！" //creeps get it when they are around their obsession
	mood_change = 18
	timeout = 3 SECONDS
	hidden = TRUE

/datum/mood_event/creeping/dead
	mood_change = 8
	timeout = 0

/datum/mood_event/revolution
	description = "革命万岁！"
	mood_change = 3
	hidden = TRUE

/datum/mood_event/cult
	description = "我已见证真理，赞美全能之主！"
	mood_change = 12 //maybe being a cultist isn't that bad after all
	hidden = TRUE

/datum/mood_event/heretics
	description = "升得越高，见得越多。"
	mood_change = 12 //maybe being a heretic isnt that bad after all
	hidden = TRUE

/datum/mood_event/rift_fishing
	description = "钓得越多，升得越高。"
	mood_change = 6
	timeout = 5 MINUTES

/datum/mood_event/blood_worm
	description = "杀戮，吞噬，繁衍，征服。"
	mood_change = 999 // Makes it bold green and gives the special obj a higher priority. Blood worm hosts are apathetic, so this is otherwise meaningless.
	hidden = TRUE

/datum/mood_event/family_heirloom
	description = "我的传家宝安全地待在我身边。"
	mood_change = 1

/datum/mood_event/clown_enjoyer_pin
	description = "我喜欢炫耀我的小丑徽章！"
	mood_change = 1

/datum/mood_event/mime_fan_pin
	description = "我喜欢炫耀我的默剧演员徽章！"
	mood_change = 1

/datum/mood_event/goodmusic
	description = "这段音乐有种让人安心的力量。"
	mood_change = 3
	timeout = 60 SECONDS
	event_flags = MOOD_EVENT_ART

/datum/mood_event/chemical_euphoria
	description = "嘿……嘿嘿嘿……嘿嘿……"
	mood_change = 4

/datum/mood_event/chemical_laughter
	description = "笑容果然是最好的良药！真的是吗？"
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/chemical_superlaughter
	description = "*笑得喘不过气*"
	mood_change = 12
	timeout = 3 MINUTES

/datum/mood_event/religiously_comforted
	description = "圣洁之人在身边，让我感到安心。"
	mood_change = 3
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_SPIRITUAL

/datum/mood_event/clownshoes
	description = "这双鞋是小丑的传承，我永远不想脱下来！"
	mood_change = 3

/datum/mood_event/sacrifice_good
	description = "诸神对这份祭品很满意！"
	mood_change = 5
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_SPIRITUAL

/datum/mood_event/sacrifice_good/add_effects(...)
	if(owner.mind?.holy_role && GLOB.deity)
		description = "[GLOB.deity]对这份祭品很满意！"

/datum/mood_event/artok
	description = "看到这里有人创作艺术，感觉真好。"
	mood_change = 2
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_ART

/datum/mood_event/artgood
	description = "真是一件发人深省的艺术品。我会记住它很久。"
	mood_change = 4
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_ART

/datum/mood_event/artgreat
	description = "那件艺术品太出色了，让我重新相信人性的美好。在这种地方，这可不容易。"
	mood_change = 6
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_ART

/datum/mood_event/bottle_flip
	description = "瓶子那样稳稳落地，真让人满足。"
	mood_change = 2
	timeout = 3 MINUTES

/datum/mood_event/hope_lavaland
	description = "真是个奇特的徽记。它让我对未来充满希望。"
	mood_change = 6

/datum/mood_event/hope_lavaland/add_effects(...)
	if(HAS_PERSONALITY(owner, /datum/personality/pessimistic))
		mood_change = 0
		description = "这个徽记是个谎言。我没有希望了。"
		return

/datum/mood_event/confident_mane
	description = "满头秀发让我自信满满。"
	mood_change = 2

/datum/mood_event/holy_consumption
	description = "那真是神明的佳肴！"
	mood_change = 1 // 1 + 5 from it being liked food makes it as good as jolly
	timeout = 3 MINUTES

/datum/mood_event/high_five
	description = "我喜欢和人击掌！"
	mood_change = 2
	timeout = 45 SECONDS

/datum/mood_event/helped_up
	description = "扶人起来的感觉真好！"
	timeout = 45 SECONDS

/datum/mood_event/helped_up/can_effect_mob(datum/mood/home, mob/living/who, ...)
	if(!HAS_PERSONALITY(owner, /datum/personality/compassionate) \
		&& !HAS_PERSONALITY(owner, /datum/personality/callous) \
		&& !HAS_PERSONALITY(owner, /datum/personality/misanthropic))
		return FALSE

	return ..()

/datum/mood_event/helped_up/add_effects(mob/other_person, helper)
	if(!other_person)
		return

	if(HAS_PERSONALITY(owner, /datum/personality/callous) || HAS_PERSONALITY(owner, /datum/personality/misanthropic))
		mood_change = -2
		if(helper)
			description = "他们应该自己想办法起来。"
		else
			description = "我本来能自己起来的。"

	else if(HAS_PERSONALITY(owner, /datum/personality/compassionate))
		mood_change = 2
		if(helper)
			description = "扶起[other_person]的感觉真好！"
		else
			description = "[other_person]扶我起来了，真是个好人！"

/datum/mood_event/high_ten
	description = "太棒了！双手击掌！"
	mood_change = 3
	timeout = 45 SECONDS
	event_flags = MOOD_EVENT_WHIMSY

/datum/mood_event/down_low
	description = "哈！真是个傻瓜，从一开始就被我耍得团团转……"
	mood_change = 4
	timeout = 90 SECONDS
	event_flags = MOOD_EVENT_WHIMSY

/datum/mood_event/aquarium_positive
	description = "看着水族箱里的鱼，让人心情平静。"
	mood_change = 3
	timeout = 90 SECONDS

/datum/mood_event/gondola
	description = "我感到内心平静，完全不想做出突然或鲁莽的举动。"
	mood_change = 6

/datum/mood_event/kiss
	description = "有人给了我一个飞吻，我一定很有魅力！"
	mood_change = 1.5
	timeout = 2 MINUTES

/datum/mood_event/kiss/add_effects(mob/beau, direct)
	if(!beau)
		return
	if(direct)
		description = "[beau.name]亲了我一下，啊啊！！"
	else
		description = "[beau.name]给了我一个飞吻，我一定很有魅力！"

/datum/mood_event/honorbound
	description = "恪守荣誉准则让我感到充实！"
	mood_change = 4

/datum/mood_event/et_pieces
	description = "嗯……我爱花生酱……"
	mood_change = 50
	timeout = 10 MINUTES

/datum/mood_event/memories_of_home
	description = "这味道莫名让人怀念……"
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/observed_soda_spill
	description = "啊哈哈！看见有人被汽水喷一身总是很好笑。"
	mood_change = 2
	timeout = 30 SECONDS
	event_flags = MOOD_EVENT_WHIMSY

/datum/mood_event/observed_soda_spill/add_effects(mob/spilled_mob, atom/soda_can)
	if(!spilled_mob)
		return

	description = "啊哈哈！[spilled_mob]把[soda_can ? soda_can.name : "汽水"]洒了自己一身！经典场面。"

/datum/mood_event/gaming
	description = "我正享受愉快的游戏时光！"
	mood_change = 2
	timeout = 30 SECONDS
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/gaming/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/industrious) || HAS_PERSONALITY(owner, /datum/personality/slacking/diligent))
		mood_change = -1
		description = "现在真是玩游戏的时候吗？我应该去工作。"

/datum/mood_event/gamer_won
	description = "我喜欢在游戏里赢！"
	mood_change = 6
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/love_reagent
	description = "这食物让我想起了往日的美好时光。"
	mood_change = 5

/datum/mood_event/love_reagent/add_effects(duration)
	if(HAS_PERSONALITY(owner, /datum/personality/pessimistic))
		mood_change = 0
		description = "这食物大概还行吧。"
		return

	if(isnum(duration))
		timeout = duration

/datum/mood_event/won_52_card_pickup
	description = "哈！那个倒霉蛋得捡好久的牌了！"
	mood_change = 3
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_WHIMSY | MOOD_EVENT_GAMING

/datum/mood_event/playing_cards
	description = "和大家一起玩牌真开心！"
	mood_change = 2
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/playing_cards/add_effects(param)
	var/card_players = 1
	for(var/mob/living/carbon/player in viewers(COMBAT_MESSAGE_RANGE, owner))
		var/player_has_cards = player.is_holding(/obj/item/toy/singlecard) || player.is_holding_item_of_type(/obj/item/toy/cards)
		if(player_has_cards)
			card_players++
			if(card_players > 5)
				break

	mood_change *= card_players
	return ..()

/datum/mood_event/garland
	description = "这些花让人很安心。"
	mood_change = 1

/datum/mood_event/russian_roulette_win
	description = "我拿性命作赌注，而且赢了！能活着真是幸运……"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/russian_roulette_win/add_effects(loaded_rounds)
	var/base = HAS_PERSONALITY(owner, /datum/personality/gambler) ? 2 : 1.8
	mood_change = round(base ** loaded_rounds, 1)

/datum/mood_event/fishing
	description = "钓鱼真让人放松。"
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/fish_released
	description = "去吧，鱼儿，自由地游吧！"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/fish_released/add_effects(morbid, obj/item/fish/fish)
	if(!morbid)
		description = "去吧，[fish.name]，自由地游吧！"
		return
	if(fish.status == FISH_DEAD)
		description = "总会有食腐动物用得上[fish.name]的遗骸。真是物尽其用。"
	else
		description = "又回到了深水中的苦难。可这真是仁慈吗，[fish.name]？总会有更大的鱼……"

/datum/mood_event/fish_petting
	description = "摸摸鱼儿的感觉真好。"
	mood_change = 2
	timeout = 2 MINUTES
	event_flags = MOOD_EVENT_WHIMSY

/datum/mood_event/fish_petting/add_effects(obj/item/fish/fish, morbid)
	if(!morbid)
		description = "摸摸[fish]的感觉真好。"
	else
		description = "我抚摸着[fish]，它在我手下扭动，对这个世界的残酷浑然不知。"

/datum/mood_event/kobun
	description = "宇宙爱着我们每一个人。我并不孤单，你也一样。"
	mood_change = 14
	timeout = 10 SECONDS

/datum/mood_event/sabrage_success
	description = "我成功用刀开了香槟！露一手的感觉真好。"
	mood_change = 2
	timeout = 4 MINUTES

/datum/mood_event/sabrage_witness
	description = "我看到有人用相当炫酷的方式打开了香槟瓶。"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/birthday
	description = "今天是我的生日！"
	mood_change = 2
	special_screen_obj = "birthday"
	special_screen_replace = FALSE

/datum/mood_event/basketball_score
	description = "唰！空心入网。"
	mood_change = 2
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_WHIMSY | MOOD_EVENT_GAMING

/datum/mood_event/basketball_dunk
	description = "灌篮！轰，沙卡拉卡！"
	mood_change = 2
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_WHIMSY | MOOD_EVENT_GAMING

/datum/mood_event/moon_smile
	description = "月亮向我揭示真理，并对我展露微笑！！！"
	mood_change = 10
	timeout = 2 MINUTES

///Wizard cheesy grand finale - what the wizard gets
/datum/mood_event/madness_elation
	description = "疯狂确实是最伟大的赐福……"
	mood_change = 200

/datum/mood_event/prophat
	description = "这顶帽子让我充满了奇妙的快乐！"
	mood_change = 2
	event_flags = MOOD_EVENT_WHIMSY

/datum/mood_event/slots
	description = "我们去赌一把！"
	mood_change = 1
	timeout = 1 MINUTES
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/slots/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/gambler))
		mood_change *= 2
	else if(HAS_PERSONALITY(owner, /datum/personality/industrious) || HAS_PERSONALITY(owner, /datum/personality/slacking/diligent))
		mood_change *= -1
		description = "我为什么要把时间和金钱都浪费在赌博上？"


/datum/mood_event/slots/win
	description = "好耶，我赢了！"
	mood_change = 2
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/slots/win/be_replaced(datum/mood/home, datum/mood_event/new_event, ...)
	if(istype(new_event, /datum/mood_event/slots/all_gone))
		return ALLOW_NEW_MOOD
	if(new_event.mood_change < mood_change)
		return BLOCK_NEW_MOOD
	return ..()

/datum/mood_event/slots/win/big
	mood_change = 3
	timeout = 10 MINUTES

/datum/mood_event/slots/win/jackpot
	description = "头奖！好耶！"
	mood_change = 4

/datum/mood_event/slots/all_gone
	description = "不——！全都没了！！！"
	mood_change = -2
	timeout = 20 MINUTES

/datum/mood_event/slots/all_gone/be_replaced(datum/mood/home, datum/mood_event/new_event, ...)
	if(istype(new_event, /datum/mood_event/slots/win/jackpot))
		return ALLOW_NEW_MOOD
	description = "我再也赢不回来了……"
	return BLOCK_NEW_MOOD

/datum/mood_event/empathetic_happy
	description = "看见别人开心，我也会开心。"
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/misanthropic_happy
	description = "看见别人难过，我就高兴。"
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/paranoid/alone
	description = "安宁又平静，周围没有人会威胁我。"
	mood_change = 1

/datum/mood_event/paranoid/small_group
	description = "待在这个小团体里更有安全感。我们彼此照应。"
	mood_change = 2

/datum/mood_event/nt_loyalist
	description = "身为纳米传讯™大家庭的一员，我深感自豪！"
	mood_change = 2

/datum/mood_event/loyalist_revs_lost
	description = "革命被镇压了！纳米传讯万岁！"
	mood_change = 4
	timeout = 10 MINUTES

/datum/mood_event/disillusioned_revs_win
	description = "革命成功了！革命万岁！"
	mood_change = 4
	timeout = 10 MINUTES

/datum/mood_event/enjoying_department_area
	description = "我热爱自己的工作。"
	mood_change = 1

/datum/mood_event/slacking_off_lazy
	description = "老板赚一块，我只赚一毛，所以上班摸鱼才合理。"
	mood_change = 1

/datum/mood_event/working_diligent
	description = "努力工作本身就是一种回报。"
	mood_change = 1

/datum/mood_event/creative_patronage
	description = "支持艺术家！"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/creative_framing
	description = "挂上艺术品，让整个房间协调多了。"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/creative_sculpting
	description = "雕刻是发挥创造力的绝佳方式。"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/whimsical_slip
	description = "哈哈！那家伙摔倒了！"
	mood_change = 3
	timeout = 2 MINUTES
	event_flags = MOOD_EVENT_WHIMSY

/datum/mood_event/bibulous_hangover
	description = "多棒的一夜！我等不及再来一次了！"
	mood_change = 2
	timeout = 10 MINUTES

/datum/mood_event/gizmo_positive
	description = "我听见一个声音在耳边轻声说着温柔的话！"
	mood_change = 3
	timeout = 30 SECONDS
