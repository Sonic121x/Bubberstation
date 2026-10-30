
/* EMOTE DATUMS */
/datum/emote/living
	abstract_type = /datum/emote/living
	mob_type_allowed_typecache = /mob/living
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/taunt
	key = "taunt"
	key_third_person = "taunts"
	message = "出言嘲讽！"
	cooldown = 1.6 SECONDS //note when changing this- this is used by the matrix taunt to block projectiles.

/datum/emote/living/taunt/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	user.spin(TAUNT_EMOTE_DURATION, 0.1 SECONDS)

/datum/emote/living/tongue
	key = "tongue"
	key_third_person = "tongues"
	message = "吐出了舌头。"

/datum/emote/living/tongue/run_emote(mob/user, params, type_override, intentional)
	var/mob/living/carbon/human/human_user = user
	if(istype(human_user) && !human_user.get_organ_slot(ORGAN_SLOT_TONGUE))
		to_chat(human_user, span_warning("你没有舌头！"))
		return
	. = ..()
	QDEL_IN(human_user.give_emote_overlay(/datum/bodypart_overlay/simple/emote/tongue), 5.2 SECONDS)

/datum/emote/living/blush
	key = "blush"
	key_third_person = "blushes"
	message = "脸红了。"

/datum/emote/living/blush/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	QDEL_IN(human_user.give_emote_overlay(/datum/bodypart_overlay/simple/emote/blush), 5.2 SECONDS)

/datum/emote/living/sing_tune
	key = "tunesing"
	key_third_person = "sings a tune"
	message = "哼起了一段旋律。"

/datum/emote/living/bow
	key = "bow"
	key_third_person = "bows"
	message = "鞠了一躬。"
	message_param = "向 %t 鞠了一躬。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/burp
	key = "burp"
	key_third_person = "burps"
	message = "打了个嗝。"
	message_mime = "无声地模仿打嗝。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/choke
	key = "choke"
	key_third_person = "chokes"
	message = "噎住了！"
	message_mime = "无声地噎住了！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/cross
	key = "cross"
	key_third_person = "crosses"
	message = "抱起了双臂。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/chuckle
	key = "chuckle"
	key_third_person = "chuckles"
	message = "轻笑了一声。"
	message_mime = "无声地模仿轻笑。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/collapse
	key = "collapse"
	key_third_person = "collapses"
	message = "瘫倒下去！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/collapse/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(isliving(user))
		var/mob/living/living = user
		living.Unconscious(4 SECONDS)

/datum/emote/living/dance
	key = "dance"
	key_third_person = "dances"
	message = "开心地跳起舞来。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/deathgasp
	key = "deathgasp"
	key_third_person = "deathgasps"
	message = "身体一僵，软软倒下，双眼失去光彩……"
	message_robot = "剧烈颤抖了一阵，随后静止不动，双眼缓缓变暗。"
	message_AI = "发出刺耳的尖鸣，屏幕闪烁，系统缓缓停止运转。"
	message_alien = "发出一声渐渐微弱的喉音尖啸，瘫倒在地……"
	message_larva = "发出一声病态的嘶嘶气声，软绵绵地倒在地上……"
	message_monkey = "虚弱地吱了一声，随即倒下不再动弹……"
	message_animal_or_basic = "停止了动弹……"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE | EMOTE_IMPORTANT
	cooldown = (15 SECONDS)
	can_use_flags = EMOTE_CANUSE_UNCONSCIOUS | EMOTE_CANUSE_HARDCRIT | EMOTE_CANUSE_SOFTCRIT
	sound_wall_ignore = TRUE
	vary = TRUE
	sound_volume = 200

/datum/emote/living/deathgasp/run_emote(mob/living/user, params, type_override, intentional)
	if(!is_type_in_typecache(user, mob_type_allowed_typecache))
		return
	var/custom_message = user.death_message
	if(custom_message)
		message_animal_or_basic = custom_message

	if(user.has_quirk(/datum/quirk/death_mimicry))
		user.Unconscious(30 SECONDS, ignore_canstun=TRUE)
		ADD_TRAIT(user, TRAIT_FAKEDEATH, QUIRK_TRAIT)
		addtimer(TRAIT_CALLBACK_REMOVE(user, TRAIT_FAKEDEATH, QUIRK_TRAIT), 30 SECONDS)

	. = ..()
	message_animal_or_basic = initial(message_animal_or_basic)

