/datum/mutation/antenna
	name = "触角天线"
	desc = "受试者长出一根天线，无需外部设备即可接入公共无线电频道。"
	quality = POSITIVE
	text_gain_indication = span_notice("你感到额头上长出了一根天线。")
	text_lose_indication = span_notice("你的天线缩了回去。")
	instability = POSITIVE_INSTABILITY_MINOR
	difficulty = 8
	mutation_icon_state = "antenna"
	layer_used = FRONT_MUTATIONS_LAYER
	var/datum/weakref/radio_weakref

/obj/item/implant/radio/antenna
	name = "内置天线器官"
	desc = "天线位于体内的器官部分。科学界还没给它起个像样的名字。"
	icon = 'icons/obj/devices/voice.dmi'//maybe make a unique sprite later. not important
	icon_state = "walkietalkie"

/obj/item/implant/radio/antenna/Initialize(mapload)
	. = ..()
	radio.name = "内置天线"

/datum/mutation/antenna/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	var/obj/item/implant/radio/antenna/linked_radio = new(owner)
	linked_radio.implant(owner, null, TRUE, TRUE)
	radio_weakref = WEAKREF(linked_radio)

/datum/mutation/antenna/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	var/obj/item/implant/radio/antenna/linked_radio = radio_weakref.resolve()
	if(linked_radio)
		QDEL_NULL(linked_radio)

/datum/mutation/mindreader
	name = "读心者"
	desc = "受试者能够窥探他人近期的记忆。"
	quality = POSITIVE
	text_gain_indication = span_notice("你的意识深处响起了遥远的声音。")
	text_lose_indication = span_notice("遥远的声音消失了。")
	power_path = /datum/action/cooldown/spell/pointed/mindread
	instability = POSITIVE_INSTABILITY_MINOR
	difficulty = 8
	locked = TRUE
	mutation_icon_state = "antenna"
	layer_used = FRONT_MUTATIONS_LAYER

/datum/action/cooldown/spell/pointed/mindread
	name = "读心"
	desc = "读取目标的思想。"
	button_icon_state = "mindread"
	school = SCHOOL_PSYCHIC
	cooldown_time = 5 SECONDS
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	antimagic_flags = MAGIC_RESISTANCE_MIND

	ranged_mousepointer = 'icons/effects/mouse_pointers/mindswap_target.dmi'

/datum/action/cooldown/spell/pointed/mindread/Grant(mob/grant_to)
	. = ..()
	if (!owner)
		return
	ADD_TRAIT(grant_to, TRAIT_MIND_READER, GENETIC_MUTATION)
	RegisterSignal(grant_to, COMSIG_MOB_EXAMINATE, PROC_REF(on_examining))

/datum/action/cooldown/spell/pointed/mindread/Remove(mob/remove_from)
	. = ..()
	REMOVE_TRAIT(remove_from, TRAIT_MIND_READER, GENETIC_MUTATION)
	UnregisterSignal(remove_from, COMSIG_MOB_EXAMINATE)

