/obj/item/gun/energy/laser
	name = "\improper 5 型激光枪"
	desc = "由纳米传讯研发的 5 型热能投送系统。纳米传讯安保部队的主力装备。"
	icon_state = "laser"
	inhand_icon_state = "laser"
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun)
	shaded_charge = TRUE
	light_color = COLOR_SOFT_RED

/obj/item/gun/energy/laser/Initialize(mapload)
	. = ..()
	// Only regular lasguns can be slapcrafted
	if(type != /obj/item/gun/energy/laser)
		return
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/laser/xraylaser, /datum/crafting_recipe/laser/hellgun, /datum/crafting_recipe/laser/ioncarbine)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/gun/energy/laser/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 18, \
		overlay_y = 12)

/obj/item/gun/energy/laser/pistol
	name = "\improper 5/C 型激光手枪"
	desc = "由纳米传讯研发的 5 型热能投送系统，紧凑型。纳米传讯安保部队的主力装备，但尺寸更便于携带。\
		牺牲了一些停止作用与容量，换来更易携带和更快的充能。"
	icon_state = "laser_pistol"
	w_class = WEIGHT_CLASS_NORMAL
	projectile_damage_multiplier = 0.8
	cell_type = /obj/item/stock_parts/power_store/cell/laser_pistol
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/pistol)

/obj/item/gun/energy/laser/pistol/add_seclight_point()
	return

/obj/item/gun/energy/laser/assault
	name = "\improper 5/A 型突击激光步枪"
	desc = "由纳米传讯研发的 5 型热能投送系统，突击型。纳米传讯安保部队与准军事组织的主力装备。\
		虽然牺牲了一些停止作用和易用性，但其激光系统效率极高，并且具备一定的抗电磁干扰能力。"
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "assault_laser"
	inhand_icon_state = "assault_laser"
	worn_icon_state = "assault_laser"
	slot_flags = ITEM_SLOT_BACK
	burst_size = 2
	fire_delay = 1
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/assault)
	emp_resistance = 2
	weapon_weight = WEAPON_HEAVY
	projectile_speed_multiplier = 1.5
	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/energy/laser/assault/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 18, \
		overlay_y = 30)

/obj/item/gun/energy/laser/practice
	name = "训练激光枪"
	desc = "5 型激光枪的改装版本。发射完全无害的定向能量束。尽情乱射也安全又好玩。"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/practice)
	clumsy_check = FALSE
	item_flags = NONE
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/laser/practice/add_deep_lore()
	return

/obj/item/gun/energy/laser/retro
	name ="\improper 1 型激光枪"
	desc = "由纳米传讯研发的 1 型热能投送系统。纳米传讯的私人安保与军事部队已不再使用。尽管如此，\
		它依然相当致命且易于维护，因此深受海盗和其他亡命之徒喜爱。"
	icon_state = "retro"
	ammo_x_offset = 3

/obj/item/gun/energy/laser/soul
	name ="\improper 3 型激光枪"
	desc = "由纳米传讯研发的 3 型热能投送系统。很可能是纳米传讯有史以来最受欢迎的热能投送系统型号。\
		他们再也造不出从前那样的东西了。"
	icon_state = "laser_soulful"
	inhand_icon_state = "laser_soulful"
	ammo_x_offset = 1

/obj/item/gun/energy/laser/carbine
	name = "\improper 5/R 型激光卡宾枪"
	desc = "由纳米传讯研发的 5/R 型快速热能投送系统，可点射。能持续齐射定向能量弹，不过单发威力不如 5 型。"
	icon_state = "laser_carbine"
	burst_size = 2
	fire_delay = 2
	projectile_damage_multiplier = 0.75
	projectile_speed_multiplier = 1.5
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/carbine)
	weapon_weight = WEAPON_MEDIUM

/obj/item/gun/energy/laser/cybersun
	name = "\improper 赛博太阳 S-120"
	desc = "辛迪加安保警卫主要使用的激光枪。可快速喷射低功率等离子束。"
	icon_state = "cybersun_s120"
	inhand_icon_state = "s120"
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/cybersun)
	spread = 14
	pin = /obj/item/firing_pin/implant/pindicate
	ammo_x_offset = 1

