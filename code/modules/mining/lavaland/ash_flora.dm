//*******************Contains everything related to the flora on lavaland.*******************************
//This includes: The structures, their produce, their seeds and the crafting recipe for the mushroom bowl

/obj/structure/flora/ash
	name = "大型蘑菇"
	desc = "几朵大型蘑菇，覆着一层薄薄的灰烬，还有些只能被称作孢子的东西。"
	icon = 'icons/obj/mining_zones/ash_flora.dmi'
	icon_state = "l_mushroom1"
	base_icon_state = "l_mushroom"
	resistance_flags = LAVA_PROOF
	gender = PLURAL
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER //sporangiums up don't shoot
	harvest_with_hands = TRUE
	harvested_name = "矮小的蘑菇"
	harvested_desc = "一些正在快速再生的蘑菇，它们原本相当大。"
	harvest_message_low = "你摘下一朵蘑菇，但没能从伞盖上收集到多少薄片。"
	harvest_message_med = "你摘下一朵蘑菇，小心地收集伞盖上的薄片。"
	harvest_message_high = "你从几朵蘑菇的伞盖上采集并收集了薄片。"
	harvest_message_true_thresholds = TRUE
	harvest_verb = "摘取"
	flora_flags = FLORA_HERBAL //not really accurate but what sound do hit mushrooms make anyway
	var/number_of_variants = 4

/obj/structure/flora/ash/Initialize(mapload)
	. = ..()
	base_icon_state = "[base_icon_state][rand(1, number_of_variants)]"
	icon_state = base_icon_state

/obj/structure/flora/ash/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/shavings = 1)

/obj/structure/flora/ash/harvest(user, product_amount_multiplier)
	if(!..())
		return FALSE
	icon_state = "[base_icon_state]p"
	return TRUE

/obj/structure/flora/ash/regrow()
	..()
	icon_state = base_icon_state

/obj/structure/flora/ash/tall_shroom //exists only so that the spawning check doesn't allow these spawning near other things
	regrowth_time_low = 7 MINUTES

/obj/structure/flora/ash/leaf_shroom
	name = "多叶蘑菇"
	desc = "几朵蘑菇，每一朵都用若干叶片状结构包围着一个浅绿色的孢子囊。"
	icon_state = "s_mushroom1"
	base_icon_state = "s_mushroom"
	harvested_name = "无叶蘑菇"
	harvested_desc = "一堆被摘光叶子的蘑菇，孢子囊裸露在外。真是不堪入目？"
	harvest_amount_high = 4
	harvest_message_low = "你摘下一片合适的叶子。"
	harvest_message_med = "你摘下一些叶子，留下几片不合适的。"
	harvest_message_high = "你摘下了相当多合适的叶子。"
	harvest_time = 20
	regrowth_time_low = 4 MINUTES
	regrowth_time_high = 10 MINUTES

/obj/structure/flora/ash/leaf_shroom/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/mushroom_leaf = 1)

/obj/structure/flora/ash/cap_shroom
	name = "高蘑菇"
	desc = "几朵蘑菇，其中较大的那些在菌柄中段长着一圈层菌。"
	icon_state = "r_mushroom1"
	base_icon_state = "r_mushroom"
	harvested_name = "小蘑菇"
	harvested_desc = "几朵小蘑菇，长在大概原本是大型蘑菇的残桩旁。"
	harvest_amount_high = 4
	harvest_message_low = "你切下一朵蘑菇的伞盖。"
	harvest_message_med = "你从较大的蘑菇上切下几块层菌。"
	harvest_message_high = "你从这些蘑菇上切下若干伞盖与层菌。"
	harvest_time = 50
	regrowth_time_low = 5 MINUTES
	regrowth_time_high = 9 MINUTES

/obj/structure/flora/ash/cap_shroom/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/mushroom_cap = 1)

/obj/structure/flora/ash/stem_shroom
	name = "众多蘑菇"
	desc = "大量蘑菇，其中一些长着肥厚的长菌柄。它们正在发光！"
	icon_state = "t_mushroom1"
	base_icon_state = "t_mushroom"
	light_range = 1.5
	light_power = 2.1
	harvested_name = "微小蘑菇"
	harvested_desc = "几朵小蘑菇长在较大的残桩周围。你已经能看到它们正在长回来。"
	harvest_amount_high = 4
	harvest_message_low = "你摘下一朵蘑菇并切掉伞盖，留下菌柄。"
	harvest_message_med = "你摘下并斩首几朵蘑菇，取走它们的菌柄。"
	harvest_message_high = "你从这些蘑菇上取下了若干菌柄。"
	harvest_time = 40
	regrowth_time_low = 5 MINUTES
	regrowth_time_high = 10 MINUTES