/datum/action/cooldown/spell/pointed/mindread/is_valid_target(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	var/mob/living/living_cast_on = cast_on
	if(!living_cast_on.mind)
		to_chat(owner, span_warning("[cast_on]没有可供读取的心智！"))
		return FALSE
	if(living_cast_on.stat == DEAD)
		to_chat(owner, span_warning("[cast_on]已经死了！"))
		return FALSE
	if(living_cast_on.mob_biotypes & MOB_ROBOTIC)
		to_chat(owner, span_warning("[cast_on]是机械生命体，你无法读取其思想！"))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/mindread/cast(mob/living/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags, charge_cost = 0))
		to_chat(owner, span_warning("当你试图进入[cast_on]的心智时，\
			一道精神屏障挡住了你。看来你失败了。"))
		return

	if(cast_on == owner)
		to_chat(owner, span_warning("你深入自己的心智……没错，这就是你自己的心智。"))
		return

	if(cast_on.has_status_effect(/datum/status_effect/heretic_passive/moon))
		to_chat(owner, span_hypnophrase(span_bolddanger("你渴求真相？我会让你看清一切。")))
		if(isliving(owner))
			var/mob/living/reader = owner
			reader.apply_status_effect(/datum/status_effect/moon_converted)
		return

	if(HAS_TRAIT(cast_on, TRAIT_EVIL))
		to_chat(owner, span_warning("当你进入[cast_on]的心智时，\
			你感受到了其中无边的空虚。这是一个真正邪恶的存在。\
			[HAS_TRAIT(owner, TRAIT_EVIL) ? "能找到志同道合的人真不错。" : "这个人到底怎么回事？"]"))

	var/list/log_info = list()
	var/list/discovered_info = list("<i>你深入[cast_on]的心智，发现了……</i>")
	if(prob(20))
		// chance to alert the read-ee
		to_chat(cast_on, span_danger("你感觉有什么外来的东西侵入了你的心智。"))
		log_info += "目标已察觉！"

	var/list/recent_speech = cast_on.copy_recent_speech(copy_amount = 3, line_chance = 50)
	if(length(recent_speech))
		discovered_info += "……往日对话的零碎记忆："
		var/list/speech_block = list()
		for(var/spoken_memory in recent_speech)
			speech_block += "&emsp;\"[spoken_memory]\"..."
			log_info += "近期发言：\"[spoken_memory]\""
		discovered_info += jointext(speech_block, "<br>")

	if(iscarbon(cast_on))
		var/mob/living/carbon/carbon_cast_on = cast_on
		discovered_info += "……意图<b>[carbon_cast_on.combat_mode ? "伤害" : "帮助"]</b>他人。"
		discovered_info += "……真实身份为<b>[carbon_cast_on.mind.name]</b>。"
		log_info += "意图：\"[carbon_cast_on.combat_mode ? "伤害" : "帮助"]\""
		log_info += "身份：\"[carbon_cast_on.mind.name]\""

	to_chat(owner, boxed_message(span_notice(jointext(discovered_info, "<br>"))))
	log_combat(owner, cast_on, "mind read (cast intentionally)", null, "info: [english_list(log_info, and_text = ", ")]")

/datum/action/cooldown/spell/pointed/mindread/proc/on_examining(mob/examiner, atom/examining)
	SIGNAL_HANDLER
	if(!isliving(examining) || examiner == examining)
		return

	INVOKE_ASYNC(src, PROC_REF(read_mind), examiner, examining)

/datum/action/cooldown/spell/pointed/mindread/proc/read_mind(mob/living/examiner, mob/living/examined)
	if(IS_UNCONSCIOUS(examined) || isnull(examined.mind) || (examined.mob_biotypes & MOB_ROBOTIC))
		return

	var/antimagic = examined.can_block_magic(antimagic_flags, charge_cost = 0)
	var/read_text = ""
	if(!antimagic)
		read_text = examined.get_typing_text()
		if(!read_text)
			return

	sleep(0.5 SECONDS) // small pause so it comes after all examine text and effects
	if(QDELETED(examiner))
		return
	if(antimagic)
		to_chat(examiner, boxed_message(span_warning("你试图分析[examined]此刻的想法，却无法进入其心智——看来你失败了。")))
		return

	var/list/log_info = list()
	if(prob(10))
		to_chat(examined, span_danger("你感觉有什么外来的东西侵入了你的心智。"))
		log_info += "目标已察觉！"

	to_chat(examiner, boxed_message(span_notice("<i>你分析着[examined]此刻的想法……</i><br>&emsp;\"[read_text]\"……")))
	log_info += "当前想法：\"[read_text]\""

	log_combat(examiner, examined, "mind read (triggered on examine)", null, "info: [english_list(log_info, and_text = ", ")]")
