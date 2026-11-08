/proc/chinese_accessory_display(value, return_mapping = FALSE)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"ronin" = "浪人",
		"Brainslug" = "脑蛞蝓", "Shorter Long Bedhead-Akula" = "稍短长睡乱发（阿库拉）", "Reptilian Smooth" = "爬行类光滑尾", "Reptilian" = "爬行类",
		"Thunder" = "雷鸣", "Laevatain" = "莱瓦汀", "Theresa" = "特蕾莎", "Scar-L" = "SCAR-L",
		"None" = "无", "Round" = "圆形", "Simple" = "简约", "Short" = "短款", "Long" = "长款", "Aquatic" = "水生型", "Cat" = "猫", "Big" = "大型", "Coeurl" = "豹魔", "Fold" = "折耳", "Lynx" = "猞猁", "Cybernetic" = "机械", "Fox" = "狐狸",
		"Curled" = "卷曲", "Ram" = "公羊", "Angeler" = "斜角", "Sharp" = "尖形", "Sharp + Light" = "尖形加浅色", "Round + Light" = "圆形加浅色", "Short + Membrane" = "短款带膜", "Long + Membrane" = "长款带膜",
		"Ivy" = "常春藤", "Cabbage" = "卷心菜", "Spinach" = "菠菜", "Prayer" = "祈祷花", "Vine" = "藤蔓", "Shrub" = "灌木", "Rose" = "玫瑰", "Orchid" = "兰花", "Fig" = "无花果", "Hibiscus" = "木槿",
		"Dark Tiger Body" = "深色虎纹躯干", "Light Tiger Body" = "浅色虎纹躯干", "Light Belly" = "浅色腹部", "Reddish" = "微红", "Royal" = "王室", "Gothic" = "哥特", "White Fly" = "白蝇", "Whitefly" = "白蝇", "Lovers" = "恋人", "Burnt Off" = "烧焦", "Firewatch" = "守火者", "Deathshead" = "骷髅头", "Deathhead" = "骷髅头", "Poison" = "毒纹", "Ragged" = "破损", "Moon Fly" = "月蛾", "Moonfly" = "月蛾", "Oak Worm" = "橡树蚕", "Oakworm" = "橡树蚕", "Jungle" = "丛林", "Witch Wing" = "巫女之翼", "Witchwing" = "巫女之翼", "Lightbearer" = "持光者", "Dipped" = "浸染",
		"Crescent" = "新月", "Shark" = "鲨鱼", "Chonky" = "粗壮", "Smooth" = "光滑", "Dark Tiger" = "深色虎纹", "Light Tiger" = "浅色虎纹", "Spikes" = "尖刺", "Monkey" = "猴子", "Xeno" = "异形", "Xeno Queen" = "异形女王",
		"Plain" = "素色", "Monarch" = "帝王蝶", "Luna" = "月蛾", "Atlas" = "皇蛾", "Snow" = "雪白", "Rosy" = "玫红", "Feathery" = "羽状", "Brown" = "棕色", "Plasmafire" = "等离子烈焰", "Moffra" = "蛾斯拉", "Angel" = "天使", "Dragon" = "龙", "Megamoth" = "巨蛾", "Mothra" = "摩斯拉", "Skeleton" = "骨骼", "Robotic" = "机器人", "Fly" = "苍蝇", "Slime" = "史莱姆", "Regal" = "尊贵",
		"Beard (Abraham Lincoln)" = "胡须（林肯式）", "Beard (Broken Man)" = "胡须（落魄式）", "Beard (Chinstrap)" = "胡须（下颌带式）", "Beard (Dwarf)" = "胡须（矮人式）", "Beard (Full)" = "胡须（络腮胡）", "Beard (Cropped Fullbeard)" = "胡须（修短络腮胡）", "Beard (Goatee)" = "胡须（山羊胡）", "Beard (Hipster)" = "胡须（潮人式）", "Beard (Jensen)" = "胡须（詹森式）", "Beard (Neckbeard)" = "胡须（颈须）", "Beard (Very Long)" = "胡须（超长）", "Beard (Muttonmus)" = "胡须（连鬓八字胡）", "Beard (Martial Artist)" = "胡须（武术家式）", "Beard (Chinless Beard)" = "胡须（露下巴）", "Beard (Moonshiner)" = "胡须（私酒酿造者式）", "Beard (Long)" = "胡须（长款）", "Beard (Volaju)" = "胡须（沃拉久式）",
		"Beard (Three o Clock Shadow)" = "胡须（午后浅胡茬）", "Beard (Five o Clock Shadow)" = "胡须（傍晚胡茬）", "Beard (Five o Clock Moustache)" = "胡须（傍晚八字胡茬）", "Beard (Seven o Clock Shadow)" = "胡须（晚间浓胡茬）", "Beard (Seven o Clock Moustache)" = "胡须（晚间浓八字胡茬）", "Moustache" = "八字胡", "Moustache (Pencilstache)" = "八字胡（铅笔式）", "Moustache (Smallstache)" = "八字胡（小型）", "Moustache (Walrus)" = "八字胡（海象式）", "Moustache (Fu Manchu)" = "八字胡（傅满洲式）", "Moustache (Hulk Hogan)" = "八字胡（霍根式）", "Moustache (Selleck)" = "八字胡（塞勒克式）", "Moustache (Square)" = "八字胡（方形）", "Moustache (Van Dyke)" = "八字胡（范戴克式）", "Moustache (Watson)" = "八字胡（华生式）", "Moustache (Handlebar)" = "八字胡（翘尖）", "Moustache (Handlebar 2)" = "八字胡（翘尖2）", "Sideburns (Elvis)" = "鬓角（猫王式）", "Sideburns (Mutton Chops)" = "鬓角（羊排式）", "Sideburns" = "鬓角", "Shaved" = "剃净",
		"Afro" = "爆炸头", "Afro 2" = "爆炸头2", "Afro (Large)" = "爆炸头（大）", "Afro (Over Eyes)" = "爆炸头（遮眼）", "Afro (Three Quarters)" = "爆炸头（四分之三）", "Afro (Huge)" = "爆炸头（超大）", "All The Fuzz" = "蓬松毛团", "Ahoge" = "呆毛", "Anime Protagonist" = "动漫主角头", "Bald" = "光头", "Balding Hair" = "秃顶",
		"Bedhead" = "睡乱发", "Bedhead 2" = "睡乱发2", "Bedhead 3" = "睡乱发3", "Bedhead 4x" = "睡乱发4x", "Long Bedhead" = "长睡乱发", "Floorlength Bedhead" = "及地睡乱发", "Shorter Long Bedhead" = "稍短长睡乱发", "Beehive" = "蜂窝头", "Beehive 2" = "蜂窝头2", "Bob Hair" = "波波头", "Bob Hair 2" = "波波头2", "Bob Hair 3" = "波波头3", "Bob Hair 4" = "波波头4", "Bobcurl" = "卷曲波波头", "Boddicker" = "博迪克式", "Bowlcut" = "锅盖头", "Bowlcut 2" = "锅盖头2", "Bowl Cut Over Eyes" = "遮眼锅盖头",
		"Braid (Floorlength)" = "辫子（及地）", "Braided" = "编辫发", "Braided Front" = "前编辫", "Braid (High)" = "辫子（高）", "Braid (Low)" = "辫子（低）", "Braid (Short)" = "辫子（短）", "Braided Tail" = "辫尾", "Bun Head" = "发髻", "Bun Head 2" = "发髻2", "Bun Head 3" = "发髻3", "Bun (Large)" = "发髻（大）", "Bun (Manbun)" = "发髻（男式）", "Bun (Tight)" = "发髻（紧束）",
		"Business Hair" = "商务发型", "Business Hair 2" = "商务发型2", "Business Hair 3" = "商务发型3", "Business Hair 4" = "商务发型4", "Buzzcut" = "寸头", "Chin-Length Bob Cut" = "齐下巴波波头", "Comet" = "彗星式", "CIA" = "情报员式", "Coffee House" = "咖啡馆式", "Coily" = "细卷发", "Combover" = "侧梳遮顶", "Cornrows" = "玉米辫", "Cornrows 2" = "玉米辫2", "Cornrow Bun" = "玉米辫发髻", "Cornrow Braid" = "玉米辫长辫", "Cornrow Tail" = "玉米辫发尾", "Crewcut" = "平头", "Curls" = "卷发", "Curtains" = "帘式中分", "Cut Hair" = "修剪短发",
		"Dandy Pompadour" = "纨绔蓬巴杜头", "Devil Lock" = "恶魔前发", "Double Bun" = "双发髻", "Double Drills" = "双螺旋卷", "Dreadlocks" = "脏辫", "Drillruru" = "螺旋卷露露式", "Drill Hair (Extended)" = "螺旋卷（加长）", "Emo" = "情绪摇滚头", "Emo Fringe" = "情绪摇滚刘海", "Fade (None)" = "渐层（无）", "Fade (High)" = "渐层（高）", "Fade (Medium)" = "渐层（中）", "Fade (Low)" = "渐层（低）", "Fade (Bald)" = "渐层（剃光）", "Feather" = "羽毛头", "Father" = "老爸式", "Flat Top" = "平顶头", "Flair" = "张扬式", "Flat Top (Big)" = "平顶头（大）", "Flow Hair" = "飘逸发", "Fluffy Mess" = "蓬松乱发", "Frizzy Sidecut" = "毛躁侧剃", "Gelled Back" = "发胶背头", "Gentle" = "温柔式",
		"Half-banged Hair" = "半边刘海", "Half-banged Hair 2" = "半边刘海2", "Half-shaved" = "半剃发", "Hedgehog Hair" = "刺猬头", "Hightop Slant" = "斜高顶", "Hime Cut" = "公主切", "Hime Cut 2" = "公主切2", "Hime Cut (Short)" = "公主切（短）", "Hime Updo" = "公主盘发", "Hitop" = "高顶头", "Jade" = "翡翠式", "Jensen Hair" = "詹森式发型", "Joestar" = "乔斯达式", "Keanu Hair" = "基努式发型", "Killmonger" = "杀戮者式", "Kusanagi Hair" = "草薙式发型",
		"Long Dreadlocks" = "长脏辫", "Long Hair 1" = "长发1", "Long Hair 2" = "长发2", "Long Hair 3" = "长发3", "Long Over Eye" = "长遮眼发", "Long Bangs" = "长刘海", "Long Dreads Up" = "长脏辫盘发", "Long Emo" = "长情绪摇滚头", "Long Fringe" = "长碎刘海", "Long Sidecut" = "长侧剃发", "Long Side Part" = "长侧分发", "Long Wavy" = "长波浪发", "Mega Eyebrows" = "超浓眉", "Messy" = "凌乱发", "Modern" = "现代式", "Mohawk" = "莫霍克头", "Nitori" = "荷取式", "Mohawk (Reverse)" = "莫霍克头（反向）", "Mohawk (Shaved)" = "莫霍克头（剃边）", "Mohawk (Unshaven)" = "莫霍克头（未剃边）", "Mohawk (Tall)" = "莫霍克头（高）", "Money Piece" = "脸侧挑染", "Mulder" = "穆德式", "Mullet" = "鲻鱼头", "Mullet with Rat Tail" = "鼠尾鲻鱼头", "Odango" = "团子头", "Ombre" = "渐变染发", "One Shoulder" = "单肩披发", "Over Eye" = "遮眼发", "Over Eye 2" = "遮眼发2", "Oxton" = "奥克斯顿式",
		"Parted" = "分缝发", "Parted (Side)" = "分缝发（侧分）", "Pigtails" = "双辫", "Pigtails 2" = "双辫2", "Pigtails 3" = "双辫3", "Pigtails 4" = "双辫4", "Pigtails 5" = "双辫5", "Pigtails (Antenna)" = "双辫（触角式）", "Pigtails (Cupid)" = "双辫（丘比特式）", "Pixie Cut" = "精灵短发", "Pompadour" = "蓬巴杜头", "Pompadour (Big)" = "蓬巴杜头（大）", "Ponytail" = "马尾", "Ponytail 2" = "马尾2", "Ponytail 3" = "马尾3", "Ponytail 4" = "马尾4", "Ponytail 5" = "马尾5", "Ponytail 6" = "马尾6", "Ponytail 7" = "马尾7", "Ponytail (High)" = "马尾（高）", "Ponytail (Short)" = "马尾（短）", "Ponytail (Long)" = "马尾（长）", "Ponytail (Country)" = "马尾（乡村式）", "Ponytail (Fringe)" = "马尾（带刘海）", "Ponytail (Side)" = "马尾（侧扎）", "Ponytail (Side) 2" = "马尾（侧扎）2", "Ponytail (Side) 3" = "马尾（侧扎）3", "Ponytail (Side) 4" = "马尾（侧扎）4", "Ponytail (Spiky)" = "马尾（尖刺）", "Ponytail (Fro)" = "马尾（蓬松）", "Ponytail (Wavy)" = "马尾（波浪）",
		"Poofy" = "蓬蓬头", "Quiff" = "翘刘海", "Ronin" = "浪人式", "Sadako" = "贞子式", "Shaved Part" = "剃线分缝", "Short Bangs" = "短刘海", "Short Bangs 2" = "短刘海2", "Shorter Bangs" = "更短刘海", "Short Hair" = "短发", "Short Hair 2" = "短发2", "Short Hair 3" = "短发3", "Short Hair 4" = "短发4", "Short Hair 5" = "短发5", "Short Hair 6" = "短发6", "Short Hair 7" = "短发7", "Short Hair 80s" = "八十年代短发", "Short Hair Rosa" = "罗莎短发", "Short Wavy" = "短波浪发", "Shoulder-length Hair" = "齐肩发", "Sidecut" = "侧剃发", "Sidecut Bang" = "侧剃刘海", "Singed Blown Back" = "烧焦后掠发", "Singed Pigtails" = "烧焦双辫", "Skinhead" = "贴皮寸头", "Slightly Long Hair" = "稍长发", "Spiky" = "尖刺发", "Spiky 2" = "尖刺发2", "Spiky 3" = "尖刺发3", "Swept Back Hair" = "后梳发", "Swept Back Hair 2" = "后梳发2", "Swirly Curls" = "旋卷发", "Swirl Curls Alt" = "旋卷发变体", "Tayama" = "田山式",
		"Thinning" = "稀疏发", "Thinning (Front)" = "稀疏发（前部）", "Thinning (Rear)" = "稀疏发（后部）", "Topknot" = "顶髻", "Tress Shoulder" = "肩侧发束", "Trimmed" = "整齐修剪", "Trim Flat" = "平整修剪", "Twintails" = "双马尾", "Twintails (Wavy)" = "双马尾（波浪）", "Undercut" = "底部剃短", "Undercut Left" = "左侧剃短", "Undercut Right" = "右侧剃短", "Unkept" = "不修边幅", "Updo" = "盘发", "Very Long Hair" = "超长发", "Very Long Hair 2" = "超长发2", "Very Long Over Eye" = "超长遮眼发", "Very Short Over Eye" = "超短遮眼发", "Very Long with Fringe" = "超长带刘海", "Volaju" = "沃拉久式", "Wisp" = "纤细发缕", "Wolfcut" = "狼尾头", "Ziegler" = "齐格勒式",
		"Full" = "全染", "Fade Up" = "向上渐变", "Fade Down" = "向下渐变", "Vertical Split" = "纵向分色", "Horizontal Split" = "横向分色", "Reflected" = "镜像", "Reflected Inverse" = "反向镜像", "Wavy" = "波浪", "Long Fade Up" = "长发向上渐变", "Long Fade Down" = "长发向下渐变", "Short Fade Up" = "短发向上渐变", "Short Fade Down" = "短发向下渐变", "Spiked Wavy" = "尖刺波浪", "striped" = "条纹", "Striped Vertical" = "纵条纹",
		"Nude" = "不穿", "Briefs" = "三角内裤", "Boxers" = "平角内裤", "Striped Boxers" = "条纹平角内裤", "Midway Boxers" = "中长平角内裤", "Long Johns" = "长内裤", "Jockstrap" = "护裆内裤", "Mankini" = "男式比基尼", "Hearts Boxers" = "爱心平角内裤", "Commie Boxers" = "共产主义平角内裤", "Freedom Boxers" = "自由旗帜平角内裤", "UK Boxers" = "英国旗平角内裤", "Bikini" = "比基尼", "Lace Bikini" = "蕾丝比基尼", "Bralette w/ Boyshorts" = "无钢圈胸衣配女式平角裤", "Sports Bra w/ Boyshorts" = "运动胸衣配女式平角裤", "Thong" = "丁字裤", "Strapless Bikini" = "无肩带比基尼", "Babydoll" = "娃娃裙睡衣", "One-Piece Swimsuit" = "连体泳衣", "Strapless One-Piece Swimsuit" = "无肩带连体泳衣", "Two-Piece Swimsuit" = "分体泳衣", "Strapless Two-Piece Swimsuit" = "无肩带分体泳衣", "Strapless Striped Swimsuit" = "无肩带条纹泳衣", "Halter Swimsuit" = "挂脖泳衣", "Neko Bikini (White)" = "猫咪比基尼（白）", "Neko Bikini (Black)" = "猫咪比基尼（黑）", "Commie Bikini" = "共产主义比基尼", "Freedom Bikini" = "自由旗帜比基尼", "UK Bikini" = "英国旗比基尼", "Lingerie" = "情趣内衣",
		"Jersey (Blue)" = "球衣（蓝）", "Jersey (Red)" = "球衣（红）", "Polo Shirt (Blue)" = "翻领衫（蓝）", "Polo Shirt (Gray-Yellow)" = "翻领衫（灰黄）", "Polo Shirt (Red)" = "翻领衫（红）", "Polo Shirt (White)" = "翻领衫（白）", "Shirt (Alien)" = "衬衫（外星人）", "Shirt (Band)" = "衬衫（乐队）", "Shirt (Black)" = "衬衫（黑）", "Shirt (Blue)" = "衬衫（蓝）", "Shirt (Clown)" = "衬衫（小丑）", "Shirt (Commie)" = "衬衫（共产主义）", "Shirt (Green)" = "衬衫（绿）", "Shirt (Grey)" = "衬衫（灰）", "Shirt (Ian)" = "衬衫（伊恩）", "Shirt (I Love NT)" = "衬衫（我爱纳米传讯）", "Shirt (Lover)" = "衬衫（恋人）", "Shirt (Matroska)" = "衬衫（水手）", "Shirt (Meat)" = "衬衫（肉）", "Shirt (Nanotrasen)" = "衬衫（纳米传讯）", "Shirt (Peace)" = "衬衫（和平）", "Shirt (Pogoman)" = "衬衫（弹跳人）", "Shirt (Question)" = "衬衫（问号）", "Shirt (Red)" = "衬衫（红）", "Shirt (Skull)" = "衬衫（骷髅）", "Shirt (SS13)" = "衬衫（SS13）", "Shirt (Striped)" = "衬衫（条纹）", "Shirt (Tie-dye)" = "衬衫（扎染）", "Shirt (UK)" = "衬衫（英国旗）", "Shirt (USA)" = "衬衫（美国旗）", "Shirt (White)" = "衬衫（白）",
		"Short-sleeved Shirt (Black)" = "短袖衫（黑）", "Short-sleeved Shirt (Blue)" = "短袖衫（蓝）", "Short-sleeved Shirt (Green)" = "短袖衫（绿）", "Short-sleeved Shirt (Purple)" = "短袖衫（紫）", "Short-sleeved Shirt (White)" = "短袖衫（白）", "Sports Bra" = "运动胸衣", "Sports Bra (Alt)" = "运动胸衣（变体）", "Sports Shirt (Blue)" = "运动衫（蓝）", "Sports Shirt (Green)" = "运动衫（绿）", "Sports Shirt (Red)" = "运动衫（红）", "Tank Top (Black)" = "背心（黑）", "Tank Top (Fire)" = "背心（火焰）", "Tank Top (Grey)" = "背心（灰）", "Tank Top (Midriff)" = "背心（露脐）", "Tank Top (Red)" = "背心（红）", "Tank Top (Striped)" = "背心（条纹）", "Tank Top (White)" = "背心（白）", "Top (Red)" = "上衣（红）", "Top (White)" = "上衣（白）", "T-Shirt (Blue)" = "T恤（蓝）", "T-Shirt (Green)" = "T恤（绿）", "T-Shirt (Red)" = "T恤（红）", "T-Shirt (Yellow)" = "T恤（黄）",
		"Knee-high (Ace)" = "及膝袜（无性恋旗）", "Knee-high (Bee)" = "及膝袜（蜜蜂）", "Knee-high (Black)" = "及膝袜（黑）", "Knee-High (Commie)" = "及膝袜（共产主义）", "Knee-High (Freedom)" = "及膝袜（自由旗帜）", "Knee-high (Rainbow)" = "及膝袜（彩虹）", "Knee-high (Striped)" = "及膝袜（条纹）", "Knee-high (Thin)" = "及膝袜（薄款）", "Knee-high (Trans)" = "及膝袜（跨性别旗）", "Knee-High (UK)" = "及膝袜（英国旗）", "Knee-high (White)" = "及膝袜（白）", "Knee-high (Fishnet)" = "及膝袜（渔网）", "Normal (Black)" = "普通袜（黑）", "Normal (White)" = "普通袜（白）", "Pantyhose" = "连裤袜", "Short (Black)" = "短袜（黑）", "Short (White)" = "短袜（白）",
		"Stockings (Blue)" = "长袜（蓝）", "Stockings (Cyan)" = "长袜（青）", "Stockings (Dark Pink)" = "长袜（深粉）", "Stockings (Green)" = "长袜（绿）", "Stockings (Orange)" = "长袜（橙）", "Stockings (Programmer)" = "长袜（程序员）", "Stockings (Purple)" = "长袜（紫）", "Stockings (Yellow)" = "长袜（黄）", "Stockings (Fishnet)" = "长袜（渔网）", "Thigh-high (Ace)" = "过膝袜（无性恋旗）", "Thigh-high (Bee)" = "过膝袜（蜜蜂）", "Thigh-high (Black)" = "过膝袜（黑）", "Thigh-high (Commie)" = "过膝袜（共产主义）", "Thigh-high (Freedom)" = "过膝袜（自由旗帜）", "Thigh-high (Rainbow)" = "过膝袜（彩虹）", "Thigh-high (Striped)" = "过膝袜（条纹）", "Thigh-high (Thin)" = "过膝袜（薄款）", "Thigh-high (Trans)" = "过膝袜（跨性别旗）", "Thigh-high (UK)" = "过膝袜（英国旗）", "Thigh-high (White)" = "过膝袜（白）", "Thigh-high (Fishnet)" = "过膝袜（渔网）", "Thocks" = "一体过膝袜"
	)
	display_names |= chinese_zubbers_modules_accessory_display(null, TRUE)
	display_names |= chinese_zubbers_species_accessory_display(null, TRUE)
	if(return_mapping)
		return display_names
	return display_names[value] || chinese_zubbers_choice_display(value)

