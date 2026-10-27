
/datum/emote
	var/muzzle_ignore = FALSE

//Disables the custom emote blacklist from TG that normally applies to slimes.
/datum/emote/living/custom
	mob_type_blacklist_typecache = list(/mob/living/brain)
	cooldown = 0
	stat_allowed = SOFT_CRIT

//me-verb emotes should not have a cooldown check
/datum/emote/living/custom/check_cooldown(mob/user, intentional)
	return TRUE


/datum/emote/imaginary_friend/custom/check_cooldown(mob/user, intentional)
	return TRUE


/datum/emote/living/blush
	sound = 'modular_skyrat/modules/emotes/sound/emotes/blush.ogg'

/datum/emote/living/quill
	key = "quill"
	key_third_person = "quills"
	message = "抖动羽毛。"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/voxrustle.ogg'


/datum/emote/living/cough/get_sound(mob/living/user)
	if(isvox(user))
		return 'modular_skyrat/modules/emotes/sound/emotes/voxcough.ogg'
	if(iscarbon(user))
		if(user.gender == MALE)
			return pick('modular_skyrat/modules/emotes/sound/emotes/male/male_cough_1.ogg',
						'modular_skyrat/modules/emotes/sound/emotes/male/male_cough_2.ogg',
						'modular_skyrat/modules/emotes/sound/emotes/male/male_cough_3.ogg')
		return pick('modular_skyrat/modules/emotes/sound/emotes/female/female_cough_1.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_2.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_3.ogg')
	return

/datum/emote/living/sneeze
	vary = TRUE

/datum/emote/living/sneeze/get_sound(mob/living/user)
	if(isvox(user))
		return 'modular_skyrat/modules/emotes/sound/emotes/voxsneeze.ogg'
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'modular_skyrat/modules/emotes/sound/emotes/male/male_sneeze.ogg'
		return 'modular_skyrat/modules/emotes/sound/emotes/female/female_sneeze.ogg'
	return

/datum/emote/living/yawn
	message_robot = "合成出一声哈欠。"
	message_AI = "合成出一声哈欠。"

/datum/emote/living/peep
	key = "peep"
	key_third_person = "peeps"
	message = "像小鸟一样啾鸣！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/peep_once.ogg'

/datum/emote/living/peep2
	key = "peep2"
	key_third_person = "peeps twice"
	message = "像小鸟一样啾鸣两声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/peep.ogg'

/datum/emote/living/snap2
	key = "snap2"
	key_third_person = "snaps twice"
	message = "打了两个响指。"
	message_param = "对着 %t 打了两个响指。"
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/snap2.ogg'

/datum/emote/living/snap3
	key = "snap3"
	key_third_person = "snaps thrice"
	message = "打了三个响指。"
	message_param = "对着 %t 打了三个响指。"
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/snap3.ogg'

/datum/emote/living/awoo
	key = "awoo"
	key_third_person = "awoos"
	message = "发出一声嗷呜！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/awoo.ogg'

/datum/emote/living/nya
	key = "nya"
	key_third_person = "nyas"
	message = "发出一声喵！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/nya.ogg'

/datum/emote/living/weh
	key = "weh"
	key_third_person = "wehs"
	message = "发出一声呜诶！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/weh.ogg'

/datum/emote/living/mothsqueak
	key = "msqueak"
	key_third_person = "lets out a tiny squeak"
	message = "发出一声细小的吱叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/sound/emotes/mothsqueak.ogg'

/datum/emote/living/mousesqueak
	key = "squeak"
	key_third_person = "squeaks"
	message = "吱吱叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/mobs/non-humanoids/mouse/mousesqueek.ogg'

/datum/emote/living/merp
	key = "merp"
	key_third_person = "merps"
	message = "发出咩噜声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/merp.ogg'

/datum/emote/living/bark
	key = "bark"
	key_third_person = "barks"
	message = "吠叫起来！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/bark2.ogg'

/datum/emote/living/squish
	key = "squish"
	key_third_person = "squishes"
	message = "发出吧唧声！"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/slime_squish.ogg'

/datum/emote/living/meow
	key = "meow"
	key_third_person = "meows"
	message = "喵喵叫！"
	message_mime = "无声地喵喵叫。"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/meow.ogg'

/datum/emote/living/hiss
	key = "hiss1"
	key_third_person = "hisses"
	message = "发出嘶嘶声！"
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/hiss.ogg'

/datum/emote/living/chitter
	key = "chitter"
	key_third_person = "chitters"
	message = "唧唧鸣叫！"
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE

/datum/emote/living/chitter/get_sound(mob/living/user)
	if(ismoth(user))
		return 'modular_skyrat/modules/emotes/sound/emotes/mothchitter.ogg'
	else
		return 'sound/mobs/non-humanoids/insect/chitter.ogg'