/datum/emote/living/deathgasp/get_sound(mob/living/user)
	. = ..()
	if(!. && user.death_sound)
		return user.death_sound

/datum/emote/living/deathgasp/should_play_sound(mob/living/user, intentional = FALSE)
	if(!user.can_speak() || user.get_oxy_loss() >= 50)
		return FALSE //stop the sound if oxyloss too high/cant speak
	return ..()

/datum/emote/living/drool
	key = "drool"
	key_third_person = "drools"
	message = "流着口水。"

/datum/emote/living/faint
	key = "faint"
	key_third_person = "faints"
	message = "昏了过去。"

/datum/emote/living/faint/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(isliving(user))
		var/mob/living/living = user
		living.SetSleeping(20 SECONDS)

/datum/emote/living/flap
	key = "flap"
	key_third_person = "flaps"
	message = "扇动着翅膀。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS
	var/wing_time = 0.35 SECONDS

/datum/emote/living/flap/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	var/obj/item/organ/wings/wings = human_user.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)

	// play a flapping noise if the wing has this implemented
	if(!istype(wings))
		return
	wings.make_flap_sound(human_user)

	if(!wings.has_open_sprite)
		return
	var/open = wings.wings_open
	if(open)
		wings.close_wings()
	else
		wings.open_wings()
	addtimer(CALLBACK(wings, open ? TYPE_PROC_REF(/obj/item/organ/wings, open_wings) : TYPE_PROC_REF(/obj/item/organ/wings, close_wings)), wing_time)

/datum/emote/living/flap/aflap
	key = "aflap"
	key_third_person = "aflaps"
	name = "扇动翅膀（愤怒）"
	message = "愤怒地扇动着翅膀！"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS
	wing_time = 10

/datum/emote/living/frown
	key = "frown"
	key_third_person = "frowns"
	message = "皱起了眉头。"

/datum/emote/living/gag
	key = "gag"
	key_third_person = "gags"
	message = "干呕起来。"
	message_mime = "无声地干呕。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/gasp
	key = "gasp"
	key_third_person = "gasps"
	message = "倒吸一口气！"
	message_mime = "无声地倒吸一口气！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	can_use_flags = EMOTE_CANUSE_UNCONSCIOUS | EMOTE_CANUSE_HARDCRIT | EMOTE_CANUSE_SOFTCRIT
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			MALE = list(
			'sound/mobs/humanoids/human/gasp/gasp_male1.ogg',
			'sound/mobs/humanoids/human/gasp/gasp_male2.ogg',
			),
			FEMALE = list(
			'sound/mobs/humanoids/human/gasp/gasp_female1.ogg',
			'sound/mobs/humanoids/human/gasp/gasp_female2.ogg',
			'sound/mobs/humanoids/human/gasp/gasp_female3.ogg',
			),
		),
	)

/datum/emote/living/gasp/shock
	key = "gaspshock"
	key_third_person = "gaspsshock"
	name = "倒吸一口气（震惊）"
	message = "震惊地倒吸一口气！"
	message_mime = "无声地倒吸一口气，震惊不已！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	can_use_flags = EMOTE_CANUSE_SOFTCRIT

/datum/emote/living/giggle
	key = "giggle"
	key_third_person = "giggles"
	message = "咯咯地笑了起来。"
	message_mime = "无声地咯咯笑！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/glare
	key = "glare"
	key_third_person = "glares"
	message = "瞪着眼。"
	message_param = "瞪了 %t 一眼。"

/datum/emote/living/grin
	key = "grin"
	key_third_person = "grins"
	message = "咧嘴一笑。"

/datum/emote/living/groan
	key = "groan"
	key_third_person = "groans"
	message = "呻吟起来！"
	message_mime = "看起来在呻吟！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/grimace
	key = "grimace"
	key_third_person = "grimaces"
	message = "做出痛苦的表情。"

/datum/emote/living/kiss
	key = "kiss"
	key_third_person = "kisses"
	cooldown = 3 SECONDS

