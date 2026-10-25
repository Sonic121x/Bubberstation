// Ritual spells which affect the station at large
/// How much threat we need to let these rituals happen on dynamic
#define MINIMUM_THREAT_FOR_RITUALS 98

/datum/spellbook_entry/summon/ghosts
	name = "召唤幽灵"
	desc = "让船员看到死人来吓他们一跳。\
		请注意，幽灵反复无常，偶尔还会记仇，\
		有些还会用它们微不足道的能力来烦扰你。"
	cost = 0

/datum/spellbook_entry/summon/ghosts/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	summon_ghosts(user)
	playsound(get_turf(user), 'sound/effects/ghost2.ogg', 50, TRUE)
	return ..()

/datum/spellbook_entry/summon/guns
	name = "召唤枪械"
	desc = "给一群正愁找不到借口杀你的疯子发枪，绝不可能出问题。\
		很有可能他们会先互相开枪。"

/datum/spellbook_entry/summon/guns/can_be_purchased()
	// Must be a high chaos round + Also must be config enabled
	return !CONFIG_GET(flag/no_summon_guns) // BUBBER EDIT CHANGE - Storyteller - ORIGINAL: return SSdynamic.current_tier.tier == DYNAMIC_TIER_HIGH && !CONFIG_GET(flag/no_summon_guns)

/datum/spellbook_entry/summon/guns/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	summon_guns(user, 10)
	playsound(get_turf(user), 'sound/effects/magic/castsummon.ogg', 50, TRUE)
	return ..()

/datum/spellbook_entry/summon/magic
	name = "召唤魔法"
	desc = "与船员分享魔法的奇妙，同时让他们明白\
		为什么不该放心把魔法交给他们。"

/datum/spellbook_entry/summon/magic/can_be_purchased()
	// Must be a high chaos round + Also must be config enabled
	return !CONFIG_GET(flag/no_summon_magic) // BUBBER EDIT CHANGE - Storyteller - ORIGINAL: return SSdynamic.current_tier.tier == DYNAMIC_TIER_HIGH && !CONFIG_GET(flag/no_summon_magic)

/datum/spellbook_entry/summon/magic/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	summon_magic(user, 10)
	playsound(get_turf(user), 'sound/effects/magic/castsummon.ogg', 50, TRUE)
	return ..()

/datum/spellbook_entry/summon/events
	name = "召唤事件"
	desc = "给墨菲定律一点推力，把所有事件替换成\
		会让所有人困惑迷茫的巫师专属事件。\
		多次施法会提高这些事件的发生频率。"
	cost = 2
	limit = 5 // Each purchase can intensify it.

/datum/spellbook_entry/summon/events/can_be_purchased()
	// Must be a high chaos round + Also must be config enabled
	return !CONFIG_GET(flag/no_summon_events) // BUBBER EDIT CHANGE - Storyteller - ORIGINAL: return SSdynamic.current_tier.tier == DYNAMIC_TIER_HIGH && !CONFIG_GET(flag/no_summon_events)

/datum/spellbook_entry/summon/events/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	summon_events(user)
	playsound(get_turf(user), 'sound/effects/magic/castsummon.ogg', 50, TRUE)
	return ..()

/datum/spellbook_entry/summon/curse_of_madness
	name = "疯狂诅咒"
	desc = "诅咒空间站，扭曲其中每个人的心智，造成持久的创伤。警告：如果不从安全距离施放，这个法术也可能影响你自己。"
	cost = 4

/datum/spellbook_entry/summon/curse_of_madness/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	var/message = tgui_input_text(user, "低语一个秘密的真相，把你的受害者逼向疯狂", "疯狂低语", max_length = MAX_MESSAGE_LEN)
	if(!message || QDELETED(user) || QDELETED(book) || !can_buy(user, book))
		return FALSE
	curse_of_madness(user, message)
	playsound(user, 'sound/effects/magic/mandswap.ogg', 50, TRUE)
	return ..()

/// A wizard ritual that allows the wizard to teach a specific spellbook enty to everyone on the station.
/// This includes item entries (which will be given to everyone) but disincludes other rituals like itself
/datum/spellbook_entry/summon/specific_spell
	name = "大规模巫师教学"
	desc = "向空间站上的每个人教授一个特定法术（或给予一个特定物品）。\
		此项目的花费会增加你所选法术的花费。别担心——你自己也会学会这个法术！"
	cost = 3 // cheapest is 4 cost, most expensive is 7 cost
	limit = 1

/datum/spellbook_entry/summon/specific_spell/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	var/list/spell_options = list()
	for(var/datum/spellbook_entry/entry as anything in book.entries)
		if(istype(entry, /datum/spellbook_entry/summon))
			continue
		if(!entry.can_be_purchased())
			continue

		spell_options[entry.name] = entry

	sortTim(spell_options, GLOBAL_PROC_REF(cmp_text_asc))
	var/chosen_spell_name = tgui_input_list(user, "选择一个法术（或物品）赐予所有人……", "巫师教学", spell_options)
	if(isnull(chosen_spell_name) || QDELETED(user) || QDELETED(book))
		return FALSE
	if(GLOB.mass_teaching)
		tgui_alert(user, "已经有人施放过[name]了！", "巫师教学", list("真可耻"))
		return FALSE

	var/datum/spellbook_entry/chosen_entry = spell_options[chosen_spell_name]
	if(cost + chosen_entry.cost > book.uses)
		tgui_alert(user, "你负担不起赐予所有人[chosen_spell_name]！(需要 [cost] 点数)", "巫师教学", list("真可耻"))
		return FALSE

	cost += chosen_entry.cost
	if(!can_buy(user, book))
		cost = initial(cost)
		return FALSE

	GLOB.mass_teaching = new(chosen_entry.type)
	GLOB.mass_teaching.equip_all_affected()

	var/item_entry = istype(chosen_entry, /datum/spellbook_entry/item)
	to_chat(user, span_hypnophrase("你已[item_entry ? "赐予所有人" : "向所有人传授"]了[chosen_spell_name]的[item_entry ? "力量" : "技艺"]！"))
	message_admins("[ADMIN_LOOKUPFLW(user)] 赐予了所有人 [item_entry ? "物品" : "法术"] \"[chosen_spell_name]\"！")
	user.log_message("赐予了所有人 [item_entry ? "物品" : "法术"] \"[chosen_spell_name]\"！", LOG_GAME)

	name = "[name]：[chosen_spell_name]"
	return ..()

/datum/spellbook_entry/summon/specific_spell/can_buy(mob/living/carbon/human/user, obj/item/spellbook/book)
	if(GLOB.mass_teaching)
		return FALSE
	return ..()

/datum/spellbook_entry/summon/specific_spell/can_be_purchased()
	/* BUBBER EDIT REMOVAL BEGIN - Storyteller
	if(SSdynamic.current_tier.tier != DYNAMIC_TIER_HIGH)
		return FALSE
	*/// BUBBER EDIT REMOVAL END - Storyteller
	if(GLOB.mass_teaching)
		return FALSE
	return ..()

#undef MINIMUM_THREAT_FOR_RITUALS
