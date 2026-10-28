#define EMAG_LOCKED_SHUTTLE_COST (CARGO_CRATE_VALUE * 50)

/datum/map_template/shuttle/emergency // SKYRAT EDIT OVERRIDE - OVERRIDDEN IN ADVANCED_SHUTTLES - shuttles.dm
	port_id = "emergency"
	name = "Base Shuttle Template (Emergency)"
	prefix = "_maps/shuttles/emergency/"
	///assoc list of shuttle events to add to this shuttle on spawn (typepath = weight)
	var/list/events
	///pick all events instead of random
	var/use_all_events = FALSE
	///how many do we pick
	var/event_amount = 1
	///do we empty the event list before adding our events
	var/events_override = FALSE

/datum/map_template/shuttle/emergency/New()
	. = ..()
	if(!occupancy_limit && who_can_purchase)
		CRASH("The [name] needs an occupancy limit!")
	if(HAS_TRAIT(SSstation, STATION_TRAIT_SHUTTLE_SALE) && credit_cost > 0 && prob(15))
		var/discount_amount = round(rand(25, 80), 5)
		name += " ([discount_amount]% Discount!)"
		var/discount_multiplier = 100 - discount_amount
		credit_cost = ((credit_cost * discount_multiplier) / 100)

///on post_load use our variables to change shuttle events
/datum/map_template/shuttle/emergency/post_load(obj/docking_port/mobile/mobile)
	. = ..()
	if(!events)
		return
	if(events_override)
		mobile.event_list.Cut()
	if(use_all_events)
		for(var/path in events)
			mobile.add_shuttle_event(path)
			events -= path
	else
		for(var/i in 1 to event_amount)
			var/path = pick_weight(events)
			events -= path
			mobile.add_shuttle_event(path)

/datum/map_template/shuttle/emergency/backup
	suffix = "backup"
	name = "Backup Shuttle"
	who_can_purchase = null

/datum/map_template/shuttle/emergency/construction
	suffix = "construction"
	name = "Build your own shuttle kit"
	description = "献给富有开拓精神的穿梭机工程师！购买后，船架即会对接，但起飞仍需像往常一样通过呼叫穿梭机获得授权。附带建筑材料。"
	admin_notes = "没有禁闭室，没有医疗设施。"
	credit_cost = CARGO_CRATE_VALUE * 5
	who_can_purchase = list(ACCESS_CAPTAIN, ACCESS_CE)
	occupancy_limit = "Flexible"

/datum/map_template/shuttle/emergency/constructionbig
	suffix = "constructionbig"
	name = "Build your own CRUISER kit"
	description = "这是建造套件的加大版，为你的穿梭机设计提供更多空间！购买后，船架即会对接，但起飞仍需像往常一样通过呼叫穿梭机获得授权。附带建筑材料。"
	admin_notes = "没有禁闭室，没有医疗设施。"
	credit_cost = CARGO_CRATE_VALUE * 30
	who_can_purchase = list(ACCESS_CAPTAIN, ACCESS_CE)
	occupancy_limit = "Flexible and more"

/datum/map_template/shuttle/emergency/asteroid
	suffix = "asteroid"
	name = "Asteroid Station Emergency Shuttle"
	description = "一艘可靠的中型穿梭机，最初用于往返运送纳米传讯小行星带设施的船员。"
	credit_cost = CARGO_CRATE_VALUE * 6
	occupancy_limit = "50"

/datum/map_template/shuttle/emergency/venture
	suffix = "venture"
	name = "Venture Emergency Shuttle"
	description = "一艘适合喜欢宽敞腿部空间的乘客的中型穿梭机。"
	credit_cost = CARGO_CRATE_VALUE * 10
	occupancy_limit = "45"

/datum/map_template/shuttle/emergency/humpback
	suffix = "humpback"
	name = "Humpback Emergency Shuttle"
	description = "一艘改作观光旅游用途的货运打捞船。配有酒吧，还附送两分钟的太空鲤鱼领地度假行程。"
	credit_cost = CARGO_CRATE_VALUE * 12
	occupancy_limit = "30"
	events = list(
		/datum/shuttle_event/simple_spawner/carp/friendly = 10,
		/datum/shuttle_event/simple_spawner/carp/friendly_but_no_personal_space = 2,
		/datum/shuttle_event/simple_spawner/carp = 2,
		/datum/shuttle_event/simple_spawner/carp/magic = 1,
	)

