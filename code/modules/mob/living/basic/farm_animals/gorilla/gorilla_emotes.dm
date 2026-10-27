/datum/emote/gorilla
	abstract_type = /datum/emote/gorilla
	mob_type_allowed_typecache = /mob/living/basic/gorilla
	mob_type_blacklist_typecache = list()

/datum/emote/gorilla/ooga
	key = "ooga"
	key_third_person = "oogas"
	message = "嗷嗷叫着。"
	message_param = "冲着 %t 嗷嗷叫。"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	sound = 'sound/mobs/non-humanoids/gorilla/gorilla.ogg'
