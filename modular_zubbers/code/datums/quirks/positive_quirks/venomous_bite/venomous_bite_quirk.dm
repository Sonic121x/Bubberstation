/datum/quirk/venomous_bite
	name = "Venomous Bite"
	desc = "你拥有毒腺，可以通过咬人注入你选择的毒素。"
	icon = FA_ICON_TEETH_OPEN
	value = 8
	gain_text = span_notice("你感觉喉咙深处长出了毒腺。")
	lose_text = span_warning("你的毒腺消失了。")
	medical_record_text = "患者拥有毒腺。"

/datum/quirk/venomous_bite/add(client/client_source)
	var/datum/reagent/reagent = text2path(client_source?.prefs?.read_preference(/datum/preference/choiced/venomous_bite_venom))

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/mob_cooldown/venomous_bite/existing = locate() in human_holder.actions
	if(existing)
		return
	var/datum/action/cooldown/mob_cooldown/venomous_bite/action = new /datum/action/cooldown/mob_cooldown/venomous_bite(human_holder, our_reagent = reagent)
	action.Grant(human_holder)

/datum/quirk/venomous_bite/remove()
	if(QDELETED(quirk_holder))
		return ..()
	var/datum/action/cooldown/mob_cooldown/venomous_bite/action = locate(/datum/action/cooldown/mob_cooldown/venomous_bite) in quirk_holder.actions
	action.Remove(quirk_holder)

	return ..()

/datum/quirk_constant_data/venomous_bite
	associated_typepath = /datum/quirk/venomous_bite
	customization_options = list(/datum/preference/choiced/venomous_bite_venom)

/datum/preference/choiced/venomous_bite_venom
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "venomous_bite_venom"
	savefile_identifier = PREFERENCE_CHARACTER
	/// Format: (reagent typepath -> list(amount to inject per bite, cooldown))
	var/static/list/venomous_bite_choice_specs = list(
		/datum/reagent/toxin = list(5, 80 SECONDS),
		/datum/reagent/toxin/venom = list(5, 180 SECONDS),
		/datum/reagent/toxin/carpotoxin = list(5, 60 SECONDS), // less powerful than toxin
		// drugs
		/datum/reagent/drug/space_drugs = list(5, 60 SECONDS),
		/datum/reagent/toxin/mindbreaker = list(5, 60 SECONDS),
)

/datum/preference/choiced/venomous_bite_venom/init_possible_values()
	var/list/choices = list()
	for (var/entry in venomous_bite_choice_specs)
		choices += "[entry]"

	return choices

/datum/preference/choiced/venomous_bite_venom/create_default_value()
	return "/datum/reagent/toxin"

/datum/preference/choiced/venomous_bite_venom/compile_constant_data()
	var/list/data = ..()

	var/list/titles = list()

	for (var/datum/reagent/entry as anything in venomous_bite_choice_specs)
		var/list/specs = venomous_bite_choice_specs[entry]

		var/inject = specs[1]
		var/cooldown = specs[2]

		var/name = entry::name

		titles["[entry]"] = "[name]（[inject]单位，冷却[cooldown / 10]秒）"

	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = titles

	return data

/datum/preference/choiced/venomous_bite_venom/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Venomous Bite" in preferences.all_quirks

/datum/preference/choiced/venomous_bite_venom/apply_to_human(mob/living/carbon/human/target, value)
	return
