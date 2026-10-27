//Very important modifications for the bird communication, also new emote files for bubber EXCLUSIVE emote list!

/datum/emote/living/chirp
	key = "chirp"
	key_third_person = "chirps"
	message = "啾啾叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/chirp.ogg'

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "嘎嘎叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/caw.ogg'

/datum/emote/living/caw2
	key = "caw2"
	key_third_person = "caws twice"
	message = "嘎嘎叫了两声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/caw2.ogg'

/datum/emote/living/mrrp //you play like a cat
	key = "mrrp"
	key_third_person = "mrrps"
	message = "发出咪噜声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/mrrp.ogg'

/datum/emote/living/fpurr
	key = "fpurr"
	key_third_person = "fpurrs"
	message = "发出呼噜声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/fox_purr.ogg'

/datum/emote/living/prbt //all tesh players will love me
	key = "prbt"
	key_third_person = "prbts"
	message = "发出噗噜声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/prbt.ogg'

/datum/emote/living/gecker
	key = "gecker"
	key_third_person = "geckers"
	message = "发出咯咯声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/foxgecker.ogg'

/datum/emote/living/mar //all shadekin players will love me
	key = "mar"
	key_third_person = "mars"
	message = "发出一声低鸣！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/sound/emotes/sound_voice_mar.ogg' // Credit to vorestation

//Silicons can snap now
/datum/emote/living/snap
	key = "snap"
	key_third_person = "snaps"
	message = "打了个响指。"
	message_param = "对着%t打了个响指。"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	sound = 'sound/mobs/humanoids/human/snap/fingersnap1.ogg'

/datum/emote/living/meow_alt
	key = "meow1"
	key_third_person = "meowalt"
	message = "喵喵叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/sound/emotes/meow1.ogg'

/datum/emote/living/mrowl
	key = "mrowl"
	key_third_person = "mrowls"
	message = "发出长长的喵呜声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/sound/emotes/mrowl.ogg'

/datum/emote/living/flutter //Moth flutter
	key = "flutter"
	key_third_person = "flutters"
	message = "快速扑扇着翅膀！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/mobs/humanoids/moth/moth_flutter.ogg'

/datum/emote/living/sigh_exasperated
	key = "esigh" // short for exasperated sigh
	key_third_person = "esighs"
	message = "懊恼地叹了口气。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sigh_exasperated/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'modular_zubbers/code/modules/emotes/sound/voice/male_sigh_exasperated.ogg'
		return 'modular_zubbers/code/modules/emotes/sound/voice/female_sigh_exasperated.ogg'
	return

/datum/emote/living/tail_thump
	key = "tailthump"
	key_third_person = "tailthumps"
	message = "咚咚地拍着尾巴！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/tailthump.ogg' // See https://github.com/shiptest-ss13/Shiptest/pull/2159

/datum/emote/living/tail_thump/can_run_emote(mob/user, status_check, intentional, params)
	var/obj/item/organ/tail/tail = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(isnull(tail))
		return FALSE
	return ..()


/datum/emote/living/squeal
	key = "squeal"
	key_third_person = "squeals"
	message = "尖声叫唤！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/squeal.ogg' // See https://github.com/shiptest-ss13/Shiptest/pull/2159

/datum/emote/living/yipyip
	key = "yipyip"
	key_third_person = "yips twice"
	message = "汪汪叫了两声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/yip.ogg'

/datum/emote/living/yip
	key = "yip"
	key_third_person = "yips"
	message = "汪汪叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/yip/get_sound(mob/living/user)
	return pick('modular_zubbers/code/modules/emotes/sound/voice/yip1.ogg',
				'modular_zubbers/code/modules/emotes/sound/voice/yip2.ogg',
				'modular_zubbers/code/modules/emotes/sound/voice/yip2.ogg')

/datum/emote/living/carbon/bonk
	key = "bonk"
	key_third_person = "bonks"
	hands_use_check = TRUE

