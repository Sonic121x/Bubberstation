
/datum/supply_pack/goody
	access = NONE
	group = "Goodies"
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/goody/clear_pda
	name = "全新品相纳米传讯透明 PDA"
	desc = "全新品相，刚刚重新包装！一件价值通常超过 250 万信用点的珍贵收藏品，现在以超低价出售！"
	cost = 100000
	contains = list(/obj/item/modular_computer/pda/clear)

/datum/supply_pack/goody/dumdum38
	name = ".38 达姆弹快速装弹器单包装"
	desc = "内含一个 .38 达姆弹快速装弹器，适合打进柔软目标里。"
	cost = PAYCHECK_CREW * 2
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/ammo_box/speedloader/c38/dumdum)

/datum/supply_pack/goody/match38
	name = ".38 竞赛级快速装弹器单包装"
	desc = "内含一个竞赛级 .38 弹药快速装弹器，非常适合用来表演花式射击。"
	cost = PAYCHECK_CREW * 2
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/ammo_box/speedloader/c38/match)

/datum/supply_pack/goody/rubber
	name = ".38 橡胶快速装弹器单包装"
	desc = "内含一个弹性橡胶 .38 弹药快速装弹器，当你想让子弹从任何东西上弹开时使用。"
	cost = PAYCHECK_CREW * 1.5
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/ammo_box/speedloader/c38/match/bouncy)

/datum/supply_pack/goody/dumdum38br
	name = ".38 达姆弹弹匣单包装"
	desc = "内含一个 .38 达姆弹弹匣，适合打进柔软目标里。"
	cost = PAYCHECK_CREW * 2
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/ammo_box/magazine/m38/dumdum)

/datum/supply_pack/goody/match38br
	name = ".38 竞赛级弹匣单包装"
	desc = "内含一个竞赛级 .38 弹药弹匣，非常适合用来表演花式射击。"
	cost = PAYCHECK_CREW * 2
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/ammo_box/magazine/m38/match)

/datum/supply_pack/goody/rubber
	name = ".38 橡胶弹匣单包装"
	desc = "内含一个弹性橡胶 .38 弹药弹匣，当你想让子弹从任何东西上弹开时使用。"
	cost = PAYCHECK_CREW * 1.5
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/ammo_box/magazine/m38/match/bouncy)
	
/datum/supply_pack/goody/mars_single
	name = "柯尔特侦探特型单包装"
	desc = "安保主管没收了你的枪和警徽？没问题！只要付这笔离谱的税，你就能重新拥有 .38 的致命威力！"
	cost = PAYCHECK_CREW * 40 //they really mean a premium here
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/revolver/c38/detective)

/datum/supply_pack/goody/stingbang
	name = "震撼闪光弹单包装"
	desc = "内含一枚“震撼闪光弹”，非常适合搞恶毒的恶作剧。"
	cost = PAYCHECK_COMMAND * 2.5
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/grenade/stingbang)

/datum/supply_pack/goody/Survivalknives_single
	name = "求生刀单包装"
	desc = "含一把锋利的求生刀，保证能严丝合缝地插进任何纳米传讯标准军靴。"
	cost = PAYCHECK_COMMAND * 1.75
	contains = list(/obj/item/knife/combat/survival)

/datum/supply_pack/goody/ballistic_single
	name = "战斗霰弹枪单包装"
	desc = "当敌人绝对需要被铅弹替换时使用。内含一把 Aussec 设计的战斗霰弹枪和一条霰弹枪弹带。"
	cost = PAYCHECK_COMMAND * 15
	access_view = ACCESS_ARMORY
	contains = list(
		/obj/item/gun/ballistic/shotgun/automatic/combat,
		/obj/item/storage/belt/bandolier
	)

/datum/supply_pack/goody/disabler_single
	name = "眩晕枪单包装"
	desc = "内含一把眩晕枪，纳米传讯各地安保部门非致命的主力装备。附带一个能量枪套，以防你恰好还有一把多余的眩晕枪。"
	cost = PAYCHECK_COMMAND * 3
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/storage/belt/holster/energy/disabler)

/datum/supply_pack/goody/energy_single
	name = "能量枪单包装"
	desc = "内含一把能量枪，可发射非致命与致命光束。"
	cost = PAYCHECK_COMMAND * 12
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/e_gun)

