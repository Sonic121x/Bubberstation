/datum/quirk/item_quirk/chronic_illness
	name = "Eradicative Chronic Illness"
	desc = "你患有一种异常的慢性病，需要持续用药才能控制，否则会引发时间流修正。"
	icon = FA_ICON_DISEASE
	value = -12
	gain_text = span_danger("你感觉自己正在逐渐消失……")
	lose_text = span_notice("你突然感觉自己更加真实了。")
	medical_record_text = "患者患有一种异常的慢性病，需要持续用药才能控制。"
	hardcore_value = 12
	mail_goodies = list(/obj/item/storage/pill_bottle/sansufentanyl)

/datum/quirk/item_quirk/chronic_illness/add(client/client_source)
	var/datum/disease/chronic_illness/hms = new()
	quirk_holder.ForceContractDisease(hms, make_copy = FALSE, del_on_fail = TRUE)

/datum/quirk/item_quirk/chronic_illness/add_unique(client/client_source)
	give_item_to_holder(/obj/item/storage/pill_bottle/sansufentanyl, list(LOCATION_BACKPACK), flavour_text = "你获得了用于控制病情的药物。请定期服用，避免出现并发症。", notify_player = TRUE)
	give_item_to_holder(/obj/item/healthanalyzer/simple/disease, list(LOCATION_BACKPACK))