/obj/structure/flora/ash/stem_shroom/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/mushroom_stem = 1)

/obj/structure/flora/ash/cacti
	name = "结果仙人掌"
	desc = "几株带刺的仙人掌，结满了成熟的果实，表面覆着一层薄灰。"
	icon_state = "cactus1"
	base_icon_state = "cactus"
	harvested_name = "仙人掌"
	harvested_desc = "一丛带刺的仙人掌。你能看到果实在灰烬覆盖下缓缓生长。"
	harvest_amount_high = 2
	harvest_message_low = "你摘下一颗仙人掌果。"
	harvest_message_med = "你摘下几颗仙人掌果。" //shouldn't show up, because you can't get more than two
	harvest_message_high = "你摘下一对仙人掌果。"
	harvest_time = 10
	regrowth_time_low = 8 MINUTES
	regrowth_time_high = 12 MINUTES
	can_uproot = FALSE //Don't want 50 in one tile to decimate whoever dare step on the mass of cacti

/obj/structure/flora/ash/cacti/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, min_damage = 3, max_damage = 6, probability = 70)

/obj/structure/flora/ash/cacti/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/cactus_fruit = 20, /obj/item/seeds/lavaland/cactus = 1)

/obj/structure/flora/ash/seraka
	name = "塞拉卡蘑菇"
	desc = "一小丛塞拉卡蘑菇。这些一定是跟着灰行者来的。"
	icon_state = "seraka_mushroom1"
	base_icon_state = "seraka_mushroom"
	harvested_name = "已采摘的塞拉卡蘑菇"
	harvested_desc = "几朵小小的塞拉卡蘑菇，较大的那些明显刚被摘走。它们迟早会长回来……"
	harvest_amount_high = 6
	harvest_message_low = "你摘下几朵上好的美味蘑菇。"
	harvest_message_med = "你收获了满满一把蘑菇。"
	harvest_message_high = "你撞上了蘑菇富矿，抱走了一大把美味蘑菇。"
	harvest_time = 25
	regrowth_time_low = 5 MINUTES
	regrowth_time_high = 9 MINUTES
	number_of_variants = 2
	harvest_message_true_thresholds = FALSE

/obj/structure/flora/ash/seraka/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/seraka = 1)

/obj/structure/flora/ash/fireblossom
	name = "烈焰花"
	desc = "一种奇特的花，常见于熔岩池附近。"
	icon_state = "fireblossom1"
	base_icon_state = "fireblossom"
	light_range = LIGHT_FIRE_BLOSSOM
	light_power = LIGHT_FIRE_BLOSSOM
	light_color = COLOR_BIOLUMINESCENCE_YELLOW
	harvested_name = "烈焰花茎"
	harvested_desc = "几根烈焰花茎，花已经不在了。"
	harvest_amount_high = 3
	harvest_message_low = "你摘下一朵合适的花。"
	harvest_message_med = "你摘下几朵花，留下几朵不合适的。"
	harvest_message_high = "你摘下了相当多合适的花。"
	regrowth_time_low = 4 MINUTES
	regrowth_time_high = 7 MINUTES
	number_of_variants = 2

/obj/structure/flora/ash/fireblossom/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/fireblossom = 1)

/obj/structure/flora/ash/fireblossom/after_harvest()
	set_light_power(LIGHT_RANGE_FIRE_BLOSSOM_HARVESTED)
	set_light_range(LIGHT_POWER_FIRE_BLOSSOM_HARVESTED)
	update_light()
	return ..()

/obj/structure/flora/ash/fireblossom/regrow()
	set_light_power(initial(light_power))
	set_light_range(initial(light_range))
	update_light()
	return ..()

/obj/structure/flora/ash/glowgrowth
	name = "辉光菌群落"
	desc = "生长在热风喷口上的一群生物发光真菌，靠喷口吹出的矿物微粒为食。"
	icon_state = "glowgrowth1"
	base_icon_state = "glowgrowth"
	density = TRUE // Large rock formations with plants ontop
	light_range = 1.7
	light_power = 1.2
	light_color = "#67b6a5"
	harvested_name = "热风喷口"
	harvested_desc = "一处布满脊状纹路的多孔岩层，正从行星深处呼出热气。"
	harvest_amount_high = 4
	harvest_verb = "刮取"
	harvest_message_low = "你刮下一层薄薄的发光真菌。"
	harvest_message_med = "你摘下一大块发光真菌。"
	harvest_message_high = "你抓了一大把发光真菌。"
	regrowth_time_low = 8 MINUTES
	regrowth_time_high = 16 MINUTES
	number_of_variants = 3

