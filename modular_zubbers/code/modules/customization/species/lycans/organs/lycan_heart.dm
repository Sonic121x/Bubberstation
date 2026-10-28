/obj/item/organ/heart/lycan
	name = "狼人心脏"
	desc = "一颗强劲搏动的大心脏。上面的血管远比正常情况粗大。"

/obj/item/organ/heart/lycan/on_mob_insert(mob/living/carbon/organ_owner, special)
	. = ..()
	var/mob/living/carbon/human/human_owner = organ_owner

	if(islycan(organ_owner))
		MODIFY_PHYSIOLOGY(human_owner, BRUTE, 0.5)
		MODIFY_PHYSIOLOGY(human_owner, BURN, 0.8)

/obj/item/organ/heart/lycan/on_mob_remove(mob/living/carbon/organ_owner, special)
	. = ..()
	var/mob/living/carbon/human/human_owner = organ_owner

	if(human_owner.physiology)
		MODIFY_PHYSIOLOGY(human_owner, BRUTE, 1/0.5)
		MODIFY_PHYSIOLOGY(human_owner, BURN, 1/0.8)
