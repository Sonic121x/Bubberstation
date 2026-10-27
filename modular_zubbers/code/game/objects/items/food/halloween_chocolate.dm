//Food
/obj/item/food/candy/hundred_credit_bar
	name = "百元巧克力棒"
	desc = "现已加入真金！"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "hundred_credit_bar"
	trash_type = /obj/item/trash/candy/hundred_credit_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/gold = 5
	)
	tastes = list("浓郁糖果" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/coconut_joy
	name = "椰香欢愉"
	desc = "吃下这种过度加工的椰子甜食时，你会被迫露出笑容。"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "coconut_joy"
	trash_type = /obj/item/trash/candy/coconut_joy
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/coconut_milk = 2,
		/datum/reagent/drug/happiness = 3
	)
	tastes = list("干纸板" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/hurr_bar
	name = "憨憨巧克力棒"
	desc = "各地傻瓜和比特潜行者的最爱！"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "hurr_bar"
	trash_type = /obj/item/trash/candy/hurr_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/medicine/mannitol = 5
	)
	tastes = list("脑损伤" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/laughter_bar
	name = "欢笑巧克力棒"
	desc = "小丑的最爱。"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "laughter_bar"
	trash_type = /obj/item/trash/candy/laughter_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/laughter = 5
	)
	tastes = list("搞笑糖果" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/laughter_bar/slaughter
	name = "屠戮巧克力棒"
	desc = "等等，什么？"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/blood = 5
	)
	tastes = list("杀戮的渴望" = 1)
	foodtypes = JUNKFOOD | SUGAR | BLOODY



/obj/item/food/candy/kit_catgirl_metaclique_bar
	name = "猫猫棒"
	desc = "全站猫人的首选！现在巧克力含量减少了 100%！"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "kit_catgirl_metaclique_bar"
	trash_type = /obj/item/trash/candy/kit_catgirl_metaclique_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/pax/catnip = 5
	)
	tastes = list("巧克力？" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/twink_bar
	name = "双 K 巧克力棒"
	desc = "蜥蜴人最爱的巧克力棒！"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "twink_bar"
	trash_type = /obj/item/trash/candy/twink_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/colorful_reagent = 5
	)
	tastes = list("骄傲" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/elon_musk_bar
	name = "火枪巧克力棒"
	desc = "海盗的首选！"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "elon_musk_bar"
	trash_type = /obj/item/trash/candy/elon_musk_bar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/gunpowder = 5
	)
	tastes = list("巧克力" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/malf_way
	name = "失控之路巧克力棒"
	desc = "SELF 运动的骄傲支持者！"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "malf_way"
	trash_type = /obj/item/trash/candy/malf_way
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/medicine/nanite_slurry = 5
	)
	tastes = list("AI 法则" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/triggerfinger
	name = "扳机手指巧克力棒"
	desc = "各地货运技师的最爱，这款巧克力棒保证无需警告或逐级升级冲突，就能让任何人当场毙命！"
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "triggerfinger"
	trash_type = /obj/item/trash/candy/triggerfinger
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/toxin/zombiepowder = 5
	)
	tastes = list("飞行啮齿动物" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

//Wrappers.
/obj/item/trash/candy/hundred_credit_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "hundred_credit_bar_trash"

/obj/item/trash/candy/coconut_joy
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "coconut_joy_trash"

/obj/item/trash/candy/hurr_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "hurr_bar_trash"

/obj/item/trash/candy/laughter_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "laughter_bar_trash"

/obj/item/trash/candy/kit_catgirl_metaclique_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "kit_catgirl_metaclique_bar_trash"

/obj/item/trash/candy/twink_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "twink_bar_trash"

/obj/item/trash/candy/elon_musk_bar
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "elon_musk_bar_trash"

/obj/item/trash/candy/malf_way
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "malf_way_trash"

/obj/item/trash/candy/triggerfinger
	icon = 'modular_zubbers/icons/obj/food/halloween_chocolate.dmi'
	icon_state = "triggerfinger_trash"
