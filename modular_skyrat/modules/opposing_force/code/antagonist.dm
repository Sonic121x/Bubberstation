GLOBAL_LIST_EMPTY(opfor_passed_ckeys)

/datum/antagonist/opfor_candidate
	name = "\improper 敌对势力候选人"
	pref_flag = ROLE_OPFOR_CANDIDATE
	show_name_in_check_antagonists = TRUE
	ui_name = "AntagInfoOpfor"
	suicide_cry = "为了我匮乏的创造力！！！"
	preview_outfit = /datum/outfit/job/assistant/consistent

/datum/antagonist/opfor_candidate/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("pass_on")
			message_admins("[key_name(usr)]移除了自己的敌对势力候选人身份。[ADMIN_PASS_OPFOR(usr)]")
			var/mob/user = usr
			user?.mind?.remove_antag_datum(/datum/antagonist/opfor_candidate)
			GLOB.opfor_passed_ckeys += usr.ckey
			return TRUE
