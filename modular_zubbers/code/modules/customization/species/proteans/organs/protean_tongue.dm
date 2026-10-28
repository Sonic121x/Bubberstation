/obj/item/organ/tongue/cybernetic/protean
	name = "\improper 普罗蒂安音频发生器"
	desc = "数以百万计的纳米机器人和谐地振动，发出你所听到的声音。"
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/tongue/cybernetic/protean/Insert(mob/living/carbon/receiver, special, movement_flags)
	if(QDELETED(src))
		return FALSE
	return ..()

/obj/item/organ/tongue/cybernetic/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)

