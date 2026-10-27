/obj/structure/shipping_container
	name = "货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个表面空白，看不出里面装了什么。"
	icon = 'icons/obj/fluff/containers.dmi'
	icon_state = "blank"
	max_integrity = 1000
	bound_width = 96
	bound_height = 32
	density = TRUE
	anchored = TRUE
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE

/obj/structure/shipping_container/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_SHIPPING_CONTAINER)

/obj/structure/shipping_container/amsco
	name = "\improper AMSCO 货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自阿蒙森-斯科特，所以里面装的可能是勘探装备。"
	icon_state = "amsco"

/obj/structure/shipping_container/blue
	icon_state = "blue"

/obj/structure/shipping_container/conarex
	name = "\improper 科纳雷克斯航空货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自科纳雷克斯航空，因此里面装的可能是航天器零件（或一桩贿赂丑闻）。"
	icon_state = "conarex"

/obj/structure/shipping_container/defaced
	name = "被涂鸦的货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个被涂满了颇有品味的涂鸦。"
	icon_state = "defaced"

/obj/structure/shipping_container/deforest
	name = "\improper 纳米传讯—德福雷斯特货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自纳米传讯—德福雷斯特，所以里面装的可能是医疗用品。"
	icon_state = "deforest"

/obj/structure/shipping_container/great_northern
	name = "\improper 大北方货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自大北方，所以里面装的可能是农业设备。"
	icon_state = "great_northern"

/obj/structure/shipping_container/green
	icon_state = "green"

/obj/structure/shipping_container/kahraman
	name = "\improper 卡赫拉曼重工货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自卡赫拉曼，为运输采矿设备做了加固。"
	icon_state = "kahraman"

/obj/structure/shipping_container/kahraman/alt
	icon_state = "kahraman_alt"

/obj/structure/shipping_container/kosmologistika
	name = "\improper 宇宙物流货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自宇宙物流，即由 SSC 拥有并运营的国家物流公司。"
	icon_state = "kosmologistika"

/obj/structure/shipping_container/magenta
	icon_state = "magenta"

/obj/structure/shipping_container/nakamura
	name = "\improper 中村工程货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自中村，大概是用来运输工具或重型工业设备的。"
	icon_state = "nakamura"

/obj/structure/shipping_container/nanotrasen
	name = "\improper 纳米传讯货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个醒目地印着纳米传讯的标志，所以里面装什么都可能。"
	icon_state = "nanotrasen"

/obj/structure/shipping_container/ntfid
	name = "\improper 纳米传讯未来与创新货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自 NTFID：纳米传讯的研究与开发部门。"
	icon_state = "ntfid"

/obj/structure/shipping_container/ntfid/defaced
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。显然有人对 NTFID 很有意见。"
	icon_state = "ntfid_defaced"

/obj/structure/shipping_container/nthi
	name = "\improper 纳米传讯重工业货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗普通金属与矿物运输。这一个来自 NTHI：纳米传讯的采矿与精炼部门。"
	icon_state = "nthi"

/obj/structure/shipping_container/nthi/minor
	desc = "标准尺寸的货运集装箱，用于大宗稀有金属与矿物运输。这一个来自 NTHI：纳米传讯的采矿与精炼部门。"
	icon_state = "nthi_minor"

/obj/structure/shipping_container/nthi/precious
	desc = "标准尺寸的货运集装箱，用于大宗贵金属与矿物运输。这一个来自 NTHI：纳米传讯的采矿与精炼部门。"
	icon_state = "nthi_precious"

/obj/structure/shipping_container/orange
	icon_state = "orange"

/obj/structure/shipping_container/purple
	icon_state = "purple"

/obj/structure/shipping_container/red
	icon_state = "red"

/obj/structure/shipping_container/sunda
	name = "\improper 巽他银河货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自巽他银河，里面几乎什么都可能装。"
	icon_state = "sunda"

/obj/structure/shipping_container/vitezstvi
	name = "\improper 胜利军火货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自胜利军火，自豪地宣称胜利武器就意味着胜利。"
	icon_state = "vitezstvi"

/obj/structure/shipping_container/vitezstvi/flags
	icon_state = "vitezstvi_flags"

/obj/structure/shipping_container/yellow
	icon_state = "yellow"

//Syndies
/obj/structure/shipping_container/biosustain
	name = "\improper 生物维持货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自生物维持，所以里面装的可能是种子或农业设备。"
	icon_state = "biosustain"

/obj/structure/shipping_container/cybersun
	name = "\improper 赛博太阳工业货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个醒目地印着赛博太阳的标志，所以里面几乎什么都可能装。"
	icon_state = "cybersun"

/obj/structure/shipping_container/cybersun/defaced
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个原本印着赛博太阳的标志，后来被一位有进取心的艺术家涂掉了。"
	icon_state = "cybersun_defaced"

/obj/structure/shipping_container/donk_co
	name = "\improper 咚克公司货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自咚克公司，所以里面什么都可能装——不过大概只是咚克口袋饼。"
	icon_state = "donk_co"