/proc/chinese_accessory_choice(mob/user, message, title, list/choices)
	var/list/display_choices = list()
	for(var/value in choices)
		display_choices["[chinese_accessory_display(value)] ([value])"] = value
	var/selection = tgui_input_list(user, message, title, display_choices)
	return isnull(selection) ? null : display_choices[selection]

/datum/preference/choiced/proc/chinese_accessory_choice_names(list/choices)
	if(!chinese_zubbers_quirk_choice() && !istype(src, /datum/preference/choiced/species_feature) && !istype(src, /datum/preference/choiced/mutant_choice) && !istype(src, /datum/preference/choiced/hairstyle) && !istype(src, /datum/preference/choiced/facial_hairstyle) && !istype(src, /datum/preference/choiced/hair_gradient) && !istype(src, /datum/preference/choiced/underwear) && !istype(src, /datum/preference/choiced/undershirt) && !istype(src, /datum/preference/choiced/socks))
		return null
	var/list/display_names = list()
	for(var/value in choices)
		display_names[value] = chinese_accessory_display(value)
	return display_names

/proc/chinese_objective_choice(mob/user, message, title, list/choices, default_value)
	var/static/list/objective_names
	if(isnull(objective_names))
		objective_names = list(
		"generic objective" = "通用目标", "assassinate" = "暗杀", "mutiny" = "兵变", "maroon" = "放逐", "debrain" = "夺取大脑", "protect" = "保护", "protect nonhuman" = "保护非人类", "jailbreak" = "越狱", "detain" = "拘押", "hijack" = "劫持", "elimination" = "清除", "no organics on shuttle" = "禁止有机生命登上穿梭机", "no mutants on shuttle" = "禁止变种人登上穿梭机", "robot army" = "机器人军团", "escape" = "逃离", "escape with identity" = "冒用身份逃离", "survive" = "存活", "survive AI" = "人工智能存活", "exile" = "流亡", "martyr" = "殉道", "nuclear" = "核爆", "steal" = "盗窃", "capture" = "俘获", "protect object" = "保护物品", "absorb" = "吸收", "absorb most" = "吸收最多目标", "absorb changeling" = "吸收变形怪", "destroy AI" = "摧毁人工智能", "steal five of" = "盗取五件物品", "steal guns" = "盗取枪械", "steal magic" = "盗取魔法物品", "steal organs" = "盗取器官", "custom" = "自定义", "kill all clones" = "杀死所有克隆体", "prison breakout" = "救人越狱", "survey" = "调查"
	)
	var/list/display_choices = list()
	for(var/value in choices)
		display_choices["[objective_names[value] || chinese_bloodsucker_objective_display(value)] ([value])"] = value
	var/display_default = "[objective_names[default_value] || chinese_bloodsucker_objective_display(default_value)] ([default_value])"
	var/selection = tgui_input_list(user, message, title, display_choices, display_default)
	return isnull(selection) ? null : display_choices[selection]

