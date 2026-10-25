/// List of all holiday-related mail. Do not edit this directly, instead add to var/list/holiday_mail
GLOBAL_LIST_INIT(holiday_mail, list())

/datum/holiday
	///Name of the holiday itself. Visible to players.
	var/name = "If you see this the holiday calendar code is broken"

	///What day of begin_month does the holiday begin on?
	var/begin_day = 1
	///What month does the holiday begin on?
	var/begin_month = 0
	/// What day of end_month does the holiday end? Default of 0 means the holiday lasts a single.
	var/end_day = 0
	/// What month does the holiday end on?
	var/end_month = 0
	/// for christmas neverending, or testing. Forces a holiday to be celebrated.
	var/always_celebrate = FALSE
	/// Held variable to better calculate when certain holidays may fall on, like easter.
	var/current_year = 0
	/// How many years are you offsetting your calculations for begin_day and end_day on. Used for holidays like easter.
	var/year_offset = 0
	///Timezones this holiday is celebrated in (defaults to three timezones spanning a 50 hour window covering all timezones)
	var/list/timezones = list(TIMEZONE_LINT, TIMEZONE_UTC, TIMEZONE_ANYWHERE_ON_EARTH)
	///If this is defined, drones/assistants without a default hat will spawn with this item in their head clothing slot.
	var/obj/item/holiday_hat
	///When this holiday is active, does this prevent mail from arriving to cargo? Overrides var/list/holiday_mail. Try not to use this for longer holidays.
	var/no_mail_holiday = FALSE
	/// The list of items we add to the mail pool. Can either be a weighted list or a normal list. Leave empty for nothing.
	var/list/holiday_mail = list()
	var/poster_name = "通用庆典海报"
	var/poster_desc = "一张用于庆祝某个节日的海报。可惜它还没做完，所以你看不出是哪个节日。"
	var/poster_icon = "holiday_unfinished"
	/// Color scheme for this holiday
	var/list/holiday_colors
	/// The default pattern of the holiday, if the requested pattern is null.
	var/holiday_pattern = PATTERN_DEFAULT

// This proc gets run before the game starts when the holiday is activated. Do festive shit here.
/datum/holiday/proc/celebrate()
	if(no_mail_holiday)
		SSeconomy.mail_blocked = TRUE
	if(LAZYLEN(holiday_mail) && !no_mail_holiday)
		GLOB.holiday_mail += holiday_mail
	return

// When the round starts, this proc is ran to get a text message to display to everyone to wish them a happy holiday
/datum/holiday/proc/greet()
	return "祝你[chinese_holiday_display(name)]快乐！"

/// Returns special prefix station name on certain days. (See new_station_name())
/// Turns "Experimental Research City" into "Christmas Research City"
/datum/holiday/proc/get_station_prefix()
	return ""

/// Returns special names for the station name on certain days. (See new_station_name())
/// Turns "Experimental Research City" into "Experimental Christmas City"
/datum/holiday/proc/get_station_name()
	// By default get the first word of the Holiday and use that
	return copytext(name, 1, findtext(name, " "))

// Return 1 if this holidy should be celebrated today
/datum/holiday/proc/shouldCelebrate(dd, mm, yyyy, ddd)
	if(always_celebrate)
		return TRUE

	if(!end_day)
		end_day = begin_day
	if(!end_month)
		end_month = begin_month
	if(end_month > begin_month) //holiday spans multiple months in one year
		if(mm == end_month) //in final month
			if(dd <= end_day)
				return TRUE

		else if(mm == begin_month)//in first month
			if(dd >= begin_day)
				return TRUE

		else if(mm in begin_month to end_month) //holiday spans 3+ months and we're in the middle, day doesn't matter at all
			return TRUE

	else if(end_month == begin_month) // starts and stops in same month, simplest case
		if(mm == begin_month && (dd in begin_day to end_day))
			return TRUE

	else // starts in one year, ends in the next
		if(mm >= begin_month && dd >= begin_day) // Holiday ends next year
			return TRUE
		if(mm <= end_month && dd <= end_day) // Holiday started last year
			return TRUE

	return FALSE

/datum/holiday/proc/get_holiday_colors(atom/thing_to_color, pattern)
	return get_decoration_color_from_pattern(thing_to_color, pattern || holiday_pattern, holiday_colors)

// The actual holidays

// JANUARY

//Fleet Day is celebrated on Jan 19th, the date on which moths were merged (#34498)
/datum/holiday/fleet_day
	name = MOTH_FLEET_DAY
	begin_month = JANUARY
	begin_day = 19
	holiday_hat = /obj/item/clothing/head/mothcap
	holiday_mail = list(
		/obj/item/toy/plush/moth = 2,
		/obj/item/clothing/shoes/clown_shoes/moffers = 1,
		/obj/item/instrument/musicalmoth = 1,
	)

/datum/holiday/fleet_day/greet()
	return "这一天纪念蛾族大游牧舰队又成功存活了一年。全银河的蛾子都受到鼓励，尽情吃喝、尽情欢乐。"

/datum/holiday/fleet_day/get_station_name()
	return pick("蛾族", "舰队", "游牧")

// FEBRUARY

/datum/holiday/groundhog
	name = "Groundhog Day"
	begin_day = 2
	begin_month = FEBRUARY

