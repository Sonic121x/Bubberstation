// Nuclear Operative Weapons and Ammunition

/datum/uplink_category/weapon_kits
	name = "武器套件（推荐）"
	weight = 30

/datum/uplink_item/weapon_kits
	category = /datum/uplink_category/weapon_kits
	surplus = 40
	purchasable_from = UPLINK_SERIOUS_OPS

// ~~ Ammunition Categories ~~

/datum/uplink_category/ammo_nuclear
	name = "额外与特殊弹药"
	weight = 29

/datum/uplink_item/ammo_nuclear
	category = /datum/uplink_category/ammo_nuclear
	surplus = 40
	purchasable_from = UPLINK_SERIOUS_OPS

// Basic: Run of the mill ammunition for various firearms
/datum/uplink_item/ammo_nuclear/basic
	cost = 2

// Armor Penetrating: strong into armor, low damage
/datum/uplink_item/ammo_nuclear/ap
	cost = 4

// Hollow Point: weak into armor, high damage
/datum/uplink_item/ammo_nuclear/hp
	cost = 4

// Incendiary: sets target on fire, does less damage
/datum/uplink_item/ammo_nuclear/incendiary
	cost = 3

// Special: does something particularly extra than just any of the above
/datum/uplink_item/ammo_nuclear/special
	cost = 5

// ~~ Weapon Categories ~~

// Core Gear Box: This contains all the 'fundamental' equipment that most nuclear operatives probably should be buying. It isn't cheaper, but it is a quick and convenient method of acquiring all the gear necessary immediately.
// Only allows one purchase, and doesn't prevent the purchase of the contained items. Focused on newer players to help them understand what items they need to succeed, and to help older players quickly purchase the baseline gear they need.

/datum/uplink_item/weapon_kits/core
	name = "核心装备箱（必备）"
	desc = "这个箱子包含一张气闸门禁覆盖卡、一个 MOD 外骨骼能量护盾模块、一枚 C-4 爆破装药、一个自由植入体以及一支兴奋剂注射器。 \
		大多数特工完成任务最重要的支援物品，一次打包。强烈建议你购买这套装备。 \
		注意：此组合包并未打折。所有物品都可以单独购买。你并非“必需”这些物品，但大多数特工若是缺少其中 \
		至少“部分”物品就会失败。经验丰富的特工可以不用这些。"
	item = /obj/item/storage/box/syndie_kit/core_gear
	//The cost for the core kit is always equivalent to the combined costs of the included items
	cost = (/datum/uplink_item/device_tools/doorjack::cost + /datum/uplink_item/implants/freedom::cost + /datum/uplink_item/explosives/c4::cost + /datum/uplink_item/device_tools/stimpack::cost +	/datum/uplink_item/suits/energy_shield::cost)
	limited_stock = 1
	cant_discount = TRUE
	purchasable_from = UPLINK_SERIOUS_OPS

//Low-cost firearms: Around 8 TC each. Meant for easy squad weapon purchases

/datum/uplink_item/weapon_kits/low_cost
	cost = 8
	surplus = 40
	purchasable_from = UPLINK_SERIOUS_OPS

// ~~ Bulldog Shotgun ~~

/datum/uplink_item/weapon_kits/low_cost/shotgun
	name = "斗牛犬霰弹枪箱（中等）"
	desc = "一把装满弹的 2 发点射弹鼓供弹霰弹枪，另附一个可热插拔的备用弹鼓。枪身上贴着便利的说明标签。 \
		兼容所有 12 号霰弹。专为近距离反人员交战设计。附三个备用弹鼓。"
	item = /obj/item/storage/toolbox/guncase/bulldog
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/basic/buck,
		/datum/uplink_item/ammo_nuclear/basic/donk,
		/datum/uplink_item/ammo_nuclear/basic/flechette,
		/datum/uplink_item/ammo_nuclear/basic/slug,
		/datum/uplink_item/ammo_nuclear/incendiary/dragon,
		/datum/uplink_item/ammo_nuclear/special/meteor,
		/datum/uplink_item/spy_unique/shotgun_ammo,
		/datum/uplink_item/spy_unique/shotgun_ammo/breacher_slug,
		/datum/uplink_item/spy_unique/shotgun_ammo/slugs,
	)

/datum/uplink_item/ammo_nuclear/basic/buck
	name = "12 号鹿弹弹鼓（斗牛犬）"
	desc = "一个 8 发装鹿弹弹鼓，用于斗牛犬霰弹枪。请将正面朝向敌人。"
	item = /obj/item/ammo_box/magazine/m12g
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

/datum/uplink_item/ammo_nuclear/basic/slug
	name = "12 号独头弹弹鼓（斗牛犬）"
	desc = "一个 8 发装独头弹弹鼓，用于斗牛犬霰弹枪。 \
		现在打中同伴的概率降低了 8 倍。"
	item = /obj/item/ammo_box/magazine/m12g/slug
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

/datum/uplink_item/ammo_nuclear/basic/flechette
	name = "12 号箭弹（斗牛犬）"
	desc = "一种 8 发装箭弹弹鼓，可用于斗牛犬霰弹枪。 \
		被护甲挡住了？为什么不试试箭弹？把血肉和凯夫拉一起撕成碎片！"
	item = /obj/item/ammo_box/magazine/m12g/flechette
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

/datum/uplink_item/ammo_nuclear/basic/donk
	name = "12 号咚克公司“咚克尖刺”箭弹弹匣箱（斗牛犬）"
	desc = "整整一箱 8 发装咚克公司“咚克尖刺”箭弹弹匣，可用于 \
		斗牛犬霰弹枪。由咚克公司赞助！买一次就能得到一整箱这样的弹匣！ \
		警告：请勿嗅闻弹匣！"
	item = /obj/item/storage/box/syndie_kit/shotgun_surplus
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

/datum/uplink_item/ammo_nuclear/incendiary/dragon
	name = "12 号龙息弹弹鼓（斗牛犬）"
	desc = "一种 8 发装龙息弹弹鼓，可用于斗牛犬霰弹枪。 \
		“我是纵火狂，扭曲的纵火狂！”"
	item = /obj/item/ammo_box/magazine/m12g/dragon
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

/datum/uplink_item/ammo_nuclear/special/meteor
	name = "12 号陨石独头弹（斗牛犬）"
	desc = "一种 8 发装陨石独头弹弹鼓，可用于斗牛犬霰弹枪。 \
		非常适合在船体上轰出大洞并击倒敌人。"
	item = /obj/item/ammo_box/magazine/m12g/meteor
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

// ~~ Ansem Pistol ~~

/datum/uplink_item/weapon_kits/low_cost/clandestine
	name = "安瑟姆手枪箱（简单／备用）"
	desc = "一把小巧、易于隐藏的手枪，使用 10 毫米自动手枪弹，弹匣容量 8 发，并且兼容 \
			消音器。附三个备用弹匣。"
	item = /obj/item/storage/toolbox/guncase/clandestine
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/basic/m10mm,
		/datum/uplink_item/ammo_nuclear/ap/m10mm,
		/datum/uplink_item/ammo_nuclear/hp/m10mm,
		/datum/uplink_item/ammo_nuclear/incendiary/m10mm,
	)

