GAME_VERB(/mob/living/carbon/human, climax_verb, "高潮", "IC")
	if(!has_status_effect(/datum/status_effect/climax_cooldown))
		if(tgui_alert(usr, "你确定要达到高潮吗？", "高潮", list("是", "否")) == "是")
			if(IS_UNCONSCIOUS(usr))
				to_chat(usr, span_warning("你现在无法达到高潮……"))
				return
			else
				climax(TRUE)
	else
		to_chat(src, span_warning("你现在无法达到高潮！"))

GAME_VERB(/mob/living, reflexes_verb, "切换触碰反射", "IC")
	if(!HAS_TRAIT_FROM(src, TRAIT_QUICKREFLEXES, REF(src)))
		ADD_TRAIT(src, TRAIT_QUICKREFLEXES, REF(src))
		to_chat(src, span_notice("[get_reflexes_gain_text()]"))
	else
		REMOVE_TRAIT(src, TRAIT_QUICKREFLEXES, REF(src))
		to_chat(src, span_notice("[get_reflexes_lose_text()]"))

/mob/living/proc/get_reflexes_gain_text()
	return "你现在不想被触碰。"

/mob/living/proc/get_reflexes_lose_text()
	return "你现在允许别人触碰自己。"

/mob/living/silicon/get_reflexes_gain_text()
	return "我们的系统将禁止友好触碰。"

/mob/living/silicon/get_reflexes_lose_text()
	return "我们的系统将允许友好触碰。"

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_erp_preferences))
		UNASSIGN_GAME_VERB(src, /mob/living/carbon/human, climax_verb)
	if(CONFIG_GET(flag/disable_lewd_items))
		UNASSIGN_GAME_VERB(src, /mob/living/carbon/human, safeword)

GAME_VERB_DESC(/mob/living/carbon/human, remove_lewd_items, "移除情趣物品", "移除你身上的所有情趣物品。", "OOC")
	// literally just another way to safeword
	safeword()

GAME_VERB_DESC(/mob/living/carbon/human, safeword, "OOC安全词", "移除你身上的所有情趣物品。", "OOC")
	SEND_SIGNAL(src, COMSIG_OOC_ESCAPE)
	log_message("[key_name(src)]使用了OOC安全词动作。", LOG_ATTACK)
	for(var/obj/item/equipped_item in get_equipped_items())
		if(!(equipped_item.type in GLOB.pref_checked_clothes))
			continue

		log_message("已从[key_name(src)]身上移除[equipped_item]。", LOG_ATTACK)
		dropItemToGround(equipped_item, TRUE)

	// Leashes are treated a smidge different than the rest of the clothing; and need their own handling here.
	var/leash_check = src?.GetComponent(/datum/component/leash/erp)
	if(leash_check)
		qdel(leash_check)

	// Vore Edit
	if(istype(loc, /obj/vore_belly))
		forceMove(get_turf(src))

	return TRUE

GAME_VERB(/mob/living/carbon/human, lick, "舔舐", "IC")
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_VIEW, /mob/living/carbon/human)
	if(!istype(target) || !(target in get_adjacent_humans()))
		return FALSE

	var/taste = target?.dna?.features["taste"]
	if(!taste)
		to_chat(src, span_warning("[target]似乎没有什么味道。"))
		return FALSE

	to_chat(src, span_notice("[target]尝起来像[taste]。"))
	to_chat(target, span_notice("[src]舔了舔你。"))

GAME_VERB(/mob/living/carbon/human, smell, "嗅闻", "IC")
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_VIEW, /mob/living/carbon/human)
	if(!istype(target) || !(target in get_adjacent_humans()))
		return FALSE

	var/smell = target?.dna?.features["smell"]
	if(!smell)
		to_chat(src, span_warning("[target]似乎没有什么气味。"))
		return FALSE

	to_chat(src, span_notice("[target]闻起来像[smell]。"))

/// Returns a list containing all of the humans adjacent to the user.
/mob/living/proc/get_adjacent_humans()
	var/list/nearby_humans = orange(1, src)
	for(var/mob/living/carbon/human/nearby_human as anything in nearby_humans)
		if(ishuman(nearby_human))
			continue

		nearby_humans -= nearby_human

	return nearby_humans

