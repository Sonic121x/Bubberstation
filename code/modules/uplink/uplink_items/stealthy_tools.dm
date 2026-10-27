/datum/uplink_category/stealthy_tools
	name = "潜行小工具"
	weight = 4

/datum/uplink_item/stealthy_tools
	category = /datum/uplink_category/stealthy_tools
	uplink_item_flags = SYNDIE_ILLEGAL_TECH


/datum/uplink_item/stealthy_tools/agent_card
	name = "特工身份卡"
	desc = "特工身份卡能阻止人工智能追踪佩戴者，还可容纳来自其他身份卡的 5 个万能权限。 \
			此外，它们可以被伪造，以显示新的职务、姓名和修饰。 \
			伪造次数不限。某些辛迪加区域和设备只能凭 \
			这类卡进入。"
	item = /obj/item/card/id/advanced/chameleon/elite
	cost = 2

/datum/uplink_item/stealthy_tools/ai_detector
	name = "人工智能探测器"
	desc = "一把实用的多功能工具，探测到人工智能正在监视它时会变红， \
			激活后可显示人工智能确切的观察位置。知道 \
			人工智能何时在看着你，有助于判断何时需要维持伪装，而找到附近的 \
			盲区则能帮你确定逃跑路线。"
	item = /obj/item/multitool/ai_detect
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	cost = 1

/datum/uplink_item/stealthy_tools/chameleon
	name = "变色龙套件"
	desc = "一套搭载变色龙技术的物品，能让你伪装成空间站上几乎任何东西，甚至更多！ \
			由于预算削减，鞋子不提供防滑保护，技能芯片需另行购买。"
	item = /obj/item/storage/box/syndie_kit/chameleon
	cost = 2
	purchasable_from = ~UPLINK_NUKE_OPS //clown ops are allowed to buy this kit, since it's basically a costume, loneops can purchase it to blend in.

/datum/uplink_item/stealthy_tools/syndigaloshes
	name = "防滑变色龙鞋"
	desc = "穿上这双鞋，使用者就能在湿滑地面和光滑物体上奔跑而不摔倒。 \
			但在经过重度润滑的表面上则无效。"
	item = /obj/item/clothing/shoes/chameleon/noslip
	cost = 2
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS)

/datum/uplink_item/stealthy_tools/chameleon_proj
	name = "变色龙投影仪"
	desc = "把影像投射到使用者身上，将其伪装成用投影仪扫描过的物体，前提是使用者 \
			不把投影仪从手中移开。伪装状态下的使用者移动缓慢，射弹会直接穿过他们。"
	item = /obj/item/chameleon
	cost = 7

/datum/uplink_item/stealthy_tools/codespeak_manual
	name = "暗语手册"
	desc = "辛迪加特工可以接受训练，使用一系列暗语来传达复杂信息，而在旁人听来只是一堆随机的概念和饮料名。 \
			这本手册会教你这种暗语。你也可以用手册敲别人一下来教他们。这是豪华版，使用次数不限。"
	item = /obj/item/language_manual/codespeak_manual/unlimited
	cost = 3

/datum/uplink_item/stealthy_tools/emplight
	name = "EMP 手电筒"
	desc = "一台小巧、可自行充能、射程较短的 EMP 装置，伪装成一支能用的手电筒。 \
			适合在潜行行动中瘫痪耳机、摄像头、门、储物柜和半机械人。 \
			用手电筒攻击目标会对其发射电磁脉冲，并消耗一次充能。"
	item = /obj/item/flashlight/emp
	cost = 2
	surplus = 30

/datum/uplink_item/stealthy_tools/emplight/New()
	..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CYBERNETIC_REVOLUTION))
		cost *= 3

/datum/uplink_item/stealthy_tools/mulligan
	name = "重塑套件"
	desc = "搞砸了，还被安保盯上了？这支便利的注射器和这套文件能给你一个全新的身份 \
			和外表，同时拦截纳米传讯的通讯，把你播报为一名新招募的助理。"
	item = /obj/item/storage/box/syndie_kit/mulligan
	cost = 4
	surplus = 30
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS)

/datum/uplink_item/stealthy_tools/jammer
	name = "无线电干扰器"
	desc = "激活后，这台装置会干扰附近所有的无线电对外通讯。不影响二进制聊天。"
	item = /obj/item/jammer
	cost = 1

/datum/uplink_item/stealthy_tools/smugglersatchel
	name = "走私挎包"
	desc = "这个挎包足够薄，可以藏在地板层与地砖之间的缝隙里；非常适合藏匿 \
			你偷来的东西。附赠一根撬棍、一块地板砖和里面的一些违禁品。其内容物无法被违禁品扫描仪检测到。"
	item = /obj/item/storage/backpack/satchel/flat/with_tools
	cost = 1
	surplus = 30
	uplink_item_flags = NONE

/datum/uplink_item/stealthy_tools/mail_counterfeit
	name = "GLA 品牌邮件伪造装置"
	desc = "一台能伪造 NT 邮件的装置。也可以用来在里面存放物品，方便走私违禁品。 \
			此外，你还可以选择把里面的物品“武装”，这样邮件被打开的瞬间物品就会像被人拿在手里使用一样启动。 \
			这项功能最常用于手榴弹，因为它会强制手榴弹进入引爆序列。如果设成瞬间引爆，还能额外加分。 \
			附赠一台用于配置的集成微型计算机。"
	item = /obj/item/storage/mail_counterfeit_device
	cost = 1
	surplus = 30

/datum/uplink_item/stealthy_tools/forensics_spofer
	name = "取证欺骗套件"
	desc = "一个盒子，内含取证欺骗器（及说明书），可扫描并复制指纹和纤维， \
			再将其附着到目标物体上。适合用来陷害船员。建议搭配肥皂一同购买。"
	item = /obj/item/storage/box/syndie_kit/forensics_spoofer
	cost = 5

/datum/uplink_item/stealthy_tools/telecomm_blackout
	name = "瘫痪通讯系统"
	desc = "购买后，会有一段病毒被上传至通讯处理服务器，使其暂时自行停运。"
	item = ABSTRACT_UPLINK_ITEM
	surplus = 0
	progression_minimum = 15 MINUTES
	limited_stock = 1
	cost = 4
	restricted = TRUE
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS) //Can still be purchased by loneops to give them an edge.

/datum/uplink_item/stealthy_tools/telecomm_blackout/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	force_event(/datum/round_event_control/communications_blackout, "一种辛迪加病毒")
	return source //For log icon

/datum/uplink_item/stealthy_tools/blackout
	name = "触发全站停电"
	desc = "购买后，会有一段病毒被上传至工程处理服务器，强制进行一次例行电网检查，使空间站上所有 APC 暂时失效。"
	item = ABSTRACT_UPLINK_ITEM
	surplus = 0
	progression_minimum = 15 MINUTES
	limited_stock = 1
	cost = 6
	restricted = TRUE
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS) //Can still be purchased by loneops to give them an edge.

/datum/uplink_item/stealthy_tools/blackout/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	force_event(/datum/round_event_control/grid_check, "一种辛迪加病毒")
	return source //For log icon
