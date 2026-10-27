//Brain traumas that are rare and/or somewhat beneficial;
//they are the easiest to cure, which means that if you want
//to keep them, you can't cure your other traumas
/datum/brain_trauma/special
	abstract_type = /datum/brain_trauma/special

/datum/brain_trauma/special/godwoken
	name = "神谕综合征"
	desc = "患者说话时偶尔会不受控制地传达某位异界神祇的意志。"
	scan_desc = "神明妄想"
	symptoms = "偶尔以命令的口吻说出话语或指令，往往伴随着神圣的威严。\
		这些话语能够影响他人的行为，迫使他们遵从其中的指示。"
	gain_text = span_notice("你感到某种更高的力量存在于自己的脑海中……")
	lose_text = span_warning("神明不再感兴趣，离开了你的脑海。")

/datum/brain_trauma/special/godwoken/on_life(seconds_per_tick)
	..()
	if(SPT_PROB(2, seconds_per_tick))
		if(prob(33) && (owner.IsStun() || owner.IsParalyzed() || owner.IsUnconscious()))
			speak("unstun", TRUE)
		else if(prob(60) && owner.health <= owner.crit_threshold)
			speak("heal", TRUE)
		else if(prob(30) && owner.combat_mode)
			speak("aggressive")
		else
			speak("neutral", prob(25))

/datum/brain_trauma/special/godwoken/on_gain()
	ADD_TRAIT(owner, TRAIT_HOLY, TRAUMA_TRAIT)
	. = ..()

/datum/brain_trauma/special/godwoken/on_lose()
	REMOVE_TRAIT(owner, TRAIT_HOLY, TRAUMA_TRAIT)
	..()

/datum/brain_trauma/special/godwoken/proc/speak(type, include_owner = FALSE)
	var/message
	switch(type)
		if("unstun")
			message = pick_list_replacements(BRAIN_DAMAGE_FILE, "god_unstun")
		if("heal")
			message = pick_list_replacements(BRAIN_DAMAGE_FILE, "god_heal")
		if("neutral")
			message = pick_list_replacements(BRAIN_DAMAGE_FILE, "god_neutral")
		if("aggressive")
			message = pick_list_replacements(BRAIN_DAMAGE_FILE, "god_aggressive")
		else
			message = pick_list_replacements(BRAIN_DAMAGE_FILE, "god_neutral")

	playsound(get_turf(owner), 'sound/effects/magic/clockwork/invoke_general.ogg', 200, TRUE, 5)
	voice_of_god(message, owner, list("colossus","yell"), 2.5, include_owner, name, TRUE)

/datum/brain_trauma/special/bluespace_prophet
	name = "蓝空间预知"
	desc = "患者能感知周围蓝空间的起伏，发现其他人看不见的通道。"
	scan_desc = "蓝空间共鸣"
	symptoms = "能够感知蓝空间中的隐秘通道，自发形成连接两个远处地点的临时传送门。\
		在普通人眼中，患者似乎凭空消失，随后出现在附近的另一处。"
	gain_text = span_notice("你感到周围的蓝空间正在脉动……")
	lose_text = span_warning("蓝空间微弱的脉动逐渐归于沉寂。")
	/// Cooldown so we can't teleport literally everywhere on a whim
	COOLDOWN_DECLARE(portal_cooldown)

/datum/brain_trauma/special/bluespace_prophet/on_life(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, portal_cooldown))
		return

	COOLDOWN_START(src, portal_cooldown, 10 SECONDS)
	var/list/turf/possible_turfs = list()
	for(var/turf/T as anything in RANGE_TURFS(8, owner))
		if(T.density)
			continue

		var/clear = TRUE
		for(var/obj/O in T)
			if(O.density)
				clear = FALSE
				break
		if(clear)
			possible_turfs += T

	if(!LAZYLEN(possible_turfs))
		return

	var/turf/first_turf = pick(possible_turfs)
	if(!first_turf)
		return

	possible_turfs -= (possible_turfs & range(first_turf, 3))

	var/turf/second_turf = pick(possible_turfs)
	if(!second_turf)
		return

	var/obj/effect/client_image_holder/bluespace_stream/first = new(first_turf, owner)
	var/obj/effect/client_image_holder/bluespace_stream/second = new(second_turf, owner)

	first.linked_to = second
	second.linked_to = first

