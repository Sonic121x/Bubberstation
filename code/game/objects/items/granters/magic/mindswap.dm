/obj/item/book/granter/action/spell/mindswap
	granted_action = /datum/action/cooldown/spell/pointed/mind_transfer
	action_name = "心智交换"
	icon_state ="bookmindswap"
	desc = "这本书的封面完好如新，书页却破烂不堪。"
	remarks = list(
		"如果你从老鼠体内发动心智交换，等你恢复过来，对方将毫无还手之力……",
		"等等，我在哪儿……？",
		"这本书让我头痛欲裂……",
		"这一页是空白的，我却感觉文字正在脑海里浮现……",
		"基纽……吉罗……呃……",
		"我正读书呢，脑袋里的声音能不能消停一下……",
		"我想没人会乐意看到我施放这个法术……",
	)
	/// Mob used in book recoils to store an identity for mindswaps
	var/datum/weakref/stored_swap_ref

/obj/item/book/granter/action/spell/mindswap/on_reading_finished()
	. = ..()
	visible_message(span_notice("[src]开始摇晃并变化。"))
	action_name = pick(
		"fireball",
		"smoke",
		"blind",
		"forcewall",
		"knock",
		"barnyard",
		"charge",
	)
	icon_state = "book[action_name]"
	name = "[chinese_granter_spell_display(action_name)]法术书"

/obj/item/book/granter/action/spell/mindswap/recoil(mob/living/user)
	. = ..()
	var/mob/living/real_stored_swap = stored_swap_ref?.resolve()
	if(QDELETED(real_stored_swap))
		stored_swap_ref = WEAKREF(user)
		to_chat(user, span_warning("有那么一瞬间，你觉得自己连自己是谁都不知道了。"))
		return
	if(real_stored_swap.stat == DEAD)
		stored_swap_ref = null
		return
	if(real_stored_swap == user)
		to_chat(user, span_notice("你又盯着书看了一会儿，但似乎已经没有更多内容可学了……"))
		return

	var/datum/action/cooldown/spell/pointed/mind_transfer/swapper = new(src)

	if(swapper.swap_minds(user, real_stored_swap))
		to_chat(user, span_warning("你突然身处别处……而且变成了别人？！"))
		to_chat(real_stored_swap, span_warning("你突然又盯着[src]……你在哪里，你又是谁？！"))

	else
		// if the mind_transfer failed to transfer mobs (likely due to the target being catatonic).
		user.visible_message(span_warning("[src]微微嘶响，光芒随之熄灭！"))

	stored_swap_ref = null
