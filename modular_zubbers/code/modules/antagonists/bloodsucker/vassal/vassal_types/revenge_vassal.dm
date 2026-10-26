/**
 * Revenge Ghoul
 *
 * Has the goal to 'get revenge' when their Master dies.
 */
/datum/antagonist/ghoul/revenge
	name = "\improper 复仇血仆"
	roundend_category = "abandoned Ghouls"
	show_in_roundend = FALSE
	show_in_antagpanel = FALSE
	antag_hud_name = "ghoul4"
	special_type = REVENGE_GHOUL
	ghoul_description = "复仇血仆不会因吸血鬼主人的终极死亡而解除转化，\
		而会继承你的所有能力，并以替你报仇为目标。\
		主人离去后，他们还会维系其他血仆，避免这些血仆失去归属。"

	///all ex-ghouls brought back into the fold.
	var/list/datum/antagonist/ex_ghoul/ex_ghouls = list()

/datum/antagonist/ghoul/revenge/roundend_report()
	var/list/report = list()
	report += printplayer(owner)
	if(objectives.len)
		report += printobjectives(objectives)

	// Now list their ghouls
	if(ex_ghouls.len)
		report += "<span class='header'>重新归顺的血仆有……</span>"
		for(var/datum/antagonist/ex_ghoul/all_ghouls as anything in ex_ghouls)
			if(!all_ghouls.owner)
				continue
			report += "[chinese_job_display(all_ghouls.owner.assigned_role.title)] <b>[all_ghouls.owner.name]</b>"

	return report.Join("<br>")

/datum/antagonist/ghoul/revenge/on_gain()
	. = ..()
	RegisterSignal(master, COMSIG_BLOODSUCKER_FINAL_DEATH, PROC_REF(on_master_death))

/datum/antagonist/ghoul/revenge/on_removal()
	UnregisterSignal(master, COMSIG_BLOODSUCKER_FINAL_DEATH)
	return ..()

/datum/antagonist/ghoul/revenge/proc/on_master_death(datum/antagonist/bloodsucker/bloodsuckerdatum, mob/living/carbon/master)
	SIGNAL_HANDLER

	show_in_roundend = TRUE
	for(var/datum/objective/all_objectives as anything in objectives)
		objectives -= all_objectives
	BuyPower(/datum/action/cooldown/bloodsucker/ghoul_blood)
	for(var/datum/action/cooldown/bloodsucker/master_powers as anything in bloodsuckerdatum.powers)
		if(master_powers.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		master_powers.Grant(owner.current)
		owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/ghoul_edition)

	var/datum/objective/survive/new_objective = new
	new_objective.name = "为主人复仇"
	new_objective.explanation_text = "杀死谋害主人的凶手，召回主人的前血仆，并延续主人的事业，为主人的终极死亡复仇。"
	new_objective.owner = owner
	objectives += new_objective

	antag_panel_title = "你是一名肩负为亡故主人复仇使命的血仆！"
	antag_panel_description = "你继承了主人原有的能力，\
		并获得了一项全新能力。你必须存活下去，\
		捍卫已故主人的尊严，并运用你的新能力\
		让主人的旧日血仆重新归顺。"
	update_static_data_for_all_viewers()