/datum/emote/living/kiss/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	var/kiss_type = /obj/item/hand_item/kisser

	if(HAS_TRAIT(user, TRAIT_GARLIC_BREATH))
		kiss_type = /obj/item/hand_item/kisser/french

	if(HAS_TRAIT(user, TRAIT_CHEF_KISS))
		kiss_type = /obj/item/hand_item/kisser/chef

	if(HAS_TRAIT(user, TRAIT_SYNDIE_KISS))
		kiss_type = /obj/item/hand_item/kisser/syndie

	if(HAS_TRAIT(user, TRAIT_KISS_OF_DEATH))
		kiss_type = /obj/item/hand_item/kisser/death

	var/datum/action/cooldown/ink_spit/ink_action = locate() in user.actions
	if(ink_action?.IsAvailable())
		kiss_type = /obj/item/hand_item/kisser/ink
	else
		ink_action = null

	var/obj/item/kiss_blower = new kiss_type(user)
	if(user.put_in_hands(kiss_blower))
		to_chat(user, span_notice("你准备好送出一个飞吻。"))
		ink_action?.StartCooldown()
		return

	qdel(kiss_blower)
	to_chat(user, span_warning("你现在这个状态没法送出飞吻。"))

/datum/emote/living/laugh
	key = "laugh"
	key_third_person = "laughs"
	message = "大笑起来。"
	message_mime = "无声地大笑！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	manual_specific_emote_audio_cooldown = 8 SECONDS
	vary = TRUE
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			MALE = list(
				'sound/mobs/humanoids/human/laugh/manlaugh1.ogg',
				'sound/mobs/humanoids/human/laugh/manlaugh2.ogg',
			),
			FEMALE = 'sound/mobs/humanoids/human/laugh/womanlaugh.ogg',
		),
	)

/datum/emote/living/laugh/can_run_emote(mob/living/user, status_check = TRUE , intentional, params)
	return ..() && user.can_speak(allow_mimes = TRUE)

/datum/emote/living/look
	key = "look"
	key_third_person = "looks"
	message = "看了看。"
	message_param = "看了看 %t。"

/datum/emote/living/nod
	key = "nod"
	key_third_person = "nods"
	message = "点了点头。"
	message_param = "向 %t 点了点头。"

/datum/emote/living/point
	key = "point"
	key_third_person = "points"
	message = "指了指。"
	message_param = "指了指 %t。"
	cooldown = 1 SECONDS
	// don't put hands use check here, everything is handled in run_emote

/datum/emote/living/point/run_emote(mob/user, params, type_override, intentional)
	message_param = initial(message_param) // reset
	if(iscarbon(user))
		var/mob/living/carbon/our_carbon = user
		if(our_carbon.usable_hands <= 0 || user.incapacitated & INCAPABLE_RESTRAINTS || HAS_TRAIT(user, TRAIT_HANDS_BLOCKED))
			if(our_carbon.usable_legs > 0)
				var/one_leg = FALSE
				var/has_shoes = our_carbon.get_item_by_slot(ITEM_SLOT_FEET)
				if(our_carbon.usable_legs == 1)
					one_leg = TRUE
				var/success_prob = 65
				if(HAS_TRAIT(our_carbon, TRAIT_FREERUNNING))
					success_prob += 35
				if(one_leg)
					success_prob -= 40
				if(prob(success_prob))
					message_param = "[one_leg ? "跳起来，然后" : ""]用[has_shoes ? "脚" : "脚趾"]指了指 %t！"
				else
					message_param = "[one_leg ? "跳起来，然后" : ""]想用[has_shoes ? "脚" : "脚趾"]指向 %t，结果摔倒在地！"
					our_carbon.Paralyze(2 SECONDS)
				TIMER_COOLDOWN_START(user, "point_verb_emote_cooldown", 1 SECONDS)
			else
				if(our_carbon.get_organ_slot(ORGAN_SLOT_EYES))
					message_param = "意味深长地瞥了 %t 一眼！"
					TIMER_COOLDOWN_START(src, "point_verb_emote_cooldown", 1.5 SECONDS)
				else
					if(our_carbon.get_organ_slot(ORGAN_SLOT_TONGUE))
						message_param = "朝 %t 动了动舌头！"
						TIMER_COOLDOWN_START(src, "point_verb_emote_cooldown", 2 SECONDS)
					else
						message_param = "[span_userdanger("脑袋在地上磕了一下")]，想要朝 %t 示意。"
						our_carbon.adjust_organ_loss(ORGAN_SLOT_BRAIN, 5)
						playsound(user, 'sound/effects/glass/glassbash.ogg', 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
						TIMER_COOLDOWN_START(src, "point_verb_emote_cooldown", 2.5 SECONDS)
	return ..()

/datum/emote/living/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "打了个喷嚏。"
	message_mime = "夸张地无声模仿打喷嚏。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			MALE = 'sound/mobs/humanoids/human/sneeze/male_sneeze1.ogg',
			FEMALE = 'sound/mobs/humanoids/human/sneeze/female_sneeze1.ogg',
		),
	)

