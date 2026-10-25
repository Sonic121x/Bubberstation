// All the procs that admins can use to view something like a global list in a cleaner manner than just View Variables are contained in this file.

/datum/admins/proc/list_bombers()
	if(!SSticker.HasRoundStarted())
		tgui_alert(usr, "游戏还没有开始！")
		return
	var/data = "<b>爆炸事件列表</b><hr>"
	for(var/entry in GLOB.bombers)
		data += "[entry]<br>"
	usr << browse(data, "window=bombers;size=800x500")

/datum/admins/proc/list_signalers()
	if(!SSticker.HasRoundStarted())
		tgui_alert(usr, "游戏还没有开始！")
		return
	var/data = "<b>显示最近 [length(GLOB.investigate_signaler)] 个信号器。</b><hr>"
	for(var/entry in GLOB.investigate_signaler)
		data += "[entry]<BR>"
	usr << browse(data, "window=lastsignalers;size=800x500")

/datum/admins/proc/list_law_changes()
	if(!SSticker.HasRoundStarted())
		tgui_alert(usr, "游戏还没有开始！")
		return
	var/data = "<b>显示最近 [length(GLOB.lawchanges)] 次法则变更。</b><hr>"
	for(var/entry in GLOB.lawchanges)
		data += "[entry]<BR>"

	var/datum/browser/browser = new(usr, "lawchanges", "法则变更", 800, 500)
	browser.set_content(data)
	browser.open()

/datum/admins/proc/list_dna()
	var/data = "<b>显示从血液中获取的 DNA。</b><hr>"
	data += "<table cellspacing=5 border=1><tr><th>姓名</th><th>DNA</th><th>血型</th></tr>"
	for(var/entry in GLOB.human_list)
		var/mob/living/carbon/human/subject = entry
		if(subject.ckey)
			data += "<tr><td>[subject]</td><td>[subject.dna.unique_enzymes]</td><td>[subject.get_bloodtype()?.name]</td></tr>"
	data += "</table>"

	var/datum/browser/browser = new(usr, "DNA", "DNA 日志", 440, 410)
	browser.set_content(data)
	browser.open()

/datum/admins/proc/list_fingerprints() //kid named fingerprints
	var/data = "<b>显示指纹。</b><hr>"
	data += "<table cellspacing=5 border=1><tr><th>姓名</th><th>指纹</th></tr>"
	for(var/entry in GLOB.human_list)
		var/mob/living/carbon/human/subject = entry
		if(subject.ckey)
			data += "<tr><td>[subject]</td><td>[md5(subject.dna.unique_identity)]</td></tr>"
	data += "</table>"

	var/datum/browser/browser = new(usr, "fingerprints", "指纹日志", 440, 410)
	browser.set_content(data)
	browser.open()

/datum/admins/proc/show_manifest()
	if(!SSticker.HasRoundStarted())
		tgui_alert(usr, "游戏还没有开始！")
		return
	GLOB.manifest.ui_interact(usr)

/datum/admins/proc/output_ai_laws()
	var/law_bound_entities = 0
	for(var/mob/living/silicon/subject as anything in GLOB.silicon_mobs)
		law_bound_entities++

		var/message = ""

		if(isAI(subject))
			message += "<b>AI [key_name(subject, usr)] 的法则：</b>"
		else if(iscyborg(subject))
			var/mob/living/silicon/robot/borg = subject
			message += "<b>半机械人 [key_name(subject, usr)] [borg.connected_ai?"（从属于：[key_name(borg.connected_ai)]）":"（独立）"]：法则：</b>"
		else if (ispAI(subject))
			message += "<b>个人 AI [key_name(subject, usr)] 的法则：</b>"
		else
			message += "<b>某种硅基单位 [key_name(subject, usr)] 的法则：</b>"

		message += "<br>"

		if (!subject.laws)
			message += "[key_name(subject, usr)] 的法则为空？？请联系程序员。"
		else
			message += jointext(subject.laws.get_law_list(include_zeroth = TRUE), "<br>")

		to_chat(usr, message, confidential = TRUE)

	if(!law_bound_entities)
		to_chat(usr, "<b>未找到受法则约束的实体</b>", confidential = TRUE)