/datum/holiday/groundhog/get_station_name()
	return pick("既视感") //I have been to this place before

/datum/holiday/nz
	name = "Waitangi Day"
	timezones = list(TIMEZONE_NZDT, TIMEZONE_CHADT)
	begin_day = 6
	begin_month = FEBRUARY
	holiday_colors = list(
		COLOR_UNION_JACK_BLUE,
		COLOR_WHITE,
		COLOR_UNION_JACK_RED,
		COLOR_WHITE,
	)

/datum/holiday/nz/get_station_name()
	return pick("奥特亚罗瓦","几维鸟","炸鱼薯条","鸮鹦鹉","南十字座")

/datum/holiday/nz/greet()
	var/nz_age = text2num(time2text(world.timeofday, "YYYY", TIMEZONE_NZST)) - 1840
	return "在 [nz_age] 年前的今天，新西兰的建国文件《怀唐伊条约》正式签署！"

/datum/holiday/valentines
	name = VALENTINES
	begin_day = 13
	end_day = 15
	begin_month = FEBRUARY
	poster_name = "爱情海报"
	poster_desc = "一张庆祝今天建立的所有感情的海报。当然，你多半没有。"
	poster_icon = "holiday_love"
	holiday_mail = list(
		/obj/item/food/bonbon/chocolate_truffle,
		/obj/item/food/candyheart,
		/obj/item/food/grown/flower/rose,
		)

/datum/holiday/valentines/get_station_name()
	return pick("爱","阿莫雷","单身","亲吻","拥抱")

/datum/holiday/birthday
	name = "Birthday of Space Station 13"
	begin_day = 16
	begin_month = FEBRUARY
	holiday_hat = /obj/item/clothing/head/costume/festive
	poster_name = "空间站生日海报"
	poster_desc = "一张庆祝空间站又运营了一年的海报。为什么有人会乐意待在这里，实在超乎你的理解。"
	poster_icon = "holiday_cake" // is a lie
	holiday_mail = list(
		/obj/item/clothing/mask/party_horn,
		/obj/item/food/cakeslice/birthday,
		/obj/item/sparkler,
		/obj/item/storage/box/party_poppers,
	)

/datum/holiday/birthday/greet()
	var/game_age = text2num(time2text(world.timeofday, "YYYY", world.timezone)) - 2003
	var/Fact
	switch(game_age)
		if(16)
			Fact = " 空间站 13 现在到了能开车的年龄了！"
		if(18)
			Fact = " 空间站 13 现在合法了！"
		if(21)
			Fact = " 空间站 13 现在可以喝酒了！"
		if(26)
			Fact = " 空间站 13 现在可以租车了！"
		if(30)
			Fact = " 空间站 13 现在可以回家当个顾家好男人了！"
		if(35)
			Fact = " 空间站 13 现在可以竞选美国总统了！"
		if(40)
			Fact = " 空间站 13 现在可以经历中年危机了！"
		if(50)
			Fact = " 金婚快乐！"
		if(65)
			Fact = " 空间站 13 现在可以开始考虑退休了！"
	if(!Fact)
		Fact = " 空间站 13 现在 [game_age] 岁了！"

	return "向空间站 13 说声“生日快乐”吧——它于 2003 年 2 月 16 日首次公开可玩！[Fact]"

/datum/holiday/random_kindness
	name = "Random Acts of Kindness Day"
	begin_day = 17
	begin_month = FEBRUARY
	poster_name = "善举海报"
	poster_desc = "一张提醒读者今天是“善举日”的海报。多好的一件事啊。"
	poster_icon = "holiday_kind"

/datum/holiday/random_kindness/greet()
	return "去为陌生人做点随机的善举吧！" //haha yeah right

/datum/holiday/leap
	name = "Leap Day"
	begin_day = 29
	begin_month = FEBRUARY

// MARCH

/datum/holiday/pi
	name = "Pi Day"
	begin_day = 14
	begin_month = MARCH
	poster_name = "圆周率日海报"
	poster_desc = "一张庆祝一年中第 3.141529 天的海报。至少还有免费的派吃。"
	poster_icon = "holiday_pi"
	holiday_mail = list(
		/obj/item/food/pieslice/apple,
		/obj/item/food/pieslice/bacid_pie,
		/obj/item/food/pieslice/blumpkin,
		/obj/item/food/pieslice/cherry,
		/obj/item/food/pieslice/frenchsilk,
		/obj/item/food/pieslice/frostypie,
		/obj/item/food/pieslice/meatpie,
		/obj/item/food/pieslice/pumpkin,
		/obj/item/food/pieslice/shepherds_pie,
		/obj/item/food/pieslice/tofupie,
		/obj/item/food/pieslice/xemeatpie,
	)

/datum/holiday/pi/get_station_name()
	return pick("正弦","余弦","正切","正割","余割","余切")

/datum/holiday/no_this_is_patrick
	name = ST_PATRICK_DAY
	begin_day = 17
	begin_month = MARCH
	holiday_hat = /obj/item/clothing/head/soft/green
	holiday_colors = list(
		COLOR_IRISH_GREEN,
		COLOR_WHITE,
		COLOR_IRISH_ORANGE,
	)
	holiday_pattern = PATTERN_VERTICAL_STRIPE
	/// Could we settle this over a pint?
	holiday_mail = list(
		/obj/item/reagent_containers/cup/glass/bottle/ale,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/irish_cream,
	)

