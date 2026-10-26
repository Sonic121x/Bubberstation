/datum/controller/subsystem/job/proc/FreeRole(rank)
	if(!rank)
		stack_trace("FreeRole called to free job slot with no rank specified")
		return
	var/datum/job/job = get_job(rank)
	if(!job)
		stack_trace("FreeRole could not map rank [rank] to a job slot")
		return FALSE
	log_econ("正在修改 [job.title] 的岗位名额。现有名额：[job.current_positions]/[job.total_positions] 新名额：[max(0, job.current_positions - 1)]/[job.total_positions]")
	job.current_positions = max(0, job.current_positions - 1)

/// Used for clocking back in, re-claiming the previously freed role. Returns false if no slot is available.
/datum/controller/subsystem/job/proc/OccupyRole(rank)
	if(!rank)
		stack_trace("OccupyRole called to free job slot with no rank specified")
		return FALSE
	var/datum/job/job = get_job(rank)
	if(!job)
		stack_trace("FreeRole could not map rank [rank] to a job slot")
		return FALSE
	if(job.current_positions >= job.total_positions)
		log_econ("因无可用岗位名额，修改 [job.title] 的岗位名额失败。当前名额：[job.current_positions]/[job.total_positions]")
		return FALSE
	log_econ("正在修改 [job.title] 的岗位名额。现有名额：[job.current_positions]/[job.total_positions] 新名额：[job.current_positions + 1]/[job.total_positions]")
	job.current_positions = job.current_positions + 1
	return TRUE