/datum/map_template/shuttle/emergency/bar
	suffix = "bar"
	name = "The Emergency Escape Bar"
	description = "配有自主意识的酒吧员工（一台酒吧无人机和一名女招待）、卫生间、供主管使用的高档休息室，以及一张大型聚会桌。"
	admin_notes = "酒吧无人机和女招待拥有 TRAIT_GODMODE（基本无敌），将在抵达前 60 秒被趣味气球自动赋予意识。\
	有医疗设施。"
	credit_cost = CARGO_CRATE_VALUE * 10
	occupancy_limit = "30"

/datum/map_template/shuttle/emergency/pod
	suffix = "pod"
	name = "Emergency Pods"
	description = "我们没想到这么快就要撤离。手头只有两个逃生舱。"
	admin_notes = "用于惩罚玩家。"
	who_can_purchase = null
	occupancy_limit = "10"

/datum/map_template/shuttle/emergency/russiafightpit
	suffix = "russiafightpit"
	name = "Mother Russia Bleeds"
	description = "这可是高品质穿梭机，达！座位多、空间大、设备齐！还有娱乐！比如海量酒水，以及供喝醉船员玩乐的搏斗场！如果还不够好玩，就按下放熊按钮。别担心，熊都训练过，不会冲出斗兽场，只要没人蠢到或醉到把门敞开，就绝对安全。别让阿西莫夫法则的小机器人扫了兴！"
	admin_notes = "带有少量各类武器，以及熊。只有舰长权限能放熊。熊不会自己打碎窗户，但有人放行时仍能逃出来。"
	credit_cost = CARGO_CRATE_VALUE * 10 // While the shuttle is rusted and poorly maintained, trained bears are costly.
	occupancy_limit = "40"

/datum/map_template/shuttle/emergency/meteor
	suffix = "meteor"
	name = "Asteroid With Engines Strapped To It"
	description = "一颗挖空后绑上引擎的小行星。挖空工艺使它极难被劫持，但价格昂贵。由于体积庞大且难以操纵，这艘穿梭机可能损坏对接区。"
	admin_notes = "这艘穿梭机很可能碾毁撤离区，杀死其中所有人。"
	credit_cost = CARGO_CRATE_VALUE * 30
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
	occupancy_limit = "CONDEMNED"

/datum/map_template/shuttle/emergency/monastery
	suffix = "monastery"
	name = "Grand Corporate Monastery"
	description = "这座宏伟的宗教建筑原本为公共空间站修建，因预算削减，如今只要提供适当的……捐款，就能用作逃生穿梭机。由于体积庞大且业主冷酷无情，它可能造成附带损害。"
	admin_notes = "警告：这艘穿梭机必定摧毁四分之一的空间站，并很可能裹挟大量物体。"
	emag_only = TRUE
	credit_cost = EMAG_LOCKED_SHUTTLE_COST * 1.8
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 5)
	occupancy_limit = "70"
	who_can_purchase = null //SKYRAT EDIT ADDITION

/datum/map_template/shuttle/emergency/luxury
	suffix = "luxury"
	name = "Luxury Shuttle"
	description = "一艘配有室内游泳池的豪华金色穿梭机。每名登船船员需携带 500 信用点，可用现金或矿物硬币支付。"
	extra_desc = "登上这艘穿梭机需支付 500 信用点。"
	admin_notes = "由于未付款船员的容身空间有限，这艘穿梭机可能引发骚乱。"
	emag_only = TRUE
	credit_cost = EMAG_LOCKED_SHUTTLE_COST
	occupancy_limit = "75"

/datum/map_template/shuttle/emergency/medisim
	suffix = "medisim"
	name = "Medieval Reality Simulation Dome"
	description = "将最先进的模拟穹顶装上你的穿梭机！看看人类在迈向群星前有多么渺小可笑。保证至少有 40% 符合史实。"
	prerequisites = "购买此穿梭机前，必须先加载一个特殊的全息甲板模拟。"
	admin_notes = "幽灵可以作为骑士或弓箭手加入战斗。夺旗游戏会自动重启，无需管理员干预。"
	credit_cost = 20000
	occupancy_limit = "30"

/datum/map_template/shuttle/emergency/medisim/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_MEDISIM]

/datum/map_template/shuttle/emergency/discoinferno
	suffix = "discoinferno"
	name = "Disco Inferno"
	description = "纳米传讯员工数百年等离子研究的辉煌成果。这就是你来此的原因。上船吧，像着了火一样热舞，燃烧吧宝贝！"
	admin_notes = "火热无比。主区域有跳舞机和等离子地砖，玩家每次都会把它们点燃。"
	emag_only = TRUE
	credit_cost = EMAG_LOCKED_SHUTTLE_COST
	occupancy_limit = "10"

