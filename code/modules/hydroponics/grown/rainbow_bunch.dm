/obj/item/seeds/rainbow_bunch
	name = "彩虹花种子包"
	desc = "一包种子，会长成一丛色彩缤纷的美丽花朵。"
	icon_state = "seed-rainbowbunch"
	species = "rainbowbunch"
	plantname = "彩虹花"
	icon_harvest = "rainbowbunch-harvest"
	product = /obj/item/food/grown/flower/rainbow_flower
	lifespan = 25
	endurance = 10
	maturation = 6
	production = 3
	yield = 5
	potency = 20
	instability = 25
	growthstages = 4
	growing_icon = 'icons/obj/service/hydroponics/growing_flowers.dmi'
	icon_dead = "rainbowbunch-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/preserved)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.05)

/obj/item/food/grown/flower/rainbow_flower
	seed = /obj/item/seeds/rainbow_bunch
	name = "彩虹花"
	desc = "一朵美丽的花，可用于大多数染色工艺。"
	slot_flags = ITEM_SLOT_HEAD
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("pompfs")
	attack_verb_simple = list("pompf")
	greyscale_colors = COLOR_BLACK //only here for unit testing. overriden in initialize()
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/food/grown/flower/rainbow_flower"
	post_init_icon_state = "map_flower"
	greyscale_config = /datum/greyscale_config/flower_simple
	greyscale_config_worn = /datum/greyscale_config/flower_simple_worn

/obj/item/food/grown/flower/rainbow_flower/Initialize(mapload)
	. = ..()
	if(greyscale_colors != initial(greyscale_colors))
		return

	var/flower_color = rand(1,8)
	switch(flower_color)
		if(1)
			set_greyscale("#c50b0b")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/red, 3)
			dye_color = DYE_RED
			desc += " 这一朵是鲜红色的。"
		if(2)
			set_greyscale("#f76f07")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/orange, 3)
			dye_color = DYE_ORANGE
			desc += " 这一朵是柑橘橙色。"
		if(3)
			set_greyscale("#d8ce13")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/yellow, 3)
			dye_color = DYE_YELLOW
			desc += " 这一朵是明黄色的。"
		if(4)
			set_greyscale("#a0da23")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/green, 3)
			dye_color = DYE_GREEN
			desc += " 这一朵是草绿色的。"
		if(5)
			set_greyscale("#0862c1")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/blue, 3)
			dye_color = DYE_BLUE
			desc += " 这一朵是令人舒缓的蓝色。"
		if(6)
			set_greyscale("#ad00cc")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/purple, 3)
			dye_color = DYE_PURPLE
			desc += " 这一朵是鲜艳的紫色。"
		if(7)
			set_greyscale("#161616")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/black, 3)
			dye_color = DYE_BLACK
			desc += " 这一朵是午夜黑色的。"
		if(8)
			set_greyscale(COLOR_WHITE)
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/white, 3)
			dye_color = DYE_WHITE
			desc += " 这一朵是纯白色的。"
