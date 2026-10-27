//scan shadekin

/datum/experiment/scanning/people/open_minds
	name = "人类实地研究：互联心智"
	description = "我们需要关于生物超感官交流效果的数据。扫描一些能够出声思考的人形生物样本。"
	performance_hint = "此类能力可通过基因注入诱发，或者找到合适的人。"
	required_traits_desc = "超感官交流"
	required_count = 2

/datum/experiment/scanning/people/open_minds/is_valid_scan_target(mob/living/carbon/human/check)
	. = ..()
	if (!.)
		return

	//check for genetics telepathy
	if(check.dna.check_mutation(/datum/mutation/telepathy))
		return TRUE

	//check for shadekin organs
	var/obj/item/organ/ears/shadekin/ears = check.get_organ_slot(ORGAN_SLOT_EARS)
	var/obj/item/organ/tongue/shadekin/tongue = check.get_organ_slot(ORGAN_SLOT_TONGUE)

	if(istype(ears) || istype(tongue))
		return TRUE

	return FALSE
