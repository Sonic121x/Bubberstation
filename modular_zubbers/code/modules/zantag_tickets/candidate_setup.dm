/datum/round_event/antagonist/candidate_setup(datum/round_event_control/antagonist/cast_control)

	var/list/candidates_tickets = candidates_to_tickets(cast_control.get_candidates())
	if(!length(candidates_tickets))
		message_admins(span_yellowteamradio("反派票系统未能找到任何候选人！"))
		log_game("反派票系统未能找到任何候选人！")
		return

	//Logging purposes.
	var/total_tickets = 0
	for(var/candidate in candidates_tickets)
		var/candidate_weight = candidates_tickets[candidate]
		total_tickets += candidate_weight
	var/average_tickets = round(total_tickets / length(candidates_tickets),1)

	for(var/i in 1 to antag_count)
		if(!length(candidates_tickets)) //All out of options.
			break
		var/mob/candidate = pick_weight(candidates_tickets)
		candidates_tickets -= candidate
		setup_minds += candidate.mind
		candidate_roles_setup(candidate)
		var/our_weight = candidates_tickets[candidate]
		if(!total_tickets)
			total_tickets = our_weight
		var/percent_chance = round( (our_weight/total_tickets)*100, 1)
		log_antag_tickets("[key_name(candidate)] 以 [percent_chance]% 的抽取概率被设为反派（自身票数：[our_weight]，总票数：[total_tickets]，平均票数：[average_tickets]）。")
