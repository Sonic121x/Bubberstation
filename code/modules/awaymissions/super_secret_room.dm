/obj/structure/speaking_tile
	name = "奇怪的瓷砖"
	desc = "一块诡异的瓷砖，它不断呼唤你靠近。也许它能帮你摆脱这场麻烦……"
	verb_say = "吟诵道"
	icon = 'icons/obj/structures.dmi'
	icon_state = "speaking_tile"
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	resistance_flags = INDESTRUCTIBLE
	var/speaking = FALSE
	var/times_spoken_to = 0
	var/list/shenanigans = list()

/obj/structure/speaking_tile/Initialize(mapload)
	. = ..()
	var/json_file = file("data/npc_saves/Poly.json")
	if(!fexists(json_file))
		return
	var/list/json = json_decode(file2text(json_file))
	shenanigans = json["phrases"]

/obj/structure/speaking_tile/interact(mob/user)
	if(!isliving(user) || speaking)
		return
	speaking = TRUE

	switch(times_spoken_to)
		if(0)
			SpeakPeace(list("欢迎来到错误处理室。","一定是出了什么大差错，才把你送到这里。","你最好告诉管理员你刚才在做什么，或者提交一个 bug 报告。"))
			for(var/obj/structure/signpost/salvation/sign in orange(7))
				sign.SetInvisibility(INVISIBILITY_NONE)
				do_smoke(1, src, sign.loc)
				break
		if(1)
			SpeakPeace(list("从那个梯子上去。","它会把你送回空间站。","但愿你再也不用见到这个地方。"))
		if(2)
			SpeakPeace(list("好奇发生了什么吗？","不知怎的，你的躯体连同你本人一起被送进了虚空空间。","幸运的是，这个房间的存在就是为了把你从那种可怕的命运中拯救出来。"))
		if(3)
			SpeakPeace(list("所以，不客气。","话说回来，你就没有别的事要做吗？","一直待在这里其实没有任何意义。"))
		if(4)
			SpeakPeace(list("你如此在意这个房间，我深感荣幸。","不过整个班次都站在这里看我会说什么，这可不太合适。","我会努力变得更无聊，好让你离开。"))
		if(5 to 8)
			SpeakPeace(list("……"))
		if(9)
			SpeakPeace(list("好吧，也许那<b>太</b>无聊了。", "但我不能一直手动敲这些台词。", "这很难解释，但我用的代码结构实在有点糟糕。"))
		if(10)
			SpeakPeace(list("哦，我有主意了！", "我们把这无止境的闲扯外包给波利吧！", "这样你就能一直听下去而不会觉得无聊了！"))
			if(isnull(shenanigans) || !shenanigans.len)
				shenanigans = list("只不过波利的文件不见了……")
		if(11 to 14, 16 to 50, 52 to 99, 103 to 107, 109 to 203, 205 to 249, 252 to 665, 667 to 999, 1001 to 5642)
			SpeakPeace(list(pick(shenanigans),pick(shenanigans),pick(shenanigans)))
			if(times_spoken_to % 10 == 0)
				SpeakPeace(list("顺便说一句，你已经跟我对话 [times_spoken_to] 次了。"))
		if(15)
			SpeakPeace(list("看吧？是不是很有趣？","现在你可以连续按上好几个小时也不会腻。","总之，就交给你了。"))
		if(51)
			SpeakPeace(list("这儿的乐趣永无止境。", "波利的文本文件最多存有 500 条语句。", "不过你现在大概已经听到一些重复的了。"))
		if(100)
			SpeakPeace(list("整整一百次了。", "干得不错，我想。", "你现在大概已经听到很多重复的了。"))
		if(101)
			SpeakPeace(list("希望你能领会这个房间所呈现的梗。", "以及这段对话所呈现的更冷门的元梗。", "这些东西是有层次的。"))
		if(102)
			SpeakPeace(list("我很想就这么一直拖下去。","严格来说，那比现在这样还省事。","只是个选项。"))
		if(108)
			SpeakPeace(list("但你对这个玩笑如此执着，值得我尊敬。", "所以这样吧，我们定一个目标。", "250 次就是你的最终任务。"))
		if(204)
			SpeakPeace(list("注意到 200 次时没有特别消息了吗？", "曾经有意义的里程碑被慢慢自动化了？","这都是玩笑的一部分。"))
		if(250)
			SpeakPeace(list("恭喜。", "按我十分粗略的估算，你已经为了这件事浪费了这轮游戏相当一部分时间。", "但你见证了这个梗的结局，这本身就是一种体验，对吧？"))
		if(251)
			SpeakPeace(list("总之，拿着。", "我不能给你任何会影响本轮进程的东西。","但至少这是你应得的。"))
			var/obj/item/reagent_containers/cup/glass/trophy/silver_cup/the_ride = new(get_turf(user))
			the_ride.name = "玩笑过火：第二名"
			the_ride.desc = "凡事都有该停下的时候，而我们显然已经越过了那条线。"
		if(252)
			SpeakPeace(list("你知道这意味着什么吧？", "当然，还没结束！", "现在的问题变成了：是坚持走向未知终点更了不起，还是有点常识就此停手？"))
		if(666)
			SpeakPeace(list("你心中的黑暗不会被简单的陈词滥调填满。","你现在不会停下的，你要坚持到底。", "你能在回合结束前冲过终点线吗？"))
		if(1000)
			SpeakPeace(list("终点在那些有意义的里程碑之外的某处。", "在那之前不会再有消息了。", "你真让我恶心。"))
		if(5643)
			user.client.give_award(/datum/award/achievement/misc/time_waste, user)
			var/obj/item/reagent_containers/cup/glass/trophy/gold_cup/never_ends = new(get_turf(user))
			never_ends.name = "玩笑过火：第一名"
			never_ends.desc = "于是我们只能与自己的悔恨相伴。"
		else
			y += 2
	speaking = FALSE
	times_spoken_to++

