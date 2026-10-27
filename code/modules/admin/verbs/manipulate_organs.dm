ADMIN_VERB_VISIBILITY(manipulate_organs, ADMIN_VERB_VISIBLITY_FLAG_MAPPING_DEBUG)

ADMIN_VERB(manipulate_organs, R_DEBUG, "操纵器官", "操纵活体碳基生物的器官。", ADMIN_CATEGORY_DEBUG)
	VERB_ARG_TYPED(carbon_victim, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob/living/carbon)
	var/operation = tgui_input_list(user, "选择器官操作", "器官操纵", list("Add organ", "Add implant", "Drop organ/implant", "Remove organ/implant"))
	if (isnull(operation))
		return

	var/list/organs = list()
	switch(operation)
		if("Add organ")
			// BYOND actually cares about order of addition in assoc lists, as long as its not an alist
			for(var/path in sort_list(subtypesof(/obj/item/organ), GLOBAL_PROC_REF(cmp_typepaths_asc)))
				var/dat = replacetext("[path]", "/obj/item/organ/", ":")
				organs[dat] = path

			var/obj/item/organ/organ_to_grant = tgui_input_list(user, "选择器官类型", "器官操纵", organs)
			if(isnull(organ_to_grant))
				return
			if(isnull(organs[organ_to_grant]))
				return
			organ_to_grant = organs[organ_to_grant]
			organ_to_grant = new organ_to_grant
			organ_to_grant.Insert(carbon_victim)
			log_admin("[key_name(user)] 已向 [key_name(carbon_victim)] 添加器官 [organ_to_grant.type]")
			message_admins("[key_name_admin(user)] 已向 [ADMIN_LOOKUPFLW(carbon_victim)] 添加器官 [organ_to_grant.type]")

		if("Add implant")
			for(var/path in sort_list(subtypesof(/obj/item/implant), GLOBAL_PROC_REF(cmp_typepaths_asc)))
				var/dat = replacetext("[path]", "/obj/item/implant/", ":")
				organs[dat] = path

			var/obj/item/implant/implant_to_grant = tgui_input_list(user, "选择植入体类型", "器官操纵", organs)
			if(isnull(implant_to_grant))
				return
			if(isnull(organs[implant_to_grant]))
				return
			implant_to_grant = organs[implant_to_grant]
			implant_to_grant = new implant_to_grant
			if(!implant_to_grant.implant(carbon_victim))
				to_chat(user, span_notice("[carbon_victim] 无法容纳此植入体！"))
				qdel(implant_to_grant)
				return
			log_admin("[key_name(user)] 已向 [key_name(carbon_victim)] 添加植入体 [implant_to_grant.type]")
			message_admins("[key_name_admin(user)] 已向 [ADMIN_LOOKUPFLW(carbon_victim)] 添加植入体 [implant_to_grant.type]")

		if("Drop organ/implant", "Remove organ/implant")
			for(var/obj/item/organ/user_organs as anything in carbon_victim.organs)
				organs["[user_organs.name] ([user_organs.type])"] = user_organs

			for(var/obj/item/implant/user_implants as anything in carbon_victim.implants)
				organs["[user_implants.name] ([user_implants.type])"] = user_implants

			var/obj/item/organ_to_modify = tgui_input_list(user, "选择器官/植入体", "器官操纵", organs)
			if(isnull(organ_to_modify))
				return
			if(isnull(organs[organ_to_modify]))
				return
			organ_to_modify = organs[organ_to_modify]

			log_admin("[key_name(user)] 已从 [key_name(carbon_victim)] 移除 [organ_to_modify.type]")
			message_admins("[key_name_admin(user)] 已从 [ADMIN_LOOKUPFLW(carbon_victim)] 移除 [organ_to_modify.type]")

			var/obj/item/organ/organ_holder
			var/obj/item/implant/implant_holder

			if(isorgan(organ_to_modify))
				organ_holder = organ_to_modify
				organ_holder.Remove(carbon_victim)
			else
				implant_holder = organ_to_modify
				implant_holder.removed(carbon_victim, special = TRUE)

			organ_to_modify.forceMove(get_turf(carbon_victim))

			if(operation == "Remove organ/implant")
				qdel(organ_to_modify)
			else if(implant_holder) // Put the implant in case.
				var/obj/item/implantcase/case = new(get_turf(carbon_victim))
				case.imp = implant_holder
				implant_holder.forceMove(case)
				case.update_appearance()
