/datum/quirk/item_quirk/limper
	name = "Limper"
	desc = "你走路时明显跛行，移动速度因此大幅降低。幸好你带了手杖。"
	icon = FA_ICON_PERSON_CANE
	gain_text = span_danger("你的腿感觉有些无力。")
	lose_text = span_notice("你的双腿感觉恢复正常了。")
	medical_record_text = "患者似乎存在腿部无力。"
	value = -6
	hardcore_value = 3

	mail_goodies = list(
		/obj/item/cane,
		/obj/item/cane/crutch,
		/obj/item/cane/white,
	)

/datum/quirk/item_quirk/limper/add_unique(client/client_source)
	give_item_to_holder(new /obj/item/cane(get_turf(quirk_holder)), list(
			LOCATION_HANDS,
			LOCATION_BACKPACK,
		))
	return

/datum/quirk/item_quirk/limper/add(client/client_source)
	quirk_holder.apply_status_effect(/datum/status_effect/limp/quirk)

/datum/quirk/item_quirk/limper/remove(client/client_source)
	quirk_holder.remove_status_effect(/datum/status_effect/limp/quirk)

