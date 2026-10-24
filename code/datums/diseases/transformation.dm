/datum/disease/transformation
	abstract_type = /datum/disease/transformation
	name = "变形"
	max_stages = 5
	spread_text = "无"
	spread_flags = DISEASE_SPREAD_SPECIAL
	cure_text = "程序员的关爱（理论上）。"
	agent = "恶作剧"
	viable_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/alien)
	severity = DISEASE_SEVERITY_BIOHAZARD
	stage_prob = 5
	visibility_flags = HIDDEN_SCANNER|HIDDEN_PANDEMIC
	disease_flags = CURABLE
	bypasses_immunity = TRUE
	var/list/stage1 = list("你感觉自己平平无奇。")
	var/list/stage2 = list("你感觉自己很无聊。")
	var/list/stage3 = list("你感觉自己毫无特色。")
	var/list/stage4 = list("你感觉自己像白面包一样乏味。")
	var/list/stage5 = list("天啊，这惨绝人寰的一幕！")
	var/new_form = /mob/living/carbon/human
	var/bantype
	var/transformed_antag_datum //Do we add a specific antag datum once the transformation is complete?

/datum/disease/transformation/Copy()
	var/datum/disease/transformation/D = ..()
	D.stage1 = stage1.Copy()
	D.stage2 = stage2.Copy()
	D.stage3 = stage3.Copy()
	D.stage4 = stage4.Copy()
	D.stage5 = stage5.Copy()
	D.new_form = D.new_form
	return D


/datum/disease/transformation/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if (length(stage1) && SPT_PROB(stage_prob, seconds_per_tick))
				to_chat(affected_mob, pick(stage1))
		if(2)
			if (length(stage2) && SPT_PROB(stage_prob, seconds_per_tick))
				to_chat(affected_mob, pick(stage2))
		if(3)
			if (length(stage3) && SPT_PROB(stage_prob * 2, seconds_per_tick))
				to_chat(affected_mob, pick(stage3))
		if(4)
			if (length(stage4) && SPT_PROB(stage_prob * 2, seconds_per_tick))
				to_chat(affected_mob, pick(stage4))
		if(5)
			do_disease_transformation(affected_mob)


/datum/disease/transformation/proc/do_disease_transformation(mob/living/affected_mob)
	if(iscarbon(affected_mob) && affected_mob.stat != DEAD)
		if(length(stage5))
			to_chat(affected_mob, pick(stage5))
		if(QDELETED(affected_mob))
			return
		if(HAS_TRAIT_FROM(affected_mob, TRAIT_NO_TRANSFORM, REF(src)))
			return
		ADD_TRAIT(affected_mob, TRAIT_NO_TRANSFORM, REF(src))
		for(var/obj/item/W in affected_mob.get_equipped_items(INCLUDE_POCKETS))
			affected_mob.dropItemToGround(W)
		for(var/obj/item/I in affected_mob.held_items)
			affected_mob.dropItemToGround(I)
		var/mob/living/new_mob = new new_form(affected_mob.loc)
		if(istype(new_mob))
			if(bantype && is_banned_from(affected_mob.ckey, bantype))
				replace_banned_player(new_mob)
			new_mob.set_combat_mode(TRUE)
			if(affected_mob.mind)
				affected_mob.mind.transfer_to(new_mob)
			else
				new_mob.PossessByPlayer(affected_mob.ckey)
		if(transformed_antag_datum)
			new_mob.mind.add_antag_datum(transformed_antag_datum)
		new_mob.name = affected_mob.real_name
		new_mob.real_name = new_mob.name
		qdel(affected_mob)

/datum/disease/transformation/proc/replace_banned_player(mob/living/new_mob) // This can run well after the mob has been transferred, so need a handle on the new mob to kill it if needed.
	set waitfor = FALSE

	var/mob/chosen_one = SSpolling.poll_ghosts_for_target("你想扮演[span_notice(affected_mob.real_name)]吗？", check_jobban = bantype, role = bantype, poll_time = 5 SECONDS, checked_target = affected_mob, alert_pic = affected_mob, role_name_text = "变形受害者")
	if(chosen_one)
		to_chat(affected_mob, span_userdanger("你的角色已被一名幽灵接管！若想避免再次发生，请对职业封禁提出申诉！"))
		message_admins("[key_name_admin(chosen_one)]接管了（[key_name_admin(affected_mob)]），以替换被职业封禁的玩家。")
		affected_mob.ghostize(FALSE)
		affected_mob.PossessByPlayer(chosen_one.ckey)
	else
		to_chat(new_mob, span_userdanger("你的角色已被死亡带走！若想避免再次发生，请对职业封禁提出申诉！"))
		new_mob.investigate_log("has been killed because there was no one to replace them as a job-banned player.", INVESTIGATE_DEATHS)
		new_mob.death()
		if (!QDELETED(new_mob))
			new_mob.ghostize(can_reenter_corpse = FALSE)

