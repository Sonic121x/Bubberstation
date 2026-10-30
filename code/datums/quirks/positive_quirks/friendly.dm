/datum/quirk/friendly
	name = "Friendly"
	desc = "你的拥抱最棒了，尤其是在你心情好的时候。"
	icon = FA_ICON_HANDS_HELPING
	value = 2
	mob_trait = TRAIT_FRIENDLY
	gain_text = span_notice("你想抱抱别人。")
	lose_text = span_danger("你不再有拥抱别人的冲动。")
	medical_record_text = "患者对身体接触毫不拘束，双臂肌肉发达。请求其他医生接手此病例。"
	mail_goodies = list(/obj/item/storage/box/hug)

/datum/quirk/friendly/add_unique(client/client_source)
	var/mob/living/carbon/human/human_quirkholder = quirk_holder
	var/obj/item/organ/heart/holder_heart = human_quirkholder.get_organ_slot(ORGAN_SLOT_HEART)
	if(isnull(holder_heart) || isnull(holder_heart.reagents))
		return
	holder_heart.reagents.maximum_volume = 20
	// We have a bigger heart full of love!
	holder_heart.reagents.add_reagent(/datum/reagent/love, 2.5)
	// Like, physically bigger.
	holder_heart.reagents.add_reagent(/datum/reagent/consumable/nutriment/organ_tissue, 5)
	holder_heart.transform = holder_heart.transform.Scale(1.5)
	holder_heart.beat_noise += "。它散发着充满爱意的温暖" // wuv is a detectable diagnostic quality