/datum/supply_pack/goody/laser_single
	name = "5 型激光枪单包装"
	desc = "内含一把 5 型激光枪，纳米传讯各地安保部门的致命主力装备。"
	cost = PAYCHECK_COMMAND * 6
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser)

/datum/supply_pack/goody/carbine_single
	name = "5/R 型激光卡宾枪单包装"
	desc = "内含一把激光卡宾枪，能快速连发威力略弱的激光弹。"
	cost = PAYCHECK_COMMAND * 8
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser/carbine)

/datum/supply_pack/goody/laser_pistol_single
	name = "5/C 型激光手枪单包装"
	desc = "内含一把 5C 型激光手枪，附能量肩挂枪套。妙极了。"
	cost = PAYCHECK_COMMAND * 2
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/storage/belt/holster/energy/laser_pistol)

/datum/supply_pack/goody/laser_single_soul
	name = "3 型激光枪单包装"
	desc = "内含一把 3 型激光枪。现在的东西可没以前做得那么好。"
	cost = PAYCHECK_COMMAND * 6
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser/soul)

/datum/supply_pack/goody/smg_single
	name = "眩晕冲锋枪单包装"
	desc = "内含一把眩晕冲锋枪，能快速连发弱化眩晕光束。"
	cost = PAYCHECK_COMMAND * 6
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/disabler/smg)

/datum/supply_pack/goody/hell_single
	name = "地狱枪改装套件单包装"
	desc = "内含一套地狱枪降级改装套件，可将普通激光枪改装成一种旧式激光枪， \
		以能用灼伤把目标弄得惨不忍睹而臭名昭著。 \
		用于人形生物时，技术上违反《太空日内瓦公约》。"
	cost = PAYCHECK_CREW * 2
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/weaponcrafting/gunkit/hellgun)

/datum/supply_pack/goody/thermal_single
	name = "热能手枪枪套单包装"
	desc = "内含一对装在枪套里的热能手枪，随时可在战场上使用。"
	cost = PAYCHECK_COMMAND * 15
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/storage/belt/holster/energy/thermal)

/datum/supply_pack/goody/sologamermitts
	name = "绝缘手套单包装"
	desc = "现代社会的栋梁。几乎从来没有人为了真正的工程用途订购它。"
	cost = PAYCHECK_CREW * 8
	contains = list(/obj/item/clothing/gloves/color/yellow)

/datum/supply_pack/goody/gorilla_single
	name = "大猩猩手套单包装"
	desc = "一副备用的大猩猩手套。比起安保售货机里的擒拿手套更适合扑倒。"
	cost = PAYCHECK_COMMAND * 6
	contains = list(/obj/item/clothing/gloves/tackler/combat)

/datum/supply_pack/goody/firstaidbruises_single
	name = "淤伤治疗包单包装"
	desc = "一个单独的外伤医疗包，非常适合从被气闸夹伤中恢复。你知道人们经常被气闸夹伤吗？真有意思……"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/storage/medkit/brute)

/datum/supply_pack/goody/firstaidburns_single
	name = "烧伤治疗包单包装"
	desc = "一个单独的烧伤医疗包。广告上画着一位眨眼的工程技师竖起大拇指，说：“难免会出错！”"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/storage/medkit/fire)

/datum/supply_pack/goody/firstaid_single
	name = "急救包单包装"
	desc = "一个单独的医疗包，足以治愈大多数类型的身体损伤。"
	cost = PAYCHECK_CREW * 3
	contains = list(/obj/item/storage/medkit/regular)

/datum/supply_pack/goody/firstaidoxygen_single
	name = "缺氧治疗包单包装"
	desc = "一个单独的缺氧医疗包，主要面向那些对窒息有严重恐惧的人营销。"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/storage/medkit/o2)

/datum/supply_pack/goody/firstaidtoxins_single
	name = "毒素治疗包单包装"
	desc = "一个单独的急救包，专用于治疗强烈毒素造成的伤害。"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/storage/medkit/toxin)

/datum/supply_pack/goody/bandagebox_singlepack
	name = "盒装创可贴单包装"
	desc = "一盒 DeForest 品牌创可贴。当你不想到医生那里去时使用。"
	cost = PAYCHECK_CREW * 3
	contains = list(/obj/item/storage/box/bandages)

