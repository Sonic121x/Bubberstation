/datum/personality/apathetic
	savefile_key = "apathetic"
	name = "淡漠"
	desc = "我没什么在乎的。好事、坏事，更别提那些丑事，都无所谓。"
	neut_gameplay_desc = "所有情绪事件对你的影响减弱"
	groups = list(PERSONALITY_GROUP_MOOD_POWER)

/datum/personality/apathetic/apply_to_mob(mob/living/who)
	. = ..()
	who.mob_mood?.mood_modifier -= 0.2

/datum/personality/apathetic/remove_from_mob(mob/living/who)
	. = ..()
	who.mob_mood?.mood_modifier += 0.2

/datum/personality/sensitive
	savefile_key = "sensitive"
	name = "敏感"
	desc = "我很容易受到周围环境的影响。"
	neut_gameplay_desc = "所有情绪事件对你的影响增强"
	groups = list(PERSONALITY_GROUP_MOOD_POWER)

/datum/personality/sensitive/apply_to_mob(mob/living/who)
	. = ..()
	who.mob_mood?.mood_modifier += 0.2

/datum/personality/sensitive/remove_from_mob(mob/living/who)
	. = ..()
	who.mob_mood?.mood_modifier -= 0.2

/datum/personality/resilient
	savefile_key = "resilient"
	name = "坚韧"
	desc = "没什么大不了的。我扛得住！"
	pos_gameplay_desc = "负面情绪消退得更快"
	groups = list(PERSONALITY_GROUP_MOOD_LENGTH)

/datum/personality/resilient/apply_to_mob(mob/living/who)
	. = ..()
	who.mob_mood?.negative_moodlet_length_modifier -= 0.2

/datum/personality/resilient/remove_from_mob(mob/living/who)
	. = ..()
	who.mob_mood?.negative_moodlet_length_modifier += 0.2

/datum/personality/brooding
	savefile_key = "brooding"
	name = "耿耿于怀"
	desc = "什么事都能影响我，让我忍不住反复回想。"
	neg_gameplay_desc = "负面情绪持续更久"
	groups = list(PERSONALITY_GROUP_MOOD_LENGTH)

/datum/personality/brooding/apply_to_mob(mob/living/who)
	. = ..()
	who.mob_mood?.negative_moodlet_length_modifier += 0.2

/datum/personality/brooding/remove_from_mob(mob/living/who)
	. = ..()
	who.mob_mood?.negative_moodlet_length_modifier -= 0.2

/datum/personality/hopeful
	savefile_key = "hopeful"
	name = "满怀希望"
	desc = "我相信一切总会好起来的。"
	pos_gameplay_desc = "正面情绪持续更久"
	groups = list(PERSONALITY_GROUP_HOPE)

/datum/personality/hopeful/apply_to_mob(mob/living/who)
	. = ..()
	who.mob_mood?.positive_moodlet_length_modifier += 0.2

/datum/personality/hopeful/remove_from_mob(mob/living/who)
	. = ..()
	who.mob_mood?.positive_moodlet_length_modifier -= 0.2

/datum/personality/pessimistic
	savefile_key = "pessimistic"
	name = "悲观"
	desc = "我觉得最好的日子已经过去了。"
	neg_gameplay_desc = "正面情绪持续更短"
	groups = list(PERSONALITY_GROUP_HOPE)

/datum/personality/pessimistic/apply_to_mob(mob/living/who)
	. = ..()
	who.mob_mood?.positive_moodlet_length_modifier -= 0.2

/datum/personality/pessimistic/remove_from_mob(mob/living/who)
	. = ..()
	who.mob_mood?.positive_moodlet_length_modifier += 0.2

/datum/personality/whimsical
	savefile_key = "whimsical"
	name = "爱玩闹"
	desc = "这座空间站有时太严肃了，轻松一点嘛！"
	pos_gameplay_desc = "喜欢看似无意义却有趣的事，也不介意小丑式恶作剧"

/datum/personality/snob
	savefile_key = "snob"
	name = "挑剔"
	desc = "我只接受这座空间站提供最好的东西——差一点都不行！"
	neut_gameplay_desc = "房间品质会影响你的心情"
	personality_trait = TRAIT_SNOB
