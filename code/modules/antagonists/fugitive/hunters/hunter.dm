//The hunters!!
/datum/antagonist/fugitive_hunter
	name = "逃犯猎人"
	roundend_category = "Fugitive"
	silent = TRUE //greet called by the spawn
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	antagpanel_category = ANTAG_GROUP_HUNTERS
	antag_hud_name = "fugitive_hunter"
	suicide_cry = "为了荣耀！！"
	antag_flags = ANTAG_SKIP_GLOBAL_LIST
	var/datum/team/fugitive_hunters/hunter_team
	var/backstory = "error"

/datum/antagonist/fugitive_hunter/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/fugitive_hunter/forge_objectives() //this isn't an actual objective because it's about round end rosters
	var/datum/objective/capture = new /datum/objective
	capture.owner = owner
	capture.explanation_text = "捕获空间站上的逃犯，并将他们放入你飞船上的蓝空间捕获机中。"
	objectives += capture

/datum/antagonist/fugitive_hunter/greet()
	switch(backstory)
		if(HUNTER_PACK_COPS)
			to_chat(owner, span_bolddanger("正义已至。我是太空警察的一员！"))
			to_chat(owner, "<B>罪犯应该就在空间站上，我们植入了特殊 HUD 来识别他们。</B>")
			to_chat(owner, "<B>由于我们几乎已经完全失去了对这些该死的无法无天巨型企业的控制权，他们的安保是否会配合我们还是个谜。</B>")
		if(HUNTER_PACK_RUSSIAN)
			to_chat(owner, span_danger("唉，布拉季。我是个太空俄罗斯走私犯！我们正在飞行途中，货物就被传送光束从船上劫走了！"))
			to_chat(owner, span_danger("一个穿绿色制服的人呼叫了我们，承诺只要我们帮个忙，就把货物安全归还："))
			to_chat(owner, span_danger("当地有一座空间站藏匿着他追捕的逃犯，他想要他们回去，死活不论。"))
			to_chat(owner, span_danger("没有货物我们就无法维持生计，所以必须照他说的做，抓住他们。"))
		if(HUNTER_PACK_BOUNTY)
			to_chat(owner, span_danger("该上班了。我是赏金猎人！我们很快就要抵达目标的藏身处了。"))
			to_chat(owner, span_danger("简报里说我们的目的地是一座研究站。对目标来说，想在那里潜伏可不太寻常。"))
			to_chat(owner, span_danger("客户许诺了大笔钞票，我们也打算把这单干成。但愿这钱挣得轻松……"))
		if(HUNTER_PACK_PSYKER)
			to_chat(owner, span_danger("晚上好，我们是灵能猎——不，是灵能希卡里！"))
			to_chat(owner, span_danger("一个脑虫通过全息板联系我们，提出了一个我们绝对无法拒绝的条件。我们替他们绑架几个蠢货，作为交换，我们得到一辈子的血肉供应。"))
			to_chat(owner, span_danger("最近我们的血肉储备越来越少——我们怎么能拒绝？狂欢必须继续！"))
		if(HUNTER_PACK_MI13)
			to_chat(owner, span_danger("特工们，我们在纳米传讯控制的星域内侦测到一名通缉逃犯。"))
			to_chat(owner, span_danger("你们的任务很简单。潜入设施并带出目标，死活不论。"))
			to_chat(owner, span_danger("这是一次深入敌方领土的隐秘渗透任务。保持警惕，尽可能避免被抓。"))

	to_chat(owner, span_bolddanger("你并非可以随意杀人的反派，但你可以采取任何手段确保抓获逃犯，即使这意味着要横扫整个空间站。"))
	owner.announce_objectives()

/datum/antagonist/fugitive_hunter/create_team(datum/team/fugitive_hunters/new_team)
	if(!new_team)
		for(var/datum/antagonist/fugitive_hunter/H in GLOB.antagonists)
			if(!H.owner)
				continue
			if(H.hunter_team)
				hunter_team = H.hunter_team
				return
		hunter_team = new /datum/team/fugitive_hunters
		hunter_team.backstory = backstory
		hunter_team.update_objectives()
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	hunter_team = new_team

/datum/antagonist/fugitive_hunter/get_team()
	return hunter_team

/datum/antagonist/fugitive_hunter/apply_innate_effects(mob/living/mob_override)
	add_team_hud(mob_override || owner.current)
	if(backstory == HUNTER_PACK_RUSSIAN)
		var/mob/living/owner_mob = mob_override || owner.current
		//bubber edit; spinwarder removed
		owner_mob.grant_language(/datum/language/spinwarder, source = LANGUAGE_BOUNTYHUNTER)
		owner_mob.set_active_language(/datum/language/spinwarder)
		//edit end

/datum/antagonist/fugitive_hunter/remove_innate_effects(mob/living/mob_override)
	var/mob/living/owner_mob = mob_override || owner.current
	// BUBBER EDIT CHANGE BEGIN: spinwarder removed
	owner_mob.remove_language(/datum/language/spinwarder, source = LANGUAGE_BOUNTYHUNTER)
	// BUBBER EDIT CHANGE END

/datum/team/fugitive_hunters
	var/backstory = "error"

/datum/team/fugitive_hunters/proc/update_objectives(initial = FALSE)
	objectives = list()
	var/datum/objective/O = new()
	O.team = src
	objectives += O

