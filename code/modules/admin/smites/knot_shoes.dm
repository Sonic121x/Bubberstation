/// Ties the target's shoes
/datum/smite/knot_shoes
	name = "系死鞋带"

/datum/smite/knot_shoes/effect(client/user, mob/living/target)
	. = ..()
	if (!ishuman(target))
		to_chat(user, span_warning("此打击只能用于人类生物。"), confidential = TRUE)
		return
	var/mob/living/carbon/human/dude = target
	var/obj/item/clothing/shoes/sick_kicks = dude.shoes
	if (!istype(sick_kicks) || sick_kicks.fastening_type == SHOES_SLIPON)
		to_chat(user, span_warning("[dude] 没有可以系鞋带的鞋子！"), confidential = TRUE)
		return
	sick_kicks.adjust_laces(SHOES_KNOTTED)