/datum/uplink_item/ammo_nuclear/basic/m10mm
	name = "10 毫米手枪弹匣（安瑟姆）"
	desc = "一个 8 发装 10 毫米备用弹匣，适用于安瑟姆手枪。"
	item = /obj/item/ammo_box/magazine/m10mm
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

/datum/uplink_item/ammo_nuclear/ap/m10mm
	name = "10 毫米穿甲弹匣（安瑟姆）"
	desc = "一个 8 发装 10 毫米备用弹匣，适用于安瑟姆手枪。 \
		这些子弹对目标的杀伤效果较差，但能穿透防护装备。"
	item = /obj/item/ammo_box/magazine/m10mm/ap
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

/datum/uplink_item/ammo_nuclear/hp/m10mm
	name = "10 毫米空尖弹匣（安瑟姆）"
	desc = "一个 8 发装 10 毫米备用弹匣，适用于安瑟姆手枪。 \
		这些子弹杀伤力更强，但对护甲无效。"
	item = /obj/item/ammo_box/magazine/m10mm/hp
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

/datum/uplink_item/ammo_nuclear/incendiary/m10mm
	name = "10 毫米燃烧弹匣（安瑟姆）"
	desc = "一个 8 发装 10 毫米备用弹匣，适用于安瑟姆手枪。 \
		装有燃烧弹，造成的伤害较低，但会点燃目标。"
	item = /obj/item/ammo_box/magazine/m10mm/fire
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

//Medium-cost: 14 TC each. Meant for more expensive purchases with a goal in mind.

/datum/uplink_item/weapon_kits/medium_cost
	cost = 14
	surplus = 20
	purchasable_from = UPLINK_SERIOUS_OPS

// ~~ C-20r Submachine Gun ~~

/datum/uplink_item/weapon_kits/medium_cost/smg
	name = "C-20r 冲锋枪箱（简单）"
	desc = "一把装满弹的斯卡伯勒军火公司犊牛式冲锋枪。C-20r 发射 .45 子弹， \
		弹匣容量 24 发，并兼容消音器。附三个备用弹匣。"
	item = /obj/item/storage/toolbox/guncase/c20r
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/ap/smg,
		/datum/uplink_item/ammo_nuclear/basic/smg,
		/datum/uplink_item/ammo_nuclear/hp/smg,
		/datum/uplink_item/ammo_nuclear/incendiary/smg,
	)

/datum/uplink_item/ammo_nuclear/basic/smg
	name = ".45 冲锋枪弹匣（C-20r）"
	desc = "一个 24 发装 .45 备用弹匣，适用于 C-20r 冲锋枪。"
	item = /obj/item/ammo_box/magazine/smgm45

/datum/uplink_item/ammo_nuclear/ap/smg
	name = ".45 穿甲冲锋枪弹匣（C-20r）"
	desc = "一个 24 发装 .45 备用弹匣，适用于 C-20r 冲锋枪。\
		这些子弹对目标的杀伤效果较差，但能穿透防护装备。"
	item = /obj/item/ammo_box/magazine/smgm45/ap

/datum/uplink_item/ammo_nuclear/hp/smg
	name = ".45 空尖冲锋枪弹匣（C-20r）"
	desc = "一个 24 发装 .45 备用弹匣，适用于 C-20r 冲锋枪。\
		这些子弹杀伤力更强，但对护甲无效。"
	item = /obj/item/ammo_box/magazine/smgm45/hp

/datum/uplink_item/ammo_nuclear/incendiary/smg
	name = ".45 燃烧冲锋枪弹匣（C-20r）"
	desc = "一个 24 发装 .45 备用弹匣，适用于 C-20r 冲锋枪。\
		装有燃烧弹，造成的伤害较低，但会点燃目标。"
	item = /obj/item/ammo_box/magazine/smgm45/incen
	cost = 4
	purchasable_from = UPLINK_SERIOUS_OPS

// ~~ Energy Sword and Shield & CQC ~~

/datum/uplink_item/weapon_kits/medium_cost/sword_and_board
	name = "能量盾与能量剑箱（极难）"
	desc = "一个内装能量剑和能量盾的箱子。两者搭配使用时，能在不牺牲致命威力的前提下提供可观的防御力。 \
		非常适合有进取心的核爆骑士。附赠一顶给你的 MOD 外骨骼用的中世纪头盔！"
	item = /obj/item/storage/toolbox/guncase/sword_and_board

/datum/uplink_item/weapon_kits/medium_cost/cqc
	name = "近身格斗术装备箱（极难）"
	desc = "内含一本教你近身格斗术（CQC）的手册。附赠一个隐匿植入体、一包香烟和一条时髦的头巾（可搭配 MOD 外骨骼的帽子稳定器使用）。"
	item = /obj/item/storage/toolbox/guncase/cqc
	purchasable_from = UPLINK_ALL_SYNDIE_OPS
	surplus = 0

// ~~ Syndicate Revolver ~~
// Nuclear operatives get a special deal on their revolver purchase compared to traitors.

/datum/uplink_item/weapon_kits/medium_cost/revolvercase
	name = "辛迪加左轮手枪箱（中等）"
	desc = "华夫公司现代化改造的辛迪加左轮手枪。可发射 7 发残暴的 .357 马格南子弹。 \
		经典的特工武器，为现代时代而改良。附 3 个额外的 .357 速装器。"
	item = /obj/item/storage/toolbox/guncase/revolver
	relevant_child_items = list(
		/datum/uplink_item/ammo/revolver,
		/datum/uplink_item/ammo_nuclear/basic/revolver,
		/datum/uplink_item/ammo_nuclear/special/revolver/phasic,
		/datum/uplink_item/ammo_nuclear/special/revolver/heartseeker,
	)

/datum/uplink_item/ammo_nuclear/basic/revolver
	name = ".357 速装器（左轮手枪）"
	desc = "一个装有七发 .357 马格南子弹的速装器，可用于辛迪加左轮手枪。 \
		适用于你确实需要让很多东西死掉的时候。与外勤特工不同，行动特工买速装器可是要付上溢价！"
	item = /obj/item/ammo_box/speedloader/c357
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

/datum/uplink_item/ammo_nuclear/special/revolver/phasic
	name = ".357 相位速装器（左轮手枪）"
	desc = "一个装有七发 .357 马格南相位弹的速装器，可用于辛迪加左轮手枪。 \
		这些子弹由一种名为“幽灵铅”的实验性合金制成，几乎能穿透任何非有机材料。 \
		这名字其实名不副实，它根本不含任何铅！"
	item = /obj/item/ammo_box/speedloader/c357/phasic
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

/datum/uplink_item/ammo_nuclear/special/revolver/heartseeker
	name = ".357 追心速装器（左轮手枪）"
	desc = "一个装有七发 .357 马格南追心弹的速装器，可用于辛迪加左轮手枪。 \
		能让子弹径直拐向目标！用追心弹绝不失手！正如纳米传讯影视热门恐怖太空西部片《勿忘我》中所见！	\
		由玫瑰银河公司呈献！"
	item = /obj/item/ammo_box/speedloader/c357/heartseeker
	cost = 3
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY

