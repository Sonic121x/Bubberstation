//These are static plaques, they are made of gold and start engraved with a title and description.

/obj/structure/plaque/static_plaque
	engraved = TRUE

/obj/structure/plaque/static_plaque/Initialize(mapload)
	. = ..()
	if(isopenturf(loc) && !isProbablyWallMounted(src))
		SET_PLANE_IMPLICIT(src, FLOOR_PLANE)
		layer = HIGH_TURF_LAYER

/obj/structure/plaque/static_plaque/get_mountable_objects()
	return list()

/obj/structure/plaque/static_plaque/find_and_mount_on_atom(mark_for_late_init, late_init)
	if(isProbablyWallMounted(src))
		return ..()

/obj/structure/plaque/static_plaque/atmos
	name = "\improper FEA 大气部分部纪念牌"
	desc = "这块纪念牌纪念大气部 FEA 分部的覆灭。献给所有死于其手中的那些被烧焦、头晕目眩、骨脆易折的人们。"

/obj/structure/plaque/static_plaque/thunderdome
	name = "\improper 雷霆竞技场纪念牌"
	desc = "这块纪念牌纪念那些在光荣战斗中倒下的人。献给所有死于其手中的那些被烧焦、头晕目眩、饱受殴打的人们。"

/obj/structure/plaque/static_plaque/golden
	name = "最强劲男士强劲奖"
	desc = "强劲并非一种行为或生活方式，而是一种精神状态。只有那些意志力足够强大、能在危机中采取行动、从敌人手中救下朋友的人，才是真正强劲的。保持强劲吧，朋友们。"
	icon_state = "goldenplaque"

/obj/structure/plaque/static_plaque/golden/captain
	name = "最强劲舰长强劲奖"

// Commission plaques, to give a little backstory to the stations. Commission dates are date of merge (or best approximation, in the case of Meta) + 540 years to convert to SS13 dates.
// Where PRs are available, I've linked them. Where they are unavailable, a git hash is provided instead for the direct commit that added/removed the map.
// Please enjoy this trip through SS13's history.

// Runtimestation: added Nov 11, 2016 (946ec1fec869eb59d6a84e32c90613af734fcd0e)
/obj/structure/plaque/static_plaque/golden/commission
	name = "启用纪念牌"
	desc = "顺旋星区空间站 SS-13\n“运行时”级前哨站\n启用 03/11/2556\n“献给先驱者们”"
	icon_state = "commission_nt"
	layer = BELOW_OPEN_DOOR_LAYER

//Current stations

// Catwalk: added Apr 10, 2025 (#90532)
/obj/structure/plaque/static_plaque/golden/commission/catwalk
	desc = "顺旋星区空间站 SS-13\n“栈桥”级前哨站\n启用 10/04/2565\n“新的高度”"

// Deltastation: added Dec 17, 2016 (#22066)
/obj/structure/plaque/static_plaque/golden/commission/delta
	desc = "顺旋星区空间站 SS-13\n“德尔塔”级前哨站\n启用 17/12/2556\n“以冗余求效率”"

// Icebox Station: added May 13, 2020 (#51090)
/obj/structure/plaque/static_plaque/golden/commission/icebox
	desc = "顺旋星区空间站 SS-13\n“箱型”级前哨站（第 2.2 版：“冰盒”）\n启用 13/05/2560\n“冷酷可靠”"

// Metastation: added Mar 11, 2013 (best estimate, pre-git)
/obj/structure/plaque/static_plaque/golden/commission/meta
	desc = "顺旋星区空间站 SS-13\n“元”级前哨站\n启用 11/03/2553\n“忒修斯”站"

// Nebulastation: added Nov 6, 2024 (#84826)
/obj/structure/plaque/static_plaque/golden/commission/nebula
	desc = "顺旋星区空间站 SS-13\n“星云”级前哨站\n启用 06/11/2564\n“崭新的未来”"

// Kilostation: added Nov 13, 2019 (#46968)
/obj/structure/plaque/static_plaque/golden/commission/kilo
	desc = "顺旋星区空间站 SS-13\n“千型”级前哨站\n启用 13/11/2559\n“永远不同”"

// Tramstation: added Mar 11, 2021 (#56509)
/obj/structure/plaque/static_plaque/golden/commission/tram
	desc = "顺旋星区空间站 SS-13\n“电车”级前哨站\n启用 11/03/2561\n“步步前行”"

