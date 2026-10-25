/datum/religion_rites/dream_portent
	name = "梦境预兆"
	desc = "立刻陷入沉睡，并接收未来的预兆。\
		景象可能难以解读，但多半会以某种形式成真。\
		任何伤害都会唤醒你并打断景象。"
	favor_cost = 50
	rite_flags = NONE
	ritual_length = 6 SECONDS

/datum/religion_rites/dream_portent/New()
	. = ..()
	ritual_invocations = list(
		"伟大的牧者 [GLOB.deity]，请赐予我未来之景！……",
		"愿我们的羊群能挺过即将到来的考验……",
	)

/datum/religion_rites/dream_portent/can_afford(mob/living/user)
	if(!..())
		return FALSE
	if(!iscarbon(user))
		to_chat(user, span_warning("你不是能接收预兆的那种生物。"))
		return FALSE
	return TRUE

/datum/religion_rites/dream_portent/invoke_effect(mob/living/user, atom/religious_tool)
	if(!user.SetSleeping(10 SECONDS))
		to_chat(user, span_warning("你没能入睡。"))
		return FALSE

	user.visible_message(span_notice("[user] 突然陷入沉睡，双眼微微颤动……"))
	user.adjust_drowsiness(30 SECONDS)
	return ..()

/datum/religion_rites/dream_portent/post_invoke_effects(mob/living/user, atom/religious_tool)
	. = ..()
	RegisterSignal(user, COMSIG_PRE_DREAMING, PROC_REF(add_portent))
	RegisterSignal(user, COMSIG_START_DREAMING, PROC_REF(check_portent))
	RegisterSignal(user, COMSIG_END_DREAMING, PROC_REF(end_portent))
	RegisterSignal(user, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(interrupt_portent))
	addtimer(CALLBACK(src, PROC_REF(force_dream), user), rand(2, 5) SECONDS, TIMER_DELETE_ME) // force the dream to start immediately

/datum/religion_rites/dream_portent/proc/force_dream(mob/living/carbon/dreamer)
	if(!iscarbon(dreamer) || HAS_TRAIT(dreamer, TRAIT_DREAMING))
		return // dreamed naturally already
	dreamer.dream()

/datum/religion_rites/dream_portent/proc/add_portent(mob/living/carbon/dreamer, list/dream_pool)
	SIGNAL_HANDLER

	// removes any pre-existing vague portents in the dream pool so we can give the real deal
	for(var/datum/dream/random/vague_portent/existing in dream_pool)
		dream_pool -= existing

	dream_pool[new /datum/dream/specific_portent()] = 2000

/datum/religion_rites/dream_portent/proc/check_portent(mob/living/carbon/dreamer, datum/dream/current_dream)
	SIGNAL_HANDLER

	if(istype(current_dream, /datum/dream/specific_portent))
		return

	to_chat(dreamer, span_cyan("你的思绪游移，却没有得到清晰的景象……你必须稍后再试。"))
	refund(0.8)
	dreamer.adjust_drowsiness(10 SECONDS)
	dreamer.add_mood_event("dream_failed", /datum/mood_event/dream_failed)

/datum/religion_rites/dream_portent/proc/interrupt_portent(mob/living/carbon/dreamer, damage_amount)
	SIGNAL_HANDLER

	if(!prob(damage_amount * 10)) // higher damage = higher chance to interrupt
		return

	to_chat(dreamer, span_warning("你受到伤害，梦境被打断了！"))
	dreamer.SetSleeping(0)
	dreamer.adjust_drowsiness(10 SECONDS)
	dreamer.add_mood_event("dream_interrupted", /datum/mood_event/dream_interrupted)

/datum/religion_rites/dream_portent/proc/end_portent(mob/living/carbon/dreamer, datum/dream/current_dream)
	SIGNAL_HANDLER

	qdel(src)

/datum/mood_event/dream_interrupted
	mood_change = -2
	description = "我被人粗暴地从梦中惊醒！"
	timeout = 5 MINUTES