/obj/effect/client_image_holder/bluespace_stream
	name = "蓝空间流"
	desc = "你看见一条穿越蓝空间的隐秘通道……"
	image_icon = 'icons/effects/effects.dmi'
	image_state = "bluestream"
	image_layer = ABOVE_MOB_LAYER
	var/obj/effect/client_image_holder/bluespace_stream/linked_to

/obj/effect/client_image_holder/bluespace_stream/Initialize(mapload, list/mobs_which_see_us)
	. = ..()
	QDEL_IN(src, 30 SECONDS)

/obj/effect/client_image_holder/bluespace_stream/generate_image()
	. = ..()
	apply_wibbly_filters(.)

/obj/effect/client_image_holder/bluespace_stream/Destroy()
	if(!QDELETED(linked_to))
		qdel(linked_to)
	linked_to = null
	return ..()

/obj/effect/client_image_holder/bluespace_stream/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(!(user in who_sees_us) || !linked_to)
		return

	var/slip_in_message = pick("古怪地向侧面滑动，然后消失了", "跳进了一个看不见的维度",\
		"伸直一条腿，晃了晃脚，然后突然消失了", "停下脚步，然后瞬间消失在现实之中", \
		"被卷进了看不见的漩涡，消失在视野中")
	var/slip_out_message = pick("无声地显现出来", "凭空跳了出来","出现了", "从看不见的门口走了出来",\
		"从时空的褶皱中滑了出来")

	to_chat(user, span_notice("你试着与蓝空间流同步……"))
	if(!do_after(user, 2 SECONDS, target = src))
		return

	var/turf/source_turf = get_turf(src)
	var/turf/destination_turf = get_turf(linked_to)

	new /obj/effect/temp_visual/bluespace_fissure(source_turf)
	new /obj/effect/temp_visual/bluespace_fissure(destination_turf)

	user.visible_message(span_warning("[user][slip_in_message]。"), ignored_mobs = user)

	if(do_teleport(user, destination_turf, no_effects = TRUE))
		user.visible_message(span_warning("[user][slip_out_message]。"), span_notice("……并成功抵达了另一端。"))
	else
		user.visible_message(span_warning("[user][slip_out_message]，却回到了原地。"), span_notice("……却发现自己还在原地？"))


/obj/effect/client_image_holder/bluespace_stream/attack_tk(mob/user)
	to_chat(user, span_warning("[src]排斥着你的意念，周围的蓝空间能量干扰了你的念动力！"))
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/brain_trauma/special/quantum_alignment
	name = "量子同步"
	desc = "患者常常发生极不可能的自发量子纠缠，造成空间异常。"
	scan_desc = "量子同步"
	symptoms = "频繁与附近的物体或生物发生自发量子纠缠，\
		导致突发且无法预测的传送，将患者送到纠缠目标处。"
	gain_text = span_notice("你隐约感觉自己与周围的一切相连……")
	lose_text = span_warning("你不再感觉自己与周围的事物相连。")
	var/atom/linked_target = null
	var/linked = FALSE
	var/returning = FALSE
	/// Cooldown for snapbacks
	COOLDOWN_DECLARE(snapback_cooldown)

/datum/brain_trauma/special/quantum_alignment/on_life(seconds_per_tick)
	if(linked)
		if(QDELETED(linked_target))
			linked_target = null
			linked = FALSE
			return
		if(!returning && COOLDOWN_FINISHED(src, snapback_cooldown))
			start_snapback()
		return
	if(SPT_PROB(2, seconds_per_tick))
		try_entangle()

/datum/brain_trauma/special/quantum_alignment/proc/try_entangle()
	//Check for pulled mobs
	if(ismob(owner.pulling))
		entangle(owner.pulling)
		return
	//Check for adjacent mobs
	for(var/mob/living/L in oview(1, owner))
		if(owner.Adjacent(L))
			entangle(L)
			return
	//Check for pulled objects
	if(isobj(owner.pulling))
		entangle(owner.pulling)
		return

	//Check main hand
	var/obj/item/held_item = owner.get_active_held_item()
	if(held_item && !(HAS_TRAIT(held_item, TRAIT_NODROP)))
		entangle(held_item)
		return

	//Check off hand
	held_item = owner.get_inactive_held_item()
	if(held_item && !(HAS_TRAIT(held_item, TRAIT_NODROP)))
		entangle(held_item)
		return

	//Just entangle with the turf
	entangle(get_turf(owner))

