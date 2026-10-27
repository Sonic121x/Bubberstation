
/obj/effect/anomaly/hallucination
	name = "幻觉异常体"
	icon_state = "hallucination"
	anomaly_core = /obj/item/assembly/signaler/anomaly/hallucination
	/// Time passed since the last effect, increased by seconds_per_tick of the SSobj
	var/ticks = 0
	/// How many seconds between each small hallucination pulses
	var/release_delay = 5
	/// Messages sent to people feeling the pulses
	var/static/list/messages = list(
		span_warning("你感觉自己的意识正在崩溃！"),
		span_warning("你周围的现实扭曲了！"),
		span_warning("有什么东西在你周围低语！"),
		span_warning("你快要疯了！"),
	)
	///Do we spawn misleading decoys?
	var/spawn_decoys = TRUE

/obj/effect/anomaly/hallucination/Initialize(mapload, new_lifespan)
	. = ..()
	apply_wibbly_filters(src)
	generate_decoys()

/obj/effect/anomaly/hallucination/anomalyEffect(seconds_per_tick)
	. = ..()
	ticks += seconds_per_tick
	if(ticks < release_delay)
		return
	ticks -= release_delay
	if(!isturf(loc))
		return

	visible_hallucination_pulse(
		center = get_turf(src),
		radius = 5,
		hallucination_duration = 50 SECONDS,
		hallucination_max_duration = 300 SECONDS,
		optional_messages = messages,
	)

/obj/effect/anomaly/hallucination/detonate()
	if(!isturf(loc))
		return

	hallucination_pulse(
		center = get_turf(src),
		radius = 15,
		hallucination_duration = 50 SECONDS,
		hallucination_max_duration = 300 SECONDS,
		optional_messages = messages,
	)

/obj/effect/anomaly/hallucination/proc/generate_decoys()
	if(!spawn_decoys)
		return

	for(var/turf/floor in orange(1, src))
		if(prob(35))
			new /obj/effect/anomaly/hallucination/decoy(floor)

/obj/effect/anomaly/hallucination/decoy
	anomaly_core = null
	///Stores the fake analyzer scan text, so the result is always consistent for each anomaly.
	var/report_text

/obj/effect/anomaly/hallucination/decoy/Initialize(mapload, new_lifespan)
	. = ..()
	ADD_TRAIT(src, TRAIT_ILLUSORY_EFFECT, INNATE_TRAIT)
	report_text = pick(
		"[src]的不稳定场正以频率 9999999.99999 波动，代码为 9999999.99999。不，不对，这怎么可能？",
		"它什么也没检测到，还在等待输入，仿佛你正对着空无一物的地方。什么？",
		"屏幕上显示着[pick("你过去的一段痛苦回忆", "用你看不懂的语言写出的频率数字", "圆周率的前十五位数字", "以四分之三等距视角从背后看去的你自己")]。这是什么鬼？",
		"什么也没发生？",
		"它报告说你是个[pick("蠢货", "白痴", "笨蛋", "人渣", "一无是处的呆瓜", "傻子")]。啊？",
		"它告诉你再试一次，因为你的操作全错了。什么？",
		"你突然意识到，你正在扫描的异常体其实根本不存在。",
		"它没反应。你再次启动%TOOL%。还是坏的。你启动%TOOL%。你启动%TOOL%。为什么它就是不工作？？",
		"发生了什么事。你却说不上来。%TOOL%的屏幕仍然一片空白。",
		"你究竟想在这里干什么？你真的以为这样有用吗？",
		"有人在你身后低声说出频率代码，可你听不清。%TOOL%的屏幕仍然一片空白。",
		"短短一瞬间，你看见自己正穿行于冰封的森林，随后又猛然回到现实。%TOOL%的屏幕仍然一片空白。",
		"什么有意思的事也没发生。你确定自己真的在用它扫描什么东西吗？",
		"有那么一瞬间，你感觉自己的皮肤正在脱落；眨眼间，这种感觉又消失了。这到底是什么意思？",
		"屏幕报告说，你是个彻头彻尾的失败者，又把一切搞砸了。干得漂亮。",
		"你意识到这条消息的格式完全不对，感到一头雾水。这又是为什么呢？",
		"%TOOL%回望着你，似乎很失望。屏幕简直就在说：‘你没对准异常体，蠢货。那里什么都没有！’",
		"毫无反应。奇怪，也许%TOOL%坏了，或者是别的什么原因？",
		"你启动%TOOL%。你启动%TOOL%。你启动%TOOL%。你启动%TOOL%。你启动%TOOL%。你启动%TOOL%。你启动%TOOL%。为什么它就是不工作？？",
	)

/obj/effect/anomaly/hallucination/decoy/anomalyEffect(seconds_per_tick)
#ifndef UNIT_TESTS // These might move away during a CI run and cause a flaky mapping nearstation errors
	if(SPT_PROB(move_chance, seconds_per_tick))
		move_anomaly()
#endif

/obj/effect/anomaly/hallucination/decoy/analyzer_act(mob/living/user, obj/item/analyzer/tool)
	to_chat(user, span_notice("你启动了[tool]。[replacetext(report_text, "%TOOL%", "[tool]")]"))
	return ITEM_INTERACT_BLOCKING

/obj/effect/anomaly/hallucination/decoy/detonate()
	do_sparks(3, source = src)
	return

/obj/effect/anomaly/hallucination/decoy/generate_decoys()
	return

///Subtype for the SM that doesn't spawn decoys, because otherwise the whole area gets flooded with dummies.
/obj/effect/anomaly/hallucination/supermatter
	spawn_decoys = FALSE
