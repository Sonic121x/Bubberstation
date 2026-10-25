//Tiziran Fish.

/obj/item/fish/moonfish
	name = "扎戈斯凯尔德月鱼"
	fish_id = "moonfish"
	desc = "一种原产于提兹拉海洋较浅水域的圆盘状鱼类，大小与金枪鱼相仿。因其鱼卵硕大，在蜥蜴人料理中备受珍视。"
	icon_state = "tizira_moonfish"
	sprite_height = 7
	sprite_width = 7
	fillet_type = /obj/item/food/fishmeat/moonfish
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 2
	average_size = 95
	average_weight = 2000
	required_temperature_min = MIN_AQUARIUM_TEMP+20
	required_temperature_max = MIN_AQUARIUM_TEMP+30
	beauty = FISH_BEAUTY_GOOD
	weight_size_deviation = 0.1
	fishing_difficulty_modifier = 10
	random_case_rarity = FISH_RARITY_RARE
	fish_traits = list(/datum/fish_trait/predator)
	compatible_types = list(/obj/item/fish/moonfish, /obj/item/fish/moonfish/dwarf)
	evolution_types = list(/datum/fish_evolution/dwarf_moonfish)
	favorite_bait = list(
		/obj/item/fish/armorfish,
		/obj/item/fish/needlefish,
		/obj/item/fish/gunner_jellyfish,
	)
	var/egg_laying_time = 2.75 MINUTES

/obj/item/fish/moonfish/Initialize(mapload, apply_qualities = TRUE)
	. = ..()
	AddComponent(/datum/component/fish_growth, /obj/item/food/moonfish_eggs, egg_laying_time, use_drop_loc = FALSE, del_on_grow = FALSE, inherit_name = FALSE)
	RegisterSignal(src, COMSIG_FISH_BEFORE_GROWING, PROC_REF(egg_checks))

///Stop laying eggs if we're in an unsafe environment, starving of if there are simply too many eggs already.
/obj/item/fish/moonfish/proc/egg_checks(datum/source, seconds_per_tick, growth, result_path)
	if(result_path != /obj/item/food/moonfish_eggs) //Don't stop the growth of the dwarf subtype.
		return
	if(!proper_environment() || get_starvation_mult())
		return COMPONENT_DONT_GROW
	var/count = 0
	for(var/obj/item/food/moonfish_eggs/egg in loc)
		count ++
		if(count > 10)
			return COMPONENT_DONT_GROW

/obj/item/fish/moonfish/dwarf
	name = "侏儒月鱼"
	fish_id = "dwarf_moonfish"
	desc = "在野外，扎戈斯凯尔德月鱼通常有金枪鱼那么大；不过通过选择性繁育，人们培育出了一种体型更小、适合作为水族宠物饲养的品种。"
	icon_state = "dwarf_moonfish"
	sprite_height = 6
	sprite_width = 6
	stable_population = 3
	average_size = 50
	average_weight = 950
	fishing_difficulty_modifier = 0
	egg_laying_time = 4.25 MINUTES
	random_case_rarity = FISH_RARITY_BASIC
	fish_traits = list()
	evolution_types = list(/datum/fish_evolution/moonfish)

/obj/item/fish/moonfish/dwarf/update_size_and_weight(new_size = average_size, new_weight = average_weight, update_materials = TRUE)
	. = ..()
	var/multiplier = (size / (average_size * 1.5)) * (weight / (average_weight * 1.5))

	AddComponent(/datum/component/fish_growth, /datum/fish_evolution/moonfish, 2.5 MINUTES * multiplier, use_drop_loc = FALSE)

/obj/item/fish/gunner_jellyfish
	name = "炮手水母"
	fish_id = "gunner_jellyfish"
	desc = "因其外形酷似炮弹而得名，炮手水母原产于提兹拉，在当地被当作美味享用。它会产生一种温和的致幻物质，但烹饪后便会被破坏。"
	icon_state = "gunner_jellyfish"
	sprite_height = 4
	sprite_width = 5
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 4
	fillet_type = /obj/item/food/fishmeat/gunner_jellyfish
	fish_traits = list(/datum/fish_trait/hallucinogenic)
	required_temperature_min = MIN_AQUARIUM_TEMP+24
	required_temperature_max = MIN_AQUARIUM_TEMP+32
	beauty = FISH_BEAUTY_GOOD
	favorite_bait = list(
		/obj/item/fish/armorfish,
		/obj/item/fish/needlefish,
	)

/obj/item/fish/gunner_jellyfish/Initialize(mapload, apply_qualities = TRUE)
	. = ..()
	AddElement(/datum/element/quality_food_ingredient, FOOD_COMPLEXITY_2)

/obj/item/fish/gunner_jellyfish/get_fish_taste()
	return list("冰凉胶质" = 2)

/obj/item/fish/gunner_jellyfish/get_fish_taste_cooked()
	return list("外脆里嫩" = 2)

/obj/item/fish/needlefish
	name = "针鱼"
	fish_id = "needlefish"
	desc = "一种微小透明的鱼，在提兹拉的海洋中成群结队地生活。是其他大型鱼类常见的食物。"
	icon_state = "needlefish"
	sprite_height = 3
	sprite_width = 7
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 12
	breeding_timeout = 1 MINUTES
	fillet_type = null
	average_size = 20
	average_weight = 300
	fish_traits = list(/datum/fish_trait/carnivore)
	required_temperature_min = MIN_AQUARIUM_TEMP+10
	required_temperature_max = MIN_AQUARIUM_TEMP+32

/obj/item/fish/needlefish/Initialize(mapload, apply_qualities = TRUE)
	. = ..()
	add_traits(list(TRAIT_FISHING_BAIT, TRAIT_GOOD_QUALITY_BAIT), INNATE_TRAIT)

/obj/item/fish/armorfish
	name = "甲鱼"
	fish_id = "armorfish"
	desc = "一种原产于提兹拉海洋的小型甲壳类，以异常坚硬的外壳著称，吃法类似对虾。"
	icon_state = "armorfish"
	sprite_height = 5
	sprite_width = 6
	average_size = 25
	average_weight = 350
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 10
	breeding_timeout = 1.25 MINUTES
	fillet_type = /obj/item/food/fishmeat/armorfish
	fish_movement_type = /datum/fish_movement/slow
	required_temperature_min = MIN_AQUARIUM_TEMP+10
	required_temperature_max = MIN_AQUARIUM_TEMP+32

/obj/item/fish/armorfish/Initialize(mapload, apply_qualities = TRUE)
	. = ..()
	add_traits(list(TRAIT_FISHING_BAIT, TRAIT_GOOD_QUALITY_BAIT), INNATE_TRAIT)

/obj/item/fish/armorfish/get_fish_taste()
	return list("生对虾" = 2)

/obj/item/fish/armorfish/get_fish_taste_cooked()
	return list("熟对虾" = 2)