/datum/holiday/no_this_is_patrick/get_station_name()
	return pick("布拉尼","绿色","矮精灵","酒")

/datum/holiday/no_this_is_patrick/greet()
	return "全国醉倒日快乐！"

// APRIL

/datum/holiday/april_fools
	name = APRIL_FOOLS
	begin_month = APRIL
	begin_day = 1
	end_day = 2
	holiday_hat = /obj/item/clothing/head/chameleon/broken
	holiday_mail = list(
		/obj/item/clothing/head/costume/whoopee,
		/obj/item/grown/bananapeel/gros_michel,
	)

/datum/holiday/april_fools/celebrate()
	. = ..()
	SSjob.set_overflow_role(/datum/job/clown)
	SSticker.set_lobby_music('sound/music/lobby_music/clown.ogg', override = TRUE)

/datum/holiday/april_fools/get_holiday_colors(atom/thing_to_color)
	return "#[random_short_color()]"

/datum/holiday/spess
	name = "Cosmonautics Day"
	begin_day = 12
	begin_month = APRIL
	holiday_hat = /obj/item/clothing/head/syndicatefake

/datum/holiday/spess/greet()
	return "在 600 多年前的今天，尤里·加加林同志首次进入太空！"

/datum/holiday/fourtwenty
	name = "Four-Twenty"
	begin_day = 20
	begin_month = APRIL
	holiday_hat = /obj/item/clothing/head/rasta
	holiday_colors = list(
		COLOR_ETHIOPIA_RED,
		COLOR_ETHIOPIA_YELLOW,
		COLOR_ETHIOPIA_GREEN,
	)
	holiday_mail = list(/obj/item/cigarette/rollie/cannabis)

/datum/holiday/fourtwenty/get_station_name()
	return pick("斯努普","钝烟","一口","醇货","奇奇","钟")

/datum/holiday/tea
	name = "National Tea Day"
	begin_day = 21
	begin_month = APRIL
	holiday_mail = list(/obj/item/reagent_containers/cup/glass/mug/tea)

/datum/holiday/tea/get_station_name()
	return pick("松饼","阿萨姆","乌龙","普洱","甜茶","绿茶","红茶")

/datum/holiday/earth
	name = "Earth Day"
	begin_day = 22
	begin_month = APRIL

/datum/holiday/anz
	name = "ANZAC Day"
	timezones = list(TIMEZONE_TKT, TIMEZONE_TOT, TIMEZONE_NZST, TIMEZONE_NFT, TIMEZONE_LHST, TIMEZONE_AEST, TIMEZONE_ACST, TIMEZONE_ACWST, TIMEZONE_AWST, TIMEZONE_CXT, TIMEZONE_CCT, TIMEZONE_CKT, TIMEZONE_NUT)
	begin_day = 25
	begin_month = APRIL
	holiday_hat = /obj/item/food/grown/flower/poppy

/datum/holiday/anz/get_station_name()
	return pick("澳大利亚","新西兰","罂粟","南十字座")

/datum/holiday/chernobyl
	name = CHERNOBYL_ANNIVERSARY
	begin_day = 26
	begin_month = APRIL
	holiday_mail = list(/obj/item/geiger_counter)

/datum/holiday/chernobyl/get_station_name()
	if(prob(3))
		return "不算好，也不算糟"

	return pick("原子","核能","辐射","钚","铀","堆芯熔融物","锆","石墨","紧急停堆","爆炸")

/datum/holiday/chernobyl/greet()
	return "1986 年的今天，切尔诺贝利核电站发生堆芯熔毁，造成了人类历史上最严重的核灾难之一。 \
		今天提醒着我们那些逝去的生命，也提醒着我们的工程师在为空间站供电时必须遵守的严格安全标准。"

// MAY

/datum/holiday/labor
	name = "Labor Day"
	begin_day = 1
	begin_month = MAY
	holiday_hat = /obj/item/clothing/head/utility/hardhat
	no_mail_holiday = TRUE

//Draconic Day is celebrated on May 3rd, the date on which the Draconic language was merged (#26780)
/datum/holiday/draconic_day
	name = "Draconic Language Day"
	begin_month = MAY
	begin_day = 3
	holiday_mail = list(
		/obj/item/toy/plush/lizard_plushie/space = 3,
		/obj/item/language_manual/roundstart_species/draconic = 1,
	)

/datum/holiday/draconic_day/greet()
	return "在这一天，蜥蜴人会用文学和其他文化作品来庆祝他们的语言。"

/datum/holiday/draconic_day/get_station_name()
	return pick("龙语","文学","阅读")

/datum/holiday/firefighter
	name = "Firefighter's Day"
	begin_day = 4
	begin_month = MAY
	holiday_hat = /obj/item/clothing/head/utility/hardhat/red
	holiday_mail = list(/obj/item/extinguisher/mini)

/datum/holiday/firefighter/get_station_name()
	return pick("燃烧","炽焰","等离子","火焰")

