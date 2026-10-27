// Modularly set the correct icon file
/obj/machinery/barsign/update_icon_state()
	. = ..()
	// uses tg icon file
	if(!istype(chosen_sign, /datum/barsign/skyrat) || icon_state == "empty")
		icon = initial(icon)
		return

	// uses modular icon file
	if(istype(chosen_sign, /datum/barsign/skyrat/large))
		icon = SKYRAT_LARGE_BARSIGN_FILE
	else
		icon = SKYRAT_BARSIGN_FILE

/datum/barsign/skyrat/topmen
	name = "顶尖人物"
	icon_state = "topmen"
	neon_color = "#C2AACA"

/datum/barsign/skyrat/spaceballgrille
	name = "太空球烧烤吧"
	icon_state = "spaceballgrille"
	neon_color = "#827973"

/datum/barsign/skyrat/clubee
	name = "蜜蜂俱乐部"
	icon_state = "clubee"
	neon_color = "#F2EEEE"

/datum/barsign/skyrat/thesun
	name = "太阳酒馆"
	icon_state = "thesun"
	neon_color = "#F8F0B8"

/datum/barsign/skyrat/limbo
	name = "灵薄狱酒馆"
	icon_state = "limbo"
	desc = "迷失灵魂的常去之地。这里的氛围灯光简直绝了！"
	neon_color = "#777777"

/datum/barsign/skyrat/meadbay
	name = "蜜酒湾"
	icon_state = "meadbay"
	neon_color = "#EBB823"

/datum/barsign/skyrat/cindikate
	name = "辛迪·凯特酒馆"
	icon_state = "cindikate"
	neon_color = "#FF3403"

/datum/barsign/skyrat/theclownshead
	name = "小丑之头"
	icon_state = "theclownshead"
	desc = "鸣笛小丑头“海迪”的家！"
	neon_color = "#FFD800"

/datum/barsign/skyrat/theorchard
	name = "果园酒馆"
	icon_state = "theorchard"
	neon_color = "#CFFF47"

/datum/barsign/skyrat/thesaucyclown
	name = "骚气小丑"
	icon_state = "thesaucyclown"
	desc = "一年一度小丑求偶仪式的知名聚集地。"
	neon_color = "#FF66CC"

/datum/barsign/skyrat/thedamnwall
	name = "该死的墙"
	icon_state = "thedamnwall"
	desc = "当你被逼到墙角时，最好有可靠的朋友和醇厚的烈酒陪在身边。"
	neon_color = "#CC3333"

/datum/barsign/skyrat/whiskeyimplant
	name = "威士忌植入体"
	icon_state = "whiskeyimplant"
	neon_color = "#E9F517"

/datum/barsign/skyrat/carpecarp
	name = "抓住鲤鱼"
	icon_state = "carpecarp"
	neon_color = "#C717FE"

/datum/barsign/skyrat/robustroadhouse
	name = "强劲公路酒馆"
	icon_state = "robustroadhouse"
	neon_color = "#F7A804"

/datum/barsign/skyrat/theredshirt
	name = "红衫酒馆"
	icon_state = "theredshirt"
	neon_color = "#FF92E0"

/datum/barsign/skyrat/maltesefalconmk2
	name = "马耳他之鹰 MK2"
	icon_state = "maltesefalconmk2"
	desc = "马耳他之鹰二号店，如今更加硬派。"
	neon_color = "#E30000"

/datum/barsign/skyrat/thecavernmk2
	name = "洞窟酒吧 MK2"
	icon_state = "thecavernmk2"
	desc = "听着好曲，品着好酒。"
	neon_color = "#AA9393"

/datum/barsign/skyrat/lv426
	name = "LV-426"
	icon_state = "lv426"
	desc = "戴着华丽面罩喝酒，显然比去医疗舱更重要。"
	neon_color = "#00F206"

/datum/barsign/skyrat/zocalo
	name = "索卡洛广场"
	icon_state = "zocalo"
	desc = "本店此前位于太空美国。"
	neon_color = "#E5AF1C"

/datum/barsign/skyrat/fourtheemprah
	name = "为了帝皇"
	icon_state = "4theemprah"
	desc = "狂热者、异教徒和脑损伤顾客都爱光顾。"
	neon_color = "#E5AF1C"

