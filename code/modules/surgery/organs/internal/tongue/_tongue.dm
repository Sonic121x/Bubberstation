/obj/item/organ/tongue
	name = "舌头"
	desc = "一块主要用于说谎的肉感肌肉。"
	icon_state = "tongue"

	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_TONGUE
	attack_verb_continuous = list("舔", "流口水", "拍打", "舌吻", "用舌头顶")
	attack_verb_simple = list("舔", "流口水", "拍打", "舌吻", "用舌头顶")
	voice_filter = ""
	visual = FALSE
	/**
	 * A cached list of paths of all the languages this tongue is capable of speaking
	 *
	 * Relates to a mob's ability to speak a language - a mob must be able to speak the language
	 * and have a tongue able to speak the language (or omnitongue) in order to actually speak said language
	 *
	 * To modify this list for subtypes, see [/obj/item/organ/tongue/proc/get_possible_languages]. Do not modify directly.
	 */
	VAR_PRIVATE/list/languages_possible
	/**
	 * A list of languages which are native to this tongue
	 *
	 * When these languages are spoken with this tongue, and modifies speech is true, no modifications will be made
	 * (such as no accent, hissing, or whatever)
	 */
	var/list/languages_native
	///changes the verbage of how you speak. (Permille -> says <-, "I just used a verb!")
	///i hate to say it, but because of sign language, this may have to be a component. and we may have to do some insane shit like putting a component on a component
	var/say_mod = "说道"
	///for temporary overrides of the above variable.
	var/temp_say_mod = ""

	/// Whether the owner of this tongue can speak clearly. Being set to FALSE means they mumble and slur things
	var/speakable_with = TRUE
	/// Whether the owner of this tongue can taste anything. Being set to FALSE will mean no taste feedback will be provided.
	var/sense_of_taste = TRUE
	/// Determines how "sensitive" this tongue is to tasting things, lower is more sensitive.
	/// See [/mob/living/proc/get_taste_sensitivity].
	var/taste_sensitivity = 15
	/// Foodtypes this tongue likes
	var/liked_foodtypes = JUNKFOOD | FRIED //human tastes are default
	/// Foodtypes this tongue dislikes
	var/disliked_foodtypes = GROSS | RAW | CLOTH | BUGS | GORE //human tastes are default
	/// Foodtypes this tongue HATES
	var/toxic_foodtypes = TOXIC //human tastes are default
	/// Whether this tongue modifies speech via signal
	var/modifies_speech = FALSE
	/// List of emote keys and sounds for overriding sounds from emotes
	VAR_PROTECTED/emote_sounds

/obj/item/organ/tongue/Initialize(mapload)
	. = ..()
	// Setup the possible languages list
	// - get_possible_languages gives us a list of language paths
	// - then we cache it via string list
	// this results in tongues with identical possible languages sharing a cached list instance
	languages_possible = string_list(get_possible_languages())
	if(speakable_with)
		add_organ_trait(TRAIT_SPEAKS_CLEARLY)
	if(!sense_of_taste)
		add_organ_trait(TRAIT_AGEUSIA)

/obj/item/organ/tongue/examine(mob/user)
	. = ..()
	if(HAS_MIND_TRAIT(user, TRAIT_ENTRAILS_READER)|| isobserver(user))
		if(liked_foodtypes)
			. += span_info("这条舌头偏爱吃 [english_list(bitfield_to_list(liked_foodtypes, FOOD_FLAGS_IC))] 的味道。")
		if(disliked_foodtypes)
			. += span_info("这条舌头讨厌 [english_list(bitfield_to_list(disliked_foodtypes, FOOD_FLAGS_IC))] 的味道。")
		if(toxic_foodtypes)
			. += span_info("这条舌头的生理结构会让 [english_list(bitfield_to_list(toxic_foodtypes, FOOD_FLAGS_IC))] 变得有毒。")

/**
 * Used in setting up the "languages possible" list.
 *
 * Override to have your tongue be only capable of speaking certain languages
 * Extend to hvae a tongue capable of speaking additional languages to the base tongue
 *
 * While a user may be theoretically capable of speaking a language, they cannot physically speak it
 * UNLESS they have a tongue with that language possible, UNLESS UNLESS they have omnitongue enabled.
 */
/obj/item/organ/tongue/proc/get_possible_languages()
	RETURN_TYPE(/list)
	// This is the default list of languages most humans should be capable of speaking
	. = list(
		/datum/language/common,
		/datum/language/uncommon,
		/datum/language/spinwarder, //bubber edit; spinwarder removed
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/nekomimetic,
	)
	if(languages_native)
		. |= languages_native

/obj/item/organ/tongue/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	if(should_modify_speech(source, speech_args))
		modify_speech(source, speech_args)

/obj/item/organ/tongue/proc/should_modify_speech(datum/source, list/speech_args)
	if(speech_args[SPEECH_LANGUAGE] in languages_native) // Speaking a native language?
		return FALSE // Don't modify speech
	if(HAS_TRAIT(source, TRAIT_SIGN_LANG)) // No modifiers for signers - I hate this but I simply cannot get these to combine into one statement
		return FALSE // Don't modify speech
	return TRUE