/datum/holiday/bee
	name = BEE_DAY
	begin_day = 20
	begin_month = MAY
	holiday_mail = list(
		/obj/item/clothing/suit/hooded/bee_costume,
		/obj/item/food/honeycomb,
		/obj/item/food/monkeycube/bee,
		/obj/item/toy/plush/beeplushie,
	)

/datum/holiday/bee/get_station_name()
	return pick("蜜蜂","蜂蜜","蜂巢","非洲化","蜂蜜酒","嗡嗡")

/datum/holiday/goth
	name = "Goth Day"
	begin_day = 22
	begin_month = MAY
	holiday_mail = list(
		/obj/item/lipstick,
		/obj/item/lipstick/black,
		/obj/item/clothing/suit/costume/gothcoat,
	)
	holiday_colors = list(
		COLOR_WHITE,
		COLOR_BLACK,
	)

/datum/holiday/goth/get_station_name()
	return pick("哥特", "血色", "幽暗", "落泪", "暗影", "夜行")

// JUNE

//The Festival of Atrakor's Might (Tizira's Moon) is celebrated on June 15th, the date on which the lizard visual revamp was merged (#9808)
/datum/holiday/atrakor_festival
	name = LIZARD_ATRAKOR_DAY
	begin_month = JUNE
	begin_day = 15
	holiday_mail = list(
		/obj/item/food/tiziran_sausage,
		/obj/item/food/honey_roll,
		/obj/item/food/lizard_dumplings,
	)

/datum/holiday/atrakor_festival/greet()
	return "在这一天，蜥蜴人传统上会庆祝阿特拉科之力节，他们用华美的服饰、大量的食物以及通宵的盛大庆典来向月神致敬。"

/datum/holiday/atrakor_festival/get_station_name()
	return pick("月亮", "夜空", "庆典")

/// Garbage DAYYYYY
/// Huh?.... NOOOO
/// *GUNSHOT*
/// AHHHGHHHHHHH
/datum/holiday/garbageday
	name = GARBAGEDAY
	begin_day = 17
	end_day = 17
	begin_month = JUNE
	holiday_mail = list(
		/obj/effect/spawner/random/trash/garbage,
		/obj/item/storage/bag/trash,
	)

/datum/holiday/summersolstice
	name = "Summer Solstice"
	begin_day = 21
	begin_month = JUNE
	holiday_hat = /obj/item/clothing/head/costume/garland

/datum/holiday/pride_week
	name = PRIDE_WEEK
	begin_month = JUNE
	// Stonewall was June 28th, this captures its week.
	begin_day = 23
	end_day = 29
	holiday_colors = PRIDE_FLAG_COLORS
	holiday_mail = list(
		/obj/item/bedsheet/rainbow,
		/obj/item/clothing/accessory/pride,
		/obj/item/clothing/gloves/color/rainbow,
		/obj/item/clothing/head/costume/garland/rainbowbunch,
		/obj/item/clothing/head/soft/rainbow,
		/obj/item/clothing/shoes/sneakers/rainbow,
		/obj/item/clothing/under/color/jumpskirt/rainbow,
		/obj/item/clothing/under/color/rainbow,
		/obj/item/food/egg/rainbow,
		/obj/item/food/grown/flower/rainbow_flower,
		/obj/item/food/snowcones/rainbow,
		/obj/item/toy/crayon/rainbow,
	)

/datum/holiday/pride_week/New()
	. = ..()
	if(prob(30))
		return
	holiday_colors = pick(LESBIAN_FLAG_COLORS, GAY_MAN_FLAG_COLORS, TRANS_FLAG_COLORS, BI_FLAG_COLORS, ACE_FLAG_COLORS, PAN_FLAG_COLORS)

/datum/holiday/pride_week/get_station_prefix()
	if(prob(10))
		return pick("同性恋", "跨性别", "双性恋", "女同性恋", "泛性恋", "无性恋", "无浪漫", "非二元", "非二元", "无性恋", "无浪漫", "无性别", "间性")
	return pick("彩虹", "骄傲", "酷儿")

/datum/holiday/pride_week/get_station_name()
	return ""

// JULY

/datum/holiday/doctor
	name = "Doctor's Day"
	begin_day = 1
	begin_month = JULY
	holiday_hat = /obj/item/clothing/head/costume/nursehat
	holiday_mail = list(
		/obj/item/stack/medical/wrap/gauze,
		/obj/item/stack/medical/ointment,
		/obj/item/storage/box/bandages,
	)

/datum/holiday/ufo
	name = "UFO Day"
	begin_day = 2
	begin_month = JULY
	holiday_hat = /obj/item/clothing/head/collectable/xenom
	holiday_mail = list(
		/obj/item/toy/plush/abductor,
		/obj/item/toy/plush/abductor/agent,
		/obj/item/toy/plush/rouny,
		/obj/item/toy/toy_xeno,
	)

/datum/holiday/ufo/get_station_name() //Is such a thing even possible?
	return pick("哎","真相","楚卡洛斯","穆德","史卡莉") //Yes it is!

