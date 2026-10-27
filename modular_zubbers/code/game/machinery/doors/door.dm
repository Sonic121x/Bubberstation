#define LINK_DENY "<a href='byond://?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=deny'>（拒绝）</a>"
#define LINK_OPEN "<a href='byond://?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=open'>（开门）</a>"
#define LINK_BOLT "<a href='byond://?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=bolt'>（落栓）</a>"
#define LINK_SHOCK "<a href='byond://?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=shock'>（通电）</a>"

/obj/machinery/door/airlock
	//so the AI doesn't get spammed
	COOLDOWN_DECLARE(answer_cd)
	/// List of ai door requesters
	var/static/list/requesters = list()

/obj/machinery/door/airlock/attack_hand_secondary(mob/living/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(world.time < requesters[user.name] + 10 SECONDS)
		to_chat(user, span_warning("请稍候，让 AI 处理你的请求。"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(!hasPower())
		to_chat(user, span_warning("这扇门没有供电。"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	src.balloon_alert(user, UNLINT("已请求 AI 协助"))

	for(var/mob/living/silicon/ai/AI as anything in GLOB.ai_list)
		if(AI.stat == DEAD)
			continue
		if(AI.control_disabled)
			continue
		if(AI.deployed_shell)
			if(!is_station_level(AI.deployed_shell.registered_z))
				continue
			SEND_SOUND(AI.deployed_shell, 'sound/machines/synth/synth_no.ogg')
			to_chat(AI.deployed_shell, "<b><a href='byond://?_src_=usr;track=[html_encode(user.name)]'>[user]</a></b>请求你打开[src] [LINK_DENY][LINK_OPEN][LINK_BOLT][LINK_SHOCK]")
		if(!is_station_level(AI.registered_z))
			continue
		to_chat(AI, "<b><a href='byond://?_src_=usr;track=[html_encode(user.name)]'>[user]</a></b>请求你打开[src] [LINK_DENY][LINK_OPEN][LINK_BOLT][LINK_SHOCK]")
		SEND_SOUND(AI, 'sound/machines/synth/synth_no.ogg')
	requesters[user.name] = world.time

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

#undef LINK_DENY
#undef LINK_OPEN
#undef LINK_BOLT
#undef LINK_SHOCK
