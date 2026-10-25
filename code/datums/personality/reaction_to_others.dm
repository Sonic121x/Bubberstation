/datum/personality/callous
	savefile_key = "callous"
	name = "冷酷"
	desc = "我不太在乎别人遭遇了什么。"
	pos_gameplay_desc = "不介意目睹死亡"
	neg_gameplay_desc = "不愿帮助他人"
	groups = list(PERSONALITY_GROUP_DEATH)

/datum/personality/compassionate
	savefile_key = "compassionate"
	name = "富有同情心"
	desc = "我喜欢向有需要的人伸出援手。"
	pos_gameplay_desc = "喜欢帮助他人"
	neg_gameplay_desc = "目睹死亡对你的情绪影响更大"
	groups = list(PERSONALITY_GROUP_DEATH, PERSONALITY_GROUP_MISANTHROPY)

/datum/personality/empathetic
	savefile_key = "empathetic"
	name = "感同身受" // according to google "empathic" means you understand other people, while "empathetic" means you feel what they feel
	desc = "别人的感受对我很重要。"
	pos_gameplay_desc = "看到别人开心会感到愉快"
	neg_gameplay_desc = "看到别人难过会感到不快"
	groups = list(PERSONALITY_GROUP_OTHERS)

/datum/personality/misanthropic
	savefile_key = "misanthropic"
	name = "厌世"
	desc = "我们根本就不该踏入星海。"
	pos_gameplay_desc = "看到别人难过会感到愉快"
	neg_gameplay_desc = "看到别人开心会感到不快"
	groups = list(PERSONALITY_GROUP_OTHERS, PERSONALITY_GROUP_MISANTHROPY)

/datum/personality/aloof
	savefile_key = "aloof"
	name = "疏离"
	desc = "为什么大家都这么喜欢动手动脚？我宁愿一个人待着。"
	neg_gameplay_desc = "不喜欢被抓住、触碰或拥抱"
	personality_trait = TRAIT_BADTOUCH

/datum/personality/aloof/apply_to_mob(mob/living/who)
	. = ..()
	RegisterSignals(who, list(COMSIG_LIVING_GET_PULLED, COMSIG_CARBON_HELP_ACT), PROC_REF(uncomfortable_touch))

/datum/personality/aloof/remove_from_mob(mob/living/who)
	. = ..()
	UnregisterSignal(who, list(COMSIG_LIVING_GET_PULLED, COMSIG_CARBON_HELP_ACT))

/// Causes a negative moodlet to our quirk holder on signal
/datum/personality/aloof/proc/uncomfortable_touch(mob/living/source)
	SIGNAL_HANDLER

	if(source.stat == DEAD)
		return

	new /obj/effect/temp_visual/annoyed(source.loc)
	if(source.mob_mood.sanity <= SANITY_NEUTRAL)
		source.add_mood_event("bad_touch", /datum/mood_event/very_bad_touch)
	else
		source.add_mood_event("bad_touch", /datum/mood_event/bad_touch)
