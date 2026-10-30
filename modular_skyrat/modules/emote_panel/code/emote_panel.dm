/mob/proc/manipulate_emotes()
	if(!mind)
		return
	var/list/available_emotes = list()
	var/list/all_emotes = list()

	// code\modules\mob\emote.dm
	var/static/list/mob_emotes = list(
		/mob/proc/emote_flip,
		/mob/proc/emote_spin
	)
	all_emotes += mob_emotes

	// code\modules\mob\living\emote.dm
	var/static/list/living_emotes = list(
		/mob/living/proc/emote_blush,
		/mob/living/proc/emote_bow,
		/mob/living/proc/emote_burp,
		/mob/living/proc/emote_choke,
		/mob/living/proc/emote_cross,
		/mob/living/proc/emote_chuckle,
		/mob/living/proc/emote_collapse,
		/mob/living/proc/emote_cough,
		/mob/living/proc/emote_dance,
		/mob/living/proc/emote_drool,
		/mob/living/proc/emote_faint,
		/mob/living/proc/emote_flap,
		/mob/living/proc/emote_aflap,
		/mob/living/proc/emote_frown,
		/mob/living/proc/emote_gag,
		/mob/living/proc/emote_giggle,
		/mob/living/proc/emote_glare,
		/mob/living/proc/emote_grin,
		/mob/living/proc/emote_groan,
		/mob/living/proc/emote_grimace,
		/mob/living/proc/emote_jump,
		/mob/living/proc/emote_kiss,
		/mob/living/proc/emote_laugh,
		/mob/living/proc/emote_look,
		/mob/living/proc/emote_nod,
		/mob/living/proc/emote_point,
		/mob/living/proc/emote_pout,
		/mob/living/proc/emote_scream,
		/mob/living/proc/emote_scowl,
		/mob/living/proc/emote_shake,
		/mob/living/proc/emote_shiver,
		/mob/living/proc/emote_sigh,
		/mob/living/proc/emote_sit,
		/mob/living/proc/emote_smile,
		/mob/living/proc/emote_sneeze,
		/mob/living/proc/emote_smug,
		/mob/living/proc/emote_sniff,
		/mob/living/proc/emote_stare,
		/mob/living/proc/emote_strech,
		/mob/living/proc/emote_sulk,
		/mob/living/proc/emote_sway,
		/mob/living/proc/emote_tilt,
		/mob/living/proc/emote_tremble,
		/mob/living/proc/emote_twitch,
		/mob/living/proc/emote_twitch_s,
		/mob/living/proc/emote_wave,
		/mob/living/proc/emote_whimper,
		/mob/living/proc/emote_wsmile,
		/mob/living/proc/emote_yawn,
		/mob/living/proc/emote_gurgle,
		/mob/living/proc/emote_inhale,
		/mob/living/proc/emote_exhale,
		/mob/living/proc/emote_swear
	)
	all_emotes += living_emotes

	// code\modules\mob\living\carbon\emote.dm
	var/static/list/carbon_emotes = list(
		/mob/living/carbon/proc/emote_airguitar,
		/mob/living/carbon/proc/emote_blink,
		/mob/living/carbon/proc/emote_blink_r,
		/mob/living/carbon/proc/emote_crack,
		/mob/living/carbon/proc/emote_circle,
		/mob/living/carbon/proc/emote_moan,
		/mob/living/carbon/proc/emote_slap,
		/mob/living/carbon/proc/emote_wink
	)
	all_emotes += carbon_emotes

	// code\modules\mob\living\carbon\human\emote.dm
	var/static/list/human_emotes = list(
		/mob/living/carbon/human/proc/emote_cry,
		/mob/living/carbon/human/proc/emote_eyebrow,
		/mob/living/carbon/human/proc/emote_grumble,
		/mob/living/carbon/human/proc/emote_mumble,
		/mob/living/carbon/human/proc/emote_pale,
		/mob/living/carbon/human/proc/emote_raise,
		/mob/living/carbon/human/proc/emote_salute,
		/mob/living/carbon/human/proc/emote_shrug,
		/mob/living/carbon/human/proc/emote_wag,
		/mob/living/carbon/human/proc/emote_wing
	)
	all_emotes += human_emotes

	// modular_skyrat\modules\emotes\code\emote.dm
	var/static/list/skyrat_living_emotes = list(
		/mob/living/proc/emote_peep,
		/mob/living/proc/emote_peep2,
		/mob/living/proc/emote_snap,
		/mob/living/proc/emote_snap2,
		/mob/living/proc/emote_snap3,
		/mob/living/proc/emote_awoo,
		/mob/living/proc/emote_nya,
		/mob/living/proc/emote_weh,
		/mob/living/proc/emote_mothsqueak,
		/mob/living/proc/emote_mousesqueak,
		/mob/living/proc/emote_merp,
		/mob/living/proc/emote_bark,
		/mob/living/proc/emote_squish,
		/mob/living/proc/emote_meow,
		/mob/living/proc/emote_hiss1,
		/mob/living/proc/emote_chitter,
		/mob/living/proc/emote_snore,
		/mob/living/proc/emote_clap,
		/mob/living/proc/emote_clap1,
		/mob/living/proc/emote_headtilt,
		/mob/living/proc/emote_blink2,
		/mob/living/proc/emote_rblink,
		/mob/living/proc/emote_squint,
		/mob/living/proc/emote_smirk,
		/mob/living/proc/emote_eyeroll,
		/mob/living/proc/emote_huff,
		/mob/living/proc/emote_etwitch,
		/mob/living/proc/emote_clear,
		/mob/living/proc/emote_bawk,
		/mob/living/proc/emote_caw,
		/mob/living/proc/emote_caw2,
		/mob/living/proc/emote_whistle,
		/mob/living/proc/emote_blep,
		/mob/living/proc/emote_bork,
		/mob/living/proc/emote_hoot,
		/mob/living/proc/emote_growl,
		/mob/living/proc/emote_woof,
		/mob/living/proc/emote_baa,
		/mob/living/proc/emote_baa2,
		/mob/living/proc/emote_wurble,
		/mob/living/proc/emote_rattle,
		/mob/living/proc/emote_cackle,
		/mob/living/proc/emote_warble,
		/mob/living/proc/emote_trills,
		/mob/living/proc/emote_rpurr,
		/mob/living/proc/emote_purr,
		/mob/living/proc/emote_moo,
		/mob/living/proc/emote_honk1,
		/mob/living/proc/emote_mggaow,
		/mob/living/proc/emote_slowclap,
		/mob/living/proc/emote_teshchirp,
		/mob/living/proc/emote_teshsqueak,
		/mob/living/proc/emote_teshtrill,
	)
	all_emotes += skyrat_living_emotes

	// code\modules\mob\living\brain\emote.dm
	var/static/list/brain_emotes = list(
		/mob/living/brain/proc/emote_alarm,
		/mob/living/brain/proc/emote_alert,
		/mob/living/brain/proc/emote_flash,
		/mob/living/brain/proc/emote_notice,
		/mob/living/brain/proc/emote_whistle_brain
	)
	all_emotes += brain_emotes

	// code\modules\mob\living\carbon\alien\emote.dm
	var/static/list/alien_emotes = list(
		/mob/living/carbon/alien/proc/emote_gnarl,
		/mob/living/carbon/alien/proc/emote_hiss,
		/mob/living/carbon/alien/proc/emote_roar
	)
	all_emotes += alien_emotes

	// modular_skyrat\modules\emotes\code\synth_emotes.dm
	var/static/list/synth_emotes = list(
		/mob/living/proc/emote_dwoop,
		/mob/living/proc/emote_yes,
		/mob/living/proc/emote_no,
		/mob/living/proc/emote_boop,
		/mob/living/proc/emote_buzz,
		/mob/living/proc/emote_beep,
		/mob/living/proc/emote_beep2,
		/mob/living/proc/emote_buzz2,
		/mob/living/proc/emote_chime,
		/mob/living/proc/emote_honk,
		/mob/living/proc/emote_ping,
		/mob/living/proc/emote_sad,
		/mob/living/proc/emote_warn,
	)
	all_emotes += synth_emotes
	var/static/list/allowed_species_synth = list(
		/datum/species/synthetic
	)

	// modular_skyrat\modules\emotes\code\additionalemotes\overlay_emote.dm
	var/static/list/skyrat_living_emotes_overlay = list(
		/mob/living/proc/emote_sweatdrop,
		/mob/living/proc/emote_exclaim,
		/mob/living/proc/emote_question,
		/mob/living/proc/emote_realize,
		/mob/living/proc/emote_annoyed,
		/mob/living/proc/emote_glasses
	)
	all_emotes += skyrat_living_emotes_overlay

	// modular_skyrat\modules\emotes\code\additionalemotes\turf_emote.dm
	all_emotes += /mob/living/proc/emote_mark_turf

	// Clearing all emotes before applying new ones
	verbs -= all_emotes

	// Checking if preferences allow emote panel
	if(!src.client?.prefs?.read_preference(/datum/preference/toggle/emote_panel))
		return

	// Checking emote availability
	if(isbrain(src))
		// Only brains in MMI have emotes
		var/mob/living/brain/current_brain = src
		if(current_brain.container && istype(current_brain.container, /obj/item/brain_processor))
			available_emotes += brain_emotes
	else
		if(ismob(src))
			available_emotes += mob_emotes
		if(isliving(src))
			available_emotes += living_emotes
			available_emotes += skyrat_living_emotes
			available_emotes += skyrat_living_emotes_overlay
			available_emotes += /mob/living/proc/emote_mark_turf
		if(iscarbon(src))
			available_emotes += carbon_emotes
		if(ishuman(src))
			available_emotes += human_emotes
			// Checking if should apply Synth emotes
			var/mob/living/carbon/human/current_mob = src
			if(!HAS_TRAIT(current_mob, TRAIT_SILICON_EMOTES_ALLOWED))
				available_emotes += synth_emotes
			// Checking if can wag tail
			var/obj/item/organ/tail/tail = current_mob.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
			if(!(tail?.wag_flags & WAG_ABLE))
				available_emotes -= /mob/living/carbon/human/proc/emote_wag
			// Checking if has wings
			if(!current_mob.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS))
				available_emotes -= /mob/living/carbon/human/proc/emote_wing
		if(isalien(src))
			available_emotes += alien_emotes
		if(issilicon(src))
			available_emotes += synth_emotes

	// Applying emote panel if preferences allow
	for(var/emote in available_emotes)
		verbs |= emote