/proc/chinese_outfit_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list("Naked" = "裸体", "Custom" = "自定义", "As Job..." = "按职业……", "As Plasmaman..." = "等离子人装备……", "Standard Gear" = "标准装备")
	return display_names[value] || chinese_preset_outfit_display(value)

/proc/chinese_preset_outfit_display(value)
	var/known_name = chinese_zubbers_modules_outfit_display(value)
	if(known_name != value)
		return known_name
	var/static/list/names
	var/static/list/prefixes
	var/static/list/suffixes
	if(isnull(names))
		names = list(
			"811 Response: Advanced Atmospherics" = "811 应急响应：高级大气技术员",
			"911 Response: Armed S.W.A.T. Officer" = "911 应急响应：武装特警", "911 Response: Base" = "911 应急响应：基础装备",
			"911 Response: EMT" = "911 应急响应：急救员", "911 Response: Marshal" = "911 应急响应：执法官", "911 Response: TerraGov Military" = "911 应急响应：地球政府军",
			"Abductor" = "绑架者", "Abductor Lobotomite" = "绑架者脑叶切除实验体", "Akula" = "阿库拉", "Cargo-Technician" = "货运技术员", "Security-Officer" = "安保官",
			"Command" = "指挥人员", "Doctor" = "医生", "Engineer" = "工程师", "Security" = "安保人员",
			"Ancient Engineer" = "远古工程师", "Ancient Scientist" = "远古科学家", "Ancient Security" = "远古安保人员",
			"Archer Clock Cultist" = "发条教徒弓箭手", "Armored Clock Cultist" = "重甲发条教徒", "Seer Clock Cultist" = "发条教徒先知", "Support Clock Cultist" = "支援发条教徒",
			"Clock Cultist" = "发条教徒", "Clockwork Cultist Base" = "发条教徒基础装备", "Default Clock Cultist" = "默认发条教徒",
			"Armed Black Mesa Security" = "武装黑山基地安保人员", "Armed Black Ops" = "武装秘密行动特工",
			"Ash Walker" = "灰行者", "Ash Walker - Spear" = "灰行者（长矛）",
			"Assault Ops - Background Dudes - Preview ONLY" = "突击特工（背景人员，仅供预览）", "Assault Ops - Default" = "突击特工（默认）", "Assault Ops - Preview ONLY" = "突击特工（仅供预览）",
			"Asset Protection Officer" = "资产保护专员", "Blood Cultist" = "血教徒",
			"Assistant - Breathmask" = "助理（呼吸面罩）", "Assistant - Consistent" = "助理（固定装备）", "Assistant - Hitchhiker" = "助理（搭便车者）", "Assistant - Preview" = "助理（预览）",
			"BLF Operative" = "BLF 特工", "BMRF HECU" = "黑山研究设施 HECU 士兵", "BMRF Science Team" = "黑山研究设施科研人员", "BMRF Security Guard" = "黑山研究设施保安",
			"Beach Bum" = "海滩浪子", "Beach Lifeguard" = "海滩救生员", "Bitrunning SolFed Marine" = "比特潜行太阳联邦陆战队员",
			"Black Market Trader" = "黑市商人", "Black Mesa Security" = "黑山基地安保人员", "Black Ops" = "秘密行动特工",
			"Bluespace Tech (Admin)" = "蓝空间技师（管理员）",
			"Bunny Magician" = "兔装魔术师", "Bunny Waiter" = "兔装侍者", "Bunny Waiter (British)" = "兔装侍者（英国）", "Bunny Waiter (CentCom)" = "兔装侍者（中央指挥部）",
			"Bunny Waiter (Communist)" = "兔装侍者（共产主义）", "Bunny Waiter (USA)" = "兔装侍者（美国）", "Butler" = "管家",
			"Cat Butcher Uniform" = "猫屠夫制服", "Clown vox" = "沃克斯小丑", "Mime vox" = "沃克斯默剧演员",
			"Coalition Operative" = "联盟特工", "Coalition Operative SNPC" = "联盟特工（简单非玩家角色）", "Colonist (Frontier)" = "边疆殖民者",
			"Corpse Assistant" = "助理尸体", "Corpse Doctor" = "医生尸体", "Crashed Survey Ship Laborer" = "坠毁勘探船劳工", "Cryogenic Bartender" = "冷冻休眠调酒师",
			"DS-2 Command Operative" = "DS-2 指挥特工", "DS-2 Corporate Liasion" = "DS-2 企业联络官", "Dead Museum Cafeteria Chef" = "博物馆食堂厨师尸体",
			"Apprentice" = "学徒", "Assistant loadout" = "助理配装", "Assistant loadout (Weaponless)" = "助理配装（无武器）", "Battlemage" = "战斗法师", "Battler Base" = "战斗员基础装备",
			"Blood Miner" = "鲜血矿工", "Chaos" = "混沌", "Chuuni" = "中二病", "Clown (Syndicate Gear)" = "小丑（辛迪加装备）", "Coder" = "程序员", "Cowboy" = "牛仔", "Cuban Pete" = "古巴皮特",
			"Cultist Artificer" = "血教工匠", "Cultist Invoker" = "血教祈咒者", "Druid" = "德鲁伊", "Electromancer" = "雷电法师",
			"Ethereal Species" = "以太人种族", "Felinid Species" = "猫人种族", "Human Species" = "人类种族", "Lizard Species" = "蜥蜴人种族", "Moth Species" = "蛾人种族", "Plasmaman Species" = "等离子人种族",
			"Gunmancer" = "枪械法师", "Heretic Scribe" = "异端抄写员", "Heretic Warrior" = "异端战士", "Holy Crusader" = "神圣十字军", "LARPer" = "现实扮演者",
			"Lattice loadout" = "格栅配装", "Master Chef" = "厨艺大师", "Melee Operative" = "近战特工", "Monkey" = "猴子", "Naked" = "裸体", "Necromancer" = "死灵法师", "North Star" = "北极星",
			"Operative" = "特工", "Pyromancer" = "烈焰法师", "Raider" = "劫掠者", "Ranged Operative" = "远程特工", "Ripper" = "撕裂者", "Samurai" = "武士", "Sniper" = "狙击手", "Soldier" = "士兵", "Surgeon" = "外科医生", "Tider" = "灰潮",
			"Instagib" = "一击必杀", "Spaceman" = "太空人", "Syndicate Spaceman" = "辛迪加太空人", "Assistant (Spaceworthy)" = "助理（太空作业）",
			"Default ERT outfit" = "默认紧急响应小队装备", "Doctor Hilbert" = "希尔伯特博士", "Dragoon" = "龙骑兵",
			"Faction - Captain" = "派系舰长", "Faction - Crew" = "派系船员", "Faction - Goon" = "派系打手", "Faction - Medic" = "派系医护", "Faction - Tech" = "派系技术员",
			"Freighter Boss" = "货船领班", "Freighter Crew" = "货船船员", "Freighter Excavator" = "货船挖掘工", "Fumigator" = "熏蒸队员", "Fumigator Leader" = "熏蒸队长",
			"Gimmick Assistant" = "特色助理", "Artist" = "艺术家", "Bear" = "熊", "Bee" = "蜜蜂", "Broomer" = "扫帚工", "Cardborg" = "纸板赛博", "Chicken" = "鸡",
			"Firefighter" = "消防员", "Fisher" = "渔夫", "Fleshy" = "血肉怪", "Gardener" = "园丁", "Hall Monitor" = "走廊督察", "Handyman" = "杂务工", "Lightbringer" = "提灯者",
			"Magician" = "魔术师", "Mopper" = "拖地工", "Patient" = "病人", "Rollerskater" = "轮滑者", "Skater" = "滑板手",
			"Gordon Freeman" = "戈登·弗里曼", "Guild Default Outfit" = "公会默认装备", "HECU Captain" = "HECU 队长", "HECU Grunt" = "HECU 步兵", "HECU Ranged" = "HECU 射手", "HECU SMG" = "HECU 冲锋枪手",
			"Hotel Security" = "酒店保安", "Hotel Staff" = "酒店职员", "Hotel Staff Manager" = "酒店经理", "Human AI" = "人类人工智能",
			"Icemoon Interdyne Shaft Miner" = "冰月英特戴恩矿工", "Icemoon Syndicate Comms Agent" = "冰月辛迪加通讯特工", "Interdyne Bioweapon Scientist" = "英特戴恩生物武器科学家",
			"Interdyne Deck Officer" = "英特戴恩甲板军官", "Interdyne Shaft Miner" = "英特戴恩矿工",
			"Lavaland Hermit" = "拉瓦兰隐士", "Lavaland Prisoner" = "拉瓦兰囚犯", "Lavaland Syndicate Agent" = "拉瓦兰辛迪加特工", "Lavaland Syndicate Comms Agent" = "拉瓦兰辛迪加通讯特工",
			"Ashwalker" = "灰行者", "Dame" = "女骑士", "Golem" = "魔像", "Miner" = "矿工", "Settler" = "定居者", "Shadowperson" = "暗影人", "Tribal Mothman" = "部落蛾人",
			"Lizard Gas Station Attendant" = "蜥蜴人加油站服务员", "Lizard Gas Station Manager" = "蜥蜴人加油站经理", "Lone Infiltrator" = "独行渗透者",
			"Abductee" = "被绑架者", "Castlegoer" = "城堡访客", "Default Outfit" = "默认装备", "Fugitive" = "逃犯", "Nightmare" = "梦魇", "Ninja" = "忍者", "Obsessed" = "痴迷者", "Outwear" = "外套", "Syndicate" = "辛迪加", "Wastelander" = "废土客",
			"Mining Site Overseer" = "矿场监督员", "Mining Site Worker" = "矿场工人", "Mr Bones' Corpse" = "骷髅先生的尸体", "Mr. Runtime" = "运行时先生",
			"NT Private Security Officer" = "纳米传讯私人安保官", "NT Assault Officer" = "纳米传讯突击队员", "NT Elite Assault Officer" = "纳米传讯精英突击队员", "Nanotrasen Private Security Commander" = "纳米传讯私人安保指挥官",
			"ODST" = "轨道空降突击兵", "Pan-Slavic Field Officer" = "泛斯拉夫战地军官", "Paper Wizard" = "纸片巫师",
			"Pirate Gunner" = "海盗炮手", "Pirate Swashbuckler" = "海盗剑客", "Pizza Delivery Boy" = "披萨配送员", "Pizza Delivery Manager" = "披萨配送经理",
			"Plasma Miner" = "等离子矿工", "Prey Pod Victim" = "猎物舱受害者", "Privateer Slaver" = "私掠贩奴者", "Privateer Slaver Captain" = "私掠贩奴舰长",
			"Ranged Russian" = "俄国射手", "Ranged Russian Trooper" = "俄国远程步兵", "Russian" = "俄国人", "Russian Officer" = "俄国军官",
			"Revolution" = "革命军", "RoroCo Glove Packer" = "罗罗公司手套包装工", "Roroco Fabric Technician" = "罗罗公司纺织技术员", "Scientist - Consistent" = "科学家（固定装备）",
			"Security Guard" = "保安", "Shuttle Nuclear Operative" = "穿梭机核爆特工", "Skeleton Cultist" = "骷髅血教徒", "Space Wizard" = "太空巫师",
			"Syndicate Battlecruiser Assault Operative" = "辛迪加战列巡洋舰突击特工", "Syndicate Battlecruiser Ship Operative" = "辛迪加战列巡洋舰舰上特工",
			"Syndicate Bunny Assassin" = "辛迪加兔装刺客", "Syndicate Commando" = "辛迪加突击队员", "Syndicate Pilot" = "辛迪加飞行员",
			"Syndicate Operative - Infiltrator" = "辛迪加特工（渗透者）", "Syndicate Operative Empty" = "辛迪加特工（空装备）",
			"Syndicate Ship Base" = "辛迪加舰船基础装备", "Syndicate Ship Crew Member" = "辛迪加舰船船员", "Syndicate Snow Operative" = "辛迪加雪地特工", "Syndicate Stormtrooper" = "辛迪加突击兵",
			"Templar" = "圣殿骑士", "Tiger Cooperative" = "猛虎合作社", "Trauma Team" = "创伤小队", "Vox" = "沃克斯", "Vítězství Arms SRT Contractor" = "胜利军械 SRT 承包商",
			"default ds2 outfit" = "DS-2 默认装备", "improper Waystation Outfit" = "中转站装备",
		)
		prefixes = list("Deathmatch: " = "死斗：", "DM: " = "死斗：", "Gimmick Assistant - " = "特色助理：", "Legion-Consumed " = "被军团吞噬的", "Mafia " = "黑手党：", "Akula " = "阿库拉")
		suffixes = list(
			" (MODsuit)" = "（MOD 外骨骼）", " (MODSuit)" = "（MOD 外骨骼）", " Plasmaman" = "（等离子人）",
			" (Preview only)" = "（仅供预览）", " - Space" = "（太空）", " (Softsuit)" = "（软式太空服）", " (Less Antag Gear)" = "（精简反派装备）",
			" (Gloves)" = "（手套）", " (Combat-Ready)" = "（战斗装备）", " (Equipment + MODsuit)" = "（装备及 MOD 外骨骼）", " (Equipment)" = "（装备）", " Corpse" = "尸体",
		)
	if(names[value])
		return names[value]
	if(!istext(value))
		return value
	var/plain_name = format_text(value)
	if(plain_name != value)
		return chinese_preset_outfit_display(plain_name)
	for(var/suffix in suffixes)
		if(length(value) > length(suffix) && copytext(value, -length(suffix)) == suffix)
			var/base_name = copytext(value, 1, length(value) - length(suffix) + 1)
			var/base_display = chinese_outfit_display(base_name)
			if(base_display != base_name)
				return "[base_display][suffixes[suffix]]"
	for(var/prefix in prefixes)
		if(findtextEx(value, prefix) == 1)
			var/base_name = copytext(value, length(prefix) + 1)
			var/base_display = chinese_outfit_display(base_name)
			if(base_display != base_name)
				return "[prefixes[prefix]][base_display]"
	return value