/datum/mood_event/dream_failed
	mood_change = -2
	description = "我无法从梦中得到清晰的景象！"
	timeout = 5 MINUTES

/datum/dream/specific_portent
	weight = 0
	sleep_until_finished = TRUE

/datum/dream/specific_portent/GenerateDream(mob/living/carbon/dreamer)
	. = list()
	. += span_cyan("未来的预兆")

	var/list/portent_types = list(
		"[GLOB.deity] 热情地问候你" = "[GLOB.deity] 向你告别，但你仍能感到其存在注视着你",
		"一颗水晶球显现出未来之景" = "最终，水晶球恢复了平常的不透明状态",
		"一道神圣之光令你目盲，显现出即将发生之事的片段" = "最后，光芒消退，只留下挥之不去的温暖",
		"一轮满月照亮天空" = "月亮越过地平线，带来新的黎明",
		"一个笼罩在阴影中的神秘身影出现" = "他们离去，留给你一种[pick("惊奇", "恐惧", "好奇", "不祥")]的感觉",
		"一个不可理解的实体将你包裹，向你展示过去、现在与未来的景象" = "实体放开了你，留下敬畏与恐惧",
		"一位年老的[pick("男人", "女人", "先知", "神谕者")]走近你，给出隐晦的建议" = "你还没来得及发问，他们就消失了",
		"群星以你从未见过的方式排列" = "最后，群星恢复了平常的星座排列",
		"前方的树木分开，露出一条隐秘的小径" = "最终，树木摇回原位，你失去了那条小径",
		"你行走在毫无特征的大地上，形状开始成形" = "最后，那些形状消逝，只留你独自处于虚空",
		"你看见自己安详地睡着" = "最后，你看见自己平静地醒来",
		"你的第三只眼睁开，揭示出一个隐藏的真相" = "最后，你的第三只眼闭上，但景象仍萦绕在脑海中",
	)
	var/picked_portent = pick(portent_types)

	. += span_cyan(picked_portent)
	for(var/part in get_portent(dreamer))
		. += span_cyan(part)
	. += span_cyan(portent_types[picked_portent])