// ~~ Grenade Launcher ~~
// 'If god had wanted you to live, he would not have created ME!'

/datum/uplink_item/weapon_kits/medium_cost/rawketlawnchair
	name = "Dardo-RE 火箭推进榴弹发射器（困难）"
	desc = "一把可重复使用的火箭推进榴弹发射器，预装一发低当量 84 毫米高爆弹。 \
		保证让你的目标“轰”然倒下，否则退钱！附赠一束额外火箭弹！"
	item = /obj/item/storage/toolbox/guncase/rocketlauncher
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/ap/rocket,
		/datum/uplink_item/ammo_nuclear/basic/rocket,
	)

/datum/uplink_item/ammo_nuclear/basic/rocket
	name = "84 毫米高爆火箭弹束（火箭发射器）"
	desc = "三发低当量反人员高爆火箭弹，捆成一束。保证让你退场得很有型！"
	item = /obj/item/ammo_box/rocket

/datum/uplink_item/ammo_nuclear/ap/rocket
	name = "84 毫米高爆穿甲火箭弹（火箭发射器）"
	desc = "一发高当量高爆穿甲火箭弹；对一切、以及那东西附近任何已不复存在的东西都极其有效。 \
			让你的敌人心中充满恐惧。"
	item = /obj/item/ammo_casing/rocket/heap

//High-cost: 18 TC each. Really should only be coming out during war for how powerful it is, or be the majority of your TC outside of war.

/datum/uplink_item/weapon_kits/high_cost
	cost = 18
	surplus = 10
	purchasable_from = UPLINK_SERIOUS_OPS

// ~~ L6 SAW Machine Gun ~~

/datum/uplink_item/weapon_kits/high_cost/machinegun
	name = "L6 班用自动武器（中等）"
	desc = "一把装满弹的斯卡伯勒军火公司弹链供弹机枪。 \
			这件致命武器配有一个 50 发弹箱，发射 7.12x82mm 弹药。" //SKYRAT EDIT - AUSSEC TO SCARBOROUGH
	item = /obj/item/gun/ballistic/automatic/l6_saw
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/ap/machinegun,
		/datum/uplink_item/ammo_nuclear/basic/machinegun,
		/datum/uplink_item/ammo_nuclear/hp/machinegun,
		/datum/uplink_item/ammo_nuclear/incendiary/machinegun,
		/datum/uplink_item/ammo_nuclear/special/machinegun,
	)

/datum/uplink_item/ammo_nuclear/basic/machinegun
	name = "7 毫米弹箱（L6 SAW）"
	desc = "一个 50 发装 7 毫米弹箱，适用于 L6 SAW。 \
		等你要用上它的时候，你早就站在一堆尸体上了。"
	item = /obj/item/ammo_box/magazine/m7mm

/datum/uplink_item/ammo_nuclear/ap/machinegun
	name = "7 毫米（穿甲）弹箱（L6 SAW）"
	desc = "一个 50 发装 7 毫米弹箱，用于 L6 SAW；装填有特殊属性弹药， \
		能击穿最坚固的护甲。"
	item = /obj/item/ammo_box/magazine/m7mm/ap

/datum/uplink_item/ammo_nuclear/hp/machinegun
	name = "7 毫米（空尖）弹箱（L6 SAW）"
	desc = "一个 50 发装 7 毫米弹箱，用于 L6 SAW；配有空尖弹头，方便 \
		对付那些没穿护甲的船员。"
	item = /obj/item/ammo_box/magazine/m7mm/hollow

/datum/uplink_item/ammo_nuclear/incendiary/machinegun
	name = "7 毫米（燃烧）弹箱（L6 SAW）"
	desc = "一个 50 发装 7 毫米弹箱，用于 L6 SAW；弹头涂有特殊易燃混合剂， \
		被子弹击中的任何人都会着火。有些人就是想看着世界燃烧。"
	item = /obj/item/ammo_box/magazine/m7mm/incen

/datum/uplink_item/ammo_nuclear/special/machinegun
	name = "7 毫米（比赛级）弹箱（L6 SAW）"
	desc = "一个 50 发装 7 毫米弹箱，用于 L6 SAW；你原来不知道比赛级 \
		精密“子弹喷水枪”弹药也有市场，但这些子弹经过精细调校，非常适合漂亮地从墙上弹射。"
	item = /obj/item/ammo_box/magazine/m7mm/match

// ~~ M-90gl Carbine ~~

/datum/uplink_item/weapon_kits/high_cost/carbine
	name = "M-90gl 卡宾枪箱（困难）"
	desc = "一把装满弹的专用三发点射卡宾枪，使用 30 发弹匣发射 .223 弹药。\
		下挂一具 40 毫米榴弹发射器。用次要开火模式发射榴弹发射器。另附两个备用弹匣 \
		和一盒 40 毫米橡胶弹丸。"
	item = /obj/item/storage/toolbox/guncase/m90gl
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/basic/carbine,
		/datum/uplink_item/ammo_nuclear/special/carbine,
		/datum/uplink_item/ammo_nuclear/basic/a40mm,
		/datum/uplink_item/ammo_nuclear/basic/a40mm/rubber,
		/datum/uplink_item/ammo_nuclear/ap/a40mm,
	)

/datum/uplink_item/ammo_nuclear/basic/carbine
	name = ".223 顶装弹匣（M-90gl）"
	desc = "一个 30 发装 .223 备用弹匣，适用于 M-90gl 卡宾枪。 \
		这些子弹的威力不如 7 毫米弹，但凭借固有的穿甲能力，仍比 .45 弹药更有力。"
	item = /obj/item/ammo_box/magazine/m223

/datum/uplink_item/ammo_nuclear/special/carbine
	name = ".223 顶装相位弹匣（M-90gl）"
	desc = "一个 30 发装 .223 备用弹匣，适用于 M-90gl 卡宾枪。 \
		这些子弹由一种名为“幽灵铅”的实验性合金制成，几乎能穿透任何非有机材料。 \
		这名字其实名不副实，它根本不含任何铅！"
	item = /obj/item/ammo_box/magazine/m223/phasic

// ~~ Anti-Materiel Sniper Rifle ~~

/datum/uplink_item/weapon_kits/high_cost/sniper
	name = "反器材狙击步枪公文包（困难）"
	desc = "一把虽然过时、但依然极其强大的反器材狙击步枪。使用 6 发弹匣发射 .50 BMG 弹药。 \
		可安装消音器。如果有人问这怎么可能，就告诉他是纳米传讯的错。附 \
		3 个备用弹匣：2 个普通弹匣和 1 个干扰弹匣。还附赠一套西装和领带。"
	item = /obj/item/storage/briefcase/sniper
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/ap/sniper/penetrator,
		/datum/uplink_item/ammo_nuclear/basic/sniper,
		/datum/uplink_item/ammo_nuclear/basic/sniper/disruptor,
		/datum/uplink_item/ammo_nuclear/incendiary/sniper,
		/datum/uplink_item/ammo_nuclear/special/sniper/marksman,
	)