// Kilostation: added Nov 13, 2019 (#46968), removed, readded Jul 7, 2026 (#96447)
/obj/structure/plaque/static_plaque/golden/commission/kilo
	desc = "顺旋星区空间站 SS-13\n“千型”级前哨站\n启用 13/11/2559\n退役\n于 7/7/2566 重新启用“永远不同”"

// Boxstation: added Nov 15, 2010 (pre-git), removed Jul 06, 2020 (#52017)- 9 years, 7 months, 21 days
// Modified NSSJourney (from FluffySTG), added April 19, 2021 (#4884). added to Bubber Feb 10, 2024 (#1128).
/obj/structure/plaque/static_plaque/golden/commission/box
	desc = "顺旋星区空间站 SS-02\n“箱型”级前哨站\n启用 15/11/2550\n退役 06/07/2560\n于 10/02/2564 重新启用\n“无可争议的拳击冠军”"

//Removed stations

// Asteroidstation: added Oct 17, 2015 (169ab09f7b52254ee505e54cdea681fab287647b), removed Jun 19, 2016 (#18661)- 8 months, 2 days
/obj/structure/plaque/static_plaque/golden/commission/asteroid
	desc = "顺旋星区空间站 SS-12\n“小行星”级前哨站\n启用 13/10/2555\n退役 19/06/2556\n“流星般的成功”"

// Birdboat Station: added Sep 17, 2015 (#11829), removed Feb 09, 2017 (#23754)- 1 year, 4 months, 23 days
/obj/structure/plaque/static_plaque/golden/commission/birdboat
	desc = "顺旋星区空间站 SS-03\n“鸟船”级前哨站\n启用 17/09/2555\n退役 09/02/2557\n“摇动小船”"

// Pubbystation: added Oct 19, 2016 (#20925), removed Dec 10, 2020 (#54588)- 4 years, 1 month, 21 days
/obj/structure/plaque/static_plaque/golden/commission/pubby
	desc = "顺旋星区空间站 SS-06\n“酒馆”级前哨站\n启用 19/10/2556\n退役 10/12/2560\n“除了我们的法律别无他法”"

// Cerestation: added Mar 29, 2017 (#24665), removed Aug 26th, 2017 (#30196)- 4 months, 28 days
/obj/structure/plaque/static_plaque/golden/commission/cere
	desc = "顺旋星区空间站 SS-10\n“谷神”级前哨站\n启用 29/03/2557\n退役 26/08/2557\n“滚去远足”"

// Discstation: added Sep 21, 2015 (#11923), removed Jan 31, 2016 (#15069)- 4 months, 10 days
/obj/structure/plaque/static_plaque/golden/commission/disc
	desc = "顺旋星区空间站 SS-05\n“圆盘”级前哨站\n启用 21/09/2555\n退役 31/01/2556\n“睡个好觉”"

// Donutstation: added Dec 16, 2018 (#41099), removed Apr 28, 2020 (#50730)- 1 year, 4 months, 12 days
/obj/structure/plaque/static_plaque/golden/commission/donut
	desc = "顺旋星区空间站 SS-11\n“甜甜圈”级前哨站\n启用 16/12/2558\n退役 28/04/2560\n“赞美吾主”"

// Dreamstation: added Oct 06, 2015 (#12154), removed Dec 22, 2016 (#22305)- 1 year, 2 months, 16 days
/obj/structure/plaque/static_plaque/golden/commission/dream
	desc = "顺旋星区空间站 SS-04\n“梦境”级前哨站\n启用 06/10/2555\n退役 22/12/2556\n“志存高远”"

// Efficiencystation: added Jan 28, 2016 (46f64266cfb8b40e35faa8a4d9a2d3aeec689943), removed Dec 20, 2016 (#22306)- 10 months, 22 days
/obj/structure/plaque/static_plaque/golden/commission/efficiency
	desc = "顺旋星区空间站 SS-07\n“效率”级前哨站\n启用 28/01/2556\n退役 20/12/2556\n“巧干而非苦干”"

// Ministation: added Jan 29, 2014 (7a76e9456b782e6626bf81e27a912d8232c76b18), removed Dec 27, 2016 (#22453)- 2 years, 10 months, 28 days
/obj/structure/plaque/static_plaque/golden/commission/mini
	desc = "顺旋星区空间站 SS-08\n“迷你”级前哨站\n启用 29/01/2554\n退役 27/12/2556\n“最小的空间站”"

// North Star: added Apr 13, 2023 (#74371), removed Nov 25, 2024 (#87937)- 1 year, 7 months, 12 days
/obj/structure/plaque/static_plaque/golden/commission/northstar
	desc = "顺旋星区船舰 SS-13\n“北极星”级舰船\n启用 13/04/2563\n退役 25/11/2564\n“新的机遇”"