/datum/disease/transformation/jungle_flu
	name = "丛林流感"
	cure_text = "死亡"
	cures = list(/datum/reagent/medicine/adminordrazine)
	spread_text = "未知"
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	cure_chance = 0.5
	disease_flags = CAN_CARRY|CAN_RESIST
	desc = "古老的\"丛林热\"的后裔，毒性虽已减弱却仍然危险，受害者最终会在基因层面退化为灵长类动物。 \
	幸运的是，变成猴子后不会产生丛林热那种类似狂犬病的狂暴。"
	severity = DISEASE_SEVERITY_BIOHAZARD
	stage_prob = 2
	visibility_flags = NONE
	agent = "金刚弧菌 M-909"
	new_form = /mob/living/carbon/human/species/monkey

	stage1 = list()
	stage2 = list()
	stage3 = list()
	stage4 = list(
		span_warning("你开始用嘴呼吸。"),
		span_warning("你特别想吃香蕉。"),
		span_warning("你的背很痛。"),
		span_warning("你的思绪混沌不清。"),
	)
	stage5 = list(span_warning("你想像猴子一样四处胡闹。"))

/datum/disease/transformation/jungle_flu/do_disease_transformation(mob/living/carbon/affected_mob)
	affected_mob.monkeyize()

/datum/disease/transformation/jungle_flu/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_notice("你的[pick("手臂", "背部", "手肘", "头部", "腿部")]发痒。"))
		if(3)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的头一阵刺痛。"))
				affected_mob.adjust_confusion(10 SECONDS)
		if(4)
			if(SPT_PROB(1.5, seconds_per_tick))
				affected_mob.say(pick("吱——！", "吱吱，呜呜！", "吱——吱！", "嗯哼，嗯哼。"), forced = "jungle fever")

/datum/disease/transformation/robot
	name = "机械化变形"
	cure_text = /datum/reagent/copper::name
	cures = list(/datum/reagent/copper)
	cure_chance = 2.5
	agent = "R2D2 纳米机器"
	desc = "这种疾病实为急性纳米机器感染，会将受害者转化为半机械人。"
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list()
	stage2 = list(span_danger("哔……啵……"), "你的关节感觉僵硬。")
	stage3 = list(
		span_danger("你感觉有什么东西在动……在体内。"),
		span_danger("你的关节感觉非常僵硬。"),
		span_warning("你的皮肤感觉松弛了。"),
	)
	stage4 = list(span_danger("你能感觉到……有什么东西……在你体内。"), span_danger("你的皮肤感觉非常松弛。"),)
	stage5 = list(span_danger("你的皮肤仿佛马上就要爆裂脱落！"))
	new_form = /mob/living/silicon/robot
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD|MOB_ROBOTIC
	bantype = JOB_CYBORG