/datum/uplink_item/ammo_nuclear/basic/sniper
	name = ".50 BMG 弹匣（AMSR）"
	desc = "一个 6 发装标准备用弹匣，适用于 .50 狙击步枪。"
	item = /obj/item/ammo_box/magazine/sniper_rounds

/datum/uplink_item/ammo_nuclear/basic/sniper/surplussniper
	name = ".50 BMG 军剩弹匣箱（AMSR）"
	desc = "一整箱军剩 .50 BMG 弹匣。不如高品质弹匣， \
		通常缺少穿透力和冲击力，但足够让枪继续开火。 \
		适合给一整队人配发。"
	cost = 7 //1 TC per magazine, special price for a special deal!
	item = /obj/item/storage/box/syndie_kit/sniper_surplus

/datum/uplink_item/ammo_nuclear/ap/sniper/penetrator
	name = ".50 BMG 穿甲弹匣（AMSR）"
	desc = "一个 6 发装穿甲弹匣，专为 .50 狙击步枪设计。 \
		可以击穿墙壁和多个敌人。"
	item = /obj/item/ammo_box/magazine/sniper_rounds/penetrator

/datum/uplink_item/ammo_nuclear/incendiary/sniper
	name = ".50 BMG 燃烧弹匣（AMSR）"
	desc = "一个 6 发装燃烧弹匣。 \
		让你的敌人以及他们旁边的所有人一起着火！"
	item = /obj/item/ammo_box/magazine/sniper_rounds/incendiary

/datum/uplink_item/ammo_nuclear/basic/sniper/disruptor
	name = ".50 BMG 干扰弹匣（AMSR）"
	desc = "一个 6 发装干扰弹匣，专为 .50 狙击步枪设计。 \
		今天就让你的敌人和他们的闹钟一起睡去吧！"
	item = /obj/item/ammo_box/magazine/sniper_rounds/disruptor

/datum/uplink_item/ammo_nuclear/special/sniper/marksman
	name = ".50 BMG 射手弹匣（AMSR）"
	desc = "一个 6 发装射手弹匣，专为 .50 狙击步枪设计。 \
		用瞬间命中的射击轰爆敌人！只是要当心反弹……"
	item = /obj/item/ammo_box/magazine/sniper_rounds/marksman

/datum/uplink_item/weapon_kits/high_cost/doublesword
	name = "双刃能量剑箱（极难）"
	desc = "一个装有双刃能量剑、防滑模块、甲基苯丙胺自动注射器和一块肥皂的箱子。 \
		有人说最臭名昭著的核爆特工就是用这套装备屠杀了数百名 \
		纳米传讯员工。不过也有人说这是猛虎合作社的夸张宣传。 \
		大部分活儿其实是肥皂干的。附赠一套囚服，好让你更入戏。"
	item = /obj/item/storage/toolbox/guncase/doublesword

//Meme weapons: Literally just weapons used as a joke, shouldn't be particularly expensive.

/datum/uplink_item/weapon_kits/surplus_smg
	name = "军剩智能冲锋枪（侥幸）"
	desc = "一把失败的实验性“智能枪”。使用 .160 火箭推进弹导致停止作用下降， \
		但只要射手大致朝目标瞄准，整体精度就会提高。 \
		荒谬的后坐力带来的操作负担相对增加，与宣传中的优势相矛盾，导致市场表现惨淡。不过， \
		仍有大量存货躺在安保松懈的仓库里。所以我们把它们拿来了。现在你可以拥有它们， \
		如果你真的想要的话。我只想说：祝你好运。"
	item = /obj/item/gun/ballistic/automatic/smartgun
	cost = 2
	purchasable_from = UPLINK_SERIOUS_OPS
	relevant_child_items = list(
		/datum/uplink_item/ammo_nuclear/surplus_smg,
	)

/datum/uplink_item/ammo_nuclear/surplus_smg
	name = "军剩智能冲锋枪弹匣（智能冲锋枪）"
	desc = "一个大容量弹匣，供阿比耶尔智能冲锋枪使用。"
	item = /obj/item/ammo_box/magazine/smartgun
	cost = 1
	purchasable_from = UPLINK_SERIOUS_OPS
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

// Explosives and Grenades
// ~~ Grenades ~~

/datum/uplink_item/explosives/military_grade
	cost = 15
	surplus = 35
	purchasable_from = UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/explosives/military_grade/buzzkill
	name = "扫兴蜂手榴弹盒"
	desc = "一盒三枚手榴弹，激活后会释放一群愤怒的蜜蜂。这些蜜蜂不分敌我，用随机的毒素 \
		攻击周围一切。由 BLF 与猛虎合作社提供。"
	item = /obj/item/storage/box/syndie_kit/bee_grenades

/datum/uplink_item/explosives/military_grade/virus_grenade
	name = "真菌性结核手榴弹盒"
	desc = "一枚装在小巧盒子里的待发生化手榴弹。附五支生化病毒解毒套件（BVAK） \
		自动注射器，每支最多可快速用于两名目标，一支注射器，以及一瓶 \
		含 BVAK 溶液的药剂。"
	item = /obj/item/storage/box/syndie_kit/tuberculosisgrenade
	restricted = TRUE

/datum/uplink_item/explosives/military_grade/viscerators
	name = "撕裂者投放手榴弹盒"
	desc = "一盒特殊手榴弹，激活后会部署一群撕裂者，它们会追杀并撕碎 \
		区域内任何非行动特工的人。"
	item = /obj/item/storage/box/syndie_kit/manhack_grenades

/datum/uplink_item/explosives/military_grade/frag_grenade
	name = "破片手榴弹盒"
	desc = "一盒 7 枚破片手榴弹。简单。粗暴。"
	item = /obj/item/storage/box/syndie_kit/frag_grenades
	cost = 5
	purchasable_from = UPLINK_SERIOUS_OPS

/datum/uplink_item/explosives/military_grade/x4
	name = "X-4 塑性炸药"
	desc = "与 C4 类似，但爆炸更强，且为定向而非环形。X-4 可以贴在墙壁或窗户等 \
		实体表面上，炸穿墙壁并伤及另一侧的任何东西，同时对使用者更安全。 \
		适用于你需要一场可控爆炸，并且想留下更宽、更深洞口的场合。"
	item = /obj/item/grenade/c4/x4
	cost = 2

/datum/uplink_item/explosives/military_grade/syndicate_minibomb
	name = "辛迪加迷你炸弹"
	desc = "迷你炸弹是一枚引信为五秒的手榴弹。引爆时，除了对附近人员造成大量伤害之外， \
			还会在船体上炸出一个小破口。"
	item = /obj/item/grenade/syndieminibomb
	cost = 2
	purchasable_from = UPLINK_SERIOUS_OPS

/datum/uplink_item/explosives/military_grade/pizza_bomb
	name = "披萨炸弹"
	desc = "一个披萨盒，盒盖上巧妙地装着一枚炸弹。需要打开盒子来设定计时器；此后， \
			计时结束后再次打开盒子就会引爆。附赠免费披萨，给你或者你的目标！\
			赛博太阳工业提醒您，在精密的渗透行动中途吃披萨并不可取， \
			并且无法保证披萨未受任何爆炸性污染物沾染。"
	item = /obj/item/pizzabox/bomb
	cost = 2