/datum/map_template/shuttle/emergency/arena
	suffix = "arena"
	name = "The Arena"
	description = "船员必须穿过异界竞技场才能登上这艘穿梭机。预计伤亡惨重。"
	prerequisites = "必须追踪并消灭血腥信号的源头，才能解锁此穿梭机。"
	admin_notes = "撕碎一切。"
	credit_cost = CARGO_CRATE_VALUE * 20
	occupancy_limit = "1/2"
	/// Whether the arena z-level has been created
	var/arena_loaded = FALSE

/datum/map_template/shuttle/emergency/arena/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_BUBBLEGUM]

/datum/map_template/shuttle/emergency/arena/post_load(obj/docking_port/mobile/M)
	. = ..()
	if(!arena_loaded)
		arena_loaded = TRUE
		var/datum/map_template/arena/arena_template = new()
		arena_template.load_new_z()

/datum/map_template/arena
	name = "The Arena"
	mappath = "_maps/templates/the_arena.dmm"

/datum/map_template/shuttle/emergency/birdboat
	suffix = "birdboat"
	name = "Birdboat Station Emergency Shuttle"
	description = "这艘穿梭机虽有些小，但功能齐全，比起它原本服务的那种空间站强多了。"
	credit_cost = CARGO_CRATE_VALUE * 2
	occupancy_limit = "25"

/datum/map_template/shuttle/emergency/box
	suffix = "box"
	name = "Box Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 4
	description = "紧急撤离的黄金标准。这一久经考验的设计配齐了船员安全返航所需的一切。"
	occupancy_limit = "45"

/datum/map_template/shuttle/emergency/donut
	suffix = "donut"
	name = "Donutstation Emergency Shuttle"
	description = "这艘穿梭机非常适合拿空间站的形状开粗俗玩笑，配有独立囚犯拘留室和紧凑的医疗区。"
	admin_notes = "两侧均有气闸；某些在离站区外延伸建造的空间站，可能在船首附近发生重叠。"
	credit_cost = CARGO_CRATE_VALUE * 5
	occupancy_limit = "60"

/datum/map_template/shuttle/emergency/clown
	suffix = "clown"
	name = "Snappop(tm)!"
	description = "各位小朋友和大朋友！\
	你是不是受够了因为无聊的理由撤离之后，那枯燥乏味的穿梭机旅途？那就马上订购啪嗒响(tm)！\
	我们有适合所有人的趣味活动、人人都能进入的驾驶舱，而且没有无聊的安保禁闭室！嘘！和朋友一起玩换装吧！\
	抢在邻居之前收集所有床单！用我们正在申请专利的“偷窥狂 AI 多功能工具探测器”，简称 PEEEEEETUR，检查 AI 是否在监视你。\
	祝你旅途愉快！"
	admin_notes = "禁闭室被一本固定的绿字胜利书取代，周围是熔岩地带的深渊；靠站一侧的门已移除，以防意外跌落。没有禁闭室。"
	credit_cost = CARGO_CRATE_VALUE * 16
	occupancy_limit = "HONK"

/datum/map_template/shuttle/emergency/cramped
	suffix = "cramped"
	name = "Secure Transport Vessel 5 (STV5)"
	description = "看来中央指挥部在附近只有这艘船，他们大概没想到你们这么快就需要撤离。\
	最好别乱翻他们原本运送的设备。希望你和同事们相处融洽，因为这东西里的空间小得可怜。\n\
	\n\
	内含违禁军械枪支、维护区杂物和废弃货箱！"
	admin_notes = "原为单人驾驶的安全运输船，因此船上有一台标记为 STV5 的运行中 GPS。空间与嗨丹尼尔号大致相当，但带有爆炸货箱。"
	occupancy_limit = "5"

/datum/map_template/shuttle/emergency/meta
	suffix = "meta"
	name = "Meta Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 8
	description = "一艘相当标准的穿梭机，但比 Box 站版本更大，设备也稍好一些。"
	occupancy_limit = "45"

/datum/map_template/shuttle/emergency/kilo
	suffix = "kilo"
	name = "Kilo Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 10
	description = "一艘功能齐全的穿梭机，配有完整医务室、储存设施和常规生活设施。"
	occupancy_limit = "55"

