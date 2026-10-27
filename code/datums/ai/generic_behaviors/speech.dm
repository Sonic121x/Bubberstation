///Random speech behavior, for speech thats random
/datum/bt_node/ai_behavior/random_speech
	time_between_perform = 1 SECONDS
	/// Chance that the mob will speak.
	var/speech_chance = 1
	/// Hearable emotes (e.g. "barks.")  played with sound if sound list is populated.
	var/list/emote_hear
	/// Visible-only emotes (e.g. "wags tail.")  no sound.
	var/list/emote_see
	/// Spoken lines.
	var/list/speak
	/// Sound files to play alongside emote_hear or speak lines.
	var/list/sound

/datum/bt_node/ai_behavior/random_speech/perform(seconds_per_tick, datum/ai_controller/controller)
	if(!prob(speech_chance))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/audible = length(emote_hear)
	var/visible = length(emote_see)
	var/spoken = length(speak)
	var/total = audible + visible + spoken
	if(!total)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/mob/living/pawn = controller.pawn
	if(!istype(pawn))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/roll = rand(1, total)

	if(roll <= audible)
		pawn.manual_emote(pick(emote_hear))
		if(length(sound))
			playsound(pawn, pick(sound), 80, vary = TRUE, pressure_affected = TRUE, ignore_walls = FALSE)
	else if(roll <= audible + visible)
		pawn.manual_emote(pick(emote_see))
	else
		INVOKE_ASYNC(src, PROC_REF(speak), pawn, controller)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/bt_node/ai_behavior/random_speech/proc/speak(mob/living/pawn, datum/ai_controller/controller)
	pawn.say(pick(speak), forced = "AI Controller")
	if(length(sound))
		playsound(pawn, pick(sound), 80, vary = TRUE)

/datum/bt_node/ai_behavior/random_speech/mothroach
	speech_chance = 15
	emote_hear = list("扑扇着翅膀。")

/datum/bt_node/ai_behavior/random_speech/mouse
	speech_chance = 1
	speak = list("吱！", "吱吱！", "吱？")
	sound = list('sound/mobs/non-humanoids/mouse/mousesqueek.ogg')
	emote_hear = list("吱吱叫着。")
	emote_see = list("跑着转圈。", "抖了抖。")

/datum/bt_node/ai_behavior/random_speech/frog
	speech_chance = 3
	emote_see = list("跳着转圈。", "抖了抖。")

/datum/bt_node/ai_behavior/random_speech/lizard
	speech_chance = 3
	emote_hear = list("跺了几下脚。", "发出几声嘶鸣。")
	emote_see = list("吐了吐舌头。", "歪了歪头。", "转了一圈。")

/datum/bt_node/ai_behavior/random_speech/faithless
	speech_chance = 1
	emote_see = list("哀嚎着。")

/datum/bt_node/ai_behavior/random_speech/garden_gnome
	speech_chance = 5
	speak = list("俺不是精灵！", "俺不是哥布林！", "你好啊，老兄！")
	emote_hear = list("打着呼噜。", "打了个嗝。")
	emote_see = list("眨了眨眼。")

/datum/bt_node/ai_behavior/random_speech/killer_tomato
	speech_chance = 3
	emote_hear = list("磨着牙。", "低声咆哮。", "龇牙低吼。")
	emote_see = list("流着口水。")

/datum/bt_node/ai_behavior/random_speech/ant
	speech_chance = 1
	speak = list("嗡嗡嗡！", "咔咔咔！", "嗡嗡", "咔咔咔")
	sound = list('sound/mobs/non-humanoids/insect/chitter.ogg')
	emote_hear = list("发出嗡鸣。", "发出咔嗒声。")
	emote_see = list("摇了摇头。", "抖动着触角。")

/datum/bt_node/ai_behavior/random_speech/fox
	speech_chance = 1
	speak = list("啊呜啊呜", "啊啊啊啊呜——", "咯咯咯", "嗷呜", "噗嗤")
	emote_hear = list("嚎叫着。", "吠叫着。", "尖叫着。")
	emote_see = list("摇了摇头。", "打了个寒战。")

