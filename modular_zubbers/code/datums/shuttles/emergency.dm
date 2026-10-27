/datum/map_template/shuttle/emergency/meteor
	prefix = "_maps/shuttles/zubbers/"
	suffix = "cube"
	name = "立方体"
	description = "一块巨大的16×16实心金属，上面绑着一堆引擎。它飞得稀烂，恐怕会一头撞进离站区。但为了立方体，这一切都值得。"
	admin_notes = "这艘穿梭机会压毁逃生区，杀死其中所有人。进入它也十分困难，需要打穿好几道金属墙。"
	credit_cost = CARGO_CRATE_VALUE * 30
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
	occupancy_limit = "4^3"
	emag_only = TRUE

/datum/map_template/shuttle/emergency/burgerstation
	prefix = "_maps/shuttles/zubbers/"
	suffix = "moonstation"
	name = "月球站紧急穿梭机"
	description = "一艘与其服务的空间站同样畸形的穿梭机。“千年肉饼”号紧急穿梭机可能会让你觉得越少越好。配有不错的医疗舱和豪华区。"
	admin_notes = "配有付费头等舱，以及专属机上娱乐和餐饮人员！酒吧无人机、女侍和小丑均处于无敌模式，会在抵达前60秒由趣味气球自动赋予意识。"
	credit_cost = CARGO_CRATE_VALUE * 25
	occupancy_limit = "50"

/datum/map_template/shuttle/emergency/imfedupwiththisworld
	prefix = "_maps/shuttles/zubbers/"
	suffix = "imfedupwiththisworld"
	name = "你的性生活怎么样？"
	description = "你可以从心底深爱一个人，这没有任何错。如果许多人彼此相爱，这个世界就会更加美好。"
	admin_notes = "狭窄的木制穿梭机，只有一扇木质气闸，极易破损失压。能出什么事呢？"
	occupancy_limit = "5"
	emag_only = TRUE
	credit_cost = 4988
	movement_force = list("KNOCKDOWN" = 0, "THROW" = 0)

/datum/map_template/shuttle/emergency/lance/New()
	. = ..()
	if(SSmapping.current_map.map_name == "Moon Station")
		who_can_purchase = null

/datum/map_template/shuttle/emergency/vortex
	prefix = "_maps/shuttles/zubbers/"
	suffix = "vortex"
	name = "涡旋级豪华撤离穿梭机"
	description = "一艘略显奢华、满足全体船员需求的撤离穿梭机：免费咖啡、免费香烟，各部门舱室内的高级工具和药品，以及部门原型车床一应俱全。指挥部还有独立舱外作业仓库，为每位主管备有专用 MOD 装备。更不用说大气系统、通电栅栏，以及可随时启动红色警戒的两台认证装置！优雅地飞回家吧。"
	admin_notes = "配有原型车床及大幅升级的工具和装备，是一艘没有缺点的豪华撤离穿梭机。拥有两台认证装置、主管备用 MOD 装备、纳米传讯顾问的企业款和蓝盾的资产保护款 MOD 装备、大气系统及通电栅栏。无论从烈焰中的空间站逃生，还是平静下班，所有人都能找到所需物资。"
	credit_cost = CARGO_CRATE_VALUE * 625
	occupancy_limit = "65"

/datum/map_template/shuttle/emergency/gorilla2
	prefix = "_maps/shuttles/zubbers/"
	suffix = "gorilla2"
	name = "大猩猩货运穿梭机二型"
	description = "由于可能存在，也可能不存在的“广泛”需求，加上一笔小费用，这艘货船重新投入使用，成为你的逃生穿梭机。这艘破旧到勉强能用的飞船运送着重要货物。不适合即将发狂的船员。注意：请勿挑衅货物。"
	admin_notes = "一艘锈迹斑斑的破烂穿梭机。货舱会生成随机维护区战利品。大猩猩属于 hostile 阵营，被关在货舱后半部，但如果长时间看见船员，就会打破等离子玻璃窗。"
	credit_cost = CARGO_CRATE_VALUE * 5
	occupancy_limit = "25 + 15"
	emag_only = TRUE

