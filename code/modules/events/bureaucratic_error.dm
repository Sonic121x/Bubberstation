/datum/round_event_control/bureaucratic_error
	name = "官僚失误"
	typepath = /datum/round_event/bureaucratic_error
	max_occurrences = 1
	weight = 5
	category = EVENT_CATEGORY_BUREAUCRATIC
	description = "随机开启与关闭岗位名额，并更改溢出岗位。"

/datum/round_event/bureaucratic_error
	announce_when = 1

/datum/round_event/bureaucratic_error/announce(fake)
	priority_announce("有机资源部近期发生的一起官僚失误，可能导致部分部门人手短缺，而另一些部门人员冗余。", "文书事故警报")

/datum/round_event/bureaucratic_error/start()
	var/list/jobs = SSjob.get_valid_overflow_jobs()
	/* SKYRAT EDIT REMOVAL START
	if(prob(33)) // Only allows latejoining as a single role.
		var/datum/job/overflow = pick_n_take(jobs)
		overflow.spawn_positions = -1
		overflow.total_positions = -1 // Ensures infinite slots as this role. Assistant will still be open for those that cant play it.
		for(var/job in jobs)
			var/datum/job/current = job
			current.total_positions = 0
		return
	*/ // SKYRAT EDIT REMOVAL - no more locking off jobs
	// Adds/removes a random amount of job slots from all jobs.
	for(var/datum/job/current as anything in jobs)
		current.total_positions = max(current.total_positions + rand(-2,4), 1) // SKYRAT EDIT CHANGE - No more locking off jobs - ORIGINAL: current.total_positions = max(current.total_positions + rand(-2,4), 0)
