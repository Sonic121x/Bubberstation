GLOBAL_LIST_INIT(skill_types, subtypesof(/datum/skill))

/datum/skill
	var/name = "技艺"
	var/title = "技艺达人"
	var/desc = "做事的艺术"
	///Dictionary of modifier type - list of modifiers (indexed by level). 7 entries in each list for all 7 skill levels.
	var/modifiers = list(SKILL_SPEED_MODIFIER = list(1, 1, 1, 1, 1, 1, 1)) //Dictionary of modifier type - list of modifiers (indexed by level). 7 entries in each list for all 7 skill levels.
	///List Path pointing to the skill item reward that will appear when a user finishes leveling up a skill
	var/skill_item_path
	///List associating different messages that appear on level up with different levels
	var/list/levelUpMessages = list()
	///List associating different messages that appear on level up with different levels
	var/list/levelDownMessages = list()

/datum/skill/proc/get_skill_modifier(modifier, level)
	return modifiers[modifier][level] //Levels range from 1 (None) to 7 (Legendary)
/**
 * new: sets up some lists.
 *
 *Can't happen in the datum's definition because these lists are not constant expressions
 */
/datum/skill/New()
	. = ..()
	levelUpMessages = list(span_nicegreen("[chinese_skyrat_primitive_skill_display(name)]到底是什么鬼？如果看到此消息，请告知管理员。"), //This first index shouldn't ever really be used
	span_nicegreen("我开始理解[chinese_skyrat_primitive_skill_display(name)]究竟是什么了！"),
	span_nicegreen("我的[chinese_skyrat_primitive_skill_display(name)]水平有所进步！"),
	span_nicegreen("我的[chinese_skyrat_primitive_skill_display(name)]水平进步很大！"),
	span_nicegreen("我觉得自己已经相当精通[chinese_skyrat_primitive_skill_display(name)]了！"),
	span_nicegreen("经过大量练习，我开始真正理解[chinese_skyrat_primitive_skill_display(name)]的精妙与深奥。现在，我称得上大师级[title]了。"),
	span_nicegreen("凭借非凡的决心与努力，我的[chinese_skyrat_primitive_skill_display(name)]能力已登峰造极。我终于能自称传奇[title]了！") )
	levelDownMessages = list(span_nicegreen("不知为何，我完全忘记了[chinese_skyrat_primitive_skill_display(name)]。如果看到此消息，请告知管理员。"),
	span_nicegreen("我开始忘记[chinese_skyrat_primitive_skill_display(name)]究竟是什么了。我需要更多练习……"),
	span_nicegreen("我的[chinese_skyrat_primitive_skill_display(name)]水平有些退步。我需要继续练习来提高水平……"),
	span_nicegreen("我的[chinese_skyrat_primitive_skill_display(name)]水平有些退步了……"),
	span_nicegreen("我的[chinese_skyrat_primitive_skill_display(name)]专长正在退化……"),
	span_nicegreen("我感觉自己对[chinese_skyrat_primitive_skill_display(name)]的精通程度正在下降。"),
	span_nicegreen("我感觉自己传奇般的[chinese_skyrat_primitive_skill_display(name)]技艺有所退步。我需要更加刻苦地训练，找回失去的技艺。") )

/**
 * level_gained: Gives skill levelup messages to the user
 *
 * Only fires if the xp gain isn't silent, so only really useful for messages.
 * Arguments:
 * * mind - The mind that you'll want to send messages
 * * new_level - The newly gained level. Can check the actual level to give different messages at different levels, see defines in skills.dm
 * * old_level - Similar to the above, but the level you had before levelling up.
 * * silent - Silences the announcement if TRUE
 */
/datum/skill/proc/level_gained(datum/mind/mind, new_level, old_level, silent)
	if(silent)
		return
	to_chat(mind.current, levelUpMessages[new_level]) //new_level will be a value from 1 to 6, so we get appropriate message from the 6-element levelUpMessages list
/**
 * level_lost: See level_gained, same idea but fires on skill level-down
 */
/datum/skill/proc/level_lost(datum/mind/mind, new_level, old_level, silent)
	if(silent)
		return
	to_chat(mind.current, levelDownMessages[old_level]) //old_level will be a value from 1 to 6, so we get appropriate message from the 6-element levelUpMessages list

/**
 * try_skill_reward: Checks to see if a user is eligable for a tangible reward for reaching a certain skill level
 *
 * Currently gives the user a special cloak when they reach a legendary level at any given skill
 * Arguments:
 * * mind - The mind that you'll want to send messages and rewards to
 * * new_level - The current level of the user. Used to check if it meets the requirements for a reward
 */
/datum/skill/proc/try_skill_reward(datum/mind/mind, new_level)
	if (new_level != SKILL_LEVEL_LEGENDARY)
		return
	if (!ispath(skill_item_path))
		to_chat(mind.current, span_nicegreen("我的传奇[chinese_skyrat_primitive_skill_display(name)]技艺令人赞叹，但专业[title]协会似乎没有任何象征地位的奖品来纪念我的成就。我应该把这件荒唐事报告给中央指挥部，也许他们能想办法。"))
		return
	if (LAZYFIND(mind.skills_rewarded, src.type))
		to_chat(mind.current, span_nicegreen("看来专业[title]协会不会再给我寄一份身份象征了。"))
		return
	podspawn(list(
		"target" = get_turf(mind.current),
		"style" = /datum/pod_style/advanced,
		"spawn" = skill_item_path,
		"delays" = list(POD_TRANSIT = 150, POD_FALLING = 4, POD_OPENING = 30, POD_LEAVING = 30)
	))
	to_chat(mind.current, span_nicegreen("我的传奇技艺引起了专业[title]协会的注意。他们似乎正寄来一件象征地位的奖品，以纪念我的成就。"))
	LAZYADD(mind.skills_rewarded, src.type)