/obj/item/gun/energy/laser/cybersun/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.15 SECONDS, allow_akimbo = FALSE)

/obj/item/gun/energy/laser/cybersun/add_deep_lore()
	return

/obj/item/gun/energy/laser/cybersun/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/energy/laser/carbine/practice
	name = "训练激光卡宾枪"
	desc = "5/R 型激光卡宾枪的改装版本。发射完全无害的定向能量束。尽情乱射也安全又好玩。"
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/carbine/practice)
	clumsy_check = FALSE
	item_flags = NONE
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/laser/carbine/practice/add_deep_lore()
	return

/obj/item/gun/energy/laser/retro/old
	desc = "由纳米传讯研发的 NT 1 型热能投送系统。这一把看起来简直古老得离谱。它到底经历了什么？"
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/old)

/obj/item/gun/energy/laser/retro/old/add_deep_lore()
	return

/obj/item/gun/energy/laser/hellgun
	name = "\improper 4 型“地狱火”激光枪"
	desc = "由纳米传讯研发的 4 型热能投送系统。严格来说，它确实是一种改进。\
		但从法律上讲，在大多数有人居住的星区，持有这种武器都受到限制。\
		4 型以能轻易将受害者变成碳化残骸而臭名昭著，熔化血肉骨骼如同融化黄油。\
		站在这把枪另一端的人，等待着的将是一场痛苦而惨烈的死亡。"
	icon_state = "hellgun"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire)
	ammo_x_offset = 1
	light_color = COLOR_AMMO_HELLFIRE

/obj/item/gun/energy/laser/captain
	name = "古董激光枪"
	desc = "这是一把古董激光枪。所有工艺均属上乘。它装饰着助手皮革与镀铬。\
		这件物品上带着能量尖刺。物品上绘有空间站 13 的图像。空间站正在爆炸。"
	icon_state = "caplaser"
	w_class = WEIGHT_CLASS_NORMAL
	inhand_icon_state = null
	force = 10
	ammo_x_offset = 3
	selfcharge = 1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire)
	light_color = COLOR_AMMO_HELLFIRE

/obj/item/gun/energy/laser/captain/scattershot
	name = "散射激光步枪"
	desc = "一把工业级重型激光步枪，改装过的激光透镜可将其射击散射成多道较小的激光。\
		其内核可自行充能，理论上可无限使用。"
	icon_state = "lasercannon"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "laser"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)
	shaded_charge = FALSE
	ammo_x_offset = 1


/obj/item/gun/energy/laser/captain/scattershot/add_deep_lore()
	return

/obj/item/gun/energy/laser/cyborg
	can_charge = FALSE
	desc = "一种直接从半机械人内部能量电池取电的能量激光枪。原来自由就是这种感觉？"
	use_cyborg_cell = TRUE
	ammo_x_offset = 1

/obj/item/gun/energy/laser/cyborg/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)

/obj/item/gun/energy/laser/cyborg/add_deep_lore()
	return

/obj/item/gun/energy/laser/scatter
	name = "散射激光枪"
	desc = "装有折射套件的激光枪，可将光束扩散开来。"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)
	ammo_x_offset = 1

/obj/item/gun/energy/laser/scatter/add_deep_lore()
	return

/obj/item/gun/energy/laser/scatter/shotty
	name = "能量霰弹枪"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "cshotgun"
	inhand_icon_state = "shotgun"
	desc = "一把被掏空并改装了内置能量发射系统的战斗霰弹枪。可在散射失能弹与电击枪电极之间切换。"
	shaded_charge = FALSE
	pin = /obj/item/firing_pin/implant/mindshield
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/disabler, /obj/item/ammo_casing/energy/electrode)
	automatic_charge_overlays = FALSE
	ammo_x_offset = 1

///Laser Cannon

/obj/item/gun/energy/lasercannon
	name = "加速器激光炮"
	desc = "一门高级激光炮，目标距离越远，造成的伤害越高。"
	icon_state = "lasercannon"
	inhand_icon_state = "laser"
	worn_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/laser/accelerator)
	pin = null
	ammo_x_offset = 3

///X-ray gun