/datum/bt_node/ai_behavior/random_speech/crab
	speech_chance = 1
	sound = list('sound/mobs/non-humanoids/crab/claw_click.ogg')
	emote_hear = list("发出咔嗒声。")
	emote_see = list("敲动着钳子。")

/datum/bt_node/ai_behavior/random_speech/penguin
	speech_chance = 5
	speak = list("嘎嘎！", "嘟嘟！", "嘟！", "嘟", "嘟", "噗嘎！", "嘎！")
	emote_hear = list("嘎嘎叫着", "咯咯叫着")

/datum/bt_node/ai_behavior/random_speech/bear
	speech_chance = 5
	emote_hear = list("咆哮着。", "低声哼哼。", "低吼着。", "重重地跺脚！")
	emote_see = list("凶狠地盯着前方。")

/datum/bt_node/ai_behavior/random_speech/cats
	speech_chance = 10
	sound = list(SFX_CAT_MEOW)
	emote_hear = list("喵喵叫着。")
	emote_see = list("喵喵叫着。")

/// Make spooky sounds, if we have a corpse inside then impersonate them
/datum/bt_node/ai_behavior/random_speech/legion
	speech_chance = 1
	speak = list("来吧……", "军团……", "为什么……？")
	emote_hear = list("呻吟着。", "哀嚎着。", "呜咽着。")
	emote_see = list("抽搐着。", "颤抖着。")
	/// Stuff to specifically say into a radio
	var/list/radio_speech = list("来吧……", "为什么……？")

/datum/bt_node/ai_behavior/random_speech/legion/speak(mob/living/pawn, datum/ai_controller/controller)
	var/mob/living/carbon/human/victim = controller.blackboard[BB_LEGION_CORPSE]
	if (QDELETED(victim) || prob(30))
		return ..()

	if (HAS_MIND_TRAIT(victim, TRAIT_MIMING)) // mimes cant talk
		return

	var/list/remembered_speech = controller.blackboard[BB_LEGION_RECENT_LINES] || list()

	if (length(remembered_speech) && prob(50)) // Don't spam the radio
		pawn.say(pick(remembered_speech), forced = "AI Controller")
		return

	var/obj/item/radio/mob_radio = locate() in victim
	if (QDELETED(mob_radio))
		return ..() // No radio, just talk funny
	mob_radio.talk_into(pawn, pick(radio_speech + remembered_speech), pick(RADIO_CHANNEL_SUPPLY, RADIO_CHANNEL_COMMON))

///Speech behavior that reads from a blackboard to pick what to say. Useful for things with dynamic speech behaviors
/datum/bt_node/ai_behavior/random_speech_blackboard

/datum/bt_node/ai_behavior/random_speech_blackboard/perform(seconds_per_tick, datum/ai_controller/controller)
	var/list/speech_lines = controller.blackboard[BB_BASIC_MOB_SPEAK_LINES]
	if(isnull(speech_lines))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/speech_chance = speech_lines[BB_SPEAK_CHANCE] || 1
	if(!prob(speech_chance))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/list/emote_hear = speech_lines[BB_EMOTE_HEAR] || list()
	var/list/emote_see  = speech_lines[BB_EMOTE_SEE]  || list()
	var/list/speak      = speech_lines[BB_EMOTE_SAY]  || list()
	var/list/sounds     = speech_lines[BB_EMOTE_SOUND] || list()

	var/total = length(emote_hear) + length(emote_see) + length(speak)
	if(!total)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/mob/living/pawn = controller.pawn
	if(!istype(pawn))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/sound_to_play = length(sounds) ? pick(sounds) : null
	var/roll = rand(1, total)

	if(roll <= length(emote_hear))
		pawn.manual_emote(pick(emote_hear))
		if(sound_to_play)
			playsound(pawn, sound_to_play, 80, vary = TRUE, pressure_affected = TRUE, ignore_walls = FALSE)
	else if(roll <= length(emote_hear) + length(emote_see))
		pawn.manual_emote(pick(emote_see))
	else
		INVOKE_ASYNC(pawn, TYPE_PROC_REF(/atom/movable, say), pick(speak), forced = "AI Controller")
		if(sound_to_play)
			playsound(pawn, sound_to_play, 80, vary = TRUE)

	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