/datum/brain_trauma/special/quantum_alignment/proc/entangle(atom/target)
	to_chat(owner, span_notice("你开始感觉自己与[target]有着强烈的联系。"))
	linked_target = target
	linked = TRUE
	COOLDOWN_START(src, snapback_cooldown, rand(45 SECONDS, 10 MINUTES))

/datum/brain_trauma/special/quantum_alignment/proc/start_snapback()
	if(QDELETED(linked_target))
		linked_target = null
		linked = FALSE
		return
	to_chat(owner, span_warning("你与[linked_target]的联系突然变得极为强烈……你能感觉到它在拉扯你！"))
	owner.playsound_local(owner, 'sound/effects/magic/lightning_chargeup.ogg', 75, FALSE)
	returning = TRUE
	addtimer(CALLBACK(src, PROC_REF(snapback)), 10 SECONDS)

/datum/brain_trauma/special/quantum_alignment/proc/snapback()
	returning = FALSE
	if(QDELETED(linked_target))
		to_chat(owner, span_notice("联系骤然消失，拉力也随之散去。"))
		linked_target = null
		linked = FALSE
		return
	to_chat(owner, span_warning("你被拉着穿越了时空！"))
	do_teleport(owner, get_turf(linked_target), null, channel = TELEPORT_CHANNEL_QUANTUM)
	owner.playsound_local(owner, 'sound/effects/magic/repulse.ogg', 100, FALSE)
	linked_target = null
	linked = FALSE

/datum/brain_trauma/special/psychotic_brawling
	name = "暴力型精神病"
	desc = "患者的战斗方式难以预测，可能帮助目标，也可能用蛮力猛击对方。"
	scan_desc = "暴力型精神病"
	symptoms = "与他人发生身体接触时，行为反复无常且可能具有暴力倾向，\
		常常意外攻击本想帮助的人，或拥抱本想殴打的人。"
	gain_text = span_warning("你感到自己失去了理智……")
	lose_text = span_notice("你感到情绪稳定了一些。")
	/// The martial art we teach
	var/datum/martial_art/psychotic_brawling/psychotic_brawling

/datum/brain_trauma/special/psychotic_brawling/on_gain()
	. = ..()
	psychotic_brawling = new(src)
	psychotic_brawling.locked_to_use = TRUE
	psychotic_brawling.teach(owner)

/datum/brain_trauma/special/psychotic_brawling/on_lose()
	. = ..()
	QDEL_NULL(psychotic_brawling)

/datum/brain_trauma/special/psychotic_brawling/bath_salts
	name = "药物诱发暴力型精神病"
	known_trauma = FALSE

/datum/brain_trauma/special/tenacity
	name = "坚韧"
	desc = "患者在精神上不受疼痛和伤势影响，能比常人坚持站立更久。"
	scan_desc = "创伤性神经病变"
	symptoms = "对疼痛和身体创伤表现出惊人的耐受力，\
		即使受到足以使常人失去行动能力的重伤，也能继续活动。"
	gain_text = span_warning("你突然感觉不到疼痛了。")
	lose_text = span_warning("你意识到自己又能感觉到疼痛了。")

/datum/brain_trauma/special/tenacity/on_gain()
	owner.add_traits(list(TRAIT_NOSOFTCRIT, TRAIT_NOHARDCRIT, TRAIT_ANALGESIA), TRAUMA_TRAIT)
	. = ..()

/datum/brain_trauma/special/tenacity/on_lose()
	owner.remove_traits(list(TRAIT_NOSOFTCRIT, TRAIT_NOHARDCRIT, TRAIT_ANALGESIA), TRAUMA_TRAIT)
	..()