/datum/team/fugitive_hunters/proc/assemble_fugitive_results()
	var/list/fugitives_counted = list()
	var/list/fugitives_dead = list()
	var/list/fugitives_captured = list()
	for(var/datum/antagonist/fugitive/A in GLOB.antagonists)
		if(!A.owner)
			stack_trace("Antagonist datum without owner in GLOB.antagonists: [A]")
			continue
		fugitives_counted += A
		if(A.owner.current.stat == DEAD)
			fugitives_dead += A
		if(A.is_captured)
			fugitives_captured += A
	. = list(fugitives_counted, fugitives_dead, fugitives_captured) //okay, check out how cool this is.

/datum/team/fugitive_hunters/proc/all_hunters_dead()
	var/dead_boys = 0
	for(var/I in members)
		var/datum/mind/hunter_mind = I
		if(!(ishuman(hunter_mind.current) || (hunter_mind.current.stat == DEAD)))
			dead_boys++
	return dead_boys >= members.len

/datum/team/fugitive_hunters/proc/get_result()
	var/list/fugitive_results = assemble_fugitive_results()
	var/list/fugitives_counted = fugitive_results[1]
	var/list/fugitives_dead = fugitive_results[2]
	var/list/fugitives_captured = fugitive_results[3]
	var/hunters_dead = all_hunters_dead()
	//this gets a little confusing so follow the comments if it helps
	if(!fugitives_counted.len)
		return
	if(fugitives_captured.len)//any captured
		if(fugitives_captured.len == fugitives_counted.len)//if the hunters captured all the fugitives, there's a couple special wins
			if(!fugitives_dead)//specifically all of the fugitives alive
				return FUGITIVE_RESULT_BADASS_HUNTER
			else if(hunters_dead)//specifically all of the hunters died (while capturing all the fugitives)
				return FUGITIVE_RESULT_POSTMORTEM_HUNTER
			else//no special conditional wins, so just the normal major victory
				return FUGITIVE_RESULT_MAJOR_HUNTER
		else if(!hunters_dead)//so some amount captured, and the hunters survived.
			return FUGITIVE_RESULT_HUNTER_VICTORY
		else//so some amount captured, but NO survivors.
			return FUGITIVE_RESULT_MINOR_HUNTER
	else//from here on out, hunters lost because they did not capture any fugitive dead or alive. there are different levels of getting beat though:
		if(!fugitives_dead)//all fugitives survived
			return FUGITIVE_RESULT_MAJOR_FUGITIVE
		else if(fugitives_dead < fugitives_counted)//at least ANY fugitive lived
			return FUGITIVE_RESULT_FUGITIVE_VICTORY
		else if(!hunters_dead)//all fugitives died, but none were taken in by the hunters. minor win
			return FUGITIVE_RESULT_MINOR_FUGITIVE
		else//all fugitives died, all hunters died, nobody brought back. seems weird to not give fugitives a victory if they managed to kill the hunters but literally no progress to either goal should lead to a nobody wins situation
			return FUGITIVE_RESULT_STALEMATE

/datum/team/fugitive_hunters/roundend_report() //shows the number of fugitives, but not if they won in case there is no security
	if(!members.len)
		return

	var/list/result = list()

	result += "<div class='panel redborder'>……并且有 <B>[members.len]</B> 名[backstory]试图追猎他们！"

	for(var/datum/mind/M in members)
		result += "<b>[printplayer(M)]</b>"

	switch(get_result())
		if(FUGITIVE_RESULT_BADASS_HUNTER)//use defines
			result += "<span class='greentext big'>彪悍的[capitalize(backstory)]胜利！</span>"
			result += "<B>这些[backstory]成功抓获了所有逃犯，而且全部活捉！</B>"
		if(FUGITIVE_RESULT_POSTMORTEM_HUNTER)
			result += "<span class='greentext big'>[capitalize(backstory)]的死后胜利！</span>"
			result += "<B>这些[backstory]成功抓获了所有逃犯，但他们全部阵亡了！真瘆人！</B>"
		if(FUGITIVE_RESULT_MAJOR_HUNTER)
			result += "<span class='greentext big'>[capitalize(backstory)]重大胜利</span>"
			result += "<B>这些[backstory]成功抓获了所有逃犯，死活不论。</B>"
		if(FUGITIVE_RESULT_HUNTER_VICTORY)
			result += "<span class='greentext big'>[capitalize(backstory)]胜利</span>"
			result += "<B>这些[backstory]成功抓获了一名逃犯，死活不论。</B>"
		if(FUGITIVE_RESULT_MINOR_HUNTER)
			result += "<span class='greentext big'>[capitalize(backstory)]小胜</span>"
			result += "<B>所有[backstory]都阵亡了，但成功抓获了一名逃犯，死活不论。</B>"
		if(FUGITIVE_RESULT_STALEMATE)
			result += "<span class='neutraltext big'>血腥僵局</span>"
			result += "<B>所有人都死了，也没有任何逃犯被带回！</B>"
		if(FUGITIVE_RESULT_MINOR_FUGITIVE)
			result += "<span class='redtext big'>逃犯小胜</span>"
			result += "<B>所有逃犯都死了，但无一人被带回！</B>"
		if(FUGITIVE_RESULT_FUGITIVE_VICTORY)
			result += "<span class='redtext big'>逃犯胜利</span>"
			result += "<B>一名逃犯幸存，而[backstory]们没有带回任何尸体。</B>"
		if(FUGITIVE_RESULT_MAJOR_FUGITIVE)
			result += "<span class='redtext big'>逃犯重大胜利</span>"
			result += "<B>所有逃犯都幸存下来，并躲过了抓捕！</B>"
		else //get_result returned null- either bugged or no fugitives showed
			result += "<span class='neutraltext big'>恶作剧电话！</span>"
			result += "<B>[capitalize(backstory)]被叫来了，可是根本没有什么逃犯……？</B>"

	result += "</div>"

	return result.Join("<br>")