/datum/emote/living/cough
	key = "cough"
	key_third_person = "coughs"
	message = "咳嗽起来！"
	message_mime = "夸张地模仿咳嗽！"
	vary = TRUE
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE | EMOTE_RUNECHAT
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			MALE = list(
				'sound/mobs/humanoids/human/cough/male_cough1.ogg',
				'sound/mobs/humanoids/human/cough/male_cough2.ogg',
				'sound/mobs/humanoids/human/cough/male_cough3.ogg',
				'sound/mobs/humanoids/human/cough/male_cough4.ogg',
				'sound/mobs/humanoids/human/cough/male_cough5.ogg',
				'sound/mobs/humanoids/human/cough/male_cough6.ogg',
			),
			FEMALE = list(
				'sound/mobs/humanoids/human/cough/female_cough1.ogg',
				'sound/mobs/humanoids/human/cough/female_cough2.ogg',
				'sound/mobs/humanoids/human/cough/female_cough3.ogg',
				'sound/mobs/humanoids/human/cough/female_cough4.ogg',
				'sound/mobs/humanoids/human/cough/female_cough5.ogg',
				'sound/mobs/humanoids/human/cough/female_cough6.ogg',
			),
		),
	)

/datum/emote/living/cough/can_run_emote(mob/user, status_check = TRUE , intentional, params)
	return !HAS_TRAIT(user, TRAIT_SOOTHED_THROAT) && ..()

/datum/emote/living/wheeze
	key = "wheeze"
	key_third_person = "wheezes"
	message = "喘息起来！"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/pout
	key = "pout"
	key_third_person = "pouts"
	message = "噘起了嘴。"
	message_mime = "无声地噘起了嘴。"

/datum/emote/living/scream
	key = "scream"
	key_third_person = "screams"
	message = "尖叫起来！"
	message_mime = "无声地模仿尖叫！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	mob_type_blacklist_typecache = list(/mob/living/brain)
	sound_wall_ignore = TRUE
	use_sound_tokens = TRUE
	manual_specific_emote_audio_cooldown = 10 SECONDS
	forced_specific_emote_audio_cooldown = 4 SECONDS
	vary = TRUE
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			MALE = list(
				'sound/mobs/humanoids/human/scream/malescream_1.ogg',
				'sound/mobs/humanoids/human/scream/malescream_2.ogg',
				'sound/mobs/humanoids/human/scream/malescream_3.ogg',
				'sound/mobs/humanoids/human/scream/malescream_4.ogg',
				'sound/mobs/humanoids/human/scream/malescream_5.ogg',
				'sound/mobs/humanoids/human/scream/malescream_6.ogg',
			),
			FEMALE = list(
				'sound/mobs/humanoids/human/scream/femalescream_1.ogg',
				'sound/mobs/humanoids/human/scream/femalescream_2.ogg',
				'sound/mobs/humanoids/human/scream/femalescream_3.ogg',
				'sound/mobs/humanoids/human/scream/femalescream_4.ogg',
				'sound/mobs/humanoids/human/scream/femalescream_5.ogg',
			),
		),
	)

/datum/emote/living/scream/run_emote(mob/user, params, type_override, intentional = FALSE)
	if(!intentional && HAS_TRAIT(user, TRAIT_ANALGESIA))
		return
	return ..()

