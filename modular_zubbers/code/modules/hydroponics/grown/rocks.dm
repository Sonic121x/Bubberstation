/obj/item/seeds/rockfruit
	name = "一包岩果幼苗"
	desc = "魔像岩果植株的小幼苗。包装上贴着一张警告标签：\n\
	“请记住：从法律上讲，玩摇滚可比拿石头砸人合法多了。 \n \
	对于因使用或种植这些植物而造成的任何伤害、死亡或全身蒸发，我们概不负责”"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-rockfruit"
	species = "rock"
	plantname = "岩果"
	product = /obj/item/grown/rockfruit
	mutatelist = list(/obj/item/seeds/sandfruit)

	lifespan = 20
	endurance = 45

	potency = 15
	maturation = 8
	production = 4
	yield = 2
	instability = 0 // Rocks are very stable


	growthstages = 2
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'

	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy,
				/datum/plant_gene/trait/fire_resistance,
				/datum/plant_gene/trait/stable_stats, // It's a rock
				/datum/plant_gene/trait/preserved)

	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.01,
						/datum/reagent/consumable/nutriment = 0.01,
						)


/obj/item/grown/rockfruit
	seed = /obj/item/seeds/rockfruit

	name = "岩果"
	desc = "一块岩果，魔像一族常吃。内部似乎是果肉，外面则是坚硬的岩石外壳。"
	force = 5 // Comparatively shit considering a nettle is 15
	throwforce = 10 // Less shit but hey, it is a rock

	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "rockfruit"

	var/product = /obj/item/food/grown/rockfruit

/obj/item/grown/rockfruit/attack_self(mob/user, modifiers)
	user.show_message(span_notice("你开始剥去外面的岩石壳……"))
	if(!(do_after(user, 2 SECONDS)))
		return
	user.show_message(span_notice("你剥下岩果的岩石外壳，露出里面甜美的果肉！"))
	balloon_alert(user, "已剥开")

	// The fruit inside
	var/obj/item/food/grown/peel_prod
	peel_prod = new product(user.loc, new_seed = seed) // I stole this from seed code and am physically crying and shaking

	// The rocky shell
	new /obj/item/food/golem_food/rocks(user.loc)

	qdel(src)
	user.put_in_hands(peel_prod)

/obj/item/food/grown/rockfruit
	seed = /obj/item/seeds/rockfruit

	name = "岩果果心"
	desc = "岩果内部的果肉！甜度不高，但依然美味。魔像一族常拿它来搭配自己的岩石食物。 \
	说来奇怪，他们并不喜欢单独吃这个"

	foodtypes = FRUIT

	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "rockfruit-peeled"

	tastes = list("高山" = 1)

/obj/item/food/golem_food/rocks
	name = "剥开的岩果外壳"
	desc = "剥下来的岩果外壳，或者按你的说法——“名副其实的一堆石头”。 \
	大概不能吃，但魔像会想方设法证明你错了"

	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "rockfruit-trash"

	foodtypes = STONE
	food_reagents = list(/datum/reagent/consumable/nutriment/mineral = 5)

	tastes = list("岩石与石头" = 1)

/datum/reagent/consumable/nutriment/mineral
	taste_description = "岩石与石头"


//Rockfruits evolutions? OREFRUITS!//
//Sand - Base tier breaks into 4 trees ('energy', Precious, Metal, Miscmats)
/obj/item/seeds/sandfruit
	name = "沙果种子包"
	desc = "这些种子会长出沙果。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-sandfruit"
	species = "ore"
	plantname = "沙果"
	product = /obj/item/food/grown/material_sand
	mutatelist = list(/obj/item/seeds/uraniberry,
					/obj/item/seeds/agbergine,
					/obj/item/seeds/ferrotuber,
					/obj/item/seeds/adamapple)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/silicon = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_sand
	seed = /obj/item/seeds/sandfruit
	name = "沙果"
	desc = "岩果的变异品种；粗糙、硌手，如今随处可见。剥开就能得到果心。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/sandfruitcore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/silicon

