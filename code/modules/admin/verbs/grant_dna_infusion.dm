/*
 * Attempts to grant the target all organs from a given DNA infuser entry.area
 * Returns the entry if all organs were successfully replaced.
 * If no infusion was picked, the infusion had no organs, or if one or more organs could not be granted, returns FALSE
*/
GAME_VERB_PROC(/client, grant_dna_infusion, "施加 DNA 注入", "Debug")
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob/living/carbon/human)

	var/list/infusions = list()
	for(var/datum/infuser_entry/path as anything in sort_list(subtypesof(/datum/infuser_entry), GLOBAL_PROC_REF(cmp_typepaths_asc)))
		var/str = "[initial(path.name)] ([path])"
		infusions[str] = path

	var/datum/infuser_entry/picked_infusion = tgui_input_list(usr, "选择注入", "施加 DNA 注入", infusions)

	if(isnull(picked_infusion))
		return FALSE

	// This is necessary because list propererties are not defined until initialization
	picked_infusion = infusions[picked_infusion]
	picked_infusion = new picked_infusion()

	if(!length(picked_infusion.output_organs))
		return FALSE

	. = picked_infusion
	for(var/obj/item/organ/infusion_organ as anything in picked_infusion.output_organs)
		var/obj/item/organ/new_organ = new infusion_organ()
		new_organ.replace_into(target)
		if(new_organ.owner != target)
			to_chat(usr, span_notice("[target] 无法承载 [new_organ]！"))
			qdel(new_organ)
			. = FALSE
			continue
		log_admin("[key_name(usr)] 向 [key_name(target)] 添加了器官 [new_organ.type]")
		message_admins("[key_name_admin(usr)] 向 [ADMIN_LOOKUPFLW(target)] 添加了器官 [new_organ.type]")
