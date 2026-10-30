//Both ERT and DS are handled by the same datums since they mostly differ in equipment in objective.
/datum/team/ert
	name = "紧急响应小队"
	var/datum/objective/mission //main mission

/datum/antagonist/ert
	name = "紧急响应官"
	can_elimination_hijack = ELIMINATION_PREVENT
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	antag_moodlet = /datum/mood_event/focused
	antagpanel_category = ANTAG_GROUP_ERT
	suicide_cry = "为了纳米传讯！！"
	// Not 'true' antags, this disables certain interactions that assume the owner is a baddie
	antag_flags = ANTAG_FAKE|ANTAG_SKIP_GLOBAL_LIST
	desensitized_modifier = DESENSITIZED_THRESHOLD * 0.5
	var/datum/team/ert/ert_team
	var/leader = FALSE
	var/datum/outfit/outfit = /datum/outfit/centcom/ert/security
	var/datum/outfit/plasmaman_outfit = /datum/outfit/plasmaman/centcom_official
	var/role = "安保官"
	var/list/name_source
	var/random_names = TRUE
	var/rip_and_tear = FALSE
	var/equip_ert = TRUE
	var/forge_objectives_for_ert = TRUE
	/// Typepath indicating the kind of job datum this ert member will have.
	var/ert_job_path = /datum/job/ert


/datum/antagonist/ert/on_gain()
	if(random_names)
		update_name()
	else owner.current.fully_replace_character_name(owner.current.real_name,"[role] [owner.current.client?.prefs?.read_preference(/datum/preference/name/emergency)]") //BUBBER EDIT ADDITION: ERT NAMES
	if(forge_objectives_for_ert)
		forge_objectives()
	if(equip_ert)
		equipERT()
	owner?.current.add_faction(FACTION_ERT) // SKYRAT EDIT ADDITION
	. = ..()

/datum/antagonist/ert/get_team()
	return ert_team

/datum/antagonist/ert/New()
	. = ..()
	name_source = GLOB.last_names

/datum/antagonist/ert/proc/update_name()
	owner.current.fully_replace_character_name(owner.current.real_name,"[role] [pick(name_source)]")

/datum/antagonist/ert/official
	name = "中央指挥部官员"
	show_name_in_check_antagonists = TRUE
	var/datum/objective/mission
	role = "检查员"
	random_names = FALSE
	outfit = /datum/outfit/centcom/centcom_official
	ert_job_path = /datum/job/ert/official

/datum/antagonist/ert/official/greet()
	. = ..()
	if (ert_team)
		to_chat(owner, "<span class='warningplain'>中央指挥部正在派你前往[station_name()]，任务为：[ert_team.mission.explanation_text]</span>")
	else
		to_chat(owner, "<span class='warningplain'>中央指挥部正在派你前往[station_name()]，任务为：[mission.explanation_text]</span>")

/datum/antagonist/ert/official/forge_objectives()
	if (ert_team)
		return ..()
	if(mission)
		return
	var/datum/objective/missionobj = new ()
	missionobj.owner = owner
	missionobj.explanation_text = "对[station_name()]及其舰长进行例行绩效审查。"
	missionobj.completed = TRUE
	mission = missionobj
	objectives |= mission

/datum/antagonist/ert/security // kinda handled by the base template but here for completion
	ert_job_path = /datum/job/ert/officer

/datum/antagonist/ert/security/red
	outfit = /datum/outfit/centcom/ert/security/alert

/datum/antagonist/ert/engineer
	role = "工程师"
	outfit = /datum/outfit/centcom/ert/engineer
	ert_job_path = /datum/job/ert/engineer

/datum/antagonist/ert/engineer/red
	outfit = /datum/outfit/centcom/ert/engineer/alert

/datum/antagonist/ert/medic
	role = "医疗官"
	outfit = /datum/outfit/centcom/ert/medic
	ert_job_path = /datum/job/ert/medical_doctor

/datum/antagonist/ert/medic/red
	outfit = /datum/outfit/centcom/ert/medic/alert

/datum/antagonist/ert/commander
	role = "指挥官"
	outfit = /datum/outfit/centcom/ert/commander
	plasmaman_outfit = /datum/outfit/plasmaman/centcom_commander
	ert_job_path = /datum/job/ert/commander

