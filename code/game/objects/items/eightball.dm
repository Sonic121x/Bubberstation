/obj/item/toy/eightball
	name = "魔法八号球"
	desc = "一颗侧面印着白色数字8的黑球，里面似乎装满了深色液体。\n说明书上写着：大声说出问题，然后摇晃。"

	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "eightball"
	w_class = WEIGHT_CLASS_TINY

	verb_say = "咔嗒作响"

	var/shaking = FALSE
	var/on_cooldown = FALSE

	var/shake_time = 5 SECONDS
	var/cooldown_time = 10 SECONDS

	var/static/list/possible_answers = list(
		"Yes" = list(
			"千真万确",
			"确实如此",
			"毫无疑问",
			"绝对是的",
			"可以放心",
			"依我看，是的",
			"很有可能",
			"前景不错",
			"是的",
			"迹象表明是的",
		),
		"Maybe" = list(
			"答案模糊，请重试",
			"稍后再问",
			"现在最好不告诉你",
			"现在无法预测",
			"集中精神再问一次",
		),
		"No" = list(
			"别指望了",
			"我的回答是否定的",
			"我的消息来源说不",
			"前景不太妙",
			"很值得怀疑"
		),
	)

/obj/item/toy/eightball/Initialize(mapload)
	. = ..()
	if(MakeHaunted())
		return INITIALIZE_HINT_QDEL

/obj/item/toy/eightball/proc/MakeHaunted()
	if(prob(1))
		new /obj/item/toy/eightball/haunted(loc)
		return TRUE
	return FALSE

/obj/item/toy/eightball/attack_self(mob/user)
	if(..())
		return

	. = TRUE
	if(shaking)
		return

	if(on_cooldown)
		to_chat(user, span_warning("[src]刚被摇过，需要一点时间平静下来。"))
		return

	user.visible_message(span_notice("[user]开始摇晃[src]。"), span_notice("你开始摇晃[src]。"), span_hear("你听见摇晃和液体晃动的声音。"))

	shaking = TRUE

	if (!start_shaking(user))
		return

	if(do_after(user, shake_time))
		say(get_answer())

		on_cooldown = TRUE
		addtimer(VARSET_CALLBACK(src, on_cooldown, FALSE), cooldown_time)

	shaking = FALSE

/obj/item/toy/eightball/proc/start_shaking(mob/user)
	return TRUE

/// Different from get_answer().
/obj/item/toy/eightball/proc/pick_from_answer_list()
	//! This is for grabbing an answer from the answer matrix.
	var/key = pick(possible_answers)
	return pick(possible_answers[key])

/obj/item/toy/eightball/proc/get_answer()
	return pick_from_answer_list()

// A broken magic eightball, it only says "YOU SUCK" over and over again.

/obj/item/toy/eightball/broken
	name = "损坏的魔法八号球"
	desc = "一颗侧面印着白色数字8的黑球。它裂开了，里面似乎是空的。"
	var/fixed_answer

/obj/item/toy/eightball/broken/Initialize(mapload)
	. = ..()
	fixed_answer = pick_from_answer_list()

/obj/item/toy/eightball/broken/get_answer()
	return fixed_answer

// Haunted eightball is identical in description and function to toy,
// except it actually ASKS THE DEAD (wooooo)

/obj/item/toy/eightball/haunted
	shake_time = 30 SECONDS
	cooldown_time = 3 MINUTES
	var/selected_message = "没什么！"
	//these kind of store the same thing but one is easier to work with.
	var/list/votes = list()
	var/list/voted = list()

/obj/item/toy/eightball/haunted/Initialize(mapload)
	. = ..()
	for (var/answer in possible_answers)
		votes[answer] = 0
	SSpoints_of_interest.make_point_of_interest(src)

/obj/item/toy/eightball/haunted/MakeHaunted()
	return FALSE

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/item/toy/eightball/haunted/attack_ghost(mob/user)
	if(!shaking)
		to_chat(user, span_warning("现在没有人摇晃[src]。"))
		return
	interact(user)
	return ..()

/obj/item/toy/eightball/haunted/start_shaking(mob/user)
	// notify ghosts that someone's shaking a haunted eightball
	// and inform them of the message, (hopefully a yes/no question)
	selected_message = tgui_input_text(user, "你想问什么？", "八号球", max_length = CHAT_MESSAGE_MAX_LENGTH) || initial(selected_message)
	if (!(src in user.held_items))
		return FALSE
	notify_ghosts(
		"[user.real_name]正在摇晃[src]，希望得到\"[selected_message]\"的答案",
		source = src,
		header = "魔法八号球",
		click_interact = TRUE,
	)
	return TRUE

/obj/item/toy/eightball/haunted/get_answer()
	var/top_amount = 0
	var/top_vote

	for(var/vote in votes)
		var/amount_of_votes = votes[vote]
		if(amount_of_votes > top_amount)
			top_vote = vote
			top_amount = amount_of_votes
		//If one option actually has votes and there's a tie, pick between them 50/50
		else if(top_amount && amount_of_votes == top_amount && prob(50))
			top_vote = vote
			top_amount = amount_of_votes

	if(isnull(top_vote))
		top_vote = pick(votes)

	for(var/vote in votes)
		votes[vote] = 0

	voted.Cut()

	var/list/top_options = possible_answers[top_vote]
	return pick(top_options)

// Only ghosts can interact because only ghosts can open the ui
/obj/item/toy/eightball/haunted/can_interact(mob/living/user)
	return isobserver(user)

/obj/item/toy/eightball/haunted/ui_state(mob/user)
	return GLOB.observer_state

/obj/item/toy/eightball/haunted/ui_interact(mob/user, datum/tgui/ui)
	if(!isobserver(user))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "EightBallVote", name)
		ui.open()

/obj/item/toy/eightball/haunted/ui_data(mob/user)
	var/list/data = list()
	data["shaking"] = shaking
	data["question"] = selected_message

	data["answers"] = list()
	for(var/vote in possible_answers)
		var/list/answer_data = list()
		answer_data["answer"] = vote
		answer_data["amount"] = votes[vote]
		answer_data["selected"] = (voted[user.ckey] == vote)

		data["answers"] += list(answer_data)
	return data

/obj/item/toy/eightball/haunted/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/user = usr

	switch(action)
		if("vote")
			var/selected_answer = params["answer"]
			if(!(selected_answer in possible_answers))
				return
			var/oldvote = voted[user.ckey]
			if(oldvote)
				// detract their old vote
				votes[oldvote] -= 1

			votes[selected_answer] += 1
			voted[user.ckey] = selected_answer
			return TRUE