/obj/item/stack/sheet/mineral/sandfruitcore
	name = "沙果果心"
	desc = "一枚极其脆弱的沙果果心，实际上就是由几十颗沙粒构成的……别往口袋里放。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	singular_name = "沙果果心"
	icon_state = "sandfruit"
	merge_type = /obj/item/stack/sheet/mineral/sandfruitcore
	max_amount = 10
	mats_per_unit = list(/datum/material/glass=SHEET_MATERIAL_AMOUNT*0.2)

//Uranium - First on 'energy' line

/obj/item/seeds/uraniberry
	name = "铀莓种子包"
	desc = "这些种子会长出连上帝都觉得本不该存在的“浆果”。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-uraniberry"
	species = "ore"
	plantname = "铀莓"
	product = /obj/item/food/grown/material_uraniberry
	mutatelist = list(/obj/item/seeds/plasmaplum)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/uranium = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_uraniberry
	seed = /obj/item/seeds/uraniberry
	name = "铀莓"
	desc = "岩果的变异品种；你大概不会想握它太久……而且它其实不是浆果！剥开就能得到果心。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/uraniberrycore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/uranium

/obj/item/stack/sheet/mineral/uraniberrycore
	name = "铀莓果心"
	singular_name = "铀莓果心"
	desc = "一枚密度极高的铀莓果心，别往口袋里放，除非你想要多长几条肢体。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "uraniberry"
	merge_type = /obj/item/stack/sheet/mineral/uraniberrycore
	max_amount = 10
	mats_per_unit =list(/datum/material/uranium=SHEET_MATERIAL_AMOUNT*0.2)

//Plasma - Second stage of 'energy' line.

/obj/item/seeds/plasmaplum
	name = "等离子李种子包"
	desc = "这些种子会长出极不稳定的“李子”。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-plasmaplum"
	species = "ore"
	plantname = "等离子李"
	product = /obj/item/food/grown/material_plasmaplum
	mutatelist = list(/obj/item/seeds/bluegemdrupe)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/toxin/plasma = 0.1)
	growthstages = 2
	rarity = 40
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_plasmaplum
	seed = /obj/item/seeds/plasmaplum
	name = "等离子李"
	desc = "岩果的变异品种；极不稳定……而且它其实不是李子！剥开就能得到果心。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/plasmaplumcore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/toxin/plasma

/obj/item/stack/sheet/mineral/plasmaplumcore
	name = "等离子李果心"
	singular_name = "等离子李果心"
	desc = "一枚密度极高的等离子李果心，请存放在阴凉、远离火焰与火花的地方。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "plasmaplum"
	merge_type = /obj/item/stack/sheet/mineral/plasmaplumcore
	max_amount = 10
	mats_per_unit = list(/datum/material/plasma=SHEET_MATERIAL_AMOUNT*0.2)

//Bluespace - ending of 'energy' line.

/obj/item/seeds/bluegemdrupe
	name = "蓝宝石核果种子包"
	desc = "这些种子会长出极不稳定的“核果”。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-bluegemdrupe"
	species = "ore"
	plantname = "蓝宝石核果"
	product = /obj/item/food/grown/material_bluegemdrupe
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/bluespace = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_bluegemdrupe
	seed = /obj/item/seeds/bluegemdrupe
	name = "蓝宝石核果"
	desc = "岩果的变异品种；极其脆弱……而且它其实不是核果！剥开就能得到果心。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/bluegemdrupecore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/bluespace

/obj/item/stack/sheet/mineral/bluegemdrupecore
	name = "蓝宝石核果果心"
	singular_name = "蓝宝石核果果心"
	desc = "一枚密度极高的蓝宝石核果果心，掉落时极少数情况下可能引发传送。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "bluegemdrupe"
	merge_type = /obj/item/stack/sheet/mineral/bluegemdrupecore
	max_amount = 10
	mats_per_unit = list(/datum/material/bluespace=SHEET_MATERIAL_AMOUNT*0.2)

//Silver - Agbergine (Get it? AG, silver?!) - First on 'precious' line

