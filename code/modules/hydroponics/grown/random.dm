//Random seeds; stats, traits, and plant type are randomized for each seed.

/obj/item/seeds/random
	name = "奇异种子包"
	desc = "正如其名般奇异的神秘种子。真诡异。"
	icon_state = "seed-x"
	species = "?????"
	plantname = "奇异植物"
	product = /obj/item/food/grown/random
	icon_grow = "xpod-grow"
	icon_dead = "xpod-dead"
	icon_harvest = "xpod-harvest"
	growthstages = 4
	custom_premium_price = PAYCHECK_CREW * 2

/obj/item/seeds/random/Initialize(mapload)
	. = ..()
	randomize_stats()
	if(prob(60))
		add_random_reagents(1, 3)
	if(prob(50))
		add_random_traits(1, 2)
	add_random_plant_type(35)

/obj/item/food/grown/random
	seed = /obj/item/seeds/random
	name = "奇异植物"
	desc = "这到底是什么东西？"
	icon_state = "crunchy"

/obj/item/food/grown/random/Initialize(mapload)
	. = ..()
	wine_power = rand(10,150)
	if(prob(1))
		wine_power = 200
