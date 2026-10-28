#define CREDIT_ROLL_SPEED 100
#define CREDIT_SPAWN_SPEED 20
#define CREDIT_ANIMATE_HEIGHT (14 * world.icon_size)
#define CREDIT_EASE_DURATION 22

#define JOINTEXT(X) jointext(X, null) // Why is this needed? Why is this here? Oh well

GLOBAL_VAR_INIT(end_credits_song, null)
GLOBAL_VAR_INIT(end_credits_title, null)
GLOBAL_LIST(end_titles)

/datum/controller/subsystem/ticker/declare_completion(force_ending)

	if(!GLOB.end_titles)
		GLOB.end_titles = generate_titles()

	for(var/client/C)
		if(!C?.credits)
			C?.RollCredits()

/* 	for(var/thing in GLOB.clients)
		var/client/C = thing
		if (!C)
			continue */
	. = ..()

/* /datum/controller/subsystem/ticker/show_roundend_report(client/C, report_type = null)
	. = ..()
	for(var/iteration in GLOB.clients)
		var/client/clients = iteration
		if(!clients.credits)
			clients.RollCredits() */
/* /client
	var/list/credits */

/client/proc/RollCredits()
	set waitfor = FALSE
	var/credit_pref = mob.client?.prefs?.read_preference(/datum/preference/toggle/see_credits)
	if(!credit_pref)
		return

	LAZYINITLIST(credits)

/* 	if(mob)
		mob.overlay_fullscreen("meeting",/atom/movable/screen/fullscreen/emergency_meeting) */
//	sound_to_playing_players('modular_skyrat/master_files/sound/music/elibao.ogg', volume = 100, vary = FALSE, frequency = 0, channel = 0, pressure_affected = FALSE)

	var/list/_credits = credits
	verbs += /client/proc/ClearCredits
	for(var/I in GLOB.end_titles)
		if(!credits)
			return
		var/atom/movable/screen/credit/T = new(null, null, I, src)
		_credits += T
		T.rollem()
		sleep(CREDIT_SPAWN_SPEED)
	sleep(CREDIT_ROLL_SPEED - CREDIT_SPAWN_SPEED)

	ClearCredits()
	verbs -= /client/proc/ClearCredits

GAME_VERB_PROC(/client, ClearCredits, "Stop End Titles", "OOC")
	verbs -= /client/proc/ClearCredits
	QDEL_LAZYLIST(credits)

/atom/movable/screen/credit
	icon_state = "blank"
	mouse_opacity = 0
	alpha = 0
	screen_loc = "CENTER-7,CENTER-7"
	plane = HUD_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	var/client/parent
	var/matrix/target

/atom/movable/screen/credit/Initialize(mapload, datum/hud/hud_owner, credited, client/P)
	. = ..()
	parent = P
	maptext = {"<div style="font:'Small Fonts'">[credited]</div>"}
	maptext_height = world.icon_size * 2
	maptext_width = world.icon_size * 14

/atom/movable/screen/credit/proc/rollem()
	var/matrix/direction = matrix(transform)
	direction.Translate(0, CREDIT_ANIMATE_HEIGHT)
	animate(src, transform = direction, time = CREDIT_ROLL_SPEED)
	animate(src, alpha = 255, time = CREDIT_EASE_DURATION, flags = ANIMATION_PARALLEL)
	UNLINT(animate(src, alpha = 0, flags = ANIMATION_PARALLEL, time = CREDIT_EASE_DURATION, delay = CREDIT_ROLL_SPEED - CREDIT_EASE_DURATION))
	parent?.screen += src

/atom/movable/screen/credit/proc/fadeout(matrix/direction)

	sleep(CREDIT_EASE_DURATION)
	qdel(src)

/atom/movable/screen/credit/Destroy()
	var/client/P = parent
	if(parent)
		P.screen -= src
	LAZYREMOVE(P?.credits, src)
	parent = null
	. = ..()

