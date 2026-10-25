/// A doctor successfuly completed a surgery on someone.
/datum/memory/surgery
	story_value = STORY_VALUE_OKAY
	// Protagonist - The surgeon, completing the surgery
	// Deuteragonist - The mob being operated on
	/// What type of surgery it was
	var/surgery_type

/datum/memory/surgery/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	surgery_type,
)
	src.surgery_type = surgery_type
	return ..()

/datum/memory/surgery/get_names()
	return list("[protagonist_name]为[deuteragonist_name]进行的[surgery_type]。")

/datum/memory/surgery/get_starts()
	return list(
		"[protagonist_name]小心翼翼地为[deuteragonist_name]进行[surgery_type]",
		"[protagonist_name]正在对[deuteragonist_name]使用骨锯",
		"[protagonist_name]正在为[deuteragonist_name]做手术",
	)

/datum/memory/surgery/get_moods()
	return list(
		"[protagonist_name]完成[surgery_type]后，[mood_verb]。",
		"鲜血溅到[protagonist_name]脸上，[protagonist_name][mood_verb]。",
		"[surgery_type]仍在继续，[protagonist_name][mood_verb]。",
		"[protagonist_name]剖开[deuteragonist_name]的身体时，[mood_verb]。",
		"[protagonist_name]切入[deuteragonist_name]的身体时，[mood_verb]。",
	)

/// Planted a bomb.
/datum/memory/bomb_planted
	story_value = STORY_VALUE_MEH
	// Protagonist - Whoever armed the bomb
	// Antaognist - The bomb that was armed

/datum/memory/bomb_planted/get_names()
	return list("[protagonist_name]启动了[antagonist_name]。")

/datum/memory/bomb_planted/get_starts()
	return list(
		"[protagonist_name]按下一个不祥的按钮，[antagonist_name]开始发出哔哔声",
		"[protagonist_name]重重地放下[antagonist_name]",
		"[protagonist_name]正在启动[antagonist_name]",
	)

/datum/memory/bomb_planted/get_moods()
	return list(
		"[protagonist_name][mood_verb]，开始走远。",
		"计时器开始滴答作响，[protagonist_name][mood_verb]。",
		"倒计时逐渐归零，[protagonist_name][mood_verb]。",
		"哔……哔……[protagonist_name][mood_verb]。"
	)

/datum/memory/bomb_planted/get_happy_moods()
	return list("觉得真酷的人从不回头看[antagonist_name]")

/// Planted a SYNDICATE bomb.
/datum/memory/bomb_planted/syndicate
	story_value = STORY_VALUE_AMAZING

/// Planted a NUKE!
/datum/memory/bomb_planted/nuke
	story_value = STORY_VALUE_LEGENDARY

/// Got a sweet high five.
/datum/memory/high_five
	story_value = STORY_VALUE_MEH
	// Protagonist - One of the high-fivers
	// Deuteragonist - The other high fiver
	/// What type of high five it was - A "high five" or a "high ten"
	var/high_five_type

/datum/memory/high_five/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	high_five_type,
	high_ten = FALSE,
)
	src.high_five_type = high_five_type == "high five" ? "击掌" : high_five_type == "high ten" ? "双手击掌" : high_five_type
	src.story_value = high_ten ? STORY_VALUE_OKAY : STORY_VALUE_MEH
	return ..()

/datum/memory/high_five/get_names()
	return list("[protagonist_name]与[deuteragonist_name]的[high_five_type]。")

/datum/memory/high_five/get_starts()
	return list(
		"[protagonist_name]和[deuteragonist_name]来了一次堪称传奇的[high_five_type]",
		"[protagonist_name]向[deuteragonist_name]送上一次[high_five_type]",
		"[protagonist_name]和[deuteragonist_name]互相[high_five_type]",
	)

/datum/memory/high_five/get_moods()
	return list(
		"双方成功[high_five_type]，[protagonist_name][mood_verb]。",
		"面对这份同伴之情，[protagonist_name][mood_verb]。",
		"多棒的一次[high_five_type]！[protagonist_name][mood_verb]。",
		"哇！[protagonist_name][mood_verb]！",
	)

/// Was cyborgized.
/datum/memory/was_cyborged
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_FLAG_NOMOOD|MEMORY_SKIP_UNCONSCIOUS
	// Protagonist - The mind of who was just cyborgized

/datum/memory/was_cyborged/get_names()
	return list("[protagonist_name]被改造成了半机械人。")

/datum/memory/was_cyborged/get_starts()
	return list(
		"[protagonist_name]的大脑被装进了机器人",
		"[protagonist_name]被变成了一堆螺丝钉",
	)