/datum/dream/specific_portent/proc/get_portent(mob/living/carbon/dreamer)
	if(prob(1))
		GLOB.religious_sect.adjust_favor(25, dreamer)
		return pick(list(
			list("答复模糊", "请稍后再试"),
			list("请稍后再问"),
			list("现在最好别告诉你"),
			list("现在无法预测"),
			list("集中精神再问一次"),
		))

	for(var/datum/antagonist/nightmare/nightmare in GLOB.antagonists)
		if(nightmare.owner?.current?.stat == STABLE)
			return pick(list(
				list("你做了一个可怕的噩梦", "其中充满难以形容的恐怖", "留下挥之不去的恐惧感"),
				list("你做了一个可怕的噩梦", "其中充满你自己死亡的景象", "留下挥之不去的厄运感"),
				list("你做了一个可怕的噩梦", "其中充满你过去的可怕记忆", "留下挥之不去的悲伤"),
				list("你做了一个可怕的噩梦", "其中充满某个不确定存在的影响", "留下挥之不去的不安"),
				list("你做了一个可怕的噩梦", "其中充满刺痛与令人窒息的黑暗", "留下挥之不去的恐慌"),
			))

	for(var/datum/team/cult/cult in GLOB.antagonist_teams)
		if(cult.cult_ascendent)
			return list("鲜血几何之神纳尔西侵入了你的梦境", "她的存在令人压抑窒息", "她贪婪地注视着你")

	for(var/datum/antagonist/heretic/heretic in GLOB.antagonists)
		if(!heretic.ascended || isnull(heretic.owner?.current))
			continue
		if(IS_UNCONSCIOUS_OR_CRIT(heretic.owner.current))
			return list(
				"漫宿之门在你面前隐现",
				"装饰繁复——却已开裂、破损，并被封死",
				"一股强大的[IS_HERETIC(dreamer) ? "力量" : "邪恶"]被永久封锁在内",
			)

		var/list/heretic_text = list("漫宿之门在你面前隐现", "装饰繁复，微微敞开", "你从缝隙中望去")
		switch(prob(75) ? heretic.heretic_path.route : null)
			if(PATH_ASH)
				heretic_text += "门后是一片荒芜的废土"
				heretic_text += "所有生命早已消逝，被烧成灰烬与尘土"
				heretic_text += "烟雾弥漫，你几乎无法呼吸"
			if(PATH_FLESH)
				heretic_text += "门后是一片浩瀚的血海"
				heretic_text += "溺水者的惨叫充斥空气"
				heretic_text += "血液拍打着你的双脚"
			if(PATH_VOID)
				heretic_text += "门后，无边的空虚向四面八方延展"
				heretic_text += "寂静震耳欲聋"
				heretic_text += "你知道自己并不孤单"
			if(PATH_COSMIC)
				heretic_text += "门后，你看见星辰的诞生与死亡，星系在宇宙之舞中碰撞"
				heretic_text += "这一切的美令人无法承受"
				heretic_text += "你感到自己微不足道"
			if(PATH_BLADE)
				heretic_text += "门后，一场宏大的战役正在展开"
				heretic_text += "无数战士在无尽的战争中厮杀"
				heretic_text += "钢铁交击声与阵亡者的哀嚎充斥空气"
			if(PATH_LOCK)
				heretic_text += "门后是一座无尽的迷宫"
				heretic_text += "你在其中穿行时，墙壁不断移动变幻"
				heretic_text += "无论你转向哪边，都找不到出口"
			if(PATH_MOON)
				heretic_text += "门后，你目睹一场盛大的狂欢"
				heretic_text += "满是奇异的景象与气味，还有无尽的欢乐与笑声"
				heretic_text += "你始终无法摆脱某种不对劲的感觉"
			else
				heretic_text += "门后的景象无法被理解"
				heretic_text += "其庞大的规模令你难以承受"
				heretic_text += "你感到敬畏与恐惧交织"

		return heretic_text

	for(var/datum/antagonist/wizard/wizard in GLOB.antagonists)
		if(isnull(wizard.owner?.current) || IS_UNCONSCIOUS_OR_CRIT(wizard.owner.current))
			return
		if(wizard.ritual?.times_completed < GRAND_RITUAL_RUNES_WARNING_POTENCY)
			if(prob(1))
				return list(
					"一个花哨的傻瓜正在表演",
					"许多人为其滑稽举动哀叹，但也有人被逗乐",
					"他们似乎毫无是非观念",
					"真是个混蛋",
				)
			return

		if(wizard.ritual.times_completed == GRAND_RITUAL_FINALE_COUNT)
			return list(
				"魔术师再次出现",
				"他们无视你，向看不见的观众鞠躬",
				"你听到人群的欢呼与掌声",
				"一道强光将你笼罩，使你目盲",
				"当视力恢复时，魔术师已经不见了",
			)

		if(wizard.ritual.times_completed == GRAND_RITUAL_IMMINENT_FINALE_POTENCY)
			return list(
				"魔术师再次向你问候，咧嘴笑着",
				"他们告诉你大结局即将到来",
				"你能感到周围的空气迸发着魔法能量",
				"魔术师眨了眨眼，承诺献上一场难忘的演出",
				"你还没来得及发问，他们又消失了",
			)

		return list(
			"一个身披长袍的身影在你的梦中显现",
			"他们自称魔术师",
			"他们展示力量，令你惊叹",
			"他们来得突然，去得也突然",
		)

	for(var/obj/machinery/nuclearbomb/bomb as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/nuclearbomb))
		if(bomb.timing)
			return pick(list(
				list("你看见", "一颗超新星", "明亮而刺眼", "转瞬之间吞噬一切"),
				list("你看见", "地平线上升起的蘑菇云", "毁灭与破败的征兆"),
				list("你看见", "一只滴答作响的钟", "正倒数着一场不可避免的灾难"),
				list("你看见", "岩石山顶上一座高耸的塔", "闪电击中，将它击倒", "这预示着正在发生的灾祸"),
			))

	for(var/obj/item/disk/nuclear/nuke_disk as anything in SSpoints_of_interest.real_nuclear_disks)
		var/area/disk_loc = get_area(nuke_disk)
		if(!istype(disk_loc, /area/station) && !istype(disk_loc, /area/space))
			return pick(list(
				list("你看见", "一颗垂死的恒星", "正缓缓变暗", "濒临崩塌"),
				list("你看见", "一个漫无目的跳舞的傻瓜", "手里拿着一枚滴答作响的炸弹", "鲁莽的征兆"),
				list("你看见", "一个倒吊的人", "被一只脚踝轻轻摇晃", "这预示着悬而未决"),
				list("你看见", "岩石山顶上一座高耸的塔", "大雨倾盆，远处雷声滚滚", "这预示着灾祸将至"),
			))

	for(var/mob/living/carbon/human/clone as anything in GLOB.human_list)
		if(clone != dreamer && clone.real_name == dreamer.real_name && !IS_UNCONSCIOUS_OR_CRIT(clone) && prob(50))
			return list(
				"你看见自己",
				"在一面雾气弥漫的镜中",
				"倒影扭曲变形",
				"但毫无疑问是你",
			)

	if(prob(length(dreamer.get_all_orbiters()) * 20))
		return list(
			"你感到一个幽灵般的[pick("存在", "实体", "身影")]",
			"它似乎正试图与你交流",
			"但你无法理解它的讯息",
			"一阵悲伤与渴望涌上心头",
		)

	if(IS_HERETIC(dreamer) && prob(50))
		var/datum/antagonist/heretic/heretic = GET_HERETIC(dreamer)
		if(prob(75) && !heretic.feast_of_owls)
			switch(heretic.heretic_path?.route)
				if(PATH_START)
					return list("你看见", "前方道路出现岔口", "眼前的路充满未知与可能")
				if(PATH_ASH)
					return list("你看见", "前方是一片荒芜的废土", "烧焦的树木排列在地平线上", "空气中弥漫着浓重的烟雾与灰烬", "景象凄凉而荒芜")
				if(PATH_FLESH)
					return list("你看见", "前方是一支由融合体组成的军团", "扭曲而怪诞", "整齐地朝未知的目的地行进")
				if(PATH_VOID)
					return list("你看见", "空无一物", "一个仿佛吞噬所有光明与希望的虚空", "寂静震耳而压抑")
				if(PATH_COSMIC)
					return list("你看见", "一颗新星的诞生", "光芒四射，向外伸展", "你并不孤单")
				if(PATH_BLADE)
					return list("你看见", "前方是一座高耸的堡垒", "城墙边排列着坚定的守卫", "他们每一个人都向你鞠躬致敬")
				if(PATH_LOCK)
					return list("你看见", "一座无尽的迷宫", "你在其中穿行时，墙壁不断移动变幻", "这是对你决心与机敏的考验")
				if(PATH_MOON)
					return list("你看见", "一场永不落幕的狂欢", "空气中充满欢乐与笑声", "但底下涌动着忧郁与渴望")

		return list("你看见", "前方有一扇巨大的门", "装饰繁复，散发着强大的气场", "但始终没有打开", "无论你等多久")

	var/dead = 0
	for(var/mob/deceased as anything in GLOB.player_list)
		if(deceased.stat == DEAD)
			dead += 1

	switch(dead / length(GLOB.joined_player_list))
		if(0.25 to 0.5)
			return pick(list(
				list("你发现自己", "身处一座小墓地", "规模不大，却打理得十分用心", "墓上放着新鲜的花"),
				list("你看见", "幽灵的幻象", "在空间站中四处飘荡"),
			))
		if(0.5 to 0.75)
			return pick(list(
				list("你发现自己", "身处一条昏暗的走廊", "空气中弥漫着恐惧"),
				list("你看见", "逼近的黑暗幻象", "诡异地威胁着你"),
			))
		if(0.75 to 0.9)
			return pick(list(
				list("你发现自己", "身处一间空荡的舞厅", "只有闪烁的灯光勉强照明"),
				list("你看见", "一片寂静战场的画面", "没有明确的胜者，各方都损失惨重"),
			))
		if(0.9 to 1)
			return pick(list(
				list("你发现自己", "孤身一人", "除了自身的黑暗什么也看不见", "除了心跳什么也听不见", "一幅凄凉而绝望的景象"),
				list("你看见", "你自己孤身一人的幻象", "身处荒凉的废土", "看不到任何生命或希望的迹象"),
			))

	var/max_law_changes = 0
	for(var/mob/living/silicon/ai/ai as anything in GLOB.ai_list)
		max_law_changes = max(max_law_changes, ai.law_change_counter)

	if(prob(clamp((max_law_changes - 10) * 10, 0, 50)))
		return pick(list(
			list("你看见", "一棵扭曲病态的树", "其枝条似乎伸入空间站的每一个角落", "树根滴落着墨黑的液体"),
			list("你看见", "一个腐败的政客", "被谄媚者与傀儡包围", "在幕后操纵一切"),
			list("你看见", "嗡鸣的电子设备", "电线仿佛蜿蜒伸向远方", "红光与静电将你笼罩"),
		))

	if(EMERGENCY_ESCAPED_OR_ENDGAMED)
		return list("你看见", "地平线上新的开始", "让人感到温暖")

	if(EMERGENCY_PAST_POINT_OF_NO_RETURN)
		return list("你看见", "近在咫尺却无法触及的救赎")

	if(prob(75) || GLOB.communications_controller.announced_greenshift)
		if(length(GLOB.admins) >= 5)
			return list("你看见", "远处一群强大存在的聚会", "他们的意图不明")

		switch(SSdynamic.current_tier.tier)
			if(0)
				return list("你看见", "一片繁茂的田野", "充满生命与活力", "象征未来的希望")
			if(1)
				return pick(list(
					list("你看见", "远处一个孤独的身影", "笼罩在神秘之中"),
					list("你看见", "一头[pick("野兽", "怪物", "动物")]在阴影中潜行", "意图不明"),
					list("你看见", "一片[pick("雾", "薄雾", "云")]席卷而来", "遮蔽了沿途的一切"),
				))
			if(2)
				return pick(list(
					list("你发现自己", "身处一片枝杈交错的森林", "幽暗，且有许多潜在的道路"),
					list("你发现自己", "身处一座古城", "依然熙熙攘攘", "但处处透着衰败的气息"),
				))
			if(3)
				return list("你发现自己", "身处一座燃烧的城市", "火焰高高窜起", "但所有人都在竭力求生")
			if(4)
				return list("你发现自己", "身处混乱的战场", "没有明确的阵营或胜者", "只有无尽的冲突与苦难")

	return list("你看见", "没有什么值得注意的东西", "但对未来仍有一种挥之不去的不安")

/datum/dream/random/vague_portent
	weight = 0
	sleep_until_finished = TRUE

/datum/dream/random/vague_portent/get_dream_nouns(mob/living/carbon/dreamer)
	var/list/antags = list()
	for(var/datum/antagonist/antag as anything in GLOB.antagonists)
		antags |= LOWER_TEXT(antag.jobban_flag || antag.pref_flag)

	if(prob(80) || !length(antags))
		for(var/datum/dynamic_ruleset/ruleset as anything in subtypesof(/datum/dynamic_ruleset))
			antags |= LOWER_TEXT(initial(ruleset.jobban_flag) || initial(ruleset.pref_flag))

	// chance to make nightmares the focus of the dream
	var/nightmare_id = /datum/antagonist/nightmare::jobban_flag || /datum/antagonist/nightmare::pref_flag
	if(prob(20) && (LOWER_TEXT(nightmare_id) in antags))
		return list(LOWER_TEXT(nightmare_id))

	return antags
