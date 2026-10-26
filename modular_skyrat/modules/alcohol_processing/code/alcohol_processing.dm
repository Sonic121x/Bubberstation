#define BAC_STAGE_1_ACTIVE 0.01
#define BAC_STAGE_2_WARN 0.05
#define BAC_STAGE_2_ACTIVE 0.07
#define BAC_STAGE_3_WARN 0.11
#define BAC_STAGE_3_ACTIVE 0.13
#define BAC_STAGE_4_WARN 0.17
#define BAC_STAGE_4_ACTIVE 0.19
#define BAC_STAGE_5_WARN 0.23

/datum/reagent/consumable/ethanol
	metabolization_rate = 0.3 * REAGENTS_METABOLISM

/atom/movable/screen/alert/status_effect/drunk
	desc = "你喝下的酒精正在损害你的语言能力、\
		运动能力和思维判断。记得要表现得像个醉鬼。\
		可通过心情状态查看你当前的醉酒程度。"

/// Adds a moodlet entry based on if the mob currently has alcohol processing in their system.
/datum/mood/proc/get_alcohol_processing(mob/user)
	if(user.reagents.reagent_list.len)
		for(var/datum/reagent/consumable/ethanol/booze in user.reagents.reagent_list)
			return TRUE

/// Adds a moodlet entry based on the current blood alcohol content of the mob.
/datum/mood/proc/get_drunk_mood(mob/user)
	var/mob/living/target = user
	var/blood_alcohol_content = target.get_blood_alcohol_content()
	switch(blood_alcohol_content)
		if(BAC_STAGE_1_ACTIVE to BAC_STAGE_2_WARN)
			return span_info("喝了一杯，该放松一下了！")
		if(BAC_STAGE_2_WARN to BAC_STAGE_2_ACTIVE)
			return span_nicegreen("现在开始有点酒意了。")
		if(BAC_STAGE_2_ACTIVE to BAC_STAGE_3_WARN)
			return span_nicegreen("有点微醺，感觉不错！")
		if(BAC_STAGE_3_WARN to BAC_STAGE_3_ACTIVE)
			return span_nicegreen("那些酒开始上头了！")
		if(BAC_STAGE_3_ACTIVE to BAC_STAGE_4_WARN)
			return span_nicegreen("我记不清自己喝了多少杯，但感觉棒极了！")
		if(BAC_STAGE_4_WARN to BAC_STAGE_4_ACTIVE)
			return span_warning("我觉得我喝得太多了……也许该停下……喝点水……")
		if(BAC_STAGE_4_ACTIVE to BAC_STAGE_5_WARN)
			return span_bolddanger("我感觉不太妙……")
		if(BAC_STAGE_5_WARN to INFINITY)
			return span_bolddanger("附近有医生吗？我真的很难受……")

#undef BAC_STAGE_1_ACTIVE
#undef BAC_STAGE_2_WARN
#undef BAC_STAGE_2_ACTIVE
#undef BAC_STAGE_3_WARN
#undef BAC_STAGE_3_ACTIVE
#undef BAC_STAGE_4_WARN
#undef BAC_STAGE_4_ACTIVE
#undef BAC_STAGE_5_WARN
