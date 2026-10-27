/// This file handles anything related to suicide related to humans, as it's a bit more involved/complex than suicide on any other type of mob.
/// Defines for all the types of messages we can dispatch.
#define HUMAN_BRAIN_DAMAGE_SUICIDE_MESSAGE "brain damaged message"
#define HUMAN_COMBAT_MODE_SUICIDE_MESSAGE "combat mode message"
#define HUMAN_DEFAULT_MODE_SUICIDE_MESSAGE "default mode message"

/mob/living/carbon/human/perform_basic_suicide()
	// if no specific item or damage type we want to deal, default to doing the deed with our own bare hands.
	if(combat_mode)
		send_applicable_messages(HUMAN_COMBAT_MODE_SUICIDE_MESSAGE)
	else
		var/obj/item/organ/brain/userbrain = get_organ_by_type(/obj/item/organ/brain)
		if(userbrain?.damage >= 75)
			send_applicable_messages(HUMAN_BRAIN_DAMAGE_SUICIDE_MESSAGE)
		else
			send_applicable_messages(HUMAN_DEFAULT_MODE_SUICIDE_MESSAGE)

	final_checkout()

/// Any "special" suicide messages are handled by the related item that the mob uses to kill itself. This is just messages for when it's done with the bare hands.
/mob/living/carbon/human/send_applicable_messages(message_type)
	var/suicide_message = ""
	switch(message_type)
		if(HUMAN_BRAIN_DAMAGE_SUICIDE_MESSAGE) // god damn this message is fucking stupid
			suicide_message = "[src] 把双臂在胸前向两侧平举，又向背后一甩，随后在更小的幅度内重复这一动作 \
			一路摆到髋部，如此再来两次，同时让双腿做出假装的行走动作，双手在自己面前拍合 \
			双膝相互碰撞，双臂向下猛压，手腕内旋、手指外展， \
			双腿来回交叉，同时保持双肩低垂、身体佝偻，如此再重复两次 \
			右手比出手指枪，左手叉在髋部，直视前方，左腿向前迈出， \
			双臂交叉、身体略微后仰，双膝歪斜地弯曲！看来 [p_they()] 正试图自杀。"

		if(HUMAN_COMBAT_MODE_SUICIDE_MESSAGE)
			suicide_message = pick(list(
				"[src] 正试图咬断自己的舌头！看来 [p_they()] 想自杀。",
				"[src] 正憋着气不呼吸！看来 [p_they()] 想自杀。",
				"[src] 正把大拇指往自己的眼窝里捅！看来 [p_they()] 想自杀。",
				"[src] 正扭着自己的脖子！看来 [p_they()] 想自杀。",
			))

		if(HUMAN_DEFAULT_MODE_SUICIDE_MESSAGE)
			suicide_message = pick(list(
				"[src] 活得太嗨了！看来 [p_they()] 想自杀。",
				"[src] 正把自己击掌击死！看来 [p_they()] 想自杀。",
				"[src] 正把自己抱死！看来 [p_they()] 想自杀。",
			))

	visible_message(span_danger(suicide_message), span_userdanger(suicide_message), span_hear(get_blind_suicide_message()))

/mob/living/carbon/human/suicide_log(obj/item/suicide_tool)
	var/suicide_tool_type = suicide_tool?.type
	var/list/suicide_data = null // log_message() is nullsafe for the data field
	if(!isnull(suicide_tool))
		suicide_data = list("suicide tool" = suicide_tool_type)
		SSblackbox.record_feedback("tally", "suicide_item", 1, suicide_tool_type)

	investigate_log("已自杀身亡[suicide_tool ? "，使用的工具为 [suicide_tool]（[suicide_tool_type]）" : ""]。", INVESTIGATE_DEATHS)
	log_message("（职务：[src.job ? "[src.job]" : "无"]）自杀了", LOG_ATTACK, data = suicide_data)


#undef HUMAN_BRAIN_DAMAGE_SUICIDE_MESSAGE
#undef HUMAN_COMBAT_MODE_SUICIDE_MESSAGE
#undef HUMAN_DEFAULT_MODE_SUICIDE_MESSAGE