/obj/item/gun/energy/laser/xray
	name = "\improper 6 型 X 射线激光枪"
	desc = "由纳米传讯研发的 6 型热能投送系统。\
		能够发射高度集中的“X 射线”冲击，穿透多个软目标和较厚重的材料。"
	icon_state = "xray"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/xray)
	ammo_x_offset = 3
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	shaded_charge = FALSE
	light_color = LIGHT_COLOR_GREEN

////////Laser Tag////////////////////

/obj/item/gun/energy/laser/bluetag
	name = "激光对抗枪"
	icon_state = "bluetag"
	desc = "一把改装过的复古激光枪，可发射无害的蓝色光束。附音效！"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag)
	item_flags = NONE
	clumsy_check = FALSE
	pin = /obj/item/firing_pin/tag/blue
	ammo_x_offset = 2
	selfcharge = TRUE
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/laser/bluetag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag/hitscan)

/obj/item/gun/energy/laser/bluetag/add_deep_lore()
	return

/obj/item/gun/energy/laser/redtag
	name = "激光对抗枪"
	icon_state = "redtag"
	desc = "一把改装过的复古激光枪，可发射无害的红色光束。附音效！"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag)
	item_flags = NONE
	clumsy_check = FALSE
	pin = /obj/item/firing_pin/tag/red
	ammo_x_offset = 2
	selfcharge = TRUE
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/laser/redtag/add_deep_lore()
	return

/obj/item/gun/energy/laser/redtag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag/hitscan)

// luxury shuttle funnies
/obj/item/firing_pin/paywall/luxury
	multi_payment = TRUE
	payment_amount = 20

/obj/item/gun/energy/laser/luxurypaywall
	name = "奢华激光枪"
	desc = "一把改装过的激光枪，每开一枪要花费 20 信用点。把枪口对准穷人吧。"
	pin = /obj/item/firing_pin/paywall/luxury

// The Deep Lore //

// Laser Gun

/obj/item/gun/energy/laser/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以 [EXAMINE_HINT("仔细观察")] 来进一步了解 [src]。"), \
		lore = "NT 5 型热能投送系统（在宣传材料中有时被称为 HDS-5）正是让纳米传讯在现代\
		远远超越大多数武器制造商的东西。该公司提供的所有现代能量武器，都要感谢\
		5 型的成功为其树立了能量武器平台的标准。<br>\
		<br>\
		它被采纳为纳米传讯军事力量的标准步兵枪械，也被用作私人安保的致命武器。几乎无人能否认\
		这把武器的可靠性，而且价格还十分亲民！<br>\
		<br>\
		然而，该武器平台仍然保留了以往能量武器的许多弱点。机载电源\
		无法在不严重损害武器散热器热分布的前提下，充分屏蔽可能干扰武器功能的外部电磁脉冲。\
		从未获得广泛采用的 4 型，至今仍是纳米传讯武器部门心中挥之不去的\
		警示：当热能投送系统无法安全排出热量时，后果会有多严重。<br>\
		<br>\
		当然，加尔法 5 号“熔化老兵”权益组织永远不会让他们忘记这件事。" \
	)

// Retro Laser Gun

/obj/item/gun/energy/laser/retro/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以 [EXAMINE_HINT("仔细观察")] 来进一步了解 [src]。"), \
		lore = "NT 1 型热能投送系统（在较老的武器目录中有时被称为 HDS-1）是一款\
		标志着枪械发展新时代开端的武器。<br>\
		<br>\
		它于 24 世纪末由纳米传讯武器研发团队的智囊实验室发明，一经上市，\
		便被争夺边疆控制权的各方势力与军事实体广泛采用。那些在这些冲突中\
		站稳脚跟的人，其标志之一就是把 1 型采纳为标准步兵\
		武器。维持 HDS-1 处于最佳作战状态所需的补给量极低，大多数军需官只需把半打这种\
		武器丢给嗜血的海军陆战队员，便深知这些武器足够坚固，能承受任何\
		砸向它们的东西，打空之后只需要一个带电源的充电站就能重新投入使用。<br>\
		<br>\
		如今这类武器存世量极大，甚至现代冲突中 HDS-1 的使用量也可能超过纳米传讯现代作战部队\
		所装备的、经过升级且同样可靠的 HDS5。纳米传讯尽管竭尽全力，仍未能\
		说服潜在客户换购新型号，哪怕给出了慷慨的换购折扣。" \
	)