/obj/item/seeds/agbergine
	name = "银茄种子包"
	desc = "这些种子会长出果心为纯银的果实。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-agbergine"
	species = "ore"
	plantname = "银茄"
	product = /obj/item/food/grown/material_agbergine
	mutatelist = list(/obj/item/seeds/aubergine)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/silver = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_agbergine
	seed = /obj/item/seeds/agbergine
	name = "银茄"
	desc = "银茄，懂了吧，银就是 AG？既好笑又值钱！剥开就能得到果心。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/agberginecore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/silver

/obj/item/stack/sheet/mineral/agberginecore
	name = "银茄果心"
	singular_name = "银茄果心"
	desc = "一枚坚实的银茄果心，由纯正白银构成。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "agbergine"
	merge_type = /obj/item/stack/sheet/mineral/agberginecore
	max_amount = 10
	mats_per_unit = list(/datum/material/silver=SHEET_MATERIAL_AMOUNT*0.2)

//Gold - Au-bergine (Pretty sure you can work this one out) - Second stage of 'precious' line.

/obj/item/seeds/aubergine
	name = "金茄种子包"
	desc = "这些种子会长出果心为黄金的果实。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-aubergine"
	species = "ore"
	plantname = "金茄"
	product = /obj/item/food/grown/material_aubergine
	mutatelist = list(/obj/item/seeds/dimantis)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/gold = 0.1)
	growthstages = 2
	rarity = 40
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_aubergine
	seed = /obj/item/seeds/aubergine
	name = "金茄"
	desc = "一枚金茄；AU？懂了吧？！……我的才华在这里真是浪费了！剥开就能得到果心。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/auberginecore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/gold

/obj/item/stack/sheet/mineral/auberginecore
	name = "金茄果心"
	singular_name = "金茄果心"
	desc = "一枚密度极高的金茄果心，实打实的 24K 好货。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "aubergine"
	merge_type = /obj/item/stack/sheet/mineral/auberginecore
	max_amount = 10
	mats_per_unit = list(/datum/material/gold=SHEET_MATERIAL_AMOUNT*0.2)

//Dimantis - ending of 'precious' line.

/obj/item/seeds/dimantis
	name = "钻果种子包"
	desc = "这些种子会长出极其珍贵的钻果。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-dimantis"
	species = "ore"
	plantname = "钻果"
	product = /obj/item/food/grown/material_dimantis
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/carbon = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_dimantis
	seed = /obj/item/seeds/dimantis
	name = "钻果"
	desc = "多肉的果实，果心是钻石。剥开就能得到果心。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/dimantiscore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/carbon

/obj/item/stack/sheet/mineral/dimantiscore
	name = "钻果果心"
	singular_name = "钻果果心"
	desc = "一枚密度极高的钻果果心，通往女人心灵的道路——它大概能直接穿透她的肋骨……"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "dimantis"
	merge_type = /obj/item/stack/sheet/mineral/dimantiscore
	max_amount = 10
	mats_per_unit = list(/datum/material/diamond=SHEET_MATERIAL_AMOUNT*0.2)

//Iron - Ferrotubers - First on 'metal' line

/obj/item/seeds/ferrotuber
	name = "铁薯种子包"
	desc = "这些种子会长出果心为铁的块茎。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-ferrotuber"
	species = "ore"
	plantname = "铁薯"
	product = /obj/item/food/grown/material_ferrotuber
	mutatelist = list(/obj/item/seeds/titanituber)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/iron = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_ferrotuber
	seed = /obj/item/seeds/ferrotuber
	name = "铁薯"
	desc = "铁薯，肉质的表皮里填满了铁屑！剥开就能得到果心。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/ferrotubercore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/iron

/obj/item/stack/sheet/mineral/ferrotubercore
	name = "铁薯果心"
	singular_name = "铁薯果心"
	desc = "一枚坚实的铁薯果心，由纯铁构成，略带磁性。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "ferrotuber"
	merge_type = /obj/item/stack/sheet/mineral/ferrotubercore
	max_amount = 10
	mats_per_unit = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*0.2)

//Titanium - titanituber - Second stage of 'metal' line.

