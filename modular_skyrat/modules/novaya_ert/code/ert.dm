/datum/ert/nri
	roles = list(/datum/antagonist/ert/nri, /datum/antagonist/ert/nri/medic, /datum/antagonist/ert/nri/engineer)
	leader_role = /datum/antagonist/ert/nri/commander
	rename_team = "泛斯拉夫边境巡逻队"
	code = "Red"
	mission = "与空间站合作，保护联邦资产。"
	polldesc = "一支泛斯拉夫边境巡逻小队"
	teamsize = 4

/datum/antagonist/ert/nri
	name = "联邦边境巡逻队员"
	role = "列兵"
	outfit = /datum/outfit/centcom/ert/nri
	suicide_cry = "天佑女皇！！"

/datum/antagonist/ert/nri/on_gain()
	. = ..()
	equip_nri()

/datum/antagonist/ert/nri/proc/equip_nri()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/H = owner.current
	H.set_species(/datum/species/human)

	H.grant_language(/datum/language/spinwarder)
	H.grant_language(/datum/language/schechi)
	return TRUE

/datum/antagonist/ert/nri/greet()
	if(!ert_team)
		return

	to_chat(owner, span_boldwarning("<font size=3 color=yellow>你是[name]</font>"))

	var/missiondesc = "经泛斯拉夫联邦国防委员会批准，你的小队正响应[station_name()]的紧急情况。"
	if(leader) //If Squad Leader
		missiondesc += "<BR><B>带领你的小队确保完成任务。队伍准备好后登上穿梭机。</B>"

	missiondesc += "<BR><B><font size=3 color=red>你不是纳米传讯员工。你为泛斯拉夫联邦国防委员会工作。</font></B>"
	missiondesc += "<BR><B><font size=3 color=red>你不是死亡小队。你是为自身利益而来，协助空间站安保部和指挥部处理异形入侵或敌对活动。</font></B>"
	missiondesc += "<BR>你正在响应空间站要求联邦立即进行军事干预的紧急呼叫！\n"
	missiondesc += "<BR><B>你的任务</B>："
	missiondesc += "<BR> <B>1.</B> 尽量减少平民伤亡。"
	missiondesc += "<BR> <B>2.</B> 消除威胁。"
	missiondesc += "<BR> <B>3.</B> 稳定局势。"
	missiondesc += "<BR> <B>4.</B> 联系呼叫你们的人，协助解决问题。"
	missiondesc += "<BR> <B>5.</B> 保护、保障并维护[station_name()]上泛斯拉夫联邦、阿古尔卡尔王国及自由特沙利联盟公民的权利。地球政府公民的福祉由你自行斟酌。"
	missiondesc += "<BR> <B>6.</B> 尝试策反空间站船员，将空间站领土纳入泛斯拉夫联邦控制。"

	missiondesc += span_warning("<BR><B>你的任务</B>：[ert_team.mission.explanation_text]")
	to_chat(owner,missiondesc)

/datum/antagonist/ert/nri/commander
	role = "指挥官"
	outfit = /datum/outfit/centcom/ert/nri/commander

/datum/antagonist/ert/nri/medic
	role = "战地医护兵"
	outfit = /datum/outfit/centcom/ert/nri/medic

/datum/antagonist/ert/nri/engineer
	role = "战斗工兵"
	outfit = /datum/outfit/centcom/ert/nri/engineer

/datum/ert/nri/diplomacy
	roles = list(/datum/antagonist/ert/nri/diplomat/scientist, /datum/antagonist/ert/nri/diplomat/doctor)
	leader_role = /datum/antagonist/ert/nri/diplomat/major
	rename_team = "泛斯拉夫对外关系委员会"
	code = "Green"
	mission = "与空间站指挥部合作，例行评估泛斯拉夫联邦公民的福祉，以及科研部和医疗部的遗传学与病毒学研究。"
	polldesc = "泛斯拉夫外交使团"

/datum/antagonist/ert/nri/diplomat
	name = "联邦对外关系委员会外交官"
	role = "外交官"
	outfit = /datum/outfit/centcom/ert/nri // no shit for generic role that won't even appear bruh

/datum/antagonist/ert/nri/diplomat/major
	role = "少校"
	outfit = /datum/outfit/centcom/ert/nri/major

/datum/antagonist/ert/nri/diplomat/scientist
	role = "科研监察员"
	outfit = /datum/outfit/centcom/ert/nri/scientist

/datum/antagonist/ert/nri/diplomat/doctor
	role = "医疗监察员"
	outfit = /datum/outfit/centcom/ert/nri/doctor