/datum/supply_pack/goody/toolbox // mostly just to water down coupon probability
	name = "机械工具箱"
	desc = "一个装备齐全的机械工具箱，当你懒得自己打印的时候用。"
	cost = PAYCHECK_CREW * 3
	contains = list(/obj/item/storage/toolbox/mechanical)

/datum/supply_pack/goody/autolatheboard
	name = "自动车床电路板"
	desc = "一块自动车床电路板，满足你的建造需求。"
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/circuitboard/machine/autolathe)

/datum/supply_pack/goody/valentine
	name = "情人节卡片"
	desc = "给那个特别的人留下深刻印象！附赠一张情人节卡片和一颗免费的心形糖果！"
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/paper/valentine, /obj/item/food/candyheart)

/datum/supply_pack/goody/beeplush
	name = "蜜蜂玩偶"
	desc = "你能用辛苦挣来的钱买到的最重要的东西。"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/toy/plush/beeplushie)

/datum/supply_pack/goody/blahaj
	name = "鲨鱼玩偶"
	desc = "一个柔软温暖的午睡伙伴。"
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/toy/plush/shark)

/datum/supply_pack/goody/horseplush
	name = "马玩偶"
	desc = "一个陪伴你的马朋友。你现在基本上算个牛仔了。"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/toy/plush/horse)

/datum/supply_pack/goody/unicornplush
	name = "独角兽玩偶"
	desc = "适合喜欢独角兽的人。等等，那不是所有人吗！"
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/toy/plush/unicorn)

/datum/supply_pack/goody/dog_bone
	name = "巨型狗骨头"
	desc = "能出口到空间站的最好的狗骨头。送给狗的完美礼物。"
	cost = PAYCHECK_COMMAND * 4
	contains = list(/obj/item/dog_bone)

/datum/supply_pack/goody/dyespray
	name = "染发喷雾"
	desc = "一瓶很酷的喷雾，能把你的头发染成炫酷的颜色！"
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/dyespray)

/datum/supply_pack/goody/pilotsuit
	name = "Mech Pilot Suit"
	desc = "For when you need to look the part during your pre-battle checks. Can be reskinned with alt-click."
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/clothing/under/costume/mech_suit)

/datum/supply_pack/goody/beach_ball
	name = "沙滩球单包装"
	// uses desc from item
	cost = PAYCHECK_CREW
	contains = list(/obj/item/toy/beach_ball/branded)

/datum/supply_pack/goody/beach_ball/New()
	..()
	var/obj/item/toy/beach_ball/branded/beachball_type = /obj/item/toy/beach_ball/branded
	desc = initial(beachball_type.desc)

/datum/supply_pack/goody/medipen_twopak
	name = "医疗笔双支装"
	desc = "内含一支标准肾上腺素医疗笔和一支标准应急医疗包医疗笔。为你最坏的打算做准备。"
	cost = PAYCHECK_CREW * 2
	contains = list(
		/obj/item/reagent_containers/hypospray/medipen,
		/obj/item/reagent_containers/hypospray/medipen/ekit
	)

/datum/supply_pack/goody/mothic_rations
	name = "蛾族剩余口粮包"
	desc = "一包来自蛾族舰队的剩余口粮。内含 3 条随机营养棒和一包 Activin 口香糖。"
	cost = PAYCHECK_COMMAND * 2
	contains = list(/obj/item/storage/box/mothic_rations)

/datum/supply_pack/goody/ready_donk
	name = "即食咚克单份餐"
	desc = "为懒到极点的人准备的全套餐包。内含一份即食咚克餐。"
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/food/ready_donk)

/datum/supply_pack/goody/pill_mutadone
	name = "应急诱变酮药片单包装"
	desc = "一片用于治疗基因缺陷的药片。当你在医疗舱拿不到时很有用。"
	cost = PAYCHECK_CREW * 2.5
	contains = list(/obj/item/reagent_containers/applicator/pill/mutadone)