/datum/brain_trauma/special/death_whispers
	name = "功能性脑坏死"
	desc = "患者的大脑停留在仍能运作的濒死状态，偶尔产生清晰的幻觉，常被理解为死者的声音。"
	scan_desc = "慢性功能性坏死"
	symptoms = "间歇性出现以低语为特征的幻听，\
		常被认为是来自死者的交流。"
	gain_text = span_warning("你感到内心已经死去。")
	lose_text = span_notice("你感觉自己又活过来了。")
	var/active = FALSE

/datum/brain_trauma/special/death_whispers/on_life()
	..()
	if(!active && prob(2))
		whispering()

/datum/brain_trauma/special/death_whispers/on_lose()
	if(active)
		cease_whispering()
	..()

/datum/brain_trauma/special/death_whispers/proc/whispering()
	ADD_TRAIT(owner, TRAIT_SIXTHSENSE, TRAUMA_TRAIT)
	active = TRUE
	addtimer(CALLBACK(src, PROC_REF(cease_whispering)), rand(5 SECONDS, 30 SECONDS))

/datum/brain_trauma/special/death_whispers/proc/cease_whispering()
	REMOVE_TRAIT(owner, TRAIT_SIXTHSENSE, TRAUMA_TRAIT)
	active = FALSE

/datum/brain_trauma/special/existential_crisis
	name = "存在危机"
	desc = "患者与现实的联系变得薄弱，偶尔会暂时不复存在。"
	scan_desc = "存在危机"
	symptoms = "偶尔出现“不存在”的发作，患者暂时淡出现实，\
		变得无形且无法被他人看见。通常伴有疏离、抑郁和迷失感。"
	gain_text = span_warning("你感觉自己不那么真实了。")
	lose_text = span_notice("你感觉自己又变得真实了。")
	var/obj/effect/abstract/sync_holder/veil/veil
	/// A cooldown to prevent constantly erratic dolphining through the fabric of reality
	COOLDOWN_DECLARE(crisis_cooldown)

/datum/brain_trauma/special/existential_crisis/on_life(seconds_per_tick)
	..()
	if(!veil && COOLDOWN_FINISHED(src, crisis_cooldown) && SPT_PROB(1.5, seconds_per_tick))
		if(isturf(owner.loc))
			fade_out()

/datum/brain_trauma/special/existential_crisis/on_lose()
	if(veil)
		fade_in()
	..()

/datum/brain_trauma/special/existential_crisis/proc/fade_out()
	if(veil)
		return
	var/duration = rand(5 SECONDS, 45 SECONDS)
	veil = new(owner.drop_location())
	to_chat(owner, span_warning("[pick(list(
			"你真的存在吗？",
			"存在，还是不存在……",
			"为什么要存在？",
			"你就这样消散了。",
			"你不再维持自己的真实。",
			"你停止了片刻思考。因此，你不复存在。",
		))]"))
	owner.forceMove(veil)
	COOLDOWN_START(src, crisis_cooldown, 1 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(fade_in)), duration)

/datum/brain_trauma/special/existential_crisis/proc/fade_in()
	QDEL_NULL(veil)
	to_chat(owner, span_notice("你重新显现在现实中。"))
	COOLDOWN_START(src, crisis_cooldown, 1 MINUTES)

//base sync holder is in desynchronizer.dm
/obj/effect/abstract/sync_holder/veil
	name = "虚无"
	desc = "存在不过是一种心境。"

/datum/brain_trauma/special/beepsky
	name = "罪犯"
	desc = "患者似乎是一名罪犯。"
	scan_desc = "犯罪心理"
	gain_text = span_warning("正义正在向你逼近。")
	lose_text = span_notice("你的罪行得到了赦免。")
	random_gain = FALSE
	known_trauma = FALSE
	/// A ref to our fake beepsky image that we chase the owner with
	var/obj/effect/client_image_holder/securitron/beepsky

/datum/brain_trauma/special/beepsky/Destroy()
	QDEL_NULL(beepsky)
	return ..()

/datum/brain_trauma/special/beepsky/on_gain()
	create_securitron()
	return ..()

/datum/brain_trauma/special/beepsky/proc/create_securitron()
	QDEL_NULL(beepsky)
	var/turf/where = locate(owner.x + pick(-12, 12), owner.y + pick(-12, 12), owner.z)
	beepsky = new(where, owner)