/datum/holiday/usa
	name = "US Independence Day"
	timezones = list(TIMEZONE_EDT, TIMEZONE_CDT, TIMEZONE_MDT, TIMEZONE_MST, TIMEZONE_PDT, TIMEZONE_AKDT, TIMEZONE_HDT, TIMEZONE_HST)
	begin_day = 4
	begin_month = JULY
	no_mail_holiday = TRUE
	holiday_hat = /obj/item/clothing/head/cowboy/brown
	holiday_colors = list(
		COLOR_WHITE,
		COLOR_OLD_GLORY_RED,
		COLOR_WHITE,
		COLOR_OLD_GLORY_RED,
		COLOR_OLD_GLORY_BLUE,
	)


/datum/holiday/usa/get_station_name()
	return pick("独立","美国","汉堡","白头海雕","星条","烟花")

/datum/holiday/writer
	name = "Writer's Day"
	begin_day = 8
	begin_month = JULY
	holiday_mail = list(/obj/item/pen/fountain)

/datum/holiday/france
	name = "Bastille Day"
	timezones = list(TIMEZONE_CEST)
	begin_day = 14
	begin_month = JULY
	holiday_hat = /obj/item/clothing/head/beret
	no_mail_holiday = TRUE
	holiday_colors = list(
		COLOR_FRENCH_BLUE,
		COLOR_WHITE,
		COLOR_FRENCH_RED
	)
	holiday_pattern = PATTERN_VERTICAL_STRIPE

/datum/holiday/france/get_station_name()
	return pick("法兰西", "奶酪", "糟了", "该死", "天哪")

/datum/holiday/france/greet()
	return "你听见人民在歌唱吗？"

/datum/holiday/hotdogday
	name = HOTDOG_DAY
	begin_day = 17
	begin_month = JULY
	holiday_mail = list(/obj/item/food/hotdog)

/datum/holiday/hotdogday/greet()
	return "全国热狗日快乐！"

//Gary Gygax's birthday, a fitting day for Wizard's Day
/datum/holiday/wizards_day
	name = "Wizard's Day"
	begin_month = JULY
	begin_day = 27
	holiday_hat = /obj/item/clothing/head/wizard

/datum/holiday/wizards_day/get_station_name()
	return pick("地城", "精灵", "魔法", "D20", "版本")

/datum/holiday/friendship
	name = "Friendship Day"
	begin_day = 30
	begin_month = JULY
	holiday_mail = list(/obj/item/food/grown/apple)

/datum/holiday/friendship/greet()
	return "祝你过一个充满魔法的[chinese_holiday_display(name)]！"

// AUGUST

/datum/holiday/indigenous //Indigenous Peoples' Day from Earth!
	name = "International Day of the World's Indigenous Peoples"
	begin_month = AUGUST
	begin_day = 9

/datum/holiday/indigenous/get_station_name()
	return pick("濒危语言", "词语", "语言", "语言复兴", "土豆", "玉米")

// AUGUST

/datum/holiday/ukraine
	name = "Independence Day of Ukraine"
	begin_month = AUGUST
	begin_day = 24
	holiday_colors = list(COLOR_TRUE_BLUE, COLOR_TANGERINE_YELLOW)

/datum/holiday/ukraine/get_station_name()
	return pick("基辅", "乌克兰")

// SEPTEMBER

//Tiziran Unification Day is celebrated on Sept 1st, the day on which lizards were made a roundstart race
/datum/holiday/tiziran_unification
	name = "Tiziran Unification Day"
	begin_month = SEPTEMBER
	begin_day = 1
	holiday_hat = /obj/item/clothing/head/costume/lizard
	holiday_mail = list(/obj/item/toy/plush/lizard_plushie)

/datum/holiday/tiziran_unification/greet()
	return "在 400 多年前的今天，蜥蜴人首次统一在同一面旗帜下，准备作为一个统一的民族面对群星。"

/datum/holiday/tiziran_unification/get_station_name()
	return pick("提兹拉", "蜥蜴", "帝国")

/datum/holiday/ianbirthday
	name = IAN_HOLIDAY //github.com/tgstation/tgstation/commit/de7e4f0de0d568cd6e1f0d7bcc3fd34700598acb
	begin_month = SEPTEMBER
	begin_day = 9
	end_day = 10
	holiday_mail = list(
		/obj/item/bedsheet/ian,
		/obj/item/bedsheet/ian/double,
		/obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian,
		/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian,
		/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian,
		/obj/item/clothing/suit/hooded/ian_costume,
		/obj/item/radio/toy,
		/obj/item/toy/figure/ian,
	)

/datum/holiday/ianbirthday/greet()
	return "生日快乐，伊恩！"

/datum/holiday/ianbirthday/get_station_name()
	return pick("伊恩", "柯基", "埃罗")

/datum/holiday/pirate
	name = TALK_LIKE_A_PIRATE_DAY
	begin_day = 19
	begin_month = SEPTEMBER
	holiday_hat = /obj/item/clothing/head/costume/pirate
	holiday_mail = list(
		/obj/item/clothing/head/costume/pirate = 3,
		/obj/item/language_manual/piratespeak = 1,
	)

/datum/holiday/pirate/greet()
	return "今天你得像海盗一样说话，不然就给我走跳板，伙计！"

/datum/holiday/pirate/get_station_name()
	return pick("呀尔","坏血病","哟吼吼")