/obj/item/organ/tongue/proc/modify_speech(datum/source, list/speech_args)
	return speech_args[SPEECH_MESSAGE]

/**
 * Gets the food reaction a tongue would have from the food item,
 * assuming that no check_liked callback was used in the edible component.
 *
 * Can be overriden by subtypes for more complex behavior.
 * Does not get called if the owner has ageusia.
 **/
/obj/item/organ/tongue/proc/get_food_taste_reaction(obj/item/food, foodtypes = NONE)
	var/food_taste_reaction
	if(foodtypes & toxic_foodtypes)
		food_taste_reaction = FOOD_TOXIC
	else if(foodtypes & disliked_foodtypes)
		food_taste_reaction = FOOD_DISLIKED
	else if(foodtypes & liked_foodtypes)
		food_taste_reaction = FOOD_LIKED
	return food_taste_reaction

/obj/item/organ/tongue/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	for(var/key in emote_sounds)
		RegisterSignal(receiver, COMSIG_MOB_EMOTE_SOUND(key), PROC_REF(get_tongue_emote_sound))
	if(modifies_speech)
		RegisterSignal(receiver, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	receiver.voice_filter = voice_filter
	/* This could be slightly simpler, by making the removal of the
	* NO_TONGUE_TRAIT conditional on the tongue's `sense_of_taste`, but
	* then you can distinguish between ageusia from no tongue, and
	* ageusia from having a non-tasting tongue.
	*/
	REMOVE_TRAIT(receiver, TRAIT_AGEUSIA, NO_TONGUE_TRAIT)

/obj/item/organ/tongue/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	temp_say_mod = ""
	for(var/key in emote_sounds)
		UnregisterSignal(organ_owner, COMSIG_MOB_EMOTE_SOUND(key))
	UnregisterSignal(organ_owner, COMSIG_MOB_SAY)
	// Carbons by default start with NO_TONGUE_TRAIT caused TRAIT_AGEUSIA
	ADD_TRAIT(organ_owner, TRAIT_AGEUSIA, NO_TONGUE_TRAIT)
	organ_owner.voice_filter = initial(organ_owner.voice_filter)

/obj/item/organ/tongue/on_begin_failure()
	remove_organ_trait(TRAIT_SPEAKS_CLEARLY)
	add_organ_trait(TRAIT_AGEUSIA)

/obj/item/organ/tongue/on_failure_recovery()
	if(speakable_with)
		add_organ_trait(TRAIT_SPEAKS_CLEARLY)
	if(sense_of_taste)
		remove_organ_trait(TRAIT_AGEUSIA)

/obj/item/organ/tongue/could_speak_language(datum/language/language_path)
	return (language_path in languages_possible)

/obj/item/organ/tongue/get_availability(datum/species/owner_species, mob/living/owner_mob)
	return owner_species.mutanttongue

/obj/item/organ/tongue/feel_for_damage(self_aware)
	// No effect
	return ""

/obj/item/organ/tongue/proc/get_tongue_emote_sound(datum/source, key, list/sounds)
	SIGNAL_HANDLER
	var/sound_override = get_emote_sound_from_list(emote_sounds[key], owner)
	sounds[sound_override] = EMOTE_SOUND_TONGUE

/obj/item/organ/tongue/lizard
	name = "分叉舌"
	desc = "一条细长的肌肉，常见于爬行类种族，据说还兼职当鼻子用。"
	icon_state = "tonguelizard"
	say_mod = "嘶嘶说道"
	taste_sensitivity = 10 // combined nose + tongue, extra sensitive
	modifies_speech = TRUE
	languages_native = list(/datum/language/draconic, /datum/language/ashtongue) //SKYRAT EDIT: Ashtongue for Ashwalkers
	liked_foodtypes = GORE | MEAT | SEAFOOD | NUTS | BUGS
	disliked_foodtypes = GRAIN | DAIRY | CLOTH | GROSS
	voice_filter = @{"[0:a] asplit [out0][out2]; [out0] asetrate=%SAMPLE_RATE%*0.9,aresample=%SAMPLE_RATE%,atempo=1/0.9,aformat=channel_layouts=mono,volume=0.2 [p0]; [out2] asetrate=%SAMPLE_RATE%*1.1,aresample=%SAMPLE_RATE%,atempo=1/1.1,aformat=channel_layouts=mono,volume=0.2[p2]; [p0][0][p2] amix=inputs=3"}
	emote_sounds = list(
		/datum/emote/living/scream::key = list(
			'sound/mobs/humanoids/lizard/lizard_scream_1.ogg',
			'sound/mobs/humanoids/lizard/lizard_scream_2.ogg',
			'sound/mobs/humanoids/lizard/lizard_scream_3.ogg',
		),
		/datum/emote/living/carbon/hiss::key = 'sound/mobs/humanoids/lizard/lizard_hiss.ogg',
		/datum/emote/living/laugh::key = 'sound/mobs/humanoids/lizard/lizard_laugh1.ogg',
		/datum/emote/living/deathgasp::key = 'sound/mobs/humanoids/lizard/deathsound.ogg',
	)
	var/static/list/speech_replacements = list(
		new /regex("s+", "g") = "sss",
		new /regex("S+", "g") = "SSS",
		new /regex(@"(\w)x", "g") = "$1kss",
		//new /regex(@"(\w)X", "g") = "$1KSSS", // SKYRAT EDIT REMOVAL
		new /regex(@"\bx([\-|r|R]|\b)", "g") = "ecks$1",
		new /regex(@"\bX([\-|r|R]|\b)", "g") = "ECKS$1",
	)
	// SKYRAT EDIT ADDITION START - Russian version
	var/static/list/russian_speech_replacements = list(
		new /regex("s+", "g") = "sss",
		new /regex("S+", "g") = "SSS",
		new /regex(@"(\w)x", "g") = "$1kss",
		new /regex(@"\bx([\-|r|R]|\b)", "g") = "ecks$1",
		new /regex(@"\bX([\-|r|R]|\b)", "g") = "ECKS$1",
		new /regex(@"(\w)x", "g") = "$1kss",
		new /regex(@"\bx([\-|r|R]|\b)", "g") = "ecks$1",
		new /regex(@"\bX([\-|r|R]|\b)", "g") = "ECKS$1",
		new /regex("с+", "g") = "ссс",
		new /regex("С+", "g") = "ССС",
		"з" = "с",
		"З" = "С",
		"ж" = "ш",
		"Ж" = "Ш",
	)
	// SKYRAT EDIT ADDITION END

/obj/item/organ/tongue/lizard/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = CONFIG_GET(flag/russian_text_formation) ? russian_speech_replacements : speech_replacements, should_modify_speech = CALLBACK(src, PROC_REF(should_modify_speech))) // SKYRAT EDIT CHANGE - ORIGINAL: AddComponent(/datum/component/speechmod, replacements = speech_replacements, should_modify_speech = CALLBACK(src, PROC_REF(should_modify_speech)))

