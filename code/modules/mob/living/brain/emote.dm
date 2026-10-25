/datum/emote/brain
	abstract_type = /datum/emote/brain
	mob_type_allowed_typecache = list(/mob/living/brain)
	mob_type_blacklist_typecache = list()
	emote_type = EMOTE_AUDIBLE

/datum/emote/brain/can_run_emote(mob/user, status_check = TRUE, intentional, params)
	. = ..()
	var/mob/living/brain/B = user
	if(!istype(B) || (!(B.container && istype(B.container, /obj/item/mmi))))
		return FALSE

/datum/emote/brain/alarm
	key = "alarm"
	message = "发出警报声。"

/datum/emote/brain/alert
	key = "alert"
	message = "发出痛苦的声音。"

/datum/emote/brain/flash
	key = "flash"
	message = "闪烁着灯光。"
	emote_type = EMOTE_VISIBLE

/datum/emote/brain/notice
	key = "notice"
	message = "播放响亮的提示音。"

/datum/emote/brain/whistle
	key = "whistle"
	key_third_person = "吹口哨"
	message = "吹了声口哨。"
