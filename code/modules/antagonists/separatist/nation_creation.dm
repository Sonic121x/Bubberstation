
/**
 * ### create_separatist_nation()
 *
 * Helper called to create the separatist antagonist via making a department independent from the station.
 *
 * * Arguments:
 * * department: which department to revolt. if null, will pick a random non-independent department. starts as a type, then turns into the reference to the singleton.
 * * announcement: whether to tell the station a department has gone independent.
 * * dangerous: whether this nation will have objectives to attack other independent departments, requires more than one nation to exist obviously
 * * message_admins: whether this will admin log how the nation creation went. Errors are still put in runtime log either way.
 *
 * Returns nothing.
 */
/proc/create_separatist_nation(datum/job_department/department, announcement = FALSE, dangerous = FALSE, message_admins = TRUE)
	var/list/jobs_to_revolt = list()
	var/list/citizens = list()

	//departments that are already independent, these will be disallowed to be randomly picked
	var/list/independent_departments = list()
	//reference to all independent nation teams
	var/list/team_datums = list()
	for(var/datum/antagonist/separatist/separatist_datum in GLOB.antagonists)
		var/independent_department_type = separatist_datum.owner?.assigned_role.departments_list[1]
		independent_departments |= independent_department_type
		team_datums |= separatist_datum.nation

	if(!department)
		//picks a random department if none was given
		department = pick(list(/datum/job_department/assistant, /datum/job_department/medical, /datum/job_department/engineering, /datum/job_department/science, /datum/job_department/cargo, /datum/job_department/service, /datum/job_department/security) - independent_departments)
		if(!department)
			if(message_admins)
				message_admins("部门叛乱无法建立国家，因为所有部门都已独立！你们这些疯子，居然把国家都建完了！")
			CRASH("Department Revolt could not create a nation, as all the departments are independent")
	department = SSjob.get_department_type(department)

	for(var/datum/job/job as anything in department.department_jobs)
		if(job.departments_list.len > 1 && job.departments_list[1] != department.type) //their loyalty is in other departments
			continue
		jobs_to_revolt += job.title

	//setup team datum
	var/datum/team/nation/nation = new(null, jobs_to_revolt, department)
	nation.name = department.generate_nation_name()
	var/datum/team/department_target //dodges picking from an empty list giving a runtime.
	if(team_datums.len)
		department_target = pick(team_datums)
	nation.generate_nation_objectives(dangerous, department_target)

	//convert current members of the department
	for(var/mob/living/possible_separatist in GLOB.player_list)
		if(isnull(possible_separatist.mind))
			continue
		var/datum/mind/separatist_mind = possible_separatist.mind
		if(!(separatist_mind.assigned_role.title in jobs_to_revolt))
			continue
		citizens += possible_separatist
		separatist_mind.add_antag_datum(/datum/antagonist/separatist, nation, department)
		nation.add_member(separatist_mind)
		possible_separatist.log_message("被改造成了一名分离主义者，[nation.name] 万岁！", LOG_ATTACK, color="red")

	//if we didn't convert anyone we just kill the team datum, otherwise cleanup and make official
	if(!citizens.len)
		qdel(nation)
		if(message_admins)
			message_admins("[nation.name] 国因潜在成员不足而未能建立。")
		return
	var/jobs_english_list = english_list(jobs_to_revolt)
	if(message_admins)
		message_admins("[nation.name] 国已成立。受影响的职业有：[jobs_english_list]。任何这些职业的新船员都将加入分裂势力。")
	if(announcement)
		var/announce_text = "新的独立国家 [nation.name] 已在 [department.department_name] 部门的废墟中建立！"
		if(istype(department, /datum/job_department/assistant)) //the text didn't really work otherwise
			announce_text = "空间站的助理们已经起义，建立了新的独立国家 [nation.name]！"
		priority_announce(announce_text, "脱离 [GLOB.station_name]",  has_important_message = TRUE)
