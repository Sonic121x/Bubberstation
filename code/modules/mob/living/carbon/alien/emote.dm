/datum/emote/living/alien
	abstract_type = /datum/emote/living/alien
	mob_type_allowed_typecache = list(/mob/living/carbon/alien)

/datum/emote/living/alien/gnarl
	key = "gnarl"
	key_third_person = "gnarls"
	message = "龇牙咧嘴，露出了牙齿……"

/datum/emote/living/alien/roar
	key = "roar"
	key_third_person = "roars"
	message_alien = "发出咆哮。"
	message_larva = "轻声咆哮。"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	vary = TRUE
	sounds_by_mobtype = list(
		/mob/living/carbon/alien/adult = 'sound/mobs/non-humanoids/hiss/hiss5.ogg',
	)
