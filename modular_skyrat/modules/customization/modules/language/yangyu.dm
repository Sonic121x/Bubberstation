/datum/language/yangyu
	name = "Martian Yangyu"
	desc = "又称“Konjin”，这一语系是汉语、藏语、缅语以及其他亚洲语言之间存在亲缘关系的产物， \
	该关系最早于十九世纪初被提出。在人类疆域中，这一语系是仅次于银河通用语的第二大语言。 \
	许多借词、习语与文化遗存得以延续至今，尤其是在来自火星城市的母语者的日常生活中。"
	key = "Y"
	flags = LANGUAGE_TONGUELESS_SPEECH
	space_chance = 70
	// Entirely Chinese save for the isolated 2 "nya" style syllables. I don't want to bloat the syllable list with other mixes, but they generally sound somewhat alike.
	syllables = list (
		"ai", "ang", "bai", "beng", "bian", "biao", "bie", "bing", "cai", "can", "cao", "cei", "ceng", "chai", "chan", "chang",
		"chen", "chi", "chong", "chou", "chu", "chuai", "chuang", "chui", "chun", "dai", "dao", "dang", "deng", "diao", "dong", "duan",
		"fain", "fang", "feng", "fou", "gai", "gang", "gao", "gong", "guai", "guang", "hai", "han", "hang", "hao", "heng", "huai", "ji", "jiang",
		"jiao", "jin", "jun", "kai", "kang", "kong", "kuang", "lang", "lao", "liang", "ling", "long", "luan", "mao", "meng", "mian", "miao",
		"ming", "miu", "nyai", "nang", "nao", "neng", "nyang", "nuan", "qi", "qiang", "qiao", "quan", "qing", "sen", "shang", "shao", "shuan", "song", "tai",
		"tang", "tian", "tiao", "tong", "tuan", "wai", "wang", "wei", "weng", "xi", "xiang", "xiao", "xie", "xin", "xing", "xiong", "xiu", "xuan", "xue", "yan", "yang",
		"yao", "yin", "ying", "yong", "yuan", "zang", "zao", "zeng", "zhai", "zhang",
		"zhen", "zhi", "zhuai", "zhui", "zou", "zun", "zuo"
	)
	icon_state = "hanzi"
	icon = 'modular_skyrat/master_files/icons/misc/language.dmi'
	default_priority = 94
	default_name_syllable_min = 1
	default_name_syllable_max = 2
