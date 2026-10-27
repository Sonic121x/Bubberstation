// This contains all boxes that will possess something wearable, like an outfit or something similar.area

/obj/item/storage/box/gloves
	name = "乳胶手套盒"
	desc = "内含无菌乳胶手套。"
	illustration = "latex"

/obj/item/storage/box/gloves/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/gloves/latex(src)

/obj/item/storage/box/masks
	name = "无菌口罩盒"
	desc = "这个盒子内装有无菌医用口罩。"
	illustration = "sterile"

/obj/item/storage/box/masks/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/mask/surgical(src)

/obj/item/storage/box/rxglasses
	name = "处方眼镜盒"
	desc = "这个盒子内装有书呆子眼镜。"
	illustration = "glasses"

/obj/item/storage/box/rxglasses/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/glasses/regular(src)

//it needs to be linked, hence a kit.
/obj/item/storage/box/rxglasses/spyglasskit
	name = "间谍眼镜套件"
	desc = "这个盒子内装有<i>酷炫</i>的书呆子眼镜；内置显示屏，可观看已连接的摄像头。"

/obj/item/storage/box/rxglasses/spyglasskit/PopulateContents()
	var/obj/item/clothing/accessory/spy_bug/newbug = new(src)
	var/obj/item/clothing/glasses/sunglasses/spy/newglasses = new(src)
	newbug.linked_glasses = newglasses
	newglasses.linked_bug = newbug
	new /obj/item/paper/fluff/nerddocs(src)

/obj/item/storage/box/tape_wizard
	name = "胶带巫师——第 23 集"
	desc = "一个装有传奇娱乐偶像“超级胶带巫师”所用服装的盒子。它出来的时候有点粘住了。"

/obj/item/storage/box/tape_wizard/PopulateContents()
	new /obj/item/clothing/head/wizard/tape/fake(src)
	new /obj/item/clothing/suit/wizrobe/tape/fake(src)
	new /obj/item/staff/tape(src)
	new /obj/item/stack/medical/wrap/sticky_tape(src)

/obj/item/storage/box/fakesyndiesuit
	name = "盒装太空服与头盔复制品"
	desc = "一个光滑坚固的盒子，用来装玩具太空服。"
	icon_state = "syndiebox"
	illustration = "syndiesuit"

/obj/item/storage/box/fakesyndiesuit/PopulateContents()
	new /obj/item/clothing/head/syndicatefake(src)
	new /obj/item/clothing/suit/syndicatefake(src)

/obj/item/storage/box/syndie_kit/battle_royale
	name = "乱斗大逃杀转播套件"
	desc = "内含举办银河系最伟大节目《乱斗大逃杀》所需的一切。"

/obj/item/storage/box/syndie_kit/battle_royale/PopulateContents()
	var/obj/item/royale_implanter/implanter = new(src)
	var/obj/item/royale_remote/remote = new(src)
	remote.link_implanter(implanter)

/obj/item/storage/box/deputy
	name = "副官臂章盒"
	desc = "发放给获授权担任安保副手的人员。"
	icon_state = "secbox"
	illustration = "depband"

/obj/item/storage/box/deputy/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/accessory/armband/deputy(src)

/obj/item/storage/box/hero
	name = "勇敢的古墓探险家——1940 年代。"
	desc = "这位历史真实性至今仍受质疑的传奇人物，据说是一位世界闻名的考古学家，带着他标志性的鞭子和软呢帽，在遥远的土地上展开了无数次冒险。"

/obj/item/storage/box/hero/PopulateContents()
	new /obj/item/clothing/head/fedora/curator(src)
	new /obj/item/clothing/shoes/workboots/mining(src)
	new /obj/item/clothing/suit/jacket/curator(src)
	new /obj/item/clothing/under/rank/civilian/curator/treasure_hunter(src)
	new /obj/item/melee/curator_whip(src)

/obj/item/storage/box/hero/astronaut
	name = "登月第一人——1960 年代。"
	desc = "一个人的一小步，人类的一大步。用这套功能完好的复古舱外活动装备，重温太空探索的起点。"

/obj/item/storage/box/hero/astronaut/PopulateContents()
	new /obj/item/clothing/suit/space/nasavoid(src)
	new /obj/item/clothing/head/helmet/space/nasavoid(src)
	new /obj/item/tank/internals/oxygen(src)
	new /obj/item/gps(src)

/obj/item/storage/box/hero/scottish
	name = "勇敢的心，苏格兰起义者——1300 年代。"
	desc = "这位似乎是苏格兰独立战争中的传奇人物，与蓝色面部涂装、大剑、怪异的男人裙裤以及他那句经久不衰的口头禅“自由！！”紧密相连。"

/obj/item/storage/box/hero/scottish/PopulateContents()
	new /obj/item/claymore/weak/ceremonial(src)
	new /obj/item/clothing/shoes/sandal(src)
	new /obj/item/clothing/under/costume/kilt(src)
	new /obj/item/toy/crayon/spraycan(src)