/datum/map_template/shuttle/emergency/mini
	suffix = "mini"
	name = "Ministation emergency shuttle"
	credit_cost = CARGO_CRATE_VALUE * 2
	description = "虽然名字叫迷你，这艘穿梭机其实只比标准型号略小，仍配有完整的禁闭室和医疗区。"
	occupancy_limit = "35"

/datum/map_template/shuttle/emergency/tram
	suffix = "tram"
	name = "Tram Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 4
	description = "太空里的火车，呜呜！"
	occupancy_limit = "35"

/datum/map_template/shuttle/emergency/birdshot
	suffix = "birdshot"
	name = "Birdshot Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 2
	description = "我们特地为你把这艘封存的老船翻了出来！"
	occupancy_limit = "40"


/datum/map_template/shuttle/emergency/emergency_catwalk
	suffix = "catwalk"
	name = "Catwalk Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 5
	description = "一艘标准尺寸的穿梭机，配有医疗区、禁闭室以及抬高的舰桥。"
	occupancy_limit = "40"

/datum/map_template/shuttle/emergency/wawa
	suffix = "wawa"
	name = "Wawa Stand-in Emergency Shuttle"
	description = "由于财务部门近期的文书失误，大量资金被用于购买蜥蜴毛绒玩具。出于成本考虑，纳米传讯调来了附近的一辆垃圾车代用。最好学会与别人挤一挤。"
	credit_cost = CARGO_CRATE_VALUE * 6
	occupancy_limit = "25"

/datum/map_template/shuttle/emergency/scrapheap
	suffix = "scrapheap"
	name = "Standby Evacuation Vessel \"Scrapheap Challenge\""
	credit_cost = CARGO_CRATE_VALUE * -18
	description = "同志！看来你缺钱，对吧？如果你有资金问题，钱很少，我们正在找好穿梭机，紧急穿梭机。你拿走星区里最好的船，我们拿走你的，你还能拿钱，达？请勿倚靠窗户，像精瓷一样脆。——伊万"
	admin_notes = "随机拼装的模块化怪胎。可能没有可用医疗区、缺少舱段，还有极脆的窗户。却出奇地气密。购买时会获得一大笔钱，但只有预算恰好为 0 信用点时才能买。"
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
	occupancy_limit = "30"
	prerequisites = "只有空间站资金不足时，才会出售此穿梭机。"

/datum/map_template/shuttle/emergency/scrapheap/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_SCRAPHEAP]

/obj/modular_map_root/scrapheapchallenge
	config_file = "strings/modular_maps/emergency_scrapheap.toml"

/datum/map_template/shuttle/emergency/narnar
	suffix = "narnar"
	name = "Shuttle 667"
	description = "看来这艘穿梭机在前往空间站途中，可能误入了群星之间的黑暗。还是别深究这些尸体从哪来吧。"
	admin_notes = "带有真正的血教遗迹、眼球生物和未激活的构装体。趣味气球会自动赋予血教生物意识。\
	“医疗区”的克隆舱只是陈列品，无法使用。"
	prerequisites = "必须先驱逐一个神秘的血教符文，才能召唤此穿梭机。"
	credit_cost = 6667 ///The joke is the number so no defines
	occupancy_limit = "666"

/datum/map_template/shuttle/emergency/narnar/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_NARNAR]

/datum/map_template/shuttle/emergency/pubby
	suffix = "pubby"
	name = "Pubby Station Emergency Shuttle"
	description = "太空里的火车！一等舱、二等舱、禁闭室和储存区一应俱全。"
	admin_notes = "呜呜，混蛋！"
	credit_cost = CARGO_CRATE_VALUE * 2
	occupancy_limit = "50"

/datum/map_template/shuttle/emergency/cere
	suffix = "cere"
	name = "Cere Station Emergency Shuttle"
	description = "Box 标准穿梭机的大型加强版。配有扩大的禁闭室、物资齐全的医疗区、带机甲充电器的增强货仓、\
	备有各类物资的引擎室，甚至能容纳八十多名船员。大气生活，尽在 Cere。"
	admin_notes = "真的很大，比 Delta 穿梭机还大。"
	credit_cost = CARGO_CRATE_VALUE * 20
	occupancy_limit = "110"

