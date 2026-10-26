/mob/living/carbon/examine_more(mob/user)
	. = ..()
	var/t_His = p_Their()
	var/t_He = p_They()
	var/t_Has = p_have()

	var/any_bodypart_damage = FALSE
	for(var/X in bodyparts)
		var/obj/item/bodypart/LB = X
		if(LB.bodypart_flags & BODYPART_PSEUDOPART)
			continue
		var/limb_max_damage = LB.max_damage
		var/status = ""
		var/brutedamage = round(LB.brute_dam/limb_max_damage*100)
		var/burndamage = round(LB.burn_dam/limb_max_damage*100)
		switch(brutedamage)
			if(20 to 50)
				status = LB.light_brute_msg
			if(51 to 75)
				status = LB.medium_brute_msg
			if(76 to 100)
				status += LB.heavy_brute_msg

		if(burndamage >= 20 && status)
			status += "，并且"
		switch(burndamage)
			if(20 to 50)
				status += LB.light_burn_msg
			if(51 to 75)
				status += LB.medium_burn_msg
			if(76 to 100)
				status += LB.heavy_burn_msg

		if(status)
			any_bodypart_damage = TRUE
			. += "\t<span class='warning'>[LB.name][status]。</span>"

		for(var/thing in LB.wounds)
			any_bodypart_damage = TRUE
			var/datum/wound/W = thing
			switch(W.severity)
				if(WOUND_SEVERITY_TRIVIAL)
					. += "\t<span class='warning'>[LB.name]有[W.get_topic_name(user)]。</span>"
				if(WOUND_SEVERITY_MODERATE)
					. += "\t<span class='warning'>[LB.name]有[W.get_topic_name(user)]！</span>"
				if(WOUND_SEVERITY_SEVERE)
					. += "\t<span class='warning'><b>[LB.name]有[W.get_topic_name(user)]！</b></span>"
				if(WOUND_SEVERITY_CRITICAL)
					. += "\t<span class='warning'><b>[LB.name]有[W.get_topic_name(user)]！！</b></span>"
		var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(LB.applied_items, LIMB_ITEM_GAUZE)
		if(current_gauze)
			var/gauze_verb = current_gauze.is_splinting(LB) ? "夹板固定" : "包扎"
			. += "\t<span class='notice'><i>[LB.name]已用 <a href='byond://?src=[REF(current_gauze)];remove=1'>[current_gauze.name]</a> [gauze_verb]。</i></span>"

	if(!any_bodypart_damage)
		. += "\t<span class='smallnotice'><i>没有明显受损的身体部位。</i></span>"

	var/list/visible_scars
	if(all_scars)
		for(var/i in all_scars)
			var/datum/scar/S = i
			if(S.is_visible(user))
				LAZYADD(visible_scars, S)

	if(!visible_scars)
		. += "\t<span class='smallnotice'><i>没有可见的疤痕。</i></span>"

	return .