/obj/structure/shipping_container/exagon
	name = "\improper 埃克萨贡—市川货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗普通金属与矿物运输。这一个来自埃克萨贡—市川，即赛博太阳工业的采矿与精炼部门。"
	icon_state = "exagon"

/obj/structure/shipping_container/exagon/minor
	desc = "标准尺寸的货运集装箱，用于大宗稀有金属与矿物运输。这一个来自埃克萨贡—市川，即赛博太阳工业的采矿与精炼部门。"
	icon_state = "exagon_minor"

/obj/structure/shipping_container/exagon/precious
	desc = "标准尺寸的货运集装箱，用于大宗贵金属与矿物运输。这一个来自埃克萨贡—市川，即赛博太阳工业的采矿与精炼部门。"
	icon_state = "exagon_precious"

/obj/structure/shipping_container/gorlex
	name = "\improper 戈尔莱克斯安保货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自戈尔莱克斯安保，里面装的可能是他们的主要出口产品：战争罪行。"
	icon_state = "gorlex"

/obj/structure/shipping_container/gorlex/red
	icon_state = "gorlex_red"

/obj/structure/shipping_container/interdyne
	name = "\improper 英特戴恩货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自英特戴恩，一家私营制药公司。里面装的可能是医疗或研究用品，大概吧。"
	icon_state = "interdyne"

/obj/structure/shipping_container/oms
	name = "\improper OMS 货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这一个来自赛博太阳的医疗部门 OMS（大阪医疗系统），里面装的可能是医疗义体之类的东西。"
	icon_state = "oms"

/obj/structure/shipping_container/tiger_coop
	name = "可疑的货运集装箱"
	desc = "标准尺寸的货运集装箱，用于大宗货物运输。这个原本空白的集装箱被喷上了猛虎合作社的徽记，意味着里面装的东西大概很危险。"
	icon_state = "tiger_coop"

/obj/structure/shipping_container/tiger_coop/text
	icon_state = "tiger_coop_text"

// REEFER CONTAINERS (REFRIGERATED)
/obj/structure/shipping_container/reefer
	name = "冷藏货运集装箱"
	desc = "标准尺寸的冷藏货运集装箱，用于大宗冷藏货物运输。这一个表面空白，看不出里面装了什么。"
	icon_state = "blank_reefer"

/obj/structure/shipping_container/reefer/deforest
	name = "\improper 纳米传讯—德福雷斯特冷藏货运集装箱"
	desc = "标准尺寸的冷藏货运集装箱，用于大宗冷藏货物运输。这一个来自纳米传讯—德福雷斯特，里面装的可能是对温度敏感的的生物材料。"
	icon_state = "deforest_reefer"

/obj/structure/shipping_container/reefer/biosustain
	name = "\improper 生物维持冷藏货运集装箱"
	desc = "标准尺寸的冷藏货运集装箱，用于大宗冷藏货物运输。这一个来自生物维持，所以里面装的可能是转基因作物或农用化学品。"
	icon_state = "biosustain_reefer"

/obj/structure/shipping_container/reefer/interdyne
	name = "\improper 英特戴恩冷藏货运集装箱"
	desc = "标准尺寸的冷藏货运集装箱，用于大宗冷藏货物运输。这一个来自英特戴恩，一家私营制药公司，里面装的可能是器官或血液，也许两者都有。"
	icon_state = "interdyne_reefer"

// GAS TANK
/obj/structure/shipping_container/gas
	name = "散装储气罐"
	desc = "标准尺寸的储气罐，用于大宗气体运输。这一个相当不负责任地没有任何标识，看不出里面装了什么。"
	icon_state = "blank_gas"

/obj/structure/shipping_container/gas/apda
	name = "\improper APdA S.p.A. 散装氦气罐"
	desc = "标准尺寸的储气罐，用于大宗气体运输。这一个来自亚得里亚海石化联合公司，装的是他们第二重要的出口产品：用作燃料的氦-3。"
	icon_state = "apda_gas_helium"

/obj/structure/shipping_container/gas/apda/hydrogen
	name = "\improper APdA S.p.A. 散装氢气罐"
	desc = "标准尺寸的储气罐，用于大宗气体运输。这一个来自亚得里亚海石化联合公司，装的是他们最重要的出口产品：用作燃料的氢气。"
	icon_state = "apda_gas_hydrogen"

/obj/structure/shipping_container/gas/nthi
	name = "\improper NTHI 散装等离子气罐"
	desc = "标准尺寸的储气罐，用于大宗气体运输。这一个来自 NTHI，纳米传讯的采矿与精炼部门，装的是来自顺旋星区的高品位气态等离子体。"
	icon_state = "nthi_gas_plasma"

/obj/structure/shipping_container/gas/exagon
	name = "\improper 埃克萨贡—市川散装等离子气罐"
	desc = "标准尺寸的储气罐，用于大宗气体运输。这一个来自埃克萨贡—市川，赛博太阳工业的采矿与精炼部门，装的气态等离子体很可能来自火星。"
	icon_state = "exagon_gas_plasma"
