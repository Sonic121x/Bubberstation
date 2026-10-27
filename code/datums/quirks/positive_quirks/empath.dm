/datum/quirk/empath
	name = "Empath"
	desc = "无论靠的是第六感还是对肢体语言的细致研究，你只需看一眼就能了解别人的感受。"
	icon = FA_ICON_SMILE_BEAM
	value = 6 // SKYRAT EDIT CHANGE - Quirk Rebalance - Original: value = 8
	gain_text = span_notice("你感觉与周围的人心意相通。")
	lose_text = span_danger("你感觉与他人隔绝了。")
	medical_record_text = "患者对社交暗示的感知极其敏锐，也可能拥有超感官知觉。需要进一步检查。"
	mail_goodies = list(/obj/item/toy/foamfinger)

/datum/quirk/empath/add(client/client_source)
	quirk_holder.AddComponentFrom(REF(src), /datum/component/empathy)

/datum/quirk/empath/remove(client/client_source)
	quirk_holder.RemoveComponentSource(REF(src), /datum/component/empathy)
