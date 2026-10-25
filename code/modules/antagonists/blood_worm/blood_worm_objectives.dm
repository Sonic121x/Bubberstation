/datum/objective/blood_worm
	abstract_type = /datum/objective/blood_worm

/datum/objective/blood_worm/proc/get_blood_worm_team()
	RETURN_TYPE(/datum/team/blood_worm)
	return team

/datum/objective/blood_worm/kill
	name = "击杀"
	explanation_text = "我们必须阻止空间站指挥部的所有成员活着乘坐紧急穿梭机逃离。"

/datum/objective/blood_worm/kill/check_completion()
	for (var/mob/player_mob as anything in GLOB.player_list)
		if (!(player_mob.mind?.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND))
			continue
		if (!considered_alive(player_mob.mind))
			continue
		if (considered_exiled(player_mob.mind))
			continue
		// Counts whiteship as escaped, but not pods.
		if (player_mob.onCentCom() || player_mob.onSyndieBase())
			return FALSE

	return TRUE

/datum/objective/blood_worm/consume
	name = "吞噬"

	var/blood_required = 0

/datum/objective/blood_worm/consume/New(text)
	blood_required = rand(20, 30) * 100
	update_explanation_text()

/datum/objective/blood_worm/consume/update_explanation_text()
	explanation_text = "我们必须总共吞噬至少 [blood_required] 单位真实血液，才能满足我们的食欲。"

/datum/objective/blood_worm/consume/check_completion()
	return get_blood_worm_team().blood_consumed_total >= blood_required

/datum/objective/blood_worm/multiply
	name = "增殖"

	var/times_required = 0

/datum/objective/blood_worm/multiply/New(text)
	times_required = rand(2, 3)
	update_explanation_text()

/datum/objective/blood_worm/multiply/update_explanation_text()
	explanation_text = "我们中至少 [times_required] 个必须完成繁殖，为我们压倒性的数量铺平道路。"

/datum/objective/blood_worm/multiply/check_completion()
	return get_blood_worm_team().times_reproduced_total >= times_required

/datum/objective/blood_worm/conquer
	name = "征服"

	var/worms_required = 0

/datum/objective/blood_worm/conquer/New(text)
	worms_required = rand(3, 4)
	update_explanation_text()

/datum/objective/blood_worm/conquer/update_explanation_text()
	explanation_text = "我们中至少 [worms_required] 个必须活着乘坐紧急穿梭机逃离，才能征服另一侧的天地。"

/datum/objective/blood_worm/conquer/check_completion()
	var/conquerors = 0

	for (var/datum/mind/member as anything in team.members)
		if (QDELETED(member.current))
			continue
		if (!isbloodworm(member.current) && !HAS_TRAIT(member.current, TRAIT_BLOOD_WORM_HOST))
			continue
		if (member.current.stat == DEAD) // This assumes that the mind of a blood worm that is inhabiting a dead host is in their blood worm mob.
			continue
		if (member.current.onCentCom() || member.current.onSyndieBase())
			conquerors++

	return conquerors >= worms_required