// ~~ Grenadier's Belt Kit ~~

/datum/uplink_item/weapon_kits/high_cost/grenadier
	name = "掷弹兵腰带与气动榴弹发射器套件（困难）"
	desc = "一条装有 26 枚致命危险且极具破坏力的手榴弹的腰带，另配一具气动榴弹发射器。附赠一把多功能工具和一把螺丝刀。"
	item = /obj/item/storage/box/syndie_kit/demoman
	purchasable_from = UPLINK_SERIOUS_OPS

// ~~ Pump-Action Grenade Launcher Kit ~~

/datum/uplink_item/weapon_kits/medium_cost/china_lake
	name = "泵动式榴弹发射器套件（中等）"
	desc = "一个武器箱，内含一具 40 毫米泵动式榴弹发射器和一条 40 毫米榴弹弹带。不如气动榴弹发射器套件灵活，但危险程度毫不逊色。 \
		不过要注意近距离误伤。如果你在乎的话。猛虎合作社的最爱。"
	item = /obj/item/storage/toolbox/guncase/china_lake
	purchasable_from = UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo_nuclear/basic/a40mm
	name = "40 毫米高爆弹箱（榴弹发射器）"
	desc = "一盒 40 毫米高爆榴弹，适用于弹道式榴弹发射器。 \
		队友会求你别在狭窄走廊里打这个。 \
		你还是会打。"
	item = /obj/item/ammo_box/a40mm

/datum/uplink_item/ammo_nuclear/basic/a40mm/rubber
	name = "40 毫米橡胶弹箱（榴弹发射器）"
	desc = "一盒 40 毫米橡胶榴弹，适用于弹道式榴弹发射器。以高速向别人发射一枚巨大的橡胶弹丸，大概是你今天 \
		能做的最人道的事了。适合你想攒点人品值之类的时候。"
	item = /obj/item/ammo_box/a40mm/rubber

/datum/uplink_item/ammo_nuclear/ap/a40mm
	name = "40 毫米钛珠榴弹箱（榴弹发射器）"
	desc = "一盒 40 毫米钛珠榴弹，适用于弹道式榴弹发射器。向敌人喷射数量离谱的钛珠。 \
		适合你想贴身肉搏的时候。"
	item = /obj/item/ammo_box/a40mm

/datum/uplink_item/ammo_nuclear/incendiary/a40mm
	name = "40 毫米燃烧弹箱（榴弹发射器）"
	desc = "一盒 40 毫米燃烧榴弹，适用于弹道式榴弹发射器。向目标发射燃烧剂，接触即爆， \
		把周围一切卷入熊熊烈火。适合你确实不想放过任何东西和任何人的时候。包括你的队友。"
	item = /obj/item/ammo_box/a40mm

// ~~ Detonator: In case you lose the old one ~~

/datum/uplink_item/explosives/military_grade/syndicate_detonator
	name = "辛迪加起爆器"
	desc = "辛迪加起爆器是辛迪加炸弹的配套装置。只需按下附带的按钮， \
		一段加密无线电频率就会指示所有在线的辛迪加炸弹引爆。 \
		适合追求速度或希望同步多起爆炸的场合。使用起爆器前请务必远离 \
		爆炸范围。"
	item = /obj/item/syndicatedetonator
	cost = 1

/datum/uplink_item/explosives/military_grade/c4bag
	name = "一袋 C-4 炸药"
	desc = "因为有时候数量就是质量。内含 10 块 C-4 塑性炸药。"
	item = /obj/item/storage/backpack/duffelbag/syndie/c4
	cost = 5 // 50% discount!

/datum/uplink_item/explosives/military_grade/x4bag
	name = "一袋 X-4 炸药"
	desc = "适合你上次行动没带上掩体破坏弹的时候。内含 10 块 X-4 锥形塑性炸药。"
	item = /obj/item/storage/backpack/duffelbag/syndie/x4
	cost = 10 // 50% discount!

/datum/uplink_item/explosives/military_grade/syndicate_bomb
	name = "辛迪加炸弹"
	desc = "辛迪加炸弹是一种可怕的装置，能造成大规模破坏。它配有可调节的计时器， \
		最短为 %MIN_BOMB_TIMER 秒，并且可以用扳手固定在地面上以防 \
		移动。炸弹体积笨重，无法搬动；订购此物品时，会有一个较小的信标 \
		被传送到你身边，激活后会把真正的炸弹传送到信标处。请注意，这枚炸弹 \
		可以被拆除，有些船员可能会尝试这么做。 \
		炸弹核心可以被撬出来，并用其他爆炸物手动引爆。"
	item = /obj/item/sbeacondrop/bomb
	cost = 8

/datum/uplink_item/explosives/military_grade/syndicate_bomb/New()
	. = ..()
	desc = replacetext(desc, "%MIN_BOMB_TIMER", SYNDIEBOMB_MIN_TIMER_SECONDS)

/datum/uplink_item/explosives/military_grade/syndicate_bomb/emp
	name = "辛迪加 EMP 炸弹"
	desc = "辛迪加炸弹的一种变体，旨在产生大范围的 EMP 效果。"
	item = /obj/item/sbeacondrop/emp
	cost = 6

/datum/uplink_item/explosives/military_grade/syndicate_bomb/emp/New()
	. = ..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CYBERNETIC_REVOLUTION))
		cost *= 2

// Support (Borgs and Reinforcements)

/datum/uplink_category/reinforcements
	name = "增援"
	weight = 28

/datum/uplink_item/reinforcements
	category = /datum/uplink_category/reinforcements
	surplus = 0
	cost = 35
	purchasable_from = UPLINK_SERIOUS_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/reinforcements/operative_reinforcement
	name = "行动特工增援"
	desc = "从我们的某个派系呼叫一名额外的队员。 \
		他们只带一把军剩冲锋枪，所以建议给他们配好武装。"
	item = /obj/item/antag_spawner/nuke_ops

/datum/uplink_item/reinforcements/assault_borg
	name = "辛迪加突击半机械人"
	desc = "一种为系统性消灭非辛迪加人员而设计、编程的半机械人。 \
		配备自动补弹的轻机枪、榴弹发射器、能量剑、emag、定位仪、闪光灯和撬棍。"
	item = /obj/item/antag_spawner/nuke_ops/borg_tele/assault

/datum/uplink_item/reinforcements/medical_borg
	name = "辛迪加医疗半机械人"
	desc = "一种战斗医疗半机械人。攻击潜力有限，但凭借其支援能力完全弥补了这一点。 \
		它配备纳米机器人注射枪、医疗光束枪、战斗除颤器、全套手术工具（包括能量锯）、emag、定位仪和闪光灯。 \
		得益于它的器官储存袋，它能像任何类人生物一样进行手术。"
	item = /obj/item/antag_spawner/nuke_ops/borg_tele/medical