/datum/emote/living/sigh/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'modular_skyrat/modules/emotes/sound/emotes/male/male_sigh.ogg'
		return 'modular_skyrat/modules/emotes/sound/emotes/female/female_sigh.ogg'
	return

/datum/emote/living/sniff
	vary = TRUE
	muzzle_ignore = TRUE

/datum/emote/living/sniff/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'modular_skyrat/modules/emotes/sound/emotes/male/male_sniff.ogg'
		return 'modular_skyrat/modules/emotes/sound/emotes/female/female_sniff.ogg'
	return

/datum/emote/living/gasp/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return pick('modular_skyrat/modules/emotes/sound/emotes/male/gasp_m1.ogg',
						'modular_skyrat/modules/emotes/sound/emotes/male/gasp_m2.ogg',
						'modular_skyrat/modules/emotes/sound/emotes/male/gasp_m3.ogg',
						'modular_skyrat/modules/emotes/sound/emotes/male/gasp_m4.ogg',
						'modular_skyrat/modules/emotes/sound/emotes/male/gasp_m5.ogg',
						'modular_skyrat/modules/emotes/sound/emotes/male/gasp_m6.ogg')
		return pick('modular_skyrat/modules/emotes/sound/emotes/female/gasp_f1.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/gasp_f2.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/gasp_f3.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/gasp_f4.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/gasp_f5.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/gasp_f6.ogg')
	return

/datum/emote/living/snore
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/snore.ogg'

/datum/emote/living/burp
	vary = TRUE

/datum/emote/living/burp/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'modular_skyrat/modules/emotes/sound/emotes/male/burp_m.ogg'
		return 'modular_skyrat/modules/emotes/sound/emotes/female/burp_f.ogg'
	return

/datum/emote/living/clap
	key = "clap"
	key_third_person = "claps"
	message = "鼓起掌来。"
	hands_use_check = TRUE
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/clap/get_sound(mob/living/user)
	return pick('modular_skyrat/modules/emotes/sound/emotes/clap1.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/clap2.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/clap3.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/clap4.ogg')

/datum/emote/living/clap/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional)
	if(!istype(user) || user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/clap1
	key = "clap1"
	key_third_person = "claps once"
	message = "鼓了一下掌。"
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/clap1/get_sound(mob/living/user)
	return pick('modular_zubbers/sound/emotes/claponce1.ogg',
				'modular_zubbers/sound/emotes/claponce2.ogg')

/datum/emote/living/slowclap
	key = "slowclap"
	message = "启动了缓慢鼓掌处理器。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/slowclap.ogg'

/datum/emote/living/clap1/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional)
	if(!istype(user) || user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/headtilt
	key = "tilt"
	key_third_person = "tilts"
	message = "歪了歪头。"
	message_AI = "让显示屏上的画面倾斜。"

/datum/emote/beep
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg'
	mob_type_allowed_typecache = list(/mob/living) //Beep already exists on brains and silicons

/datum/emote/living/blink2
	key = "blink2"
	key_third_person = "blinktwice"
	message = "眨了两下眼。"
	message_AI = "让显示屏闪烁两下。"

/datum/emote/living/rblink
	key = "rblink"
	key_third_person = "rapidblink"
	message = "快速眨眼！"
	message_AI = "让显示端口快速闪烁！"

/datum/emote/living/squint
	key = "squint"
	key_third_person = "squints"
	message = "眯起眼睛。"
	message_AI = "拉近画面。"

/datum/emote/living/smirk
	key = "smirk"
	key_third_person = "smirks"
	message = "露出坏笑。"

/datum/emote/living/eyeroll
	key = "eyeroll"
	key_third_person = "eyerolls"
	message = "翻了个白眼。"

/datum/emote/living/huff
	key = "huff"
	key_third_person = "huffs"
	message = "哼了一声！"

/datum/emote/living/etwitch
	key = "etwitch"
	key_third_person = "eartwitch"
	message = "耳朵抽动了一下！"

/datum/emote/living/carbon/human/clear_throat
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/carbon/human/clear_throat/get_sound(mob/living/user)
	if(!iscarbon(user))
		return
	if(user.gender == MALE)
		return 'modular_skyrat/modules/emotes/sound/emotes/male/clear_m.ogg'
	return 'modular_skyrat/modules/emotes/sound/emotes/female/clear_f.ogg'

// Avian revolution
/datum/emote/living/bawk
	key = "bawk"
	key_third_person = "bawks"
	message = "像鸡一样咯咯叫。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/bawk.ogg'

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "嘎嘎叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/caw.ogg'

/datum/emote/living/caw2
	key = "caw2"
	key_third_person = "caws twice"
	message = "嘎嘎叫了两声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/caw2.ogg'

/datum/emote/living/blep
	key = "blep"
	key_third_person = "bleps"
	message = "吐出舌头。Blep。"
	message_AI = "展示一张随机吐舌动物的图片。Blep。"
	message_robot = "伸出机械舌头。Blep。"

/datum/emote/living/bork
	key = "bork"
	key_third_person = "borks"
	message = "发出一声汪汪。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/bork.ogg'

/datum/emote/living/hoot
	key = "hoot"
	key_third_person = "hoots"
	message = "咕咕叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/hoot.ogg'

/datum/emote/living/growl
	key = "growl"
	key_third_person = "growls"
	message = "发出一声低吼。"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/growl.ogg'

/datum/emote/living/woof
	key = "woof"
	key_third_person = "woofs"
	message = "发出一声汪。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/woof.ogg'

/datum/emote/living/howl
	key = "howl"
	key_third_person = "howls"
	message = "发出一声长嚎。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/howl.ogg'

/datum/emote/living/howl/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional)
	if(!HAS_TRAIT(user, TRAIT_CANINE) && !islycan(user))
		return FALSE
	return ..()

