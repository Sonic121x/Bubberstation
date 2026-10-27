/datum/antagonist/slaughter
	name = "\improper 屠戮恶魔"
	roundend_category = "demons"
	show_name_in_check_antagonists = TRUE
	ui_name = "AntagInfoDemon"
	pref_flag = ROLE_SENTIENCE
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	antagpanel_category = ANTAG_GROUP_WIZARDS
	var/fluff = "你是愤怒恶魔，常被巫师拖入现实，去恐吓他们的敌人。"
	var/objective_verb = "杀死"
	var/datum/mind/summoner
	/// consume count for statistics
	var/consume_count = 0

/datum/antagonist/slaughter/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/slaughter/greet()
	. = ..()
	owner.announce_objectives()
	to_chat(owner, span_warning("你拥有一种强力的备用攻击，可将人向后拍飞，右键点击目标即可发动！"))

/datum/antagonist/slaughter/forge_objectives()
	if(summoner)
		var/datum/objective/assassinate/new_objective = new /datum/objective/assassinate
		new_objective.owner = owner
		new_objective.target = summoner
		new_objective.explanation_text = "[objective_verb][summoner.name]，那个召唤你的人。"
		objectives += new_objective
	var/datum/objective/new_objective2 = new /datum/objective
	new_objective2.owner = owner
	new_objective2.no_failure = TRUE
	new_objective2.explanation_text = "[objective_verb]所有人[summoner ? "，顺便也把其他人解决掉":""]。"
	objectives += new_objective2

/datum/antagonist/slaughter/ui_static_data(mob/user)
	var/list/data = list()
	data["fluff"] = fluff
	data["objectives"] = get_objectives()
	data["explain_attack"] = TRUE
	return data

/datum/antagonist/slaughter/roundend_report()
	var/list/report = list()

	if(!owner)
		CRASH("Antagonist datum without owner")

	report += printplayer(owner)

	if(objectives.len)
		report += printobjectives(objectives)

	if(consume_count > 0)
		report += span_greentext("[name]共吞噬了 [consume_count] 具尸体！")
	else
		report += span_redtext("[name]一个人都没吞噬！真丢脸！！")

	if(isnull(owner.current) || owner.current.stat == DEAD) //demons delete on death but if someone makes like a subtype that doesnt we also check for stat
		report += "<span class='redtext big'>[name]被击败了！</span>"
	else
		report += "<span class='greentext big'>[name]存活了下来！</span>"

	return report.Join("<br>")

/datum/antagonist/slaughter/laughter
	name = "欢笑恶魔"
	objective_verb = "拥抱并挠痒"
	fluff = "你是嫉妒恶魔，有时会被巫师拖入现实，以此肆意制造混乱。"