/// Witnessed someone die nearby.
/datum/memory/witnessed_death
	story_value = STORY_VALUE_MEH // this is pretty common on this hellhole
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS|MEMORY_FLAG_NOMOOD
	// Protagonist - Who died

/datum/memory/witnessed_death/get_names()
	return list("[protagonist_name]的死亡。")

/datum/memory/witnessed_death/get_starts()
	return list(
		"[protagonist_name]已经死去",
		"[protagonist_name]浑身一僵，随后瘫软倒下，双眼失去生气",
		"[protagonist_name]的心脏停止了跳动",
		"[protagonist_name]迎来了死亡",
	)

/// Witnessed someone get creampied nearby.
/datum/memory/witnessed_creampie
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The mob that got pied

/datum/memory/witnessed_creampie/get_names()
	return list("[protagonist_name]被奶油糊了一脸。")

/datum/memory/witnessed_creampie/get_starts()
	return list(
		"[protagonist_name]满脸都是奶油",
		"[protagonist_name]被奶油派砸中了",
	)

/datum/memory/witnessed_creampie/get_moods()
	return list(
		"奶油从[protagonist_name]脸上滴落，[protagonist_name][mood_verb]。",
		"想到又多了些要洗的衣服，[protagonist_name][mood_verb]。",
		"[protagonist_name]舔了点派上的奶油，[mood_verb]。",
	)

/// Witnessed someone get splashed with squid ink.
/datum/memory/witnessed_inking
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The mob that got pied

/datum/memory/witnessed_inking/get_names()
	return list("[protagonist_name]被喷了一脸墨汁。")

/datum/memory/witnessed_inking/get_starts()
	return list(
		"[protagonist_name]的脸上沾满了鱿鱼墨汁",
		"[protagonist_name]被鱿鱼墨汁喷中了",
	)

/datum/memory/witnessed_inking/get_moods()
	return list(
		"墨汁从[protagonist_name]脸上滴落，[protagonist_name][mood_verb]。",
		"想到又多了些要洗的衣服，[protagonist_name][mood_verb]。",
		"[protagonist_name]擦去脸上的墨汁，[mood_verb]。",
	)

/// Got slipped by something.
/datum/memory/was_slipped
	story_value = STORY_VALUE_MEH
	// Protagonist - The mob that got slipped
	// Antagonist - The thing that did the slipping (banana peel, etc)

/datum/memory/was_slipped/get_names()
	return list("[protagonist_name]滑倒了。")

/datum/memory/was_slipped/get_starts()
	return list(
		"面对[antagonist_name]，[protagonist_name]没能站稳",
		"[protagonist_name]在[antagonist_name]上摔了个跟头",
		"[antagonist_name]让[protagonist_name]摔了个四脚朝天",
	)

/datum/memory/was_slipped/get_moods()
	return list(
		"[protagonist_name]从地上爬起来，[mood_verb]。",
		"[protagonist_name]躺在地上，[mood_verb]。",
	)

/datum/memory/was_slipped/get_sad_moods()
	return list("沮丧得连爬起来都不愿意")

/datum/memory/was_slipped/build_story_character(character)
	// We can slip on turfs, so we should account for it
	if(isturf(character))
		var/turf/place = character
		return "[prob(50) ? "危险的" : ""][pick("潮湿的", "涂满润滑剂的", "湿滑的", "冰冷的")][place.name]"

	return ..()

/// Had spaghetti fall from their pockets.
/datum/memory/lost_spaghetti
	story_value = STORY_VALUE_AMAZING // This doesn't happen very often
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The mob losing their spaghet

/datum/memory/lost_spaghetti/get_names()
	return list("[protagonist_name]的意大利面糗事。")

/datum/memory/lost_spaghetti/get_starts()
	return list(
		"意大利面从[protagonist_name]的口袋里倾泻而出",
		"[protagonist_name]的口袋已经装不下意大利面了",
	)

/datum/memory/lost_spaghetti/get_moods()
	return list(
		"意大利面倾泻而出，[protagonist_name][mood_verb]。",
		"[protagonist_name]试图捡起散落的面条，[mood_verb]。",
	)

/// Got kissed! AHHHHH!
/datum/memory/kissed
	story_value = STORY_VALUE_MEH
	// Sorry but blind people can't feel kisses...
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The mob being kissed
	// Deuteragonist - The mob doing the kissing

/datum/memory/kissed/get_names()
	return list("送给[protagonist_name]的飞吻。")

/datum/memory/kissed/get_starts()
	return list(
		"[protagonist_name]收到了[deuteragonist_name]的飞吻",
		"[deuteragonist_name]向[protagonist_name]送出了飞吻",
	)

