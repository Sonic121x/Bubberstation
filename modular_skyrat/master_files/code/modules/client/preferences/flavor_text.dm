/datum/preference/text/flavor_text
	category = PREFERENCE_CATEGORY_CHARACTER_BASICS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["flavor_text"] = value

/datum/preference/text/silicon_flavor_text
	category = PREFERENCE_CATEGORY_SILICON_PREFS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "silicon_flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN
	// This does not get a apply_to_human proc, this is read directly in silicon/robot/examine.dm

/datum/preference/text/silicon_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE // To prevent the not-implemented runtime

/datum/preference/text/ooc_notes
	category = PREFERENCE_CATEGORY_OOC_PREFS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ooc_notes"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/ooc_notes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ooc_notes"] = value

/datum/preference/text/custom_species
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_species"
	maximum_value_length = 100

/datum/preference/text/custom_species/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["custom_species"] = value

/datum/preference/text/custom_species/is_accessible(datum/preferences/preferences)
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	if(species_type)
		if(initial(species_type.lore_protected))
			return FALSE
	return ..()

/datum/preference/text/taste
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_taste"
	maximum_value_length = 100

/datum/preference/text/taste/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["taste"] = value
	return FALSE

/datum/preference/text/smell
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_smell"
	maximum_value_length = 100

/datum/preference/text/smell/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["smell"] = value
	return FALSE

/datum/preference/text/custom_species_lore
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_species_lore"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/custom_species_lore/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["custom_species_lore"] = value

/datum/preference/text/custom_species_lore/is_accessible(datum/preferences/preferences)
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	if(species_type)
		if(initial(species_type.lore_protected))
			return FALSE
	return ..()


// RP RECORDS REJUVINATION - All of these are handled in datacore, so we dont apply it to the human.
/datum/preference/text/general
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "general_record"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/general/create_default_value()
	return "个人信息 \n\ 姓名： \n\ 种族： \n\ 外貌描述：身高、体重、可辨年龄 \n\ 出生日期： \n\ 母星： \n\ 首选语言： \n\ 掌握语言： \n\ 联系方式：住址、近亲、电话号码"

/datum/preference/text/general/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/medical
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "medical_record"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/medical/create_default_value()
	return "体格评估 \n\ \n\ 心理评估 \n\ \n\ 用药史 \n\ \n\ 手术史 \n\ \n\ 医生备注："

/datum/preference/text/medical/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/security
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "security_record"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/security/create_default_value()
	return "教育经历 \n\ \n\ 工作履历 \n\ 入职时间： \n\ 犯罪记录 \n\ \n\ 忠诚评级： \n\ 施压筹码：用于要挟该船员的点数 \n\ \n\ 案卷员备注："

/datum/preference/text/security/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/exploitable
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "exploitable_info"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/exploitable/create_default_value()
	return EXPLOITABLE_DEFAULT_TEXT

/datum/preference/text/exploitable/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/background
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "background_info"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/background/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