/datum/holiday/questions
	name = "Stupid-Questions Day"
	begin_day = 28
	begin_month = SEPTEMBER

/datum/holiday/questions/greet()
	return "你的[chinese_holiday_display(name)]过得开心吗？"

// OCTOBER

/datum/holiday/animal
	name = "Animal's Day"
	begin_day = 4
	begin_month = OCTOBER

/datum/holiday/animal/get_station_name()
	return pick("鹦鹉","柯基","猫","巴哥犬","山羊","狐狸")

/datum/holiday/smile
	name = "Smiling Day"
	begin_day = 7
	begin_month = OCTOBER
	holiday_hat = /obj/item/clothing/head/costume/papersack/smiley
	holiday_mail = list(/obj/item/sticker/smile)

/datum/holiday/boss
	name = "Boss' Day"
	begin_day = 16
	begin_month = OCTOBER
	holiday_hat = /obj/item/clothing/head/hats/tophat

/datum/holiday/un_day
	name = "Anniversary of the Foundation of the United Nations"
	begin_month = OCTOBER
	begin_day = 24

/datum/holiday/un_day/greet()
	return "1945 年的今天，联合国成立，为人类联合政府奠定了基础！"

/datum/holiday/un_day/get_station_name()
	return pick("联合", "合作", "人道")

/datum/holiday/halloween
	name = HALLOWEEN
	begin_day = 29
	begin_month = OCTOBER
	end_day = 2
	end_month = NOVEMBER
	holiday_colors = list(COLOR_MOSTLY_PURE_ORANGE, COLOR_PRISONER_BLACK)
	holiday_mail = list(
		/obj/item/food/cookie/sugar/spookycoffin,
		/obj/item/food/cookie/sugar/spookyskull,
		)

/datum/holiday/halloween/greet()
	return "祝你万圣节惊悚快乐！"

/datum/holiday/halloween/get_station_name()
	return pick("骸骨震响","骨头先生专属","太惊悚了","惊悚","恐怖","骷髅")

// NOVEMBER

/datum/holiday/vegan
	name = VEGAN_DAY
	begin_day = 1
	begin_month = NOVEMBER
	holiday_mail = list(/obj/item/food/tofu)

/datum/holiday/vegan/get_station_name()
	return pick("豆腐", "天贝", "面筋", "豆腐火鸡")

/datum/holiday/october_revolution
	name = "October Revolution"
	begin_day = 6
	begin_month = NOVEMBER
	end_day = 7
	holiday_colors = list(
		COLOR_MEDIUM_DARK_RED,
		COLOR_GOLD,
		COLOR_MEDIUM_DARK_RED,
	)

/datum/holiday/october_revolution/get_station_name()
	return pick("共产", "苏维埃", "布尔什维克", "社会主义", "红色", "工人")

/datum/holiday/remembrance_day
	name = "Remembrance Day"
	begin_month = NOVEMBER
	begin_day = 11
	holiday_hat = /obj/item/food/grown/flower/poppy
	holiday_mail = list(
		/obj/item/food/grown/flower/harebell,
		/obj/item/food/grown/flower/poppy,
		/obj/item/storage/fancy/candle_box,
	)

/datum/holiday/remembrance_day/greet()
	return "永志不忘。"

/datum/holiday/remembrance_day/get_station_name()
	return pick("和平", "停战", "罂粟")

/datum/holiday/lifeday
	name = "Life Day"
	begin_day = 17
	begin_month = NOVEMBER

/datum/holiday/lifeday/get_station_name()
	return pick("痒痒", "疙瘩", "玛拉", "卡祖克") //he really pronounced it "Kazook", I wish I was making shit up

/datum/holiday/kindness
	name = "Kindness Day"
	begin_day = 13
	begin_month = NOVEMBER

/datum/holiday/flowers
	name = "Flowers Day"
	begin_day = 19
	begin_month = NOVEMBER
	holiday_hat = /obj/item/food/grown/flower/moonflower
	holiday_mail = list(
		/obj/item/food/grown/flower/harebell,
		/obj/item/food/grown/flower/moonflower,
		/obj/item/food/grown/flower/poppy,
		/obj/item/food/grown/flower/poppy/geranium,
		/obj/item/food/grown/flower/poppy/geranium/fraxinella,
		/obj/item/food/grown/flower/poppy/lily,
		/obj/item/food/grown/flower/rose,
		/obj/item/food/grown/flower/sunflower,
		/obj/item/grown/carbon_rose,
		/obj/item/grown/novaflower,
	)

/datum/holiday/hello
	name = "Saying-'Hello' Day"
	begin_day = 21
	begin_month = NOVEMBER

/datum/holiday/hello/greet()
	return "[pick(list("Aloha", "Bonjour", "Hello", "Hi", "Greetings", "Salutations", "Bienvenidos", "Hola", "Howdy", "Ni hao", "Guten Tag", "Konnichiwa", "G'day cunt"))]! " + ..()

//The Festival of Holy Lights is celebrated on Nov 28th, the date on which ethereals were merged (#40995)
/datum/holiday/holy_lights
	name = "Festival of Holy Lights"
	begin_month = NOVEMBER
	begin_day = 28
	/// If there's more of them I forgot
	holiday_mail = list(
		/obj/item/food/energybar,
		/obj/item/food/pieslice/bacid_pie,
	)

/datum/holiday/holy_lights/greet()
	return "圣光节是以太人日历的最后一天。通常这一天会先祈祷，再举行庆典，以华丽的方式为一年收尾。"

/datum/holiday/holy_lights/get_station_name()
	return pick("以太", "灯笼", "神圣")

// DECEMBER

/datum/holiday/festive_season
	name = FESTIVE_SEASON
	begin_day = 1
	begin_month = DECEMBER
	end_day = 31
	holiday_hat = /obj/item/clothing/head/costume/santa

/datum/holiday/festive_season/greet()
	return "祝你节日季愉快！"

/datum/holiday/human_rights
	name = "Human-Rights Day"
	begin_day = 10
	begin_month = DECEMBER

/datum/holiday/monkey
	name = MONKEYDAY
	begin_day = 14
	begin_month = DECEMBER
	holiday_mail = list(/obj/item/toy/plush/monkey)

/datum/holiday/monkey/celebrate()
	. = ..()
	SSstation.setup_trait(/datum/station_trait/job/pun_pun)

/datum/holiday/doomsday
	name = "Mayan Doomsday Anniversary"
	begin_day = 21
	begin_month = DECEMBER

/datum/holiday/xmas
	name = CHRISTMAS
	begin_day = 18
	begin_month = DECEMBER
	end_day = 27
	holiday_hat = /obj/item/clothing/head/costume/santa
	holiday_mail = list(
		/obj/item/clothing/head/beanie/christmas,
		/obj/item/clothing/neck/scarf/christmas,
		/obj/item/food/cookie/sugar,
		/obj/item/gift/anything,
		/obj/item/toy/xmas_cracker,
	)
	holiday_colors = list(
		COLOR_CHRISTMAS_GREEN,
		COLOR_CHRISTMAS_RED,
	)

/datum/holiday/xmas/get_station_name()
	return pick(
		"圣经",
		"生日",
		"烟囱",
		"克劳斯",
		"钉十字架",
		"精灵",
		"冷杉",
		"呵呵呵",
		"耶稣",
		"欢乐",
		"快乐",
		"礼物",
		"麻袋",
		"圣诞老人",
		"雪橇",
		"尤尔",
	)

/datum/holiday/xmas/greet()
	return "祝你圣诞快乐！"

/datum/holiday/xmas/celebrate()
	. = ..()
	SSticker.OnRoundstart(CALLBACK(src, PROC_REF(roundstart_celebrate)))
	GLOB.maintenance_loot += list(
		list(
			/obj/item/clothing/head/costume/santa = 1,
			/obj/item/gift/mostly_anything = 1, // BUBBER EDIT - Previous: /obj/item/gift/anything
			/obj/item/toy/xmas_cracker = 3,
		) = maint_holiday_weight,
	)

/datum/holiday/xmas/proc/roundstart_celebrate()
	for(var/obj/machinery/computer/security/telescreen/entertainment/Monitor as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/computer/security/telescreen/entertainment))
		Monitor.icon_state_on = "entertainment_xmas"

	for(var/mob/living/basic/pet/dog/corgi/ian/Ian in GLOB.mob_living_list)
		Ian.place_on_head(new /obj/item/clothing/head/helmet/space/santahat(Ian))

	var/datum/supply_pack/pack = SSshuttle.supply_packs[/datum/supply_pack/costumes_toys/christmas]
	pack.order_flags |= ORDER_SPECIAL_ENABLED

/datum/holiday/boxing
	name = "Boxing Day"
	begin_day = 26
	begin_month = DECEMBER
	holiday_mail = list(
		/obj/item/clothing/gloves/boxing,
		/obj/item/clothing/gloves/boxing/blue,
		/obj/item/clothing/gloves/boxing/green,
		/obj/item/clothing/gloves/boxing/yellow,
	)

/datum/holiday/new_year
	name = NEW_YEAR
	begin_day = 31
	begin_month = DECEMBER
	end_day = 2
	end_month = JANUARY
	holiday_hat = /obj/item/clothing/head/costume/festive
	no_mail_holiday = TRUE

/datum/holiday/new_year/get_station_name()
	return pick("派对","新年","宿醉","决心","往昔")

// MOVING DATES

/datum/holiday/friday_thirteenth
	name = "Friday the 13th"

/datum/holiday/friday_thirteenth/shouldCelebrate(dd, mm, yyyy, ddd)
	if(dd == 13 && ddd == FRIDAY)
		return TRUE
	return FALSE

/datum/holiday/friday_thirteenth/get_station_name()
	return pick("迈克","星期五","邪恶","迈尔斯","谋杀","死亡","捅刺")

/datum/holiday/programmers
	name = "Programmers' Day"
	holiday_mail = list(/obj/item/sticker/robot)

/datum/holiday/programmers/shouldCelebrate(dd, mm, yyyy, ddd) //Programmer's day falls on the 2^8th day of the year
	if(mm == 9)
		if(yyyy/4 == round(yyyy/4)) //Note: Won't work right on September 12th, 2200 (at least it's a Friday!)
			if(dd == 12)
				return TRUE
		else
			if(dd == 13)
				return TRUE
	return FALSE