/datum/map_template/shuttle/emergency/supermatter
	suffix = "supermatter"
	name = "Hyperfractal Gigashuttle"
	description = "“我不太懂，但这看起来复杂得毫无必要。”\n\
	“据中央指挥部军官学员因斯说，这艘穿梭机的安全记录极其优秀。”\n\
	“你确定？”\n\
	“确定，它的安全记录是 N-A-N，显然比 100% 还高。”"
	admin_notes = "船上生成的超物质是固定的特殊“安全版”超物质，不会受损，也不会吸入或释放气体。\
	除非管理员干预，否则不会爆炸。\
	但接触它仍会化为灰烬，它也会释放大量辐射，让未戴防护镜直视它的人产生幻觉。\
	发射器初始已通电，预计会触发管理员提示，但它们无害。"
	emag_only = TRUE
	credit_cost = EMAG_LOCKED_SHUTTLE_COST
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
	occupancy_limit = "15"

/datum/map_template/shuttle/emergency/imfedupwiththisworld
	suffix = "imfedupwiththisworld"
	name = "Oh, Hi Daniel"
	description = "今天的太空工作怎么样？哦，挺好。我们有了新空间站，公司会赚很多钱。什么空间站？不能告诉你，这是太空机密。\
	哎，太空别这样。为什么不能？不行，就是不能。话说回来，你的太空角色扮演生活怎么样？"
	admin_notes = "非常小，只有一道气闸和木墙。能出什么事呢？"
	emag_only = TRUE
	credit_cost = EMAG_LOCKED_SHUTTLE_COST
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
	occupancy_limit = "5"

/datum/map_template/shuttle/emergency/goon
	suffix = "goon"
	name = "NES Port"
	description = "纳米传讯紧急穿梭机港（简称 NES Port）用于其他不太知名的纳米传讯设施，内部更加开阔，可容纳更多人，但船载设施较少。"
	credit_cost = CARGO_CRATE_VALUE
	occupancy_limit = "40"

/datum/map_template/shuttle/emergency/rollerdome
	suffix = "rollerdome"
	name = "Uncle Pete's Rollerdome"
	description = "由一位自称从 2028 年穿越而来的纳米传讯研发人员开发。\
	他说这艘穿梭机以二十世纪九十年代的一座老娱乐场为原型，不过我们的数据库里没有那个年代的任何记录。"
	admin_notes = "只有九十年代的孩子才记得。使用紧急逃生酒吧的趣味气球和无人机。"
	credit_cost = CARGO_CRATE_VALUE * 30
	occupancy_limit = "5"

/datum/map_template/shuttle/emergency/basketball
	suffix = "bballhooper"
	name = "Basketballer's Stadium"
	description = "投篮，伙计，投篮！在这座时髦的新篮球馆里大显身手吧！但请记住，为了以实惠价格提供这座球馆，\
	其他穿梭机上常见的某些设施并未配备。\
	它的设计也没考虑某些空间站的外形……祝你好运。"
	admin_notes = "围绕篮球馆建造的大型穿梭机：完全不实用，但乐趣十足！"
	credit_cost = CARGO_CRATE_VALUE * 10
	occupancy_limit = "30"

/datum/map_template/shuttle/emergency/wabbajack
	suffix = "wabbajack"
	name = "NT Lepton Violet"
	description = "驻扎在这艘船上的研究小组某天失踪了，无论如何调查，都没能查明他们的遭遇。\
	船上只剩一些啮齿动物尸体，似乎是互相撕抓而死。\
	不用说，没有工程队愿意靠近它。之所以把它用作紧急逃生穿梭机，只是因为实在没有别的可用。"
	admin_notes = "如果船员解开谜题，就会唤醒瓦巴杰克雕像。多半不会有好下场。它被封起来是有原因的，或许不去碰它才对。"
	credit_cost = CARGO_CRATE_VALUE * 30
	occupancy_limit = "30"
	prerequisites = "必须先发生一次魔法变形，才能购买此穿梭机。"

/datum/map_template/shuttle/emergency/wabbajack/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_WABBAJACK]

/datum/map_template/shuttle/emergency/omega
	suffix = "omega"
	name = "Omegastation Emergency Shuttle"
	description = "这艘采用现代设计的小型穿梭机，适合喜欢温馨环境又希望能伸展双腿的船员。"
	credit_cost = CARGO_CRATE_VALUE * 2
	occupancy_limit = "30"

/datum/map_template/shuttle/emergency/cruise
	suffix = "cruise"
	name = "The NTSS Independence"
	description = "独立号游轮穿梭机通常只用于特殊典礼和活动，如今只收取一笔“适中”的费用，就能为你的下次空间站撤离带来夏日欢乐！"
	admin_notes = "这玩意儿他妈的大得离谱。可能需要强制对接。"
	credit_cost = CARGO_CRATE_VALUE * 100
	occupancy_limit = "80"