/datum/brain_trauma/special/beepsky/on_lose()
	QDEL_NULL(beepsky)
	return ..()

/datum/brain_trauma/special/beepsky/on_life()
	if(QDELETED(beepsky) || !beepsky.loc || beepsky.z != owner.z)
		if(prob(30))
			create_securitron()
		else
			return

	if(get_dist(owner, beepsky) >= 10 && prob(20))
		create_securitron()

	if(IS_UNCONSCIOUS_OR_CRIT(owner))
		if(prob(20))
			owner.playsound_local(beepsky, 'sound/mobs/non-humanoids/beepsky/iamthelaw.ogg', 50)
		return

	if(get_dist(owner, beepsky) <= 1)
		owner.playsound_local(owner, 'sound/items/weapons/egloves.ogg', 50)
		owner.visible_message(span_warning("[owner]的身体像触电一样抽搐。"), span_userdanger("你感受到了法律的铁拳。"))
		owner.adjust_stamina_loss(rand(40, 70))
		QDEL_NULL(beepsky)

	if(prob(20) && get_dist(owner, beepsky) <= 8)
		owner.playsound_local(beepsky, 'sound/mobs/non-humanoids/beepsky/criminal.ogg', 40)

/obj/effect/client_image_holder/securitron
	name = "安保机器人"
	desc = "法律正在逼近。"
	image_icon = 'icons/mob/silicon/aibots.dmi'
	image_state = "secbot-c"

/obj/effect/client_image_holder/securitron/Initialize(mapload)
	. = ..()
	name = pick("毕普斯基警官", "约翰逊警官", "平斯基警官")
	START_PROCESSING(SSfastprocess, src)

/obj/effect/client_image_holder/securitron/Destroy()
	STOP_PROCESSING(SSfastprocess,src)
	return ..()

