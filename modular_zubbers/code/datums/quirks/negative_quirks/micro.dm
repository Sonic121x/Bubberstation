
/datum/quirk/micro
	name = "Small"
	desc = "不知为何，你比大多数人都小一些。你的体型比别人小百分之二十，\
	代价是很容易被压扁！"
	icon = FA_ICON_MINIMIZE
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN|QUIRK_CHANGES_APPEARANCE
	value = -4
	gain_text = span_danger("你感觉自己变小了些。")
	lose_text = span_notice("你感觉自己变大了些。")
	medical_record_text = "患者身材矮小。"
	hardcore_value = 0
	var/squash_damage_ = 8
	var/squash_chance_ = 25
	var/size_reduced = 0.8

/datum/quirk/micro/smaller
	name = "Microsized"
	desc = "你的体型比别人小百分之三十……\
	代价是很容易被压扁，而且会很痛！！"
	icon = FA_ICON_LOCUST
	squash_damage_ = 15
	squash_chance_ = 40
	size_reduced = 0.7
	value = -5

/datum/quirk/micro/smallest
	name = "Microscopic"
	desc = "你的体型比别人小百分之四十……别人得眯起眼睛才能看清你！\
	而且你总会像虫子一样被不小心踩扁！"
	icon = FA_ICON_BACTERIUM
	squash_damage_ = 30
	squash_chance_ = 50
	size_reduced = 0.6
	value = -6

/datum/quirk/micro/post_add()
	var/mob/living/carbon/living_as_carbon = quirk_holder
	living_as_carbon.update_transform(size_reduced / quirk_holder.client?.prefs?.read_preference(/datum/preference/numeric/body_size))
	living_as_carbon.AddComponent( \
		/datum/component/squashable, \
		squash_chance = squash_chance_, \
		squash_damage = squash_damage_, \
		squash_flags = SQUASHED_ALWAYS_IF_DEAD|SQUASHED_DONT_SQUASH_IN_CONTENTS|SQUASHED_SHOULD_BE_DOWN, \
	)

/datum/quirk/micro/remove()
	qdel(quirk_holder.GetComponent(/datum/component/squashable))



