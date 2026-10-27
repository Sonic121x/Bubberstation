/datum/emote/silicon
	abstract_type = /datum/emote/silicon
	trait_required = TRAIT_SILICON_EMOTES_ALLOWED
	emote_type = EMOTE_AUDIBLE

/datum/emote/silicon/boop
	key = "boop"
	key_third_person = "boops"
	message = "嘟了一声。"

/datum/emote/silicon/beep
	key = "beep"
	key_third_person = "beeps"
	message = "发出哔声。"
	message_param = "对 %t 发出哔声。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/beep/twobeep.ogg'

/datum/emote/silicon/buzz
	key = "buzz"
	key_third_person = "buzzes"
	message = "发出蜂鸣声。"
	message_param = "对 %t 发出蜂鸣声。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz/buzz-sigh.ogg'

/datum/emote/silicon/buzz2
	key = "buzz2"
	message = "发出两声蜂鸣。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz/buzz-two.ogg'

/datum/emote/silicon/chime
	key = "chime"
	key_third_person = "chimes"
	message = "叮咚作响。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/chime.ogg'

/datum/emote/silicon/honk
	key = "honk"
	key_third_person = "honks"
	message = "鸣响喇叭。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/items/bikehorn.ogg'

/datum/emote/silicon/ping
	key = "ping"
	key_third_person = "pings"
	message = "发出提示音。"
	message_param = "对 %t 发出提示音。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/ping.ogg'

/datum/emote/silicon/sad
	key = "sad"
	message = "奏响一段悲伤的长号声……"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/misc/sadtrombone.ogg'

/datum/emote/silicon/warn
	key = "warn"
	message = "大声鸣响警报！"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/warning-buzzer.ogg'
