/datum/objective/abductee
	completed = 1

/datum/objective/abductee/random

/datum/objective/abductee/random/New()
	explanation_text = pick(world.file2list("strings/abductee_objectives.txt"))

/datum/objective/abductee/steal
	explanation_text = "偷走所有的"

/datum/objective/abductee/steal/New()
	var/target = pick(list("宠物","灯具","猴子","水果","鞋子","肥皂块", "武器", "电脑", "器官"))
	explanation_text+="[target]。"

/datum/objective/abductee/paint
	explanation_text = "空间站丑陋至极。你必须把它全部涂成"

/datum/objective/abductee/paint/New()
	var/color = pick(list("红色", "蓝色", "绿色", "黄色", "橙色", "紫色", "黑色", "彩虹色", "血色"))
	explanation_text+= "[color]！"

/datum/objective/abductee/speech
	explanation_text = "你的大脑已经坏掉了……你交流时只能使用"

/datum/objective/abductee/speech/New()
	var/style = pick(list("哑剧", "韵文", "俳句", "冗长的隐喻", "谜语", "极端字面化的措辞", "音效", "军事术语", "三词短句"))
	explanation_text+= "[style]。"

/datum/objective/abductee/capture
	explanation_text = "绑架"

/datum/objective/abductee/capture/New()
	var/list/jobs = SSjob.joinable_occupations.Copy()
	for(var/datum/job/job as anything in jobs)
		if(job.current_positions < 1)
			jobs -= job
	if(length(jobs) > 0)
		var/datum/job/target = pick(jobs)
		explanation_text += "一名[target.title]。"
	else
		explanation_text += "某个人。"

/datum/objective/abductee/calling/New()
	var/mob/dead/D = pick(GLOB.dead_mob_list)
	if(D)
		explanation_text = "你知道[D]已经逝去。举行一场降神会，从灵魂领域召回对方。"

/datum/objective/abductee/forbiddennumber

/datum/objective/abductee/forbiddennumber/New()
	var/number = rand(2,10)
	explanation_text = "无视任何以[number]为一组出现的东西，它们并不存在。"