/datum/supply_pack/goody/rapid_lighting_device
	name = "快速照明装置（RLD）单包装"
	desc = "一种用于快速为区域提供光源的装置。可用铁、塑料钢、玻璃或压缩物质弹药筒装填。"
	cost = PAYCHECK_CREW * 10
	contains = list(/obj/item/construction/rld)

/datum/supply_pack/goody/fishing_toolbox
	name = "钓鱼工具箱"
	desc = "为你的钓鱼冒险准备的完整工具箱套装。内含一条宝贵的建议。高级鱼钩和鱼线另售。"
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/storage/toolbox/fishing)

/datum/supply_pack/goody/fishing_hook_set
	name = "鱼钩套装"
	desc = "各种鱼钩的套装。"
	cost = PAYCHECK_CREW
	contains = list(/obj/item/storage/box/fishing_hooks)

/datum/supply_pack/goody/fishing_line_set
	name = "鱼线套装"
	desc = "各种鱼线的套装。"
	cost = PAYCHECK_CREW
	contains = list(/obj/item/storage/box/fishing_lines)

/datum/supply_pack/goody/fishing_lure_set
	name = "拟饵套装"
	desc = "一套防咬的拟饵，能钓到所有（大部分）种类的鱼。今天就把随机性踩在脚下！"
	cost = PAYCHECK_CREW * 8
	contains = list(/obj/item/storage/box/fishing_lures)

/datum/supply_pack/goody/fishing_hook_rescue
	name = "救援鱼钩单包装"
	desc = "当你的矿工同伴不可避免地掉进裂隙时，就靠你来救他了。"
	cost = PAYCHECK_CREW * 12
	contains = list(/obj/item/fishing_hook/rescue)

/datum/supply_pack/goody/premium_bait
	name = "豪华鱼饵单包装"
	desc = "当标准品种对你来说不够好时。"
	cost = PAYCHECK_CREW
	contains = list(/obj/item/bait_can/worm/premium)

/datum/supply_pack/goody/fish_feed
	name = "罐装鱼食单包装"
	desc = "用来让你小朋友吃饱并活着。"
	cost = PAYCHECK_CREW
	contains = list(/obj/item/reagent_containers/cup/fish_feed)

/datum/supply_pack/goody/naturalbait
	name = "装满天然鱼饵的保鲜罐单包装"
	desc = "在顺旋星区自制。"
	cost = PAYCHECK_CREW * 4 //rock on
	contains = list(/obj/item/storage/pill_bottle/naturalbait)

/datum/supply_pack/goody/telescopic_fishing_rod
	name = "伸缩鱼竿单包装"
	desc = "一根可折叠、能放进背包的鱼竿。"
	cost = PAYCHECK_CREW * 8
	contains = list(/obj/item/fishing_rod/telescopic)

/datum/supply_pack/goody/fish_analyzer
	name = "鱼类分析仪单包装"
	desc = "一台单独的分析仪，用来监测鱼的状态与特性，以防你没有打印它的技术。"
	cost = PAYCHECK_CREW * 2.5
	contains = list(/obj/item/fish_analyzer)

/datum/supply_pack/goody/fish_catalog
	name = "钓鱼图鉴单包装"
	desc = "一本包含你所需全部鱼类信息的图鉴。"
	cost = PAYCHECK_LOWER
	contains = list(/obj/item/book/manual/fish_catalog)

/datum/supply_pack/goody/aquarium_props
	name = "水族箱道具单包装"
	desc = "一箱通用水族箱道具。你仍然需要水族箱或鱼缸来放它们。"
	cost = PAYCHECK_LOWER
	contains = list(/obj/item/storage/box/aquarium_props)

/datum/supply_pack/goody/coffee_mug
	name = "咖啡杯单包装"
	desc = "一个普普通通的咖啡杯，用来喝咖啡。"
	cost = PAYCHECK_LOWER
	contains = list(/obj/item/reagent_containers/cup/glass/mug)

/datum/supply_pack/goody/nt_mug
	name = "纳米传讯咖啡杯单包装"
	desc = "一个印着你公司主子标志的蓝色杯子。通常在入职培训或活动上发放，只要付一点名义费用，我们也可以专门给你寄一个。"
	cost = PAYCHECK_LOWER
	contains = list(/obj/item/reagent_containers/cup/glass/mug/nanotrasen)