/obj/structure/flora/ash/glowgrowth/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/structure/flora/ash/glowgrowth/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/glowgrowth = 1)

/obj/structure/flora/ash/glowgrowth/after_harvest()
	set_light_on(FALSE)
	update_light()
	update_appearance()
	return ..()

/obj/structure/flora/ash/glowgrowth/regrow()
	set_light_on(TRUE)
	update_light()
	update_appearance()
	return ..()

/obj/structure/flora/ash/glowgrowth/update_overlays()
	. = ..()
	if (!harvested)
		. += emissive_appearance(icon, "[icon_state]e", src, alpha = 120)

///Snow flora to exist on icebox.
/obj/structure/flora/ash/chilly
	name = "弹跳草果"
	desc = "几株明亮、富有弹性的蓝色结果植物。它们似乎毫不在意这严酷寒冷的环境。"
	icon_state = "chilly_pepper1"
	base_icon_state = "chilly_pepper"
	harvested_name = "弹跳草"
	harvested_desc = "一丛富有弹性的结果草，果子已被摘光。又或者它们从来就没结过果？"
	harvest_amount_high = 3
	harvest_message_low = "你摘下一颗弯曲的果实。"
	harvest_message_med = "你摘下几颗弯曲的果实。"
	harvest_message_high = "你摘下相当多弯曲的果实。"
	harvest_time = 15
	regrowth_time_low = 2400
	regrowth_time_high = 5500
	number_of_variants = 2

/obj/structure/flora/ash/chilly/get_potential_products()
	return list(/obj/item/food/grown/icepepper = 1)

//SNACKS

/obj/item/food/grown/ash_flora
	name = "不明植物的碎块"
	desc = "这是什么？是个入侵物种。快去告诉别人。"
	icon = 'icons/obj/mining_zones/ash_flora.dmi'
	icon_state = "mushroom_shavings"
	abstract_type = /obj/item/food/grown/ash_flora
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	max_integrity = 100
	foodtypes = VEGETABLES

/obj/item/food/grown/ash_flora/Initialize(mapload)
	. = ..()
	pixel_x = base_pixel_x + rand(-4, 4)
	pixel_y = base_pixel_y + rand(-4, 4)

/obj/item/food/grown/ash_flora/shavings
	name = "蘑菇薄片"
	desc = "从高蘑菇上削下的薄片。凑够数量或许能做成碗。"
	seed = /obj/item/seeds/lavaland/polypore
	wine_power = 20

/obj/item/food/grown/ash_flora/shavings/grind_results()
	return list(/datum/reagent/toxin/mushroom_powder = 5)

/obj/item/food/grown/ash_flora/mushroom_leaf
	name = "蘑菇叶"
	desc = "一片叶子，来自蘑菇。"
	icon_state = "mushroom_leaf"
	seed = /obj/item/seeds/lavaland/porcini
	wine_power = 40
	special_desc_requirement = EXAMINE_CHECK_JOB //SKYRAT EDIT
	special_desc_jobs = list("Botanist") //SKYRAT EDIT
	special_desc = "这种植物营养丰富、有益健康，不过掺有少量尼古丁。" //SKYRAT EDIT

/obj/item/food/grown/ash_flora/mushroom_cap
	name = "蘑菇伞盖"
	desc = "一朵大型蘑菇的伞盖。"
	icon_state = "mushroom_cap"
	seed = /obj/item/seeds/lavaland/inocybe
	wine_power = 70
	special_desc_requirement = EXAMINE_CHECK_JOB //SKYRAT EDIT
	special_desc_jobs = list("Botanist") //SKYRAT EDIT
	special_desc = "这种植物有毒，且具有致幻作用。" //SKYRAT EDIT

/obj/item/food/grown/ash_flora/mushroom_stem
	name = "蘑菇柄"
	desc = "一根长长的蘑菇柄。微微发光。"
	icon_state = "mushroom_stem"
	seed = /obj/item/seeds/lavaland/ember
	wine_power = 60
	special_desc_requirement = EXAMINE_CHECK_JOB //SKYRAT EDIT
	special_desc_jobs = list("Botanist") //SKYRAT EDIT
	special_desc = "这种植物含有精神活性药物，还会让你发光。" //SKYRAT EDIT