/datum/antagonist/ert/commander/red
	outfit = /datum/outfit/centcom/ert/commander/alert

/datum/antagonist/ert/janitor
	role = "清洁工"
	outfit = /datum/outfit/centcom/ert/janitor
	ert_job_path = /datum/job/ert/janitor

/datum/antagonist/ert/janitor/heavy
	role = "重装清洁工"
	outfit = /datum/outfit/centcom/ert/janitor/heavy

/datum/antagonist/ert/deathsquad
	name = "死亡小队队员"
	outfit = /datum/outfit/centcom/death_commando
	plasmaman_outfit = /datum/outfit/plasmaman/centcom_commander
	role = "队员"
	rip_and_tear = TRUE
	ert_job_path = /datum/job/ert/deatsquad

/datum/antagonist/ert/deathsquad/New()
	. = ..()
	name_source = GLOB.commando_names

/datum/antagonist/ert/deathsquad/leader
	name = "死亡小队军官"
	outfit = /datum/outfit/centcom/death_commando/officer
	role = "军官"

/datum/antagonist/ert/medic/inquisitor
	outfit = /datum/outfit/centcom/ert/medic/inquisitor

/datum/antagonist/ert/medic/inquisitor/on_gain()
	. = ..()
	owner.set_holy_role(HOLY_ROLE_PRIEST)

/datum/antagonist/ert/security/inquisitor
	outfit = /datum/outfit/centcom/ert/security/inquisitor

/datum/antagonist/ert/security/inquisitor/on_gain()
	. = ..()
	owner.set_holy_role(HOLY_ROLE_PRIEST)

/datum/antagonist/ert/chaplain
	role = "牧师"
	outfit = /datum/outfit/centcom/ert/chaplain
	ert_job_path = /datum/job/ert/chaplain

/datum/antagonist/ert/chaplain/inquisitor
	outfit = /datum/outfit/centcom/ert/chaplain/inquisitor

/datum/antagonist/ert/chaplain/on_gain()
	. = ..()
	owner.set_holy_role(HOLY_ROLE_PRIEST)

/datum/antagonist/ert/commander/inquisitor
	outfit = /datum/outfit/centcom/ert/commander/inquisitor

/datum/antagonist/ert/commander/inquisitor/on_gain()
	. = ..()
	owner.set_holy_role(HOLY_ROLE_PRIEST)

/datum/antagonist/ert/intern
	name = "中央指挥部实习生"
	outfit = /datum/outfit/centcom/centcom_intern
	plasmaman_outfit = /datum/outfit/plasmaman/centcom_intern
	random_names = FALSE
	role = "实习生"
	suicide_cry = "为了我的实习！！"
	ert_job_path = /datum/job/ert/intern

/datum/antagonist/ert/intern/leader
	name = "中央指挥部实习生主管"
	outfit = /datum/outfit/centcom/centcom_intern/leader
	random_names = FALSE
	role = "实习生主管"
	ert_job_path = /datum/job/ert/intern/leader

/datum/antagonist/ert/intern/unarmed
	outfit = /datum/outfit/centcom/centcom_intern/unarmed

/datum/antagonist/ert/intern/leader/unarmed
	outfit = /datum/outfit/centcom/centcom_intern/leader/unarmed
	ert_job_path = /datum/antagonist/ert/intern/leader::ert_job_path

/datum/antagonist/ert/clown
	role = "小丑"
	outfit = /datum/outfit/centcom/ert/clown
	plasmaman_outfit = /datum/outfit/plasmaman/party_comedian
	ert_job_path = /datum/job/ert/clown

/datum/antagonist/ert/clown/New()
	. = ..()
	name_source = GLOB.clown_names

/datum/antagonist/ert/janitor/party
	role = "派对清洁服务"
	outfit = /datum/outfit/centcom/ert/janitor/party
	plasmaman_outfit = /datum/outfit/plasmaman/party_janitor

/datum/antagonist/ert/security/party
	role = "派对保镖"
	outfit = /datum/outfit/centcom/ert/security/party
	plasmaman_outfit = /datum/outfit/plasmaman/party_bouncer

