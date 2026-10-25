
/**
 * When the station wins, any remaining living headrevs become Enemies of the State, a small solo antagonist.
 * They either have the choice to fuck off and do their own thing, or try and regain their honor with a hijack.
 */
/datum/antagonist/enemy_of_the_state
	name = "\improper 国家公敌"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	hijack_speed = 2 //not like they have much to do
	suicide_cry = "为了永恒的革命！！"

/datum/antagonist/enemy_of_the_state/forge_objectives()
	var/datum/objective/exile/exile_choice = new
	exile_choice.owner = owner
	exile_choice.objective_name = "抉择"
	objectives += exile_choice

	var/datum/objective/hijack/hijack_choice = new
	hijack_choice.owner = owner
	hijack_choice.objective_name = "抉择"
	objectives += hijack_choice

/datum/antagonist/enemy_of_the_state/on_gain()
	owner.add_memory(/datum/memory/revolution_rev_defeat)
	// LAZYADD(owner.special_statuses, "Exiled Head Revolutionary")
	forge_objectives()
	. = ..()

/datum/antagonist/enemy_of_the_state/greet()
	. = ..()
	to_chat(owner, span_userdanger("革命已经失败了。"))
	to_chat(owner, span_bolddanger("对纳米传讯而言，你是国家公敌。对辛迪加而言，你是个待处理的麻烦。"))
	to_chat(owner, "<b>是时候以流放者的身份度过余生了……或者，来上最后一场惊天动地的爆发。</b>")
	owner.announce_objectives()

/datum/antagonist/enemy_of_the_state/roundend_report()
	var/list/report = list()

	if(!owner)
		CRASH("Antagonist datum without owner")

	report += printplayer(owner)

	//needs to complete only one objective, not all

	var/option_chosen = FALSE
	var/badass = FALSE
	if(objectives.len)
		report += printobjectives(objectives)
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				option_chosen = TRUE
				if(istype(objective, /datum/objective/hijack))
					badass = TRUE
				break

	if(objectives.len == 0 || option_chosen)
		if(badass)
			report += "<span class='greentext big'>[name] 大胜</span>"
			report += "<B>[name] 选择了硬核选项，并劫持了穿梭机！</B>"
		else
			report += "<span class='greentext big'>[name] 小胜</span>"
			report += "<B>[name] 作为流放者活了下来！</B>"
	else
		report += "<span class='redtext big'>[name] 失败了！</span>"

	return report.Join("<br>")