/proc/generate_titles()
	var/list/titles = list()
	var/list/cast = list()
	var/list/chunk = list()
	var/list/possible_titles = list()
	var/chunksize = 0
	if(!GLOB.end_credits_title)
		/* Establish a big-ass list of potential titles for the "episode". */
		possible_titles += "《[pick("衰亡：", "崛起：", "麻烦：", "最后一战：", "阴暗面：", "荒芜：", "毁灭：", "危机：")]\
							[pick("太空人", "人类", "尊严", "理智", "黑猩猩", "自动售货机的物价", "巨型装甲", "瓦斯清洁工",\
							"超物质晶体", "医疗部", "工程部", "安保部", "科研部", "服务部", "指挥部", "小丑们", "货运部",\
							"巴伯站")]》"
		possible_titles += "船员们[pick("浑身发麻", "被腌了起来", "染上一种不治之症", "吃上披萨", "上了一堂宝贵的历史课", "获得一次休息", "嗨到飞起", "得以活下去", "重温童年", "卷入内战", "落下严重的宿醉", "认真对待[pick("药物滥用", "犯罪", "生产力", "古老美国卡通片", "太空球", "减压程序")]")]"
		possible_titles += "船员们了解了[pick("爱情", "毒品", "洗钱的危害", "异种敏感度", "投资诈骗", "凯洛坦滥用", "辐射防护", "神圣几何", "弦理论", "抽象数学", "[pick("提兹拉人", "斯克雷尔人", "兔子", "猫科人", "沃克斯人", "兔兔")]的交配仪式", "古代中医")]"
		possible_titles += "一场非常[pick("企业", "纳米传讯", "舰队", "兔兔", "小丑", "异星生物", "远征", "兔子", "等离子", "火星", "蛇人")]的[pick("圣诞节", "复活节", "节日", "周末", "星期四", "假期")]"
		possible_titles += "[pick("枪，到处都是枪", "最小的阿玛利斯", "当维护无人机遇上商用级填充泡沫", "进攻！进攻！进攻！", "性爱炸弹", "外星神器传说：第 [pick("I","II","III","IV","V","VI","VII","VIII","IX", "X", "C", "M", "L")] 部")]"
		possible_titles += "[pick("太空", "性感", "巨龙", "术士", "洗衣", "枪械", "广告", "狗狗", "一氧化碳", "忍者", "巫师", "苏格拉底式", "少年犯罪", "政治动机", "辐射到爆的恶心玩意")] [pick("任务", "力量", "冒险")]"
		possible_titles += "[pick("[pick("纳米传讯", "辛迪加", "阿玛达因公司", "小丑",)] 静止的那一天", "追捕绿色小香肠", "异形大战自动售货机", "太空赛道")]"
		titles += "<center><h1>第 [rand(1,1000)] 集<br>[pick(possible_titles)]<h1></h1></h1></center>"
	else
		titles += "<center><h1>第 [rand(1,1000)] 集<br>[GLOB.end_credits_title]<h1></h1></h1></center>"

	for(var/datum/mind/mind in get_crewmember_minds())
		if(!mind)
			continue
		if(!cast.len && !chunksize)
			chunk += "演员表："
		var/datum/job/job = mind?.assigned_role
		var/jobtitle = job?.title || "无头衔"
		var/used_name = mind?.current?.name
		var/antag_string
		for(var/datum/antagonist/antagonist as anything in mind?.antag_datums)
			antag_string ? (antag_string += ", ") : (antag_string += "...")
			antag_string += "[antagonist?.name]"
		chunk += "[used_name] 饰 [mind?.antag_datums ? "[antag_string] 与 [jobtitle]" : jobtitle]"
		chunksize++

		if(chunksize > 2)
			cast += "<center>[jointext(chunk,"<br>")]</center>"
			chunk.Cut()
			chunksize = 0
	if(chunk.len)
		cast += "<center>[jointext(chunk,"<br>")]</center>"

	titles += cast

	var/list/corpses = list()
	var/list/monkies = list()
	for(var/mob/living/carbon/human/H in GLOB.dead_mob_list)
		if(H.timeofdeath < 5 MINUTES) //no prespawned corpses
			continue
		if(ismonkey(H))
			monkies[H?.name] += 1
		else if(H?.real_name)
			corpses += H?.real_name
	if(corpses.len)
		titles += "<center>根据真实事件改编<br>谨以此纪念 [english_list(corpses)]。</center>"

	var/list/staff = list("制作人员：")
	var/static/list/staffjobs = list("端咖啡的", "摄影师", "咆哮担当", "椅子操作员", "编舞", "历史顾问", "服装设计师", "总编辑", "行政助理")
	var/list/goodboys = list()
	for(var/client/C)
		if(!C?.holder)
			continue
		if(C?.holder)
			staff += "[uppertext(pick(staffjobs))] 又名“[C?.key]”"

	titles += "<center>[jointext(staff,"<br>")]</center>"
	if(goodboys.len)
		titles += "<center>工作人员的乖狗狗：<br>[english_list(goodboys)]</center><br>"

	var/disclaimer = "<br>由 [pick("纳米传讯", "辛迪加", "阿玛达因公司", "你，也就是玩家")] 赞助。<br>保留所有权利。<br>\
					本影片受银河联邦及银河系各国的版权法保护。<br>\
					首次公映行星：[pick("火星", "月球", "地球", "金星", "火卫一", "谷神星", "提亚马特", "鲸鱼座ε", "厄俄斯", "冥王星", "欧埃雷", \
					"洛达尼亚", "金斯顿", "西努", "尤克利德五号", "洛里曼", "特斯滕", "卡罗塔")]。<br>"
	disclaimer += pick("禁止用于恶搞。绝对禁止。",
					   "所有特技均由薪酬过低的实习生完成。请勿在家中尝试。",
					   "[pick("纳米传讯", "辛迪加", "阿玛达因公司", )] 不认可片中展现的行为。尝试风险自负。",
					   "未经授权放映、发行或复制本影片及其任何部分（包括配乐）<br>\
						可能导致紧急响应小队被召来强攻你家，以武力将其收回。",
						"本片中的故事、所有姓名、角色与事件均属虚构。无意暗示或应被推断为与任何实际<br>\
						人物（在世或已故）、地点、建筑及产品有关。<br>\
						本片改编自真实故事，片中所有人物均以真人为原型，尽管我们刚才才说过相反的话。",
						"与本品相关的任何个人或实体均未因片中烟草产品的展示而获得任何款项或财物，或达成任何协议，<br>\
						尽管片中有大量吸烟镜头。<br>\
						（本免责声明由 [pick("纳米传讯！祝你拥有纳米级美好一天！", "猛虎合作社！先杀后问，永远别问！", "阿玛达因公司！我们怎么还活着？", "你，以及其他让我们的服务器持续运转的玩家！",)](TM) 赞助。）",
						"本片制作过程中没有任何动物受到伤害，此前列为死亡者除外。未签署免责书前请勿在家中尝试。")
	titles += "<hr>"
	titles += "<center><span style='font-size:6pt;'>[JOINTEXT(disclaimer)]</span></center>"

	return titles

/// Enables the choice of players disabling seeing the credits
/datum/preference/toggle/see_credits
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "see_credits"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

#undef CREDIT_ROLL_SPEED
#undef CREDIT_SPAWN_SPEED
#undef CREDIT_ANIMATE_HEIGHT
#undef CREDIT_EASE_DURATION
#undef JOINTEXT