/datum/emote/living/pant
	key = "pant"
	key_third_person = "pants"
	message = "像狗一样喘气！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/pant.ogg'

/datum/emote/living/baa
	key = "baa"
	key_third_person = "baas"
	message = "发出一声咩。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/baa.ogg'

/datum/emote/living/baa2
	key = "baa2"
	key_third_person = "bleat"
	message = "咩咩叫。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/baa2.ogg'

/datum/emote/living/wurble
	key = "wurble"
	key_third_person = "wurbles"
	message = "发出一声咕噜叫。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/wurble.ogg'

/datum/emote/living/rattle
	key = "rattle"
	key_third_person = "rattles"
	message = "发出咔咔声！"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/rattle.ogg'

/datum/emote/living/cackle
	key = "cackle"
	key_third_person = "cackles"
	message = "歇斯底里地咯咯尖笑！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/cackle_yeen.ogg'

/mob/living/proc/do_ass_slap_animation(atom/slapped)
	do_attack_animation(slapped, no_effect=TRUE)
	var/image/gloveimg = image('icons/effects/effects.dmi', slapped, "slapglove", slapped.layer + 0.1)
	gloveimg.pixel_y = -5
	gloveimg.pixel_x = 0
	slapped.flick_overlay_view(gloveimg, 1 SECONDS)

	// And animate the attack!
	animate(gloveimg, alpha = 175, transform = matrix() * 0.75, pixel_x = 0, pixel_y = -5, pixel_z = 0, time = 0.3 SECONDS)
	animate(time = 0.1 SECONDS)
	animate(alpha = 0, time = 0.3 SECONDS, easing = CIRCULAR_EASING|EASE_OUT)

//Froggie Revolution
/datum/emote/living/warble
	key = "warble"
	key_third_person = "warbles"
	message = "发出颤鸣！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/warbles.ogg'

/datum/emote/living/trills
	key = "trill"
	key_third_person = "trills"
	message = "发出颤音！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/trills.ogg'

/datum/emote/living/rpurr
	key = "rpurr"
	key_third_person = "rpurrs"
	message = "发出呼噜声！"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/raptor_purr.ogg'

/datum/emote/living/purr //Ported from CitRP originally by buffyuwu.
	key = "purr"
	key_third_person = "purrs"
	message = "发出呼噜声！"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/feline_purr.ogg'

/datum/emote/living/moo
	key = "moo"
	key_third_person = "moos"
	message = "哞哞叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/moo.ogg'

/datum/emote/living/honk
	key = "honk1"
	key_third_person = "ghonk"
	message = "像鹅一样大声鸣叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/goose_honk.ogg'

/datum/emote/living/gnash
	key = "gnash"
	key_third_person = "gnashes"
	message = "咬紧牙关。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/items/weapons/bite.ogg'

/datum/emote/living/thump
	key = "thump"
	key_third_person = "thumps"
	message = "重重跺脚！"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'sound/effects/glass/glassbash.ogg'

/datum/emote/living/surrender
	muzzle_ignore = TRUE

/datum/emote/living/mggaow
	key = "mggaow"
	key_third_person = "meowloud"
	message = "大声喵叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/mggaow.ogg'

/datum/emote/living/teshchirp
	key = "teshchirp"
	key_third_person = "chirps!"
	message = "啾鸣！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/teshchirp.ogg' // Credits to Virgo Station for the files.

/datum/emote/living/teshsqueak
	key = "teshsqueak"
	key_third_person = "squeaks!"
	message = "吱叫！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/teshsqueak.ogg' // Credits to Virgo Station for the files.

/datum/emote/living/teshtrill
	key = "teshtrill"
	key_third_person = "trills!"
	message = "发出颤音！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/teshtrill.ogg' // Credits to Virgo Station for the files.
