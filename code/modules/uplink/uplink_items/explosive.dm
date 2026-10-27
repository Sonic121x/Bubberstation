/datum/uplink_category/explosives
	name = "爆炸物"
	weight = 6

/datum/uplink_item/explosives
	category = /datum/uplink_category/explosives

/datum/uplink_item/explosives/soap_clusterbang
	name = "滑倒末日集束弹"
	desc = "一枚传统的集束手榴弹，装药全部由辛迪加肥皂组成。在任何场合都很有用！"
	item = /obj/item/grenade/clusterbuster/soap
	cost = 1

/datum/uplink_item/explosives/c4
	name = "C-4 塑性炸药"
	desc = "C-4 是常见的 C 型塑性炸药。你可以用它炸开墙壁、破坏设备，或者给它接上 \
			引爆组件来改变引爆方式。它可以附着在几乎所有物体上，计时器可调， \
			最短设置为 10 秒。"
	item = /obj/item/grenade/c4
	cost = 1

/datum/uplink_item/explosives/x4
	name = "X-4 塑性炸药"
	desc = "与 C4 类似，但爆炸更强，且为定向而非环形。X-4 可以贴在墙壁或窗户等 \
		实体表面上，炸穿墙壁并伤及另一侧的任何东西，同时对使用者更安全。 \
		适用于你需要一场可控爆炸，并且想留下更宽、更深洞口的场合。"
	item = /obj/item/grenade/c4/x4
	cost = 2
	limited_stock = 5
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS //nukies get their own version

/datum/uplink_item/explosives/c4bag
	name = "一袋 C-4 炸药"
	desc = "因为有时候数量就是质量。内含 10 块 C-4 塑性炸药。"
	item = /obj/item/storage/backpack/duffelbag/syndie/c4
	cost = 5 // 50% discount!
	cant_discount = TRUE
	limited_stock = 2
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS //nukies get their own version

/datum/uplink_item/explosives/frag
	name = "破片手榴弹"
	desc = "一枚破片手榴弹。拔掉保险销，扔向敌人，远离弹片。就这么简单！"
	item = /obj/item/grenade/frag
	cost = 1
	limited_stock = 10
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS //nukies get a whole box of these at once at a considerable discount.

/* // SKYRAT EDIT REMOVAL START
/datum/uplink_item/explosives/detomatix
	name = "Detomatix disk"
	desc = "When inserted into a tablet, this cartridge gives you four opportunities to \
			detonate tablets of crewmembers who have their message feature enabled. \
			The concussive effect from the explosion will knock the recipient out for a short period, and deafen them for longer."
	item = /obj/item/disk/computer/virus/detomatix
	cost = 6
	restricted = TRUE
*/ // SKYRAT EDIT REMOVAL END
/datum/uplink_item/explosives/emp
	name = "EMP 手榴弹与植入器套件"
	desc = "一个装有五枚 EMP 手榴弹和一个可使用三次的 EMP 植入体的箱子。当你陷入困境时， \
			可用于瘫痪通讯、安保的能量武器以及硅基生命体。"
	item = /obj/item/storage/box/syndie_kit/emp
	cost = 2

/datum/uplink_item/explosives/emp/New()
	..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CYBERNETIC_REVOLUTION))
		cost *= 3

/datum/uplink_item/explosives/smoke
	name = "烟雾手榴弹"
	desc = "一个装有五枚烟雾手榴弹、一个可使用三次的烟雾植入体和一副防毒面具的箱子。适合用来散播混乱、 \
		不留痕迹地消失，或者抱着手臂姿势怪异地逃跑。"
	item = /obj/item/storage/box/syndie_kit/smoke
	cost = 2

/datum/uplink_item/explosives/pizza_bomb
	name = "披萨炸弹"
	desc = "一个披萨盒，盒盖上巧妙地装着一枚炸弹。需要打开盒子来设定计时器；此后， \
			计时结束后再次打开盒子就会引爆。附赠免费披萨，给你或者你的目标！"
	item = /obj/item/pizzabox/bomb
	cost = 2
	limited_stock = 4
	surplus = 8
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS /// Ops get their own version.

/datum/uplink_item/explosives/syndicate_minibomb
	name = "辛迪加迷你炸弹"
	desc = "迷你炸弹是一枚引信为五秒的手榴弹。引爆时，除了对附近人员造成大量伤害之外， \
			还会在船体上炸出一个小破口。"
	progression_minimum = 30 MINUTES
	item = /obj/item/grenade/syndieminibomb
	cost = 2
	limited_stock = 4
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS /// Ops get their own version.

/datum/uplink_item/explosives/syndicate_bomb/emp
	name = "辛迪加 EMP 炸弹"
	desc = "辛迪加炸弹的一种变体，旨在产生大范围的 EMP 效果。"
	item = /obj/item/sbeacondrop/emp
	cost = 7
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS /// Ops get their own version.
	limited_discount_stock = 4

/datum/uplink_item/explosives/syndicate_bomb/emp/New()
	..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CYBERNETIC_REVOLUTION))
		cost *= 2

/datum/uplink_item/explosives/syndicate_bomb
	name = "辛迪加炸弹"
	desc = "辛迪加炸弹是一种可怕的装置，能造成大规模破坏。它配有可调节的计时器， \
		最短为 %MIN_BOMB_TIMER 秒，并且可以用扳手固定在地面上以防 \
		移动。炸弹体积笨重，无法搬动；订购此物品时，会有一个较小的信标 \
		被传送到你身边，激活后会把真正的炸弹传送到信标处。请注意，这枚炸弹 \
		可以被拆除，有些船员可能会尝试这么做。 \
		炸弹核心可以被撬出来，并用其他爆炸物手动引爆。"
	progression_minimum = 30 MINUTES
	item = /obj/item/sbeacondrop/bomb
	cost = 11
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS /// Ops get their own version.
	limited_discount_stock = 4

/datum/uplink_item/explosives/earthcracker
	name = "E-2 裂地锤"
	desc = "E-2 裂地锤是任何常规爆炸物的绝佳搭档。把这台装置装到任意空间站船体上，开启，然后激活。\
		留下的会是一个常规意义上的危险薄弱点，一旦受到爆炸冲击，就会以随机图案裂开地板。\
		这种裂纹图案又会继续产生更多裂纹，若不修补便会无限蔓延。它也可以用来挖开岩石，不过不太建议这么做。"
	item = /obj/item/earthcracker
	cost = 2
	limited_discount_stock = 2

/datum/uplink_item/explosives/syndicate_bomb/New()
	. = ..()
	desc = replacetext(desc, "%MIN_BOMB_TIMER", SYNDIEBOMB_MIN_TIMER_SECONDS)

/datum/uplink_item/dangerous/cat
	name = "野猫手榴弹盒"
	desc = "这个箱子装有 5 枚手榴弹，每枚里面封印着 5 只在静滞状态下的野猫。激活后，野猫会被唤醒并扑向倒霉的路人。警告：这些猫没有受过分辨敌友的训练！"
	cost = 5
	item = /obj/item/storage/box/syndie_kit/feral_cat_grenades
	surplus = 30
	limited_stock = 2
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS
