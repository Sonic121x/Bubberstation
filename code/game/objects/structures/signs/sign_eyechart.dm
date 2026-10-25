/obj/structure/sign/eyechart
	icon_state = "eyechart"
	name = "视力表"
	desc = "一张印有大小不一的彩色条块和字母的海报，\
		用于测试色觉与色盲——我是说，视觉敏锐度。"
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/eyechart, 32)

/obj/structure/sign/eyechart/examine(mob/user)
	. = ..()
	if(isobserver(user))
		return

	if(!user.can_read(src, READING_CHECK_LITERACY, silent = TRUE) || !user.has_language(/datum/language/common, UNDERSTOOD_LANGUAGE))
		if(!user.is_blind())
			. += "<hr>你盯着满墙的符号，试图弄明白它们的意思……"
			. += span_warning("……但你其实根本不知道它们是什么意思。")
		return

	if(user.is_blind())
		. += "<hr>你摸了摸海报。"
		. += span_notice("没错，摸起来像是……“E、P、D……”还好这张表有盲文！")
		return

	if(!user.can_read(src, READING_CHECK_LIGHT, silent = TRUE))
		. += "<hr>你眯起眼睛看图表。"
		. += span_warning("……但太暗了，什么都看不清。")
		return

	var/colorblind = HAS_TRAIT(user, TRAIT_COLORBLIND)
	var/obj/item/organ/eyes/eye = user.get_organ_slot(ORGAN_SLOT_EYES)
	// eye null checks here are for mobs without eyes.
	// humans missing eyes will be caught by the is_blind check above.
	var/eye_goodness = isnull(eye) ? 0 : eye.damage
	var/little_bad = isnull(eye) ? 20 : eye.low_threshold
	var/very_bad = isnull(eye) ? 30 : eye.high_threshold

	if(user.has_status_effect(/datum/status_effect/eye_blur))
		eye_goodness = max(eye_goodness, very_bad + 1)
	if(user.is_nearsighted_currently())
		eye_goodness = max(eye_goodness, little_bad + 1)
	eye_goodness += ((get_dist(user, src) - 2) * 5) // add a modifier based on distance, so closer = "better", further = "worse"

	. += "<hr>你出于怀旧，把视力表读了一遍。"
	if(eye_goodness <= 0)
		. += span_notice("“E、F、P……”没错，你能读到[colorblind ? "棕色——等等，不应该是红色吗？——" : "红色"]那一行。")
	else if(eye_goodness < little_bad)
		. += span_notice("“E、F、P……”你能看清大部分字母，但过了[colorblind ? "灰色——等等，不应该是绿色吗？——" : "绿色"]那一行后就有些吃力了。")
	else if(eye_goodness < very_bad)
		. += span_warning("“E、F、P……？”大字你能看清，小字则有点模糊。")
	else
		. += span_warning("“E、P、D……？”大字你都几乎看不清，更别说小字了。")
