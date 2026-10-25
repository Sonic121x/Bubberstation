/datum/trader_data/mr_corporate
	shop_spot_type = /obj/structure/chair/wood/wings
	sign_type = null
	sell_sound = 'sound/mobs/non-humanoids/hiss/hiss2.ogg'

	initial_products = list(
		/obj/item/nullrod/claymore/chainsaw_sword/kyle = list(PAYCHECK_CREW * 200, 1),
		/obj/item/sharpener = list(PAYCHECK_CREW * 200, INFINITY),
		/obj/item/book/bible = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/reagent_containers/cup/glass/bottle/holywater = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/grenade/chem_grenade/holy = list(PAYCHECK_CREW * 20, INFINITY),
		/obj/item/ammo_casing/arrow = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/ammo_casing/arrow/holy = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/gun/ballistic/bow/shortbow = list(PAYCHECK_CREW * 40, INFINITY),
		/obj/item/ammo_casing/arrow/holy/blazing = list(PAYCHECK_CREW * 10, INFINITY),
	)

//tome
	initial_wanteds = list(
		/obj/item/fake_items/time_stopper/no_anchor = list(PAYCHECK_CREW * 40, INFINITY, "干掉那个巫师，干得漂亮"),
		/obj/item/fake_items/wabbajack/no_anchor = list(PAYCHECK_CREW * 40, INFINITY, "干掉那个巫师，干得漂亮"),
		/obj/item/fake_items/abductor_win_stick/no_anchor = list(PAYCHECK_CREW * 40, INFINITY, "干掉那个巫师，干得漂亮"),
		/obj/item/clothing/head/collectable/paper = list(PAYCHECK_CREW * 40, INFINITY, "干掉那个巫师，干得漂亮"),
		/obj/item/clothing/suit/wizrobe/paper = list(PAYCHECK_CREW * 40, INFINITY, "干掉那个巫师，干得漂亮"),
		/obj/item/gun/magic/wand/disabler = list(PAYCHECK_CREW * 40, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/boulder/true_boulder = list(PAYCHECK_CREW * 40, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/gun/magic/wand/fireball/inert = list(PAYCHECK_CREW * 40, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/gun/magic/wand/resurrection/inert = list(PAYCHECK_CREW * 40, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/soulstone = list(PAYCHECK_CREW * 40, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/soulstone/anybody = list(PAYCHECK_CREW * 5, 1, "取回违禁品，干得漂亮——哦，我认得这个，我会想办法给空间站派一支小队"),//to-do, spawn a red alert security ert if this item is sold
		/obj/item/soulstone/anybody/chaplain = list(PAYCHECK_CREW * 5, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/soulstone/anybody/chaplain/sparring = list(PAYCHECK_CREW * 5, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/soulstone/anybody/mining = list(PAYCHECK_CREW * 5, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/soulstone/anybody/purified = list(PAYCHECK_CREW * 10, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/soulstone/anybody/revolver = list(PAYCHECK_CREW * 5, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/soulstone/mystic = list(PAYCHECK_CREW * 5, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/guardian_creator/miner = list(PAYCHECK_CREW * 5, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/guardian_creator/wizard = list(PAYCHECK_CREW * 5, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/guardian_creator/carp = list(PAYCHECK_CREW * 5, INFINITY, "取回遗物，干得漂亮"),
		/obj/item/card/emag = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/card/emag/doorjack = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/card/emag/battlecruiser = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮——哦，我认得这个，我会想办法给空间站派一支小队"),//to-do, spawn a red alert security ert if this item is sold
		/obj/item/disk/nuclear/fake = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮，这些东西很难分辨真假"),
		/obj/item/gun/ballistic/revolver/badass = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/crowbar/power/syndicate = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/documents/syndicate = list(PAYCHECK_CREW * 5, INFINITY, "抱歉，但这些已经过时了，我们从里面得不到什么有用的信息。"),
		/obj/item/documents/syndicate/blue = list(PAYCHECK_CREW * 50, INFINITY, "希望你没细看过这些。来，多拿点钱"),
		/obj/item/documents/syndicate/red = list(PAYCHECK_CREW * 50, INFINITY, "希望你没细看过这些。来，多拿点钱。"),
		/obj/item/documents/syndicate/mining = list(PAYCHECK_CREW * 5, INFINITY, "抱歉，但这些已经过时了，我们从里面得不到什么有用的信息"),
		/obj/item/gun/ballistic/rifle/sniper_rifle/syndicate = list(PAYCHECK_CREW * 60, INFINITY, "哇哦——我的天 *吹口哨* 一把漂亮的 .50 口径狙击步枪，这个我收下了"),//to-do, make it appear on his back after purchasing this
		/obj/item/mod/control/pre_equipped/empty/syndicate = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/storage/toolbox/syndicate = list(PAYCHECK_CREW * 5, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/toy/cards/deck/syndicate = list(PAYCHECK_CREW * 1, INFINITY, "这其实不算真的违禁品，不过我还是收下了"),
		/obj/item/syndicate_teleporter = list(PAYCHECK_CREW * 5, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/encryptionkey/syndicate = list(PAYCHECK_CREW * 5, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/clothing/suit/space/syndicate/black/red = list(PAYCHECK_CREW * 5, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/clothing/head/helmet/space/syndicate/black/red = list(PAYCHECK_CREW * 5, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/gun/ballistic/automatic/pistol/contraband = list(PAYCHECK_CREW * 10, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/gun/ballistic/rifle/rebarxbow/syndie = list(PAYCHECK_CREW * 10, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/mod/control/pre_equipped/traitor = list(PAYCHECK_CREW * 10, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/mod/control/pre_equipped/traitor_elite = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/melee/energy/sword = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/melee/energy/axe = list(PAYCHECK_CREW * 100, INFINITY, "搞什么鬼——算了，钱给你"),
		/obj/item/dualsaber = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮"),
		/obj/item/dualsaber/red = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮"),
		/obj/effect/fun_balloon = list(PAYCHECK_CREW * 0, INFINITY, "我为什么要在意一个印着 S 的红气球？！"),
		/obj/item/nuke_core = list(PAYCHECK_CREW * 40, INFINITY, "*他举起双手，挡住那块钚石* 我的天，你为什么把这东西带来给我？！*他随后似乎想起自己的防护服是防辐射的，然后一把从你手中把它夺了过去*"),
		/obj/item/melee/supermatter_sword = list(PAYCHECK_CREW * 200, INFINITY, "*他一言不发地盯着你，感觉足有两分钟* 呃——那什么，这是你们空间站研发部挺有意思的产品——我就收下了"),
		/obj/item/melee/cultblade/haunted = list(PAYCHECK_CREW * 20, 1, "取回违禁品，干得漂亮——哦，这是纳尔西专用的装备……我会派一队人去空间站"),//to-do, spawn a red alert inquisition ert if this item is sold
		/obj/item/seeds/kudzu = list(PAYCHECK_CREW * 20, INFINITY, "取回违禁品，干得漂亮"),
	)

	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"抱歉，你拿出来的东西我一件都不感兴趣。给我点更好的，我们再谈。",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"真可惜，改变主意了就告诉我。",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"和你做生意很愉快，如果你给我的够多，我可以帮你疏通一下，也许能给你升个职。",
		),
		INTERESTED_PHRASE = list(
			"嘿，你手上有个东西我很感兴趣，我想买下它，会付你一笔现金，成交吗？",
		),
		BUY_PHRASE = list(
			"好好享受这些额外信用点吧，奴——我是说，宝贵又可敬的员工",
		),
		NO_CASH_PHRASE = list(
			"抱歉，打工仔，等你稍微嗯……更有钱点再来吧！",
		),
		NO_STOCK_PHRASE = list(
			"这些东西我每种只放出一件，上头只允许我做到这个程度——磨刀石除外。",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"这东西我暂时不想买，下次再来看看吧。",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"仔细一看这东西似乎一文不值，我不买。",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"这东西我暂时已经买够了。",
		),
		TRADER_LORE_PHRASE = list(
			"你好，宝贵的员工。我们在北边发现了一大群巫师！我不跟你绕弯子，去把他们杀了，他们要是掉了什么魔法玩意儿，就拿来给我；或者从空间站那边弄到任何违禁品带给我，我都收。",
			"你好，宝贵的员工。我们在北边发现了一大群巫师！我不跟你绕弯子，去把他们杀了，他们要是掉了什么魔法玩意儿，就拿来给我；或者从空间站那边弄到任何违禁品带给我，我都收。",
			"你好，打工仔。我们在北边发现了一大群巫师！我不跟你绕弯子，去把他们杀了，他们要是掉了什么魔法玩意儿，就拿来给我；或者从空间站那边弄到任何违禁品带给我，我都收。",
			"你好，奴隶。我们在北边发现了一大群巫师！我不跟你绕弯子，去把他们杀了，他们要是掉了什么魔法玩意儿，就拿来给我；或者从空间站那边弄到任何违禁品带给我，我都收。",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"你身上没有值得我付钱的东西。",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"我目前什么都不卖。",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"就因为这件事，我要把你降职！",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"算了，反正他们会被重新克隆一次然后忘掉这事，不过我会把这记进他们的内部档案。",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"很简单：往北走，搞到遗物，卖给我；回到空间站，搞到违禁品，再卖给我。",
		),
	)
