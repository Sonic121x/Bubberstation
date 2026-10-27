/datum/reagent/consumable/powdered_tea
	name = "茶粉"
	description = "粉末形态的茶。味道糟透了。"
	color = "#3a3a03"
	nutriment_factor = 0
	taste_description = "苦涩的粉末"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/cup/glass/mug/tea

/datum/chemical_reaction/food/unpowdered_tea
	required_reagents = list(
		/datum/reagent/water = 1,
		/datum/reagent/consumable/powdered_tea = 1,
	)
	results = list(/datum/reagent/consumable/tea = 2)
	mix_message = "混合物立刻变热了。"
	reaction_flags = REACTION_INSTANT

/datum/reagent/consumable/powdered_coffee
	name = "咖啡粉"
	description = "粉末形态的美式咖啡。说实话，挺普通的东西。"
	color = "#101000"
	nutriment_factor = 0
	taste_description = "极苦的粉末"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/cup/glass/coffee

/datum/chemical_reaction/food/unpowdered_coffee
	required_reagents = list(
		/datum/reagent/water = 1,
		/datum/reagent/consumable/powdered_coffee = 1,
	)
	results = list(/datum/reagent/consumable/coffee = 2)
	mix_message = "混合物立刻变热了。"
	reaction_flags = REACTION_INSTANT

/datum/reagent/consumable/powdered_lemonade
	name = "柠檬水粉"
	description = "柠檬水的甜酸基底。兑上水应该会不错。"
	nutriment_factor = 0
	color = "#FFE978"
	taste_description = "酸得刺舌又带着甜味的柠檬粉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/cup/soda_cans/lemon_lime

/datum/chemical_reaction/food/unpowdered_lemonade
	required_reagents = list(
		/datum/reagent/water = 1,
		/datum/reagent/consumable/powdered_lemonade = 1,
	)
	results = list(/datum/reagent/consumable/lemonade = 2)
	mix_message = "混合物立刻变凉了。"
	reaction_flags = REACTION_INSTANT

/datum/reagent/consumable/powdered_milk
	name = "奶粉"
	description = "一种不透明的白色粉末，由某些机器的生物质重构器生产。"
	nutriment_factor = 0
	color = "#DFDFDF"
	taste_description = "干甜奶粉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/condiment/milk

/datum/chemical_reaction/food/unpowdered_milk
	required_reagents = list(
		/datum/reagent/water = 1,
		/datum/reagent/consumable/powdered_milk = 1,
	)
	results = list(/datum/reagent/consumable/milk = 2)
	mix_message = "混合物变凉了。"
	reaction_flags = REACTION_INSTANT

/obj/item/reagent_containers/applicator/pill/convermol
	name = "康弗莫药丸"
	desc = "用于治疗缺氧，但会使身体中毒。"
	icon_state = "pill16"
	list_reagents = list(/datum/reagent/medicine/c2/convermol = 15)
	rename_with_volume = TRUE

/datum/reagent/consumable/nutriment/glucose
	name = "合成葡萄糖"
	description = "一种黏稠的黄色液体，属于单糖，是有机葡萄糖的合成变体。能为身体提供短时的能量补充。"
	nutriment_factor = 1
	color = "#f3d00d"
	taste_description = "浓烈的甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	var/delayed_satiety_drain = 30

/datum/reagent/consumable/nutriment/glucose/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(affected_mob.satiety < MAX_SATIETY)
		affected_mob.adjust_nutrition(15)
		delayed_satiety_drain += 15

	return ..()

/datum/reagent/consumable/nutriment/glucose/on_mob_delete(mob/living/carbon/detoxed_mob)
	detoxed_mob.adjust_nutrition(-delayed_satiety_drain)
	return ..()