/datum/memory/kissed/get_moods()
	return list(
		"飞吻落在[protagonist_name]的脸颊上，[protagonist_name][mood_verb]。",
		"就在这一刻，[protagonist_name][mood_verb]。",
	)

/// Had some good food.
/datum/memory/good_food
	story_value = STORY_VALUE_MEH
	// Protagonist - The mob consuming the food
	/// The name of the food item being consumed
	var/food

/datum/memory/good_food/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	obj/item/food,
)
	src.food = food.name
	return ..()

/datum/memory/good_food/get_names()
	return list("[protagonist_name]吃过的美味[food]。")

/datum/memory/good_food/get_starts()
	return list(
		"[food]改变了[protagonist_name]对美食的看法",
		"[food]让[protagonist_name]吃得肚子圆滚滚的",
		"[food]给[protagonist_name]留下了难忘的印象",
		"[protagonist_name]正享用美味无比的[food]",
		"[protagonist_name]吃下[food]后，露出了日常动画角色般夸张的反应",
	)

/datum/memory/good_food/get_moods()
	return list("[protagonist_name]又吃了一口，[mood_verb]。")

/// Had a good drink.
/datum/memory/good_drink
	story_value = STORY_VALUE_MEH
	// Protagonist - The mob consuming the drink
	/// The name of the nice drink reagent
	var/drink

/datum/memory/good_drink/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	datum/reagent/drink,
)
	src.drink = drink.name
	return ..()

/datum/memory/good_drink/get_names()
	return list("[protagonist_name]喝过的美味[drink]。")

/datum/memory/good_drink/get_starts()
	return list(
		"[drink]改变了[protagonist_name]对优雅饮酒的看法",
		"[drink]给[protagonist_name]留下了难忘的印象",
		"[protagonist_name]正享用美味无比的[drink]",
		"[protagonist_name]正啜饮可口的[drink]",
	)

/datum/memory/good_drink/get_moods()
	return list("[protagonist_name]又喝了一口，[mood_verb]。")

/// Was set on fire and started to burn.
/datum/memory/was_burning
	story_value = STORY_VALUE_MEH
	// Protagonist - The mob burning

/datum/memory/was_burning/get_names()
	return list("[protagonist_name]浑身燃烧。")

/datum/memory/was_burning/get_starts()
	return list(
		"[protagonist_name]突然燃烧起来",
		"[protagonist_name]变成了人形火炬",
		"大火吞没了[protagonist_name]",
	)

/datum/memory/was_burning/get_moods()
	return list("[protagonist_name]的皮肤逐渐融化，[protagonist_name][mood_verb]。")

/// Got a limb removed by force.
/datum/memory/was_dismembered
	story_value = STORY_VALUE_AMAZING
	// Protagonist - The mob who lost a limb
	/// The limb (in plaintext) that got lost (ends up being "left arm" or "right leg")
	var/lost_limb

/datum/memory/was_dismembered/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	obj/item/bodypart/lost_limb,
)
	src.lost_limb = chinese_body_zone_display(lost_limb.plaintext_zone)
	return ..()

/datum/memory/was_dismembered/get_names()
	return list("[protagonist_name]失去了[lost_limb]。")

/datum/memory/was_dismembered/get_starts()
	return list(
		"[protagonist_name]获得了使用残疾人停车位的资格",
		"[protagonist_name]的[lost_limb]被打飞到深渊中",
		"[protagonist_name]的[lost_limb]飞了出去",
	)

/datum/memory/was_dismembered/get_moods()
	return list(
		"失去[lost_limb]后，[protagonist_name][mood_verb]。",
		"[protagonist_name]没了[lost_limb]，[mood_verb]。",
	)

/// Our pet died...
/datum/memory/pet_died
	story_value = STORY_VALUE_AMAZING
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS
	// Protagonist - The mob who saw the pet die
	// Deuteragonist - The pet which died

/datum/memory/pet_died/get_names()
	return list("[deuteragonist_name]的死亡。")

/datum/memory/pet_died/get_starts()
	return list(
		"大家正在悼念空间站的宠物[deuteragonist_name]",
		"一群船员参加了[deuteragonist_name]的葬礼",
		"一个浅坑里躺着[deuteragonist_name]",
	)

/datum/memory/pet_died/get_moods()
	return list(
		"失去[deuteragonist_name]后，[protagonist_name][mood_verb]。",
		"[deuteragonist_name]已经不在了，[protagonist_name][mood_verb]。",
	)

/// The revolution was triumphant!
/// Given to head revs and those nearby when the revs win a revolution.
/datum/memory/revolution_rev_victory
	story_value = STORY_VALUE_LEGENDARY
	memory_flags = MEMORY_FLAG_NOSTATIONNAME|MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS
	// Protagonist - The head revolutionary that won the revolution