/datum/antagonist/ert/engineer/party
	role = "派对建造师"
	outfit = /datum/outfit/centcom/ert/engineer/party
	plasmaman_outfit = /datum/outfit/plasmaman/party_constructor

/datum/antagonist/ert/clown/party
	role = "派对喜剧演员"
	outfit = /datum/outfit/centcom/ert/clown/party

/datum/antagonist/ert/commander/party
	role = "派对协调员"
	outfit = /datum/outfit/centcom/ert/commander/party

/datum/antagonist/ert/create_team(datum/team/ert/new_team)
	if(istype(new_team))
		ert_team = new_team

/datum/antagonist/ert/bounty_armor
	role = "重甲赏金猎人"
	outfit = /datum/outfit/bountyarmor/ert

/datum/antagonist/ert/bounty_hook
	role = "钩枪赏金猎人"
	outfit = /datum/outfit/bountyhook/ert

/datum/antagonist/ert/bounty_synth
	role = "合成人赏金猎人"
	outfit = /datum/outfit/bountysynth/ert

/datum/antagonist/ert/forge_objectives()
	if(ert_team)
		objectives |= ert_team.objectives

/datum/antagonist/ert/proc/equipERT()
	var/mob/living/carbon/human/H = owner.current
	if(!istype(H))
		return

	if(isplasmaman(H))
		H.dna.species.outfit_important_for_life = plasmaman_outfit

	H.dna.species.give_important_for_life(H)
	H.equipOutfit(outfit)

	if(isplasmaman(H))
		var/obj/item/mod/control/our_modsuit = locate() in H.get_equipped_items()
		if(our_modsuit)
			our_modsuit.install(new /obj/item/mod/module/plasma_stabilizer)

/datum/antagonist/ert/greet()
	if(!ert_team)
		return

	to_chat(owner, "<span class='warningplain'><B><font size=3 color=red>你是[name]。</font></B></span>")

	var/missiondesc = "你的小队受纳米传讯安保部派遣，前往[station_name()]执行任务。"
	if(leader) //If Squad Leader
		missiondesc += " 带领你的小队，确保任务圆满完成。队伍准备就绪后登船。"
	else
		missiondesc += " 服从小队队长下达的命令。"
	if(!rip_and_tear)
		missiondesc += " 尽可能避免平民伤亡。"

	missiondesc += "<span class='warningplain'><BR><B>你的任务</B>：[ert_team.mission.explanation_text]</span>"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/marine
	name = "陆战队指挥官"
	outfit = /datum/outfit/centcom/ert/marine
	ert_job_path = /datum/antagonist/ert/commander::ert_job_path
	role = "指挥官"

/datum/antagonist/ert/marine/security
	name = "陆战队重装兵"
	outfit = /datum/outfit/centcom/ert/marine/security
	ert_job_path = /datum/antagonist/ert/security::ert_job_path
	role = "队员"

/datum/antagonist/ert/marine/engineer
	name = "陆战队工程师"
	outfit = /datum/outfit/centcom/ert/marine/engineer
	role = "工程师"
	ert_job_path = /datum/antagonist/ert/engineer::ert_job_path

/datum/antagonist/ert/marine/medic
	name = "陆战队医疗兵"
	outfit = /datum/outfit/centcom/ert/marine/medic
	role = "医疗官"
	ert_job_path = /datum/antagonist/ert/medic::ert_job_path

/datum/antagonist/ert/militia
	name = "边疆民兵"
	outfit = /datum/outfit/centcom/militia
	role = "志愿者"

/datum/antagonist/ert/militia/general
	name = "边疆民兵将军"
	outfit = /datum/outfit/centcom/militia/general
	role = "将军"

/datum/antagonist/ert/medical_commander
	role = "急救主管"
	outfit = /datum/outfit/centcom/ert/medical_commander
	plasmaman_outfit = /datum/outfit/plasmaman/medical_commander
	ert_job_path = /datum/antagonist/ert/medic::ert_job_path

/datum/antagonist/ert/medical_technician
	role = "急救医疗技术员"
	outfit = /datum/outfit/centcom/ert/medical_technician
	plasmaman_outfit = /datum/outfit/plasmaman/medical_technician
	ert_job_path = /datum/antagonist/ert/medic::ert_job_path
