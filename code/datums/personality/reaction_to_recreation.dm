/datum/personality/gambler
	savefile_key = "gambler"
	name = "赌徒"
	desc = "掷一把骰子永远值得！"
	pos_gameplay_desc = "喜欢赌博与纸牌游戏，赌输了也能欣然接受"

/datum/personality/slacking
	/// Areas which are considered "slacking off"
	var/list/slacker_areas = list(
		/area/station/commons/fitness,
		/area/station/commons/lounge,
		/area/station/service/bar,
		/area/station/service/cafeteria,
		/area/station/service/library,
		/area/station/service/minibar,
		/area/station/service/theater,
	)
	/// Mood event applied when in a slacking area
	var/mood_event_type

/datum/personality/slacking/apply_to_mob(mob/living/who)
	. = ..()
	who.apply_status_effect(/datum/status_effect/moodlet_in_area, mood_event_type, slacker_areas, CALLBACK(src, PROC_REF(is_slacking)))

/datum/personality/slacking/remove_from_mob(mob/living/who)
	. = ..()
	who.remove_status_effect(/datum/status_effect/moodlet_in_area, mood_event_type)

/// Callback for the moodlet_in_area status effect to determine if we're slacking off
/datum/personality/slacking/proc/is_slacking(mob/living/who, area/new_area)
	if(!istype(new_area, /area/station/service))
		return TRUE
	// Service workers don't slack in service
	if(who.mind?.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_SERVICE)
		return FALSE

	return TRUE

/datum/personality/slacking/lazy
	savefile_key = "lazy"
	name = "懒散"
	desc = "我今天实在不想工作。"
	pos_gameplay_desc = "待在酒吧或娱乐区域会感到开心"
	mood_event_type = /datum/mood_event/slacking_off_lazy
	groups = list(PERSONALITY_GROUP_RECREATION, PERSONALITY_GROUP_WORK, PERSONALITY_GROUP_ATHLETICS)

/datum/personality/slacking/diligent
	savefile_key = "diligent"
	name = "勤奋"
	desc = "这里还有事情等着人去做呢！"
	pos_gameplay_desc = "待在所属部门会感到开心"
	neg_gameplay_desc = "在酒吧或娱乐区域偷懒会感到不快"
	mood_event_type = /datum/mood_event/slacking_off_diligent
	groups = list(PERSONALITY_GROUP_RECREATION)

/datum/personality/slacking/diligent/apply_to_mob(mob/living/who)
	. = ..()
	RegisterSignals(who, list(COMSIG_MOB_MIND_TRANSFERRED_INTO, COMSIG_MOB_MIND_SET_ROLE), PROC_REF(update_effect))
	// Unfortunate side effect here in that IC job changes, IE HoP are missed
	who.apply_status_effect(/datum/status_effect/moodlet_in_area, /datum/mood_event/working_diligent, who.mind?.get_work_areas())

/datum/personality/slacking/diligent/remove_from_mob(mob/living/who)
	. = ..()
	UnregisterSignal(who, list(COMSIG_MOB_MIND_TRANSFERRED_INTO, COMSIG_MOB_MIND_SET_ROLE))
	who.remove_status_effect(/datum/status_effect/moodlet_in_area, /datum/mood_event/working_diligent)

/// Signal handler to update our status effect when our job changes
/datum/personality/slacking/diligent/proc/update_effect(mob/living/source, ...)
	SIGNAL_HANDLER

	source.remove_status_effect(/datum/status_effect/moodlet_in_area, /datum/mood_event/working_diligent)
	source.apply_status_effect(/datum/status_effect/moodlet_in_area, /datum/mood_event/working_diligent, source.mind.get_work_areas())

/datum/personality/industrious
	savefile_key = "industrious"
	name = "埋头苦干"
	desc = "每个人都得干活——不然大家就是在浪费时间。"
	neg_gameplay_desc = "不喜欢玩游戏"
	groups = list(PERSONALITY_GROUP_WORK)

/datum/personality/athletic
	savefile_key = "athletic"
	name = "热爱运动"
	desc = "不能整天坐着！得动起来。"
	pos_gameplay_desc = "喜欢锻炼"
	neg_gameplay_desc = "不喜欢偷懒"
	groups = list(PERSONALITY_GROUP_ATHLETICS)

/datum/personality/erudite
	savefile_key = "erudite"
	name = "博学"
	desc = "知识就是力量，尤其是在如此遥远的太空。"
	pos_gameplay_desc = "喜欢读书"
	groups = list(PERSONALITY_GROUP_READING)

/datum/personality/uneducated
	savefile_key = "uneducated"
	name = "不爱读书"
	desc = "我对书没什么兴趣——该知道的我都知道了。"
	neg_gameplay_desc = "不喜欢读书"
	groups = list(PERSONALITY_GROUP_READING)

/datum/personality/spiritual
	savefile_key = "spiritual"
	name = "虔诚"
	desc = "我相信有更高的力量存在。"
	pos_gameplay_desc = "喜欢教堂和牧师，并能进行特殊祈祷"
	neg_gameplay_desc = "不喜欢邪秽之物"
	personality_trait = TRAIT_SPIRITUAL
