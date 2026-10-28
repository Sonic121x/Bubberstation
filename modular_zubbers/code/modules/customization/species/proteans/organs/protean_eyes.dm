/obj/item/organ/eyes/robotic/protean
	name = "成像纳米机器人"
	desc = "设计用于从周围世界收集视觉数据的纳米机器人。"
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/eyes/robotic/protean/Initialize(mapload)
	if(QDELETED(src))
		return FALSE
	return ..()

/obj/item/organ/eyes/robotic/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)

