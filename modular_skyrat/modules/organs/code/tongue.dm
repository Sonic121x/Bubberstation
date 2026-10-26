/obj/item/organ/tongue/copy_traits_from(obj/item/organ/tongue/old_tongue, copy_actions = FALSE)
	. = ..()
	// make sure we get food preferences too, because those are now tied to tongues for some reason
	liked_foodtypes = old_tongue.liked_foodtypes
	disliked_foodtypes = old_tongue.disliked_foodtypes
	toxic_foodtypes = old_tongue.toxic_foodtypes

/obj/item/organ/tongue/dog
	name = "长舌头"
	desc = "一条湿润的长舌头。奇怪的是，受到夸奖时它似乎会跳动。"
	say_mod = "汪汪说道"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/tongue/dog/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "汪汪问道"
	signer.verb_exclaim = "汪汪叫道"
	signer.verb_whisper = "呜咽道"
	signer.verb_yell = "吠叫道"

/obj/item/organ/tongue/dog/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/tongue/cat/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "喵喵问道"
	signer.verb_exclaim = "喵呜叫道"
	signer.verb_whisper = "呼噜低语道"
	signer.verb_yell = "喵嗷喊道"

/obj/item/organ/tongue/cat/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/tongue/avian
	name = "鸟类舌头"
	desc = "一条渴望种子的短粗舌头。"
	say_mod = "啁啾说道"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/tongue/avian/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "啾啾问道"
	signer.verb_exclaim = "嘎嘎叫道"
	signer.verb_whisper = "低喃道"
	signer.verb_yell = "尖叫道"

/obj/item/organ/tongue/avian/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/tongue/bovine
	name = "牛舌"
	desc = "一条渴望青草的宽长舌头。"
	say_mod = "哞哞说道"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/tongue/bovine/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "哞哞问道"
	signer.verb_exclaim = "哼气叫道"
	signer.verb_whisper = "低哼道"
	signer.verb_yell = "哞叫道"

/obj/item/organ/tongue/bovine/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/tongue/mouse
	name = "鼠舌"
	desc = "一条布满凸点的短粗糙舌头。"
	say_mod = "吱吱说道"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/tongue/mouse/modify_speech(datum/source, list/speech_args)
	. = ..()
	var/message = LOWER_TEXT(speech_args[SPEECH_MESSAGE])
	if(message == "hi" || message == "hi.")
		speech_args[SPEECH_MESSAGE] = "见到你真是芝士满心！"
	if(message == "hi?")
		speech_args[SPEECH_MESSAGE] = "呃……见到你真是芝士满心？"

/obj/item/organ/tongue/mouse/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("mouse_replacement.json", "mouse")) // This is prepawsterous! ...Or something like that.

/obj/item/organ/tongue/mouse/on_mob_insert(mob/living/carbon/tongue_owner, special, movement_flags)
	. = ..()
	RegisterSignal(tongue_owner, COMSIG_LIVING_ITEM_GIVEN, PROC_REF(its_on_the_mouse))

/obj/item/organ/tongue/mouse/on_mob_remove(mob/living/carbon/tongue_owner)
	. = ..()
	UnregisterSignal(tongue_owner, COMSIG_LIVING_ITEM_GIVEN)

/obj/item/organ/tongue/mouse/proc/on_item_given(mob/living/carbon/offerer, mob/living/taker, obj/item/given)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(its_on_the_mouse), offerer, taker)

/obj/item/organ/tongue/mouse/proc/its_on_the_mouse(mob/living/carbon/offerer, mob/living/taker)
	offerer.say("送给你，这次由鼠买单。")
	taker.add_mood_event("it_was_on_the_mouse", /datum/mood_event/it_was_on_the_mouse)

/// This "human" tongue is only used in Character Preferences / Augmentation menu.
/// The base tongue class lacked a say_mod. With say_mod included it makes a non-Human user sound like a Human.
/obj/item/organ/tongue/human
	say_mod = "说道"

/obj/item/organ/tongue/lizard/robot
	name = "机械蜥蜴发声器"
	desc = "能与有机生命体连接的仿蜥蜴语音合成器。"
	organ_flags = ORGAN_ROBOTIC
	icon_state = "tonguerobot"
	say_mod = "嘶鸣道"
	attack_verb_continuous = list("哔哔撞击", "嘟嘟撞击")
	attack_verb_simple = list("哔哔撞击", "嘟嘟撞击")
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	voice_filter = "alimiter=0.9,acompressor=threshold=0.2:ratio=20:attack=10:release=50:makeup=2,highpass=f=1000"

