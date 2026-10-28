/datum/mkultra_command/strip
	name = "脱衣"
	description = "让你的奴隶为你脱光衣服。"
	feedback = "脱光了所有衣服。"
	trigger = "strip|remove your clothes|derobe|nude"
	phase_requirement = 2
	erp_command = TRUE
	cooldown = 20 SECONDS

/datum/mkultra_command/strip/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/human/person = owner
	var/obj/item/items = owner.get_contents()
	for(var/obj/item/stuff in items)
		if(stuff == person.wear_suit)
			person.dropItemToGround(stuff)
			continue
		if(stuff == person.w_uniform)
			person.dropItemToGround(stuff)
			continue
	to_chat(person, span_userlove("还没等你反应过来，你的双手就已经遵从[status.get_gender()]的命令开始脱去衣物！"))
