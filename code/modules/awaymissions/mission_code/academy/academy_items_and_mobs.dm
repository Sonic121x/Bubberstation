//the one boulder to rule them all, rust reference
/obj/item/boulder/true_boulder
	name = "一石统御万石"
	desc = "一块配重良好、易于握持的石头，其中一面握起来顺手又舒服；你可以轻松用它砸开别人的脑袋，或者开采金属矿脉。"
	icon_state = "ore"
	icon = 'icons/obj/ore.dmi'
	item_flags = NO_MAT_REDEMPTION | SLOWS_WHILE_IN_HAND
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 25 // rock
	throw_range = 5
	force = 25 // the one rock to rule them all
	armour_penetration = 100 //the rock does not care what you wear
	block_chance = 25 // funny
	tk_throw_range = 0 // no fancy magic tricks with the rock
	throw_speed = 0.5
	slowdown = 2
	drag_slowdown = 1.5 // It's still a big rock.

/obj/item/fake_items/time_stopper/no_anchor
	anchored = 0

/obj/item/fake_items/wabbajack/no_anchor
	anchored = 0

/obj/item/fake_items/abductor_win_stick/no_anchor
	anchored = 0

/obj/item/reagent_containers/condiment/protein/wizbulk
	name = "巫师增肌粉，为非天生奇才者带来非自然增益"
	desc = "背面有一小块字样写着“对未受魔法亲和者无效”。"

/obj/item/nullrod/claymore/chainsaw_sword/kyle
	name = "凯尔"
	desc = "一把链锯剑，其剑刃被加热到近乎白热。这玩意儿他妈的为什么叫凯尔？为什么不叫焚化者、异端熔炉之类的名字。"
	damtype = BURN
	chaplain_spawnable = FALSE
	station_holy_item = FALSE
	force = 30

//mobs start here
/mob/living/basic/wizard/buffwiz
	name = "壮硕巫师"
	desc = "看来并非所有巫师都会舍弃自己的肉身。"
	speed = 0
	maxHealth = 500
	health = 500
	melee_damage_lower = 50
	melee_damage_upper = 50

/mob/living/basic/wizard/tired
	name = "过劳巫师"
	desc = "这名巫师似乎并不敌视你，也完全没注意到你；他正手忙脚乱地对 MOD 外骨骼做些什么——看起来像是在改造它。也许你能从他那儿顺走点什么。"
	speed = 0
	maxHealth = 75
	health = 75
	melee_damage_lower = 4
	melee_damage_upper = 4
	faction = list(FACTION_NEUTRAL)

/mob/living/basic/wizard/high_magus
	name = "高阶法师"
	desc = "此地区的高阶法师，也只是一位略强于平均水平的巫师。"
	speed = 0
	maxHealth = 750
	health = 750
	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/basic/skeleton/templar/academy
	name = "亡灵骑士护卫"
	desc = "一名骑士被重新唤起躯体的遗骸，这一具似乎是名护卫。"
	loot = list(
		/obj/effect/decal/remains/human,
		/obj/item/clothing/suit/armor/riot/knight/greyscale,
		/obj/item/clothing/head/helmet/knight/greyscale,
		/obj/item/claymore/weak,
		/obj/item/shield/buckler,
	)
	outfit = /datum/outfit/academy_knight
	faction = list(ROLE_WIZARD)

/datum/outfit/academy_knight
	name = "骑士"
	uniform = /obj/item/clothing/under/costume/gamberson/military
	mask = /obj/item/clothing/mask/bandana
	ears = /obj/item/radio/headset
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/riot/knight/greyscale
	back = /obj/item/storage/backpack/cultpack
	head = /obj/item/clothing/head/helmet/knight/greyscale
	l_hand = /obj/item/claymore
	r_hand = /obj/item/shield/buckler

/mob/living/basic/trooper/nanotrasen/ranged/elite/traitor
	name = "叛变纳米传讯精英突击军官"
	desc = "一名叛变的纳米传讯精英突击军官。"
	faction = list(ROLE_WIZARD)

/mob/living/basic/skeleton/templar/leader
	name = "骑士首领"
	desc = "这一具并未像其他同类那样被困在玻璃之后或被人呼来喝去，它一定是它们的头目。"
	maxHealth = 450
	health = 450
	melee_damage_lower = 35
	melee_damage_upper = 35
