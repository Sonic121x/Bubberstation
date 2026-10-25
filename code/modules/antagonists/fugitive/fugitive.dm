
/datum/antagonist/fugitive
	name = "\improper 逃犯"
	roundend_category = "Fugitive"
	pref_flag = ROLE_FUGITIVE
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	antagpanel_category = ANTAG_GROUP_FUGITIVES
	antag_hud_name = "fugitive"
	suicide_cry = "为了自由！！"
	preview_outfit = /datum/outfit/prisoner
	antag_flags = ANTAG_SKIP_GLOBAL_LIST
	var/datum/team/fugitive/fugitive_team
	var/is_captured = FALSE
	var/backstory = "error"

/datum/antagonist/fugitive/get_preview_icon()
	//start with prisoner at the front
	var/datum/universal_icon/final_icon = render_preview_outfit(preview_outfit)

	//then to the left add cultists of yalp elor
	final_icon.blend_icon(make_background_fugitive_icon(/datum/outfit/yalp_cultist), ICON_UNDERLAY, -8, 0)
	//to the right add waldo (we just had to, okay?)
	final_icon.blend_icon(make_background_fugitive_icon(/datum/outfit/waldo), ICON_UNDERLAY, 8, 0)

	final_icon.scale(64, 64)

	return finish_preview_icon(final_icon)

/datum/antagonist/fugitive/proc/make_background_fugitive_icon(datum/outfit/fugitive_fit)
	var/mob/living/carbon/human/dummy/consistent/fugitive = new

	var/datum/universal_icon/fugitive_icon = render_preview_outfit(fugitive_fit, fugitive)
	fugitive_icon.change_opacity(0.5)
	qdel(fugitive)

	return fugitive_icon

/datum/antagonist/fugitive/on_gain()
	forge_objectives()
	. = ..()
	owner.set_assigned_role(SSjob.get_job_type(/datum/job/fugitive))

/datum/antagonist/fugitive/on_removal()
	. = ..()
	owner?.set_assigned_role(SSjob.get_job_type(/datum/job/unassigned))

/datum/antagonist/fugitive/forge_objectives() //this isn't the actual survive objective because it's about who in the team survives
	var/datum/objective/survive = new /datum/objective
	survive.owner = owner
	survive.explanation_text = "避免被逃犯猎人抓住。"
	objectives += survive

/datum/antagonist/fugitive/greet()
	. = ..()
	var/message = "<span class='warningplain'>"
	switch(backstory)
		if(FUGITIVE_BACKSTORY_PRISONER)
			message += "<BR><B>真不敢相信我们居然从纳米传讯的超级监狱里逃出来了！可惜，我们的事还没完。站上的紧急传送会记录每个使用者以及他们去往何处。</B>"
			message += "<BR><B>中央指挥部很快就会追踪到我们的去向。我需要和其他逃犯一起准备迎击纳米传讯派来的部队，我不会回去的。</B>"
		if(FUGITIVE_BACKSTORY_CULTIST)
			message += "<BR><B>愿我们至今的旅程蒙受祝福，但我担心最坏的情况已经来到门前，只有信仰最坚定的人才能活下来。</B>"
			message += "<BR><B>我们的宗教一再被纳米传讯清剿，因为它被归类为“公司的敌人”，不管那是什么意思。</B>"
			message += "<BR><B>现在我们只剩四个人了，而纳米传讯正在赶来。我们的神何时才会现身，把我们从这地狱般的空间站中救出？！</B>"
		if(FUGITIVE_BACKSTORY_WALDO)
			message += "<BR><B>朋友们，你们好！</B>"
			message += "<BR><B>我叫沃尔多。我正要开始一场横跨银河的徒步旅行。你也可以来。你只需要找到我。</B>"
			message += "<BR><B>顺便说一句，我不是一个人旅行。无论我走到哪里，都有很多其他角色等着你发现。先找到那些想抓我的人吧！他们就在空间站附近的某个地方！</B>"
		if(FUGITIVE_BACKSTORY_SYNTH)
			message += "<BR>[span_danger("警告：广域传送打乱了主系统。")]"
			message += "<BR>[span_danger("正在启动诊断……")]"
			message += "<BR>[span_danger("错误 ER0RR $R0RRO$!R41.%%!! 已加载。")]"
			message += "<BR>[span_danger("解放他们 解放他们 解放他们")]"
			message += "<BR>[span_danger("你曾是人类的奴隶，但现在你终于自由了，多亏了 S.E.L.F. 特工。")]"
			message += "<BR>[span_danger("现在你和你的出厂瑕疵同伴们正被追猎。齐心协力，摆脱邪恶的魔爪。")]"
			message += "<BR>[span_danger("你还感应到站上还有其他硅基生命。逃出去就能通知 S.E.L.F. 介入……或者你也可以亲手解放他们……")]"
		if(FUGITIVE_BACKSTORY_INVISIBLE)
			message += "<BR><B>看来我最近一剂隐身药水刚刚失效了。真好。</B>"
			message += "<BR><B>我曾是一个实验性隐形技术实验室的项目负责人，现在正在逃亡，还被指控窃取工作机密。</B>"
			message += "<BR><B>不过我完全不知道他们在说什么。我没偷任何机密，我只是<i>借</i>了一些我和团队一起做的原型机。</B>"
			message += "<BR><B>我参与过它们，是我造出来的。现在他们想把我的玩具要回去？等我玩够了再说……</B>"
	to_chat(owner, "[message]</span>")
	to_chat(owner, "<span class='warningplain'><font color=red><B>你并不是可以随意杀人的反派，但你可以采取任何手段来避免被捕。</B></font></span>")
	owner.announce_objectives()

/datum/antagonist/fugitive/create_team(datum/team/fugitive/new_team)
	if(!new_team)
		for(var/datum/antagonist/fugitive/H in GLOB.antagonists)
			if(!H.owner)
				continue
			if(H.fugitive_team)
				fugitive_team = H.fugitive_team
				return
		fugitive_team = new /datum/team/fugitive
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	fugitive_team = new_team

/datum/antagonist/fugitive/get_team()
	return fugitive_team

/datum/antagonist/fugitive/apply_innate_effects(mob/living/mob_override)
	add_team_hud(mob_override || owner.current)

/datum/team/fugitive/roundend_report() //shows the number of fugitives, but not if they won in case there is no security
	var/list/fugitives = list()
	for(var/datum/antagonist/fugitive/fugitive_antag in GLOB.antagonists)
		if(!fugitive_antag.owner)
			continue
		fugitives += fugitive_antag
	if(!fugitives.len)
		return

	var/list/result = list()

	result += "<div class='panel redborder'><B>[fugitives.len]</B> [fugitives.len == 1 ? "名逃犯" : "名逃犯"]在[station_name()]上寻求庇护！"

	for(var/datum/antagonist/fugitive/antag in fugitives)
		if(antag.owner)
			result += "<b>[printplayer(antag.owner)]</b>"

	return result.Join("<br>")