/datum/map_template/shuttle/emergency/monkey
	suffix = "nature"
	name = "Dynamic Environmental Interaction Shuttle"
	description = "一艘中央配有生机勃勃生态穹顶的大型穿梭机。和猴子们一起玩耍吧！（舰桥还存放着额外的猴子。）"
	admin_notes = "相当大，几乎和渡鸦号或 Cere 一样大。使用时小心。"
	credit_cost = CARGO_CRATE_VALUE * 16
	occupancy_limit = "45"

/datum/map_template/shuttle/emergency/casino
	suffix = "casino"
	name = "Lucky Jackpot Casino Shuttle"
	description = "一座豪华赌场，装满了让你染上新赌瘾所需的一切！"
	admin_notes = "船体有些臃肿，注意停靠位置。"
	credit_cost = 7777
	occupancy_limit = "85"

/datum/map_template/shuttle/emergency/shadow
	suffix = "shadow"
	name = "The NTSS Shadow"
	description = "保证飞快地把你送到某处。凭借定制等离子引擎，这家伙比任何船都更能让你远离迫在眉睫的危险！"
	admin_notes = "船尾有一个初始已点燃的等离子储罐，可能被船员释放。引擎加热器旁的等离子窗也会燃烧，同样有被船员放出的风险。"
	credit_cost = CARGO_CRATE_VALUE * 50
	occupancy_limit = "40"

/datum/map_template/shuttle/emergency/fish
	suffix = "fish"
	name = "Angler's Choice Emergency Shuttle"
	description = "牺牲“储物空间”和“充足座位”等设施，换取理想的人工垂钓环境和充足物资（也是用来钓鱼的）。"
	admin_notes = "里面有一道深渊，虽然有护栏，但拦不住铁了心的玩家。"
	credit_cost = CARGO_CRATE_VALUE * 10
	occupancy_limit = "35"

/datum/map_template/shuttle/emergency/lance
	suffix = "lance"
	name = "The Lance Crew Evacuation System"
	description = "由纳米传讯最优秀的穿梭机工程师设计的全新船型，专为战术性撞入受损空间站而造，同时消灭威胁并救出船员！注意避开它的行进路线。"
	admin_notes = "警告：这艘穿梭机就是用来撞进空间站的。和渡鸦号一样配有炮塔。"
	credit_cost = CARGO_CRATE_VALUE * 70
	occupancy_limit = "50"

/datum/map_template/shuttle/emergency/tranquility
	suffix = "tranquility"
	name = "The Tranquility Relocation Shuttle"
	description = "一艘遍布植物与舒适休息区的大型穿梭机。为平静的轮班画上完美句号。"
	admin_notes = "相当大，也很舒适。放置时请小心！"
	credit_cost = CARGO_CRATE_VALUE * 25
	occupancy_limit = "40"

/datum/map_template/shuttle/emergency/hugcage
	suffix = "hugcage"
	name = "Hug Relaxation Shuttle"
	description = "一艘温馨的小型穿梭机，为疲倦或敏感的太空人准备了许多床铺，还备有一盒枕头大战用品。"
	admin_notes = "有一个可赋予宠物意识的趣味气球。"
	credit_cost = CARGO_CRATE_VALUE * 16
	occupancy_limit = "20"

/datum/map_template/shuttle/emergency/fame
	suffix = "fame"
	name = "Hall of Fame Shuttle"
	description = "一艘华丽的穿梭机，红毯直通名人堂。你有资格与最优秀的太空人并肩而立吗？"
	admin_notes = "围绕记忆、奖杯、照片和雕像的跨局保存而设计。"
	credit_cost = CARGO_CRATE_VALUE * 25
	occupancy_limit = "55"

/datum/map_template/shuttle/emergency/delta
	suffix = "delta"
	name = "Delta Station Emergency Shuttle"
	description = "大空间站就配大穿梭机，轻松应对人口过多和拥挤需求。设施齐全，还带有额外装备。"
	admin_notes = "要么做大，要么回家。"
	credit_cost = CARGO_CRATE_VALUE * 15
	occupancy_limit = "75"