/proc/chinese_granter_spell_display(value)
	var/static/list/names
	if(isnull(names))
		names = list("fireball" = "火球术", "smoke" = "烟雾术", "blind" = "致盲术", "forcewall" = "力场墙", "knock" = "敲击术", "barnyard" = "畜栏诅咒", "charge" = "充能术")
	return names[value] || value

/proc/chinese_slime_crossbreed_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list("reproductive" = "繁殖型", "symbiont" = "共生型", "consuming" = "吞噬型", "industrial" = "工业型", "regenerative" = "再生型", "self-sustaining" = "自给型", "burning" = "燃烧型", "charged" = "充能型", "sanguine" = "血液型", "stabilized" = "稳定型", "chilling" = "寒冷型", "gentle" = "温和型", "mutative" = "突变型", "loyal" = "忠诚型", "transformative" = "变形型", "detonating" = "爆炸型", "crystalline" = "晶体型", "warping" = "跃迁型", "prismatic" = "棱彩型", "recurring" = "循环型", "lengthened" = "延长型", "hyperchromatic" = "超彩型")
	return display_names[value] || value

/proc/chinese_outfit_choice(mob/user, message, title, list/choices)
	var/list/display_choices = list()
	for(var/value in choices)
		var/display_name = chinese_outfit_display(value)
		var/unique_name = display_name
		var/duplicate = 1
		while(unique_name in display_choices)
			unique_name = "[display_name]（选项[++duplicate]）"
		display_choices[unique_name] = value
	var/selection = tgui_input_list(user, message, title, display_choices)
	return isnull(selection) ? null : display_choices[selection]
