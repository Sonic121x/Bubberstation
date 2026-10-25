///Mostly useless funny rite for forgiving someone, making them innocent once again.
/datum/religion_rites/forgive
	name = "宽恕"
	desc = "宽恕某人，使其不再被视为有罪。无论如何，这都是一份善意的举动！"
	invoke_msg = "你的罪孽已被赦免。"
	var/mob/living/who

/datum/religion_rites/forgive/perform_rite(mob/living/carbon/human/user, atom/religious_tool)
	if(!ishuman(user))
		return FALSE
	var/datum/brain_trauma/special/honorbound/honor = user.has_trauma_type(/datum/brain_trauma/special/honorbound)
	if(!honor)
		return FALSE
	if(!length(honor.guilty))
		to_chat(user, span_warning("[GLOB.deity] 心中没有需要宽恕的怨恨。"))
		return FALSE
	var/forgiven_choice = tgui_input_list(user, "选择一名 [GLOB.deity] 认为有罪者加以宽恕", "宽恕", honor.guilty)
	if(isnull(forgiven_choice))
		return FALSE
	who = forgiven_choice
	return ..()

/datum/religion_rites/forgive/invoke_effect(mob/living/carbon/human/user, atom/movable/religious_tool)
	..()
	if(in_range(user, religious_tool))
		return FALSE
	var/datum/brain_trauma/special/honorbound/honor = user.has_trauma_type(/datum/brain_trauma/special/honorbound)
	if(!honor) //edge case
		return FALSE
	honor.guilty -= who
	who = null
	playsound(get_turf(religious_tool), 'sound/effects/pray.ogg', 50, TRUE)
	return TRUE

/datum/religion_rites/summon_rules
	name = "召唤荣誉准则"
	desc = "在一张纸上写下荣誉准则与规章。"
	invoke_msg = "取出神圣文书！"
	///paper to turn into holy writ
	var/obj/item/paper/writ_target

/datum/religion_rites/summon_rules/perform_rite(mob/living/user, atom/religious_tool)
	for(var/obj/item/paper/could_writ in get_turf(religious_tool))
		if(istype(could_writ, /obj/item/paper/holy_writ))
			continue
		if(could_writ.get_total_length()) //blank paper pls
			continue
		writ_target = could_writ //PLEASE SIGN MY AUTOGRAPH
		return ..()
	to_chat(user, span_warning("你需要把空白纸张放在 [religious_tool] 上才能这么做！"))
	return FALSE

/datum/religion_rites/summon_rules/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/obj/item/paper/autograph = writ_target
	var/turf/tool_turf = get_turf(religious_tool)
	writ_target = null
	if(QDELETED(autograph) || !(tool_turf == autograph.loc)) //check if the paper is still there
		to_chat(user, span_warning("你的目标离开了祭坛！"))
		return FALSE
	autograph.visible_message(span_notice("文字神奇地在 [autograph] 上浮现！"))
	playsound(tool_turf, 'sound/effects/pray.ogg', 50, TRUE)
	new /obj/item/paper/holy_writ(tool_turf)
	qdel(autograph)
	return TRUE

/obj/item/paper/holy_writ
	icon = 'icons/obj/scrolls.dmi'
	icon_state = "honorscroll"
	slot_flags = null
	show_written_words = FALSE

//info set in here because we need GLOB.deity
/obj/item/paper/holy_writ/Initialize(mapload)
	add_filter("holy_outline", 9, list("type" = "outline", "color" = "#fdff6c"))
	name = "[GLOB.deity] 的荣誉准则"
	default_raw_text = {"[GLOB.deity] 的荣誉准则：
	<br>
	1、不得攻击尚未准备好的人！<br>
	未做好战斗准备者不应被击倒。若要将此世之恶彻底征服，
	它们必须在公平的战斗中败北。
	较弱的生物可享有“未准备好”的宽容，请谨记这一点。
	<br>
	<br>
	2、不得攻击正义之人！<br>
	为正义与善良而战者不可伤害。安保部不可腐蚀，必须受到尊重。
	治疗者大多不可腐蚀；如果你确信医疗部已堕入邪恶之灾，
	请使用邪恶宣告。
	<br>
	<br>
	3、不得攻击无辜者！<br>
	先发制人毫无荣誉可言，除非对方确是邪恶的害兽。
	有罪者会先对你动手，或者你可以宣告其邪恶。
	无智的弱小生物既不算无辜，也不算邪恶。它们由激情与本能驱动，
	若其激情与更美好世界的追求相悖，便可将其处置。
	<br>
	<br>
	4、不得使用亵渎魔法！<br>
	你不是术士，而是荣誉的战士。没有什么比女巫、术士与死灵法师所用的邪恶魔法更具腐蚀性。此规则亦有例外。<br>
	你可以使用神圣魔法；若你招募到默剧演员，
	其亦可使用神圣默剧。恢复系魔法也被允许，
	因为这一流派专注于光明与治愈此世。
	"}
	return ..()

/// how much favor is gained when someone is deaconized
#define DEACONIZE_FAVOR_GAIN 300

/**
 * Crusader deaconize
 * Along with making the person holy & being an infinite-use type, it comes with the cost
 * of enforcing an honorbound code onto convertees.
 * Earns the church favor per conversion, but convincing others to uphold the code is not easy.
 * Geneless species are not welcome for reasons
 * (The actual reason is because the honorbound trauma used to be a mutation which they couldn't get,
 * maybe it's time we let them join? idk)
 */
/datum/religion_rites/deaconize/crusader
	name = "加入十字军"
	desc = "将某人转化为你的教派成员。对方必须自愿，因此第一次施仪只会邀请其加入。\
	他们将像你一样受荣誉准则约束，而你也会获得大量恩宠！"
	ritual_length = 30 SECONDS
	ritual_invocations = list(
		"我们需要一场善良而荣誉的讨伐邪恶之战。",
		"我们需要正义者……",
		"……坚定不移者……",
		"……以及公正者。",
		"罪人必须被噤声……",
	)
	invoke_msg = "……并且必须维护准则！"
	rite_flags = RITE_ALLOW_MULTIPLE_PERFORMS

/datum/religion_rites/deaconize/crusader/post_invoke_effects(mob/living/user, atom/religious_tool)
	. = ..()
	GLOB.religious_sect.adjust_favor(DEACONIZE_FAVOR_GAIN, user)

/datum/religion_rites/deaconize/crusader/is_valid_for_deacon(mob/living/carbon/human/possible_deacon, mob/living/user)
	if((TRAIT_GENELESS in possible_deacon.dna.species.inherent_traits) && !issynthetic(possible_deacon)) // BUBBER EDIT CHANGE: Let synths join crusades. Original: if(TRAIT_GENELESS in possible_deacon.dna.species.inherent_traits)
		to_chat(user, span_warning("这个种族令 [GLOB.deity] 厌恶！他们永远不被允许加入十字军！"))
		return FALSE
	return ..()

/datum/religion_rites/deaconize/crusader/invite_deacon(mob/living/carbon/human/invited)
	var/ask = tgui_alert(invited, "加入 [GLOB.deity] 吗？你将被荣誉准则约束。", "邀请", list("是", "否"), 60 SECONDS)
	if(ask != "是")
		return
	potential_deacon = invited

#undef DEACONIZE_FAVOR_GAIN