/datum/memory/revolution_rev_victory/get_names()
	return list("[protagonist_name]在[station_name()]发动的革命。")

/datum/memory/revolution_rev_victory/get_starts()
	return list(
		"[protagonist_name]在昔日独裁者的尸体上升起了革命旗帜",
		"一面旗帜在尸堆上方飘扬，[protagonist_name]站在其上",
		"一张写着[station_name()]的海报被画上了叉，宣告新时代的到来",
		"前任舰长的雕像倒在地上，[protagonist_name]站在旁边",
	)

/datum/memory/revolution_rev_victory/get_moods()
	return list(
		"见证[station_name()]的陷落，[protagonist_name][mood_verb]。",
		"想到即将到来的新时代，[protagonist_name][mood_verb]。",
	)

/// Given to heads of staff if they lose a revolution and are alive still.
/datum/memory/revolution_heads_defeated
	story_value = STORY_VALUE_NONE
	memory_flags = MEMORY_FLAG_NOSTATIONNAME|MEMORY_SKIP_UNCONSCIOUS
	// Protagonist - The head of staff that lost the revolution

/datum/memory/revolution_heads_defeated/get_names()
	return list("[protagonist_name]败在了革命者手下。")

/datum/memory/revolution_heads_defeated/get_starts()
	return list(
		"革命成功了，[protagonist_name]羞愧地逃离[station_name()]",
		"[protagonist_name]看着监控画面中横行的革命者",
		"一张海报上，[protagonist_name]的脸被划掉了",
	)

/datum/memory/revolution_heads_defeated/get_moods()
	return list(
		"见证[station_name()]的陷落，[protagonist_name][mood_verb]。",
		"面对失败，[protagonist_name][mood_verb]。",
	)

/// Given to head revs for failing the revolution!
/datum/memory/revolution_rev_defeat
	story_value = STORY_VALUE_NONE
	memory_flags = MEMORY_FLAG_NOSTATIONNAME|MEMORY_SKIP_UNCONSCIOUS
	// Protagonist - The head revolutionary that lost the revolution

/datum/memory/revolution_rev_defeat/get_names()
	return list(
		"[protagonist_name]败在了纳米传讯手下。",
		"[protagonist_name]的光荣革命走向了终结。",
	)

/datum/memory/revolution_rev_defeat/get_starts()
	return list("革命失败了，[protagonist_name]羞愧地逃离[station_name()]。")

/datum/memory/revolution_rev_defeat/get_moods()
	return list("面对失败，[protagonist_name][mood_verb]。")

/// Given to heads of staff, and those around them, upon defeating the revolutionaries.
/datum/memory/revolution_heads_victory
	story_value = STORY_VALUE_AMAZING // Not as cool as a rev victory. Everyone loves underdog stories
	memory_flags = MEMORY_FLAG_NOSTATIONNAME|MEMORY_SKIP_UNCONSCIOUS
	// Protagonist - The head of staff that won the revolution

/datum/memory/revolution_heads_victory/get_names()
	return list("[protagonist_name]与纳米传讯成功镇压了可恨的革命。")

/datum/memory/revolution_heads_victory/get_starts()
	return list(
		"镇压革命取得胜利后，[protagonist_name]拍去了手上的灰尘",
		"纳米传讯的旗帜在[station_name()]舰桥上飘扬，[protagonist_name]骄傲地站在旁边",
	)

/datum/memory/revolution_rev_defeat/get_moods()
	return list("纳米传讯击败了革命者，[protagonist_name][mood_verb]。")

/// Watched someone receive a commendation medal
/datum/memory/received_medal
	story_value = STORY_VALUE_AMAZING
	memory_flags = MEMORY_FLAG_NOSTATIONNAME|MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS
	// Protagonist - The person being given a medal
	// Deuteragonist - The mob awarding a medal
	/// The name of the medal being rewarded
	var/medal_type
	/// The text on the medal / the commendation / the input
	var/medal_text

/datum/memory/received_medal/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	obj/item/medal_type,
	medal_text,
)
	src.medal_type = medal_type.name
	src.medal_text = medal_text
	return ..()

/datum/memory/received_medal/get_names()
	return list("向[protagonist_name]颁发[medal_type]的仪式。")

/datum/memory/received_medal/get_starts()
	return list(
		"[protagonist_name]从[deuteragonist_name]手中接过刻着\"[medal_text]\"的[medal_type]",
		"[protagonist_name]获颁了刻着\"[medal_text]\"的[medal_type]",
		"[deuteragonist_name]向[protagonist_name]颁发了一枚刻着\"[medal_text]\"的[medal_type]",
	)

