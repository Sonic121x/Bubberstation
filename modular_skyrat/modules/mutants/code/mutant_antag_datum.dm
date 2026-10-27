/datum/antagonist/mutant
	name = "\improper 突变憎恶"
	pref_flag = ROLE_MUTANT
	roundend_category = "mutants"
	antagpanel_category = "Mutant"
	show_in_antagpanel = TRUE
	antag_hud_name = "mutant"
	hud_icon = 'modular_skyrat/modules/mutants/icons/antag_hud.dmi'
	antag_memory = "你是一只突变憎恶。你渴望血肉，心智支离破碎，已不记得自己是谁。\
	你只知道自己想要杀戮。\
	你仍保留着一定的思考能力。\
	友好对待或帮助船员将受到处罚。\
	攻击僵尸同伴将受到处罚。\
	妨碍僵尸同伴将受到处罚。"

/datum/antagonist/mutant/on_gain()
	. = ..()
	var/component = owner.current?.GetComponent(/datum/component/mutant_infection)
	if(!component)
		owner.current?.AddComponent(/datum/component/mutant_infection)
	to_chat(owner, span_boldannounce(antag_memory))
