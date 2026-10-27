/obj/item/seeds/kronkus
	name = "克朗库斯种子包"
	desc = "一包高度非法的克朗库斯种子。\n在 7 个星区中，持有这些种子即可判处死刑。"
	icon_state = "seed-kronkus"
	plant_icon_offset = 6
	species = "kronkus"
	plantname = "克朗库斯藤"
	product = /obj/item/food/grown/kronkus
	//shitty stats, because botany is easy
	lifespan = 60
	endurance = 40
	maturation = 6
	production = 4
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.05)

/obj/item/seeds/kronkus/Initialize(mapload, nogenes)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/food/grown/kronkus
	seed = /obj/item/seeds/kronkus
	name = "克朗库斯藤段"
	desc = "一段成熟的克朗库斯藤。它散发出尖锐刺鼻的气味。\n\n它可以发酵制成粗制提取物，供太空货船上的流浪汉在引擎废气渗入棚屋时保持清醒。\n\n据说进一步加工可制得克隆卡因，但关于此事的情报受到严格管控。"
	icon_state = "kronkus"
	filling_color = "#37946e"
	foodtypes = VEGETABLES | TOXIC
	distill_reagent = /datum/reagent/kronkus_extract

/obj/item/food/grown/kronkus/Initialize(mapload, nogenes)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)