/datum/emote/living/carbon/bonk/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!length(user.get_empty_held_indexes()))
		to_chat(user, span_warning("你没有空着的手可以用来敲别人的头。"))
		return
	var/obj/item/hand_item/bonkinghand/bonk = new(user)
	if(user.put_in_hands(bonk))
		to_chat(user, span_notice("你准备好用手去敲别人的头了。"))

/datum/emote/living/kweh
	key = "kweh"
	key_third_person = "kwehs"
	message = "大声啼叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/kweh/get_sound(mob/living/user)
	return pick('sound/mobs/non-humanoids/raptor/raptor_1.ogg',
				'sound/mobs/non-humanoids/raptor/raptor_4.ogg',
				'sound/mobs/non-humanoids/raptor/raptor_5.ogg')

/datum/emote/living/kweh_sad
	key = "skweh"
	key_third_person = "skwehs"
	message = "悲伤地啼叫。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/kweh_sad/get_sound(mob/living/user)
	return pick('sound/mobs/non-humanoids/raptor/raptor_2.ogg',
				'sound/mobs/non-humanoids/raptor/raptor_3.ogg')

/datum/emote/living/xenogrowl
	key = "xenogrowl"
	key_third_person = "xenogrowls"
	message = "发出令人不安的低吼。"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/xenogrowl.ogg'

/datum/emote/living/xenohiss
	key = "xenohiss"
	key_third_person = "xenohisses"
	message = "发出令人不安的嘶嘶声。"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/xenohiss.ogg'

/datum/emote/living/stoatchirp
	key = "schirp" // short for stoatchirp
	key_third_person = "schirps"
	message = "啾啾啾地叫！"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/mobs/non-humanoids/stoat/stoat_sounds.ogg'

/datum/emote/living/shortmoo
	key = "smoo" // short for shortmoo
	key_third_person = "smoos"
	message = "短促地哞了一声！"
	emote_type = EMOTE_AUDIBLE
	sound = 'goon/sounds/cow.ogg'

/datum/emote/living/deermah
	key = "mah"
	key_third_person = "mahs"
	message = "像鹿一样咩咩叫！"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_skyrat/modules/customization/game/objects/items/sound/leaplush.ogg'

/datum/emote/living/neigh
	key = "neigh"
	key_third_person = "neighs"
	message = "嘶鸣。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/neigh/get_sound(mob/living/user)
	return 'sound/mobs/non-humanoids/pony/whinny03.ogg'

/datum/emote/living/neigh2
	key = "neigh2"
	key_third_person = "neighs2"
	message = "发出一声悠长的马嘶！"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/neigh2/get_sound(mob/living/user)
	return pick('sound/mobs/non-humanoids/pony/whinny01.ogg',
				'sound/mobs/non-humanoids/pony/whinny02.ogg')

/datum/emote/living/snort
	key = "snort"
	key_third_person = "snorts"
	message = "打了个响鼻。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/snort/get_sound(mob/living/user)
	return 'sound/mobs/non-humanoids/pony/snort.ogg'

/datum/emote/living/bray
	key = "bray"
	key_third_person = "brays"
	message = "大声嘶叫。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bray/get_sound(mob/living/user)
	return 'modular_zubbers/sound/emotes/bray.ogg'

/datum/emote/living/bellow
	key = "bellow"
	key_third_person = "bellows"
	message = "发出一声低沉的吼叫。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bellow/get_sound(mob/living/user)
	return 'modular_zubbers/sound/emotes/bellow.ogg'

/datum/emote/living/yowl
	key = "yowl"
	key_third_person = "yowls"
	message = "大声嚎叫！"
	message_mime = "无声地嚎叫。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/yowl/get_sound(mob/living/user)
	return pick('modular_zubbers/sound/emotes/yowl1.ogg', 'modular_zubbers/sound/emotes/yowl2.ogg')