// Omegastation: added Dec 27, 2016 (#22453), removed Sep 20, 2018 (#40352)- 1 year, 8 months, 24 days
/obj/structure/plaque/static_plaque/golden/commission/omega
	desc = "顺旋星区空间站 SS-09\n“欧米伽”级前哨站\n启用 27/12/2556\n退役 20/09/2558\n“小巧，再来一次”"

// Uterusstation: added Sep 03, 2011 (bbd6db9ce2d6341892b89a620593fc8877f5a817), removed Jun 21, 2012 (72d72f7ce522c2d2ad4863f44ee9f5054413c489)- 9 months, 18 days
/obj/structure/plaque/static_plaque/golden/commission/uterus
	desc = "顺旋星区空间站 SS-01\n“子宫”级前哨站\n启用 03/09/2551\n退役 21/06/2552\n“人类先锋”"

// Birdshot: added Apr 29, 2023 (#74371), removed Jul 9, 2025 (#92022) — 2 years, 2 months, 10 days
/obj/structure/plaque/static_plaque/golden/commission/birdshot
	desc = "顺旋星区空间站 SS-13\n“鸟弹”级前哨站\n启用 29/04/2563\n退役 09/07/2565\n“向着星辰进发”"

// Wawastation: added Jun 4, 2024 (#82298), removed Jul 7, 2026 (#96447) - 2 years, 1 month, 3 days
/obj/structure/plaque/static_plaque/golden/commission/wawa
	desc = "顺旋星区空间站 SS-13\n“瓦瓦”级前哨站\n启用 04/06/2564\n退役 9/07/2565\n“永远垂直”"

// Other Stations

// Space Station 13, Developer Class Outpost, Station Commissioned 30.12.2322, For the Glory of the Workers of the Third Soviet Union
// The date for this station is exactly 4 centuries after the initial foundation of the (1st) Soviet Union. I have very little interest in tracking down the actual date of addition of Originalstation.
/obj/structure/plaque/static_plaque/golden/commission/ks13
	desc = "космическая-станция-13\nфорпост класса разработчика\nстанция сдана 30.12.2322\nво славу тружеников третьего советского союза"
	icon_state = "commission_commie"

//These are plaques that aren't made of metal, so we'll just consider them signs. Those are made of plastic (default) or wood, not gold.
//See: code>game>objects>structures>signs>_signs.dm

/obj/structure/sign/plaques/kiddie
	name = "\improper AI 开发者纪念牌"
	desc = "在长得离谱的姓名与职务清单旁边，画着一个小孩子。这孩子看起来是残疾的。图像下方，有人刻上了“PACKETS”这个词。"
	icon_state = "kiddieplaque"

/obj/structure/sign/plaques/kiddie/devils_tooth
	name = "\improper 恶魔之牙纪念牌"
	desc = "一块纪念牌，纪念那些为了凿穿这片冰封星球而丧生的亡魂。它之所以叫“恶魔之牙”，是因为那些在此献出生命的人当时想必以为自己身处地狱。"

/obj/structure/sign/plaques/kiddie/badger
	name = "\improper 悼念纪念牌"
	desc = "一块纪念逝者的纪念牌，愿他们安息，在群星之间永远长眠。有人在底部画了一只哭泣的獾。"

/obj/structure/sign/plaques/kiddie/library
	name = "\improper 图书馆规章标牌"
	desc = "一长串在图书馆内需遵守的规则，颂扬时刻保持安静的美德，并威胁那些胆敢在里面吃热食的人。"

/obj/structure/sign/plaques/kiddie/perfect_man
	name = "\improper “完美人”标牌"
	desc = "展品导览，说明纳米传讯公司在心智护盾植入体与克隆技术上的最新进展，如何造就了“完美人”——忠诚的纳米传讯雇员——的诞生及其实际上的永生。"

/obj/structure/sign/plaques/kiddie/perfect_drone
	name = "\improper “完美无人机”标牌"
	desc = "无人机外壳分配器的导览，详述现代维修无人机的建设与破坏用途，以及明日那些不可腐蚀的半机械人仆从的发展——今日即可拥有。"

/obj/structure/sign/plaques/kiddie/gameoflife
	name = "\improper 康威《生命游戏》纪念牌"
	desc = "一块纪念牌，详述《生命游戏》在计算机科学领域的历史意义，并说明脚下的壁画正是该游戏运行过程的呈现。"
