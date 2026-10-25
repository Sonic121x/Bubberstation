#define RAT_ORGAN_COLOR "#646464"
#define RAT_SCLERA_COLOR "#f0e055"
#define RAT_PUPIL_COLOR COLOR_BLACK
#define RAT_COLORS RAT_ORGAN_COLOR + RAT_SCLERA_COLOR + RAT_PUPIL_COLOR

///bonus of the rat: you can ventcrawl!
/datum/status_effect/organ_set_bonus/rat
	id = "organ_set_bonus_rat"
	organs_needed = 4
	bonus_activate_text = span_notice("啮齿动物的 DNA 已与你深度融合！你学会了穿行通风管道！")
	bonus_deactivate_text = span_notice("你的 DNA 不再以老鼠为主，穿行通风管道的本领也随之消失了……")
	bonus_traits = list(TRAIT_VENTCRAWLER_NUDE)

///way better night vision, super sensitive. lotta things work like this, huh?
/obj/item/organ/eyes/night_vision/rat
	name = "突变鼠眼"
	desc = "一对原本正常的眼睛，融合了老鼠的 DNA。"
	flash_protect = FLASH_PROTECTION_HYPER_SENSITIVE
	eye_color_left = COLOR_BLACK
	eye_color_right = COLOR_BLACK

	iris_overlay = null
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/eyes/night_vision/rat"
	post_init_icon_state = "eyes"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = RAT_COLORS
	low_light_cutoff = list(16, 11, 0)
	medium_light_cutoff = list(30, 20, 5)
	high_light_cutoff = list(45, 35, 10)

/obj/item/organ/eyes/night_vision/rat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noticable_organ, "眼睛里有深黑而闪烁不定的瞳孔，周围的巩膜呈病态的黄色。", BODY_ZONE_PRECISE_EYES)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/rat)

///increases hunger, disgust recovers quicker, expands what is defined as "food"
/obj/item/organ/stomach/rat
	name = "突变鼠胃"
	desc = "一个原本正常的胃，融合了老鼠的 DNA。"
	disgust_metabolism = 3

	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/stomach/rat"
	post_init_icon_state = "stomach"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = RAT_COLORS
	hunger_modifier = 10

/obj/item/organ/stomach/rat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/rat)
	AddElement(/datum/element/noticable_organ, "嘴里不停地流着口水。", BODY_ZONE_PRECISE_MOUTH)

/// makes you smaller, walk over tables, and take 1.5x damage
/obj/item/organ/heart/rat
	name = "突变鼠心脏"
	desc = "一颗原本正常的心脏，融合了老鼠的 DNA。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/heart/rat"
	post_init_icon_state = "heart"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = RAT_COLORS
	beat_noise = "急促而尖细的扑通声"
	organ_traits = list(TRAIT_DWARF)

/obj/item/organ/heart/rat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/rat)
	AddElement(/datum/element/noticable_organ, "身体不自然地佝偻着！")
	AddElement(/datum/element/update_icon_blocker)

/obj/item/organ/heart/rat/on_mob_insert(mob/living/carbon/receiver)
	. = ..()
	if(!ishuman(receiver))
		return
	var/mob/living/carbon/human/human_receiver = receiver
	//but 1.5 damage
	human_receiver.physiology?.damage_resistance -= 50

/obj/item/organ/heart/rat/on_mob_remove(mob/living/carbon/heartless, special, movement_flags)
	. = ..()
	if(!ishuman(heartless))
		return
	var/mob/living/carbon/human/human_heartless = heartless
	human_heartless.physiology?.damage_resistance += 50

/// you occasionally squeak, and have some rat related verbal tics
/obj/item/organ/tongue/rat
	name = "突变鼠舌"
	desc = "一条原本正常的舌头，融合了老鼠的 DNA。"
	say_mod = "吱吱说道"
	modifies_speech = TRUE
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/tongue/rat"
	post_init_icon_state = "tongue"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = RAT_COLORS
	liked_foodtypes = DAIRY //mmm, cheese. doesn't especially like anything else
	disliked_foodtypes = NONE //but a rat can eat anything without issue
	toxic_foodtypes = NONE

/obj/item/organ/tongue/rat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noticable_organ, "牙齿形状古怪，泛着黄色。", BODY_ZONE_PRECISE_MOUTH)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/rat)

/obj/item/organ/tongue/rat/proc/whimsy_check(mob/living/checking)
	if(check_holidays(APRIL_FOOLS))
		return TRUE
	if(HAS_PERSONALITY(checking, /datum/personality/whimsical))
		return TRUE
	if(prob(1))
		return TRUE
	return FALSE

/obj/item/organ/tongue/rat/modify_speech(datum/source, list/speech_args)
	. = ..()
	if(!whimsy_check(source))
		return
	var/message = LOWER_TEXT(speech_args[SPEECH_MESSAGE])
	if(message == "hi" || message == "hi.")
		speech_args[SPEECH_MESSAGE] = "芝士很高兴认识你！"
	if(message == "hi?")
		speech_args[SPEECH_MESSAGE] = "呃……芝士很高兴认识你？"

/obj/item/organ/tongue/rat/on_mob_insert(mob/living/carbon/tongue_owner, special, movement_flags)
	. = ..()
	RegisterSignal(tongue_owner, COMSIG_LIVING_ITEM_GIVEN, PROC_REF(its_on_the_mouse))

/obj/item/organ/tongue/rat/on_mob_remove(mob/living/carbon/tongue_owner)
	. = ..()
	UnregisterSignal(tongue_owner, COMSIG_LIVING_ITEM_GIVEN)

/obj/item/organ/tongue/rat/proc/on_item_given(mob/living/carbon/offerer, mob/living/taker, obj/item/given)
	SIGNAL_HANDLER
	if(!whimsy_check(offerer))
		return
	INVOKE_ASYNC(src, PROC_REF(its_on_the_mouse), offerer, taker)

/obj/item/organ/tongue/rat/proc/its_on_the_mouse(mob/living/carbon/offerer, mob/living/taker)
	offerer.say("送你的，算我鼠请客。")
	taker.add_mood_event("it_was_on_the_mouse", /datum/mood_event/it_was_on_the_mouse)

/obj/item/organ/tongue/rat/on_life(seconds_per_tick)
	. = ..()
	if(prob(5))
		owner.emote("squeaks")
		playsound(owner, 'sound/mobs/non-humanoids/mouse/mousesqueek.ogg', 100)

#undef RAT_ORGAN_COLOR
#undef RAT_SCLERA_COLOR
#undef RAT_PUPIL_COLOR
#undef RAT_COLORS
