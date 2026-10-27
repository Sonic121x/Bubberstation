/datum/quirk/chipped
	name = "Chipped"
	desc = "几年前你赶上了技能芯片热潮，给自己植入了一枚市售芯片。"
	icon = FA_ICON_MICROCHIP
	value = 2
	gain_text = span_notice("你突然感觉脑子里多了枚芯片。")
	lose_text = span_danger("你不再感觉到那枚芯片了。")
	medical_record_text = "患者讲述了自己最近如何追赶“技能芯片热潮”，现在脑子里装着一枚没用的芯片。蠢货。"
	mail_goodies = list(
		/obj/item/skillchip/matrix_taunt,
		/obj/item/skillchip/big_pointer,
		/obj/item/skillchip/acrobatics,
	)
	/// Variable that holds the chip, used on removal.
	var/obj/item/skillchip/installed_chip

/datum/quirk_constant_data/chipped
	associated_typepath = /datum/quirk/chipped
	customization_options = list(/datum/preference/choiced/chipped)

/datum/quirk/chipped/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique = TRUE, announce = FALSE)
	var/chip_pref = client_source?.prefs?.read_preference(/datum/preference/choiced/chipped)

	if(isnull(chip_pref))
		return ..()
	installed_chip = GLOB.quirk_chipped_choice[chip_pref] || GLOB.quirk_chipped_choice[pick(GLOB.quirk_chipped_choice)]
	gain_text = span_notice("你脑中的[installed_chip::name]满载知识，嗡嗡作响。")
	lose_text = span_notice("你感觉不到脑中的芯片了。")
	return ..()

/datum/quirk/chipped/add_unique(client/client_source)
	if(!iscarbon(quirk_holder))
		return

	var/mob/living/carbon/quirk_holder_carbon = quirk_holder
	installed_chip = new installed_chip()
	quirk_holder_carbon.implant_skillchip(installed_chip, force = TRUE)
	installed_chip.try_activate_skillchip(silent = FALSE, force = TRUE)

/datum/quirk/chipped/remove()
	QDEL_NULL(installed_chip)
	return ..()
