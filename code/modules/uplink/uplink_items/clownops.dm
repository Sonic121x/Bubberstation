
// Clown Operative Stuff
// Maybe someday, someone will care to maintain this

/datum/uplink_item/weapon_kits/pie_cannon
	name = "香蕉奶油馅饼炮"
	desc = "为特别的小丑准备的特别馅饼炮，这台装置最多可装 20 个馅饼，并且每两秒自动制造一个！"
	cost = 10
	item = /obj/item/pneumatic_cannon/pie/selfcharge
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/weapon_kits/bananashield
	name = "香蕉矿能量盾"
	desc = "小丑最强大的防御武器，这面个人护盾能将射来的能量攻击弹回攻击者，让你几乎免疫 \
		远程能量攻击。它也可以投掷出去，在人群身上弹跳使他们滑倒， \
		而且即使没命中也会回到你手中。警告：护盾展开时不要试图站在上面，即使穿着防滑鞋也不行。"
	item = /obj/item/shield/energy/bananium
	cost = 16
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/weapon_kits/clownsword
	name = "香蕉矿剑"
	desc = "一把不造成任何伤害的能量剑，但无论是近战攻击、投掷撞击，还是仅仅踩到它，都会让接触者滑倒。 \
		小心误伤队友，即使是防滑鞋也无法抵挡。"
	item = /obj/item/melee/energy/sword/bananium
	cost = 3
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/weapon_kits/clownoppin
	name = "超级搞笑击针"
	desc = "一种击针，装入枪械后，该枪械将只能由小丑和笨拙的人使用，而且任何人试图开火时枪都会发出洪克声。"
	cost = 1 //much cheaper for clown ops than for clowns
	item = /obj/item/firing_pin/clown/ultra
	purchasable_from = UPLINK_CLOWN_OPS
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/weapon_kits/clownopsuperpin
	name = "超级无敌搞笑击针"
	desc = "和超级搞笑击针一样，只不过当不是笨拙者或小丑的人试图开火时，装入此击针的枪械会直接爆炸。"
	cost = 4 //much cheaper for clown ops than for clowns
	item = /obj/item/firing_pin/clown/ultra/selfdestruct
	purchasable_from = UPLINK_CLOWN_OPS
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/weapon_kits/foamsmg
	name = "玩具冲锋枪"
	desc = "一把装满弹的咚克软犊牛式冲锋枪，可发射防暴级飞镖，弹匣容量 20 发。"
	item = /obj/item/gun/ballistic/automatic/c20r/toy
	cost = 5
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/weapon_kits/foammachinegun
	name = "玩具机枪"
	desc = "一把装满弹的咚克软弹链机枪。这件武器拥有高达 50 发的巨型弹匣，装填着毁灭性的 \
		防暴级飞镖，只需一轮齐射就能短暂让目标失去行动能力。"
	item = /obj/item/gun/ballistic/automatic/l6_saw/toy
	cost = 10
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/explosives/bombanana
	name = "炸弹香蕉"
	desc = "一根味道爆炸的香蕉！吃完香蕉后过几秒，香蕉皮就会以辛迪加迷你炸弹的威力炸开， \
		所以请赶快把皮扔掉。"
	item = /obj/item/food/grown/banana/bombanana
	cost = 4 //it is a bit cheaper than a minibomb because you have to take off your helmet to eat it, which is how you arm it
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/explosives/clown_bomb_clownops
	name = "小丑炸弹"
	desc = "小丑炸弹是一种滑稽的装置，能制造大规模的恶作剧。它配有可调节的计时器， \
		最短为 %MIN_BOMB_TIMER 秒，并且可以用扳手固定在地面上以防止 \
		移动。炸弹体积笨重，无法搬动；订购此物品时，会有一个较小的信标 \
		被传送到你身边，激活后会把真正的炸弹传送到信标处。请注意，这枚炸弹 \
		可以被拆除，有些船员可能会尝试这么做。"
	item = /obj/item/sbeacondrop/clownbomb
	cost = 15
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/explosives/clown_bomb_clownops/New()
	. = ..()
	desc = replacetext(desc, "%MIN_BOMB_TIMER", SYNDIEBOMB_MIN_TIMER_SECONDS)

/datum/uplink_item/explosives/tearstache
	name = "催泪胡须手榴弹"
	desc = "一枚催泪瓦斯手榴弹，会把黏糊糊的胡子贴到任何没戴小丑面具或默剧面具的人脸上。这些胡子会 \
		在目标脸上停留一分钟，使其无法使用呼吸面罩之类的装置。"
	item = /obj/item/grenade/chem_grenade/teargas/moustache
	cost = 3
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/explosives/pinata
	name = "武器级皮纳塔套件"
	desc = "一个塞满糖果和爆炸物、还附带两条携带腰带的皮纳塔，敲开它看看你能得到什么！"
	item = /obj/item/storage/box/syndie_kit/pinata
	purchasable_from = UPLINK_CLOWN_OPS
	limited_stock = 1
	cost = 12 //This is effectively the clown ops version of the grenadier belt where you should on average get 8 explosives if you use a weapon with exactly 10 force.
	surplus = 0

/datum/uplink_item/reinforcement/clown_reinforcement
	name = "小丑增援"
	desc = "呼叫一名额外的小丑来分享乐趣，配备全套初始装备，但没有传送水晶。"
	item = /obj/item/antag_spawner/nuke_ops/clown
	cost = 20
	purchasable_from = UPLINK_CLOWN_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/reinforcement/monkey_agent
	name = "猿猴特工增援"
	desc = "从我们辛迪加香蕉部呼叫一名训练有素的猴子秘密特工。 \
		它们受过操作机械的训练，也会识字，但不会说通用语。"
	item = /obj/item/antag_spawner/loadout/monkey_man
	cost = 7
	purchasable_from = UPLINK_CLOWN_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/reinforcement/monkey_supplies
	name = "猿猴特工补给"
	desc = "有时候你需要比一只狂躁猴子更强的火力。比如一只狂躁的、武装起来的猴子！ \
		猴子可以打开这套工具，获得一个装着廉价枪械、弹药以及一些杂项补给的袋子。"
	item = /obj/item/storage/toolbox/guncase/monkeycase
	cost = 4
	purchasable_from = UPLINK_CLOWN_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/mech/honker
	name = "暗影 H.O.N.K."
	desc = "一台小丑作战机甲，装备炸弹香蕉皮发射器和催泪胡须手榴弹发射器，还有无处不在的 HoNkER BlAsT 5000。"
	item = /obj/vehicle/sealed/mecha/honker/dark/loaded
	cost = 80
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/stealthy_tools/combatbananashoes
	name = "香蕉战斗鞋"
	desc = "与普通战斗小丑鞋一样能让穿着者对大多数滑倒攻击免疫，此外这双鞋还 \
		能在穿着者行走时生成大量合成香蕉皮，让追上来的敌人滑倒。它们 \
		发出的吱吱声也响亮得多。"
	item = /obj/item/clothing/shoes/clown_shoes/banana_shoes/combat
	cost = 6
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/badass/clownopclumsinessinjector //clowns can buy this too, but it's in the role-restricted items section for them
	name = "笨拙注射器"
	desc = "给自己注射后，你会变得和小丑一样笨拙……或者给别人注射，让那个人变得和小丑一样笨拙。对于想重拾昔日小丑本性的小丑特工，或者想在杀死猎物前戏弄一番的小丑特工都很有用。"
	item = /obj/item/dnainjector/clumsymut
	cost = 1
	purchasable_from = UPLINK_CLOWN_OPS
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