/obj/item/organ/tongue/lizard/silver
	name = "银舌"
	desc = "这是上流社会银鳞帮的一支基因分支，赋予了他们“化银”的特性。对他们而言，这便是全部，背叛帮会的成员会被强行摘除舌头。奇怪的是，这条舌头本身却是蓝色的。"
	icon_state = "silvertongue"
	actions_types = list(/datum/action/cooldown/turn_to_statue)

/datum/action/cooldown/turn_to_statue
	name = "化为雕像"
	desc = "变成一尊优雅的银色雕像。雕像的耐久与你的生命直接相连，所以务必小心。"
	button_icon = 'icons/obj/medical/organs/organs.dmi'
	button_icon_state = "silvertongue"
	cooldown_time = 10 SECONDS
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_LYING

	/// The statue we turn into.
	/// We only ever make one (in New) and simply move it into nullspace or back.
	var/obj/structure/statue/custom/statue

/datum/action/cooldown/turn_to_statue/New(Target)
	. = ..()
	if(!istype(Target, /obj/item/organ/tongue/lizard/silver))
		stack_trace("Non-silverscale tongue initialized a turn to statue action.")
		qdel(src)
		return

	init_statue()

/datum/action/cooldown/turn_to_statue/Destroy()
	clean_up_statue()
	return ..()

/datum/action/cooldown/turn_to_statue/IsAvailable(feedback)
	. = ..()
	if(!.)
		return FALSE

	if(!isliving(owner))
		return FALSE
	var/obj/item/organ/tongue/lizard/silver/tongue_target = target
	if(tongue_target.owner != owner)
		return FALSE

	if(isnull(statue))
		if(feedback)
			owner.balloon_alert(owner, "你似乎没法变成雕像了！")
		return FALSE // permanently bricked
	if(IS_UNCONSCIOUS_OR_CRIT(owner))
		if(feedback)
			owner.balloon_alert(owner, "你太虚弱了！")
		return FALSE

	return TRUE

/datum/action/cooldown/turn_to_statue/Activate(atom/target)
	StartCooldown(3 SECONDS)

	var/is_statue = owner.loc == statue
	if(!is_statue)
		owner.visible_message(
			span_notice("[owner] 摆出了一个辉煌的姿势。"),
			span_notice("你摆出辉煌的姿势，化作了一尊雕像！"),
		)

	owner.balloon_alert(owner, is_statue ? "正在挣脱……" : "正在摆造型……")
	if(!do_after(owner, (is_statue ? 0.5 SECONDS : 3 SECONDS), target = get_turf(owner)))
		owner.balloon_alert(owner, "被打断了！")
		return

	StartCooldown()

	statue.name = "[owner.real_name] 的雕像"
	statue.desc = "一尊描绘 [owner.real_name] 的雕像"

	if(is_statue)
		statue.visible_message(span_danger("[statue] 活了过来！"))
		owner.forceMove(get_turf(statue))
		statue.moveToNullspace()
		UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	else
		owner.visible_message(
			span_notice("[owner] 硬化成了一尊银色雕像。"),
			span_notice("你变成了一尊银色雕像！"),
		)
		statue.set_visuals(owner.appearance)
		statue.forceMove(get_turf(owner))
		owner.forceMove(statue)
		RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(human_left_statue))

		var/mob/living/living_owner = owner
		statue.update_integrity(living_owner.health) // Statue has 100 health, humans have 100 health