/mob/mind_initialize()
	. = ..()
	manipulate_emotes()

// code\modules\mob\emote.dm
GAME_VERB_PROC(/mob, emote_flip, "| 翻转 |", "表情")
	src.emote("flip", intentional = TRUE)

GAME_VERB_PROC(/mob, emote_spin, "| 旋转 |", "表情")
	src.emote("spin", intentional = TRUE)

// code\modules\mob\living\emote.dm
GAME_VERB_PROC(/mob/living, emote_blush, "~ 脸红", "表情")
	src.emote("blush", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bow, "~ 鞠躬", "表情")
	src.emote("bow", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_burp, "> 打嗝", "表情")
	src.emote("burp", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_choke, "~ 呛住", "表情")
	src.emote("choke", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_cross, "~ 交叉手臂", "表情")
	src.emote("cross", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_chuckle, "~ 轻笑", "表情")
	src.emote("chuckle", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_collapse, "~ 瘫倒", "表情")
	src.emote("collapse", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_cough, "> 咳嗽", "表情")
	src.emote("cough", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_dance, "~ 跳舞", "表情")
	src.emote("dance", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_drool, "~ 流口水", "表情")
	src.emote("drool", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_faint, "~ 昏倒", "表情")
	src.emote("faint", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_flap, "~ 拍翅", "表情")
	src.emote("flap", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_aflap, "~ 愤怒拍翅", "表情")
	src.emote("aflap", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_frown, "~ 皱眉", "表情")
	src.emote("frown", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_gag, "~ 干呕", "表情")
	src.emote("gag", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_giggle, "~ 咯咯笑", "表情")
	src.emote("giggle", intentional = TRUE)


