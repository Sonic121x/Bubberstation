//Some of the fluff that can spawn in there
/obj/item/paperwork/ntc
	name = "内务档案"
	desc = "厚厚一叠内务档案，记录了各种调查、审计和纪律处分程序；大量内容依中央指挥部的命令被涂黑。"

/obj/item/paperwork/blueshield
	name = "资产保护案件档案"
	desc = "一叠整理凌乱的资产保护部档案，包含事故报告、资产回收简报和秘密准军事行动，大量内容被审查涂黑。你大概不该读它，除非你很向往太空关塔那摩的单程旅行。"

/obj/item/reagent_containers/cup/glass/trophy
	name = "红盾一等奖"
	desc = "你用最糟糕的方式干了一件好事。"

/obj/item/toy/plush/skyrat/fox/mia/vigilant
	name = "警觉狐毛绒玩具"
	desc = "资产保护部吉祥物之一“警觉狐”的可爱商品版本。她戴着蓝色项圈，盾形吊牌上写着 DAP。抱着她会让你感到受到保护。"

/obj/effect/spawner/random/loot/dignitary
	desc = "荣耀归于纳米传讯！"
	var/spawn_additional_loot_chance = 100
	var/list/additional_loot

/obj/effect/spawner/random/loot/dignitary/Initialize(mapload)
	. = ..()
	if(additional_loot?.len && prob(spawn_additional_loot_chance))
		var/loot_to_spawn = pick_weight_recursive(additional_loot)
		var/atom/movable/spawned_loot = make_item(loc, loot_to_spawn)
		spawned_loot.setDir(dir)

/obj/effect/spawner/random/loot/dignitary/consultant
	name = "纳米传讯顾问保险箱生成器"
	loot = null
	additional_loot = list(
		/obj/structure/safe/abovetilefloor = 1
	)

/obj/effect/spawner/random/loot/dignitary/consultant/Initialize(mapload)
	loot = list(
		/obj/item/lighter/royal = 1,
		/obj/item/coin/antagtoken = 1,
		/obj/item/coin/gold = 1,
		/obj/item/toy/plush/slimeplushie = 1,
		/obj/item/megaphone/command = 1,
		/obj/item/book/manual/wiki/security_space_law = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_robustgold = 1,
		/obj/item/toy/plush/carpplushie = 1,
		/obj/item/pizzabox/margherita = 1,
		/obj/item/pizzabox/meat = 1,
		/obj/item/reagent_containers/cup/glass/bottle/applejack = 1,
		/obj/item/reagent_containers/cup/glass/bottle/lizardwine = 1,
		/obj/item/reagent_containers/cup/glass/bottle/whiskey = 1,
		/obj/item/reagent_containers/cup/glass/bottle/hcider = 1,
		/obj/item/lustwish_discount = 1,
		/obj/item/folder/ancient_paperwork = 1,
		/obj/item/reagent_containers/cup/glass/flask = 1,
		/obj/item/storage/fancy/cigarettes/cigars = 1,
		/obj/item/storage/fancy/cigarettes/cigars/cohiba = 1,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 1,
		/obj/item/toy/plush/ghoul = 1,
		/obj/item/toy/figure/dsquad = 1,
		/obj/item/bong = 1,
		/obj/item/gun/ballistic/revolver/protector_revolver = 1,
	)
	. = ..()

	var/obj/structure/safe/loot_inside = locate(/obj/structure/safe) in loc
	if(loot_inside)
		for(var/i = 1 to 2)
			var/loot_to_spawn = pick_weight_recursive(loot)
			make_item(loot_inside, loot_to_spawn)

	make_item(loot_inside, /obj/item/paperwork/ntc)

/obj/effect/spawner/random/loot/dignitary/blueshield
	name = "蓝盾保险箱生成器"
	loot = null
	additional_loot = list(
		/obj/structure/safe/abovetilefloor = 1
	)

/obj/effect/spawner/random/loot/dignitary/blueshield/Initialize(mapload)
	loot = list(
		/obj/item/coin/antagtoken = 1,
		/obj/item/coin/gold = 1,
		/obj/item/holocigarette/masvedishcigar = 1,
		/obj/item/megaphone/command = 1,
		/obj/item/toy/plush/horse = 1,
		/obj/item/book/manual/wiki/security_space_law/weighted = 1,
		/obj/item/storage/medkit/emergency = 1,
		/obj/item/storage/fancy/donut_box = 1,
		/obj/item/radio = 1,
		/obj/item/clothing/erp_leash = 1,
		/obj/item/reagent_containers/cup/glass/bottle/lizardwine = 1,
		/obj/item/reagent_containers/cup/glass/bottle/whiskey = 1,
		/obj/item/reagent_containers/cup/glass/bottle/hcider = 1,
		/obj/item/reagent_containers/cup/glass/bottle/vodka = 1,
		/obj/item/reagent_containers/cup/glass/flask = 1,
		/obj/item/storage/fancy/cigarettes/cigars = 1,
		/obj/item/storage/fancy/cigarettes/cigars/cohiba = 1,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 1,
		/obj/item/toy/figure/dsquad = 1,
		/obj/item/toy/figure/captain = 1,
		/obj/item/toy/figure/syndie = 1,
		/obj/item/toy/plush/skyrat/fox/mia/vigilant = 1,
		/obj/item/reagent_containers/cup/glass/trophy = 1,
	)
	. = ..()

	var/obj/structure/safe/loot_inside = locate(/obj/structure/safe) in loc
	if(loot_inside)
		for(var/i = 1 to 2)
			var/loot_to_spawn = pick_weight_recursive(loot)
			make_item(loot_inside, loot_to_spawn)

	make_item(loot_inside, /obj/item/paperwork/blueshield)
