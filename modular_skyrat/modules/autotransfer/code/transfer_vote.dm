#define CHOICE_TRANSFER "发起船员转移"
#define CHOICE_CONTINUE "继续游戏"

/datum/vote/transfer_vote
	name = "Transfer"
	default_choices = list(
		CHOICE_TRANSFER,
		CHOICE_CONTINUE,
	)
	default_message = "投票发起船员转移。"

/datum/vote/transfer_vote/toggle_votable()
	CONFIG_SET(flag/allow_vote_transfer, !CONFIG_GET(flag/allow_vote_transfer))

/datum/vote/transfer_vote/is_config_enabled()
	return CONFIG_GET(flag/autotransfer) && CONFIG_GET(flag/allow_vote_transfer)

/datum/vote/transfer_vote/can_be_initiated(forced)
	. = ..()
	if(. != VOTE_AVAILABLE)
		return .

	if(forced)
		return VOTE_AVAILABLE

	if(!CONFIG_GET(flag/autotransfer) || !CONFIG_GET(flag/allow_vote_transfer))
		return "船员转移投票已禁用。"

	return VOTE_AVAILABLE

/datum/vote/transfer_vote/finalize_vote(winning_option)
	if(winning_option == CHOICE_CONTINUE)
		return

	if(winning_option == CHOICE_TRANSFER)
		SSshuttle.autoEnd()
		var/obj/machinery/computer/communications/comms_console = locate() in GLOB.shuttle_caller_list
		if(comms_console)
			comms_console.post_status("shuttle")
		return

	CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")

#undef CHOICE_TRANSFER
#undef CHOICE_CONTINUE