/datum/disease/transformation/robot/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(3)
			if (SPT_PROB(4, seconds_per_tick))
				affected_mob.say(pick("哔，哔！", "哔，啵", "啵……哔"), forced = "robotic transformation")
			if (SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的头一阵刺痛。"))
				affected_mob.Unconscious(40)
		if(4)
			if (SPT_PROB(10, seconds_per_tick))
				affected_mob.say(pick("哔，哔！", "啵哔啵哔。", "我——想——死——……", "杀——了——我"), forced = "robotic transformation")


/datum/disease/transformation/xeno

	name = "异形变形"
	cure_text = /datum/reagent/medicine/spaceacillin::name + " & " + /datum/reagent/glycerol::name
	cures = list(/datum/reagent/medicine/spaceacillin, /datum/reagent/glycerol)
	cure_chance = 2.5
	agent = "雷普利外星微生物"
	desc = "这种疾病会将受害者变成异形。"
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list()
	stage2 = list("你的喉咙感觉刺痒。", span_danger("杀戮……"))
	stage3 = list(
		span_danger("你感觉有什么东西在动……在体内。"),
		span_danger("你的喉咙感觉非常刺痒。"),
		span_warning("你的皮肤感觉紧绷。"),
	)
	stage4 = list(
		span_danger("你能感觉到……有什么东西……在你体内。"),
		span_danger("你的血液沸腾了！"),
		span_danger("你的皮肤感觉非常紧绷。"),
	)
	stage5 = list(span_danger("你的皮肤仿佛马上就要爆裂脱落！"))
	new_form = /mob/living/carbon/alien/adult/hunter
	bantype = ROLE_ALIEN


/datum/disease/transformation/xeno/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(3)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的头一阵刺痛。"))
				affected_mob.Unconscious(40)
		if(4)
			if(SPT_PROB(10, seconds_per_tick))
				affected_mob.say(pick("我要……吞掉你……", "嘶——！", "你看起来真美味。"), forced = "xenomorph transformation")


/datum/disease/transformation/slime
	name = "高级突变变形"
	cure_text = /datum/reagent/consumable/frostoil::name
	cures = list(/datum/reagent/consumable/frostoil)
	cure_chance = 55
	agent = "高级突变毒素"
	desc = "这种高度浓缩的提取物会将一切转化为更多同类。"
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list("你感觉不太舒服。")
	stage2 = list("你的皮肤感觉有点黏滑。")
	stage3 = list(span_danger("你的肢体正在融化。"), span_danger("你的四肢开始失去形状。"))
	stage4 = list(span_danger("你正在变成史莱姆。"))
	stage5 = list(span_danger("你已经变成了史莱姆。"))
	new_form = /mob/living/basic/slime


/datum/disease/transformation/slime/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(ishuman(affected_mob))
				var/mob/living/carbon/human/human = affected_mob
				if(isjellyperson(human))
					update_stage(5)
		if(3)
			if(ishuman(affected_mob))
				var/mob/living/carbon/human/human = affected_mob
				if(!ismonkey(human) && !isjellyperson(human))
					human.set_species(/datum/species/jelly/slime)

/datum/disease/transformation/slime/do_disease_transformation(mob/living/affected_mob)
	if(affected_mob.client && ishuman(affected_mob)) // if they are a human who's not a monkey and are sentient, then let them have the old fun
		var/mob/living/carbon/human/human = affected_mob
		if(!ismonkey(human))
			new_form = /mob/living/basic/slime/random
	return ..()

/datum/disease/transformation/corgi
	name = "犬吠降临"
	cure_text = "死亡"
	cures = list(/datum/reagent/medicine/adminordrazine)
	agent = "邪恶神犬魔法"
	desc = "这种疾病会将受害者变成柯基。"
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list("汪。")
	stage2 = list("你想戴上滑稽的帽子。")
	stage3 = list(span_danger("必须……吃……巧克力……"), span_danger("汪汪"))
	stage4 = list(span_danger("洗衣机的幻象涌入你的脑海！"))
	stage5 = list(span_danger("嗷呜——！！！"))
	new_form = /mob/living/basic/pet/dog/corgi


/datum/disease/transformation/corgi/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return
	switch(stage)
		if(3)
			if (SPT_PROB(4, seconds_per_tick))
				affected_mob.say(pick("汪！", "汪汪"), forced = "corgi transformation")
		if(4)
			if (SPT_PROB(10, seconds_per_tick))
				affected_mob.say(pick("嗷呜——", "汪！"), forced = "corgi transformation")


/datum/disease/transformation/morph
	name = "暴食赐福"
	cure_text = "无"
	cures = list(/datum/reagent/consumable/nothing)
	agent = "暴食赐福"
	desc = "来自某个可怕地方的“礼物”。"
	stage_prob = 10
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list("你的胃咕噜作响。")
	stage2 = list("你的皮肤感觉松垮了。")
	stage3 = list(span_danger("你的肢体正在融化。"), span_danger("你的四肢开始失去形状。"))
	stage4 = list(span_danger("你饥肠辘辘。"))
	stage5 = list(span_danger("你已经变成了拟态怪。"))
	new_form = /mob/living/basic/morph
	infectable_biotypes = MOB_ORGANIC|MOB_MINERAL|MOB_UNDEAD //magic!
	transformed_antag_datum = /datum/antagonist/morph

/datum/disease/transformation/gondola
	name = "贡多拉变形"
	cure_text = /datum/reagent/consumable/condensedcapsaicin::name + "（不可通过蒸气施用）"
	cures = list(/datum/reagent/consumable/condensedcapsaicin) //beats the hippie crap right out of your system
	cure_chance = 55
	stage_prob = 2.5
	agent = "宁静"
	desc = "食用贡多拉的肉需要付出可怕的代价。"
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list("你的脚步似乎轻盈了一些。")
	stage2 = list("你发现自己无缘无故地微笑。")
	stage3 = list(
		span_danger("一种残酷的平静笼罩着你。"),
		span_danger("你感觉不到自己的手臂了！"),
		span_danger("你放下了伤害小丑的冲动。"),
	)
	stage4 = list(span_danger("你感觉不到自己的手臂，但这已经不再困扰你。"), span_danger("你原谅了伤害你的小丑。"))
	stage5 = list(span_danger("你已经变成了贡多拉。"))
	new_form = /mob/living/basic/pet/gondola


/datum/disease/transformation/gondola/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("smile")
			if(SPT_PROB(10, seconds_per_tick))
				affected_mob.reagents.add_reagent_list(list(/datum/reagent/pax = 5))
		if(3)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("smile")
			if(SPT_PROB(10, seconds_per_tick))
				affected_mob.reagents.add_reagent_list(list(/datum/reagent/pax = 5))
		if(4)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("smile")
			if(SPT_PROB(10, seconds_per_tick))
				affected_mob.reagents.add_reagent_list(list(/datum/reagent/pax = 5))
			if(SPT_PROB(1, seconds_per_tick))
				var/obj/item/held_item = affected_mob.get_active_held_item()
				if(held_item)
					to_chat(affected_mob, span_danger("你松开了手中的东西。"))
					affected_mob.dropItemToGround(held_item)
