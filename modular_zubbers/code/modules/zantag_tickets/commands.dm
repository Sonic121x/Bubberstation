GAME_VERB(/client, check_antag_tickets, "查看反派票", "OOC")
	var/antag_ticket_rate = CONFIG_GET(number/antag_tickets_per_update)

	if(!antag_ticket_rate)
		to_chat(src,span_notice("反派票系统目前已停用。"))
		return

	var/antag_ticket_count = get_antag_tickets()
	var/antag_ticket_gain = antag_ticket_multiplier()*antag_ticket_rate

	to_chat(src,span_notice("你目前拥有 <b>[antag_ticket_count]</b> 张反派票，并且每 [DisplayTimeText(SSblackbox.wait,1)] [antag_ticket_gain >= 0 ? "获得" : "失去"] <b>[abs(antag_ticket_gain)]</b> 张反派票。"))

GAME_VERB(/client, antag_tickets_info, "什么是反派票？", "OOC")
	var/antag_ticket_rate = CONFIG_GET(number/antag_tickets_per_update)

	if(!antag_ticket_rate)
		to_chat(span_notice("反派票系统目前已停用，因此你无需为它操心。"))
		return

	var/information = "\
	反派票是一种在扮演反派与不扮演反派之间平衡游戏时长的机制。 \
	反派票越多，你就越有可能被选为反派；反派票越少，被选中的可能性就越低。 \
	当你以非反派身份扮演船员角色时会获得反派票，而以反派身份游玩时则会消耗反派票。 \
	请注意，作为反派，当你被铐住、被束缚、死亡、濒死、失去行动能力或入狱时，都不会扣除反派票。"

	to_chat(src,span_notice(information))