/obj/item/storage/box/hero/carphunter
	name = "鲤鱼猎人，野生动物专家——2506 年。"
	desc = "尽管绰号如此，这位野生动物专家主要以热情的环保主义者和自然保护者的身份为人所知，他经常与危险的野生动物接触，以传授自然之美。"

/obj/item/storage/box/hero/carphunter/PopulateContents()
	new /obj/item/clothing/mask/gas/carp(src)
	new /obj/item/clothing/suit/hooded/carp_costume/spaceproof/old(src)
	new /obj/item/knife/hunting(src)
	new /obj/item/storage/box/papersack/meat(src)

/obj/item/storage/box/hero/mothpioneer
	name = "蛾族舰队先驱——2429 年。"
	desc = "有人声称，舰队工程师直接促成了现代航天设计中的大多数进步。尽管他们过往贡献的具体细节有些模糊，但他们的巧思至今仍无人能及、毋庸置疑。"

/obj/item/storage/box/hero/mothpioneer/PopulateContents()
	new /obj/item/clothing/head/mothcap/original(src)
	new /obj/item/clothing/suit/mothcoat/original(src)
	new /obj/item/crowbar(src)
	new /obj/item/flashlight/lantern(src)
	new /obj/item/screwdriver(src)
	new /obj/item/stack/sheet/glass/fifty(src)
	new /obj/item/stack/sheet/iron/fifty(src)
	new /obj/item/wrench(src)

/obj/item/storage/box/hero/etherealwarden
	name = "以太人小径守望者——2450 年代。"
	desc = "关于英勇的小径守望者，流传着许多奇幻故事，连那些在他们的指引下，于斯普劳特时而险恶的道路上免于横死的外星来客也这么说。事实上，他们的工作主要是走路和修路，而非屠龙，但其重要性丝毫不减，且备受尊敬：保持道路与小径的安全与良好维护，对许多定居点而言是生死攸关之事。"

/obj/item/storage/box/hero/etherealwarden/PopulateContents()
	new /obj/item/clothing/suit/hooded/ethereal_raincoat/trailwarden(src)
	new /obj/item/clothing/under/ethereal_tunic/trailwarden(src)
	new /obj/item/storage/backpack/saddlepack(src)

/obj/item/storage/box/hero/journalist
	name = "被 CIA 暗杀——1984 年。" // Literally
	desc = "许多勇敢的人冒着生命危险报道政府试图向公众隐瞒的事件，确保真相仍被掩埋、无人听闻。这套衣物复制了其中一位“记者”所穿的服装——他是真相之战中沉默的哨兵。"

/obj/item/storage/box/hero/journalist/PopulateContents()
	new /obj/item/clothing/under/costume/buttondown/slacks(src)
	new /obj/item/clothing/suit/toggle/suspenders(src)
	new /obj/item/clothing/neck/tie/red(src)
	new /obj/item/clothing/head/fedora/beige/press(src)
	new /obj/item/clothing/accessory/press_badge(src)
	new /obj/item/clothing/suit/hazardvest/press(src)
	new /obj/item/radio/entertainment/microphone/physical(src)
	new /obj/item/radio/entertainment/speakers/physical(src)
	new /obj/item/clipboard(src)
	new /obj/item/taperecorder(src)
	new /obj/item/camera(src)
	new /obj/item/wallframe/telescreen/entertainment(src)

/obj/item/storage/box/holy
	name = "圣殿骑士套件"
	/// This item is used to generate a preview image for this set.
	/// It could be any item, doesn't even necessarily need to be something in the kit
	var/obj/item/typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/templar

/obj/item/storage/box/holy/PopulateContents()
	new /obj/item/clothing/head/helmet/chaplain(src)
	new /obj/item/clothing/suit/chaplainsuit/armor/templar(src)

/obj/item/storage/box/holy/clock
	name = "被遗忘的套件"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/clock

/obj/item/storage/box/holy/clock/PopulateContents()
	new /obj/item/clothing/head/helmet/chaplain/clock(src)
	new /obj/item/clothing/suit/chaplainsuit/armor/clock(src)

/obj/item/storage/box/holy/student
	name = "亵渎学者套件"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/studentuni

/obj/item/storage/box/holy/student/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/studentuni(src)
	new /obj/item/clothing/head/helmet/chaplain/cage(src)

/obj/item/storage/box/holy/sentinel
	name = "石之哨卫套件"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/ancient

/obj/item/storage/box/holy/sentinel/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/ancient(src)
	new /obj/item/clothing/head/helmet/chaplain/ancient(src)

/obj/item/storage/box/holy/witchhunter
	name = "猎巫人套件"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/witchhunter

/obj/item/storage/box/holy/witchhunter/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/witchhunter(src)
	new /obj/item/clothing/head/helmet/chaplain/witchunter_hat(src)

/obj/item/storage/box/holy/adept
	name = "神圣侍徒套件"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/adept

/obj/item/storage/box/holy/adept/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/adept(src)
	new /obj/item/clothing/head/helmet/chaplain/adept(src)
	new /obj/item/clothing/gloves/bracer(src)

/obj/item/storage/box/holy/follower
	name = "牧师追随者套件"
	typepath_for_preview = /obj/item/clothing/suit/hooded/chaplain_hoodie/leader

