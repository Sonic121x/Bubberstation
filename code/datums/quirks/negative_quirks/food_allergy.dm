GLOBAL_LIST_INIT(possible_food_allergies, list(
	"Alcohol" = ALCOHOL,
	"Bugs" = BUGS,
	"Dairy" = DAIRY,
	"Fruit" = FRUIT,
	"Grain" = GRAIN,
	"Meat" = MEAT,
	"Nuts" = NUTS,
	"Seafood" = SEAFOOD,
	"Sugar" = SUGAR,
	"Vegetables" = VEGETABLES,
))

/datum/quirk/item_quirk/food_allergic
	name = "Food Allergy"
	desc = "你从小就对某些食物过敏。"
	icon = FA_ICON_SHRIMP
	value = -2
	gain_text = span_danger("你感到自己的免疫系统发生了变化。")
	lose_text = span_notice("你感到自己的免疫系统恢复了完美状态。")
	medical_record_text = "患者的免疫系统对某些食物有剧烈反应。"
	hardcore_value = 1
	mail_goodies = list(/obj/item/reagent_containers/hypospray/medipen)
	/// Footype flags that will trigger the allergy
	var/target_foodtypes = NONE

/datum/quirk_constant_data/food_allergy
	associated_typepath = /datum/quirk/item_quirk/food_allergic
	customization_options = list(/datum/preference/choiced/food_allergy)

/datum/quirk/item_quirk/food_allergic/add(client/client_source)
	if(target_foodtypes != NONE) // Already set, don't care
		return

	var/desired_allergy = client_source?.prefs.read_preference(/datum/preference/choiced/food_allergy) || "Random"
	if(desired_allergy != "Random")
		target_foodtypes = GLOB.possible_food_allergies[desired_allergy]
		if(target_foodtypes != NONE) // Got a preference, don't care
			return

	target_foodtypes = pick(assoc_to_values(GLOB.possible_food_allergies))

/datum/quirk/item_quirk/food_allergic/add_unique(client/client_source)
	var/what_are_we_actually_killed_by = english_list(bitfield_to_list(target_foodtypes, FOOD_FLAGS_IC)) // This should never be more than one thing but just in case we can support it
	to_chat(client_source.mob, span_info("你对[what_are_we_actually_killed_by]过敏。注意饮食！"))

	var/obj/item/clothing/accessory/dogtag/allergy/dogtag = new(quirk_holder, what_are_we_actually_killed_by)
	give_item_to_holder(dogtag, list(LOCATION_BACKPACK, LOCATION_HANDS), flavour_text = "在厨房附近时记得随身携带。", notify_player = TRUE)