/datum/holiday/programmers/get_station_name()
	return pick("span>","DEBUG: ","null","/list","未找到事件前缀") //Portability

// ISLAMIC

/datum/holiday/islamic
	name = "Islamic calendar code broken"

/datum/holiday/islamic/shouldCelebrate(dd, mm, yyyy, ddd)
	var/datum/foreign_calendar/islamic/cal = new(yyyy, mm, dd)
	return ..(cal.dd, cal.mm, cal.yyyy, ddd)

/datum/holiday/islamic/ramadan
	name = "Start of Ramadan"
	begin_month = 9
	begin_day = 1
	end_day = 3

/datum/holiday/islamic/ramadan/get_station_name()
	return pick("哈拉姆","清真","圣战","穆斯林","阿尔","穆罕默德","拉希敦","伍麦叶","阿拔斯","阿卜杜勒","法蒂玛","阿尤布","穆瓦希德","阿布")

/datum/holiday/islamic/ramadan/end
	name = "End of Ramadan"
	end_month = 10
	begin_day = 28
	end_day = 1

// HEBREW

/datum/holiday/hebrew
	name = "If you see this the Hebrew holiday calendar code is broken"

/datum/holiday/hebrew/shouldCelebrate(dd, mm, yyyy, ddd)
	var/datum/foreign_calendar/hebrew/cal = new(yyyy, mm, dd)
	return ..(cal.dd, cal.mm, cal.yyyy, ddd)

/datum/holiday/hebrew/hanukkah
	name = "Hanukkah"
	begin_day = 25
	begin_month = 9
	end_day = 2
	end_month = 10

/datum/holiday/hebrew/hanukkah/greet()
	return "[pick("光明节", "哈努卡节")]快乐！"

/datum/holiday/hebrew/hanukkah/get_station_name()
	return pick("陀螺", "七枝烛台", "土豆饼", "金币")

/datum/holiday/hebrew/passover
	name = "Passover"
	begin_day = 15
	begin_month = 1
	end_day = 22

/datum/holiday/hebrew/passover/get_station_name()
	return pick("无酵饼", "摩西", "红海")

// EASTER (this having its own spot should be understandable)

/datum/holiday/easter
	name = EASTER
	holiday_hat = /obj/item/clothing/head/costume/rabbitears
	holiday_mail = list(
		/obj/item/clothing/head/costume/rabbitears,
		/obj/item/food/chocolatebunny,
		/obj/item/food/chocolateegg,
		/obj/item/food/egg/blue,
		/obj/item/food/egg/green,
		/obj/item/food/egg/orange,
		/obj/item/food/egg/purple,
		/obj/item/food/egg/rainbow,
		/obj/item/food/egg/red,
		/obj/item/food/egg/yellow,
	)
	var/const/days_early = 1 //to make editing the holiday easier
	var/const/days_extra = 1

/datum/holiday/easter/shouldCelebrate(dd, mm, yyyy, ddd)
	if(!begin_month)
		current_year = text2num(time2text(world.timeofday, "YYYY", world.timezone))
		var/list/easterResults = EasterDate(current_year+year_offset)

		begin_day = easterResults["day"]
		begin_month = easterResults["month"]

		end_day = begin_day + days_extra
		end_month = begin_month
		if(end_day >= 32 && end_month == MARCH) //begins in march, ends in april
			end_day -= 31
			end_month++
		if(end_day >= 31 && end_month == APRIL) //begins in april, ends in june
			end_day -= 30
			end_month++

		begin_day -= days_early
		if(begin_day <= 0)
			if(begin_month == APRIL)
				begin_day += 31
				begin_month-- //begins in march, ends in april

	return ..()

/datum/holiday/easter/celebrate()
	. = ..()
	GLOB.maintenance_loot += list(
		list(
			/obj/item/surprise_egg = 15,
			/obj/item/storage/basket/easter = 15
		) = maint_holiday_weight,
	)

/datum/holiday/easter/greet()
	return "问候！复活节快乐，记得留意复活节兔子！"

/datum/holiday/easter/get_station_name()
	return pick("毛茸茸","兔子","复活节","彩蛋")

/// Takes a holiday datum, a starting month, ending month, max amount of days to test in, and min/max year as input
/// Returns a list in the form list("yyyy/m/d", ...) representing all days the holiday runs on in the tested range
/proc/poll_holiday(datum/holiday/path, min_month, max_month, min_year, max_year, max_day)
	var/list/deets = list()
	for(var/year in min_year to max_year)
		for(var/month in min_month to max_month)
			for(var/day in 1 to max_day)
				var/datum/holiday/new_day = new path()
				if(new_day.shouldCelebrate(day, month, year, iso_to_weekday(day_of_month(year, month, day))))
					deets += "[year]/[month]/[day]"
	return deets

/// Does the same as [/proc/poll_holiday], but prints the output to admins instead of returning it
/proc/print_holiday(datum/holiday/path, min_month, max_month, min_year, max_year, max_day)
	var/list/deets = poll_holiday(path, min_month, max_month, min_year, max_year, max_day)
	message_admins("在输入范围 [min_year]-[max_year]/[min_month]-[max_month]/1-[max_day] 内，[path] 被接受的日期为 [deets.Join("\n")]")
