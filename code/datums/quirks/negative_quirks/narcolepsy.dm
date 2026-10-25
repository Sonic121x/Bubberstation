/datum/quirk/item_quirk/narcolepsy
	name = "Narcolepsy"
	desc = "你经常感到困倦，随时可能睡着。补充咖啡因、走动，甚至用处方或其他兴奋剂抑制症状，都能帮助你熬过本班次……"
	icon = FA_ICON_BED
	value = -8
	hardcore_value = 8
	medical_record_text = "患者可能在正常活动中不由自主地入睡，并随时感到困倦。"
	mail_goodies = list(
		/obj/item/reagent_containers/cup/glass/coffee,
		/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind,
		/obj/item/storage/pill_bottle/prescription_stimulant,
	)

/datum/quirk/item_quirk/narcolepsy/add(client/client_source)
	var/mob/living/carbon/carbon_user = quirk_holder
	carbon_user.gain_trauma(/datum/brain_trauma/severe/narcolepsy/permanent, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/item_quirk/narcolepsy/add_unique(client/client_source)
	give_item_to_holder(
		/obj/item/storage/pill_bottle/prescription_stimulant,
		list(
			LOCATION_BACKPACK,
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_HANDS,
		),
		flavour_text = "这些可以帮助你在本班次保持清醒……",
		notify_player = TRUE,
	)

/datum/quirk/item_quirk/narcolepsy/remove()
	if(!QDELETED(quirk_holder) && quirk_holder.get_organ_by_type(/obj/item/organ/brain))
		var/mob/living/carbon/carbon_user = quirk_holder
		carbon_user?.cure_trauma_type(/datum/brain_trauma/severe/narcolepsy/permanent, TRAUMA_RESILIENCE_ABSOLUTE)
