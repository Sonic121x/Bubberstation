/obj/item/organ/heart/lycan
	name = "狼人心脏"
	desc = "一颗强劲搏动的大心脏。上面的血管远比正常情况粗大。"

/obj/item/organ/heart/lycan/on_mob_insert(mob/living/carbon/organ_owner, special)
	. = ..()
	var/mob/living/carbon/human/human_owner = organ_owner

	if(islycan(organ_owner))
		human_owner.physiology.brute_mod *= 0.5
		human_owner.physiology.burn_mod *= 0.8

/obj/item/organ/heart/lycan/on_mob_remove(mob/living/carbon/organ_owner, special)
	. = ..()
	var/mob/living/carbon/human/human_owner = organ_owner

	if(human_owner.physiology)
		human_owner.physiology.brute_mod /= 0.5
		human_owner.physiology.burn_mod /= 0.8
