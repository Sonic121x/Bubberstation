/datum/mood_event/drunk
	mood_change = 3
	description = "喝上一两杯，感觉一切都好多了。"
	/// The blush overlay to display when the owner is drunk
	var/datum/bodypart_overlay/simple/emote/blush_overlay

/datum/mood_event/drunk/add_effects(drunkness)
	update_change(drunkness)
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/human_owner = owner
	blush_overlay = human_owner.give_emote_overlay(/datum/bodypart_overlay/simple/emote/blush)

/// Updates the description and value of the moodlet according to the passed drunkness value
/// (Does not add to or remove from the current level - it will sets it directly to the new value)
/datum/mood_event/drunk/proc/update_change(drunkness = 0)
	var/old_mood = mood_change
	switch(drunkness)
		if(0 to 30)
			mood_change = 3
			description = "喝上一两杯，感觉一切都好多了。"
		if(30 to 45)
			mood_change = 4
			description = "是不是越来越热了，还是只有我这么觉得？得再喝一杯凉快一下。"
		if(45 to 60)
			mood_change = 5
			description = "谁一直在晃地板？我要找他们谈谈……等我喝完这一杯。"
		if(60 to 90)
			mood_change = 6
			description = "我才没——醉，你才醉了！其实……我还得再来一杯！"
		if(90 to INFINITY)
			mood_change = 3 // crash out
			description = "你是我最——好的朋、朋友……咱俩一起闯天下，伙计。再来一杯。"
	if(HAS_PERSONALITY(owner, /datum/personality/teetotal))
		mood_change *= -1.5
		description = "我不喜欢喝酒……这感觉糟透了。"
	if(HAS_PERSONALITY(owner, /datum/personality/bibulous))
		mood_change *= 1.5
	if(old_mood != mood_change)
		owner.mob_mood.update_mood()

/datum/mood_event/drunk/remove_effects()
	QDEL_NULL(blush_overlay)

/datum/mood_event/drunk_after
	mood_change = 2
	description = "酒劲也许过去了，但我仍然感觉很好。"
	timeout = 5 MINUTES

/datum/mood_event/wrong_brandy
	description = "我讨厌那种饮料。"
	mood_change = -2
	timeout = 6 MINUTES

/datum/mood_event/quality_revolting
	description = "那是我喝过最难喝的东西。"
	mood_change = -8
	timeout = 7 MINUTES

/datum/mood_event/quality_nice
	description = "那杯饮料还挺不错。"
	mood_change = 2
	timeout = 7 MINUTES

/datum/mood_event/quality_good
	description = "那杯饮料相当不错。"
	mood_change = 4
	timeout = 7 MINUTES

/datum/mood_event/quality_verygood
	description = "那杯饮料真棒！"
	mood_change = 6
	timeout = 7 MINUTES

/datum/mood_event/quality_fantastic
	description = "那杯饮料棒极了！"
	mood_change = 8
	timeout = 7 MINUTES

/datum/mood_event/amazingtaste
	description = "味道绝了！"
	mood_change = 50
	timeout = 10 MINUTES

/datum/mood_event/wellcheers
	description = "这罐威尔奇真好喝！咸葡萄风味让人精神一振。"
	mood_change = 3
	timeout = 7 MINUTES

/datum/mood_event/sweetcoffee
	description = "咖啡苦中带甜的味道还不错。"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/sweettea
	description = "让烦恼像茶里的糖一样慢慢融化吧。"
	mood_change = 4
	timeout = 2.5 MINUTES