/obj/item/organ/tongue/lizard/robot/can_speak_language(language)
	return TRUE // THE MAGIC OF ELECTRONICS

/obj/item/organ/tongue/lizard/robot/modify_speech(datum/source, list/speech_args)
	. = ..()
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

/obj/item/organ/tongue/lizard/cybernetic
	name = "分叉义体舌"
	icon = 'modular_skyrat/modules/organs/icons/cyber_tongue.dmi'
	icon_state = "cybertongue-lizard"
	desc =  "一条功能齐全的分叉合成舌，包覆着柔软硅胶，配备高精度发声装置与味觉感受器。"
	organ_flags = ORGAN_ROBOTIC
	// Not as good as organic tongues, not as bad as the robotic voicebox.
	taste_sensitivity = 20
	modifies_speech = TRUE
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2,
	)

/obj/item/organ/tongue/cybernetic
	name = "义体舌"
	icon = 'modular_skyrat/modules/organs/icons/cyber_tongue.dmi'
	icon_state = "cybertongue"
	desc =  "一条功能齐全的合成舌，包覆着柔软硅胶，配备高精度发声装置与味觉感受器。"
	organ_flags = ORGAN_ROBOTIC
	say_mod = "说道"
	// Not as good as organic tongues, not as bad as the robotic voicebox.
	taste_sensitivity = 20
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2
		)

/obj/item/organ/tongue/vox
	name = "沃克斯舌头"
	desc = "一块主要用于尖鸣的肉质肌肉。"
	say_mod = "尖鸣道"
	liked_foodtypes = MEAT | FRIED
	emote_sounds = list(
		/datum/emote/living/scream::key = 'modular_skyrat/modules/emotes/sound/emotes/voxscream.ogg'
	)

/obj/item/organ/tongue/dwarven
	name = "矮人舌头"
	desc = "一块主要用于咆哮的肉质肌肉。"
	say_mod = "咆哮道"
	liked_foodtypes = ALCOHOL | MEAT | DAIRY //Dwarves like alcohol, meat, and dairy products.
	disliked_foodtypes = JUNKFOOD | FRIED | CLOTH //Dwarves hate foods that have no nutrition other than alcohol.

/obj/item/organ/tongue/ghoul
	name = "食尸鬼舌头"
	desc = "一块主要用于发出沙哑声音的肉质肌肉。"
	say_mod = "沙哑地说道"
	liked_foodtypes = RAW | MEAT
	disliked_foodtypes = VEGETABLES | FRUIT | CLOTH
	toxic_foodtypes = DAIRY | PINEAPPLE

/obj/item/organ/tongue/insect
	name = "昆虫舌头"
	desc = "一块主要用于唧唧鸣叫的肉质肌肉。"
	say_mod = "唧唧说道"
	liked_foodtypes = GROSS | RAW | TOXIC | GORE
	disliked_foodtypes = CLOTH | GRAIN | FRIED
	toxic_foodtypes = DAIRY
	emote_sounds = list(
		/datum/emote/living/scream::key = 'sound/mobs/humanoids/moth/scream_moth.ogg'
	)

/obj/item/organ/tongue/xeno_hybrid
	name = "异形舌头"
	desc = "据顶尖异种生物学家所说，嘴里再长一张嘴的进化优势是\"看起来很酷\"。"
	icon_state = "tonguexeno"
	say_mod = "嘶嘶说道"
	taste_sensitivity = 10
	liked_foodtypes = MEAT
	emote_sounds = list(
		/datum/emote/living/scream::key = 'sound/mobs/non-humanoids/hiss/hiss6.ogg'
	)

/obj/item/organ/tongue/xeno_hybrid/Initialize(mapload)
	. = ..()
	var/obj/item/organ/tongue/alien/alien_tongue_type = /obj/item/organ/tongue/alien
	voice_filter = initial(alien_tongue_type.voice_filter)

/obj/item/organ/tongue/skrell
	name = "斯克雷尔舌头"
	desc = "一块主要用于发出婉转颤音的肉质肌肉。"
	say_mod = "颤声说道"
