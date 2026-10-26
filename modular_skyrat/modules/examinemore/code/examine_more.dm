/*
EXTRA EXAMINE MODULE

This is the module for handling items with special examine stats,
like syndicate items having information in their description that
would only be recognisable with someone that had the syndicate trait.
*/

/obj/item
	//The special description that is triggered when special_desc_requirements are met. Make sure you set the correct EXAMINE_CHECK!
	var/special_desc = ""

	//The special affiliation type, basically overrides the "Syndicate Affiliation" for SYNDICATE check types. It will show whatever organisation you put here instead of "Syndicate Affiliation"
	var/special_desc_affiliation = ""

	//The requirement setting for special descriptions. See examine_defines.dm for more info.
	var/special_desc_requirement = EXAMINE_CHECK_NONE

	//The ROLE requirement setting if EXAMINE_CHECK_ROLE is set. E.g. ROLE_SYNDICATE. As you can see, it's a list. So when setting it, ensure you do = list(shit1, shit2)
	var/list/special_desc_roles

	//The JOB requirement setting if EXAMINE_CHECK_JOB is set. E.g. JOB_SECURITY_OFFICER. As you can see, it's a list. So when setting it, ensure you do = list(shit1, shit2)
	var/list/special_desc_jobs

	//The FACTION requirement setting if EXAMINE_CHECK_FACTION is set. E.g. "Syndicate". As you can see, it's a list. So when setting it, ensure you do = list(shit1, shit2)
	var/list/special_desc_factions


/obj/item/examine(mob/user)
	. = ..()
	if(special_desc_requirement == EXAMINE_CHECK_NONE && special_desc)
		. += span_notice("这件物品可以进一步检查……")

/obj/item/examine_more(mob/user)
	. = ..()
	if(special_desc)
		var/composed_message
		switch(special_desc_requirement)
			//Will always show if set
			if(EXAMINE_CHECK_NONE)
				composed_message = "你注意到以下内容：<br>"
				composed_message += special_desc
				. += composed_message
			//Mindshield checks
			if(EXAMINE_CHECK_MINDSHIELD)
				if(HAS_TRAIT(user, TRAIT_MINDSHIELD))
					composed_message = "你因你的<span class='blue'><b>心智护盾</b></span>而注意到以下内容：<br>"
					composed_message += special_desc
					. += composed_message
			//Standard syndicate checks
			if(EXAMINE_CHECK_SYNDICATE)
				if(user.mind)
					var/datum/mind/M = user.mind
					if((ROLE_TRAITOR in M.get_special_roles()) || (user.has_faction(ROLE_SYNDICATE)))
						composed_message = "你因你的<span class='red'><b>[special_desc_affiliation ? special_desc_affiliation : "辛迪加归属"]</b></span>而注意到以下内容：<br>"
						composed_message += special_desc
						. += composed_message
					else if(HAS_TRAIT(M, TRAIT_DETECTIVE))  //Useful detective!
						composed_message = "你因你出色的<span class='blue'><b>侦探技能</b></span>而注意到以下内容：<br>"
						composed_message += special_desc
						. += composed_message
			//As above, but with a toy desc for those looking at it
			if(EXAMINE_CHECK_SYNDICATE_TOY)
				if(user.mind)
					var/datum/mind/M = user.mind
					if((ROLE_TRAITOR in M.get_special_roles()) || (user.has_faction(ROLE_SYNDICATE)))
						composed_message = "你因你的<span class='red'><b>[special_desc_affiliation ? special_desc_affiliation : "辛迪加归属"]</b></span>而注意到以下内容：<br>"
						composed_message += special_desc
						. += composed_message
					else if(HAS_TRAIT(M, TRAIT_DETECTIVE)) //Useful detective!
						composed_message = "你因你出色的<span class='blue'><b>侦探技能</b></span>而注意到以下内容：<br>"
						composed_message += special_desc
						. += composed_message
					else
						composed_message = "这款广受欢迎的玩具仿照当地街机厅的 [src] 制成，适合儿童和成人。"
						. += composed_message
			//Standard role checks
			if(EXAMINE_CHECK_ROLE)
				if(user.mind)
					var/datum/mind/M = user.mind
					for(var/role_i in special_desc_roles)
						if(role_i in M.get_special_roles())
							composed_message = "你因你的<b>[role_i]</b>身份而注意到以下内容：<br>"
							composed_message += special_desc
							. += composed_message
			//Standard job checks
			if(EXAMINE_CHECK_JOB)
				if(ishuman(user))
					var/mob/living/carbon/human/H = user
					for(var/job_i in special_desc_jobs)
						if(H.job == job_i)
							composed_message = "你因担任<b>[job_i]</b>而注意到以下内容：<br>"
							composed_message += special_desc
							. += composed_message
			//Standard faction checks
			if(EXAMINE_CHECK_FACTION)
				for(var/faction_i in special_desc_factions)
					if(user.has_faction(faction_i))
						composed_message = "你因对<b>[faction_i]</b>的忠诚而注意到以下内容：<br>"
						composed_message += special_desc
						. += composed_message


/*
*	EXAMPLES
*/

/obj/item/storage/backpack/duffelbag/syndie
	name = "行李袋"
	desc = "一个用于存放额外补给品的大号行李袋。"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "这个包用于存放战术装备，由辛迪加制造。"
