/datum/objective/revenant

/datum/objective/revenant/New()
	target_amount = rand(350, 600)
	explanation_text = "从人类身上吸取 [target_amount] 点精华。"
	return ..()

/datum/objective/revenant/check_completion()
	if(!isrevenant(owner.current))
		return FALSE
	var/mob/living/basic/revenant/owner_mob = owner.current
	if(QDELETED(owner_mob) || owner_mob.stat == DEAD)
		return FALSE
	var/essence_stolen = owner_mob.essence_accumulated
	return essence_stolen >= target_amount

/datum/objective/revenant_fluff

/datum/objective/revenant_fluff/New()
	var/list/explanation_texts = list(
		"在关键时刻协助并加剧既有的威胁。",
		"在不被杀死的前提下，尽可能地制造混乱与怒气。",
		"尽量损坏空间站设施，让更多东西锈蚀报废。",
		"使尽可能多的机器失效并发生故障。",
		"确保所有神圣武器都无法使用。",
		"聆听并遵从死者的请求，前提是执行起来不会太麻烦或自取灭亡。",
		"冒充神明，或让众人把你当作神明来膜拜。",
		"让船员们尽可能地痛苦。",
		"尽可能阻止能量武器的使用。",
	)
	if(SSjob.assigned_captain)
		explanation_texts += "让舰长尽可能地痛苦。"
	var/datum/job/clown/clown_job = SSjob.get_job(JOB_CLOWN)
	if(clown_job.current_positions)
		explanation_texts += "让小丑尽可能地痛苦。"
	explanation_text = pick(explanation_texts)
	return ..()

/datum/objective/revenant_fluff/check_completion()
	return TRUE
