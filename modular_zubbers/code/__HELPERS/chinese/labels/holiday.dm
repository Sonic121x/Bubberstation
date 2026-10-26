/// Localize holiday labels while keeping the calendar's lookup keys unchanged.
/proc/chinese_holiday_display(value)
	var/static/list/names
	if(!names)
		names = list(
			"If you see this the holiday calendar code is broken" = "如果你看到这段文字，说明节日日历代码出错了",
			"Groundhog Day" = "土拨鼠日", "Waitangi Day" = "怀唐伊日", "Birthday of Space Station 13" = "空间站 13 的生日",
			"Random Acts of Kindness Day" = "随机善举日", "Leap Day" = "闰日", "Pi Day" = "圆周率日",
			"Cosmonautics Day" = "宇航节", "Four-Twenty" = "四·二零", "National Tea Day" = "全国茶日", "Earth Day" = "地球日", "ANZAC Day" = "澳新军团日",
			"Labor Day" = "劳动节", "Draconic Language Day" = "龙语日", "Firefighter's Day" = "消防员日", "Goth Day" = "哥特日", "Summer Solstice" = "夏至",
			"Doctor's Day" = "医生节", "UFO Day" = "UFO 日", "US Independence Day" = "美国独立日", "Writer's Day" = "作家节", "Bastille Day" = "巴士底日",
			"Wizard's Day" = "巫师日", "Friendship Day" = "友谊日", "International Day of the World's Indigenous Peoples" = "世界土著人民国际日", "Independence Day of Ukraine" = "乌克兰独立日",
			"Tiziran Unification Day" = "提兹拉统一日", "Stupid-Questions Day" = "蠢问题日", "Animal's Day" = "动物日", "Smiling Day" = "微笑日", "Boss' Day" = "老板节",
			"Anniversary of the Foundation of the United Nations" = "联合国成立纪念日", "October Revolution" = "十月革命", "Remembrance Day" = "阵亡将士纪念日", "Life Day" = "生命日",
			"Kindness Day" = "善良日", "Flowers Day" = "鲜花日", "Saying-'Hello' Day" = "说“你好”日", "Festival of Holy Lights" = "圣光节", "Human-Rights Day" = "人权日",
			"Mayan Doomsday Anniversary" = "玛雅末日纪念日", "Boxing Day" = "节礼日", "Friday the 13th" = "十三号星期五", "Programmers' Day" = "程序员节",
			"Islamic calendar code broken" = "伊斯兰历代码出错", "Start of Ramadan" = "斋月开始", "End of Ramadan" = "斋月结束",
			"If you see this the Hebrew holiday calendar code is broken" = "如果你看到这段文字，说明希伯来历节日代码出错了", "Hanukkah" = "光明节", "Passover" = "逾越节",
			NEW_YEAR = "新年", VALENTINES = "情人节", APRIL_FOOLS = "愚人节", EASTER = "复活节", HALLOWEEN = "万圣节", CHRISTMAS = "圣诞节", FESTIVE_SEASON = "节庆季",
			GARBAGEDAY = "垃圾日", MONKEYDAY = "猴子日", PRIDE_WEEK = "骄傲月", MOTH_WEEK = "蛾族周", IAN_HOLIDAY = "伊恩的生日", HOTDOG_DAY = "全国热狗日", ICE_CREAM_DAY = "全国冰淇淋日",
			CHERNOBYL_ANNIVERSARY = "切尔诺贝利灾难纪念日", LIZARD_ATRAKOR_DAY = "阿特拉科威力节", MOTH_FLEET_DAY = "舰队日", BEE_DAY = "蜜蜂日", BEER_DAY = "啤酒日", VEGAN_DAY = "纯素食日", TALK_LIKE_A_PIRATE_DAY = "学海盗说话日", ST_PATRICK_DAY = "圣帕特里克节"
		)
	return names[value] || value
