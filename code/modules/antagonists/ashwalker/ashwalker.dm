/datum/antagonist/ashwalker
	name = "\improper 灰行者"
	pref_flag = ROLE_LAVALAND
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	antagpanel_category = ANTAG_GROUP_ASHWALKERS
	suicide_cry = "我完全不知道这东西是干什么的！！"
	antag_flags = ANTAG_FAKE|ANTAG_SKIP_GLOBAL_LIST
	var/datum/team/ashwalkers/ashie_team

/datum/antagonist/ashwalker/create_team(datum/team/ashwalkers/ashwalker_team)
	if(ashwalker_team)
		ashie_team = ashwalker_team
		objectives |= ashie_team.objectives
	else
		ashie_team = new

/datum/antagonist/ashwalker/get_team()
	return ashie_team

/datum/antagonist/ashwalker/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	UnregisterSignal(old_body, COMSIG_MOB_EXAMINATE)
	RegisterSignal(new_body, COMSIG_MOB_EXAMINATE, PROC_REF(on_examinate))

/datum/antagonist/ashwalker/on_gain()
	. = ..()
	RegisterSignal(owner.current, COMSIG_MOB_EXAMINATE, PROC_REF(on_examinate))
	owner.teach_crafting_recipe(/datum/crafting_recipe/skeleton_key)
	owner.teach_crafting_recipe(/datum/crafting_recipe/arrow) //BUBBER EDIT - ASH WALKER SHOULD KNOW HOW TO FLETCH
	owner.current.remove_faction(FACTION_NEUTRAL) // ashwalkers aren't neutral; they're ashwalker-aligned

/datum/antagonist/ashwalker/on_removal()
	. = ..()
	if(!owner.current)
		return
	UnregisterSignal(owner.current, COMSIG_MOB_EXAMINATE)
	owner.current.add_faction(FACTION_NEUTRAL)

/datum/antagonist/ashwalker/proc/on_examinate(datum/source, atom/A)
	SIGNAL_HANDLER

	if(istype(A, /obj/structure/headpike))
		owner.current.add_mood_event("oogabooga", /datum/mood_event/sacrifice_good)

/datum/team/ashwalkers
	name = "灰行者部落"
	member_name = "灰行者"
	///A list of "worthy" (meat-bearing) sacrifices made to the Necropolis
	var/sacrifices_made = 0
	///A list of how many eggs were created by the Necropolis
	var/eggs_created = 0

/datum/team/ashwalkers/roundend_report()
	var/list/report = list()

	report += span_header("一支灰行者部落曾栖息于荒原之中……</span><br>")
	if(length(members)) //The team is generated alongside the tendril, and it's entirely possible that nobody takes the role.
		report += "[member_name]共有以下成员："
		report += printplayerlist(members)

		var/datum/objective/protect_object/necropolis_objective = locate(/datum/objective/protect_object) in objectives

		if(necropolis_objective)
			objectives -= necropolis_objective //So we don't count it in the check for other objectives.
			report += "<b>[name]的任务是保卫死灵之都：</b>"
			if(necropolis_objective.check_completion())
				report += span_greentext(span_header("巢穴屹立不倒！死灵之都万岁！<br>"))
			else
				report += span_redtext(span_header("死灵之都已毁，部落已然覆灭……<br>"))

		if(length(objectives))
			report += span_header("[name]的其他目标有：")
			printobjectives(objectives)

		report += "[name]共向死灵之都献上了 <b>[sacrifices_made]</b> 次祭品。死灵之都由此产下了 <b>[eggs_created]</b> 枚灰行者卵。"

	else
		report += "<b>但它的卵一颗也没有孵化！</b>"

	return "<div class='panel redborder'>[report.Join("<br>")]</div>"
