/datum/emote/living/carbon
	abstract_type = /datum/emote/living/carbon
	mob_type_allowed_typecache = list(/mob/living/carbon)

/datum/emote/living/carbon/airguitar
	key = "airguitar"
	message = "在空中弹着吉他，还像野生动物园里的黑猩猩一样疯狂甩头。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

//SKYRAT EDIT REMOVAL BEGIN - EMOTES - (Moved to modular_skyrat/modules/emotes/code/emotes.dm as /datum/emote/living/clap)
/*
/datum/emote/living/carbon/clap
	key = "clap"
	key_third_person = "claps"
	message = "claps."
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	vary = TRUE
	affected_by_pitch = FALSE
	sounds_by_mobtype = list(
		/mob/living/carbon = list(
			'sound/mobs/humanoids/human/clap/clap1.ogg',
			'sound/mobs/humanoids/human/clap/clap2.ogg',
			'sound/mobs/humanoids/human/clap/clap3.ogg',
			'sound/mobs/humanoids/human/clap/clap4.ogg',
		),
	)
*/
//SKYRAT EDIT REMOVAL END

/datum/emote/living/carbon/clap/should_play_sound(mob/living/user, intentional = FALSE)
	if(!user.get_bodypart(BODY_ZONE_L_ARM) || !user.get_bodypart(BODY_ZONE_R_ARM))
		return FALSE
	return ..()

/datum/emote/living/carbon/crack
	key = "crack"
	key_third_person = "cracks"
	message = "掰响了指关节。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS
	cooldown = 6 SECONDS
	sound = 'sound/mobs/humanoids/human/knuckle_crack/knuckles.ogg'

/datum/emote/living/carbon/crack/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional, params)
	if(!iscarbon(user) || user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/carbon/cry
	key = "cry"
	key_third_person = "cries"
	message = "哭了起来。"
	message_mime = "无声地抽泣。"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	vary = TRUE
	can_use_flags = EMOTE_CANUSE_SOFTCRIT
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			FEMALE = list(
				'sound/mobs/humanoids/human/cry/female_cry1.ogg',
				'sound/mobs/humanoids/human/cry/female_cry2.ogg',
			),
			MALE = list(
				'sound/mobs/humanoids/human/cry/male_cry1.ogg',
				'sound/mobs/humanoids/human/cry/male_cry2.ogg',
				'sound/mobs/humanoids/human/cry/male_cry3.ogg',
			),
		),
	)

/datum/emote/living/carbon/cry/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	QDEL_IN(human_user.give_emote_overlay(/datum/bodypart_overlay/simple/emote/cry), 12.8 SECONDS)

/datum/emote/living/carbon/circle
	key = "circle"
	key_third_person = "circles"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/circle/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!length(user.get_empty_held_indexes()))
		to_chat(user, span_warning("你没有空着的手来比圈。"))
		return
	var/obj/item/hand_item/circlegame/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, span_notice("你用手比了一个圈。"))

/* BUBBER EDIT REMOVE - moved to modular_skyrat/modules/emotes/code/emotes.dm
/datum/emote/living/carbon/meow
	key = "meow"
	key_third_person = "meows"
	vary = TRUE
	sound = SFX_CAT_MEOW
	message = "meows!"
	message_mime = "meows silently."
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/carbon/meow/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional, params)
	if(!iscarbon(user) || (!istype(user.get_organ_slot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/cat)))
		return FALSE
	return ..()

/datum/emote/living/carbon/purr
	key = "purr"
	key_third_person = "purrs"
	vary = TRUE
	sound = SFX_CAT_PURR
	message = "purrs."
	emote_type = EMOTE_AUDIBLE
*/

/datum/emote/living/carbon/purr/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional, params)
	if(!iscarbon(user) || (!istype(user.get_organ_slot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/cat)) || HAS_MIND_TRAIT(user, TRAIT_MIMING))
		return FALSE
	return ..()

/datum/emote/living/carbon/mchitter
	key = "chitter"
	key_third_person = "chitters"
	message = "发出啁啾声！"
	message_mime = "无声地啁啾？"
	sound = 'sound/mobs/humanoids/moth/moth_chitter.ogg'