/obj/effect/client_image_holder/securitron/process()
	if(prob(40))
		return

	var/mob/victim = pick(who_sees_us)
	forceMove(get_step_towards(src, victim))
	if(prob(5))
		var/beepskys_cry = "十级违规警报！"
		to_chat(victim, "[span_name("[name]")]喊道：“[span_robot("[beepskys_cry]")]”")
		if(victim.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
			victim.create_chat_message(src, raw_message = beepskys_cry, spans = list(SPAN_ROBOT))

// Used by Veteran Security Advisor job.
/datum/brain_trauma/special/ptsd
	name = "战斗创伤后应激障碍"
	desc = "患者因过去的战斗经历而患有创伤后应激障碍，导致情感缺失，并伴有轻度幻觉。"
	scan_desc = "创伤后应激障碍"
	symptoms = "目睹或经历过创伤、恐怖或可能危及生命的事件，\
		导致回避行为、侵入性思维、闪回、幻听、\
		情感麻木、与他人疏离，以及对刺激的反应增强，\
		尤其是在让人联想到创伤事件的情境中。"

	gain_text = span_warning("你被抛回了过去的混乱之中！爆炸！枪火！情感，不知所踪！")
	lose_text = span_notice("随着情感恢复、头脑清醒，过去的闪回逐渐消退。")
	resilience = TRAUMA_RESILIENCE_ABSOLUTE
	can_gain = TRUE
	random_gain = FALSE
	/// Our cooldown declare for causing hallucinations
	COOLDOWN_DECLARE(ptsd_hallucinations)
	var/list/ptsd_hallucinations_list = list(
		/datum/hallucination/fake_sound/normal/boom,
		/datum/hallucination/fake_sound/normal/distant_boom,
		/datum/hallucination/stray_bullet,
		/datum/hallucination/battle/gun/disabler,
		/datum/hallucination/battle/gun/laser,
		/datum/hallucination/battle/bomb,
		/datum/hallucination/battle/e_sword,
		/datum/hallucination/battle/harm_baton,
		/datum/hallucination/battle/stun_prod,
	)

/datum/brain_trauma/special/ptsd/on_life(seconds_per_tick)
	if(IS_UNCONSCIOUS_OR_CRIT(owner))
		return

	if(!COOLDOWN_FINISHED(src, ptsd_hallucinations))
		return

	owner.cause_hallucination(pick(ptsd_hallucinations_list), "Caused by The Combat PTSD brain trauma")
	COOLDOWN_START(src, ptsd_hallucinations, rand(10 SECONDS, 10 MINUTES))

/datum/brain_trauma/special/ptsd/on_gain()
	owner.add_mood_event("combat_ptsd", /datum/mood_event/desentized)
	owner.mob_mood?.mood_modifier -= 1 //Basically nothing can change your mood
	owner.mob_mood?.set_sanity(SANITY_DISTURBED, override = TRUE) //Makes sanity on a unstable level unless cured
	owner.apply_status_effect(/datum/status_effect/desensitized, REF(src), DESENSITIZED_THRESHOLD)
	. = ..()

/datum/brain_trauma/special/ptsd/on_lose()
	owner.clear_mood_event("combat_ptsd")
	owner.mob_mood?.mood_modifier += 1
	owner.mob_mood?.set_sanity(SANITY_GREAT, override = TRUE)
	owner.remove_status_effect(/datum/status_effect/desensitized, REF(src))
	return ..()

/datum/brain_trauma/special/primal_instincts
	name = "野兽本能"
	desc = "患者的思维停留在原始状态，行事依靠本能而非理性。"
	scan_desc = "兽性"
	symptoms = "偶尔出现高级认知功能受到抑制的发作，\
		行为主要由原始本能驱使。在发作期间，\
		患者可能表现出更强的攻击性、领地意识，以及对基本生存需求的关注。"
	gain_text = span_warning("你的瞳孔扩张，越来越难以清晰思考。")
	lose_text = span_notice("你的头脑清醒了，感觉更能掌控自己。")
	resilience = TRAUMA_RESILIENCE_SURGERY
	/// Tracks any existing AI controller, so we can restore it when we're cured
	var/old_ai_controller_type

/datum/brain_trauma/special/primal_instincts/on_gain()
	. = ..()
	if(!isnull(owner.ai_controller))
		old_ai_controller_type = owner.ai_controller.type
		QDEL_NULL(owner.ai_controller)

	owner.ai_controller = new /datum/ai_controller/monkey(owner)
	owner.ai_controller.continue_processing_when_client = TRUE
	owner.ai_controller.ai_traits |= RUN_WHILE_UNWATCHED
	owner.ai_controller.force_ai_off()

/datum/brain_trauma/special/primal_instincts/on_lose(silent)
	. = ..()
	if(QDELING(owner))
		return

	QDEL_NULL(owner.ai_controller)
	if(old_ai_controller_type)
		owner.ai_controller = new old_ai_controller_type(owner)
	owner.remove_language(/datum/language/monkey, UNDERSTOOD_LANGUAGE, TRAUMA_TRAIT)

/datum/brain_trauma/special/primal_instincts/on_life(seconds_per_tick)
	if(isnull(owner.ai_controller))
		qdel(src)
		return

	if(!SPT_PROB(3, seconds_per_tick))
		return

	owner.grant_language(/datum/language/monkey, UNDERSTOOD_LANGUAGE, TRAUMA_TRAIT)
	owner.ai_controller.set_blackboard_key(BB_MONKEY_AGGRESSIVE, prob(75))
	if(owner.ai_controller.ai_status == AI_STATUS_OFF)
		owner.ai_controller.clear_forced_off()
		owner.log_message("became controlled by monkey instincts ([owner.ai_controller.blackboard[BB_MONKEY_AGGRESSIVE] ? "aggressive" : "docile"])", LOG_ATTACK, color = "orange")
		to_chat(owner, span_warning("你感到一股遵循原始本能行动的冲动……"))
	// extend original timer if we roll the effect while it's already ongoing
	addtimer(CALLBACK(src, PROC_REF(primal_instincts_off)), rand(20 SECONDS, 40 SECONDS), TIMER_UNIQUE|TIMER_NO_HASH_WAIT|TIMER_OVERRIDE|TIMER_DELETE_ME)

/datum/brain_trauma/special/primal_instincts/proc/primal_instincts_off()
	owner.ai_controller.force_ai_off()
	owner.remove_language(/datum/language/monkey, UNDERSTOOD_LANGUAGE, TRAUMA_TRAIT)
	to_chat(owner, span_green("冲动消退了。"))

/datum/brain_trauma/special/axedoration
	name = "斧头妄想"
	desc = "患者对保护一把斧头怀有极强的责任感，并产生与其相关的幻觉。"
	scan_desc = "物品依恋"
	gain_text = span_notice("你觉得保护消防斧是自己最重要的职责之一。")
	lose_text = span_warning("你觉得自己失去了责任感。")
	resilience = TRAUMA_RESILIENCE_ABSOLUTE
	random_gain = FALSE
	known_trauma = FALSE
	var/static/list/talk_lines = list(
		"我为你感到骄傲。",
		"我相信你！",
		"我打扰到你了吗？",
		"夸奖我吧！",
		"烈火灼烧。",
		"我们做到了！",
		"母亲，我厌恶自己的身体。",
		"在我们相遇之处，在我结束而你开始之处，有一道鸿沟。",
		"谦卑一些。",
	)
	var/static/list/hurt_lines = list(
		"哎呀！",
		"好痛！",
		"呃啊！",
		"好烫！",
		"停下！",
		"啊啊！",
		"求你了！",
		"结束这一切！",
		"住手！",
		"啊！",
	)

/datum/brain_trauma/special/axedoration/on_life(seconds_per_tick)
	if(IS_UNCONSCIOUS_OR_CRIT(owner))
		return

	if(!GLOB.bridge_axe)
		if(SPT_PROB(0.5, seconds_per_tick))
			to_chat(owner, span_warning("我辜负了自己的职责……"))
			owner.set_jitter_if_lower(5 SECONDS)
			owner.set_stutter_if_lower(5 SECONDS)
			if(SPT_PROB(20, seconds_per_tick))
				owner.vomit(VOMIT_CATEGORY_DEFAULT)
		return

	var/atom/axe_location = get_axe_location()
	if(!SPT_PROB(1.5, seconds_per_tick))
		return
	if(isliving(axe_location))
		var/mob/living/axe_holder = axe_location
		if(axe_holder == owner)
			talk_tuah(pick(talk_lines))
			return
		var/datum/job/holder_job = axe_holder.mind?.assigned_role
		if(holder_job && (/datum/job_department/command in holder_job.departments_list))
			to_chat(owner, span_notice("希望这把斧头得到了妥善照顾……"))
			owner.add_mood_event("fireaxe", /datum/mood_event/axe_neutral)
			return
		to_chat(owner, span_warning("你开始有种不祥的预感……"))
		owner.add_mood_event("fireaxe", /datum/mood_event/axe_missing)
		return

	if(!isarea(axe_location))
		owner.add_mood_event("fireaxe", /datum/mood_event/axe_gone)
		return

	if(istype(axe_location, /area/station/command))
		to_chat(owner, span_notice("你松了一口气……"))
		if(istype(GLOB.bridge_axe.loc, /obj/structure/fireaxecabinet))
			return
		owner.add_mood_event("fireaxe", /datum/mood_event/axe_neutral)
		return

	to_chat(owner, span_warning("你开始有种不祥的预感……"))
	owner.add_mood_event("fireaxe", /datum/mood_event/axe_missing)

/datum/brain_trauma/special/axedoration/on_gain()
	RegisterSignal(owner, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_equip))
	RegisterSignal(owner, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(on_unequip))
	RegisterSignal(owner, COMSIG_MOB_EXAMINING, PROC_REF(on_examine))
	if(!GLOB.bridge_axe)
		axe_gone()
		return ..()
	RegisterSignal(GLOB.bridge_axe, COMSIG_QDELETING, PROC_REF(axe_gone))
	if(istype(get_axe_location(), /area/station/command) && istype(GLOB.bridge_axe.loc, /obj/structure/fireaxecabinet))
		owner.add_mood_event("fireaxe", /datum/mood_event/axe_cabinet)
	else if(owner.is_holding(GLOB.bridge_axe))
		on_equip(owner, GLOB.bridge_axe)
	else
		owner.add_mood_event("fireaxe", /datum/mood_event/axe_neutral)
	RegisterSignal(GLOB.bridge_axe, COMSIG_ITEM_AFTERATTACK, PROC_REF(on_axe_attack))
	return ..()