/obj/item/food/grown/ash_flora/cactus_fruit
	name = "仙人掌果"
	desc = "一颗覆着厚实红色外皮的仙人掌果。还有些灰烬。"
	icon_state = "cactus_fruit"
	seed = /obj/item/seeds/lavaland/cactus
	wine_power = 50
	foodtypes = FRUIT

/obj/item/food/grown/ash_flora/cactus_fruit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/raptor_food, growth_modifier = 0.1, ability_modifier = -0.05)

/obj/item/food/grown/ash_flora/seraka
	name = "塞拉卡伞盖"
	desc = "小巧而滋味浓郁，原产于提兹拉。"
	icon_state = "seraka_cap"
	seed = /obj/item/seeds/lavaland/seraka
	wine_power = 40

/obj/item/food/grown/ash_flora/seraka/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/raptor_food, ability_modifier = 0.1)

/obj/item/food/grown/ash_flora/fireblossom
	name = "烈焰花"
	desc = "一朵来自烈焰花的花。"
	icon_state = "fireblossom"
	slot_flags = ITEM_SLOT_HEAD
	seed = /obj/item/seeds/lavaland/fireblossom
	wine_power = 40

/obj/item/food/grown/ash_flora/fireblossom/Initialize(mapload)
	. = ..()
	// Fire flowers make fireproof raptors
	AddElement(/datum/element/raptor_food, color_chances = string_list(list(/datum/raptor_color/blue = 5)))

/obj/item/food/grown/ash_flora/glowgrowth
	name = "辉光菌片"
	desc = "一片厚厚的发光菌类。"
	icon_state = "glowgrowth"
	seed = /obj/item/seeds/lavaland/glowgrowth // Cannot be grown in hydroponics as it feeds off mineral air
	wine_power = 50

// SEEDS

/obj/item/seeds/lavaland
	name = "熔岩地带种子"
	desc = "你不该看到这个。"
	lifespan = 50
	endurance = 25
	maturation = 7
	production = 4
	yield = 4
	potency = 15
	growthstages = 3
	rarity = PLANT_MODERATELY_RARE
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	species = "polypore" // silence unit test
	genes = list(/datum/plant_gene/trait/fire_resistance)
	graft_gene = /datum/plant_gene/trait/fire_resistance

/obj/item/seeds/lavaland/cactus
	name = "结果仙人掌种子包"
	desc = "这些种子会长成结果仙人掌。"
	icon_state = "seed-cactus"
	species = "cactus"
	plantname = "结果仙人掌"
	product = /obj/item/food/grown/ash_flora/cactus_fruit
	mutatelist = list(/obj/item/seeds/star_cactus)
	genes = list(/datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	growthstages = 2
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04, /datum/reagent/consumable/vitfro = 0.08)

///Star Cactus seeds, mutation of lavaland cactus.
/obj/item/seeds/star_cactus
	name = "星形仙人掌种子包"
	desc = "这些种子会长成星形仙人掌。"
	icon_state = "seed-starcactus"
	species = "starcactus"
	plantname = "星形仙人掌簇"
	product = /obj/item/food/grown/star_cactus
	lifespan = 60
	endurance = 30
	maturation = 7
	production = 6
	yield = 3
	growthstages = 4
	genes = list(/datum/plant_gene/trait/sticky, /datum/plant_gene/trait/stinging)
	graft_gene = /datum/plant_gene/trait/sticky
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	reagents_add = list(/datum/reagent/water = 0.08, /datum/reagent/consumable/nutriment = 0.05, /datum/reagent/medicine/c2/helbital = 0.05)

///Star Cactus Plants.
/obj/item/food/grown/star_cactus
	seed = /obj/item/seeds/star_cactus
	name = "星形仙人掌"
	desc = "一簇带刺的圆形星形仙人掌。另外，它叫星形仙人掌可不是因为它在太空里。"
	icon_state = "starcactus"
	filling_color = "#1c801c"
	foodtypes = VEGETABLES
	distill_reagent = /datum/reagent/consumable/ethanol/tequila

/obj/item/seeds/lavaland/polypore
	name = "多孔菌菌丝包"
	desc = "这种菌丝会长成层菌，也叫多孔菌。质地木质而坚硬，竖井矿工常用它们做些简易手工艺品。"
	icon_state = "mycelium-polypore"
	species = "polypore"
	plantname = "多孔菌"
	product = /obj/item/food/grown/ash_flora/shavings
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.04, /datum/reagent/consumable/ethanol = 0.04, /datum/reagent/stabilizing_agent = 0.06, /datum/reagent/consumable/mintextract = 0.02)