/datum/emote/living/scream/select_message_type(mob/user, message, intentional)
	. = ..()
	if(!intentional && isanimal_or_basicmob(user))
		return "发出一声痛苦而响亮的呜咽。"

/datum/emote/living/scream/get_sound(mob/living/user)
	. = ..()
	if(!ishuman(user) || !.)
		return
	var/mob/living/carbon/human/humie = user
	//Rare chance for this banger of a classic to play instead of the avarage joe screams
	if(humie.physique == MALE && prob(1) && ishumanbasic(humie))
		return 'sound/mobs/humanoids/human/scream/wilhelm_scream.ogg'

/datum/emote/living/scowl
	key = "scowl"
	key_third_person = "scowls"
	message = "沉下脸来。"

/datum/emote/living/shake
	key = "shake"
	key_third_person = "shakes"
	message = "摇了摇头。"

/datum/emote/living/shiver
	key = "shiver"
	key_third_person = "shiver"
	message = "打了个寒颤。"

#define SHIVER_LOOP_DURATION (1 SECONDS)
/datum/emote/living/shiver/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()

	animate(user, pixel_w = 1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
	for(var/i in 1 to SHIVER_LOOP_DURATION / (0.2 SECONDS)) //desired total duration divided by the iteration duration to give the necessary iteration count
		animate(pixel_w = -2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
		animate(pixel_w = 2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
	animate(pixel_w = -1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)
#undef SHIVER_LOOP_DURATION

/datum/emote/living/sigh
	key = "sigh"
	key_third_person = "sighs"
	message = "叹了口气。"
	message_mime = "夸张地无声模仿叹气。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			MALE = SFX_MALE_SIGH,
			FEMALE = SFX_FEMALE_SIGH,
		),
	)

/datum/emote/living/sigh/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!ishuman(user))
		return
	var/image/emote_animation = image('icons/mob/human/emote_visuals.dmi', user, "sigh")
	flick_overlay_global(emote_animation, GLOB.clients, 2.0 SECONDS)

/datum/emote/living/sit
	key = "sit"
	key_third_person = "sits"
	message = "坐了下来。"

/datum/emote/living/smile
	key = "smile"
	key_third_person = "smiles"
	message = "微微一笑。"

/datum/emote/living/smug
	key = "smug"
	key_third_person = "smugs"
	message = "得意地笑了。"

/datum/emote/living/sniff
	key = "sniff"
	key_third_person = "sniffs"
	message = "抽了抽鼻子。"
	message_mime = "无声地抽了抽鼻子。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			MALE = 'sound/mobs/humanoids/human/sniff/male_sniff.ogg',
			FEMALE = 'sound/mobs/humanoids/human/sniff/female_sniff.ogg',
		),
	)

/datum/emote/living/snore
	key = "snore"
	key_third_person = "snores"
	message = "打着呼噜。"
	message_mime = "睡得很香。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	can_use_flags = EMOTE_CANUSE_UNCONSCIOUS
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			MALE = SFX_SNORE_MALE,
			FEMALE = SFX_SNORE_FEMALE,
		),
	)

/datum/emote/living/stare
	key = "stare"
	key_third_person = "stares"
	message = "盯着看。"
	message_param = "盯着 %t 看。"

/datum/emote/living/strech
	key = "stretch"
	key_third_person = "stretches"
	message = "伸展双臂。"

/datum/emote/living/sulk
	key = "sulk"
	key_third_person = "sulks"
	message = "难过地闷闷不乐。"

/datum/emote/living/surrender
	key = "surrender"
	key_third_person = "surrenders"
	message = "双手抱头，跪倒在地，投降了！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/surrender/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(isliving(user))
		var/mob/living/living = user
		living.Paralyze(20 SECONDS)
		living.remove_status_effect(/datum/status_effect/grouped/surrender)

/datum/emote/living/sway
	key = "sway"
	key_third_person = "sways"
	message = "头晕目眩地摇晃着。"