/datum/uplink_item/reinforcements/saboteur_borg
	name = "辛迪加破坏者半机械人"
	desc = "一种流线型的工程半机械人，配备隐蔽模块。但它同样会把焊接工具忘在穿梭机上。 \
		除了常规工程装备外，它还带有一个特殊的目的地贴标器，可借此穿行垃圾处理管网。 \
		它的变色龙投影器能让它伪装成纳米传讯半机械人，此外还具备热成像视觉和定位仪。"
	item = /obj/item/antag_spawner/nuke_ops/borg_tele/saboteur

/datum/uplink_item/reinforcements/overwatch_agent
	name = "守望情报特工"
	desc = "一名守望情报特工将被指派支援你的行动。他们能查看你的进度，并通过你 \
		行动小队随身摄像头协助协调。他们还能远程驾驶穿梭机并查看空间站的摄像头网络。 \
		如果你只是个只想杀人的莽夫，不在乎策略或情报，至少还有个人能见证你的屠杀狂欢！"
	item = /obj/item/antag_spawner/nuke_ops/overwatch
	cost = 10
	purchasable_from = UPLINK_FIREBASE_OPS

// ~~ Disposable Sentry Gun ~~
// Technically not a spawn but it is a kind of reinforcement...I guess.

/datum/uplink_item/reinforcements/turretbox
	name = "一次性哨戒炮"
	desc = "一套一次性哨戒炮部署系统，巧妙地伪装成工具箱，用扳手敲一下即可启用。"
	item = /obj/item/storage/toolbox/emergency/turret/nukie
	cost = 16
	restricted = FALSE
	refundable = FALSE


/datum/uplink_item/reinforcements/ed209
	name = "改装 ED209"
	desc = "偷来的纳米传讯科技，经过小幅调整与改装，以适应更宏大的用途。"
	item = /obj/item/antag_spawner/nuke_ops/ed209_nukie
	cost = 20
	restricted = FALSE
	refundable = FALSE


// Bundles

/datum/uplink_item/bundles_tc/cyber_implants
	name = "义体植入体组合"
	desc = "一个箱子，内含 X 光眼、CNS 重启植入体和复活植入体。每个都附一台自动手术器。"
	item = /obj/item/storage/box/cyber_implants
	cost = 20 //worth 24 TC
	purchasable_from = UPLINK_SERIOUS_OPS

/datum/uplink_item/bundles_tc/medical
	name = "医疗组合"
	desc = "支援专家：用这套医疗组合援助你的同伴特工。内含一个战术医疗包、 \
		一把咚克软轻机枪、一盒防暴飞镖，以及一个磁力靴 MOD 外骨骼模块，方便你在无重力环境中营救伙伴。"
	item = /obj/item/storage/backpack/duffelbag/syndie/med/medicalbundle
	cost = 25 // normally 31
	purchasable_from = UPLINK_SERIOUS_OPS

/datum/uplink_item/bundles_tc/firestarter
	name = "特种部队纵火兵组合"
	desc = "用于在近距离系统性压制碳基生命体：内含一套带火焰喷射器附件的精英 MOD 外骨骼、 \
		斯捷奇金 APS 冲锋手枪、两个燃烧弹匣、一枚迷你炸弹和一支兴奋剂注射器。 \
		立即下单，鲍里斯同志还会额外送你一套运动服。"
	item = /obj/item/storage/backpack/duffelbag/syndie/firestarter
	cost = 30
	purchasable_from = UPLINK_SERIOUS_OPS

/datum/uplink_item/bundles_tc/induction_kit
	name = "辛迪加征募套件"
	desc = "在空间站上遇到另一位辛迪加特工？预留了一些 TC 以防万一？或者你正在通过辛迪加频道与某人联络？ \
		买下这套装备，你就能通过特殊植入体把他们征召进你的行动小队。 \
		此外，它还包含一批对新特工有用的装备，包括一套太空服、一把安瑟姆手枪、两个备用弹匣等等！ \
		*不要*用于增援，而且它不会给目标洗脑！"
	item = /obj/item/storage/box/syndie_kit/induction_kit
	cost = 10
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/bundles_tc/induction_kit/clown
	name = "辛迪加马戏团入团套件"
	desc = "在站上发现了一位格外有趣、技艺精湛的表演者？\
		这套装备能让你将其招入辛迪加马戏团！包含履行新职责所需的全部装备。\
		*不要*用于增援，而且它不会给目标洗脑！"
	item = /obj/item/storage/box/syndie_kit/induction_kit/clown
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/bundles_tc/cowboy
	name = "辛迪加亡命徒套件"
	desc = "据说这一带出没着一个亡命徒。那家伙心狠手辣又高效，没有哪个巡警能抓住他。 \
	现在你也能变得和他一样！ \
	这套装备包含带装甲内衬的牛仔装备、一把定制左轮手枪与枪套，以及一匹附赠苹果可供驯服的小马。 \
	还附赠一个打火机，不过香烟得你自己准备。"
	item = /obj/item/storage/box/syndie_kit/cowboy
	cost = 18
	purchasable_from = UPLINK_SERIOUS_OPS
	relevant_child_items = list(
		/datum/uplink_item/ammo/revolver,
		/datum/uplink_item/ammo_nuclear/basic/revolver,
		/datum/uplink_item/ammo_nuclear/special/revolver/phasic,
		/datum/uplink_item/ammo_nuclear/special/revolver/heartseeker,
	)

// Mech related gear

/datum/uplink_category/mech
	name = "机甲增援"
	weight = 27

/datum/uplink_item/mech
	category = /datum/uplink_category/mech
	surplus = 0
	purchasable_from = UPLINK_SERIOUS_OPS
	restricted = TRUE

// ~~ Mechs ~~

/datum/uplink_item/mech/gygax
	name = "暗影吉盖克斯机甲"
	desc = "一台轻量级机甲，涂装为暗色。它的速度和装备选项使其非常适合 \
		打了就跑的战术。配备散射霰弹枪、对抗近战与远程攻击的装甲增强器，以及离子推进器。"
	item = /obj/vehicle/sealed/mecha/gygax/dark/loaded
	cost = 60
	relevant_child_items = list(
		/datum/uplink_item/mech/support_bag/mauler,
	)

/datum/uplink_item/mech/mauler
	name = "蹂躏者机甲"
	desc = "一台庞大且极其致命的军用级机甲。具备远程锁定、推力矢量 \
		和可部署烟雾。配备轻机枪、散射卡宾枪、导弹发射架，以及反投射物装甲增强器。"
	item = /obj/vehicle/sealed/mecha/marauder/mauler/loaded
	cost = 100
	relevant_child_items = list(
		/datum/uplink_item/mech/support_bag/mauler,
	)

// ~~ Mech Support ~~

/datum/uplink_item/mech/support_bag
	name = "暗影吉盖克斯支援行李袋"
	desc = "一个行李袋，内含可供散射机甲武器完全装填六次的弹药，该武器装备于标准暗影吉盖克斯机甲上。还附带一些用于维护机甲的支援装备，包括工具和一个感应器。"
	item = /obj/item/storage/backpack/duffelbag/syndie/ammo/darkgygax
	cost = 4
	purchasable_from = UPLINK_SERIOUS_OPS

