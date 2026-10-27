/datum/quirk/nyctophobia
	name = "Nyctophobia"
	desc = "从记事起，你就一直害怕黑暗。\
		身处没有光源的黑暗中时，你会持续感到恐惧。"
	icon = FA_ICON_LIGHTBULB
	value = -3
	medical_record_text = "患者表现出对黑暗的恐惧。（认真的吗？）"
	medical_symptom_text = "在黑暗环境中会出现惊恐发作与呼吸急促。\
		心定宁等药物或可减轻反应的严重程度。"
	hardcore_value = 5
	mail_goodies = list(/obj/effect/spawner/random/engineering/flashlight)
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_TRAUMALIKE

/datum/quirk/nyctophobia/add(client/client_source)
	quirk_holder.AddComponentFrom(type, /datum/component/fearful, list(/datum/terror_handler/simple_source/nyctophobia))

/datum/quirk/nyctophobia/remove()
	quirk_holder.RemoveComponentSource(type, /datum/component/fearful)