/datum/barsign/skyrat/ishimura
	name = "石村"
	icon_state = "ishimura"
	desc = "以优质褐星和美味饼干闻名。"
	neon_color = "#FF0000"

/datum/barsign/skyrat/tardis
	name = "塔迪斯"
	icon_state = "tardis"
	desc = "这家店至少已经历过 5,343 次迭代。"
	neon_color = "#2739AA"

/datum/barsign/skyrat/quarks
	name = "夸克酒吧"
	icon_state = "quarks"
	desc = "这家店的常客常常戴着介子扫描仪；真是古怪。"
	neon_color = "#10E500"

/datum/barsign/skyrat/tenforward
	name = "十前酒吧"
	icon_state = "tenforward"
	neon_color = "#E5AF1C"

/datum/barsign/skyrat/theprancingpony
	name = "跃马酒馆"
	icon_state = "theprancingpony"
	desc = "行吧，我们可不太喜欢你们这些矮个子在这儿晃来晃去找什么游侠渣滓。"
	neon_color = "#FF9100"

/datum/barsign/skyrat/vault13
	name = "13 号避难所"
	icon_state = "vault13"
	desc = "巧合是有意为之。"
	neon_color = "#FFA800"

/datum/barsign/skyrat/thehive
	name = "蜂巢酒吧"
	icon_state = "thehive"
	neon_color = "#FFC62A"

/datum/barsign/skyrat/cantina
	name = "查尔蒙酒馆"
	icon_state = "cantina"
	desc = "这家酒吧以原创为立店之本；他们的音乐全天候循环同一首。"
	neon_color = "#0078FF"

/datum/barsign/skyrat/milliways42
	name = "万路餐厅 42"
	icon_state = "milliways42"
	desc = "这里其实不是终点；它是你一切饮品需求的起点、意义与答案。"
	neon_color = "#FF00F6"

/datum/barsign/skyrat/timeofeve
	name = "夏娃时光"
	icon_state = "thetimeofeve"
	desc = "源自 2453 年的陈年饮品！"
	neon_color = "#EB52F8"

/datum/barsign/skyrat/spaceasshole
	name = "太空混蛋"
	icon_state = "spaceasshole"
	desc = "自 2125 年开业至今，几乎没什么变化：工程师照样放出奇点，而那些该死的矿工照样更可能把你的脸砸烂，而不是送来矿石。"
	neon_color = "#FF0000"

/datum/barsign/skyrat/birdcage
	name = "鸟笼"
	icon_state = "birdcage"
	desc = "呱。"
	neon_color = "#FFD21E"

/datum/barsign/skyrat/narsie
	name = "纳尔西小酒馆"
	icon_state = "narsiebistro"
	desc = "世界尽头之前的最后一家酒馆。"
	neon_color = "#FF0000"

/datum/barsign/skyrat/fallout
	name = "酒水地堡"
	icon_state = "boozebunker"
	desc = "躲进掩体时别忘了带上酒！"
	neon_color = "#FCC41B"

/datum/barsign/skyrat/brokendreams
	name = "碎梦咖啡馆"
	icon_state = "brokendreams"
	desc = "尝尝我们的新款狗肉小堡！"
	neon_color = "#E8E8A5"

/datum/barsign/skyrat/toolboxtavern
	name = "工具箱酒馆"
	icon_state = "toolboxtavern"
	desc = "每买一杯螺丝起子，免费住宿一晚！"
	neon_color = ""

/datum/barsign/skyrat/blueoyster
	name = "蓝牡蛎"
	icon_state = "blueoyster"
	desc = "专为十足异性恋男士开设的十足异性恋酒吧，进来看看就知道了。"
	neon_color = ""

/datum/barsign/skyrat/foreign
	name = "异国食物招牌"
	icon_state = "foreign"
	desc = "一块用某种死语言写成的招牌，宣传着某种说不上来的异国食物。"
	neon_color = ""

/datum/barsign/skyrat/commie
	name = "无产者之选"
	icon_state = "commie"
	desc = "你唯一需要的酒吧，同志！"
	neon_color = "#E46F6F"