/datum/map_template/shuttle/emergency/northstar
	suffix = "northstar"
	name = "North Star Emergency Shuttle"
	description = "一艘坚固的穿梭机，用于边疆尽头与中央指挥部之间的长途往返运输。\
	大小和舒适度尚可，但很拥挤。"
	credit_cost = CARGO_CRATE_VALUE * 14
	occupancy_limit = "55"

/datum/map_template/shuttle/emergency/nebula
	suffix = "nebula"
	name = "Nebula Station Emergency Shuttle"
	description = "一艘适合运送大量乘客的出色豪华穿梭机。\
	配有丰富的灌木和免费氧气。"
	credit_cost = CARGO_CRATE_VALUE * 18
	occupancy_limit = "80"

/datum/map_template/shuttle/emergency/raven
	suffix = "raven"
	name = "CentCom Raven Cruiser"
	description = "中央指挥部渡鸦号巡洋舰原是一艘执行高风险任务的打捞船，如今改作紧急逃生穿梭机。\
	它曾总是率先进入战区搜寻有价值的残骸，现在则是遭受外敌猛烈炮击的空间站的绝佳撤离选择。\
	这艘逃生穿梭机配有护盾，以及守卫四周的大量反步兵炮塔，用以抵挡陨石和敌人登船。"
	admin_notes = "配备的炮塔会攻击所有不属于中立阵营的目标（核爆特工、异形等，但不包括宠物）。"
	credit_cost = CARGO_CRATE_VALUE * 60
	occupancy_limit = "CLASSIFIED"

/datum/map_template/shuttle/emergency/zeta
	suffix = "zeta"
	name = "Tr%nPo2r& Z3TA"
	description = "显示器上出现了一处故障，在眼前的选项中时隐时现。\
	它显得陌生而异样……"
	prerequisites = "你需要研究特殊外星科技，才能接入该信号。"
	admin_notes = "配有外星手术工具，以及提供无限能源的虚空核心。"
	credit_cost = CARGO_CRATE_VALUE * 16
	occupancy_limit = "xxx"

/datum/map_template/shuttle/emergency/zeta/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_ALIENTECH]

/datum/map_template/shuttle/emergency/tombstone
	suffix = "tombstone"
	name = "The NTSS Tombstone"
	description = "专为生物危害、僵尸爆发或食肉瘟疫的清理工作订造。配有墓地、加固停尸托盘和火葬炉。安全、气密，保证你在运输途中咬不到同事！"
	admin_notes = "船尾馆长室后有一个瘴气储罐，可能被船员释放。墓穴内还有随机生成器，有机会生成一次性的幽灵乐器。"
	credit_cost = CARGO_CRATE_VALUE * 15
	occupancy_limit = "40"
	prerequisites = "必须先发生生物危害事件，才能购买此穿梭机。"

/datum/map_template/shuttle/emergency/tombstone/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_TOMBSTONE]

/datum/map_template/shuttle/emergency/ark
	suffix = "ark"
	name = "The Ark"
	description = "一艘专用的移动动物园和科研运输船。主要乘客休息室紧邻收容舱，其中关着各类友善、奇异和敌对的外星生物样本。"
	prerequisites = "你需要收集空间站 DNA 宝库目标所需的全部样本。"
	admin_notes = "装载了各种动物，包括围栏中的敌对和温顺珍奇生物。"
	credit_cost = CARGO_CRATE_VALUE * 25
	occupancy_limit = "70"

/datum/map_template/shuttle/emergency/ark/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_ARK]

/datum/map_template/shuttle/emergency/departmental
	who_can_purchase = null
	admin_notes = "其他部门专属穿梭机的父级模板。"
	///requires a job_department datum to present it to communications console.
	var/department_type = null
	///requires a name of department to send it to ui.
	var/department_name = ""
	occupancy_limit = "null"

/datum/map_template/shuttle/emergency/departmental/command
	suffix = "dep_cap"
	name = "Command Emergency Shuttle"
	description = "这本来可以成为某位寡头的私人穿梭机，但工会不让我们达成交易，\
	所以现在把它作为精英专用穿梭机投入运营。"
	admin_notes = "舰桥区配有卷帘门和一把斧头。"
	credit_cost = CARGO_CRATE_VALUE * 17.5
	who_can_purchase = list(ACCESS_CAPTAIN)
	department_type = /datum/job_department/command
	department_name = DEPARTMENT_COMMAND
	occupancy_limit = "40 人，另有 7 人可参加宴会。"