/datum/map_template/shuttle/emergency/foxferry
	prefix = "_maps/shuttles/zubbers/"
	suffix = "foxferry"
	name = "巨狐级撤离渡船"
	description = "这是小巧狐级渡舱的超大版本。一艘舒适且未武装的辛迪加运输船，拥有充足座位、一些辛迪加物资、品牌商品及标志。引擎室内有小型大气系统，栅栏带电。购买本穿梭机后发生的任何伤害或事故，辛迪加概不负责。"
	admin_notes = "尺寸适中、外形圆润且略贵的穿梭机。公共区有少量叛徒物品和辛迪加品牌物品，柜子与箱子里锁着一些违禁品。小心能量斧。"
	credit_cost = CARGO_CRATE_VALUE * 250
	occupancy_limit = "50"
	emag_only = TRUE

/datum/map_template/shuttle/emergency/pod_cluster
	prefix = "_maps/shuttles/zubbers/"
	suffix = "pod_cluster"
	name = "逃生舱集群"
	description = "我们没能给你弄到正规穿梭机，只好拿来一堆大家似乎很喜欢的逃生舱，用格栅绑在一起。不太好看，但至少便宜。"
	admin_notes = "舱与舱之间没有空气。指挥舱稍长，以容纳控制台。这个有趣点子来自一位朋友。"
	credit_cost = CARGO_CRATE_VALUE * 1.5
	occupancy_limit = "36"
	emag_only = TRUE

/datum/map_template/shuttle/emergency/stockade
	prefix = "_maps/shuttles/zubbers/"
	suffix = "stockade"
	name = "破阵者级堡垒穿梭机"
	description = "这艘老式纳米传讯破阵者级堡垒穿梭机，用极致的厚重与耐久弥补了护盾和先进技术的缺失。强化船壳、激光防御炮塔和小行星犁一应俱全，几乎没有什么能攻破这头钢铁巨兽。"
	admin_notes = "巨大厚重，所有门都是安全门。装有渡鸦穿梭机同款炮塔，除此以外没有太多特别之处。"
	credit_cost = CARGO_CRATE_VALUE * 100
	occupancy_limit = "80"

/datum/map_template/shuttle/emergency/imfedupbutgold
	prefix = "_maps/shuttles/zubbers/"
	suffix = "imfedupbutgold"
	name = "你的性生活怎么样（涡轮黄金高级支持者版）"
	description = "你可以从心底深爱一个人，这没有任何错。如果许多人彼此相爱，这个世界就会更加美好。现在含有更多黄金。"
	admin_notes = "买下它会让所有人恨你。"
	occupancy_limit = "5"
	emag_only = TRUE
	credit_cost = CARGO_CRATE_VALUE * 1250
	movement_force = list("KNOCKDOWN" = 0, "THROW" = 0)

/datum/map_template/shuttle/emergency/vigilante
	prefix = "_maps/shuttles/zubbers/"
	suffix = "vigilante"
	name = "辛迪加远程支援舰“义警”号"
	description = "一艘直接来自辛迪加的远程运输船。“义警”号远程支援舰载客量大，支援部门物资充足，船员设施完善。它或许不像其他穿梭机那样奢华，却结实耐用，能保障你的旅途安全。注意：请勿与舰长挑起冲突，我们挂牌出售时他拒绝离船。"
	admin_notes = "昂贵的辛迪加飞船。违禁品没有想象中那么多，但有几套辛迪加 MOD 装备和软式太空服。配有意识趣味气球，可让船上的几个生物获得意识。还有装填豆袋弹的斗牛犬霰弹枪。"
	occupancy_limit = "90"
	emag_only = TRUE
	credit_cost = CARGO_CRATE_VALUE * 1000

/datum/map_template/shuttle/emergency/millionaire
	prefix = "_maps/shuttles/zubbers/"
	suffix = "millionaire"
	name = "百万富翁穿梭机"
	description = "一艘贵得离谱、几乎完全由黄金、白银和钻石打造的穿梭机。若买得起它，你的空间站将永远载入“百万名录”。注意：该名录不一定存在。另注：它也可能撞上空间站。"
	admin_notes = "攒到一百万干得不错。享受这艘蠢穿梭机吧。"
	occupancy_limit = "55"
	credit_cost = 1000000