/datum/barsign/skyrat/brokenheros
	name = "破碎英雄酒吧"
	icon_state = "brokenheros"
	desc = "你喜欢伤害别人吗？"
	neon_color = ""

/datum/barsign/skyrat/sociallubricator
	name = "社交润滑剂"
	icon_state = "sociallubricator"
	desc = "让你喜欢上自己讨厌的人的最佳之物。"
	neon_color = ""

/datum/barsign/skyrat/chemlab
	name = "化学实验室"
	icon_state = "chemlab"
	desc = "尝尝我们的新款等离子马提尼！"
	neon_color = ""

/datum/barsign/skyrat/mime
	name = "默剧私酿酒馆"
	icon_state = "mime"
	desc = "静默，但不搅动。"
	neon_color = ""

/datum/barsign/skyrat/clown
	name = "鸣笛小丑"
	icon_state = "clown"
	desc = "不含香蕉。"
	neon_color = ""

/datum/barsign/skyrat/progressive
	name = "现代进步酒馆"
	icon_state = "progressive"
	desc = "管它是什么意思。"
	neon_color = "#DB9B9A"

/datum/barsign/skyrat/va11halla
	name = "VA-11 HALL-A"
	icon_state = "va11halla"
	desc = "没有 N1-RV Ann-A 那么危险。"
	neon_color = "#FB3F7D"

/datum/barsign/skyrat/squatopia
	name = "蹲蹲乌托邦"
	icon_state = "squatopia"
	desc = "那块水晶属于我父亲。他被人谋杀了。"
	neon_color = "#CC0033"

/datum/barsign/skyrat/bug
	name = "饥饿甲虫"
	icon_state = "hungrybug"
	desc = "来坐坐，尝尝“洞”里远近闻名的饺子吧！"
	neon_color = "#E2B001"

/datum/barsign/skyrat/HeavensHallow
	name = "天堂圣堂"
	icon_state = "heavenshallow"
	desc = ""
	neon_color = "#000066"

/datum/barsign/skyrat/nukies
	name = "核爆仔酒吧"
	icon_state = "nukies"
	desc = "我的酒里最好别有叶子……"
	neon_color = ""

/datum/barsign/skyrat/duellingmoons
	name = "决斗之月"
	icon_state = "duelling-moons"
	desc = "它们只是缺了自己所属的天体。"
	neon_color = ""

/datum/barsign/skyrat/lowhanginfruit
	name = "低垂之果"
	icon_state = "the-low-hangin-fruit"
	desc = "植物学家只有一个笑话……"
	neon_color = "#37be49"

/datum/barsign/skyrat/peeps
	name = "叽叽"
	icon_state = "peeps"
	desc = "叫两声，像鸟那样！"
	neon_color = ""

/datum/barsign/skyrat/o2n2
	name = "02n2"
	icon_state = "02n2"
	desc = "那种用镀金杯子装啤酒的地方……价格还要贵上十倍。"
	neon_color = ""

/datum/barsign/skyrat/nyameowmrrp
	name = "喵喵咪呜"
	icon_state = "nya-meow-mrrp"
	desc = "要不要在糖里再加点酒？"
	neon_color = "#ff4cff"

/datum/barsign/skyrat/punpunspub
	name = "潘潘酒馆分店"
	icon_state = "pun-puns-pub"
	desc = "经历了他经历的那些事，换我也想全天候守在酒旁边。"
	neon_color = "#3874cf"

/datum/barsign/skyrat/stoutbottom
	name = "矮胖酒馆"
	icon_state = "the-stout-bottom"
	desc = "直击月亮！"
	neon_color = "#e98a32"

/datum/barsign/skyrat/nutcracker
	name = "胡桃夹子"
	icon_state = "the-nutcracker"
	desc = "取材自一部关于安保部最强悍军官的古老地球芭蕾舞剧。"
	neon_color = ""

/datum/barsign/skyrat/entertainmentTV
	name = "娱乐电视"
	icon_state = "entertainment-tv"
	desc = "星际有线电视的全部奇观，毫无选择余地。"
	neon_color = ""

// 96x96 signs

/datum/barsign/skyrat/large/cyberslyph
	name = "赛博符纹"
	icon_state = "cyberslyph"
	neon_color = "#00FFFF"