/datum/uplink_item/mech/support_bag/mauler
	name = "蹂躏者支援行李袋"
	desc = "一个行李袋，内含可供标准蹂躏者机甲所装备的轻机枪和 SRM-8 导弹发射器完全装填三次的弹药。还附带一些用于维护机甲的支援装备，包括工具和一个感应器。"
	item = /obj/item/storage/backpack/duffelbag/syndie/ammo/mauler
	cost = 6
	purchasable_from = UPLINK_SERIOUS_OPS

// Stealthy Tools

/datum/uplink_item/stealthy_tools/syndigaloshes/nuke
	item = /obj/item/clothing/shoes/chameleon/noslip
	cost = 4
	purchasable_from = UPLINK_SERIOUS_OPS

/datum/uplink_item/stealthy_weapons/romerol_kit
	name = "罗梅罗尔"
	desc = "一种高度实验性的生物恐怖制剂，会在脑灰质中形成休眠结节。 \
		死亡时，这些结节会接管死者的身体，造成有限度的复活， \
		并伴有言语不清、攻击性，以及将这种制剂传染给他人的能力。"
	item = /obj/item/storage/box/syndie_kit/romerol
	cost = 25
	population_minimum = TRAITOR_POPULATION_LOWPOP
	purchasable_from = UPLINK_ALL_SYNDIE_OPS /*| UPLINK_TRAITORS */ // Don't give this to spies // BUBBER EDIT - Romerol only for nukies
	cant_discount = TRUE

// Modsuits

/datum/uplink_item/suits/modsuit/elite
	name = "辛迪加精英 MOD 外骨骼"
	desc = "辛迪加 MOD 外骨骼的升级精英版。具备防火性能，而且 \
		相比标准辛迪加 MOD 外骨骼，能为使用者提供更优越的护甲和机动性。"
	item = /obj/item/mod/control/pre_equipped/elite
	purchasable_from = (UPLINK_SERIOUS_OPS | UPLINK_SPY)

/datum/uplink_item/suits/energy_shield
	name = "MOD 外骨骼能量护盾模块"
	desc = "一种用于 MOD 外骨骼的能量护盾模块。护盾能挡下一次冲击， \
		之后需要重新充能。用得巧妙的话，这个模块能让你活得更久。"
	item = /obj/item/mod/module/energy_shield
	cost = 8
	purchasable_from = (UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)

/datum/uplink_item/suits/emp_shield
	name = "MOD 外骨骼高级 EMP 护盾模块"
	desc = "一种用于 MOD 外骨骼的高级 EMP 护盾模块。它能保护你的全身免受电磁脉冲影响。"
	item = /obj/item/mod/module/emp_shield/advanced
	cost = 5
	purchasable_from = (UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)

/datum/uplink_item/suits/injector
	name = "MOD 外骨骼注射模块"
	desc = "一种用于 MOD 外骨骼的注射模块。它是一支可伸出的穿刺注射器，容量 30u。"
	item = /obj/item/mod/module/injector
	cost = 2
	purchasable_from = (UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)
	uplink_item_flags = NONE

/datum/uplink_item/suits/holster
	name = "MOD 外骨骼枪套模块"
	desc = "一种用于 MOD 外骨骼的枪套模块。它能隐蔽地收纳任何不太重的枪械。"
	item = /obj/item/mod/module/holster
	cost = 2
	purchasable_from = (UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)
	uplink_item_flags = NONE

/datum/uplink_item/device_tools/medgun_mod
	name = "医疗光束枪模块"
	desc = "辛迪加工程的奇迹，医疗光束枪模块让军医能够让自己的同伴 \
		在火力压制下依然坚持作战。别让光束交叉！"
	item = /obj/item/mod/module/medbeam
	cost = 15
	purchasable_from = UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/suits/syndi_intellicard
	name = "预装填辛迪加智能卡"
	desc = "一张辛迪加智能卡，激活后可下载一名被俘获的纳米传讯 AI，并将其改造为标准辛迪加法则集。你可以把它插入 MOD 外骨骼，得到一个会聊天的伙伴！它还能随意控制 MOD 外骨骼的模块，并在你濒死或死亡时操控你的身体。 \
			不过，由于抽取过程启动的失效保护，该 AI 只能通过直接接触与电子设备交互……"
	item = /obj/item/aicard/syndie/loaded
	cost = 12
	purchasable_from = UPLINK_ALL_SYNDIE_OPS
	refundable = TRUE

/datum/uplink_item/suits/synd_ai_upgrade
	name = "辛迪加 AI 升级"
	desc = "……除非你购买辛迪加升级！这枚数据芯片可让被俘获的 AI 每次应用时增加两格的交互范围。辛迪加建议最多购买三次或四次，以获得总共七米或无限的交互范围。"
	item = /obj/item/disk/computer/syndie_ai_upgrade
	cost = 4
	purchasable_from = UPLINK_ALL_SYNDIE_OPS
	cant_discount = TRUE
	refundable = TRUE

// Devices

/datum/uplink_item/device_tools/assault_pod
	name = "突击舱目标定位器"
	desc = "用它来选择突击舱的着陆区。"
	item = /obj/item/assault_pod
	cost = 30
	surplus = 0
	restricted = TRUE
	purchasable_from = UPLINK_FIREBASE_OPS

/datum/uplink_item/device_tools/syndie_jaws_of_life
	name = "辛迪加救生钳"
	desc = "基于纳米传讯的型号，这件强力工具既能当撬棍，也能当剪线钳。 \
		在撬棍形态下，它可以用来强行打开气闸。对于进入空间站或其各部门非常有用。"
	item = /obj/item/crowbar/power/syndicate
	cost = 4
	purchasable_from = UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY

/datum/uplink_item/device_tools/medkit
	name = "辛迪加战斗军医包"
	desc = "这个急救包呈可疑的黑红配色。内含若干阿托品注射笔， \
		用于快速稳定伤情和防止引爆，缝合线和再生网片用于处理伤口，以及贴片 \
		用于在战场上加速愈合。还附带基础医疗工具和消毒剂。"
	item = /obj/item/storage/medkit/tactical
	cost = 4
	purchasable_from = UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/medkit/premium
	name = "辛迪加战斗医疗全套装备"
	desc = "这个急救包呈可疑的黑红配色。内含一支未装填的战斗化学注射器， \
		可穿透太空服投送化学药剂；一副医学科研夜视 HUD，便于快速辨认伤员和化学补给； \
		改良的医疗用品，包括经英特戴恩制药公司认可的药品；一条被骇入的义体手术工具臂植入体； \
		以及一些有助于野外医疗使用和行动特工生理药剂强化的 MOD 外骨骼模块。"
	item = /obj/item/storage/medkit/tactical/premium
	cost = 15
	purchasable_from = UPLINK_SERIOUS_OPS