/datum/emote/living/carbon/whistle
	key = "whistle"
	key_third_person = "whistles"
	message = "吹了声口哨。"
	message_mime = "无声地吹着口哨！"
	vary = TRUE
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	sound = 'sound/mobs/humanoids/human/whistle/whistle1.ogg'

/datum/emote/living/carbon/moan
	key = "moan"
	key_third_person = "moans"
	message = "呻吟起来！"
	message_mime = "看起来像是在呻吟！"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/carbon/noogie
	key = "noogie"
	key_third_person = "noogies"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/noogie/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/hand_item/noogie/noogie = new(user)
	if(user.put_in_hands(noogie))
		to_chat(user, span_notice("你准备好了搓人脑袋的手。"))
	else
		qdel(noogie)
		to_chat(user, span_warning("以你现在的状态，没法给人家来一记搓头。"))

/datum/emote/living/carbon/roll
	key = "roll"
	key_third_person = "rolls"
	message = "打了个滚。"
	mob_type_allowed_typecache = list(/mob/living/carbon/alien)
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/scratch
	key = "scratch"
	key_third_person = "scratches"
	message = "挠了挠。"
	mob_type_allowed_typecache = list(/mob/living/carbon/alien)
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/sign
	key = "sign"
	key_third_person = "signs"
	message_param = "用手语比出数字 %t。"
	mob_type_allowed_typecache = list(/mob/living/carbon/alien)
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/sign/select_param(mob/user, params)
	. = ..()
	if(!isnum(text2num(params)))
		return message

/datum/emote/living/carbon/sign/signal
	key = "signal"
	key_third_person = "signals"
	message_param = "举起 %t 根手指。"
	mob_type_allowed_typecache = list(/mob/living/carbon/human)
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/slap
	key = "slap"
	key_third_person = "slaps"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS
	cooldown = 3 SECONDS // to prevent endless table slamming

/datum/emote/living/carbon/slap/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/hand_item/slapper/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, span_notice("你准备好了扇人的手。"))
	else
		qdel(N)
		to_chat(user, span_warning("以你现在的状态，没法扇人巴掌。"))


/datum/emote/living/carbon/hand
	key = "hand"
	key_third_person = "hands"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS


/datum/emote/living/carbon/hand/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/hand_item/hand/hand = new(user)
	if(user.put_in_hands(hand))
		to_chat(user, span_notice("你准备好了手。"))
	else
		qdel(hand)
		to_chat(user, span_warning("以你现在的状态，没法使用你的手。"))

/* Bubber removal begin - moved to modular_zubbers\code\modules\emotes\emotes.dm - /datum/emote/living/snap
/datum/emote/living/carbon/snap
	key = "snap"
	key_third_person = "snaps"
	message = "snaps their fingers."
	message_param = "snaps their fingers at %t."
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS
	affected_by_pitch = FALSE
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			'sound/mobs/humanoids/human/snap/fingersnap1.ogg',
			'sound/mobs/humanoids/human/snap/fingersnap2.ogg',
			)
	return null
Bubber removal end */

/datum/emote/living/carbon/shoesteal
	key = "shoesteal"
	key_third_person = "shoesteals"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS
	cooldown = 3 SECONDS

/datum/emote/living/carbon/shoesteal/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/hand_item/stealer/stealing_hand = new(user)
	if (user.put_in_hands(stealing_hand))
		user.balloon_alert(user, "准备偷鞋……")
	else
		qdel(stealing_hand)
		user.balloon_alert(user, "你偷不了鞋！")

/datum/emote/living/carbon/tail
	key = "tail"
	message = "挥了挥尾巴。"
	mob_type_allowed_typecache = list(/mob/living/carbon/alien)

/datum/emote/living/carbon/wink
	key = "wink"
	key_third_person = "winks"
	message = "抛了个媚眼。"
	sound = 'sound/mobs/humanoids/human/wink/wink.ogg'

/datum/emote/living/carbon/hiss
	key = "hiss"
	key_third_person = "hisses"
	message = "发出嘶嘶声！"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	vary = TRUE
	sounds_by_mobtype = list(
		/mob/living/carbon/human = 'sound/mobs/humanoids/human/hiss/human_hiss.ogg',
		/mob/living/carbon/alien = SFX_HISS,
	)