/datum/memory/received_medal/get_moods()
	return list(
		"[protagonist_name]接过勋章时，[mood_verb]。",
		"[protagonist_name]拿着刚获得的奖章，[mood_verb]。",
	)

/// Killed a Megafauna
/datum/memory/megafauna_slayer
	story_value = STORY_VALUE_LEGENDARY
	// Protagonist - The person who killed the megafauna
	// Antagonist - The megafauna

/datum/memory/megafauna_slayer/get_names()
	return list("[antagonist_name]被杀死了。")

/datum/memory/megafauna_slayer/get_starts()
	return list(
		"[protagonist_name]对[antagonist_name]打出了最后一击，将其击倒",
		"[protagonist_name]站在那里，手中提着[antagonist_name]的头",
		"[protagonist_name]杀死了危险的巨型生物[antagonist_name]",
	)

/datum/memory/megafauna_slayer/get_moods()
	return list(
		"眼中的嗜血欲望逐渐消退，[protagonist_name][mood_verb]。",
		"[protagonist_name]在尸体上搜寻贵重物品，[mood_verb]。",
	)

/// Got held at gunpoint by someone!
/datum/memory/held_at_gunpoint
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - Who was held at gunpoint
	// Deuteragonist - Who held them at gunpoint
	// Antagonist - The gun

/datum/memory/held_at_gunpoint/get_names()
	return list("[protagonist_name]被枪口指着。")

/datum/memory/held_at_gunpoint/get_starts()
	return list(
		"[deuteragonist_name]将[antagonist_name]抵在[protagonist_name]的头上",
		"[deuteragonist_name]猛地掏出[antagonist_name]，指向[protagonist_name]",
	)

/datum/memory/held_at_gunpoint/get_moods()
	return list(
		"面对眼前的局面，[protagonist_name][mood_verb]。",
		"[protagonist_name]盯着[antagonist_name]的枪口，[mood_verb]。",
	)


/datum/memory/won_jackpot
	story_value = STORY_VALUE_AMAZING

/datum/memory/won_jackpot/get_names()
	return list("[protagonist_name]赢得了大奖。")

/datum/memory/won_jackpot/get_starts()
	return list(
		"[protagonist_name]两眼放光地拉下了[deuteragonist_name]的拉杆。",
		"[protagonist_name]拉下拉杆时，[deuteragonist_name]响起了一段欢快的旋律。",
	)

/datum/memory/won_jackpot/get_moods()
	return list(
		"[protagonist_name]从[deuteragonist_name]取走奖金，[mood_verb]。",
		"[deuteragonist_name]伴着响亮的声音开始吐出钞票，[protagonist_name][mood_verb]。",
	)

/// Saw someone get gibbed.
/datum/memory/witness_gib
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_FLAG_NOMOOD
	// Protagonist - Who got gibbed

/datum/memory/witness_gib/get_names()
	return list("[protagonist_name]炸成了碎块。")

/datum/memory/witness_gib/get_starts()
	return list(
		"[protagonist_name]炸成了细小的肉块",
		"[protagonist_name]眨眼间变成了肉泥",
	)

/// Saw someone get crushed by a vending machine.
/datum/memory/witness_vendor_crush
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_SKIP_UNCONSCIOUS
	// Protagonist - Who got crushed
	// Antagonist - The vendor that crushed them

/datum/memory/witness_vendor_crush/get_names()
	return list("[protagonist_name]被[antagonist_name]压住了。")

/datum/memory/witness_vendor_crush/get_starts()
	return list(
		"[antagonist_name]压住了[protagonist_name]",
		"[antagonist_name]重重砸在[protagonist_name]身上",
		"[antagonist_name]倒在了[protagonist_name]身上",
	)

/datum/memory/witness_vendor_crush/get_moods()
	return list(
		"[protagonist_name]躺在机器下面，[mood_verb]。",
		"一件好东西从[antagonist_name]中掉了出来，[protagonist_name][mood_verb]。"
	)

/// Saw someone get dusted by the supermatter.
/datum/memory/witness_supermatter_dusting
	story_value = STORY_VALUE_AMAZING
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - Who got dusted
	// Antagonist - The supermatter

/datum/memory/witness_supermatter_dusting/get_names()
	return list("[antagonist_name]将[protagonist_name]化成了灰。")

/datum/memory/witness_supermatter_dusting/get_starts()
	return list(
		"[protagonist_name]碰到[antagonist_name]后变成了一堆白骨",
		"[antagonist_name]将[protagonist_name]化成了灰",
		"[protagonist_name]因靠[antagonist_name]太近而灰飞烟灭",
	)

