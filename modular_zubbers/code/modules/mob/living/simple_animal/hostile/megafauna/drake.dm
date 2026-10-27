/mob/living/simple_animal/hostile/megafauna/dragon
	faction = list(FACTION_ASHWALKER,FACTION_MINING)

/mob/living/simple_animal/hostile/megafauna/dragon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/egg_layer,\
		egg_type = /obj/item/stack/sheet/animalhide/ashdrake,\
		food_types = list(/obj/item/food/meat/slab/drakebait),\
		feed_messages = list("灰烬龙接受了你的供品。"),\
		lay_messages = list(\
				"摇了摇头，发出一声满意的低鸣。干燥的旧鳞片从皮上无害地脱落。",\
				"伸展开翅膀。一些鳞片脱落下来，整齐地堆成一堆。",\
				"舒服地叹了口气。膈肌的运动使多余的鳞片松动，落到腹下的地面上。"),\
		eggs_left = 0,\
		eggs_added_from_eating = 7,\
		max_eggs_held = 14,\
	)
