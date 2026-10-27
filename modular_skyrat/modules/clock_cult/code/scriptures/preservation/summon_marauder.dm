#define MAXIMUM_MARAUDERS 2

/datum/scripture/marauder
	name = "召唤发条掠夺者"
	desc = "召唤一名发条掠夺者，这是一种能弹开远程攻击的强大战士。需要 100 点活力。"
	tip = "在战斗变得激烈时，把发条掠夺者当作强力士兵投入战场。"
	button_icon_state = "Clockwork Marauder"
	power_cost = 2000
	vitality_cost = 100
	invocation_time = 30 SECONDS
	invocation_text = list("Through the fires and flames...", "nothing outshines Eng'Ine!")
	category = SPELLTYPE_PRESERVATION
	cogs_required = 6
	invokers_required = 3
	// Ref to the selected observer
	var/mob/dead/observer/selected


/datum/scripture/marauder/Destroy(force, ...)
	selected = null
	return ..()


/datum/scripture/marauder/invoke()
	var/list/candidates = SSpolling.poll_ghost_candidates("你愿意扮演一名发条掠夺者吗？", role = ROLE_PAI, check_jobban = FALSE, poll_time = 10 SECONDS, ignore_category = POLL_IGNORE_CONSTRUCT)
	if(length(candidates))
		selected = pick(candidates)

	if(!selected)
		to_chat(invoker, span_brass("<i>没有幽灵愿意成为发条掠夺者！</i>"))
		invoke_fail()

		if(invocation_chant_timer)
			deltimer(invocation_chant_timer)
			invocation_chant_timer = null

		end_invoke()
		return
	return ..()


/datum/scripture/marauder/invoke_success()
	var/mob/living/basic/clockwork_marauder/new_mob = new (get_turf(invoker))
	new_mob.visible_message(span_notice("[new_mob] 闪烁着现出身形！"))
	new_mob.key = selected.key
	to_chat(new_mob, span_brass("你是一名发条掠夺者！你拥有一面能吸收 [new_mob.shield_health] 点伤害的护盾，可保护你免受任何伤害。若你或你的护盾受损过重，可让仆从用焊接工具修复你。"))
	selected = null


/datum/scripture/marauder/check_special_requirements(mob/user)
	. = ..()
	if(!.)
		return FALSE

	if(length(GLOB.clockwork_marauders) >= MAXIMUM_MARAUDERS)
		to_chat(user, span_brass("你有限的力量使你无法创造超过 [MAXIMUM_MARAUDERS] 名发条掠夺者。"))
		return FALSE

	return TRUE

#undef MAXIMUM_MARAUDERS
