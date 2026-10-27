/datum/emote/silicon
	cooldown = 2 SECONDS

/datum/emote/living/human/dwoop
	key = "dwoop"
	key_third_person = "dwoops"
	message = "欢快地啾鸣！"
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/dwoop.ogg'
	allowed_species = list(/datum/species/synthetic, /datum/species/protean)
	cooldown = 2 SECONDS

/datum/emote/silicon/yes
	key = "yes"
	message = "发出肯定的提示音。"
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/synth_yes.ogg'

/datum/emote/silicon/no
	key = "no"
	message = "发出否定的提示音。"
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/synth_no.ogg'

/datum/emote/silicon/beep2
	key = "beep2"
	key_third_person = "beeps sharply"
	message = "发出尖锐的哔声。"
	message_param = "对着 %t 发出尖锐的哔声。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg'

/datum/emote/silicon/laughtrack
	key = "laughtrack"
	message = "播放了一段罐头笑声。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/items/sitcom_laugh/SitcomLaugh2.ogg'

/datum/emote/silicon/wink
	key = "wink"
	key_third_person = "winks"
	message = "俏皮地眨了眨眼。"
	sound = 'sound/mobs/humanoids/human/wink/wink.ogg'

/datum/emote/silicon/blink
	key = "blink"
	key_third_person = "blinks"
	message = "眨了眨眼。"
	sound = 'sound/mobs/humanoids/human/blink/blink.ogg'
