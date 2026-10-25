/datum/quirk/foreigner
	name = "Foreigner"
	desc = "你不是本地人。你不懂银河通用语！"
	icon = FA_ICON_LANGUAGE
	value = 0
	gain_text = span_notice("你完全听不懂周围的人在说什么。")
	lose_text = span_notice("你已经能流利地使用银河通用语了。")
	medical_record_text = "患者不会说银河通用语，可能需要翻译。"
	mail_goodies = list(/obj/item/taperecorder) // for translation

/datum/quirk/foreigner/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.add_blocked_language(/datum/language/common)
	if(ishumanbasic(human_holder))
		human_holder.grant_language(/datum/language/uncommon, source = LANGUAGE_QUIRK)

/datum/quirk/foreigner/remove()
	if(QDELETED(quirk_holder))
		return
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.remove_blocked_language(/datum/language/common)
	if(ishumanbasic(human_holder))
		human_holder.remove_language(/datum/language/uncommon)