/datum/memory/witness_supermatter_dusting/get_moods()
	return list(
		"[protagonist_name]逐渐消散，[mood_verb]。",
		"[protagonist_name]化为原子时，[mood_verb]。",
	)

/// Played cards with another person.
/datum/memory/playing_cards
	story_value = STORY_VALUE_MEH
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The player
	// Deuteragonist - The game dealer (which may be a player OR in the players list)
	/// What card game is being played
	var/game
	/// The card the protagonist is holding
	var/protagonist_held_card
	/// A string (english list) of all the mobs playing the game
	var/formatted_players_list

/datum/memory/playing_cards/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	game,
	obj/item/protagonist_held_card,
	list/mob/living/other_players,
)
	src.game = game
	src.protagonist_held_card = protagonist_held_card.name

	var/list/story_players = list()
	for(var/mob/living/player as anything in other_players)
		// This will result in some strange structure sometimes -
		// "The assistant, the assistant, and the assistant playing a game",
		// but meh. Someone can improve upon it in the future
		story_players += build_story_character(player)

	src.formatted_players_list = english_list(story_players, nothing_text = "没有其他人")
	return ..()

/datum/memory/playing_cards/get_names()
	return list("[protagonist_name]与[formatted_players_list]玩的[game]。")

/datum/memory/playing_cards/get_starts()
	return list(
		"[formatted_players_list]正等着[protagonist_name]开始[game]",
		"[deuteragonist_name]已经布置好了[game]",
		"[deuteragonist_name]开始为[game]洗牌",
	)

/datum/memory/playing_cards/get_moods()
	return list(
		"[protagonist_name]在[game]中握着[protagonist_held_card]，[mood_verb]。",
		"[protagonist_name]拿起[protagonist_held_card]时，[mood_verb]。",
		"[protagonist_name]放下[protagonist_held_card]时，[mood_verb]。",
	)

/// Played 52 card pickup with another person.
/datum/memory/playing_card_pickup
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The guy who initiated the game
	// Deuteragonist - The guy who got the cards thrown in their face
	// Antagonist - The deck of cards

/datum/memory/playing_card_pickup/get_names()
	return list("[protagonist_name]用[antagonist_name]戏弄[deuteragonist_name]，让其捡满地的牌。")

/datum/memory/playing_card_pickup/get_starts()
	return list(
		"[protagonist_name]把[antagonist_name]扔向[deuteragonist_name]，将牌撒得满地都是",
		"[protagonist_name]扔出的[antagonist_name]散落在[deuteragonist_name]脸上",
	)

/datum/memory/playing_card_pickup/get_moods()
	return list(
		"[protagonist_name]嘲弄着[deuteragonist_name]，[mood_verb]。",
		"[deuteragonist_name]羞愧地捡着牌，[mood_verb]。",
	)

/// Saw someone play Russian Roulette.
/datum/memory/witnessed_russian_roulette
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist = The guy who played roulette
	// Antagonist = The revolver
	/// The bodypart the protagonist was aiming at
	var/aimed_at
	/// How many rounds were loaded in the revolver
	var/rounds_loaded
	/// The result of the game ("won"(survived) or "lost"(shot themselves))
	var/result

/datum/memory/witnessed_russian_roulette/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	aimed_at,
	rounds_loaded = 0,
	result,
)
	src.aimed_at = chinese_body_zone_display(aimed_at)
	src.rounds_loaded = rounds_loaded
	src.result = result

	if(result == "won")
		// The more bullets, the better the story.
		story_value = max(STORY_VALUE_NONE, rounds_loaded)
	else
		story_value = STORY_VALUE_SHIT

	return ..()

/datum/memory/witnessed_russian_roulette/get_names()
	return list("[protagonist_name]玩了一局俄罗斯轮盘。")

/datum/memory/witnessed_russian_roulette/get_starts()
	return list(
		"[protagonist_name]将枪口对准自己的[aimed_at]，即将扣动扳机。",
		"左轮手枪的弹巢中装有[rounds_loaded]发子弹。",
		"[protagonist_name]转动着左轮手枪，拿自己的性命作赌注。",
	)

/datum/memory/witnessed_russian_roulette/get_moods()
	return list("[protagonist_name][result == "won" ? "赢得" : "输掉"]了这场致命的轮盘赌，[mood_verb]。")

/// When a heretic finishes their ritual of knowledge
/datum/memory/heretic_knowledge_ritual
	story_value = STORY_VALUE_AMAZING
	// Protagonist = heretic

/datum/memory/heretic_knowledge_ritual/get_names()
	return list("[protagonist_name]通过邪异研究汲取无尽知识。")

