/datum/quirk/chip_connector
	name = "Chip Connector"
	desc = "你安装了一种能让你手动装卸技能芯片的装置！不过最好离电磁脉冲远点。"
	icon = FA_ICON_PLUG
	value = 4
	gain_text = span_notice("你感觉自己接通了。")
	lose_text = span_danger("你不再有那种接通的感觉了。")
	medical_record_text = "患者后脑装有机械植入物，可随意装卸技能芯片。真恶心。"
	mail_goodies = list()
	var/obj/item/organ/cyberimp/brain/connector/connector

/datum/quirk/chip_connector/New()
	. = ..()
	mail_goodies = assoc_to_keys(GLOB.quirk_chipped_choice) + /datum/quirk/chipped::mail_goodies

/datum/quirk/chip_connector/add_unique(client/client_source)
	. = ..()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if(!iscarbon(quirk_holder))
		return
	connector = new()
	connector.Insert(carbon_holder, special = TRUE)

/datum/quirk/chip_connector/post_add()
	to_chat(quirk_holder, span_bolddanger(desc)) // efficiency is clever laziness

/datum/quirk/chip_connector/remove()
	qdel(connector)
