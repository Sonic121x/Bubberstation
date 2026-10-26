// SKYRAT NEGATIVE TRAITS

/datum/quirk/alexithymia
	name = "Alexithymia"
	desc = "你无法准确判断自己的感受。"
	value = -4
	mob_trait = TRAIT_MOOD_NOEXAMINE
	medical_record_text = "患者无法表达自己的情绪。"
	icon = FA_ICON_QUESTION_CIRCLE

/datum/quirk/fragile
	name = "Fragility"
	desc = "你的身体十分脆弱。烧伤和挫伤对你的伤害比常人更大！"
	value = -6
	medical_record_text = "患者的身体已适应低重力。遗憾的是，低重力环境不利于强健骨骼的发育。"
	icon = FA_ICON_TIRED

/datum/quirk_constant_data/fragile
	associated_typepath = /datum/quirk/fragile
	customization_options = list(
		/datum/preference/numeric/fragile_customization/brute,
		/datum/preference/numeric/fragile_customization/burn,
	)

/datum/preference/numeric/fragile_customization
	abstract_type = /datum/preference/numeric/fragile_customization
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER

	minimum = 1.25
	maximum = 5 // 5x damage, arbitrary

	step = 0.01

/datum/preference/numeric/fragile_customization/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/fragile_customization/create_default_value()
	return 1.25

/datum/preference/numeric/fragile_customization/brute
	savefile_key = "fragile_brute"

/datum/preference/numeric/fragile_customization/burn
	savefile_key = "fragile_burn"

/datum/quirk/fragile/post_add()
	. = ..()

	var/mob/living/carbon/human/user = quirk_holder
	var/datum/preferences/prefs = user.client.prefs
	var/brutemod = prefs.read_preference(/datum/preference/numeric/fragile_customization/brute)
	var/burnmod = prefs.read_preference(/datum/preference/numeric/fragile_customization/burn)

	user.physiology.brute_mod *= brutemod
	user.physiology.burn_mod *= burnmod

/datum/quirk/fragile/remove()
	. = ..()

	if(QDELETED(quirk_holder))
		return
	var/mob/living/carbon/human/user = quirk_holder
	var/datum/preferences/prefs = user.client.prefs
	var/brutemod = prefs.read_preference(/datum/preference/numeric/fragile_customization/brute)
	var/burnmod = prefs.read_preference(/datum/preference/numeric/fragile_customization/burn)
	// will cause issues if the user changes this value before removal
	user.physiology.brute_mod /= brutemod
	user.physiology.burn_mod /= burnmod

/datum/quirk/monophobia
	name = "Monophobia"
	desc = "没有他人陪伴时，你会变得越来越紧张，引发从恶心到心脏病发作等各种恐慌反应。"
	value = -6
	gain_text = span_danger("你感到十分孤独……")
	lose_text = span_notice("你觉得自己独处也能安然无恙。")
	medical_record_text = "患者独处时会感到恶心和痛苦，压力可能达到致命程度。"
	icon = FA_ICON_PEOPLE_ARROWS_LEFT_RIGHT

/datum/quirk/monophobia/post_add()
	. = ..()
	var/mob/living/carbon/human/user = quirk_holder
	user.gain_trauma(/datum/brain_trauma/severe/monophobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/monophobia/remove()
	. = ..()
	var/mob/living/carbon/human/user = quirk_holder
	user?.cure_trauma_type(/datum/brain_trauma/severe/monophobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/no_guns
	name = "No Guns"
	desc = "出于某种原因，你无法使用枪械。具体缘由由你自己决定。"
	gain_text = span_notice("你觉得自己再也无法使用枪械了……")
	lose_text = span_notice("你突然觉得自己又能使用枪械了！")
	medical_record_text = "患者无法使用枪械，原因不明。"
	value = -6
	mob_trait = TRAIT_NOGUNS
	icon = FA_ICON_GUN
