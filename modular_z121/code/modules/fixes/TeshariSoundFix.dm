/datum/emote/living/cough/get_sound(mob/living/user)
	if(isteshari(user))
		return 'modular_z121/sound/emotes/tesharicough.ogg'
	..(user)

/datum/emote/living/sneeze/get_sound(mob/living/user)
	if(isteshari(user))
		return 'modular_z121/sound/emotes/tesharisneeze.ogg'
	..(user)

/datum/laugh_type/teshari_alt
	name = "Teshari laugh"
	male_laughsounds = list('modular_z121/sound/emotes/tesharilaugh.ogg')
	female_laughsounds = null

/datum/scream_type/teshari_alt
	name = "Teshari scream"
	male_screamsounds = list('modular_z121/sound/emotes/teshariscream.ogg')
	female_screamsounds = null

/datum/preference/choiced/laugh/compile_constant_data()
	var/list/data = ..()
	var/list/display_names = data[CHOICED_PREFERENCE_DISPLAY_NAMES] || list()
	display_names["No Laugh"] = "无笑声"
	display_names["Human Laugh"] = "人类笑声"
	display_names["Masculine Human Laugh"] = "男性化人类笑声"
	display_names["Feminine Human Laugh"] = "女性化人类笑声"
	display_names["Lizard Laugh"] = "蜥蜴笑声"
	display_names["Felinid Laugh"] = "猫人笑声"
	display_names["Clown Laugh"] = "小丑笑声"
	display_names["Moth and Insect Laugh"] = "蛾人与昆虫笑声"
	display_names["Vox Laugh"] = "沃克斯笑声"
	display_names["Ascent Laugh"] = "飞升者笑声"
	display_names["Teshari laugh"] = "特沙利笑声"
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = display_names
	return data
