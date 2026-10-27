/obj/item/organ/wings
	name = "翅膀"
	desc = "一对翅膀。它们也许能让你飞起来……至少也能扑腾两下。"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_WINGS
	mutantpart_key = "wings"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Bat", MUTANT_INDEX_COLOR_LIST = list("#335533"))
	organ_flags = ORGAN_EXTERNAL
	///Whether the wings should grant flight on insertion.
	var/unconditional_flight
	///What species get flights thanks to those wings. Important for moth wings
	var/list/flight_for_species
	///Whether a wing can be opened by the *wing emote. The sprite use a "_open" suffix, before their layer
	var/can_open
	///Whether an openable wing is currently opened
	var/is_open
	///Whether the owner of wings has flight thanks to the wings
	var/granted_flight

/datum/bodypart_overlay/mutant/wings
	color_source = ORGAN_COLOR_OVERRIDE

//TODO: Well you know what this flight stuff is a bit complicated and hardcoded, this is enough for now

/datum/bodypart_overlay/mutant/wings/override_color(rgb_value)
	return draw_color

/obj/item/organ/wings/moth
	name = "蛾翅"
	desc = "一对毛茸茸的蛾翅。"
	flight_for_species = list(SPECIES_MOTH)

/obj/item/organ/wings/flight
	unconditional_flight = TRUE
	can_open = TRUE

/obj/item/organ/wings/flight/angel
	name = "天使翅膀"
	desc = "一对华丽的羽翼。看起来足以把你托上天空。"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Angel", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

/obj/item/organ/wings/flight/dragon
	name = "龙翼"
	desc = "一对令人生畏的膜翼。看起来足以把你托上天空。"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Dragon", MUTANT_INDEX_COLOR_LIST = list("#880000"))

/obj/item/organ/wings/flight/megamoth
	name = "巨蛾翅膀"
	desc = "一对大得吓人的毛茸茸翅膀。看起来足以把你托上天空。"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Megamoth", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))


/datum/bodypart_overlay/mutant/wings/functional
	color_source = ORGAN_COLOR_INHERIT


/datum/bodypart_overlay/mutant/wings/functional/original_color
	color_source = ORGAN_COLOR_OVERRIDE


/datum/bodypart_overlay/mutant/wings/functional/original_color/override_color(rgb_value)
	return COLOR_WHITE // We want to keep those wings as their original color, because it looks better.


/datum/bodypart_overlay/mutant/wings/functional/locked/get_global_feature_list()
	if(wings_open)
		return SSaccessories.sprite_accessories["wings_open"]
	return SSaccessories.sprite_accessories["wings_functional"]


// We need to overwrite this because all of these wings are locked.
/datum/bodypart_overlay/mutant/wings/functional/locked/get_random_appearance()
	var/list/valid_restyles = list()
	var/list/feature_list = get_global_feature_list()
	for(var/accessory in feature_list)
		var/datum/sprite_accessory/accessory_datum = feature_list[accessory]
		valid_restyles += accessory_datum

	return pick(valid_restyles)


/datum/bodypart_overlay/mutant/wings/functional/locked/original_color
	color_source = ORGAN_COLOR_OVERRIDE


/datum/bodypart_overlay/mutant/wings/functional/locked/original_color/override_color(rgb_value)
	return COLOR_WHITE // We want to keep those wings as their original color, because it looks better.


/obj/item/organ/wings/functional
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/locked

/obj/item/organ/wings/functional/angel
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/original_color

/obj/item/organ/wings/functional/dragon
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional

/obj/item/organ/wings/functional/moth
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/locked/original_color

/obj/item/organ/wings/functional/robotic
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional

/obj/item/organ/wings/functional/slime
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional
