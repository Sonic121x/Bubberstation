// Hey listen! Imgur doesn't actually work, it's been tested.

/datum/preference/text/headshot
	category = PREFERENCE_CATEGORY_CHARACTER_BASICS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "headshot"
	maximum_value_length = MAX_MESSAGE_LEN
	/// Assoc list of ckeys and their link, used to cut down on chat spam
	var/list/stored_link = list()
	var/static/link_regex = regex(@"i\.gyazo.com|.\.l3n\.co|static\.f-list\.net/images/|images2\.imgbox\.com|thumbs2\.imgbox\.com|files\.catbox\.moe") // Catbox, Imgbox, Gyazo, Lensdump, or F-List
	var/static/list/valid_extensions = list("jpg", "png", "jpeg") // Regex works fine, if you know how it works

/datum/preference/text/headshot/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["headshot"] = value

/datum/preference/text/headshot/is_valid(value)
	if(!length(value)) // Just to get blank ones out of the way
		return TRUE

	var/find_index = findtext(value, "https://")
	if(find_index != 1)
		to_chat(usr, span_warning("你的链接必须使用 https！"))
		return

	if(!findtext(value, "."))
		to_chat(usr, span_warning("链接无效！"))
		return
	var/list/value_split = splittext(value, ".")

	// extension will always be the last entry
	var/extension = value_split[length(value_split)]
	if(!(extension in valid_extensions))
		to_chat(usr, span_warning("图片扩展名必须为以下之一：“[english_list(valid_extensions)]”"))
		return

	find_index = findtext(value, link_regex)
	if(find_index != 9)
		to_chat(usr, span_warning("图片必须托管在以下站点之一：“Catbox、Imgbox、Gyazo、Lensdump、F-List”"))
		return

	apply_headshot(value)
	return TRUE

/datum/preference/text/headshot/proc/apply_headshot(value)
	if(stored_link[usr.ckey] != value)
		to_chat(usr, span_notice("请使用相对适合工作场合的头肩部图片，以维持沉浸感。可以把它当作你证件上的头像照。最后，[span_bold("切勿使用真人照片，也不要使用任何不够严肃的图片。")]"))
		to_chat(usr, span_notice("如果照片在游戏中无法正常显示，请确认它是能在浏览器中正常打开的直链图片。"))
		to_chat(usr, span_notice("请注意，照片会被缩小至 250x250 像素，因此照片越接近正方形，显示效果越好。"))
		log_game("[usr] 已将头像图片设置为“[value]”。")
	stored_link[usr.ckey] = value
	return TRUE