/// Somehow they used an exploit/teleportation to leave statue, lets clean up
/datum/action/cooldown/turn_to_statue/proc/human_left_statue(atom/movable/mover, atom/oldloc, direction)
	SIGNAL_HANDLER

	statue.moveToNullspace()
	UnregisterSignal(mover, COMSIG_MOVABLE_MOVED)

/// Statue was destroyed via IC means (destruction / deconstruction), dust the owner and drop their stuff
/datum/action/cooldown/turn_to_statue/proc/statue_destroyed(datum/source)
	SIGNAL_HANDLER

	if(isnull(statue.loc))
		return // the statue ended up getting destroyed while in nullspace?

	var/mob/living/carbon/carbon_owner = owner
	UnregisterSignal(carbon_owner, COMSIG_MOVABLE_MOVED)

	to_chat(carbon_owner, span_userdanger("随着你的雕像形态崩碎，你作为活物的存在也彻底断绝了！"))
	carbon_owner.forceMove(get_turf(statue))
	carbon_owner.dust(just_ash = TRUE, drop_items = TRUE)
	carbon_owner.investigate_log("因银鳞雕像被拆解／摧毁而化为灰烬。", INVESTIGATE_DEATHS)

	clean_up_statue() // unregister signal before we can do further side effects.

/// Statue was qdeleted outright, do nothing but clear refs.
/datum/action/cooldown/turn_to_statue/proc/statue_deleted(datum/source)
	SIGNAL_HANDLER

	clean_up_statue() // Note that if the lizard is in the statue when they're raw deleted, they too will be raw deleted. This is fine

/// Initializes the statue we're going to hang around inside
/datum/action/cooldown/turn_to_statue/proc/init_statue()
	statue = new()
	statue.set_custom_materials(list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5))
	statue.max_integrity = 100 // statues already have 100 max integrity, so this is a safety net
	statue.set_armor(/datum/armor/obj_structure/silverscale_statue_armor)
	statue.flags_ricochet |= RICOCHET_SHINY
	RegisterSignals(statue, list(COMSIG_OBJ_DECONSTRUCT, COMSIG_ATOM_DESTRUCTION), PROC_REF(statue_destroyed))
	RegisterSignal(statue, COMSIG_QDELETING, PROC_REF(statue_deleted))

/// Cleans up the reference to the statue and unregisters signals
/datum/action/cooldown/turn_to_statue/proc/clean_up_statue()
	if(QDELETED(statue))
		statue = null
		return

	UnregisterSignal(statue, list(COMSIG_OBJ_DECONSTRUCT, COMSIG_ATOM_DESTRUCTION, COMSIG_QDELETING))
	QDEL_NULL(statue)

/datum/armor/obj_structure/silverscale_statue_armor
	melee = 50
	bullet = 50
	laser = 70
	energy = 70
	bomb = 50
	fire = 100

/obj/item/organ/tongue/ghost
	name = "幽灵舌"
	desc = "光是想到有人用它说话，你就觉得毛骨悚然。"
	icon_state = "tongue-ghost"
	movement_type = PHASING
	say_mod = "呜呜说道"
	sense_of_taste = FALSE
	organ_flags = parent_type::organ_flags | ORGAN_GHOST

/obj/item/organ/tongue/abductor
	name = "超语言矩阵"
	desc = "一种神秘的结构，能让使用者之间瞬间沟通。在你需要吃东西之前，它都相当了不起。"
	icon_state = "tongueayylmao"
	say_mod = "叽里咕噜说道"
	organ_traits = list(TRAIT_HIDE_THINKING_INDICATOR)
	sense_of_taste = FALSE
	modifies_speech = TRUE
	var/mothership

/obj/item/organ/tongue/abductor/attack_self(mob/living/carbon/human/tongue_holder)
	if(!istype(tongue_holder))
		return

	var/obj/item/organ/tongue/abductor/tongue = tongue_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!istype(tongue))
		return

	if(tongue.mothership == mothership)
		to_chat(tongue_holder, span_notice("[src] 已经与你自己所在的频道谐振了。"))

	tongue_holder.visible_message(span_notice("[tongue_holder] 双手捧着 [src]，凝神专注了片刻。"), span_notice("你试图调整 [src] 的谐振频率。"))
	if(do_after(tongue_holder, delay=15, target=src))
		to_chat(tongue_holder, span_notice("你把 [src] 谐振到了自己的频道。"))
		mothership = tongue.mothership