/datum/uplink_item/device_tools/potion
	name = "辛迪加智力药水"
	item = /obj/item/slimepotion/sentience/nuclear
	desc = "一种由辛迪加卧底特工冒着极大风险回收、随后又用辛迪加科技改造的药水。 \
		使用后能让任何动物获得智力，并绑定为你效力，同时为它植入一枚用于交流的内部无线电和一张用于开门的内部身份卡。"
	cost = 4
	purchasable_from = UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY
	restricted = TRUE

// Implants

/datum/uplink_item/implants/nuclear
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/implants/nuclear/deathrattle
	name = "亡语植入体盒"
	desc = "一批植入体（以及一台可重复使用的植入器），应当注入队员体内。当队中一人 \
		死亡时，所有其他植入者都会收到一条心灵讯息，告知他们队友的名字 \
		和死亡地点。与大多数植入体不同，这些设计为可植入 \
		任何生物体内，无论生物还是机械。"
	item = /obj/item/storage/box/syndie_kit/imp_deathrattle
	cost = 4
	purchasable_from = UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/implants/nuclear/microbomb
	name = "微型炸弹植入体"
	desc = "一种注入体内的植入体，之后可手动激活，或在死亡时自动激活。 \
		你体内的植入体越多，爆炸威力就越高。 \
		不过，这会永久摧毁你的身体。"
	item = /obj/item/storage/box/syndie_kit/imp_microbomb
	cost = 2
	purchasable_from = UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY

/datum/uplink_item/implants/nuclear/macrobomb
	name = "大型炸弹植入体"
	desc = "一种注入体内的植入体，之后可手动激活，或在死亡时自动激活。 \
		死亡时会释放一场巨大的爆炸，摧毁附近的一切。"
	item = /obj/item/storage/box/syndie_kit/imp_macrobomb
	cost = 20
	restricted = TRUE
	purchasable_from = UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/implants/nuclear/macrobomb/fake
	name = "假大型炸弹植入体"
	desc = "引爆延迟与真正的大型炸弹相同，但最终威力只相当于标准微型炸弹的植入体。\
		不过，引爆时还会带来标准微型炸弹没有的惊喜……"
	item = /obj/item/storage/box/syndie_kit/imp_macrobomb_fake
	cost = /datum/uplink_item/implants/nuclear/microbomb::cost
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/implants/nuclear/deniability
	name = "战术推责植入体"
	desc = "一种注入脑部的植入体，之后可手动激活，或在进入濒危状态时自动激活。 \
			能防止因濒危状态而倒下，但过一段时间后会爆炸。"
	item = /obj/item/storage/box/syndie_kit/imp_deniability
	cost = 6
	purchasable_from = UPLINK_SERIOUS_OPS | UPLINK_SPY

/datum/uplink_item/implants/nuclear/reviver
	name = "复活植入体"
	desc = "这种植入体会在你失去意识时尝试复活并治疗你。附一台自动手术器。"
	item = /obj/item/autosurgeon/syndicate/reviver
	cost = 8

/datum/uplink_item/implants/nuclear/thermals
	name = "热成像义眼"
	desc = "这些义眼能给你热成像视觉。附赠一台免费自动手术器。"
	item = /obj/item/autosurgeon/syndicate/thermal_eyes
	cost = 8

/datum/uplink_item/implants/nuclear/implants/xray
	name = "X 光视觉植入体"
	desc = "这些义眼能给你 X 光视觉。附一台自动手术器。"
	item = /obj/item/autosurgeon/syndicate/xray_eyes
	cost = 8

/datum/uplink_item/implants/nuclear/antistun
	name = "CNS 重启植入体"
	desc = "这种植入体能帮助你在被眩晕后更快站起来。附一台自动手术器。"
	item = /obj/item/autosurgeon/syndicate/anti_stun
	cost = 8

// Badass (meme items)

/datum/uplink_item/badass/costumes
	surplus = 0
	purchasable_from = UPLINK_SERIOUS_OPS
	cost = 4
	cant_discount = TRUE

// Base Keys

/datum/uplink_category/base_keys
	name = "基地门禁卡"
	weight = 27

/datum/uplink_item/base_keys
	category = /datum/uplink_category/base_keys
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS
	cost = 5
	cant_discount = TRUE

/datum/uplink_item/base_keys/bomb_key
	name = "辛迪加军械实验室门禁卡"
	desc = "你自认为是爆炸物专家吗？如果是，那你走运了！有了这张特殊授权卡， \
		你就能用自己亲手制作的爆炸装置把那些企业西装佬炸飞。就产自你所在火力基地的 \
		军械实验室！*辛迪加对使用实验室期间造成的伤亡概不负责。"
	cost = 30
	item = /obj/item/keycard/syndicate_bomb

/datum/uplink_item/base_keys/bio_key
	name = "辛迪加生化武器实验室门禁卡"
	desc = "在合适的人手里，即使是邪恶的企业科技也能转化为庞大的解放与正义武库。从 \
		微生物共生到史莱姆核心武器化，这张特殊授权卡能让你以惊人速度突破生物恐怖主义的 \
		边界。作为额外福利，这些实验室甚至还配备了自然生命维持系统！*不含植物。"
	item = /obj/item/keycard/syndicate_bio
	purchasable_from = UPLINK_FIREBASE_OPS

/datum/uplink_item/base_keys/chem_key
	name = "辛迪加化工厂门禁卡"
	desc = "对于我们当中一些最优秀的行动特工来说，看着企业空间站在复仇的闪光中爆炸还远远不够。 \
		这类人更喜欢给他们的艺术创作增添一点私人触感。感兴趣的话，一张特殊授权卡 \
		可以立即送到你的位置。制造开创性的化学药剂、下厨、贩卖顶级毒品， \
		并欣赏今日最佳古典音乐！"
	item = /obj/item/keycard/syndicate_chem
	purchasable_from = UPLINK_FIREBASE_OPS

/datum/uplink_item/base_keys/fridge_key
	name = "洛佩斯门禁卡"
	desc = "饿了？巴尔萨佐德火力基地的每个人都饿了。别误会，洛佩斯是个好厨子，但他对 \
		菜单安排固执得很。有时候你就是想大吃一顿。听着，别告诉任何人，好吗？今天早上简报时 \
		我从他口袋里摸到了这个。他一直在找。拿去吧，进到冷藏库，在他回来之前 \
		想做什么就做什么。记住：别告诉任何人！——M.T"
	item = /obj/item/keycard/syndicate_fridge
	purchasable_from = UPLINK_FIREBASE_OPS

/datum/uplink_item/base_keys/custodial_key
	name = "辛迪加清洁工具间门禁卡"
	desc = "你的工作场所脏了？没问题！有了这张卡，你就能进入清洁工具间。里面有一辆清洁推车， \
	配有一些清洁用品和一罐水蒸气。"
	item = /obj/item/keycard/syndicate_custodial
	purchasable_from = UPLINK_FIREBASE_OPS

// Hats
// It is fundamental for the game's health for there to be a hat crate for nuclear operatives.

/datum/uplink_item/badass/hats
	name = "帽子板条箱"
	desc = "帽子板条箱！内含帽子！帽子！！！"
	item = /obj/structure/closet/crate/large/hats
	cost = 5
	purchasable_from = UPLINK_ALL_SYNDIE_OPS
