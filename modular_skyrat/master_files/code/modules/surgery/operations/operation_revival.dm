// DNR TRAIT - need this so that people don't just keep spamming the revival surgery; it runs success just bc the surgery steps are done
/datum/surgery_operation/basic/revival/on_failure(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	if(HAS_TRAIT(patient, TRAIT_DNR))
		patient.visible_message(span_warning("……[patient] 静静地躺着，毫无反应。再多的尝试也是徒劳，已经回不来了。"))
		patient.adjust_organ_loss(ORGAN_SLOT_BRAIN, 50, 199) // MAD SCIENCE
	else
		return ..()