/datum/emote/living/sway/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()

	animate(user, pixel_w = 2, time = 0.5 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
	for(var/i in 1 to 2)
		animate(pixel_w = -6, time = 1.0 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
		animate(pixel_w = 6, time = 1.0 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
	animate(pixel_w = -2, time = 0.5 SECONDS, flags = ANIMATION_RELATIVE)

/datum/emote/living/tilt
	key = "tilt"
	key_third_person = "tilts"
	message = "把头歪向一边。"

/datum/emote/living/tremble
	key = "tremble"
	key_third_person = "trembles"
	message = "浑身发抖！"

#define TREMBLE_LOOP_DURATION (4.4 SECONDS)
/datum/emote/living/tremble/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()

	animate(user, pixel_w = 2, time = 0.2 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
	for(var/i in 1 to TREMBLE_LOOP_DURATION / (0.4 SECONDS)) //desired total duration divided by the iteration duration to give the necessary iteration count
		animate(pixel_w = -4, time = 0.2 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
		animate(pixel_w = 4, time = 0.2 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
	animate(pixel_w = -2, time = 0.2 SECONDS, flags = ANIMATION_RELATIVE)
#undef TREMBLE_LOOP_DURATION

/datum/emote/living/twitch
	key = "twitch"
	key_third_person = "twitches"
	message = "剧烈地抽搐。"

/datum/emote/living/twitch/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()

	animate(user, pixel_w = 1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
	animate(pixel_w = -2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)
	animate(time = 0.1 SECONDS)
	animate(pixel_w = 2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)
	animate(pixel_w = -1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)

/datum/emote/living/twitch_s
	key = "twitch_s"
	name = "抽搐（轻微）"
	message = "抽搐了一下。"

/datum/emote/living/twitch_s/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()

	animate(user, pixel_w = -1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
	animate(pixel_w = 1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)

/datum/emote/living/wave
	key = "wave"
	key_third_person = "waves"
	message = "挥了挥手。"

/datum/emote/living/whimper
	key = "whimper"
	key_third_person = "whimpers"
	message = "小声呜咽。"
	message_mime = "看起来受伤了。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/wsmile
	key = "wsmile"
	key_third_person = "wsmiles"
	name = "微笑（勉强）"
	message = "勉强笑了笑。"

/// The base chance for your yawn to propagate to someone else if they're on the same tile as you
#define YAWN_PROPAGATE_CHANCE_BASE 20
/// The amount the base chance to propagate yawns falls for each tile of distance
#define YAWN_PROPAGATE_CHANCE_DECAY 4

/datum/emote/living/yawn
	key = "yawn"
	key_third_person = "yawns"
	message = "打了个哈欠。"
	message_mime = "夸张地无声模仿打哈欠。"
	message_robot = "受到感染也打了个哈欠。"
	message_AI = "受到感染也打了个哈欠。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	cooldown = 5 SECONDS

/datum/emote/living/yawn/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!isliving(user))
		return

	if(TIMER_COOLDOWN_FINISHED(user, COOLDOWN_YAWN_PROPAGATION))
		TIMER_COOLDOWN_START(user, COOLDOWN_YAWN_PROPAGATION, cooldown * 3)

	if(astype(user, /mob/living/carbon)?.obscured_slots & HIDEFACE)
		return // if your face is obscured, skip propagation

	var/propagation_distance = user.client ? 5 : 2 // mindless mobs are less able to spread yawns

	for(var/mob/living/iter_living in view(user, propagation_distance))
		if(iter_living.incapacitated || TIMER_COOLDOWN_RUNNING(iter_living, COOLDOWN_YAWN_PROPAGATION))
			continue

		var/dist_between = get_dist(user, iter_living)
		var/recently_examined = FALSE // if you yawn just after someone looks at you, it forces them to yawn as well. Tradecraft!

		if(iter_living.client)
			var/examine_time = LAZYACCESS(iter_living.client?.recent_examines, user)
			if(examine_time && (world.time - examine_time < YAWN_PROPAGATION_EXAMINE_WINDOW))
				recently_examined = TRUE

		if(!recently_examined && !prob(YAWN_PROPAGATE_CHANCE_BASE - (YAWN_PROPAGATE_CHANCE_DECAY * dist_between)))
			continue

		var/yawn_delay = rand(0.2 SECONDS, 0.7 SECONDS) * dist_between
		addtimer(CALLBACK(src, PROC_REF(propagate_yawn), iter_living), yawn_delay)

/// This yawn has been triggered by someone else yawning specifically, likely after a delay. Check again if they don't have the yawned recently trait
/datum/emote/living/yawn/proc/propagate_yawn(mob/user)
	if(!istype(user) || TIMER_COOLDOWN_RUNNING(user, COOLDOWN_YAWN_PROPAGATION))
		return
	user.emote("yawn")

#undef YAWN_PROPAGATE_CHANCE_BASE
#undef YAWN_PROPAGATE_CHANCE_DECAY

/datum/emote/living/gurgle
	key = "gurgle"
	key_third_person = "gurgles"
	message = "发出不舒服的咕噜声。"
	message_mime = "无声而不舒服地咕噜着。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/custom
	key = "me"
	key_third_person = "custom"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	message = null

/datum/emote/living/custom/can_run_emote(mob/user, status_check, intentional, params)
	. = ..()
	if(!. || !intentional)
		return FALSE

	if(!isnull(user.ckey) && is_banned_from(user.ckey, "Emote"))
		to_chat(user, span_boldwarning("你无法发送自定义表情（已被封禁）。"))
		return FALSE

	if(QDELETED(user))
		return FALSE

	if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, span_boldwarning("你无法发送 IC 消息（已被禁言）。"))
		return FALSE

/datum/emote/living/custom/proc/emote_is_valid(mob/user, input)
	// We're assuming clientless mobs custom emoting is something codebase-driven and not player-driven.
	// If players ever get the ability to force clientless mobs to emote, we'd need to reconsider this.
	if(!user.client)
		return TRUE

	if(CAN_BYPASS_FILTER(user))
		return TRUE

	var/static/regex/stop_bad_mime = regex(@"says|exclaims|yells|asks")
	if(stop_bad_mime.Find(input, 1, 1))
		to_chat(user, span_danger("无效的表情。"))
		return FALSE

	var/list/filter_result = is_ic_filtered(input)

	if(filter_result)
		to_chat(user, span_warning("该表情包含 IC 表情中禁止使用的词语！建议复习一下服务器规则。"))
		to_chat(user, span_warning("“[input]”"))
		REPORT_CHAT_FILTER_TO_USER(user, filter_result)
		log_filter("IC Emote", input, filter_result)
		SSblackbox.record_feedback("tally", "ic_blocked_words", 1, LOWER_TEXT(config.ic_filter_regex.match))
		return FALSE

	filter_result = is_soft_ic_filtered(input)

	if(filter_result)
		if(tgui_alert(user,"你的表情包含“[filter_result[CHAT_FILTER_INDEX_WORD]]”。“[filter_result[CHAT_FILTER_INDEX_REASON]]”，你确定还要发送吗？", "软屏蔽词", list("Yes", "No")) != "Yes")
			SSblackbox.record_feedback("tally", "soft_ic_blocked_words", 1, LOWER_TEXT(config.soft_ic_filter_regex.match))
			log_filter("Soft IC Emote", input, filter_result)
			return FALSE

		message_admins("[ADMIN_LOOKUPFLW(user)] 的表情通过了软过滤词“[filter_result[CHAT_FILTER_INDEX_WORD]]”，可能使用了不被允许的词语。表情：“[html_encode(input)]”")
		log_admin_private("[key_name(user)] 的表情通过了软过滤词“[filter_result[CHAT_FILTER_INDEX_WORD]]”，可能使用了不被允许的词语。表情：“[input]”")
		SSblackbox.record_feedback("tally", "passed_soft_ic_blocked_words", 1, LOWER_TEXT(config.soft_ic_filter_regex.match))
		log_filter("Soft IC Emote (Passed)", input, filter_result)

	return TRUE

/datum/emote/living/custom/get_message_flags(intentional)
	. = ..()
	return .|WITH_EMPHASIS_MESSAGE

/datum/emote/living/custom/proc/get_custom_emote_from_user()
	return stripped_multiline_input(usr, "选择要显示的表情。", "我" , null, MAX_MESSAGE_LEN) // SKYRAT EDIT CHANGE - ORIGINAL : return copytext(sanitize(input("Choose an emote to display.") as text|null), 1, MAX_MESSAGE_LEN)

/datum/emote/living/custom/proc/get_custom_emote_type_from_user()
	var/type = input("这是可见表情还是可听表情？") as null|anything in list("可见", "可听", "两者")

	switch(type)
		if("可见")
			return EMOTE_VISIBLE
		if("可听")
			return EMOTE_AUDIBLE
		if("两者")
			return EMOTE_VISIBLE | EMOTE_AUDIBLE
		else
			tgui_alert(usr,"无法使用该表情，必须选择可听或可见。")
			return FALSE

/datum/emote/living/custom/run_emote(mob/user, params, type_override = null, intentional = FALSE)
	var/our_message = params ? params : get_custom_emote_from_user()

	if(!emote_is_valid(user, our_message))
		return FALSE

	if(!params)
		var/user_emote_type = get_custom_emote_type_from_user()

		if(!user_emote_type)
			return FALSE

		type_override = user_emote_type

	. = ..(user = user, params = our_message, type_override = type_override, intentional = intentional)

/datum/emote/living/custom/replace_pronoun(mob/user, message)
	return message

///Emotes only for le epic chimps
/datum/emote/living/monkey
	abstract_type = /datum/emote/living/monkey
	trait_required = TRAIT_SIMIAN

/datum/emote/living/monkey/gnarl
	key = "gnarl"
	key_third_person = "gnarls"
	message = "龇牙咧嘴，露出了牙齿……"
	message_mime = "无声地龇牙咧嘴，露出牙齿……"

/datum/emote/living/monkey/roll
	key = "roll"
	key_third_person = "rolls"
	message = "打了个滚。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/monkey/scratch
	key = "scratch"
	key_third_person = "scratches"
	message = "挠了挠。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/monkey/sign
	key = "sign"
	key_third_person = "signs"
	message_param = "用手语比出数字 %t。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/inhale
	key = "inhale"
	key_third_person = "inhales"
	message = "吸了口气。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/exhale
	key = "exhale"
	key_third_person = "exhales"
	message = "呼了口气。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/swear
	key = "swear"
	key_third_person = "swears"
	message = "骂了句脏话！"
	message_mime = "做了个粗鲁的手势！"
	emote_type = EMOTE_AUDIBLE

///Abstract type for emotes that can be run by cats and those with a felinid tongue
/datum/emote/living/cat
	abstract_type = /datum/emote/living/cat
	trait_required = TRAIT_CAT_EMOTES_ALLOWED

/datum/emote/living/carbon/whistle/get_sound(mob/living/user)
	return 'sound/mobs/humanoids/human/whistle/whistle1.ogg'

/datum/emote/living/gulp
	key = "gulp"
	key_third_person = "gulps"
	message = "紧张地咽了口口水。"
	message_mime = "无声地咽了口口水！"
	vary = TRUE
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/gulp/get_sound(mob/living/user)
	return pick('sound/mobs/humanoids/human/gulp/gulp1.ogg',
				'sound/mobs/humanoids/human/gulp/gulp2.ogg')
/datum/emote/living/cat/meow
	key = "meow"
	key_third_person = "meows"
	vary = TRUE
	message = "喵了一声！"
	message_mime = "无声地喵了一声。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	sound = SFX_CAT_MEOW

/datum/emote/living/cat/purr
	key = "purr"
	key_third_person = "purrs"
	vary = TRUE
	message = "发出呼噜声。"
	emote_type = EMOTE_AUDIBLE
	sound = SFX_CAT_PURR

///Abstract type for emotes that can be run by mothroaches and those with a moth tongue
/datum/emote/living/moth
	abstract_type = /datum/emote/living/moth
	trait_required = TRAIT_MOTH_EMOTES_ALLOWED

/datum/emote/living/moth/mchitter
	key = "chitter"
	key_third_person = "chitters"
	message = "发出咔嗒声！"
	message_mime = "无声地咔嗒了两下？"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	sound = 'sound/mobs/humanoids/moth/moth_chitter.ogg'

/datum/emote/living/moth/msqueak
	key = "squeak"
	key_third_person = "squeaks"
	message = "吱吱叫了一声！"
	message_mime = "无声地吱了一声？"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	sound = 'sound/mobs/humanoids/moth/moth_squeak.ogg'
