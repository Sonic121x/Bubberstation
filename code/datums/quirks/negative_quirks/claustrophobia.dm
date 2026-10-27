/datum/quirk/claustrophobia
	name = "Claustrophobia"
	desc = "你害怕狭小空间和某些喜气洋洋的人物。被放入任何容器、柜子或机器内，都会让你惊恐发作、呼吸困难。"
	icon = FA_ICON_BOX_OPEN
	value = -4
	medical_record_text = "患者表现出对狭小空间的恐惧。"
	medical_symptom_text = "被困在狭小空间时会出现惊恐发作与呼吸急促。\
		心定宁等药物或可减轻反应的严重程度。"
	hardcore_value = 5
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_TRAUMALIKE
	mail_goodies = list(/obj/item/reagent_containers/syringe/convermol) // to help breathing

/datum/quirk/claustrophobia/add(client/client_source)
	quirk_holder.AddComponentFrom(type, /datum/component/fearful, list(/datum/terror_handler/simple_source/claustrophobia, /datum/terror_handler/simple_source/clausophobia))

/datum/quirk/claustrophobia/remove()
	quirk_holder.RemoveComponentSource(type, /datum/component/fearful)