// Soulful Laser Gun

/obj/item/gun/energy/laser/soul/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以 [EXAMINE_HINT("仔细观察")] 来进一步了解 [src]。"), \
		lore = "NT 3 型热能投送系统（在安保人员的记忆中有时被称为 HDS-3）很可能是\
		市面上仍在流通的最常见热能投送系统。它备受喜爱，不少死忠粉丝至今仍紧握着自己的\
		3 型，仿佛性命全靠它，这把武器也以“什么都能干的枪”在历史上占据一席之地。<br>\
		<br>\
		3 型系列畅销了数十年，纳米传讯才终于动念要替换它。人们想到\
		“激光枪”时，通常想到的就是 3 型。<br>\
		<br>\
		当纳米传讯宣布其替代型号 4 型时，怀疑者们迅速抨击这把武器，称它缺少 3 型用户\
		多年来享有的多项显著功能。事实证明，大多数批评者最终都被证明是对的——\
		“加尔法 5 号”事件以及 4 型不稳定本质带来的可怕后果被公之于众。大多数人坚守 3 型，从未\
		回头，即使 5 型推出后本身也取得了相当大的成功。<br>\
		<br>\
		纳米传讯仍在维护 3 型，其使用的许多零件与 5 型共享兼容的同类件。如今大多数\
		3 型实例在功能和外形上可能反而比它们最初\
		制造时更接近 5 型，具体取决于保养频率。" \
	)

// hellfire laser gun

/obj/item/gun/energy/laser/hellgun/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以 [EXAMINE_HINT("仔细观察")] 来进一步了解 [src]。"), \
		lore = "NT 4 型热能投送系统（在法律文书中有时被称为 HDS-4）被视为纳米传讯武器研发团队\
		“飞得离太阳太近”的著名例证。<br>\
		<br>\
		3 型的成功让股东们催促营销部门推出能量武器中的“下一款最佳产品”。\
		当时，纳米传讯武器部门有一个仍在研发中的原型，并吸取了\
		在测试中多次发生灾难性故障、容易出问题的 2 型的近期教训。\
		然而，研究人员中有人提出了关于“道德影响”的担忧——\
		把“那么多定向放射性物质”倾泻到活体身上可能造成怎样的后果。\
		当时的高管对这些担忧不以为然，因为有钱可赚，还有早已超级富有的股东等着瓜分收益。<br>\
		<br>\
		4 型在接下来的一个季度内就被仓促推向市场，甚至还没等大多数常规安全机制得到充分测试和落实。\
		随即，关于可怕的意外走火、战场暴行以及意外自燃的报告如潮水般涌来——\
		原因正是过量暴露于未经测试的实验性热分布系统，在为它“释放的地狱”索取“一磅血肉”。<br>\
		<br>\
		新闻媒体和小报纷纷抨击该公司制造了如今被称为“地狱火”的激光枪。作为回应，大多数\
		法律机构迅速在本星区内禁售该枪械，这把武器也因其不道德的终结\
		智慧生命的方式而臭名昭著。法律被通过，要求纳米传讯今后销售的所有能量武器都必须安装功率调节器。纳米传讯迅速\
		停产了 4 型作为回应，此后它再未投入生产。然而，改装套件仍然存在\
		于黑市以及纳米传讯自己的部分仓库中。虽然从法律上讲，销售和持有 4 型都是非法的，但纳米传讯本身\
		并不管制其自有空间站内对该枪械的持有，任何法律机构也不打算阻止他们将其用于保卫\
		自身资产。" \
	)

// Antique Laser Gun