/datum/brain_trauma/special/axedoration/on_lose()
	owner.clear_mood_event("fireaxe")
	UnregisterSignal(owner, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_MOB_UNEQUIPPED_ITEM, COMSIG_MOB_EXAMINING))
	if(GLOB.bridge_axe)
		UnregisterSignal(GLOB.bridge_axe, COMSIG_ITEM_AFTERATTACK)
	return ..()

/datum/brain_trauma/special/axedoration/proc/axe_gone(source)
	SIGNAL_HANDLER
	to_chat(owner, span_danger("你感到原力发生了巨大的扰动。"))
	owner.add_mood_event("fireaxe", /datum/mood_event/axe_gone)
	owner.set_jitter_if_lower(15 SECONDS)
	owner.set_stutter_if_lower(15 SECONDS)

/datum/brain_trauma/special/axedoration/proc/on_equip(source, obj/item/picked_up, slot)
	SIGNAL_HANDLER
	if(!istype(picked_up, /obj/item/fireaxe))
		return
	owner.set_jitter_if_lower(3 SECONDS)
	if(picked_up == GLOB.bridge_axe)
		to_chat(owner, span_hypnophrase("我拿到了。该把它放回去了。"))
		owner.add_mood_event("fireaxe", /datum/mood_event/axe_held)
		return
	ADD_TRAIT(picked_up, TRAIT_NODROP, type)
	to_chat(owner, span_warning("……这不是我要守护的那把斧头。"))
	owner.Immobilize(2 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(throw_faker), picked_up), 2 SECONDS)