/obj/item/organ/tongue/abductor/examine(mob/examining_mob)
	. = ..()
	if(HAS_MIND_TRAIT(examining_mob, TRAIT_ABDUCTOR_TRAINING) || isobserver(examining_mob))
		. += span_notice("将它拿在手上使用，即可让它谐振到另一个频道。")
		if(!mothership)
			. += span_notice("它尚未谐振到任何特定的母舰。")
		else
			. += span_notice("它已与 [mothership] 谐振。")

/obj/item/organ/tongue/abductor/modify_speech(datum/source, list/speech_args)
	//Hacks
	var/message = speech_args[SPEECH_MESSAGE]
	var/mob/living/carbon/human/user = source
	var/rendered = span_abductor("<b>[user.real_name]:</b> [message]")
	user.log_talk(message, LOG_SAY, tag=SPECIES_ABDUCTOR)
	for(var/mob/living/carbon/human/living_mob in GLOB.alive_mob_list)
		var/obj/item/organ/tongue/abductor/tongue = living_mob.get_organ_slot(ORGAN_SLOT_TONGUE)
		if(!istype(tongue))
			continue
		if(mothership == tongue.mothership)
			to_chat(living_mob, rendered, type = MESSAGE_TYPE_RADIO, avoid_highlighting = user == living_mob)

	for(var/mob/dead_mob in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(dead_mob, user)
		to_chat(dead_mob, "[link] [rendered]", type = MESSAGE_TYPE_RADIO)

	speech_args[SPEECH_MESSAGE] = ""

/obj/item/organ/tongue/zombie
	name = "腐烂舌"
	desc = "且不说它已经腐烂，光是它就这么摊在那儿，你就怀疑没有哪条舌头看起来比它更不性感了。"
	icon_state = "tonguezombie"
	say_mod = "呻吟道"
	modifies_speech = TRUE
	taste_sensitivity = 32
	liked_foodtypes = GROSS | MEAT | RAW | GORE
	disliked_foodtypes = NONE
	emote_sounds = list(
		/datum/emote/living/scream::key = list(
			'sound/effects/hallucinations/veryfar_noise.ogg',
			'sound/effects/hallucinations/wail.ogg',
			'sound/effects/hallucinations/far_noise.ogg',
		),
	)
	// List of english words that translate to zombie phrases
	var/static/list/english_to_zombie = list()
	/// Spooky growls we sometimes play while alive
	var/static/list/spooks = list(
		'sound/effects/hallucinations/growl1.ogg',
		'sound/effects/hallucinations/growl2.ogg',
		'sound/effects/hallucinations/growl3.ogg',
		'sound/effects/hallucinations/veryfar_noise.ogg',
		'sound/effects/hallucinations/wail.ogg',
	)

/obj/item/organ/tongue/zombie/proc/add_word_to_translations(english_word, zombie_word)
	english_to_zombie[english_word] = zombie_word
	// zombies don't care about grammar (any tense or form is all translated to the same word)
	english_to_zombie[english_word + plural_s(english_word)] = zombie_word
	english_to_zombie[english_word + "ing"] = zombie_word
	english_to_zombie[english_word + "ed"] = zombie_word

/obj/item/organ/tongue/zombie/proc/load_zombie_translations()
	var/list/zombie_translation = strings("zombie_replacement.json", "zombie")
	for(var/zombie_word in zombie_translation)
		// since zombie words are a reverse list, we gotta do this backwards
		var/list/data = islist(zombie_translation[zombie_word]) ? zombie_translation[zombie_word] : list(zombie_translation[zombie_word])
		for(var/english_word in data)
			add_word_to_translations(english_word, zombie_word)
	english_to_zombie = sort_list(english_to_zombie) // Alphabetizes the list (for debugging)

/obj/item/organ/tongue/zombie/modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		// setup the global list for translation if it hasn't already been done
		if(!length(english_to_zombie))
			load_zombie_translations()

		// make a list of all words that can be translated
		var/list/message_word_list = splittext(message, " ")
		var/list/translated_word_list = list()
		for(var/word in message_word_list)
			word = english_to_zombie[LOWER_TEXT(word)]
			translated_word_list += word ? word : FALSE

		// all occurrences of characters "eiou" (case-insensitive) are replaced with "r"
		message = replacetext(message, regex(@"[eiou]", "ig"), "r")
		// all characters other than "zhrgbmna .!?-" (case-insensitive) are stripped
		message = replacetext(message, regex(@"[^zhrgbmna.!?-\s]", "ig"), "")
		// multiple spaces are replaced with a single (whitespace is trimmed)
		message = replacetext(message, regex(@"(\s+)", "g"), " ")

		var/list/old_words = splittext(message, " ")
		var/list/new_words = list()
		for(var/word in old_words)
			// lower-case "r" at the end of words replaced with "rh"
			word = replacetext(word, regex(@"\lr\b"), "rh")
			// an "a" or "A" by itself will be replaced with "hra"
			word = replacetext(word, regex(@"\b[Aa]\b"), "hra")
			new_words += word

		// if words were not translated, then we apply our zombie speech patterns
		for(var/i in 1 to length(new_words))
			new_words[i] = translated_word_list[i] ? translated_word_list[i] : new_words[i]

		message = new_words.Join(" ")
		message = capitalize(message)
		speech_args[SPEECH_MESSAGE] = message

/obj/item/organ/tongue/zombie/on_life(seconds_per_tick)
	. = ..()
	if(!IS_UNCONSCIOUS_OR_CRIT(owner) && SPT_PROB(2, seconds_per_tick))
		playsoundtoken(owner, pick(spooks), 50, TRUE, 10)

/obj/item/organ/tongue/alien
	name = "异形舌"
	desc = "据顶尖异种生物学家所说，在嘴里再长一张嘴的进化优势在于“这样看起来很凶”。"
	icon_state = "tonguexeno"
	say_mod = "嘶嘶说道"
	taste_sensitivity = 10 // LIZARDS ARE ALIENS CONFIRMED
	modifies_speech = TRUE // not really, they just hiss
	voice_filter = @{"[0:a] asplit [out0][out2]; [out0] asetrate=%SAMPLE_RATE%*0.8,aresample=%SAMPLE_RATE%,atempo=1/0.8,aformat=channel_layouts=mono [p0]; [out2] asetrate=%SAMPLE_RATE%*1.2,aresample=%SAMPLE_RATE%,atempo=1/1.2,aformat=channel_layouts=mono[p2]; [p0][0][p2] amix=inputs=3"}
	emote_sounds = list(
		/datum/emote/living/deathgasp::key = 'sound/mobs/non-humanoids/hiss/hiss6.ogg',
		/datum/emote/living/carbon/hiss::key = SFX_HISS,
		/datum/emote/living/scream::key = 'sound/mobs/non-humanoids/hiss/hiss5.ogg',
	)

// Aliens can only speak alien and a few other languages.
/obj/item/organ/tongue/alien/get_possible_languages()
	return list(
		/datum/language/xenocommon,
		/datum/language/common,
		/datum/language/uncommon,
		/datum/language/draconic, // Both hiss?
		/datum/language/monkey,
	)

/obj/item/organ/tongue/alien/modify_speech(datum/source, list/speech_args)
	var/datum/saymode/xeno/hivemind = speech_args[SPEECH_SAYMODE]
	if(hivemind)
		return

	playsound(owner, SFX_HISS, 25, TRUE, TRUE)

/obj/item/organ/tongue/bone
	name = "骨“舌”"
	desc = "据说骷髅通过颤动牙齿来改变发出的声音，因此才有那种标志性的咯咯声。"
	icon_state = "tonguebone"
	say_mod = "咯咯作响道"
	attack_verb_continuous = list("咬", "咯咯作响", "咀嚼", "磨牙", "啃骨")
	attack_verb_simple = list("咬", "咯咯作响", "咀嚼", "磨牙", "啃骨")
	sense_of_taste = FALSE
	liked_foodtypes = GROSS | MEAT | RAW | GORE | DAIRY //skeletons eat spooky shit... and dairy, of course
	disliked_foodtypes = NONE
	organ_flags = ORGAN_MINERAL
	modifies_speech = TRUE
	var/chattering = FALSE
	var/phomeme_type = "sans"
	var/list/phomeme_types = list("sans", "papyrus")

/obj/item/organ/tongue/bone/Initialize(mapload)
	. = ..()
	phomeme_type = pick(phomeme_types)

// Bone tongues can speak all default + calcic
/obj/item/organ/tongue/bone/get_possible_languages()
	return ..() + /datum/language/calcic

/obj/item/organ/tongue/bone/modify_speech(datum/source, list/speech_args)
	if (chattering)
		chatter(speech_args[SPEECH_MESSAGE], phomeme_type, source)
	switch(phomeme_type)
		if("sans")
			speech_args[SPEECH_SPANS] |= SPAN_SANS
		if("papyrus")
			speech_args[SPEECH_SPANS] |= SPAN_PAPYRUS

/obj/item/organ/tongue/bone/plasmaman
	name = "等离子骨“舌”"
	desc = "和活动的骷髅一样，等离子人通过颤动牙齿来发出语音。"
	icon_state = "tongueplasma"
	modifies_speech = FALSE
	liked_foodtypes = VEGETABLES
	disliked_foodtypes = FRUIT | CLOTH
	organ_flags = parent_type::organ_flags | ORGAN_ORGANIC
	languages_native = list(/datum/language/calcic)
	emote_sounds = list(
		/datum/emote/living/scream::key = list(
			'sound/mobs/humanoids/plasmaman/plasmeme_scream_1.ogg',
			'sound/mobs/humanoids/plasmaman/plasmeme_scream_2.ogg',
			'sound/mobs/humanoids/plasmaman/plasmeme_scream_3.ogg',
		),
	)

/obj/item/organ/tongue/robot
	name = "机械发声盒"
	desc = "一台能与有机生命体对接的语音合成器。"
	failing_desc = "似乎已经损坏。"
	organ_flags = ORGAN_ROBOTIC
	icon_state = "tonguerobot"
	say_mod = "机械地说道"
	attack_verb_continuous = list("哔哔作响", "嘟嘟作响")
	attack_verb_simple = list("哔哔", "嘟嘟")
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	organ_traits = list(TRAIT_SILICON_EMOTES_ALLOWED)
	voice_filter = "alimiter=0.9,acompressor=threshold=0.2:ratio=20:attack=10:release=50:makeup=2,highpass=f=1000"
	emote_sounds = list(
		/datum/emote/living/deathgasp::key = 'sound/mobs/non-humanoids/cyborg/borg_deathsound.ogg',
	)

/obj/item/organ/tongue/robot/could_speak_language(datum/language/language_path)
	return TRUE // THE MAGIC OF ELECTRONICS

/obj/item/organ/tongue/robot/modify_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

/obj/item/organ/tongue/robot/on_mob_insert(mob/living/carbon/receiver)
	. = ..()
	receiver.grant_language(/datum/language/machine, source = LANGUAGE_TONGUE)
	to_chat(receiver, span_boldnotice("你对 [/datum/language/machine::name] 有了新的理解。"))

/obj/item/organ/tongue/robot/on_mob_remove(mob/living/carbon/owner)
	. = ..()
	if(QDELING(owner))
		return
	owner.remove_language(/datum/language/machine, source = LANGUAGE_TONGUE)
	to_chat(owner, span_boldnotice("你已经不太确定“哔”和“嘟”是什么意思了。"))

/obj/item/organ/tongue/snail
	name = "齿舌"
	desc = "一条布满细齿的几丁质齿带，副作用是让所有蜗牛说话变得不不可可思思议议地地缓缓慢慢。"
	color = "#96DB00" // TODO proper sprite, rather than recoloured pink tongue
	modifies_speech = TRUE
	voice_filter = "atempo=0.5" // makes them talk really slow
	liked_foodtypes = VEGETABLES | FRUIT | GROSS | RAW //SKYRAT EDIT - Roundstart Snails - Food Prefs
	disliked_foodtypes = DAIRY | ORANGES | SUGAR //SKYRAT EDIT: Roundstart Snails - As it turns out, you can't give a snail processed sugar or citrus.

/* SKYRAT EDIT START - Roundstart Snails: Less annoying speech.
/obj/item/organ/tongue/snail/modify_speech(datum/source, list/speech_args)
	var/new_message
	var/message = speech_args[SPEECH_MESSAGE]
	for(var/i in 1 to length(message))
		if(findtext("ABCDEFGHIJKLMNOPWRSTUVWXYZabcdefghijklmnopqrstuvwxyz", message[i])) //Im open to suggestions
			new_message += message[i] + message[i] + message[i] //aaalllsssooo ooopppeeennn tttooo sssuuuggggggeeessstttiiiooonsss
		else
			new_message += message[i]
	speech_args[SPEECH_MESSAGE] = new_message
*/ // SKYRAT EDIT END

/obj/item/organ/tongue/ethereal
	name = "放电装置"
	desc = "一种精密的以太人器官，能通过放电合成语音。"
	icon_state = "electrotongue"
	say_mod = "噼啪说道"
	taste_sensitivity = 10 // ethereal tongues function (very loosely) like a gas spectrometer: vaporising a small amount of the food and allowing it to pass to the nose, resulting in more sensitive taste
	liked_foodtypes = NONE //no food is particularly liked by ethereals
	disliked_foodtypes = GROSS
	toxic_foodtypes = NONE //no food is particularly toxic to ethereals
	attack_verb_continuous = list("电击", "猛电", "噼啪放电")
	attack_verb_simple = list("电击", "猛电", "噼啪放电")
	voice_filter = @{"[0:a] asplit [out0][out2]; [out0] asetrate=%SAMPLE_RATE%*0.99,aresample=%SAMPLE_RATE%,volume=0.3 [p0]; [p0][out2] amix=inputs=2"}
	languages_native = list(/datum/language/voltaic)
	emote_sounds = list(
		/datum/emote/living/scream::key = list(
			'sound/mobs/humanoids/ethereal/ethereal_scream_1.ogg',
			'sound/mobs/humanoids/ethereal/ethereal_scream_2.ogg',
			'sound/mobs/humanoids/ethereal/ethereal_scream_3.ogg',
		),
		/datum/emote/living/carbon/hiss::key = 'sound/mobs/humanoids/ethereal/ethereal_hiss.ogg',
	)

/obj/item/organ/tongue/ethereal/lustrous
	//lustrous screams.
	emote_sounds = list(
		/datum/emote/living/scream::key = list(
			'sound/mobs/humanoids/ethereal/lustrous_scream_1.ogg',
			'sound/mobs/humanoids/ethereal/lustrous_scream_2.ogg',
			'sound/mobs/humanoids/ethereal/lustrous_scream_3.ogg',
		),
		/datum/emote/living/carbon/hiss::key = 'sound/mobs/humanoids/ethereal/ethereal_hiss.ogg',
	)

/obj/item/organ/tongue/cat
	name = "猫人舌"
	desc = "一块主要用来喵喵叫的肉感肌肉。或者用来咬人。"
	say_mod = "喵喵说道"
	liked_foodtypes = SEAFOOD | ORANGES | BUGS | GORE
	disliked_foodtypes = GROSS | CLOTH | RAW
	organ_traits = list(TRAIT_WOUND_LICKER, TRAIT_FISH_EATER, TRAIT_CARPOTOXIN_IMMUNE, TRAIT_CAT_EMOTES_ALLOWED)
	languages_native = list(/datum/language/nekomimetic)
	emote_sounds = list(
		/datum/emote/living/carbon/hiss::key = 'sound/mobs/humanoids/felinid/felinid_hiss.ogg',
	)

/obj/item/organ/tongue/jelly
	name = "果冻舌"
	desc = "啊……这声音和我预想的不一样。听起来像太空秋鸟。"
	say_mod = "啁啾说道"
	liked_foodtypes = MEAT | BUGS
	disliked_foodtypes = GROSS
	toxic_foodtypes = NONE
	languages_native = list(/datum/language/slime)

/obj/item/organ/tongue/jelly/get_food_taste_reaction(obj/item/food, foodtypes = NONE)
	// a silver slime created this? what a delicacy!
	if(HAS_TRAIT(food, TRAIT_FOOD_SILVER))
		return FOOD_LIKED
	return ..()

/obj/item/organ/tongue/monkey
	name = "原始舌"
	desc = "用来凶猛地吱吱叫，以及吃香蕉。"
	say_mod = "吱吱说道"
	liked_foodtypes = MEAT | FRUIT | BUGS
	disliked_foodtypes = CLOTH
	languages_native = list(/datum/language/monkey)
	emote_sounds = list(
		/datum/emote/living/scream::key = SFX_SCREECH,
	)

/obj/item/organ/tongue/moth
	name = "蛾舌"
	desc = "蛾子没有舌头。谁给上帝打个电话，告诉祂我很不满意。"
	say_mod = "振翅说道"
	liked_foodtypes = VEGETABLES | DAIRY | CLOTH
	disliked_foodtypes = FRUIT | GROSS | BUGS | GORE
	toxic_foodtypes = MEAT | RAW | SEAFOOD
	languages_native = list(/datum/language/moffic)
	organ_traits = list(TRAIT_MOTH_EMOTES_ALLOWED)
	emote_sounds = list(
		/datum/emote/living/scream::key = 'sound/mobs/humanoids/moth/scream_moth.ogg',
		/datum/emote/living/laugh::key = 'sound/mobs/humanoids/moth/moth_laugh1.ogg',
		/datum/emote/living/deathgasp::key = 'sound/mobs/humanoids/moth/moth_death.ogg',
	)

/obj/item/organ/tongue/mush
	name = "蘑菇舌"
	desc = "你靠它噗噗地说话。懂了吗？"
	icon = 'icons/obj/service/hydroponics/seeds.dmi'
	icon_state = "mycelium-angel"
	say_mod = "噗噗说道"
	languages_native = list(/datum/language/mushroom)

/obj/item/organ/tongue/pod
	name = "豆荚人舌"
	desc = "一种用于说话和进食的植物状器官。"
	say_mod = "吹哨说道"
	liked_foodtypes = VEGETABLES | FRUIT | GRAIN
	disliked_foodtypes = GORE | MEAT | DAIRY | SEAFOOD | BUGS
	foodtype_flags = PODPERSON_ORGAN_FOODTYPES
	color = COLOR_LIME
	languages_native = list(/datum/language/sylvan)

/obj/item/organ/tongue/golem
	name = "魔像舌"
	desc = "这块硅酸盐板看起来并不怎么灵活，但魔像就是用它在发声。"
	color = COLOR_WEBSAFE_DARK_GRAY
	organ_flags = ORGAN_MINERAL
	say_mod = "隆隆说道"
	sense_of_taste = FALSE
	liked_foodtypes = STONE
	disliked_foodtypes = NONE //you don't care for much else besides stone
	toxic_foodtypes = NONE //you can eat fucking uranium
	languages_native = list(/datum/language/terrum)

/obj/item/organ/tongue/shadow
	name = "暗影舌"
	color = COLOR_ALMOST_BLACK
	languages_native = list(/datum/language/shadowtongue)
	say_mod = "哀号道"
	emote_sounds = list(
		/datum/emote/living/scream::key = 'sound/mobs/humanoids/shadow/shadow_wail.ogg',
	)