GAME_VERB_PROC(/mob/living, emote_glare, "~ 瞪视", "表情")
	src.emote("glare", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_grin, "~ 咧嘴笑", "表情")
	src.emote("grin", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_groan, "~ 呻吟", "表情")
	src.emote("groan", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_grimace, "~ 做鬼脸", "表情")
	src.emote("grimace", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_jump, "~ 跳跃", "表情")
	src.emote("jump", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_kiss, "| 亲吻 |", "表情")
	src.emote("kiss", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_laugh, "> 大笑", "表情")
	src.emote("laugh", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_look, "~ 环顾", "表情")
	src.emote("look", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_nod, "~ 点头", "表情")
	src.emote("nod", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_nodnod, "~ 连点头", "表情")
	src.emote("nod2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_point, "~ 指向", "表情")
	src.emote("point", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_pout, "~ 撅嘴", "表情")
	src.emote("pout", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_scream, "> 尖叫", "表情")
	src.emote("scream", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_scowl, "~ 怒视", "表情")
	src.emote("scowl", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_shake, "~ 摇头", "表情")
	src.emote("shake", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_shiver, "~ 发抖", "表情")
	src.emote("shiver", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sigh, "> 叹气", "表情")
	src.emote("sigh", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sit, "~ 坐下", "表情")
	src.emote("sit", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_smile, "~ 微笑", "表情")
	src.emote("smile", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sneeze, "> 打喷嚏", "表情")
	src.emote("sneeze", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_smug, "~ 得意", "表情")
	src.emote("smug", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sniff, "> 吸鼻子", "表情")
	src.emote("sniff", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_stare, "~ 凝视", "表情")
	src.emote("stare", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_strech, "~ 伸展", "表情")
	src.emote("stretch", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sulk, "~ 生闷气", "表情")
	src.emote("sulk", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sway, "~ 摇摆", "表情")
	src.emote("sway", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_tilt, "~ 歪头", "表情")
	src.emote("tilt", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_tremble, "~ 颤抖", "表情")
	src.emote("tremble", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_twitch, "~ 抽搐", "表情")
	src.emote("twitch", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_twitch_s, "~ 轻微抽搐", "表情")
	src.emote("twitch_s", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_wave, "~ 挥手", "表情")
	src.emote("wave", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_whimper, "~ 呜咽", "表情")
	src.emote("whimper", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_wsmile, "~ 虚弱微笑", "表情")
	src.emote("wsmile", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_yawn, "~ 打哈欠", "表情")
	src.emote("yawn", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_gurgle, "~ 咕噜作响", "表情")
	src.emote("gurgle", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_inhale, "~ 吸气", "表情")
	src.emote("inhale", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_exhale, "~ 呼气", "表情")
	src.emote("exhale", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_swear, "~ 咒骂", "表情")
	src.emote("swear", intentional = TRUE)

// code\modules\mob\living\carbon\emote.dm
GAME_VERB_PROC(/mob/living/carbon, emote_airguitar, "~ 空气吉他", "表情")
	src.emote("airguitar", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_blink, "~ 眨眼", "表情")
	src.emote("blink", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_blink_r, "~ 快速眨眼", "表情")
	src.emote("blink_r", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_crack, "> 掰关节", "表情")
	src.emote("crack", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_circle, "| 转圈 |", "表情")
	src.emote("circle", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_moan, "~ 呻吟", "表情")
	src.emote("moan", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_slap, "| 扇耳光 |", "表情")
	src.emote("slap", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_wink, "~ 眨眼示意", "表情")
	src.emote("wink", intentional = TRUE)

// code\modules\mob\living\carbon\human\emote.dm
GAME_VERB_PROC(/mob/living/carbon/human, emote_cry, "~ 哭泣", "表情")
	src.emote("cry", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_eyebrow, "~ 扬眉", "表情")
	src.emote("eyebrow", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_grumble, "~ 嘟囔", "表情")
	src.emote("grumble", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_mumble, "~ 含糊低语", "表情")
	src.emote("mumble", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_pale, "~ 脸色发白", "表情")
	src.emote("pale", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_raise, "~ 举手", "表情")
	src.emote("raise", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_salute, "~ 敬礼", "表情")
	src.emote("salute", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_shrug, "~ 耸肩", "表情")
	src.emote("shrug", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_wag, "| 摇尾巴 |", "表情")
	src.emote("wag", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_wing, "| 振翅 |", "表情")
	src.emote("wing", intentional = TRUE)

// modular_skyrat\modules\emotes\code\emote.dm
GAME_VERB_PROC(/mob/living, emote_peep, "> 啾鸣", "表情+")
	src.emote("peep", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_peep2, "> 啾鸣两声", "表情+")
	src.emote("peep2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_snap, "> 打响指", "表情+")
	src.emote("snap", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_snap2, "> 打两下响指", "表情+")
	src.emote("snap2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_snap3, "> 打三下响指", "表情+")
	src.emote("snap3", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_awoo, "> 嗷呜", "表情+")
	src.emote("awoo", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_nya, "> 喵", "表情+")
	src.emote("nya", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_weh, "> 呜诶", "表情+")
	src.emote("weh", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_mothsqueak, "> 蛾鸣", "表情+")
	src.emote("msqueak", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_mousesqueak, "> 鼠吱", "表情+")
	src.emote("squeak", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_merp, "> 咩噜", "表情+")
	src.emote("merp", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bark, "> 吠叫", "表情+")
	src.emote("bark", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_squish, "> 吧唧", "表情+")
	src.emote("squish", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_meow, "> 喵叫", "表情+")
	src.emote("meow", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_hiss1, "> 嘶嘶", "表情+")
	src.emote("hiss1", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_chitter, "> 唧唧", "表情+")
	src.emote("chitter", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_snore, "> 打鼾", "表情+")
	src.emote("snore", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_clap, "> 鼓掌", "表情+")
	src.emote("clap", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_clap1, "> 鼓一下掌", "表情+")
	src.emote("clap1", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_slowclap, "> 缓慢鼓掌", "表情")
	src.emote("slowclap", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_headtilt, "~ 歪头", "表情+")
	src.emote("tilt", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_blink2, "~ 眨两下眼", "表情+")
	src.emote("blink2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_rblink, "~ 快速眨眼", "表情+")
	src.emote("rblink", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_squint, "~ 眯眼", "表情+")
	src.emote("squint", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_smirk, "~ 坏笑", "表情+")
	src.emote("smirk", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_eyeroll, "~ 翻白眼", "表情+")
	src.emote("eyeroll", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_huff, "~ 哼气", "表情+")
	src.emote("huff", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_etwitch, "~ 耳朵抽动", "表情+")
	src.emote("etwitch", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_clear, "~ 清嗓子", "表情+")
	src.emote("clear", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bawk, "> 咯咯叫", "表情+")
	src.emote("bawk", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_caw, "> 嘎嘎", "表情+")
	src.emote("caw", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_caw2, "> 嘎嘎两声", "表情+")
	src.emote("caw2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_whistle, "~ 吹口哨", "表情+")
	src.emote("whistle", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_mggaow, "> 大声喵叫", "表情+")
	src.emote("mggaow", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_blep, "~ 吐舌", "表情+")
	src.emote("blep", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bork, "> 汪汪", "表情+")
	src.emote("bork", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_hoot, "> 咕咕", "表情+")
	src.emote("hoot", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_growl, "> 低吼", "表情+")
	src.emote("growl", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_woof, "> 汪", "表情+")
	src.emote("woof", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_baa, "> 咩", "表情+")
	src.emote("baa", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_baa2, "> 咩咩", "表情+")
	src.emote("baa2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_wurble, "> 咕噜叫", "表情+")
	src.emote("wurble", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_rattle, "> 咔咔响", "表情+")
	src.emote("rattle", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_cackle, "> 咯咯尖笑", "表情+")
	src.emote("cackle", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_warble, "> 颤鸣", "表情+")
	src.emote("warble", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_trills, "> 颤音", "表情+")
	src.emote("trills", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_rpurr, "> 迅猛龙呼噜", "表情+")
	src.emote("rpurr", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_purr, "> 呼噜", "表情+")
	src.emote("purr", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_moo, "> 哞", "表情+")
	src.emote("moo", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_honk1, "> 鸣笛", "表情+")
	src.emote("honk1", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_neigh, "> 嘶鸣", "表情+")
	src.emote("neigh", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_neigh2, "> 连声嘶鸣", "表情+")
	src.emote("neigh2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_snort, "> 喷鼻息", "表情+")
	src.emote("snort", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bray, "> 驴叫", "表情+")
	src.emote("bray", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bellow, "> 低沉吼叫", "表情+")
	src.emote("bellow", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_teshchirp, "> 特沙利啾鸣", "表情+")
	src.emote("teshchirp", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_teshsqueak, "> 特沙利吱叫", "表情+")
	src.emote("teshsqueak", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_teshtrill, "> 特沙利颤鸣", "表情+")
	src.emote("teshtrill", intentional = TRUE)

// code\modules\mob\living\brain\emote.dm
GAME_VERB_PROC(/mob/living/brain, emote_alarm, "< 警报 >", "表情")
	src.emote("alarm", intentional = TRUE)

GAME_VERB_PROC(/mob/living/brain, emote_alert, "< 警觉 >", "表情")
	src.emote("alert", intentional = TRUE)

GAME_VERB_PROC(/mob/living/brain, emote_flash, "< 闪光 >", "表情")
	src.emote("flash", intentional = TRUE)

GAME_VERB_PROC(/mob/living/brain, emote_notice, "< 注意 >", "表情")
	src.emote("notice", intentional = TRUE)

GAME_VERB_PROC(/mob/living/brain, emote_whistle_brain, "< 口哨 >", "表情")
	src.emote("whistle", intentional = TRUE)

// code\modules\mob\living\carbon\alien\emote.dm
GAME_VERB_PROC(/mob/living/carbon/alien, emote_gnarl, "< 龇牙低吼 >", "表情")
	src.emote("gnarl", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/alien, emote_hiss, "< 嘶嘶 >", "表情")
	src.emote("hiss", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/alien, emote_roar, "< 咆哮 >", "表情")
	src.emote("roar", intentional = TRUE)

// modular_skyrat\modules\emotes\code\synth_emotes.dm
GAME_VERB_PROC(/mob/living, emote_dwoop, "< 嘟呜 >", "表情")
	src.emote("dwoop", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_yes, "< 是 >", "表情")
	src.emote("yes", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_no, "< 否 >", "表情")
	src.emote("no", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_boop, "< 哔 >", "表情")
	src.emote("boop", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_buzz, "< 嗡嗡 >", "表情")
	src.emote("buzz", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_beep, "< 哔声 >", "表情")
	src.emote("beep", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_beep2, "< 尖锐哔声 >", "表情")
	src.emote("beep2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_buzz2, "< 嗡两声 >", "表情")
	src.emote("buzz2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_chime, "< 叮咚 >", "表情")
	src.emote("chime", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_honk, "< 鸣笛 >", "表情")
	src.emote("honk", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_ping, "< 叮 >", "表情")
	src.emote("ping", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sad, "< 悲伤 >", "表情")
	src.emote("sad", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_warn, "< 警告 >", "表情")
	src.emote("warn", intentional = TRUE)

// modular_skyrat\modules\emotes\code\additionalemotes\overlay_emote.dm
GAME_VERB_PROC(/mob/living, emote_sweatdrop, "| 汗滴 |", "表情+")
	src.emote("sweatdrop", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_exclaim, "| 惊叹 |", "表情+")
	src.emote("exclaim", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_question, "| 问号 |", "表情+")
	src.emote("question", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_realize, "| 领悟 |", "表情+")
	src.emote("realize", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_annoyed, "| 恼火 |", "表情+")
	src.emote("annoyed", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_glasses, "| 扶眼镜 |", "表情+")
	src.emote("glasses", intentional = TRUE)

// modular_skyrat\modules\emotes\code\additionalemotes\turf_emote.dm
GAME_VERB_PROC(/mob/living, emote_mark_turf, "| 标记地面 |", "表情+")
	src.emote("turf", intentional = TRUE)