/datum/memory/heretic_knowledge_ritual/get_starts()
	return list(
		"[protagonist_name]用绿色焦油和蜡烛摆出一个圆圈",
		"[protagonist_name]周围的多本书自行翻开",
		"绿色与紫色的能量包围着[protagonist_name]",
		"[protagonist_name]双眼圆睁，一眨不眨地读着一本怪书",
		"一堆血肉内脏摆在复杂的符文上",
		"[protagonist_name]正在勾画一个宽大而怪异的圆圈"
	)

/datum/memory/heretic_knowledge_ritual/get_moods()
	return list("[protagonist_name]的手中闪耀着力量的光芒，[protagonist_name][mood_verb]。")

/datum/memory/heretic_knowledge_ritual/get_happy_moods()
	return list("疯狂地尖笑着")

/datum/memory/heretic_knowledge_ritual/get_neutral_moods()
	return list("咧嘴大笑，目光呆滞")

/datum/memory/heretic_knowledge_ritual/get_sad_moods()
	return list("歇斯底里地狂笑着")

/// Failed to defuse a bomb, by triggering it early.
/datum/memory/bomb_defuse_failure
	story_value = STORY_VALUE_NONE // Anyone who gets this is probably dead
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS
	// Protagonist = (failed) defuser
	// Antagonist = bomb

/datum/memory/bomb_defuse_failure/get_names()
	return list("[protagonist_name]未能拆除[antagonist_name]。")

/datum/memory/bomb_defuse_failure/get_starts()
	return list(
		"[protagonist_name]剪错了[antagonist_name]上的线",
		"[antagonist_name]发出巨响时，[protagonist_name]紧张地冒着汗，护住了脸",
		"[antagonist_name]上的倒计时突然跳到0秒"
	)

/datum/memory/bomb_defuse_failure/get_moods()
	return list("[protagonist_name]剪断[antagonist_name]上的一根线时，[mood_verb]。")

/// Succeeded in defusing a bomb!
/datum/memory/bomb_defuse_success
	story_value = STORY_VALUE_LEGENDARY // Very sick, and can't be gotten from training bombs
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS
	// Protagonist = defuser
	// Antagonist = bomb
	/// This is the time left (in seconds) of the bomb at defusal
	var/bomb_time_left

/datum/memory/bomb_defuse_success/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	bomb_time_left = -1,
)
	src.bomb_time_left = bomb_time_left
	return ..()

/datum/memory/bomb_defuse_success/get_names()
	return list("[protagonist_name]成功拆除了[antagonist_name]。")

/datum/memory/bomb_defuse_success/get_starts()
	return list(
		"[protagonist_name]剪对了[antagonist_name]上的线",
		"[antagonist_name]发出刺耳的哔声时，[protagonist_name]紧张地冒着汗，护住了脸",
		"[antagonist_name]上的倒计时停在了[bomb_time_left]秒"
	)

/datum/memory/bomb_defuse_success/get_moods()
	return list("[protagonist_name]剪断[antagonist_name]上的一根线时，[mood_verb]。")


/datum/memory/helped_up
	story_value = STORY_VALUE_OKAY

/datum/memory/helped_up/get_names()
	return list("[protagonist_name]彬彬有礼地扶起了[deuteragonist_name]。")

/datum/memory/helped_up/get_starts()
	return list(
		"[protagonist_name]正在扶起[deuteragonist_name]",
		"[deuteragonist_name]握住[protagonist_name]礼貌伸出的手，站了起来",
	)

/// Catching a fish
/datum/memory/caught_fish
	story_value = STORY_VALUE_OKAY

/datum/memory/caught_fish/get_names()
	return list(
		"[protagonist_name]钓上了一条大家伙。",
		"[protagonist_name]钓上了一条[deuteragonist_name]。",
	)

/datum/memory/caught_fish/get_starts()
	return list(
		"[protagonist_name]开始收线",
		"[protagonist_name]眼睛一亮，开始收线",
		"[protagonist_name]沉浸在垂钓中，钓上了什么东西",
		"[protagonist_name]开始与一条鱼较量",
		"一场热闹的垂钓正在进行",
	)

/datum/memory/caught_fish/get_moods()
	return list(
		"一条[deuteragonist_name]跃出水面，[protagonist_name][mood_verb]！",
		"[protagonist_name]钓上了一条[deuteragonist_name]，[mood_verb]！",
		"[protagonist_name]举着[deuteragonist_name]摆姿势，[mood_verb]！",
	)

/datum/memory/caught_fish/get_sad_moods()
	return list("借垂钓舒缓心情")

