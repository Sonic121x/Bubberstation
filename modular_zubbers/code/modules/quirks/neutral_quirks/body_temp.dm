/datum/quirk/bodytemp
	name = "异常体温"
	desc = "你的体温与你所属种族的基础值不同，会向上或向下偏移一定幅度。不建议与冷血种族搭配选取。该特质可在 -40 到 +70 之间调整；由于你被送往空间站的方式，取极端数值时可能会造成轻度烧伤。"
	value = 0
	gain_text = span_danger("你的体温感觉不太对劲。")
	lose_text = span_notice("你的体温恢复正常了。")
	species_blacklist = list(SPECIES_SKRELL) //Skrell already have a insane +70 to their body temp
	medical_record_text = "患者的体温与其种族正常值不符。"
	icon = FA_ICON_THERMOMETER_HALF
	var/bodytemp = 0
	var/species_normal = 0
	var/species_heat = 0
	var/species_cold = 0

/datum/quirk_constant_data/bodytemp
	associated_typepath = /datum/quirk/bodytemp
	customization_options = list(
		/datum/preference/numeric/bodytemp_customization/bodytemp,
	)

/datum/preference/numeric/bodytemp_customization
	abstract_type = /datum/preference/numeric/bodytemp_customization
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = -40 //Plasmamen
	maximum = 70 //Skrell

/datum/preference/numeric/bodytemp_customization/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/bodytemp_customization/create_default_value()
	return 20

/datum/preference/numeric/bodytemp_customization/bodytemp
	savefile_key = "bodytemp"


/datum/quirk/bodytemp/add(client/client_source)
	. = ..()

	var/mob/living/carbon/human/user = quirk_holder
	species_normal = user.dna.species.bodytemp_normal
	species_heat = user.dna.species.bodytemp_heat_damage_limit //Storing the species's default body temps incase the quirk is removed.
	species_cold = user.dna.species.bodytemp_cold_damage_limit
	user.dna.species.bodytemp_normal += bodytemp
	user.dna.species.bodytemp_heat_damage_limit += bodytemp
	user.dna.species.bodytemp_cold_damage_limit += bodytemp

/datum/quirk/bodytemp/post_add()
	. = ..()

	var/mob/living/carbon/human/user = quirk_holder
	var/datum/preferences/prefs = user.client.prefs
	bodytemp = prefs.read_preference(/datum/preference/numeric/bodytemp_customization/bodytemp)
	user.dna.species.bodytemp_normal += bodytemp
	user.dna.species.bodytemp_heat_damage_limit += bodytemp
	user.dna.species.bodytemp_cold_damage_limit += bodytemp

/datum/quirk/bodytemp/remove()
	. = ..()

	if(QDELETED(quirk_holder))
		return
	var/mob/living/carbon/human/user = quirk_holder
	user.dna.species.bodytemp_normal = species_normal
	user.dna.species.bodytemp_heat_damage_limit = species_heat
	user.dna.species.bodytemp_cold_damage_limit = species_cold