/obj/item/seeds/titanituber
	name = "钛薯种子包"
	desc = "这些种子会长出钛薯。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-titanituber"
	species = "ore"
	plantname = "钛薯"
	product = /obj/item/food/grown/material_titanituber
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	growthstages = 2
	rarity = 40
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_titanituber
	seed = /obj/item/seeds/titanituber
	name = "钛薯"
	desc = "果肉柔软、果心却坚硬无比的果实，小心你的牙齿！剥开就能得到果心。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/titanitubercore
	foodtypes = FRUIT

/obj/item/stack/sheet/mineral/titanitubercore
	name = "钛薯果心"
	singular_name = "钛薯果心"
	desc = "一枚密度极高的钛薯果心，希望你还没咬上去！"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "titanituber"
	merge_type = /obj/item/stack/sheet/mineral/titanitubercore
	max_amount = 10
	mats_per_unit = list(/datum/material/titanium=SHEET_MATERIAL_AMOUNT*0.2)

//Adamantine - First on 'misc' line

/obj/item/seeds/adamapple
	name = "亚当果种子包"
	desc = "这些种子会长出果心为精金的果实。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-adamapple"
	species = "ore"
	plantname = "亚当果"
	product = /obj/item/food/grown/material_adamapple
	mutatelist = list(/obj/item/seeds/runescooper)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_adamapple
	seed = /obj/item/seeds/adamapple
	name = "亚当果"
	desc = "亚当果，伊甸园的馈赠！剥开就能得到果心。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/adamapplecore
	foodtypes = FRUIT

/obj/item/stack/sheet/mineral/adamapplecore
	name = "亚当果果心"
	singular_name = "亚当果果心"
	desc = "一枚坚实的亚当果果心，由纯精金构成。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "adamapple"
	merge_type = /obj/item/stack/sheet/mineral/adamapplecore
	max_amount = 10
	mats_per_unit = list(/datum/material/adamantine=SHEET_MATERIAL_AMOUNT*0.2)

//Runite - Second stage of 'misc' line.

/obj/item/seeds/runescooper
	name = "符文果种子包"
	desc = "这些种子会长出稀有而野性的果实。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-runescooper"
	species = "ore"
	plantname = "符文果"
	product = /obj/item/food/grown/material_runescooper
	mutatelist = list(/obj/item/seeds/bananiumberry)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_runescooper
	seed = /obj/item/seeds/runescooper
	name = "符文果"
	desc = "一种果实，通常生长在人们会为利益互相残杀的荒野之地。"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/runescoopercore
	foodtypes = FRUIT

/obj/item/stack/sheet/mineral/runescoopercore
	name = "符文果果心"
	singular_name = "符文果果心"
	desc = "一枚密度极高的符文矿果心，再攒上几个，你说不定就能打出一把弯刀去击败敌人了……"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "runescooper"
	merge_type = /obj/item/stack/sheet/mineral/runescoopercore
	max_amount = 10
	mats_per_unit = list(/datum/material/runite=SHEET_MATERIAL_AMOUNT*0.2)

//bananiumberry - ending of 'misc' line.

/obj/item/seeds/bananiumberry
	name = "香蕉矿莓种子包"
	desc = "这些种子会长出亵渎至极的怪物果实。"
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-bananiumberry"
	species = "ore"
	plantname = "香蕉矿莓"
	product = /obj/item/food/grown/material_bananiumberry
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/consumable/nutriment/soup/clown_tears = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_bananiumberry
	seed = /obj/item/seeds/bananiumberry
	name = "香蕉矿莓"
	desc = "洪克之母啊……这果实的果心竟是香蕉矿，剥开它吧！"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/bananiumberrycore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/consumable/nutriment/soup/clown_tears

/obj/item/stack/sheet/mineral/bananiumberrycore
	name = "香蕉矿莓果心"
	singular_name = "香蕉矿莓果心"
	desc = "一枚密度极高的香蕉矿果心，通往小丑心灵的道路——它大概能直接穿透他们的肋骨……"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "bananiumberry"
	merge_type = /obj/item/stack/sheet/mineral/bananiumberrycore
	max_amount = 10
	mats_per_unit = list(/datum/material/bananium=SHEET_MATERIAL_AMOUNT*0.2)
