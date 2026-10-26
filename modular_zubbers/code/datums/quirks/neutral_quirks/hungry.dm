#define QUIRK_HUNGRY_MOD 2

/datum/quirk/hungry
	name = "Hungry"
	desc = "不知为何，你比别人更容易饿！"
	value = -2
	icon = FA_ICON_BOWL_FOOD
	gain_text = span_notice("你感觉自己的胃像个无底洞。")
	lose_text = span_notice("你不再觉得自己的胃是个无底洞了。")
	medical_record_text = "患者的新陈代谢速度明显偏快。"
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(/obj/item/food/chips)

/datum/quirk_constant_data/hungry
	associated_typepath = /datum/quirk/hungry
	customization_options = list(/datum/preference/numeric/hungry_level)

/datum/preference/numeric/hungry_level
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "hungry_quirk_level"
	savefile_identifier = PREFERENCE_CHARACTER
	step = 0.1
	minimum = 1.5
	maximum = 3

/datum/preference/numeric/hungry_level/create_default_value()
	return 1.5


/datum/preference/numeric/hungry_level/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/quirk/hungry/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(istype(human_holder))
		human_holder.physiology.hunger_mod *= client_source.prefs.read_preference(/datum/preference/numeric/hungry_level)

/datum/quirk/hungry/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/client/target_client = human_holder?.client
	if (istype(human_holder) && target_client)
		human_holder.physiology.hunger_mod /= target_client.prefs.read_preference(/datum/preference/numeric/hungry_level)

#undef QUIRK_HUNGRY_MOD