/obj/item/storage/box/holy/follower/PopulateContents()
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie/leader(src)

/obj/item/storage/box/holy/divine_archer
	name = "神圣弓手套件"
	typepath_for_preview = /obj/item/clothing/suit/hooded/chaplain_hoodie/divine_archer

/obj/item/storage/box/holy/divine_archer/PopulateContents()
	new /obj/item/clothing/under/rank/civilian/chaplain/divine_archer(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie/divine_archer(src)
	new /obj/item/clothing/gloves/divine_archer(src)
	new /obj/item/clothing/shoes/divine_archer(src)

/obj/item/storage/box/holy/heretic
	name = "秘术修行者套件"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/heretic

/obj/item/storage/box/holy/heretic/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/heretic(src)
	new /obj/item/clothing/head/helmet/chaplain/heretic(src)

/obj/item/storage/box/floor_camo
	name = "地砖迷彩盒"
	desc = "感谢您光临 Camo-J's，我们独特设计的 \
		地砖“纳米传讯渣滓”风格迷彩服，是顶尖高手 \
		所使用的终极间谍制服。以我们最新的迷彩科技 \
		面料，提供最佳的灵活性。完美适用于 \
		高风险的间谍走廊行动。请享用我们的产品！"

/obj/item/storage/box/floor_camo/PopulateContents()
	new /obj/item/clothing/under/syndicate/floortilecamo(src)
	new /obj/item/clothing/mask/floortilebalaclava(src)
	new /obj/item/clothing/gloves/combat/floortile(src)
	new /obj/item/clothing/shoes/jackboots/floortile(src)
	new /obj/item/storage/backpack/floortile(src)

/obj/item/storage/box/collar_bomb
	name = "项圈炸弹盒"
	desc = "背面有一行小字写着“仅供研究用途。请小心处理。如遇紧急情况，请拨打以下号码：”……其余部分被记号笔涂掉了……"

/obj/item/storage/box/collar_bomb/PopulateContents()
	var/obj/item/collar_bomb_button/button = new(src)
	new /obj/item/clothing/neck/collar_bomb(src, button)

/obj/item/storage/box/itemset/crusader/blue/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/crusader/blue(src)
	new /obj/item/clothing/head/helmet/plate/crusader/blue(src)
	new /obj/item/clothing/gloves/plate/blue(src)
	new /obj/item/clothing/shoes/plate/blue(src)

/obj/item/storage/box/itemset/crusader/red/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/crusader/red(src)
	new /obj/item/clothing/head/helmet/plate/crusader/red(src)
	new /obj/item/clothing/gloves/plate/red(src)
	new /obj/item/clothing/shoes/plate/red(src)

/obj/item/storage/box/wizard_kit
	name = "通用巫师角色扮演套件"

/obj/item/storage/box/wizard_kit/PopulateContents()
	new /obj/item/clothing/head/wizard(src)
	new /obj/item/clothing/suit/wizrobe(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/wizard_kit/red
	name = "塑能巫师角色扮演套件"

/obj/item/storage/box/wizard_kit/red/PopulateContents()
	new /obj/item/clothing/head/wizard/red(src)
	new /obj/item/clothing/suit/wizrobe/red(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/wizard_kit/yellow
	name = "传送巫师角色扮演套件"

/obj/item/storage/box/wizard_kit/yellow/PopulateContents()
	new /obj/item/clothing/head/wizard/yellow(src)
	new /obj/item/clothing/suit/wizrobe/yellow(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/wizard_kit/magusred
	name = "咒法巫师角色扮演套件"

/obj/item/storage/box/wizard_kit/yellow/PopulateContents()
	new /obj/item/clothing/head/wizard/magus(src)
	new /obj/item/clothing/suit/wizrobe/magusred(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/wizard_kit/magusblue
	name = "变化巫师角色扮演套件"

/obj/item/storage/box/wizard_kit/yellow/PopulateContents()
	new /obj/item/clothing/head/wizard/magus(src)
	new /obj/item/clothing/suit/wizrobe/magusblue(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/wizard_kit/black
	name = "死灵巫师角色扮演套件"

/obj/item/storage/box/wizard_kit/black/PopulateContents()
	new /obj/item/clothing/head/wizard/black(src)
	new /obj/item/clothing/suit/wizrobe/black(src)
	new /obj/item/clothing/shoes/sandal(src)

// BUBBER EDIT ADDITION BEGIN

/obj/item/storage/box/lewd_toys
	name = "淫秽玩具盒"
	desc = "内含供独处或与他人共度时光的淫秽器具！下次请藏得好一点。"

/obj/item/storage/box/lewd_toys/PopulateContents()
	new /obj/item/clothing/sextoy/dildo(src)
	new /obj/item/clothing/sextoy/buttplug(src)
	new /obj/item/stack/shibari_rope/full(src)
	new /obj/item/spanking_pad(src)
	new /obj/item/clothing/mask/ballgag(src)
	new /obj/item/clothing/suit/straight_jacket/shackles(src)
	new /obj/item/clothing/glasses/blindfold/kinky(src)

// BUBBER EDIT ADDITION END