/obj/item/seeds/lavaland/porcini
	name = "牛肝菌菌丝包"
	desc = "这种菌丝会长成美味牛肝菌，也就是牛肝菌。原产于已逝的地球，却在熔岩地带被发现。具有食用、药用和放松效果。"
	icon_state = "mycelium-porcini"
	species = "porcini"
	plantname = "牛肝菌"
	product = /obj/item/food/grown/ash_flora/mushroom_leaf
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.06,  /datum/reagent/consumable/sugar = 0.06, /datum/reagent/consumable/vitfro = 0.04, /datum/reagent/drug/nicotine = 0.04)

/obj/item/seeds/lavaland/inocybe
	name = "丝盖伞菌丝包"
	desc = "这种菌丝会长成丝盖伞，一种原产于熔岩地带、具有致幻和毒性效果的蘑菇。"
	icon_state = "mycelium-inocybe"
	species = "inocybe"
	plantname = "丝盖伞"
	product = /obj/item/food/grown/ash_flora/mushroom_cap
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/toxin/mindbreaker = 0.04, /datum/reagent/consumable/entpoly = 0.08, /datum/reagent/drug/mushroomhallucinogen = 0.04)

/obj/item/seeds/lavaland/ember
	name = "余烬菇菌丝包"
	desc = "这种菌丝会长成余烬菇，一种原产于熔岩地带的生物发光蘑菇。"
	icon_state = "mycelium-ember"
	species = "ember"
	plantname = "余烬菇"
	product = /obj/item/food/grown/ash_flora/mushroom_stem
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/glow, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/tinlux = 0.04, /datum/reagent/consumable/nutriment/vitamin = 0.02, /datum/reagent/drug/space_drugs = 0.02)

/obj/item/seeds/lavaland/seraka
	name = "塞拉卡菌丝包"
	desc = "这种菌丝会长成塞拉卡蘑菇，一种原产于提兹拉、用于食物与传统医药的鲜味蘑菇。"
	icon_state = "mycelium-seraka"
	species = "seraka"
	plantname = "塞拉卡蘑菇"
	product = /obj/item/food/grown/ash_flora/seraka
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/toxin/mushroom_powder = 0.1, /datum/reagent/medicine/coagulant/seraka_extract = 0.02)

/obj/item/seeds/lavaland/fireblossom
	name = "烈焰花种子包"
	desc = "这些种子会长成烈焰花。"
	plantname = "烈焰花"
	icon_state = "seed-fireblossom"
	species = "fireblossom"
	growthstages = 3
	product = /obj/item/food/grown/ash_flora/fireblossom
	genes = list(/datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/glow/yellow)
	growing_icon = 'icons/obj/service/hydroponics/growing_flowers.dmi'
	reagents_add = list(/datum/reagent/consumable/tinlux = 0.04, /datum/reagent/consumable/nutriment = 0.03, /datum/reagent/carbon = 0.05)

/obj/item/seeds/lavaland/glowgrowth
	name = "辉光菌菌丝包"
	desc = "这种菌丝会长成辉光菌。"
	plantname = "辉光菌"
	icon_state = "mycelium-glowgrowth"
	species = "glowgrowth"
	product = /obj/item/food/grown/ash_flora/glowgrowth
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/glow/blue) // Fungal metab doesn't do anything (cause it can't be planted) but it shows up in analyzers
	reagents_add = list(/datum/reagent/luminescent_fluid/cyan = 0.06, /datum/reagent/consumable/nutriment = 0.01, /datum/reagent/silicon = 0.03)
	seed_flags = parent_type::seed_flags | NO_PLANTING

//CRAFTING

/datum/crafting_recipe/mushroom_bowl
	name = "蘑菇碗"
	result = /obj/item/reagent_containers/cup/bowl/mushroom_bowl
	reqs = list(/obj/item/food/grown/ash_flora/shavings = 5)
	time = 3 SECONDS
	category = CAT_CONTAINERS

/obj/item/reagent_containers/cup/bowl/mushroom_bowl
	name = "蘑菇碗"
	desc = "用蘑菇做成的碗。不是食物，不过它也许曾在某个时候装过食物。"
	icon = 'icons/obj/mining_zones/ash_flora.dmi'
	base_icon_state = "mushroom_bowl"
	icon_state = "mushroom_bowl"
	fill_icon_state = "fullbowl"
	fill_icon = 'icons/obj/mining_zones/ash_flora.dmi'
	custom_materials = null