/datum/supply_pack/goody/coffee_cartridge
	name = "咖啡胶囊单包装"
	desc = "用于咖啡机的基础胶囊。可煮 4 壶。"
	cost = PAYCHECK_LOWER
	contains = list(/obj/item/coffee_cartridge)

/datum/supply_pack/goody/coffee_cartridge_fancy
	name = "高级咖啡胶囊单包装"
	desc = "用于咖啡机的高级胶囊。可煮 4 壶。"
	cost = PAYCHECK_CREW
	contains = list(/obj/item/coffee_cartridge/fancy)

/datum/supply_pack/goody/coffeepot
	name = "咖啡壶单包装"
	desc = "一个标准尺寸的咖啡壶，配合咖啡机使用。"
	cost = PAYCHECK_CREW
	contains = list(/obj/item/reagent_containers/cup/coffeepot)

/datum/supply_pack/goody/climbing_hook
	name = "攀爬钩单包装"
	desc = "一个不那么便宜的进口攀爬钩。除了多层空间站以外完全没用。"
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/climbing_hook)

/datum/supply_pack/goody/double_barrel
	name = "双管霰弹枪单包装"
	desc = "心爱的兔子被恶魔入侵夺走了？小丑闯进来偷走了你心爱的枪？没问题！只要付得起离谱的费用，就能再买一把。"
	cost = PAYCHECK_COMMAND * 18
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/shotgun/doublebarrel)

/datum/supply_pack/goody/experimental_medication
	name = "实验性药物单包装"
	desc = "一瓶 Interdyne 牌实验性药物，用于治疗患有遗传性多重疾病的人。"
	cost = PAYCHECK_CREW * 6.5
	contains = list(/obj/item/storage/pill_bottle/sansufentanyl)

/datum/supply_pack/goody/pet_mouse
	name = "宠物鼠"
	desc = "很多人认为老鼠是害虫、是做实验的脏耗子，或者是一道美食。所以我们在这里不多问问题。"
	cost = PAYCHECK_CREW * 1.5
	contains = list(/obj/item/pet_carrier/small/mouse)

/datum/supply_pack/goody/shuttle_construction_kit
	name = "穿梭机构建入门套件"
	desc = "内含一套穿梭机蓝图，以及建造你自己的穿梭机所需的电路板。 \
			至少包含那些没有科研帮助你就弄不到的东西。"
	cost = PAYCHECK_COMMAND * 12 //You assistants with shipwrighting ambitions can do a couple bounties, can't you?
	access_view = ACCESS_AUX_BASE //Engineers have it, QM can give it to whoever, and scientists can just research the tech.
	contains = list(
		/obj/item/shuttle_blueprints,
		/obj/item/circuitboard/computer/shuttle/flight_control,
		/obj/item/circuitboard/computer/shuttle/docker,
		/obj/item/circuitboard/machine/engine/propulsion = 2,
	)

/datum/supply_pack/goody/golfcart_key
	name = "备用高尔夫球车钥匙"
	desc = "如果你粗心大意弄丢了高尔夫球车钥匙，可以买一把。很遗憾，不在保修范围内。"
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/key/golfcart)

/datum/supply_pack/goody/handheld_crew_monitor
	name = "手持船员监测仪"
	desc = "内含一台手持船员监测仪。"
	cost = /obj/item/sensor_device::custom_premium_price * 1.25 // 1.25X base vending machine value
	contains = list(
		/obj/item/sensor_device,
	)
	crate_name = "手持船员监测仪板条箱"

/datum/supply_pack/goody/camera
	name = "广播摄像机"
	desc = "一台单独的广播摄像机，可向空间站的娱乐显示器进行广播，满足你所有的戏剧需求。"
	cost = PAYCHECK_COMMAND * 8
	contains = list(/obj/item/broadcast_camera/cargo)

/datum/supply_pack/goody/rock_tape
	name = "Boombox tape (Rock)"
	desc = "A classic rock track by George Patel, 'Bainrock'. Requires a boombox to play."
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/music_tape/rock)

/datum/supply_pack/goody/hiphop_tape
	name = "Boombox tape (HipHop)"
	desc = "A trendy hiphop track by F'norkiz Gamma, 'Groovepad'. Requires a boombox to play."
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/music_tape/hiphop)