/datum/brain_trauma/special/axedoration/proc/throw_faker(obj/item/faker)
	REMOVE_TRAIT(faker, TRAIT_NODROP, type)
	var/held_index = owner.get_held_index_of_item(faker)
	if(!held_index)
		return
	to_chat(owner, span_warning("滚开吧。"))
	owner.swap_hand(held_index, silent = TRUE)
	var/turf/target_turf = get_ranged_target_turf(owner, owner.dir, faker.throw_range)
	owner.throw_item(target_turf)

/datum/brain_trauma/special/axedoration/proc/on_unequip(datum/source, obj/item/dropped_item, force, new_location)
	SIGNAL_HANDLER
	if(dropped_item != GLOB.bridge_axe)
		return
	if(get_axe_location() == owner)
		return
	if(istype(new_location, /obj/structure/fireaxecabinet))
		if(istype(get_area(new_location), /area/station/command))
			to_chat(owner, span_nicegreen("啊！物归原位了！"))
			owner.add_mood_event("fireaxe", /datum/mood_event/axe_cabinet)
			INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "smile")
			return
		to_chat(owner, span_warning("把它留在指挥区外？我真的确定吗？"))
		owner.add_mood_event("fireaxe", /datum/mood_event/axe_neutral)
		return
	to_chat(owner, span_warning("我真的应该把它留在这里吗？"))
	owner.add_mood_event("fireaxe", /datum/mood_event/axe_neutral)

/datum/brain_trauma/special/axedoration/proc/on_examine(mob/source, atom/target, list/examine_strings, list/examine_overrides)
	SIGNAL_HANDLER
	if(!istype(target, /obj/item/fireaxe))
		return
	if(target == GLOB.bridge_axe)
		examine_strings += span_notice("这就是我发誓要保护的斧头。")
	else
		examine_strings += span_warning("这是仿制品，一把用来欺骗大众的假斧头。")

/datum/brain_trauma/special/axedoration/proc/on_axe_attack(obj/item/axe, atom/target, mob/user, list/modifiers)
	SIGNAL_HANDLER
	if(user != owner)
		return
	talk_tuah(pick(hurt_lines))

/datum/brain_trauma/special/axedoration/proc/talk_tuah(sent_message = "你好，世界。")
	owner.Hear(GLOB.bridge_axe, owner.get_selected_language(), sent_message)

/datum/brain_trauma/special/axedoration/proc/get_axe_location()
	if(!GLOB.bridge_axe)
		return
	var/atom/axe_loc = GLOB.bridge_axe.loc
	while(!ismob(axe_loc) && !isarea(axe_loc) && !isnull(axe_loc))
		axe_loc = axe_loc.loc
	return axe_loc
