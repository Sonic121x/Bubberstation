/obj/item/fish/shrimp
	name = "虾"
	fish_id = "shrimp"
	desc = "一种偏红粉色的甲壳类。你得吃下多少只，皮肤才会变成粉色呢？"
	icon = 'modular_zubbers/icons/obj/aquarium/fish.dmi'
	icon_state = "shrimp"
	dedicated_in_aquarium_icon = 'modular_zubbers/icons/obj/aquarium/fish.dmi'
	dedicated_in_aquarium_icon_state = "shrimp_small"
	sprite_width = 7
	sprite_height = 7
	average_size = 14
	average_weight = 300
	stable_population = 4
	fish_traits = list()
	required_temperature_min = MIN_AQUARIUM_TEMP
	required_temperature_max = MIN_AQUARIUM_TEMP + 12
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	fillet_type = /obj/item/food/fishmeat/shrimp

/obj/item/fish/shrimp/get_fish_taste()
	return list("生虾" = 2)