/datum/map_template/shuttle/emergency/departmental/civil
	suffix = "dep_civ"
	name = "Assistants Emergency Shuttle"
	description = "为满足助理们的愿望而设计的穿梭机，内部改装成了维修区。"
	admin_notes = "维修区风格穿梭机。"
	credit_cost = CARGO_CRATE_VALUE * 5.5
	who_can_purchase = list(ACCESS_CAPTAIN)
	department_type = /datum/job_department/assistant
	department_name = DEPARTMENT_ASSISTANT
	occupancy_limit = "足够容纳一群助理。"

/datum/map_template/shuttle/emergency/departmental/engineering
	suffix = "dep_eng"
	name = "Engineering Emergency Shuttle"
	description = "工程师们说，按照物理定律，穿梭机没有能源就飞不起来，\
	所以我们装上了超物质碎片，并设置了带涡轮和混气室的大气处理区。"
	admin_notes = "配有未启动的超物质碎片、斧头、绝缘手套和免费工程售货机；工程师为船供电后，格栅也会通电。"
	credit_cost = CARGO_CRATE_VALUE * 15.5
	who_can_purchase = list(ACCESS_CAPTAIN)
	department_type = /datum/job_department/engineering
	department_name = DEPARTMENT_ENGINEERING
	occupancy_limit = "20"

/datum/map_template/shuttle/emergency/departmental/medical
	suffix = "dep_med"
	name = "Medical Emergency Shuttle"
	description = "有人认为一边开穿梭机一边治病救人很方便，\
	于是为了讨心脏外科医生们欢心，推出了配备治疗中心、病毒学实验室和化学实验室的医疗穿梭机。"
	admin_notes = "配有可用的药房和病毒学实验室。"
	credit_cost = CARGO_CRATE_VALUE * 12
	who_can_purchase = list(ACCESS_CAPTAIN)
	department_type = /datum/job_department/medical
	department_name = DEPARTMENT_MEDICAL
	occupancy_limit = "30 名活人和 1 具遗体。"

/datum/map_template/shuttle/emergency/departmental/science
	suffix = "dep_sci"
	name = "Science Emergency Shuttle"
	description = "我们受够了科学家们，所以专门给他们造了一艘穿梭机。\
	还搬来了一块真正的小行星，用于建造军械实验室和异种生物学扩建区。"
	admin_notes = "配有可用的研发设施。"
	credit_cost = CARGO_CRATE_VALUE * 10
	who_can_purchase = list(ACCESS_CAPTAIN)
	department_type = /datum/job_department/science
	department_name = DEPARTMENT_SCIENCE
	occupancy_limit = "50"

/datum/map_template/shuttle/emergency/departmental/security
	suffix = "dep_sec"
	name = "Security Emergency Shuttle"
	description = "为纪念一位救下中央指挥部代表性命的安保官而建造。\
	他是个非常好的人，直到牺牲在叛徒手中。"
	admin_notes = "配有 2 间牢房、1 间临时拘留室，以及取代乘坐区的永久监狱。"
	credit_cost = CARGO_CRATE_VALUE * 16
	who_can_purchase = list(ACCESS_CAPTAIN)
	department_type = /datum/job_department/security
	department_name = DEPARTMENT_SECURITY
	occupancy_limit = "40 名囚犯和 10 名自由船员。"

/datum/map_template/shuttle/emergency/departmental/service
	suffix = "dep_srv"
	name = "Service Emergency Shuttle"
	description = "这艘穿梭机专为流连酒吧而造，没有工具库或医疗区。"
	admin_notes = "空间宽敞，但缺少许多穿梭机的重要设施。"
	credit_cost = CARGO_CRATE_VALUE * 8
	who_can_purchase = list(ACCESS_CAPTAIN)
	department_type = /datum/job_department/service
	department_name = DEPARTMENT_SERVICE
	occupancy_limit = "30"

/datum/map_template/shuttle/emergency/departmental/cargo
	suffix = "dep_sup"
	name = "Cargo Emergency Shuttle"
	description = "应货运分离主义者的要求而建造。\
	别担心，所有分离主义者都已入狱。设计实在太出色，所以我们决定公开销售。"
	admin_notes = "配有未装弹的火箭筒和快速补给控制台。"
	credit_cost = CARGO_CRATE_VALUE * 9.5
	who_can_purchase = list(ACCESS_CAPTAIN)
	department_type = /datum/job_department/cargo
	department_name = DEPARTMENT_CARGO
	occupancy_limit = "40"

#undef EMAG_LOCKED_SHUTTLE_COST
