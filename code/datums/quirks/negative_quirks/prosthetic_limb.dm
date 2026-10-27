/datum/quirk/prosthetic_limb
	name = "Prosthetic Limb"
	desc = "一次事故让你失去了一条肢体。因此，你现在装着一条廉价库存义肢！"
	icon = "tg-prosthetic-leg"
	value = -3
	hardcore_value = 3
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_CHANGES_APPEARANCE
	mail_goodies = list(/obj/item/weldingtool/mini, /obj/item/stack/cable_coil/five)
	/// The slot to replace, in string form
	var/slot_string = "limb"
	/// The slot to replace, in GLOB.limb_zones (both arms and both legs)
	var/limb_zone
	

/datum/quirk_constant_data/prosthetic_limb
	associated_typepath = /datum/quirk/prosthetic_limb
	customization_options = list(/datum/preference/choiced/prosthetic)

/datum/quirk/prosthetic_limb/add_unique(client/client_source)
	var/obj/item/bodypart/limb_type = GLOB.prosthetic_limb_choice[client_source?.prefs?.read_preference(/datum/preference/choiced/prosthetic)]
	if(isnull(limb_type))  //Client gone or they chose a random prosthetic
		limb_type = GLOB.prosthetic_limb_choice[pick(GLOB.prosthetic_limb_choice)]
	limb_zone = limb_type.body_zone

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/bodypart/surplus = new limb_type()
	slot_string = "[surplus.plaintext_zone]"

	medical_record_text = "患者的[chinese_body_zone_display(slot_string)]使用廉价义肢。"
	human_holder.del_and_replace_bodypart(surplus, special = TRUE)

/datum/quirk/prosthetic_limb/post_add()
	to_chat(quirk_holder, span_bolddanger("你的[chinese_body_zone_display(slot_string)]被替换成了廉价库存义肢。它几乎没有肌力，光是装着它就会让你的身体状况变差。此外，\
	你需要用焊接工具和电缆来修理它，而不是缝合线和再生网。"))

/datum/quirk/prosthetic_limb/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.reset_to_original_bodypart(limb_zone)