/obj/item/gun/energy/laser/captain/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以 [EXAMINE_HINT("仔细观察")] 来进一步了解 [src]。"), \
		lore = "曾有一小段时间，纳米传讯为一小群特定客户定制生产了一系列 4 型激光枪，\
		这些客户主要是富有的星舰舰长、政客和军方领袖，他们想在平民面前\
		炫耀威望。<br>\
		<br>\
		4 型在商业上是失败的，但这一特定变体却为自己赢得了恶名，与那些疯狂\
		暴君用它铲除政敌和异见者的故事、以及疯狂将军冲在部队前方、\
		手臂前伸、把发热的武器指向战场上任何能找到的活动目标的故事\
		联系在一起。<br>\
		<br>\
		如今在太阳联邦境内，该枪械的复制品已被禁止，任何缴获品都会被迅速销毁。\
		这很大程度上就是纳米传讯<b>坚持</b>要求高级军官持有的样品必须锁在保险柜里的原因。\
		关于 4 型此变体设计图的所有记录都已被收缴销毁，其背后的创造者\
		被关押在太阳联邦最高安全级别的疗养院中。当他们再次找到她时，她似乎用自己的\
		血涂满了墙壁，声称“她”就要来了，而自己为获得制造这把武器的知识付出了惨痛的代价。<br>\
		<br>\
		就连武器内部装设的微聚变增殖电池也几乎成了失传的技术，纳米传讯一直无法\
		逆向工程出该装置的确切运作方式。<br>\
		<br>\
		辛迪加显然同样想知道这把武器究竟如何自我维持，因此这个集团\
		才如此不遗余力地伺机夺取它们。也许该把这东西放在安全的地方。或者别放。" \
	)

// X-ray Laser Gun

/obj/item/gun/energy/laser/xray/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以 [EXAMINE_HINT("仔细观察")] 来进一步了解 [src]。"), \
		lore = "NT 6 型热能投送系统（在研究笔记中有时被称为 HDS6）是单兵便携式定向能武器\
		发展史上的一项突破。<br>\
		<br>\
		人们对 6 型知之甚少，因为它是相对较新的实验性武器，仅限纳米传讯安保部队使用。\
		不知怎的，纳米传讯找到了一种方法，能让 6 型产生的能量束“滑过”非预期目标，只有在\
		接触武器使用者预先指定的目标时才会产生作用。它似乎无法可靠地滑过有机物，\
		这削弱了它消除误伤的能力。不过，无机目标不会受到伤害，除非武器被有意\
		瞄准该物体开火。这使得该武器在资产回收、防守坚固阵地和攻坚防御工事方面表现卓越。<br>\
		<br>\
		纳米传讯声称这一现象是“通过 X 射线的力量”实现的。大多数批评者指出这纯属胡说。有人声称\
		纳米传讯发现了一种尚不为人知的物质状态，并正利用它进行武器研发和制造。纳米传讯批评者中\
		最热衷于阴谋论的人甚至宣称，这是“灵质作为第六元素的证据”，\
		甚至可能让武器借助超自然手段运作：也许是由“受诅咒者的灵魂”驱动的。<br>\
		<br>\
		无论真相如何，这把武器似乎如宣传那般运作，而且比 5 型更节能。纳米传讯\
		预计将在下一季度的某个时候全面投入商业发售。" \
	)

// Laser Carbine

/obj/item/gun/energy/laser/carbine/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以 [EXAMINE_HINT("仔细观察")] 来进一步了解 [src]。"), \
		lore = "NT 5/R 型快速热能投送系统（在简报手册中有时被称为 HDS-5/R，在 TGMC 士兵口中则被叫作\
		“那坨狗屎手电筒”）是迈向自动定向能武器的蹒跚第一步。<br>\
		<br>\
		5/R 型原本打算用于特种作战，尤其是交到轨道空降突击部队手中，曾被预见会成为纳米传讯\
		向占领区各军事力量提供的装备库中的出色一员。然而，实战表现却十分惨淡。<br>\
		<br>\
		定向能武器的优势在于，它给后勤军官和军需官带来的供应链压力很轻，因为武器\
		唯一必需的后勤保障就是稳定的电力供应（无论是既有的还是前线带来的），再加上偶尔的清洁。<br>\
		<br>\
		然而，在敌后行动或战术部署中的士兵却无法利用这一优势。结果，\
		与常规弹道枪械相比，操作者常常对有限的弹药供应感到不满，这把武器很快就被\
		大多数特种部队弃用。<br>\
		<br>\
		相反，这把武器在私人安保团队中受到了青睐，他们喜欢它提供的火力密度，同时\
		即使在远距离也能保持出色的精度，而且相比全尺寸步枪足够紧凑，能实现高度的隐蔽性。\
		这把武器也常被边缘星区的海盗和掠夺者使用，因而名声不佳。" \
	)