/// Becoming a mutant via infusion
/datum/memory/dna_infusion
	story_value = STORY_VALUE_MEH
	///describing what they turn into, "skittish", "nomadic", etc
	var/mutantlike

/datum/memory/dna_infusion/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	mutantlike,
)
	src.mutantlike = mutantlike
	return ..()

/datum/memory/dna_infusion/get_names()
	return list(
		"[protagonist_name]接受了[deuteragonist_name]的基因注入。",
		"[protagonist_name]把[deuteragonist_name]的基因注入了自己体内。",
	)

/datum/memory/dna_infusion/get_starts()
	return list(
		"[protagonist_name]走进了一台令人毛骨悚然的 DNA 机器",
		"[protagonist_name]参与了疯狂的科学实验",
		"DNA 注入器关上了门，[protagonist_name]就在里面",
		"注入槽里放着[deuteragonist_name]"
	)

/datum/memory/dna_infusion/get_moods()
	return list(
		"接受[deuteragonist_name]的基因注入时，[protagonist_name][mood_verb]！",
		"与[deuteragonist_name]融为一体时，[protagonist_name][mood_verb]。",
		"[deuteragonist_name]的基因融入了[protagonist_name]的 DNA，[protagonist_name][mood_verb]。",
		"接受[deuteragonist_name]的基因注入后，[protagonist_name]变得更加[mutantlike]！",
		"与[deuteragonist_name]融为一体后，[protagonist_name]变得更加[mutantlike]。",
		"[deuteragonist_name]的基因融入 DNA 后，[protagonist_name]变得更加[mutantlike]。",
	)

/datum/memory/dna_infusion/get_happy_moods()
	return list(
		"为了科学忍受着痛苦",
		"自信地咬牙忍痛"
	)

/datum/memory/dna_infusion/get_neutral_moods()
	return list(
		"痛得尖叫起来",
		"开始打退堂鼓"
	)

/datum/memory/dna_infusion/get_sad_moods()
	return list("悲愤地抛弃了人类之身")

/// Who rev'd me, so if a mindreader reads a rev, they have a clue on who to hunt down
/datum/memory/recruited_by_headrev

/datum/memory/recruited_by_headrev/get_names()
	return list("[antagonist_name]将[protagonist_name]转化成了革命者。")

/datum/memory/recruited_by_headrev/get_starts()
	return list(
		"[antagonist_name]用闪光灯照射了[protagonist_name]，其脑中只剩下一个暴力目标：杀死主管。",
		"[antagonist_name]举起一个奇怪的装置，对着[protagonist_name]的双眼闪光，将杀戮指令烙进了脑海。",
	)

/// Who converted into a blood brother
/datum/memory/recruited_by_blood_brother

/datum/memory/recruited_by_blood_brother/get_names()
	return list("[antagonist_name]将[protagonist_name]转化成了血盟兄弟。")

/datum/memory/recruited_by_blood_brother/get_starts()
	return list(
		"[antagonist_name]对[protagonist_name]显得有些过分亲热，很快就要将其转化成血盟兄弟。",
		"[protagonist_name]被[antagonist_name]带进了充满犯罪与间谍活动的生活。",
	)

/// Saw someone play Russian Roulette.
/datum/memory/witnessed_gods_wrath
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_SKIP_UNCONSCIOUS
	story_value = STORY_VALUE_AMAZING

/datum/memory/witnessed_gods_wrath/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
)

/datum/memory/witnessed_gods_wrath/get_names()
	return list("[protagonist_name]承受了[antagonist_name]的怒火。")

/datum/memory/witnessed_gods_wrath/get_starts()
	return list(
		"[protagonist_name]烧毁了[deuteragonist_name]，[antagonist_name]将[protagonist_name]化作一团细密的血雾。",
		"[protagonist_name]亵渎了[deuteragonist_name]，[antagonist_name]因此将其炸得粉碎。",
		"[protagonist_name]亵渎[deuteragonist_name]，激怒了[antagonist_name]，随即被彻底抹杀。",
	)

/datum/memory/witnessed_gods_wrath/get_moods()
	return list("[antagonist_name]将[protagonist_name]彻底毁灭时，[protagonist_name][mood_verb]。")

/datum/memory/witnessed_gods_wrath/get_happy_moods()
	return list(
		"歇斯底里地尖笑着",
		"疯狂地大笑着",
		"咧嘴大笑",
	)

/datum/memory/witnessed_gods_wrath/get_neutral_moods()
	return list(
		"显得忧心忡忡",
		"重新审视自己的人生选择",
		"面无表情",
	)

/datum/memory/witnessed_gods_wrath/get_sad_moods()
	return list(
		"显得垂头丧气",
		"满心悔恨",
		"绝望地皱起脸"
	)