/obj/structure/speaking_tile/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	interact(user)
	return ITEM_INTERACT_SUCCESS

/obj/structure/speaking_tile/attack_paw(mob/user, list/modifiers)
	return interact(user)

/obj/structure/speaking_tile/attack_hulk(mob/user)
	return

/obj/structure/speaking_tile/attack_larva(mob/user, list/modifiers)
	return interact(user)

/obj/structure/speaking_tile/attack_ai(mob/user)
	return interact(user)


/obj/structure/speaking_tile/attack_animal(mob/user, list/modifiers)
	return interact(user)

/obj/structure/speaking_tile/proc/SpeakPeace(list/statements)
	for(var/i in 1 to statements.len)
		say(span_deadsay("[statements[i]]"), sanitize=FALSE)
		if(i != statements.len)
			sleep(3 SECONDS)

/obj/item/rupee
	name = "怪异水晶"
	desc = "当你发现它不过是块染色玻璃时，你的兴奋瞬间蒸发殆尽。为什么会有人囤积这种东西呢？"
	icon = 'icons/obj/economy.dmi'
	icon_state = "rupee"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT*5)

/obj/item/rupee/Initialize(mapload)
	. = ..()
	var/newcolor = pick(10;COLOR_GREEN, 5;COLOR_BLUE, 3;COLOR_RED, 1;COLOR_PURPLE)
	add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/rupee/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!ismob(AM))
		return
	INVOKE_ASYNC(src, PROC_REF(put_in_crossers_hands), AM)

/obj/item/rupee/proc/put_in_crossers_hands(mob/crosser)
	if(crosser.put_in_hands(src))
		if(src != crosser.get_active_held_item())
			crosser.swap_hand()
		equip_to_best_slot(crosser)

/obj/item/rupee/equipped(mob/user, slot)
	playsound(get_turf(loc), 'sound/misc/server-ready.ogg', 50, TRUE, -1)
	..()

/obj/effect/landmark/error
	name = "error"
	icon_state = "error_room"
